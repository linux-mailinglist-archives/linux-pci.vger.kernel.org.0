Return-Path: <linux-pci+bounces-5184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BC88C52B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8341F3DF89
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E87FBD5;
	Tue, 26 Mar 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GHjaYru+"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BF1BC40;
	Tue, 26 Mar 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463431; cv=none; b=evhYs3rjFkDRPPaIWl7j3rYHUi2tQO0Yx2ztiYJ1ueT84YSuZvUA/XdVFk+NqPn2emrVYQ1Ce9RpsKObukPEwqL0ewO/it5CVva2DM5/WP5MJIcD3ExJpu5DGNucOvjvl48xQML/bHslwk+AjEaCr3OkRnXmBWYVJ8paMDvbi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463431; c=relaxed/simple;
	bh=//rHrUgjEmOLGBfGfKkrjCnOWQAuk+QBok4YREDf2W4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrrQtbXqHbTFjSlxTnXcEz3/YRBCim1DtmkYsESK4aQe8IX89KdlF7I5XYDIsYFzlxSj14eYzlEaHJv0LFyGDfo7bCg49nOZyjV7834nDjNxLkMxfEOdpCgFg+O32nzi8GUjfVPC0FJfr/xasqg8HiDUEKNrLsjmyuHtbZjmuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GHjaYru+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QEU7GL128913;
	Tue, 26 Mar 2024 09:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711463407;
	bh=SNTgUxZVk6wVetOWRKspsG10dACCHvhBQOX0BXi4C+w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GHjaYru+bg6VZoMaYMwvG3Jd2Boj/ElWmnu9f1PCcRyRMDJGwEFolkQvRVLahjsz/
	 6ry1h5LuRjzx9bT/xtowYSqrcs26MBpYCNkp/yalSVOA3BdWcxuBBAcO54jQQep7nq
	 IDvLD2pq2xlWh92hgmAgJSK/cHGSUtGGt6JTfYdQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QEU6DV081421
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 09:30:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 09:30:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 09:30:06 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QEU5Y7074845;
	Tue, 26 Mar 2024 09:30:06 -0500
Date: Tue, 26 Mar 2024 20:00:04 +0530
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
Message-ID: <2e40b30d-b063-48ac-a566-f66eb2788003@ti.com>
References: <20240326111905.2369778-1-s-vadapalli@ti.com>
 <ZgLUCqh12RMApzyr@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgLUCqh12RMApzyr@x1-carbon>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Mar 26, 2024 at 02:56:26PM +0100, Niklas Cassel wrote:
> On Tue, Mar 26, 2024 at 04:49:05PM +0530, Siddharth Vadapalli wrote:
> > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > to controller version 3.65a, while the .add_bus() method had been added
> > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > ks_pcie_v3_65_add_bus() method are applicable to the controller version
> > 4.90a which is present in AM654x SoCs.
> > 

...

> > +	} while (val & DBI_CS2);
> > +}
> > +
> >  static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  {
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> > +
> > +	/* Configure and set up BAR0 */
> > +	ks_pcie_set_dbi_mode(ks_pcie);
> > +
> > +	/* Enable BAR0 */
> > +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> > +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> > +
> > +	ks_pcie_clear_dbi_mode(ks_pcie);
> > +
> > +	 /*
> > +	  * For BAR0, just setting bus address for inbound writes (MSI) should
> > +	  * be sufficient.  Use physical address to avoid any conflicts.
> > +	  */
> 
> This comment seems to have wrong indentation.
> With that fixed:
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

I will fix it and post the v6 patch.

Regards,
Siddharth.

