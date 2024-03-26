Return-Path: <linux-pci+bounces-5186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2888C5A7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 15:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1CFB25990
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73913C663;
	Tue, 26 Mar 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aX8o8gh7"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8E13C3F1;
	Tue, 26 Mar 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464503; cv=none; b=Nf44+P3s27+uJ7nOeEdfct0TWvPrYu+UVZoQtq1zXq3im74TFvDzjTOzyP/fnrPGKDzJad4KsgioWwV/Y2YNNoqxuisas4EQTbsfvo4Fr+tNd9siugZ/GdFYffKgLWpvYKxcmrqF3KuCcGrco2Z95SoEccm9KKDk3V1ytT6PVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464503; c=relaxed/simple;
	bh=WSB5F1WSZax7rQrE9wzTv65xq0IhCJ8+VtjWj4me3m8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUUV+0DwNrmeEfe38L8aTF5X13i6NvGxV5RqOzAVA1T3iK5uE8Nsc+HdlcnunvC3WRq9uL6tL1q7mFXoadB7Vrx8Cva7T+5Y+0ALtmmx9c4zgzvFJbwcpzoX7AMd2AnbIdzy8381xgqDlhQmmT0FZSekPhE3xRx2/NoA4tQl6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aX8o8gh7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QEm1EK121149;
	Tue, 26 Mar 2024 09:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711464481;
	bh=r5kO6gHMdss7KBmKCinOi5uDLA/3tf7mzyqUper/ros=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=aX8o8gh7KKSVG4M7zvZf6QdRV0MxzOhc7xOYlTaQ09TlWUVrmBPwsevCzu0CVAtlS
	 AC+bAqo8Px8MIFR6Mn8IrXfNVy+BndDAQ//MSqChtLf8djsMse1NL205ti9ThBmGco
	 uxQ+49u6vtwOcpq66Fo7x5M4wrs0FM1snZK1xZm4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QEm1qk022383
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 09:48:01 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 09:48:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 09:48:01 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QEm0PX024629;
	Tue, 26 Mar 2024 09:48:00 -0500
Date: Tue, 26 Mar 2024 20:17:59 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <fancer.lancer@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v5] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <c01170ab-b16b-45c7-9067-07cc9004e2c9@ti.com>
References: <20240326111905.2369778-1-s-vadapalli@ti.com>
 <ZgLUCqh12RMApzyr@x1-carbon>
 <2e40b30d-b063-48ac-a566-f66eb2788003@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e40b30d-b063-48ac-a566-f66eb2788003@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Mar 26, 2024 at 08:00:04PM +0530, Siddharth Vadapalli wrote:
> On Tue, Mar 26, 2024 at 02:56:26PM +0100, Niklas Cassel wrote:
> > On Tue, Mar 26, 2024 at 04:49:05PM +0530, Siddharth Vadapalli wrote:
> > > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > > to controller version 3.65a, while the .add_bus() method had been added
> > > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > > ks_pcie_v3_65_add_bus() method are applicable to the controller version
> > > 4.90a which is present in AM654x SoCs.
> > > 
> 
> ...
> 
> > > +	} while (val & DBI_CS2);
> > > +}
> > > +
> > >  static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  {
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> > > +
> > > +	/* Configure and set up BAR0 */
> > > +	ks_pcie_set_dbi_mode(ks_pcie);
> > > +
> > > +	/* Enable BAR0 */
> > > +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> > > +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> > > +
> > > +	ks_pcie_clear_dbi_mode(ks_pcie);
> > > +
> > > +	 /*
> > > +	  * For BAR0, just setting bus address for inbound writes (MSI) should
> > > +	  * be sufficient.  Use physical address to avoid any conflicts.
> > > +	  */
> > 
> > This comment seems to have wrong indentation.
> > With that fixed:
> > 
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> I will fix it and post the v6 patch.

I have posted the v6 patch at:
https://lore.kernel.org/r/20240326144258.2404433-1-s-vadapalli@ti.com/

Regards,
Siddharth.

