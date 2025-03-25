Return-Path: <linux-pci+bounces-24691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA8A708CF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A6A3B0ACD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2B26463B;
	Tue, 25 Mar 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7NVhPDu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E906264628
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926165; cv=none; b=d4lRcA3N1nvATItURHz5joWEhg92L6y1lQElSiENuzb5h4E6EkyHqDNUUq9vHVAzWaoitweWpM6OsSBwFaBARAn5QxA/zYoZfcm1unP/LalJXXbuMfOB4lk5d7noykuuq8L7H7mJM06m+lbk0I/3JTMH6iX2qk0PgCjqnwa5OwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926165; c=relaxed/simple;
	bh=kwrD0kk73w4WKSwM/MIyzGd8Rlp1W5PDLpfyMta66ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DByKqbubAoj+SwHV++FM398SxrTczweWDKFemmg6d183+UPLMCoGLI+b/Lhypwcf5blI401UhJuBNFLM4RSbkmeDlrIpCwekf/PUHgaNuvzldskv63OPcerOc2soIdUYJFgdO/rd6VcI+M3WNkkdC90BakQTGf93QZBYzABNMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7NVhPDu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2255003f4c6so116256595ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742926163; x=1743530963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GkFwRrf70rNA8OmaYxw9PFrRp7+gsmsE+hCsvNFF5YM=;
        b=Z7NVhPDuB+Y3DuWrbTOvbanmmzpJtXBDYwhLHrn5CoJTurebba7PYZhajOiHeI7F+c
         0gu1OzwsM2y5iHIKxd6OxGh3fDnRw6ko6gbZOuKY1mPrP/fovJ3rrkyq60K63t/jETB/
         ZKdXDGNINBvqhKEaBoNzLPX2e62F3mZZI/jV03dXBTW0+GCgdM6U36tof0kEm/kGwQun
         oI5rL8ePicWlbgufQnhIx2ou3g6Hb99hcGmb/GLqo3aaj3KWnC1FxGJAJtTs0AKqODQw
         bkayENc1FYgogirMyQ+739ShUFWUe3GWa5ju38v/7nTwLE4q/UJD+mxn6EDY2fyGtCVg
         GRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926163; x=1743530963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkFwRrf70rNA8OmaYxw9PFrRp7+gsmsE+hCsvNFF5YM=;
        b=sjy+79Oi2/KtU5FlSmt/8Iq5iEiTvTvUaqdI/hypLBjKhrmuthatDjh1AUU1A+jsVT
         BQTsPb3gGF0WAksWcVMhqxgnLs7oE3QKJRUIY0HC40v+ScGFu6rybw2l3mdA5ogi/Rl3
         Wuf3HRjkid9TnqK2RNEDpXgaZmPNFcz2NIDiQvUKLEchlYt4PiJcq2xonOLVqQ2YMqJA
         rkdNUncD/VTFomk/vyrX20jQb2AESP1FH2S2wDtwSJUBzMgVUVrss1Y6FdyDSOI0l9Nk
         wGYpMTMgYYKtmydUrPPnkLbHTcmMmML3atgzxAa5C2o+/I06eNsFxJW3R9I1wExO7Sx3
         WOFg==
X-Forwarded-Encrypted: i=1; AJvYcCWq3bTrkK565dlGHdTeNcAWOV1P4KvxpW208i3aUwturljxYw7ePxLkgSpRvpy/ViMDZ7JnkysLMbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR5Tfcve8WT8zyMWV432MkazkWWzlmOuNAHXf00g6qHF0jw961
	YoZ7qg0dKEWo+/jZzHgR4ajCxXfhS75iBUrmg4mT/DAbDR7vXkgrOtohNRKPhQ==
X-Gm-Gg: ASbGnctefJjiUaS7fIdVu0wBHy2mD7sR1TLkN9BHs0dIyRZ6XwnsNs80zoT1oyPWXuQ
	tOfySSdjDM0QbikYG1gYcDPbtPYxYOY3QoIOMHIeXX9c+wdnkVJyStyknThSVBcNHjSEOyuy3oa
	lNLMJyUF4qShHjdsV3CAMIuvopH7LCrXBuirvZZfJafXtdowPEEuZuigBvgrNGF+Bi2W/Ia1TMK
	OGKw2YJiPUgVMEgOSHnCUMP8P9irBuB0CuEegkd4B4i37gYFs75LGs2dyqvzRGiklfHlRKUL4n+
	KYKLY2x2EsBFvbNCI0oN59GQb/RQ9/yOqJCgt+t95ldOy2HnkMCHvfy94Q/gN9CL78k=
X-Google-Smtp-Source: AGHT+IHsQEtK5eDuRWsdEQBYf6f44q2yB07kDLfDBWhVOxMWTo+zOzGbIhIFFRGiGOEd2PP4iDFCkA==
X-Received: by 2002:a17:902:f693:b0:226:3781:379d with SMTP id d9443c01a7336-22780e1044fmr239586185ad.33.1742926163021;
        Tue, 25 Mar 2025 11:09:23 -0700 (PDT)
