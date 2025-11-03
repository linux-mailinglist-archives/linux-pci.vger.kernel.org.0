Return-Path: <linux-pci+bounces-40097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A17C2AF08
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1C13B20F5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767042ED853;
	Mon,  3 Nov 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI+/sVQ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941F19309C;
	Mon,  3 Nov 2025 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164790; cv=none; b=rY71Fmqjvqnj5TQ9rhliBkvzEO9NNHOKdYGggw4ByhPBFjm6WxrKCvjCzLz8/sTzEL5apP9PKWiRjar2+22jxTB5aynJ2A5Xni4UYK1Vzwi5S8KAGILlJMgDY7xXpmA0l5HevRuf1L3/dYdvSWrNG6AVuwowR9oGwpJERvowkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164790; c=relaxed/simple;
	bh=3HvSwd3Hdi/gWECtVw0p3KFzqcxgB2PNYUbt+Yyqiyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL17AY7l591OG+qnZTODdIxn8BoyZQiAm8R6lJXkHJzg7W/NOJf3RlHy/P+jKgJY83Req/T7+GMwGs7KXL52nEFcxnR6Vpdgi1IbaYCQQojf9Nb+bSbFHm1GZxam9Q+fLZwMYr3es5dnwr6fowdZiwifBLRsS/Lu61d2N+KVPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI+/sVQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCD2C4CEE7;
	Mon,  3 Nov 2025 10:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762164788;
	bh=3HvSwd3Hdi/gWECtVw0p3KFzqcxgB2PNYUbt+Yyqiyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI+/sVQ9SlsH4jxh7ldDJPSzl9u1cyTsFagb7+gvmUh4ExL/zDq0bf1Gbvmp5sPSx
	 PxOyHzDt9E/jVv2OmRkPvGEqzu1k2oujSXANHPm55HKlbab005K9610paGE/jgx9TW
	 M6hQTPI06hlYMNQX/ikArLJ0f1JHblDl5xEcz9EXYY7E798ASikJD+vbmD2II+gdxg
	 PBGbA1BQfNdMFMtvDfCgz/DPrYIJFUoPL1O4ODwd2uR7tdRhknbXeVXvi5vkO2eNxI
	 q0s58Y/m24NQnWTfX5sgkHF3IP/b2lDmSmuoX9GhlxwpFYy386TOHtXf9vpc/W15tl
	 h9byOjeJtFrUQ==
Date: Mon, 3 Nov 2025 15:42:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Andrew Murray <amurray@thegoodpenguin.co.uk>, 
	Jingoo Han <jingoohan1@gmail.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
Message-ID: <rguwscxck7vel3hjdd2hlkypzdbwdvafdryxtz5benweduh4eg@sny4rr2nx5aq>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
 <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>

On Mon, Nov 03, 2025 at 10:47:36AM +0100, Neil Armstrong wrote:
> Hi Mani,
> 
> On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> > Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
> > have region for DWC controllers as it has the Root Port and controller
> > specific registers, while ELBI has optional registers.
> > 
> > Hence, fix the binding. Though this is an ABI break, this change is needed
> > to accurately describe the PCI memory map.
> 
> Not fan of this ABI break, the current bindings should be marked as deprecated instead.
> 

Fair enough. Will make it as deprecated.

- Mani

> > 
> > Fixes: 7cd210391101 ("dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> > index 79a21ba0f9fd62804ba95fe8a6cc3252cf652197..c8258ef4032834d87cf3160ffd1d93812801b62a 100644
> > --- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
> > @@ -36,13 +36,13 @@ properties:
> >     reg:
> >       items:
> > -      - description: External local bus interface registers
> > +      - description: Data Bus Interface registers
> >         - description: Meson designed configuration registers
> >         - description: PCIe configuration space
> >     reg-names:
> >       items:
> > -      - const: elbi
> > +      - const: dbi
> >         - const: cfg
> >         - const: config
> > @@ -113,7 +113,7 @@ examples:
> >       pcie: pcie@f9800000 {
> >           compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> >           reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
> > -        reg-names = "elbi", "cfg", "config";
> > +        reg-names = "dbi", "cfg", "config";
> >           interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> >           clocks = <&pclk>, <&clk_port>, <&clk_phy>;
> >           clock-names = "pclk", "port", "general";
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

