Return-Path: <linux-pci+bounces-23005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2296A509F2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1167A41F4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394E24C062;
	Wed,  5 Mar 2025 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I79RATMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84841C6FF9
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199208; cv=none; b=U8DqBjSj+RzE05nDNY+TlSwH3R462hQWfOYkSMtkYeesfiiJTkv7fU1DwLtIvwhoscXspJih3sZ4JKPPeqSGhhEEvjGX8N99Y2C4U5ICmmQMO+wZdlp5dEihwxzdBqHAQWpjJma/nZ/5m9mjA2hrxjKizPWQctXhAHVGlLUOcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199208; c=relaxed/simple;
	bh=lOvJev40nIqo4oRoFQ7lLwUE57q+/VBiCQHKrO7PhuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxHCfFgEsGxKNmULquxul3rhVLZYXcZPl06+dJpSGGQ21XiGP3YH4pOR0D7OegB6S7P05KFAHs0mFw4qQ5/bTZ/DyMfTgTwa9pK96V1SPRI0wSHsW8mLSo6RHcTcOHZV4fV4Tt1M9ULq2sIY+Defvve8RaMujWrqp7sOQPvKcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I79RATMv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239aa5da08so70546115ad.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741199206; x=1741804006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tNWo3VYV/1cKBkZ4zhMAsTayxfYjzVYq1qj3gAwNT54=;
        b=I79RATMvIN6mhdOcC6HozQxxXIakzAALbJl4qZLJN4K1ZIFzeJQO3ExzdwsYY83g2C
         ulrSaMU2dUsfz+glmj35xXHjj97qvNVcRkB54ptlaW347MH7A+ghiG99kmppafknDTrv
         ICL6fvrlUtsr1uS/adCzcZhyFVfsMX8u9HGa7qYFCTEzCDEq8Aq5Tz/FvUstv+kcsgjM
         qevhONc/mGE7MLo7/HJQjTiy7yvPKHyN7we8sXvS51Vee0KnIxDgzpHjM4OhOb/tWAwQ
         Sb6YKGJ9jS5QZ8/o0INwm7UNW2NE0s3dgjR0f6oPqWvLF+KgN43LunzxbrD1Xz5o/dJT
         lvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199206; x=1741804006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNWo3VYV/1cKBkZ4zhMAsTayxfYjzVYq1qj3gAwNT54=;
        b=jAsMwKtpEmmKzF7xB4SHPdp8/VB9ZDkvK/DX8VynHiiRFHuon8RI5KLqusVqrCOrwQ
         aF6XYPEj+KUzmRLgJsdYQNZ/OF/1ANxETVu80yFGE9IGvAR8R6OiQcv0mmItZz/q5V58
         m0vxorUJ91LoWYQvDY/n2sdbWb+vRinht/w/JmLgHSpeDaqMQGO/5UspFd7CRpM8ofOn
         gnJzNDFnYiPoj7YFhYQTlwg4uoAWmGmg0NIT/11xaUiSdApLqBRj7c8uwMngIUnFZZqT
         PfaZUQaVWZHEMYZ26Q7JcSwQPWxVsuKKp1dmaJsucGpKI7IL7CW1xiqS6ca97RBIqLX/
         5e/g==
X-Forwarded-Encrypted: i=1; AJvYcCX8WWerSMR8/PEvnfrO6XOsuQBoIahoZ7kK+loFr+Jotenv6xsPN0vhm2PpxhBkWzk620lDdMBW9Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSp+EQ8rKR95617wIaDvMQVPUJz1u1pGrqw4EyW3LrACjkSOX
	I3wBaBF550tK1UMVsMfGioOECAoFCdgrwFGZBmJpnDPvbmUCVn1xkhNeilXkxA==
X-Gm-Gg: ASbGncvIQ1ZX9aKmW7tzmW/CDjB3CkaiyIO7/BzwYbHcCUOt/OqTfrkkw+xajQgVguZ
	kCjprYCAvrSg61l2g+Ajyspw96PGX3jEQYUo7fiWh2Ky/6ypjr5Un3xAZtvUNjaDxKo4CQ4MItS
	6tSH4i3HxrrhTR8QEz5YZeEA799hQrAYvTXnyON9HHJQO2wqb24+ehpzkwV1v1SEQrHc19nZCFE
	cHhOB3Zgltv/4FdMmvvR6cGMelTHwZpDU0GmQ6u0kBTcf9FZbl7j/JGp+Zrr7Vi2yGkUdekWr+B
	75Xqexijasa+wI45I/PQ1eceC7A+ur+3q1zOqQbOtSlAOOJMekx/veLV
