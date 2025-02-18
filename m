Return-Path: <linux-pci+bounces-21682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB21A39124
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 04:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8194167BE8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 03:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936217A5BE;
	Tue, 18 Feb 2025 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCHS8vnV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF849155CBA
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848296; cv=none; b=QuHB03+bMiJt00wY15wCoxgRCoFUcU8O2rjKhu87Ax5V6JJUPJ3CSa863+JsebVPQcc2guuy9iK6KycS6m9p3xXQrH2TPWe4eeEvqv/EI02rP4j2caBT6DFT2F6KOEp9gVoQqWnBM/w3wAyyqclT1jrL6TOPR8mqROL1yarz610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848296; c=relaxed/simple;
	bh=RVJFrivssK5lOgAU2uZrT+MAH2UW87Q1ZpMgWOe+frI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKafQlce6spU7GlD1CefjK5UKJjCKZAmxNyyOhsLq+rWmEcVgQKUeG/2819vSX58gOTdsPyfNpnJ8zEyIsZbO/rU6vqU1Y1DUd3mSMOhLXRil8uNRA9cb6fifMAqr4dY/3KxbdFD91jCJEmpKjRejlwC01aCIYWnXUyWYRK2pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCHS8vnV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so15924381fa.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 19:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739848291; x=1740453091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGwBD2CFKUEGFcmXQk7UzQTdAax4FlaTNuTGP53zge0=;
        b=lCHS8vnVJisxNLpmYu/c5adI3cl3I8QApaXq9B+vuZ2rB+3kpNrJFTmqP5FLwPJt0a
         V9vPdlgfPtAQHgTLrxLRChguN4AziXNaBTwovT8rCaVIi4mBcdK6ZGo4xzaBJGeT8REn
         hhfBqQHjgQZmDvL/fvX5I9l/JRo7/zlrvi9LHhhr3MXvfpvPjVrcVUGtwNEaqHDBNdK9
         FNioYi8AFJQKFCIQxjnl7h3vbQW5glQ9Y7tb3gSmWVhUltbcL5749PZY79lym+SNRjAx
         ZdYGN09VH0lxlLmTMJT3aPn/Dk3hqIg3x9gUYaMHXKi9d88b7tPC8biIN2fTyhO3g38M
         rhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848291; x=1740453091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGwBD2CFKUEGFcmXQk7UzQTdAax4FlaTNuTGP53zge0=;
        b=J3t7KkSdwVX46nTkjSXsczuB2W4i4Z0QoeAYYAtkZsia1TOk8ZnPXjHjooSKi8PY7j
         tQzXTQdoZaVV4x7pkSKtEdF2GQE4lMAtv7eaAWTZCGw9qQVdW70nQXL9Qpqq27lpkqG9
         6XkawWapH8O5lerzH9vi5b3iowTiOrV/n5Gl/Brnse9nMQwq4mX0nafmYPmy4pPS3fVx
         cVdm0P5ufYpqxBla7r1FZJ545vH56XX1mMifQY8dfkCJ8LDD1ll2AbpHKpqMTlYPIMcU
         YEYuJnJVoWd9fP/0irwnh1+xbvOqGH+kXlby4Mx7hIeyKCLvHCAT93y1KvW3qHjX8uT8
         gPpw==
X-Forwarded-Encrypted: i=1; AJvYcCUxsIUZEJ+CFQM2AyN8GFZdzFBHqb4wuSoghcKtikfO+LtGfnIckvIGFQwlT67flgkWF3hmW0aT77A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0pVpiFyZihAeUGHUei5DK4UgpLkoBv0rMiwlOmErKQw66bWJ
	z32rtQSg+ArW0UuiRJR2NpcLJmIcspH/cV888aNqqNyh21L+aQRO45+WaJHrito=
X-Gm-Gg: ASbGncvZOtWlVWybeFFU9yPp5NK5A+5aJVUJWR6v4gumVSjQRkiSqZ0Ia/vIV6rLuBY
	23UjHFZniB3yGG2wTkxCTCagXjh9isTmbhpHqg8B9vijX4wuJrCAwMmd1cwUpht6QSu96KuHqTD
	iHELAd5b4qyIyv3o+aV2snOq9kTcZneTCAEjAtIP6Z8ES0RoHlQAEhx4VpF3sAtOioqXuquDon0
	749wLOeh92SEdvyLH4xa/lod+oa31K2gcVU4x3Gz2YE8tHkjCgx8Q22nH/LhbX1CGvgvDPT3jq9
	dtSqorjiWR6Kl9g8H5aXEtRgw1NKFx2qghaQ0CG6C8/BD5Hg2lIZW+9LAh2HWKok+Gq6uVs=