Received: from thinkpad ([120.60.136.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3962esm93992265ad.4.2025.03.25.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:09:22 -0700 (PDT)
Date: Tue, 25 Mar 2025 23:39:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <3rtte7uyv7gilxnstcxjizpkdlfk5rfxwyc3bd4ednjakn5rfc@fhidkj5vvmtf>
References: <x2r2xfxrnkihvpoqiamgjmvppverjugp5r4we7lcfpz6jloxzy@7kdfzxiwv2po>
 <20250324200437.GA1257874@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324200437.GA1257874@bhelgaas>

On Mon, Mar 24, 2025 at 03:04:37PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 24, 2025 at 11:00:24PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > > 
> > > dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> > > controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> > > is a hard-coded way to get the parent bus address corresponding to a CPU
> > > physical address.
> > > 
> > > Add debug code to compare the address from .cpu_addr_fixup() with the
> > > address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> > > redundant and should be removed; if they differ, warn that something is
> > > wrong with the devicetree.
> > > 
> > > If .cpu_addr_fixup() is not implemented, the parent bus address should be
> > > identical to the CPU physical address because we previously ignored the
> > > parent bus address from devicetree.  If the devicetree has a different
> > > parent bus address, warn about it being broken.
> > > 
> > > [bhelgaas: split debug to separate patch for easier future revert, commit
> > > log]
> > > Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
> > >  2 files changed, 38 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 0a35e36da703..985264c88b92 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > >  	struct device *dev = pci->dev;
> > >  	struct device_node *np = dev->of_node;
> > >  	int index;
> > > -	u64 reg_addr;
> > > +	u64 reg_addr, fixup_addr;
> > > +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> > >  
> > >  	/* Look up reg_name address on parent bus */
> > >  	index = of_property_match_string(np, "reg-names", reg_name);
> > > @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > >  
> > >  	of_property_read_reg(np, index, &reg_addr, NULL);
> > >  
> > > +	fixup = pci->ops->cpu_addr_fixup;
> > > +	if (fixup) {
> > > +		fixup_addr = fixup(pci, cpu_phy_addr);
> > > +		if (reg_addr == fixup_addr) {
> > > +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> > > +				 cpu_phy_addr, reg_name, index,
> > > +				 fixup_addr, fixup);
> > > +		} else {
> > > +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> > > +				 cpu_phy_addr, reg_name,
> > > +				 index, fixup_addr);
> > > +			reg_addr = fixup_addr;
> > > +		}
> > > +	} else if (!pci->use_parent_dt_ranges) {
> > 
> > Is this check still valid? 'use_parent_dt_ranges' is only used here for
> > validation. Moreover, if the fixup is not available, we should be able to
> > safely return 'cpu_phy_addr - reg_addr' unconditionally.
> 
> Yes, that's true IF the devicetree has the correct 'ranges'
> translation.  This is to avoid breaking platforms with broken
> devicetrees.
> 

You mean the driver without cpu_addr_fixup() and devicetree with broken 'ranges'
property? So the existing platforms... Not a bad idea though.

> > > +		if (reg_addr != cpu_phy_addr) {
> > > +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> > > +				 cpu_phy_addr, reg_addr);
> > > +			return 0;
> > > +		}
> > > +	}
> > > +
> > > +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> > > +		 reg_name, cpu_phy_addr - reg_addr);
> > 
> > This info is useless on platforms having no translation between CPU and PCI
> > controller. The offset will always be 0.
> 
> You're right.  This was probably an overzealous message for any
> possible issues.
> 
> What would you think of the below as a replacement?  It should emit at
> most one message, and none for platforms where devicetree describes no
> translation and there never was a .cpu_addr_fixup().
> 
> It's still pretty aggressive logging, but I'm just concerned about
> being able to quickly debug and fix any regressions.  Ideally we can
> revert the whole thing eventually.
> 
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 27b464a405a4..4b442d1aa55b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	int index;
> -	u64 reg_addr;
> +	u64 reg_addr, fixup_addr;
> +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
>  
>  	/* Look up reg_name address on parent bus */
>  	index = of_property_match_string(np, "reg-names", reg_name);
> @@ -1126,5 +1127,42 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  
>  	of_property_read_reg(np, index, &reg_addr, NULL);
>  
> +	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
> +	if (fixup) {
> +		fixup_addr = fixup(pci, cpu_phys_addr);
> +		if (reg_addr == fixup_addr) {
> +			dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
> +				 reg_name, index, reg_addr, fixup_addr,
> +				 (unsigned long long) cpu_phys_addr, fixup);
> +		} else {
> +			dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
> +				 reg_name, index, reg_addr, fixup_addr,
> +				 (unsigned long long) cpu_phys_addr);
> +			reg_addr = fixup_addr;
> +		}
> +
> +		return cpu_phys_addr - reg_addr;
> +	}
> +
> +	if (pci->use_parent_dt_ranges) {
> +
> +		/*
> +		 * This platform once had a fixup, presumably because it
> +		 * translates between CPU and PCI controller addresses.
> +		 * Log a note if devicetree didn't describe a translation.
> +		 */
> +		if (reg_addr == cpu_phys_addr)
> +			dev_info(dev, "%s reg[%d] %#010llx == cpu %#010llx\n; no fixup was ever needed for this devicetree\n",
> +				 reg_name, index, reg_addr,
> +				 (unsigned long long) cpu_phys_addr);

So this check is to detect the usage of old DTs with new kernel without
cpu_addr_fixup()? If so:

(1) The log is not accurate
(2) The driver would be broken, so the log should be an error. This condition
should not be met (if we do not remove the fixup for some time). But I think
this check should be moved ahead of cpu_addr_fixup() so that the correct DTs
would be honored first and the fixup would be ignored for them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

