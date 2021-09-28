Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4B41AB89
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhI1JMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 05:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239694AbhI1JMB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 05:12:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D77460F44;
        Tue, 28 Sep 2021 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632820222;
        bh=nNUQ2Cbdi2wqZSMi5rvMuU/y79v+XzSHTSCiCh87I6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hY8T7xysw2mQ+OnEHAdCVU7YyS+exjH7oqrCv8gxeBVL3jpcKKaFuhDxLwJBXk+NB
         gkuPg8isIOQ/Zf2fyuSxyrCoqT/OoybjwdqXgBRUhYMD9pEEJuVypu1d+vYMp/MOp/
         mKbIun/KpaLJN3Z2tZE6Pyv8WZjxWumR5lwTHB8c=
Date:   Tue, 28 Sep 2021 11:10:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, bhelgaas@google.com,
        andy.shevchenko@gmail.com, mgross@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/5] MFD: intel_pmt: Support non-PMT capabilities
Message-ID: <YVLb/GrePEKNDdtb@kroah.com>
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
 <20210922213007.2738388-3-david.e.box@linux.intel.com>
 <YVIBI6TQrD/rehli@kroah.com>
 <d540894d3d8c05722bd924c21bd9dd9c2b9def53.camel@linux.intel.com>
 <YVLKRSQx01vB4N77@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVLKRSQx01vB4N77@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 28, 2021 at 08:54:45AM +0100, Lee Jones wrote:
> On Mon, 27 Sep 2021, David E. Box wrote:
> 
> > On Mon, 2021-09-27 at 19:36 +0200, Greg KH wrote:
> > > On Wed, Sep 22, 2021 at 02:30:04PM -0700, David E. Box wrote:
> > > > Intel Platform Monitoring Technology (PMT) support is indicated by presence
> > > > of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> > > > structures may also be used by Intel to indicate support for other
> > > > capabilities unrelated to PMT.  OOBMSM is a device that can have both PMT
> > > > and non-PMT capabilities. In order to support these capabilities it is
> > > > necessary to modify the intel_pmt driver to handle the creation of platform
> > > > devices more generically.
> > > 
> > > I said this on your other driver submission, but why are you turning a
> > > PCIe device into a set of platform devices and craming it into the MFD
> > > subsystem?
> > > 
> > > PCIe devices are NOT platform devices.
> > 
> > But they *are* used to create platform devices when the PCIe device is multi-functional, which is
> > what intel_pmt is.
> > 
> > > 
> > > Why not use the auxiliary bus for this thing if you have individual
> > > drivers that need to "bind" to the different attributes that this single
> > > PCIe device is exporting.
> > 
> > It wasn't clear in the beginning how this would evolve. MFD made sense for the PMT (platform
> > monitoring technology) driver. PMT has 3 related but individually enumerable devices on the same IP,
> > like lpss. But the same IP is now being used for other features too like SDSi. We could work on
> > converting this to the auxiliary bus and then covert the cell drivers.
> 
> I see this as subsequent work.  It should not affect this submission.
> 
> FWIW, I still plan to review this set for inclusion into MFD.

That's fine, but as the add-on submission that builds on top of this is
a broken mess (which is what caused me to have to review this series), I
can't recommend that be taken yet as it needs work to prevent systems
from doing bad things.

thanks,

greg k-h
