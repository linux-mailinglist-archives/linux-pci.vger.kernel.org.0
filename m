Return-Path: <linux-pci+bounces-20105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05BA16058
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 06:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273347A304E
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F742A80;
	Sun, 19 Jan 2025 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jli6BU0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7C2905
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264584; cv=none; b=AlWQS4KB8qjp6g7pVDiNNI0+OV2E8oVyAZCkB3U0v41AeV7LfeMGBX6gIa18XmBB7h1gKgbpcVVvhoL1XfyZ+UXjDcvtgfkYwlSxKawtc+WvOrWboPuBD4f8Vhl7gLijXulwVy/R9y/yuwC9xSEqqfGP2KPF9xOhmwACkzj1e1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264584; c=relaxed/simple;
	bh=YQ+SkVn/5dZ1bvQk0aMHEyYxSViS0MRSAtnyJ7ipyG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0eUYLdC4Nc8TzUI5b10odVYHszvwMV0Tp9quf8IdHimN9HRNAsU0VOuiasfqHyjC22ddrmnuhdN+WPv/8uXu++j9XqoKFJkA+D57MM7JGee6gIvo3Qvj0jnjbw0UQn/lwnCveYv0sJ98OZeHnMnsM0pV+5IjAh4YKEwme5Vs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jli6BU0U; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2156e078563so44495315ad.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 21:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737264581; x=1737869381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ydg819ik4XGyFgZqGWRtIjraKUcIHCENX6zMa6kvYxQ=;
        b=Jli6BU0UwOMpDhVSkdfOqPqa8/m1Z2AsTlboBsnvErrNKnCWZcNUvooLQVaG15MKtD
         A9m0vMXZGIv2NmwC50mr7CXg0UobsmoRjGAjUjqSphCNA3xzw8CtvgO1a1CetcBTa3U7
         QwJq2hikUkCuFidLUXwGpEkxcUWW5V529HJM0jYPHe7lE6Qj4KTLJ2QUSL8Sr4Happm4
         tXUdExSgzTdwUAbGfpxLsezoY+a4OTgIYJtXUvIpX+b8Rpt/AnWnTwENsA3S4jZHm99x
         J2Vd1UQDDRGyJ/pmt2n3Zoe0JIyv+OxNCuXekwmJWlc8Q/gfZPDw3bDGWEBQRf4AzRCE
         KOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264581; x=1737869381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydg819ik4XGyFgZqGWRtIjraKUcIHCENX6zMa6kvYxQ=;
        b=qAdUX2aOqJKVBdHbZY0lmOcXnBItk+QLKWlvInGoeyTagx3u+y409ifV9HwIuJBA6w
         vdA264e6a6R+fpykk1efWrpGzTNIG3cppb+/LJHSlUGzfAFX0ErvhBmprxJ3h9vJvl9G
         zc5R7fByvmD+LCrPkr3OWVCoIcJTSvLhbnZ7lNHcb/5/1DYFzu+vqnj6+ZJ8n5kKSFvR
         egvgXjeOv5JVLguxOUofg8P2cbmLqj+z1XC7hDCMzyvGewtwBt/026nqsWEKTYOmrX7u
         Uofc0tLeH5n/63ePh2bVgHYI5t35gGwWAUSxs8mxJ7DF1aj78JnpKaAK5h9lMj1gmU5S
         Pj/w==
X-Forwarded-Encrypted: i=1; AJvYcCVq3AyxOOct26CyubpnfhzQiLU0u4J2mrkv4KsViay7ngslGTOmx/eVRRc9UoUdkrEa7wxAaon7fLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+LAOpQyeqX366Hkkx/2wXISNXYDR0KABgrlPhXMMOQvrasSE
	QVswK/QNN3BPFpvF9H/yMhGqCmi40wPEwdj9fcE5xYQX0sItHQS2BFHmA2Fx9Q==
X-Gm-Gg: ASbGncvOQQsXDbm+mAp9Z+m5ZU1nmnbmjFtDijhXWJUs1SKVq5ZlgQddAi4nxJKqjNV
	qYIlUGE3rxcY7hKtOH4E8ziHHwN83iupdzuMWgKMCJk3ZWXD7ibsN1zSR5gKuxJLUVJhzBEtPMP
	t0B4SYCqrpJ/Ag5EStIqBKWE4w6Ya3uOYBZd0q/KP1CyuOXCypupuLZb+FB33COVdorNO4+CPkD
	IMixhrJ62qr/0/lChY+s0X/50ny1+oG5VqIfVY4kiFyU8Cw67tp/WAasqiyi4IwTfKq+3zJUZWu
	4U4f/g==
X-Google-Smtp-Source: AGHT+IHZGUl+Ctjc/5TpRqHK8lpZy41XaNwXG9sP8EBg5F1ecmuKd1KUI27K/f5SQg63QIHw65cByQ==
X-Received: by 2002:a17:902:cec3:b0:21a:7cbe:3a9a with SMTP id d9443c01a7336-21c353ee9cfmr128024215ad.14.1737264580900;
        Sat, 18 Jan 2025 21:29:40 -0800 (PST)
