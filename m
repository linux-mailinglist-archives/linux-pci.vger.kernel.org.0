Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8441A6DC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 07:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhI1FCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 01:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhI1FCw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 01:02:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D86561157;
        Tue, 28 Sep 2021 05:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632805273;
        bh=zsQk0tlFBx4r/np/dpdue6p/eJJfxXfQU+IrfF5+Bhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmy2YODD81AfnYlUzCWGvxSes7alPN10gAmsR7FPADYzq1nE85XE5OaS6xPRTIeZJ
         snqyTguLpEYvV67F+ah2/9xAU3ulKQR/jWBL/ffXkUfRX71RkHFkPTAXlutaE+padl
         LzStgM8WEz4HgDCy5v18gGr70esGI7awFcq2wLV0=
Date:   Tue, 28 Sep 2021 07:01:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, bhelgaas@google.com,
        andy.shevchenko@gmail.com, mgross@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/5] MFD: intel_pmt: Support non-PMT capabilities
Message-ID: <YVKhlWSb3pdMLCEk@kroah.com>
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
 <20210922213007.2738388-3-david.e.box@linux.intel.com>
 <YVIBI6TQrD/rehli@kroah.com>
 <d540894d3d8c05722bd924c21bd9dd9c2b9def53.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d540894d3d8c05722bd924c21bd9dd9c2b9def53.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 27, 2021 at 11:40:37AM -0700, David E. Box wrote:
> On Mon, 2021-09-27 at 19:36 +0200, Greg KH wrote:
> > On Wed, Sep 22, 2021 at 02:30:04PM -0700, David E. Box wrote:
> > > Intel Platform Monitoring Technology (PMT) support is indicated by presence
> > > of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> > > structures may also be used by Intel to indicate support for other
> > > capabilities unrelated to PMT.  OOBMSM is a device that can have both PMT
> > > and non-PMT capabilities. In order to support these capabilities it is
> > > necessary to modify the intel_pmt driver to handle the creation of platform
> > > devices more generically.
> > 
> > I said this on your other driver submission, but why are you turning a
> > PCIe device into a set of platform devices and craming it into the MFD
> > subsystem?
> > 
> > PCIe devices are NOT platform devices.
> 
> But they *are* used to create platform devices when the PCIe device is multi-functional, which is
> what intel_pmt is.

That is an abuse of platform devices, as that is not what they are for.

> > Why not use the auxiliary bus for this thing if you have individual
> > drivers that need to "bind" to the different attributes that this single
> > PCIe device is exporting.
> 
> It wasn't clear in the beginning how this would evolve. MFD made sense for the PMT (platform
> monitoring technology) driver. PMT has 3 related but individually enumerable devices on the same IP,
> like lpss. But the same IP is now being used for other features too like SDSi. We could work on
> converting this to the auxiliary bus and then covert the cell drivers.

Please do so.

> > Or why not just fix the hardware to report individual PCIe devices, like
> > a sane system would do?
> 
> We have some systems with 1000+ PCIe devices. Each PCIe device adds cost to HW. So increasingly
> VSEC/DVSEC is used to expose features which are handled by the same micro-controller in the HW.

A PCIe device is a virtual thing, what HW cost do they have?

Anyway, a platform device should NOT ever be a child of a PCI device,
that is not ok and should be fixed here please.

A platform device is just that, something that the platform provides on
a non-discoverable bus.  A PCIe device is NOT that type of device at
all and never has been.

thanks,

greg k-h
