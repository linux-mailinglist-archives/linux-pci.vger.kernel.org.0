Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A566425B93
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhJGThc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 15:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233251AbhJGThc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 15:37:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 018F8610C8;
        Thu,  7 Oct 2021 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633635338;
        bh=Vur98vXq4PsLHaokShnlstz73Uon8pgr3uFm9W6mdLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oSNYEZ8NShvsEx3Mq5ZiKFtja3kD214N9jxV+wO9zAAbe5D2jors8Vghsgr1uA4eo
         JIyf9jJYgsmNcSCyfMoBmNgVcxTWHm3M8cp7QMKUpTdk7vxNOwE66DMomv1RSuqyR+
         /NitRl6ukFu6IbmPyHXUBg1YTRTEpno0qJt6tfNTEXgiTi8K9dF8LHxRQxYTqbKZWo
         kdRPpMo7GuKubR1aUvFhuEnFO9FayfMsVa3QQuIiMCfGW9h4wWcifa1v05ev3PUZYn
         mMg9FwGDmoBF4uVvvbMhAxO2qA5P7Ro4Uv/daRPbnAm+g09MjBroRA0tawczURo2Rs
         KAQ6fP03SL/CA==
Date:   Thu, 7 Oct 2021 14:35:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Convert to
 device_create_managed_software_node()
Message-ID: <20211007193536.GA1260015@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV7UFoAXb5MrkaFg@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 07, 2021 at 02:03:50PM +0300, Heikki Krogerus wrote:
> On Wed, Oct 06, 2021 at 01:47:54PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 06, 2021 at 02:26:41PM +0300, Heikki Krogerus wrote:
> > > In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
> > > instead of device_add_properties() to set the "dma-can-stall"
> > > property.
> > > 
> > > This is the last user of device_add_properties() that relied on
> > > device_del() to take care of also calling device_remove_properties().
> > > After this change we can finally get rid of that
> > > device_remove_properties() call in device_del().
> > > 
> > > After that device_remove_properties() call has been removed from
> > > device_del(), the software nodes that hold the additional device
> > > properties become reusable and shareable as there is no longer a
> > > default assumption that those nodes are lifetime bound the first
> > > device they are associated with.
> > 
> > This does not help me determine whether this patch is safe.
> > device_create_managed_software_node() sets swnode->managed = true,
> > but device_add_properties() did not.  I still don't know what the
> > effect of that is.
> 
> OK. So how about this:
> 
>         PCI: Convert to device_create_managed_software_node()
> 
>         In quirk_huawei_pcie_sva(), device_add_properties() is used to
>         inject additional device properties, but there is no
>         device_remove_properties() call anywhere to remove those
>         properties. The assumption is most likely that the device is
>         never removed, and the properties therefore do not also never
>         need to be removed.
> 
>         Even though it is unlikely that the device is ever removed in
>         this case, it is safer to make sure that the properties are
>         also removed if the device ever does get unregistered.
> 
>         To achieve this, instead of adding a separate quirk for the
>         case of device removal where device_remove_properties() is
>         called, using device_create_managed_software_node() instead of
>         device_add_properties(). Both functions create a software node
>         (a type of fwnode) that holds the device properties, which is
>         then assigned to the device very much the same way.
> 
>         The difference between the two functions is, that
>         device_create_managed_software_node() guarantees that the
>         software node (together with the properties) is removed when
>         the device is removed. The function device_add_property() does
>         _not_ guarantee that, so the properties added with it should
>         always be removed with device_remove_properties().

That makes sense to me, thanks.  And it sounds like it *does* resolve
a lifetime issue, namely, a caller of device_add_properties(dev) is
required to arrange for device_remove_properties(dev) to be called
when "dev" is removed.

The fact that in this particular case, "dev" is a non-removable AMBA
device doesn't mean there was no issue; it only means we should have
had a matching device_remove_properties() call somewhere or at the
very least a comment about why it wasn't needed.  Otherwise people
copy the code to somewhere where it *does* matter.

But removing device_add_properties() altogether will mean this is all
moot anyway.

You can add my:

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Bjorn
