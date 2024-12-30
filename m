Return-Path: <linux-pci+bounces-19099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843A9FE9DD
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFC03A12F8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8F15855E;
	Mon, 30 Dec 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UH8i+WlC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56255EAD0
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583425; cv=none; b=UGkjAX430BJOu/QfCVqME5VvKSAe8fdPsGfbktnQ2/J5g6TMtR1yGZXOeV+lt5f8/gmqyehtMv67RdSw/MA+eg+8VqOvO01bdW1ugL2UfXKib8X9IpkyURa34IgYrtUWLs0RmoiS9JCi6QEYNB8Nfl/wt36XvQfcHpoNzqQyvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583425; c=relaxed/simple;
	bh=7JX9o06TbMHFNUP4w+zeBdbxi1p2cny7zuKa+LHvM4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVgQA3HAMtmRwBHzncHqfhJin2Wq/cI7DAjqMTSkeC79WJyxJ/M6tGA5fjc530Kjx55OkAFlkUp8ae79oe0PbTlFVyBt6HVOB03Q6S+8L3BDVWd7YOZQFUX0erQtv0j3J9JJNkzbrRtGVuKbJ7t3inJqL/mpg8OZT8bu+9c/JoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UH8i+WlC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so11318946e87.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735583421; x=1736188221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rK5QxsLLWnIEghDw8cOGxxcQrQQt27mtz5MyxCeBKUs=;
        b=UH8i+WlCwn7wyOF1hRIRB7S23dxhI/Vqyu1o6rQCXSVeJb4vxhwsCcZth4OYWqR9O4
         iuSraVny/w1WR4OvNWirxVGYmHXB3CWGnj2Mp8Egik67LFZ4NB8ufwOXcHs1kH5ZYnMH
         2TqH1qLpPPCjh3r8uteNp8KHCPnIsi354FpOjctminYk5Ezu0m3+ukewDoKbiAOPfaLR
         OH2F9wCy43kPWqmmh2XAd9+cXNa59UkwDxn5+tG3MwEbP8dVKHAdpVT6z93TA33adKYC
         Kth77zUKAScuS3UCIpUecLCb0uyUrQ/9EVeRiDyUeI2ZLEaOvDHza0601Jjlj7/Rw1YK
         zXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735583421; x=1736188221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK5QxsLLWnIEghDw8cOGxxcQrQQt27mtz5MyxCeBKUs=;
        b=qvc5EPgqZax9uMMaZzt9WviqfETss03gsV8W+MeDx41Rzaqey3OHU1WivmhGM591Tn
         Hd8w5s9UD+k22sqkN+mTOJhyULl3bLSvEeOhXsJkzPOLZ47PlJiOXIoqUBzMS8W4Gvwc
         ibKSANB2iQk7bWesS1FprPjsedbXDOA0VzkSbM4zda1i8gw7pAcYeoLOv6ApYGHMRfHH
         1LNdUhckq8kqa1qmtSKOVaqfVT+ozZ4IZlHNNyIyOkaprtlaDxvXLb+ExU9UBwS75xKh
         NGJbsEcCnuOwTXZeZqvWdNNCSoJTR66K2k7XP/QhFpvjhjYECX8DM4IVvUkGaRPrh39i
         SzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6oG6w66zjv5usPAYauvIVop2/bUKZtbWhribrMkVM76ojkv7kqGpoocg9j088GeWLukX1ba6/lc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4NbR1D+ridd3aJxyFVi4qGw7SDigsLjLVLGuJojfDhIv8gVg
	/cQBpj1dETduf4afj6D2ZugXQXlUK+LxmC6gXcnqVAD17lgu2AN2UK+bevtvHkk=
X-Gm-Gg: ASbGncuMiMbpPADtlQM87joOXGpLv+FyiBwy1eJ+MjNF6EQ8BWKD/zp+Wmx8vU804Q2
	4B7MISBLegdUUiaefma+o39dYGGOX41FT8KFgr2yjpG/8QDsrvfDhMbjmq+vEcUH3XpbGTDVxMn
	xPRyApamH13TasISwh+IhQKaGDDhK4JOtAyn5dx+J+sO2ZMOxHz8T9s0jMtZPyYjePcRvdiaHf+
	nSRSvxgMa+X/X0mw/XQ9YRcKr3pG2TItU3ZLv26Gn/ZomWqpfXzp70xRlOr9rN+HpEEyQeijkcg
	zlj2r5zxUkC656yV+YDNb3ygz4giUgfB1Csy