Received: from thinkpad ([120.60.143.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea08cesm39646805ad.50.2025.01.18.21.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:29:39 -0800 (PST)
Date: Sun, 19 Jan 2025 10:59:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/6] PCI: dwc: endpoint: Add support for BAR type
 BAR_RESIZABLE
Message-ID: <20250119052935.x776q7pff5hfsm4i@thinkpad>
References: <20250113102730.1700963-8-cassel@kernel.org>
 <20250113102730.1700963-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113102730.1700963-11-cassel@kernel.org>

On Mon, Jan 13, 2025 at 11:27:34AM +0100, Niklas Cassel wrote:

Maybe the subject should be reworded as:

PCI: dwc: endpoint: Allow EPF drivers to configure the size of Resizable BARs

> The DWC databook specifies three different BARn_SIZING_SCHEME_N
> - Fixed Mask (0)
> - Programmable Mask (1)
> - Resizable BAR (2)
> 
> Each of these sizing schemes have different instructions for how to
> initialize the BAR.
> 
> The DWC driver currently does not support resizable BARs.
> 
> Instead, in order to somewhat support resizable BARs, the DWC EP driver
> currently has an ugly hack that force sets a resizable BAR to 1 MB, if
> such a BAR is detected.
> 
> Additionally, this hack only works if the DWC glue driver also has lied
> in their EPC features, and claimed that the resizable BAR is a 1 MB fixed
> size BAR.
> 
> This is unintuitive (as you somehow need to know that you need to lie in
> your EPC features), but other than that it is overly restrictive, since a
> resizable BAR is capable of supporting sizes different than 1 MB.
> 
> Add proper support for resizable BARs in the DWC EP driver.
> 
> Note that the pci_epc_set_bar() API takes a struct pci_epf_bar which tells
> the EPC driver how it wants to configure the BAR.
> 
> struct pci_epf_bar only has a single size struct member.
> 
> This means that an EPC driver will only be able to set a single supported
> size. This is perfectly fine, as we do not need the complexity of allowing
> a host to change the size of the BAR. If someone ever wants to support
> resizing a resizable BAR, the pci_epc_set_bar() API can be extended in the
> future.
> 
> With these changes, the DWC EP driver will be able to support resizable
> BARs (we intentionally only support a single supported resizable BAR size).

Same comment as patch 1.

> This means that an EPC driver does not need to lie in EPC features, and an
> EPF driver will be able to set an arbitrary size (not be forced to a 1 MB
> size), just like BAR_PROGRAMMABLE.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 195 ++++++++++++++++--
>  1 file changed, 180 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 6b494781da42..34c3ae7219f4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -223,6 +223,138 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	ep->bar_to_atu[bar] = 0;
>  }
>  
> +static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
> +						enum pci_barno bar)
> +{
> +	u32 reg, bar_index;
> +	unsigned int offset, nbars;
> +	int i;
> +
> +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	if (!offset)
> +		return offset;
> +
> +	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +	nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
> +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		bar_index = reg & PCI_REBAR_CTRL_BAR_IDX;
> +		if (bar_index == bar)
> +			return offset;
> +	}
> +
> +	return 0;
> +}
> +
> +static u32 dw_pcie_ep_bar_size_to_rebar_cap(size_t size)
> +{
> +	u32 val;
> +
> +	/*
> +	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
> +	 * thus disallow a requested BAR size smaller than 1 MB.
> +	 * Disallow a requested BAR size larger than 128 TB.
> +	 */
> +	if (size < SZ_1M || (u64)size > (SZ_128G * 1024))
> +		return 0;

Could you please move this check to pci_epc_set_bar()?

> +
> +	val = ilog2(size);
> +	val -= 20;

val = ilog2(size) - ilog2(SZ_1M);

> +
> +	/* Sizes in REBAR_CAP start at BIT(4). */
> +	return BIT(val + 4);
> +}

This function is also not DWC specific, so this could also be moved to
pci-epc-core.

> +
> +static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
> +					struct pci_epf_bar *epf_bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	size_t size = epf_bar->size;
> +	int flags = epf_bar->flags;
> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +	unsigned int rebar_offset;
> +	u32 rebar_cap, rebar_ctrl;
> +
> +	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
> +	if (!rebar_offset)
> +		return -EINVAL;
> +
> +	rebar_cap = dw_pcie_ep_bar_size_to_rebar_cap(size);
> +	if (!rebar_cap)
> +		return -EINVAL;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	/*
> +	 * You should not write a BAR mask for a resizable BAR. The BAR mask

Nit: Avoid using 'you'

> +	 * is automatically derived by the controller every time the "selected
> +	 * size" bits are updated, see "Figure 3-26 Resizable BAR Example for
> +	 * 32-bit Memory BAR0" in DWC EP databook 5.96a. We simply need to write
> +	 * BIT(0) to set the BAR enable bit.
> +	 */
> +	dw_pcie_ep_writel_dbi2(ep, func_no, reg, BIT(0));
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
> +
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, 0);
> +		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
> +	}
> +
> +	/*
> +	 * Bits 31:0 in PCI_REBAR_CAP define "supported sizes" bits for sizes
> +	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
> +	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
> +	 */
> +	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
> +	rebar_ctrl &= ~GENMASK(31, 16);
> +	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
> +
> +	/*
> +	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
> +	 * updated when writing PCI_REBAR_CAP, see "Figure 3-26 Resizable BAR
> +	 * Example for 32-bit Memory BAR0" in DWC EP databook 5.96a.
> +	 */
> +	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CAP, rebar_cap);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}
> +
> +static int dw_pcie_ep_set_bar_programmable(struct dw_pcie_ep *ep, u8 func_no,
> +					   struct pci_epf_bar *epf_bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	size_t size = epf_bar->size;
> +	int flags = epf_bar->flags;
> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	dw_pcie_ep_writel_dbi2(ep, func_no, reg, lower_32_bits(size - 1));
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
> +
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
> +	}
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}
> +
> +static enum pci_epc_bar_type dw_pcie_ep_get_bar_type(struct dw_pcie_ep *ep,
> +						     enum pci_barno bar)
> +{
> +	const struct pci_epc_features *epc_features = ep->ops->get_features(ep);

'epc_features' can be NULL.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

