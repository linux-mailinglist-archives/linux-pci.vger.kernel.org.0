Return-Path: <linux-pci+bounces-6505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6468AC4D9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 09:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B55282D78
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F124C62A;
	Mon, 22 Apr 2024 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kmk7u3Cl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8C4AEEA
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769874; cv=none; b=UIiU3ksOG91sJQ/ifWwsfZoklAQinLsdWfaIwGVsKmwTSeCYmnAQn/Et+T6jicLEZ5nFHwJL9y8gnw5qFEu4+ZJm2LT6FJvb5tNkmLfwfQU7rY01YsEgNKw0UwFF56ok15lc78WCtlOL+WK2c5dU3Q1My5U06kK5QNAMC+o02EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769874; c=relaxed/simple;
	bh=qsL9k/zxg1aShoZ3afvsL1pBaxYHnpQV83bKqr0tqms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2qf5BmpSLA1cn20zs5lfaEqxMLzhXGzSaJzCl9yEviaDXtjRsFq15FVnFrqBQKV4xTPJMAf8Zko6vvgvopx+SQgBeHLaVj7elpHs/64VFchyJV3XhLM6xV8TX327b6u/kb9m+Qc04z04CZMYLv9rQugk5IGzk2MgMpQ3ZZQwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kmk7u3Cl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a78c2e253aso3132232a91.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713769872; x=1714374672; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=srhD1f3QgnLQ0Obmx96JcKyYrS05l+ud2rJYIQaibGI=;
        b=Kmk7u3ClY/5rq4TKnx3GBwnarqfnDjg+buG8W2cpfSMMVrcMW0SzvMc8ZKlBHfzebH
         yGCnhbifQG3x0DX8OS394LN6cnsE9H4fK7OYk/LWv+XSMa9sEXEdWb10/HvmajZfh++i
         slNq6h72oNv4vqVYaHhI36B043A5+5UDzb9BCwiURX11S/qa/7LRzFdgKvUMQE/23vJL
         txwje7LSv/a0qr/1NGlrse/yZSnJKYtzHbV8CRx4YOdcgSFpp14O1CceWb53QaPazIMz
         AFu0TkyCjY/wbIxGzC4uvMfL+lmPykmu9PLfMhCZ+Uz2siHSeRtJbaKlzjLmBO0uUUpZ
         ChyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713769872; x=1714374672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srhD1f3QgnLQ0Obmx96JcKyYrS05l+ud2rJYIQaibGI=;
        b=ttrzkjz4cZz5H+6Sf9M4IvteXSiSv4Q4xWw5p6yS8HOEI6x0Jk31z6pdGkVQrPxQ2a
         V2aIvXFT3GbG+EeU+MNySi6d1O08y/lekYUScMhb7Zk5c5G7MIltC5DR3CVglSSie5Hz
         mhUxC/8G8Aa5vvCFHMsTnAzYBHjDLsqrvWg8gADy/xwXqpMlkTimP6mfl/ApDD5vCMUy
         o2HunDSSBoJqcInou50/sqBUsTF+9mV+mz2yAvDVcH/aso2s5LO3SXztbbaoDzKBWj70
         tNT3MDrkIJzTXTARiplrqkOFfgCgENqWPC5hoecdloX91oP4MY68oe494CBFpuYtUNk7
         BIpg==
X-Forwarded-Encrypted: i=1; AJvYcCWiz8feCmwmg5YCHJZxo2eCou/A/Yyem1Mu9XoauAUdMC71cZ/tE8tBgrFoINtUCPEdte6SGe9K2HsSj1JsbVKidv1kLoDVjmIj
X-Gm-Message-State: AOJu0YyR8ob79YRdlULXvRJvQ5RmWrc0uUGwLVbukM8MIFeMwzlWKUR4
	zkaR5i1VZLlxCl4Bgrt8EOmK+uI2R+V5hrwoasrltPaTSyxgnAda29fLV/2Apw==
X-Google-Smtp-Source: AGHT+IHblHBOn1TM0hV6bpSsRhCl+tpVy4vTceVMjNfVKOdq9LBxmBqhZhlGl/7orl05cqYH7jy1KQ==
X-Received: by 2002:a17:90a:de02:b0:2a5:275c:ed with SMTP id m2-20020a17090ade0200b002a5275c00edmr8331950pjv.23.1713769871982;
        Mon, 22 Apr 2024 00:11:11 -0700 (PDT)
Received: from thinkpad ([120.60.70.118])
        by smtp.gmail.com with ESMTPSA id fu4-20020a17090ad18400b002acfe00c742sm3431669pjb.21.2024.04.22.00.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:11:11 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:40:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mr.nuke.me@gmail.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: ipq9574: add PCIe2 nodes
