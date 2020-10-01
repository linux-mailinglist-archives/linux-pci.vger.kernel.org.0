Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33D4280443
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbgJAQuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 12:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbgJAQuj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 12:50:39 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56343206B5;
        Thu,  1 Oct 2020 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601571038;
        bh=Dy9dlPDxuVQVw0d3xH0Da7njcTBnKG0XsUS0bZZr6oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J/2REUJ+GJ7O698V4SUiSQRXbIQiWfVUPSlnnnm4Wl5YtkvFQpvCiGWYsSVsgSzC/
         81150HQvrAykbuOFVZlPg+yFZiycgeir5ViJ2e8nNGeC/uU+wcTxyjsFwXctEtcoLy
         rnnLoioVNTeQMJTJJW0oyvFkmXFxR/hy553rvFsw=
Date:   Thu, 1 Oct 2020 11:50:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: of_match[] warnings
Message-ID: <20201001165037.GA2702236@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKKhN26qJT50zwaqtFDeUJBPJk0bRrGnFAz4k9K6f_Lhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 11:43:12AM -0500, Rob Herring wrote:
> On Thu, Oct 1, 2020 at 10:53 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Oct 01, 2020 at 07:48:23AM -0500, Rob Herring wrote:
> > > On Wed, Sep 30, 2020 at 5:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > These warnings are sort of annoying.  I guess most of the other
> > > > drivers avoid this by depending on OF as well as COMPILE_TEST.
> > >
> > > Using the of_match_ptr() macro should prevent this.
> >
> > Both drivers *do* use of_match_ptr(), but the of_device_id table is
> > unused when of_match_ptr() throws away the pointer.
> 
> Oh right, it's actually we don't want to use of_match_ptr() in this case.
> 
> > I guess we could add __maybe_unused to squelch the warning.  Ugly, but
> > I do think COMPILE_TEST has some value.
> 
> We do that or an ifdef for drivers that actually work for !OF.
> 
> We also have lot's of 'depends on OF' as proposed too, but that's not
> really my preference given we have empty functions for most
> everything.

So just removing of_match_ptr() as below?  That seems way nicer than
any of the #ifdef, __maybe_unused, or "depends on OF" options.

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 62846562da0b..b2ef8ffde79e 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -303,7 +303,7 @@ static struct platform_driver spear13xx_pcie_driver = {
 	.probe		= spear13xx_pcie_probe,
 	.driver = {
 		.name	= "spear-pcie",
-		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
+		.of_match_table = spear13xx_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
