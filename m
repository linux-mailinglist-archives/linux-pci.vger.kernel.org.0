Return-Path: <linux-pci+bounces-21073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D08A2E81E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8917A3A8887
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835A1C4A02;
	Mon, 10 Feb 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSbXEeVj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE01BEF85
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180839; cv=none; b=ioqrYUaxw2xOI7LQFLIFqVKLjMWKLdKPIKRvj7qi+L/XTPx0IDnV/55BCtVx+11P361P1AcmiLEea/BU8SmEOq43ORXN+nGqQum8fBzXRJVpho6Auz3RZj+jZNBHFTGLjPiWcDkPzABFWfn5rIDwY5eACX27FsnA3wTB7Udd+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180839; c=relaxed/simple;
	bh=2r7TZMDfSPPm5LU5bgV4VCkElX81ruoMbFQWk9qpFW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdkD1yGWzanUIMY0803b89/LU2qmDAobH5UBYeX9fzR9Khs7VfgAhLW9daJQHBCeQV1ACmGReg8C45kxH/nHgkqfKwOPa7ORaEB8a9IJf4Q/KO1StE1IefCUki2F1c9kKK5+pd3zUN77OGvN4r4X3d0GPW63T0GCxbjra++TGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZSbXEeVj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa4493a695so2436023a91.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 01:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739180836; x=1739785636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t/gWsTAHhuQ8YNanqgzy8vlnvRL8N2S0+AFXHj4eSWE=;
        b=ZSbXEeVjxY8f2sp8JYpHuTSdZiq9HqAsXV3A/pAeJwjVmArB07DERNauCDebVJm4jm
         fqLa9z8ni7ekao0wYvj2XlxVa5ETQ6diGkd97HNnv4W0Jf7N8ItDR4o+Wtc8vJ9vBFlr
         eVhHRDTkvAiMxf+gpw/F0SES57RGkNio7rrcUVCogJ2Km/6LE6cslUOsCZe9pugon7gw
         oue3YIxkk1KaqefUUEg3gqPq7XG7F1Ef5fm7UmhrvVxPMPfOk/2LHSm5oIjFWoLwRqlc
         T4UHE6L+KBQ6SbZtWLJSx5rtt6y7vS4LOye0o3aAcyM7N5YojRZKpTVwPa4z6hfKGooJ
         yCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739180836; x=1739785636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/gWsTAHhuQ8YNanqgzy8vlnvRL8N2S0+AFXHj4eSWE=;
        b=gNv2zub6xbvoNq97gy5iz9ehvII4Dcpbgu2JCefTIx6msEZXRtszxeYqIyKXE/tjf3
         afNuQ3BrGn5N+TXl7dROOntcmlWyLUWU4Zw3TtEuQ9S41DWenkbFN2JeJCdBcD1b0/R0
         31laP7/9H22g6qiQlQxT2rj5k2LHrkla9hUAwySzQcBUH7vgL1ihXFAlgdFe5KQYKrPT
         yIIRnSEWd30g2vmpZCMZAAt5iMow0vpeDUfzsVyRs2C+egv6Xb6nzGTmkTCXxfyLwxEY
         0zHBhEuZ7bd2r2IYV/2/Y/69jKKsM07hPMuQAt6oytoH0mlfAgpZugnTrVW21FD2C5LO
         a88Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjtWpOp9qb0wG5ZLRlvAqjkq6LbjprJ1wV4S6UU2uZuPfIAwna8+QoDgn18uOX5QUdcqg00UHgSs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/v/4eqPmpAFIiFPTkVDSfKGkYXXMxXby0tM7XQ6iwJpEuMhx
	DeOhexeutbiOsg/dRX/UTGtGLUrPnUf+Hb/A9J1ZvE4OGwalav+7BhTDNylVTA==
X-Gm-Gg: ASbGncvZ3oR+iHslAcl6/45bT3tBy44jmXmI2LD1KlXdWzcVOGs4KOAdDcLbZ2sslow
	EfsD3OgnHzoe8VEKr4KJ/Q0cvA8vzJs5+r3gt0IQ0Q4O5KSrbtp4q+h7V7mpTtF3u2ibxFbtwkX
	u4f8Z6OgKHsyPCymiu1S7nhFekpo04xk8VEAR4Lj673GZlnek8cN7mjZUC5o12defWjOff/Zb0j
	2tbqQFj3ig0P1Dwt6qxLFE2yUcdr4Tf9FC4wHgXRkHFXYk/YR4mF+hFxmctagcCv+3+IklmSNaA
	PjE5PNLW6ezlpVC3b2wk5njDtrGy
X-Google-Smtp-Source: AGHT+IFwNvzVnIUWkxJ/1/slugP24suDHvocJcj8q023qee4IEM8MzOMQEU4Cx+QKRBUSYzX9cSTkw==
X-Received: by 2002:a17:90b:4a46:b0:2ea:aa56:499 with SMTP id 98e67ed59e1d1-2fa23f55de0mr18813704a91.1.1739180836421;
        Mon, 10 Feb 2025 01:47:16 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2a201b9dsm6167759a91.22.2025.02.10.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 01:47:16 -0800 (PST)
Date: Mon, 10 Feb 2025 15:17:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v4 4/4] PCI: qcom: Enable ECAM feature
Message-ID: <20250210094709.lih7lhnwjhmvrk7r@thinkpad>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-4-94b5d5ec5017@oss.qualcomm.com>
 <20250210092240.5b67fsdervb2tvxp@thinkpad>
 <5fc8c993-4993-d930-2687-96fdf95dc1cf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fc8c993-4993-d930-2687-96fdf95dc1cf@oss.qualcomm.com>