Message-ID: <20240422071054.GA9522@thinkpad>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-8-mr.nuke.me@gmail.com>
 <20240417073412.GD3894@thinkpad>
 <e8957b07-692f-7d38-e276-b0e3791d31f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8957b07-692f-7d38-e276-b0e3791d31f4@gmail.com>

On Thu, Apr 18, 2024 at 10:33:23AM -0500, mr.nuke.me@gmail.com wrote:
> 
> 
> On 4/17/24 02:34, Manivannan Sadhasivam wrote:
> > On Mon, Apr 15, 2024 at 01:20:52PM -0500, Alexandru Gagniuc wrote:
> > > On ipq9574, there are 4 PCIe controllers. Describe the pcie2 node, and
> > > its PHY in devicetree.
> > > 
> > > Only pcie2 is described, because only hardware using that controller
> > > was available for testing.
> > > 
> > 
> > You should describe all the instances in DT. Since the unused ones will be
> > 'disabled', it won't affect anyone.
> 
> My concern with untested but "disabled" descriptions is that someone may
> think it's supported, try to enable it on their board, and run into issues.
> Theoretically, we could describe pcie3, as it uses the same gen3x2 phy.
> 

Okay.

> The pcie0 and pcie1 use a gen3x1 phy, which I do not support in this series.
> I would have to leave the "phys" and "phy-names" for these nodes, leading to
> an incomplete description
> 

Fine then. Please describe at least pcie3. Also add a TODO above the first pcie
node mentioning that someone need to populate others too.

- Mani

> Given this info, do you still wish that I add all other pcie nodes?
> 
> > > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 93 ++++++++++++++++++++++++++-
> > >   1 file changed, 92 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > > index 7f2e5cbf3bbb..f075e2715300 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > > @@ -300,7 +300,7 @@ gcc: clock-controller@1800000 {
> > >   				 <0>,
> > >   				 <0>,
> > >   				 <0>,
> > > -				 <0>,
> > > +				 <&pcie2_phy>,
> > >   				 <0>,
> > >   				 <0>;
> > >   			#clock-cells = <1>;
> > > @@ -745,6 +745,97 @@ frame@b128000 {
> > >   				status = "disabled";
> > >   			};
> > >   		};
> > > +
> > > +		pcie2_phy: phy@8c000 {
> > > +			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> > > +			reg = <0x0008c000 0x14f4>;
> > > +
> > > +			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
> > > +				 <&gcc GCC_PCIE2_AHB_CLK>,
> > > +				 <&gcc GCC_PCIE2_PIPE_CLK>,
> > > +				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
> > > +				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
> > > +			clock-names = "aux",
> > > +				      "cfg_ahb",
> > > +				      "pipe",
> > > +				      "anoc",
> > > +				      "snoc";
> > > +
> > > +			clock-output-names = "pcie_phy2_pipe_clk";
> > > +			#clock-cells = <0>;
> > > +			#phy-cells = <0>;
> > > +
> > > +			resets = <&gcc GCC_PCIE2_PHY_BCR>,
> > > +				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
> > > +			reset-names = "phy",
> > > +				      "common";
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		pcie2: pcie@20000000 {
> > > +			compatible = "qcom,pcie-ipq9574";
> > > +			reg = <0x20000000 0xf1d>,
> > > +			      <0x20000f20 0xa8>,
> > > +			      <0x20001000 0x1000>,
> > > +			      <0x00088000 0x4000>,
> > > +			      <0x20100000 0x1000>;
> > > +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> > > +
> > > +			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,	/* I/O */
> > 
> > Please use below range:
> > 
> > <0x01000000 0x0 0x00000000 0x20200000 0x0 0x00100000>
> > <0x02000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>
> > 
> Of course, thank you.
> 
> > > +				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;	/* MEM */
> > > +
> > > +			device_type = "pci";
> > > +			linux,pci-domain = <3>;
> > > +			bus-range = <0x00 0xff>;
> > > +			num-lanes = <2>;
> > > +			max-link-speed = <3>;
> > > +			#address-cells = <3>;
> > > +			#size-cells = <2>;
> > > +
> > > +			phys = <&pcie2_phy>;
> > > +			phy-names = "pciephy";
> > > +
> > > +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-names = "msi";
> > > +
> > > +			#interrupt-cells = <1>;
> > > +			interrupt-map-mask = <0 0 0 0x7>;
> > > +			interrupt-map = <0 0 0 1 &intc 0 0 164
> > > +					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> > > +					<0 0 0 2 &intc 0 0 165
> > > +					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > > +					<0 0 0 3 &intc 0 0 186
> > > +					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> > > +					<0 0 0 4 &intc 0 0 187
> > > +					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> > 
> > Use a single line for each INTX entry even if it exceeds 80 column width.
> 
> Yes. Will do.
> 
> > - Mani
> > 

-- 
மணிவண்ணன் சதாசிவம்