X-Google-Smtp-Source: AGHT+IFVhueg+ws7/leYGv1nno/FZWcXMjXB/SdxpnJXXaT1iXjCsNP/1dqKZQfaQrzbrDGkZDCj0A==
X-Received: by 2002:a17:902:d50d:b0:223:6657:5001 with SMTP id d9443c01a7336-223f1d6cd0cmr76193495ad.40.1741199206134;
        Wed, 05 Mar 2025 10:26:46 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501faa33sm116126215ad.66.2025.03.05.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:26:45 -0800 (PST)
Date: Wed, 5 Mar 2025 23:56:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	cros-qcom-dts-watchers@chromium.org,
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
Message-ID: <20250305182639.ov6yiqplyaymdbpa@thinkpad>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-4-94b5d5ec5017@oss.qualcomm.com>
 <20250210092240.5b67fsdervb2tvxp@thinkpad>
 <5fc8c993-4993-d930-2687-96fdf95dc1cf@oss.qualcomm.com>
 <20250210094709.lih7lhnwjhmvrk7r@thinkpad>
 <149f513f-a68f-8966-4c3a-ed8c7aafb1ab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149f513f-a68f-8966-4c3a-ed8c7aafb1ab@quicinc.com>

On Mon, Feb 10, 2025 at 03:23:43PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/10/2025 3:17 PM, Manivannan Sadhasivam wrote:
> > On Mon, Feb 10, 2025 at 03:04:43PM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 2/10/2025 2:52 PM, Manivannan Sadhasivam wrote:
> > > > On Fri, Feb 07, 2025 at 04:58:59AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> > > > > gives us the offset from which ELBI starts. so use this offset and cfg
> > > > > win to map these regions instead of doing the ioremap again.
> > > > > 
> > > > > On root bus, we have only the root port. Any access other than that
> > > > > should not go out of the link and should return all F's. Since the iATU
> > > > > is configured for the buses which starts after root bus, block the
> > > > > transactions starting from function 1 of the root bus to the end of
> > > > > the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> > > > > outside the link through ECAM blocker through PARF registers.
> > > > > 
> > > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-qcom.c | 77 ++++++++++++++++++++++++++++++++--
> > > > >    1 file changed, 73 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index e4d3366ead1f..84297b308e7e 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -52,6 +52,7 @@
> > > > >    #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> > > > >    #define PARF_Q2A_FLUSH				0x1ac
> > > > >    #define PARF_LTSSM				0x1b0
> > > > > +#define PARF_SLV_DBI_ELBI			0x1b4
> > > > >    #define PARF_INT_ALL_STATUS			0x224
> > > > >    #define PARF_INT_ALL_CLEAR			0x228
> > > > >    #define PARF_INT_ALL_MASK			0x22c
> > > > > @@ -61,6 +62,17 @@
> > > > >    #define PARF_DBI_BASE_ADDR_V2_HI		0x354
> > > > >    #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
> > > > >    #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
> > > > > +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
> > > > > +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
> > > > > +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
> > > > > +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
> > > > > +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
> > > > > +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
> > > > > +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
> > > > > +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
> > > > > +#define PARF_ECAM_BASE				0x380
> > > > > +#define PARF_ECAM_BASE_HI			0x384
> > > > > +
> > > > >    #define PARF_NO_SNOOP_OVERIDE			0x3d4
> > > > >    #define PARF_ATU_BASE_ADDR			0x634
> > > > >    #define PARF_ATU_BASE_ADDR_HI			0x638
> > > > > @@ -84,6 +96,7 @@
> > > > >    /* PARF_SYS_CTRL register fields */
> > > > >    #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
> > > > > +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
> > > > >    #define MST_WAKEUP_EN				BIT(13)
> > > > >    #define SLV_WAKEUP_EN				BIT(12)
> > > > >    #define MSTR_ACLK_CGC_DIS			BIT(10)
> > > > > @@ -294,6 +307,44 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> > > > >    	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> > > > >    }
> > > > > +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
> > > > > +{
> > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > > > +	u64 addr, addr_end;
> > > > > +	u32 val;
> > > > > +
> > > > > +	/* Set the ECAM base */
> > > > > +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> > > > > +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> > > > > +
> > > > > +	/*
> > > > > +	 * The only device on root bus is the Root Port. Any access other than that
> > > > > +	 * should not go out of the link and should return all F's. Since the iATU
> > > > > +	 * is configured for the buses which starts after root bus, block the transactions
> > > > > +	 * starting from function 1 of the root bus to the end of the root bus (i.e from
> > > > > +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
> > > > > +	 */
> > > > > +	addr = pci->dbi_phys_addr + SZ_4K;
> > > > > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
> > > > > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
> > > > > +
> > > > > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
> > > > > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
> > > > > +
> > > > > +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
> > > > > +
> > > > > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
> > > > > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
> > > > > +
> > > > > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
> > > > > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
> > > > > +
> > > > > +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
> > > > > +	val |= PCIE_ECAM_BLOCKER_EN;
> > > > > +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
> > > > > +}
> > > > > +
> > > > >    static int qcom_pcie_start_link(struct dw_pcie *pci)
> > > > >    {
> > > > >    	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > > > @@ -303,6 +354,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
> > > > >    		qcom_pcie_common_set_16gt_lane_margining(pci);
> > > > >    	}
> > > > > +	if (pci->pp.ecam_mode)
> > > > > +		qcom_pci_config_ecam(&pci->pp);
> > > > > +
> > > > >    	/* Enable Link Training state machine */
> > > > >    	if (pcie->cfg->ops->ltssm_enable)
> > > > >    		pcie->cfg->ops->ltssm_enable(pcie);
> > > > > @@ -1233,6 +1287,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > > > >    {
> > > > >    	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > >    	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > > > +	u16 offset;
> > > > >    	int ret;
> > > > >    	qcom_ep_reset_assert(pcie);
> > > > > @@ -1241,6 +1296,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > > > >    	if (ret)
> > > > >    		return ret;
> > > > > +	if (pp->ecam_mode) {
> > > > > +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
> > > > > +		pcie->elbi = pci->dbi_base + offset;
> > > > > +	}
> > > > 
> > > > If you use the existing 'elbi' register offset defined in DT, you can just rely
> > > > on the DWC core to call dw_pcie_ecam_supported() as I mentioned in my comment in
> > > > patch 3.
> > > >   >> +
> > > > >    	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> > > > >    	if (ret)
> > > > >    		goto err_deinit;
> > > > > @@ -1615,6 +1675,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > > >    	pci->ops = &dw_pcie_ops;
> > > > >    	pp = &pci->pp;
> > > > > +	pp->bridge = devm_pci_alloc_host_bridge(dev, 0);
> > > > > +	if (!pp->bridge) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto err_pm_runtime_put;
> > > > > +	}
> > > > > +
> > > > 
> > > > This will also go away.
> > > > 
> > > Hi Mani,
> > > 
> > > I get your point but the problem is in ECAM mode the DBI address to maximum
> > > of 256 MB will be ioremap by pci_ecam_create(). If we don't skip
> > > this ioremap of elbi ioremap in pci_ecam_create because we already
> > > iormaped elbi which falls in dbi address to 256 MB region( as we can't
> > > remap same region twice). so we need to skip doing ioremap for elbi
> > > region.
> > > 
> > 
> > Then obviously, your DT entries are wrong. You cannot define overlapping regions
> > on purpose. Can't you leave the ELBI region and start the config region?
> > 
> > - Mani
> ELBI is part of DBI space(present in the first 4kb of the dbi) we can't
> relocate ELBI region to different location.
> can we keep this elbi region as optional and remove elbi from the
> devicetree and binding?
> 

Since ELBI is a DWC generic region, you should move the resource get call to
dw_pcie_get_resources(). Also, it is an optional region, so you should open code
devm_platform_ioremap_resource_byname() to skip devm_ioremap_resource() if
platform_get_resource_byname() returns NULL. DT binding should make sure that
the DTS has the region specified if required.

And this should allow you to move the dw_pcie_ecam_supported() call inside DWC
core.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