X-Google-Smtp-Source: AGHT+IHEy5ZvHN/N2d3LnFR4bWe0guhklfA0XrjVHjpOfGy3NBjZ2MFOtJWVN0e0n29HAkkbBgH/Zw==
X-Received: by 2002:a05:6512:1096:b0:542:23a9:bd30 with SMTP id 2adb3069b0e04-542294509e4mr11259843e87.14.1735583421266;
        Mon, 30 Dec 2024 10:30:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5422382fa79sm3175423e87.230.2024.12.30.10.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 10:30:19 -0800 (PST)
Date: Mon, 30 Dec 2024 20:30:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, andersson@kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <gtghhopugyciqrbhk3pe4gsrujp6wq7escuc3ztqxlbhngaq3e@shfa77ancu22>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
 <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
 <kssmfrzgo7ljxveys4rh5wqyaottufhjsdjnro7k7h7e6fdgcl@i7tdpohtny2x>
 <97c4f884-8915-a919-d565-cf6e9f83d2e4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c4f884-8915-a919-d565-cf6e9f83d2e4@quicinc.com>

On Fri, Dec 27, 2024 at 07:44:49AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/24/2024 12:27 AM, Dmitry Baryshkov wrote:
> > On Sun, Nov 24, 2024 at 07:02:48AM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 11/15/2024 9:48 PM, Rob Herring wrote:
> > > > On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
> > > > > Add binding describing the Qualcomm PCIe switch, QPS615,
> > > > > which provides Ethernet MAC integrated to the 3rd downstream port
> > > > > and two downstream PCIe ports.
> > > > > 
> > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > ---
> > > > >    .../devicetree/bindings/pci/qcom,qps615.yaml       | 205 +++++++++++++++++++++
> > > > >    1 file changed, 205 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..e6a63a0bb0f3
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> > > > > @@ -0,0 +1,205 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Qualcomm QPS615 PCIe switch
> > > > > +
> > > > > +maintainers:
> > > > > +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > +
> > > > > +description: |
> > > > > +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
> > > > > +  ports. The 3rd downstream port has integrated endpoint device of
> > > > > +  Ethernet MAC. Other two downstream ports are supposed to connect
> > > > > +  to external device.
> > > > > +
> > > > > +  The QPS615 PCIe switch can be configured through I2C interface before
> > > > > +  PCIe link is established to change FTS, ASPM related entry delays,
> > > > > +  tx amplitude etc for better power efficiency and functionality.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - pci1179,0623
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  i2c-parent:
> > > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > +    description: |
> > > > 
> > > > Don't need '|' if no formatting to preserve.
> > > > 
> > > ack
> > > > > +      A phandle to the parent I2C node and the slave address of the device
> > > > > +      used to do configure qps615 to change FTS, tx amplitude etc.
> > > > > +    items:
> > > > > +      - description: Phandle to the I2C controller node
> > > > > +      - description: I2C slave address
> > > > > +
> > > > > +  vdd18-supply: true
> > > > > +
> > > > > +  vdd09-supply: true
> > > > > +
> > > > > +  vddc-supply: true
> > > > > +
> > > > > +  vddio1-supply: true
> > > > > +
> > > > > +  vddio2-supply: true
> > > > > +
> > > > > +  vddio18-supply: true
> > > > > +
> > > > > +  reset-gpios:
> > > > > +    maxItems: 1
> > > > > +    description:
> > > > > +      GPIO controlling the RESX# pin.
> > > > 
> > > > Is the PERST# or something else?
> > > > 
> > > it is not PERST GPIO, it is similar to PERST in terms
> > > of functionality which brings switch out from reset.
> > 
> > Do you have an actual PERST# on upstream facing port? Is it a separate
> > wire? Judging by the RB3 Gen2 this line is being used as PERST#
> > 
> > > > > +
> > > > > +  qps615,axi-clk-freq-hz:
> > > > 
> > > > qps615 is not a vendor prefix.
> > > > 
> > > > > +    description:
> > > > > +      AXI clock rate which is internal bus of the switch
> > > > > +      The switch only runs in two frequencies i.e 250MHz and 125MHz.
> > > > > +    enum: [125000000, 250000000]
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: "#/$defs/qps615-node"
> > > > > +
> > > > > +patternProperties:
> > > > > +  "@1?[0-9a-f](,[0-7])?$":
> > > > 
> > > > You have 3 ports. So isn't this fixed and limited to 0-2?
> > > > 
> > > sure I will change it to below as suggested
> > > "@1?[0-3](,[0-1])?$"
> > 
> > Why do you still need '1?' ?
> > 
> > > > > +    description: child nodes describing the internal downstream ports
> > > > > +      the qps615 switch.
> > > > 
> > > > Please be consistent with starting after the ':' or on the next line.
> > > > 
> > > > And start with capital C.
> > > > 
> > > > 
> > > ack
> > > 
> > > > > +    type: object
> > > > > +    $ref: "#/$defs/qps615-node"
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > > +$defs:
> > > > > +  qps615-node:
> > > > > +    type: object
> > > > > +
> > > > > +    properties:
> > > > > +      qcom,l0s-entry-delay-ns:
> > > > > +        description: Aspm l0s entry delay.
> > > > > +
> > > > > +      qcom,l1-entry-delay-ns:
> > > > > +        description: Aspm l1 entry delay.
> > > > 
> > > > These should probably be common being standard PCIe things. Though, why
> > > > are they needed? I'm sure the timing is defined by the PCIe spec, so
> > > > they are not compliant?
> > > > 
> > > Usually the firmware in the endpoints/switches should do this these
> > > configurations. But the qps615 PCIe switch doesn't have any firmware
> > > running to configure these. So the hardware exposes i2c interface to
> > > configure these before link training.
> > 
> > If they are following the standard, why do you need to have them in the
> > DT? Can you hardcode thos evalues in the driver?
> > 
> > > > > +
> > > > > +      qcom,tx-amplitude-millivolt:
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        description: Change Tx Margin setting for low power consumption.
> > > > > +
> > > > > +      qcom,no-dfe-support:
> > > > > +        type: boolean
> > > > > +        description: Disable DFE (Decision Feedback Equalizer), which mitigates
> > > > > +          intersymbol interference and some reflections caused by impedance mismatches.
> > > > > +
> > > > > +      qcom,nfts:
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        description:
> > > > > +          Number of Fast Training Sequence (FTS) used during L0s to L0 exit
> > > > > +          for bit and Symbol lock.
> > > > 
> > > > Also something common.
> > > > 
> > > > The problem I have with all these properties is you are using them on
> > > > both the upstream and downstream sides of the PCIe links. They belong in
> > > > either the device's node (downstream) or the bus's node (upstream).
> > > > 
> > > This switch allows us to configure both upstream, downstream ports and
> > > also embedded Ethernet port which is internal to the switch. These
> > > properties are applicable for all of those.
> > > > > +
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/pci/pci-bus.yaml#
> > > > 
> > > > pci-pci-bridge.yaml is more specific and closer to what this device is.
> > > > 
> > > I tried this now, I was getting warning saying the compatible
> > > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > > pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching the
> > > given schema
> > >          from schema $id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> > > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > > pcie@0,0: Unevaluated properties are not allowed ('#address-cells',
> > > '#size-cells', 'bus-range', 'device_type', 'ranges' were unexpected)
> > > 
> > > I think pci-pci-bridge is expecting the compatible string in this format
> > > only "pciclass,0604".
> > 
> > I think the pci-pci-bridge schema requires to have "pciclass,0604" among
> > other compatibles. So you should be able to do something like:
> > 
> > compatible = "pci1179,0623", "pciclass,0604";
> > 
> > At least if follows PCI Bus Binding to Open Firmware document.
> > 
> There is a slot driver which is using this pciclass,0604 can we use
> still the suggested way.

The suggested way is to describe devices properly.

> 
> https://lore.kernel.org/linux-pci/20241210-pci-pwrctrl-slot-v1-4-eae45e488040@linaro.org/

-- 
With best wishes
Dmitry

