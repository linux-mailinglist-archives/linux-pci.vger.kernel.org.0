Return-Path: <linux-pci+bounces-3760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1185BB88
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C131F26003
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F467C67;
	Tue, 20 Feb 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tgk4Nf+y"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EB67C6A;
	Tue, 20 Feb 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431122; cv=none; b=kJfv2WiZcZ0pm1ENuluuMD8krDZlNOT5lmLjvubcVqVf0IbE/wjFUP27slH3cVO8zxLkIu5+tDrW69yUEwrAG29NI2iTzZrUxlNEed+aAnI8WKCcrPKx9VId0M9d+j9AuLTNRDriSeUlP8B0HSQs/6XPDJuTcWMhEhXjSew7R1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431122; c=relaxed/simple;
	bh=VQwdwkiqF7atE4ZGt/XQ1+JYNrmZCk8qg42wHIdGyEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYws9AJl6aVz+hTeDfH268mtaPG1iyin241lnYsTGoZkjniqOpvtC9YdynF0X1wfoBCErE0rznHGIoqNg1Z8bEpvebBz1yki6aNM83Y0S3/MBQmIWU9IS57OgLAs7zXbosyB+TyY6hULXlVSKX2C0FbrIV0r/pwcWDQSR+vWTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tgk4Nf+y; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KCBgP8088721;
	Tue, 20 Feb 2024 06:11:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708431102;
	bh=A1Wnhtv/mj8FTbw6kpoNXtyq830Vf6qti0CsRifKZCM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Tgk4Nf+ywcowy+vjLIs8yyUUYlDeNgBzmIYjyHODprN4yxMW60DRZUpYZTAVszA4x
	 ySv6zp5dWUNYFpAYafdIHIYKOm+55czngq/QDKqmW0DQq1JPbKG0vHUhoPEMG19eLo
	 AZJXSBuBDNleq526lvOXsStT7ThwdQn1oDZqcpRw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KCBgDI005500
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 06:11:42 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 06:11:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 06:11:42 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KCBfOj072811;
	Tue, 20 Feb 2024 06:11:42 -0600
Date: Tue, 20 Feb 2024 17:41:41 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut
	<marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Message-ID: <70a2f29f-301d-40c6-bc37-abab35286caa@ti.com>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
 <20240216-dw-hdma-v2-1-b42329003f43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216-dw-hdma-v2-1-b42329003f43@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 24/02/16 11:04PM, Manivannan Sadhasivam wrote:
> In order to add support for Hyper DMA (HDMA), let's refactor the existing
> dw_pcie_edma_find_chip() API by moving the common code to separate
> functions.
> 
> No functional change.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 40 +++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..3a26dfc5368f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
>  	.irq_vector = dw_pcie_edma_irq_vector,
>  };
>  
> -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +static void dw_pcie_edma_init_data(struct dw_pcie *pci)
> +{
> +	pci->edma.dev = pci->dev;
> +
> +	if (!pci->edma.ops)
> +		pci->edma.ops = &dw_pcie_edma_ops;
> +
> +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +}
> +
> +static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> @@ -902,8 +912,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  
>  	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
>  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> -
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  	} else if (val != 0xFFFFFFFF) {
>  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;

Minor suggestion:

The above section prior to this patch was:
	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
		pci->edma.mf = EDMA_MF_EDMA_UNROLL;

		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
	} else if (val != 0xFFFFFFFF) {
		pci->edma.mf = EDMA_MF_EDMA_LEGACY;

		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
	} else {
		return -ENODEV;
	}

And this patch is removing the call to dw_pcie_readl_dma() in the "if"
condition above. So the curly braces after this patch will only be
present because of the "else if" statement. So is the following change a
good idea?

	/* Assume it is EDMA_LEGACY by default but update it later if needed */
	pci->edma.mf = EDMA_MF_EDMA_LEGACY;

	if (val == 0xFFFFFFFF && pci->edma.reg_base)
		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
	else if (val != 0xFFFFFFFF)
		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
	else
		return -ENODEV;


Regards,
Siddharth.