On Mon, Feb 10, 2025 at 03:04:43PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/10/2025 2:52 PM, Manivannan Sadhasivam wrote:
> > On Fri, Feb 07, 2025 at 04:58:59AM +0530, Krishna Chaitanya Chundru wrote:
> > > The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> > > gives us the offset from which ELBI starts. so use this offset and cfg
> > > win to map these regions instead of doing the ioremap again.
> > > 
> > > On root bus, we have only the root port. Any access other than that
> > > should not go out of the link and should return all F's. Since the iATU
> > > is configured for the buses which starts after root bus, block the
> > > transactions starting from function 1 of the root bus to the end of
> > > the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> > > outside the link through ECAM blocker through PARF registers.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 77 ++++++++++++++++++++++++++++++++--
> > >   1 file changed, 73 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index e4d3366ead1f..84297b308e7e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -52,6 +52,7 @@
> > >   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> > >   #define PARF_Q2A_FLUSH				0x1ac
> > >   #define PARF_LTSSM				0x1b0
> > > +#define PARF_SLV_DBI_ELBI			0x1b4
> > >   #define PARF_INT_ALL_STATUS			0x224
> > >   #define PARF_INT_ALL_CLEAR			0x228
> > >   #define PARF_INT_ALL_MASK			0x22c
> > > @@ -61,6 +62,17 @@
> > >   #define PARF_DBI_BASE_ADDR_V2_HI		0x354
> > >   #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
> > >   #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
> > > +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
> > > +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
> > > +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
> > > +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
> > > +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
> > > +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
> > > +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
> > > +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
> > > +#define PARF_ECAM_BASE				0x380
> > > +#define PARF_ECAM_BASE_HI			0x384
> > > +
> > >   #define PARF_NO_SNOOP_OVERIDE			0x3d4
> > >   #define PARF_ATU_BASE_ADDR			0x634
> > >   #define PARF_ATU_BASE_ADDR_HI			0x638
> > > @@ -84,6 +96,7 @@
> > >   /* PARF_SYS_CTRL register fields */
> > >   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
> > > +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
> > >   #define MST_WAKEUP_EN				BIT(13)
> > >   #define SLV_WAKEUP_EN				BIT(12)
> > >   #define MSTR_ACLK_CGC_DIS			BIT(10)
> > > @@ -294,6 +307,44 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> > >   	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> > >   }
> > > +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > +	u64 addr, addr_end;
> > > +	u32 val;
> > > +
> > > +	/* Set the ECAM base */
> > > +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> > > +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> > > +
> > > +	/*
> > > +	 * The only device on root bus is the Root Port. Any access other than that
> > > +	 * should not go out of the link and should return all F's. Since the iATU
> > > +	 * is configured for the buses which starts after root bus, block the transactions
> > > +	 * starting from function 1 of the root bus to the end of the root bus (i.e from
> > > +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
> > > +	 */
> > > +	addr = pci->dbi_phys_addr + SZ_4K;
> > > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
> > > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
> > > +
> > > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
> > > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
> > > +
> > > +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
> > > +
> > > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
> > > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
> > > +
> > > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
> > > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
> > > +
> > > +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
> > > +	val |= PCIE_ECAM_BLOCKER_EN;
> > > +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
> > > +}
> > > +
> > >   static int qcom_pcie_start_link(struct dw_pcie *pci)
> > >   {
> > >   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > @@ -303,6 +354,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
> > >   		qcom_pcie_common_set_16gt_lane_margining(pci);
> > >   	}
> > > +	if (pci->pp.ecam_mode)
> > > +		qcom_pci_config_ecam(&pci->pp);
> > > +
> > >   	/* Enable Link Training state machine */
> > >   	if (pcie->cfg->ops->ltssm_enable)
> > >   		pcie->cfg->ops->ltssm_enable(pcie);
> > > @@ -1233,6 +1287,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >   {
> > >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > >   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > +	u16 offset;
> > >   	int ret;
> > >   	qcom_ep_reset_assert(pcie);
> > > @@ -1241,6 +1296,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >   	if (ret)
> > >   		return ret;
> > > +	if (pp->ecam_mode) {
> > > +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
> > > +		pcie->elbi = pci->dbi_base + offset;
> > > +	}
> > 
> > If you use the existing 'elbi' register offset defined in DT, you can just rely
> > on the DWC core to call dw_pcie_ecam_supported() as I mentioned in my comment in
> > patch 3.
> >  >> +
> > >   	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> > >   	if (ret)
> > >   		goto err_deinit;
> > > @@ -1615,6 +1675,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >   	pci->ops = &dw_pcie_ops;
> > >   	pp = &pci->pp;
> > > +	pp->bridge = devm_pci_alloc_host_bridge(dev, 0);
> > > +	if (!pp->bridge) {
> > > +		ret = -ENOMEM;
> > > +		goto err_pm_runtime_put;
> > > +	}
> > > +
> > 
> > This will also go away.
> > 
> Hi Mani,
> 
> I get your point but the problem is in ECAM mode the DBI address to maximum
> of 256 MB will be ioremap by pci_ecam_create(). If we don't skip
> this ioremap of elbi ioremap in pci_ecam_create because we already
> iormaped elbi which falls in dbi address to 256 MB region( as we can't
> remap same region twice). so we need to skip doing ioremap for elbi
> region.
> 

Then obviously, your DT entries are wrong. You cannot define overlapping regions
on purpose. Can't you leave the ELBI region and start the config region?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

