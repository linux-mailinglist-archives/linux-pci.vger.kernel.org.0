Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9E4251A7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhJGLGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 07:06:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:46080 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232732AbhJGLGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 07:06:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="213170040"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="213170040"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 04:04:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="624205158"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Oct 2021 04:03:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Oct 2021 14:03:50 +0300
Date:   Thu, 7 Oct 2021 14:03:50 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Convert to
 device_create_managed_software_node()
Message-ID: <YV7UFoAXb5MrkaFg@kuha.fi.intel.com>
References: <20211006112643.77684-2-heikki.krogerus@linux.intel.com>
 <20211006184754.GA1171384@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006184754.GA1171384@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 01:47:54PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 06, 2021 at 02:26:41PM +0300, Heikki Krogerus wrote:
> > In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
> > instead of device_add_properties() to set the "dma-can-stall"
> > property.
> > 
> > This is the last user of device_add_properties() that relied on
> > device_del() to take care of also calling device_remove_properties().
> > After this change we can finally get rid of that
> > device_remove_properties() call in device_del().
> > 
> > After that device_remove_properties() call has been removed from
> > device_del(), the software nodes that hold the additional device
> > properties become reusable and shareable as there is no longer a
> > default assumption that those nodes are lifetime bound the first
> > device they are associated with.
> 
> This does not help me determine whether this patch is safe.
> device_create_managed_software_node() sets swnode->managed = true,
> but device_add_properties() did not.  I still don't know what the
> effect of that is.

OK. So how about this:

        PCI: Convert to device_create_managed_software_node()

        In quirk_huawei_pcie_sva(), device_add_properties() is used to
        inject additional device properties, but there is no
        device_remove_properties() call anywhere to remove those
        properties. The assumption is most likely that the device is
        never removed, and the properties therefore do not also never
        need to be removed.

        Even though it is unlikely that the device is ever removed in
        this case, it is safer to make sure that the properties are
        also removed if the device ever does get unregistered.

        To achieve this, instead of adding a separate quirk for the
        case of device removal where device_remove_properties() is
        called, using device_create_managed_software_node() instead of
        device_add_properties(). Both functions create a software node
        (a type of fwnode) that holds the device properties, which is
        then assigned to the device very much the same way.

        The difference between the two functions is, that
        device_create_managed_software_node() guarantees that the
        software node (together with the properties) is removed when
        the device is removed. The function device_add_property() does
        _not_ guarantee that, so the properties added with it should
        always be removed with device_remove_properties().

        SoB...

thanks,

-- 
heikki
