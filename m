Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF15711A008
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfLKAeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 19:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLKAeg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 19:34:36 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA67206EC;
        Wed, 11 Dec 2019 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576024475;
        bh=jzFJSZUzcWHDrnR5nBtffbFTzo3Xxd+S7C/GyLfcdGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RmsQfocZuOJZPtWto8q9H9xqVFb1xK9FBnd5qp4WEe+QlPj1JrDkGZtdjnLGoLY50
         DmGGmu4EEiZTSUFjk9AtI25LWmOYEZXjECT7RRs1yhyWYZfnb2JlAALSrR5ANU0kmP
         gFxDuBMJfbV4vu4EahFTRgGcuPSidhYwHDHnif+g=
Date:   Tue, 10 Dec 2019 18:34:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org,
        rjui@broadcom.com
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
Message-ID: <20191211003433.GA182827@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3b9565-1426-20a8-4982-c680001bbbbf@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 04:28:47PM -0800, Ray Jui wrote:
> 
> 
> On 12/10/19 4:09 PM, Bjorn Helgaas wrote:
> > On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
> > > CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> > > in.  Removing the ifdef will allow us to build the driver as a module.
> > > 
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > ---
> > > Alternatively, we can change the condition to:
> > > 
> > >    #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
> > > .
> > > 
> > > I chose to remove the ifdef because that's what other quirks looked like
> > > in this file.
> > > ---
> > >   drivers/pci/quirks.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 320255e5e8f8..cd0e7c18e717 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -2381,7 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
> > >   			 PCI_DEVICE_ID_TIGON3_5719,
> > >   			 quirk_brcm_5719_limit_mrrs);
> > > -#ifdef CONFIG_PCIE_IPROC_PLATFORM
> > >   static void quirk_paxc_bridge(struct pci_dev *pdev)
> > >   {
> > >   	/*
> > > @@ -2405,7 +2404,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> > > -#endif
> > 
> > Is there a reason this quirk can't be moved to
> > drivers/pci/controller/pcie-iproc-platform.c?  That would make it much
> > less subtle because it would be compiled if and only if the driver
> > itself is compiled.
> > 
> > If it needs to be here in quirks.c, please include a note about the
> > reason.
> 
> There's no particular reason and yes it could be moved to pcie-iproc.c.
> 
> If that's preferred (and it sounds like it is) then we can do that.

Yes, please, that would be great!  No #ifdefs, plus the code won't be
compiled into x86 and other arches that never use that driver.

Bjorn