X-Google-Smtp-Source: AGHT+IEQMhncm0WXNWgmzEzOnsIe6cxTWRiyx7IxSOBKCLrORD4BXpH0JP8Q/iLmPhvhFsftBlGbKA==
X-Received: by 2002:a2e:9cd1:0:b0:308:eabd:2991 with SMTP id 38308e7fff4ca-30927a3a12fmr32101951fa.1.1739848290806;
        Mon, 17 Feb 2025 19:11:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30922dc69bdsm15315571fa.12.2025.02.17.19.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:11:29 -0800 (PST)
Date: Tue, 18 Feb 2025 05:11:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mrinmay Sarkar <quic_msarkar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sar2130p: add PCIe EP device nodes
Message-ID: <qafwztwsn3eiz76ot4ej7uv3ahprrri7u6x5jt3tvkx4j7xu34@5yeaj2d5a535>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
 <20250217-sar2130p-pci-v1-5-94b20ec70a14@linaro.org>
 <17aa47df-1daf-4ec2-8f6a-48c3bc375dd3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17aa47df-1daf-4ec2-8f6a-48c3bc375dd3@oss.qualcomm.com>

On Mon, Feb 17, 2025 at 08:23:28PM +0100, Konrad Dybcio wrote:
> On 17.02.2025 7:56 PM, Dmitry Baryshkov wrote:
> > On the Qualcomm AR2 Gen1 platform the second PCIe host can be used
> > either as an RC or as an EP device. Add device node for the PCIe EP.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sar2130p.dtsi | 53 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> > index dd832e6816be85817fd1ecc853f8d4c800826bc4..7f007fad6eceebac1b2a863d9f85f2ce3dfb926a 100644
> > --- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> > @@ -1474,6 +1474,59 @@ pcie@0 {
> >  			};
> >  		};
> >  
> > +		pcie1_ep: pcie-ep@1c08000 {
> > +			compatible = "qcom,sar2130p-pcie-ep";
> > +			reg = <0x0 0x01c08000 0x0 0x3000>,
> > +			      <0x0 0x40000000 0x0 0xf1d>,
> > +			      <0x0 0x40000f20 0x0 0xa8>,
> > +			      <0x0 0x40001000 0x0 0x1000>,
> > +			      <0x0 0x40200000 0x0 0x1000000>,
> > +			      <0x0 0x01c0b000 0x0 0x1000>,
> > +			      <0x0 0x40002000 0x0 0x2000>;
> > +			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> > +				    "mmio", "dma";
> 
> vertical list, please

Ack

> 
> > +
> > +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> > +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> > +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> > +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> > +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> > +				 <&gcc GCC_DDRSS_PCIE_SF_CLK>,
> > +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
> > +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_AHB_CLK>,
> > +				 <&gcc GCC_QMIP_PCIE_AHB_CLK>;
> 
> please make sure this one is actually required

Hmm, this one seems to be present in pcie0 and pcie1 RC, but in the EP
deivice (in the vendor DT). Are you saying that it is not used for the
EP? I think I just c&p'ed RC clocks here.

> 
> > +			clock-names = "aux",
> > +				      "cfg",
> > +				      "bus_master",
> > +				      "bus_slave",
> > +				      "slave_q2a",
> > +				      "ddrss_sf_tbu",
> > +				      "aggre_noc_axi",
> > +				      "cnoc_sf_axi",
> > +				      "qmip_pcie_ahb";
> > +
> > +			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "global", "doorbell", "dma";
> 
> and here

This is used for the eDMA implementation. Unlike the vendor kernel,
there is no separate device for eDMA.

> 
> > +
> > +			interconnects = <&pcie_noc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
> > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> > +					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ALWAYS>;
> 
> active-only

Ack.

> 
> 
> looks good otherwise
> 
> Konrad

-- 
With best wishes
Dmitry

