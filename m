Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27F46DC0C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhLHTZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbhLHTZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:25:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F0C061746;
        Wed,  8 Dec 2021 11:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A586B82275;
        Wed,  8 Dec 2021 19:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BBAC341C8;
        Wed,  8 Dec 2021 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638991291;
        bh=flAko3jtQKmtx9X5Z+Aj4PgqNh/wtnJ0lsVhb+dcL30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nishq4Yzs1p2DF8s+QCR43LiGoin7Ct7ZAX8cuwZLtFz0UIWU29andkeh3c4Hn0F2
         yCcva0gwWef/zf52MUClmF3LF9n08yRH6Rf6ZmO8CheFZeGLvZMzZKFKzVu8p3Ym3J
         X4WKUdWPjcI3OMLW9j+Yamz+tZ8t6mhMCnB6nfsw=
Date:   Wed, 8 Dec 2021 20:21:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
Message-ID: <YbEFuN7fwdiNI8vW@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-4-david.e.box@linux.intel.com>
 <YbDbql39x7Kw6iAC@kroah.com>
 <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
 <YbD1NsYHbU8FvtTN@kroah.com>
 <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 11:09:48AM -0800, David E. Box wrote:
> On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
> > On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
> > > On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> > > > On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
> > > > > +static struct pci_driver intel_vsec_pci_driver = {
> > > > > +       .name = "intel_vsec",
> > > > > +       .id_table = intel_vsec_pci_ids,
> > > > > +       .probe = intel_vsec_pci_probe,
> > > > > +};
> > > > 
> > > > So when the PCI device is removed from the system you leak resources and
> > > > have dangling devices?
> > > 
> > > No.
> > > 
> > > > 
> > > > Why no PCI remove driver callback?
> > > 
> > > After probe all resources are device managed. There's nothing to explicitly clean up. When the
> > > PCI
> > > device is removed, all aux devices are automatically removed. This is the case for the SDSi
> > > driver
> > > as well.
> > 
> > Where is the "automatic cleanup" happening?  As this pci driver is bound
> > to the PCI device, when the device is removed, what is called in this
> > driver to remove the resources allocated in the probe callback?
> > 
> > confused,
> 
> devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux, auxdev)

Wow that is opaque.  Why not do it on remove instead?

> intel_vsec_remove_aux() gets called when the PCI device is removed. It calls auxiliary_device_unit()
> which in turn calls the auxdev release() function that cleans up resources.

Does this happen when the device is removed, or when the binding of
driver <-> device is removed?

> When the auxdev is removed, all resources that were dev_m added by the SDSi driver are released too
> which is why it has no remove() either. I'll add the tests that check this.

Please do so and document it well, as that is an odd "pattern".

thanks,

greg k-h
