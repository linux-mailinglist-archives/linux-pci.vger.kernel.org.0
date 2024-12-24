Return-Path: <linux-pci+bounces-18996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856FE9FBB84
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 10:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A59C1886A48
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058CA1C5493;
	Tue, 24 Dec 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEkD8u1s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8411C3C13
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033638; cv=none; b=JpZxZ+d8AqKJl5rNYBviaiQMDLTA9g4t0fZ2BD76BSrqRJJIpmpuoJwLDzU9elcwMySXJv9OxXmNsJqr9Yo/JpwGvVBcIMCQghAiK0eZ3jB6r0ziOlSbDTmbBFd0KIj2tzJT0xOyDcsH0d4eRe3e9Wd3wy4BXePUPIn+EkXDP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033638; c=relaxed/simple;
	bh=nJL3cJklp23M/iHXZ6qUlbikuJoZmCHT94AfHfXf+TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRWbO11j8dn1/ELpc+8VXd2ehKgvpMuYyfq0rv78WxIIIEBGGvTdd5nwcurhQlcW3XKnhDpKe4daxlzL9GFi+SdK3qStj2lZA15ZaDH0g4aMLI6AODQY2hHIBLhqrGb6eBgopMPvOWqOmhxQj2yYYvZIh4bjFrKHPBgWyeOc6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEkD8u1s; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54025432becso5207989e87.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 01:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735033634; x=1735638434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICRWszIDYo7jhB4ldqyzBXZGTmMRp8M18Zu6d1SbJBc=;
        b=sEkD8u1sXWhH4Qy2i1wnPa2jcIkRieBB7Slqt+d1jZuDlOCfuXxt6p0v1uX2sq8QA8
         wDjMrIvWcaXjM6QxIUnC7seFEeGpTlsuXlwyHGsx7eYdWeru8msORYBSQoobZxN1bnHd
         aYfwIP+OZOB+TuYOY1ebVPMDdKfevIBfPkJn0rg7cPAZ+yOzcdSgmvOiQkKwnbTxkjwm
         7Bj/JXI6gV9s6x85P8pLerw0h/9PY4fTPX0+quk/eZ+se+uJk1lscai5U0mK6+VZhMP1
         upHA7KARbHnt2UadS9apLNIU/np4huXozgXVj4tdhg+6nPIvZSYGsmgiouj44nOa/vaN
         A/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735033634; x=1735638434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICRWszIDYo7jhB4ldqyzBXZGTmMRp8M18Zu6d1SbJBc=;
        b=TH8n1EHEI3wZecBrpSpP3IqemVXqtheqljBC/5rO409K8h9tEVYYe8D1s7ukMj9rSm
         5wqfd6FB9QXCJpGboFCL9k876/yEl/Tsy/uY3pJxuLyQlSKpcJhvY7Befjc2wYVS6QxX
         zBUMduEQUubHAaCjAZX6LUpRH2lb06AOvLSrRn7sW5hNfg+5jQEk9MV54rwKimmE9iIs
         0hGNY2mFqO3sapYh6co9Q1xGkhF8Gba9mE/CFm3F6Ny3VFC+kZwB4Vh74gsmUU1n/nlu
         +UAHnMZwYSpB/xIpDtDKuTdyjzePXQPVDv0pkFuvVa6wK1dAMFkGLSMP9tGU6rTT6SMn
         KQtA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Yh8crUVRCnbPdtICcFZthW863nZS/jVK58VkEz5EIwBCkj8HJTZJz94fsGoXC/KX24cDkfIvK2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGVTe+eRTXzDe0vID4pvARIhLcFSnLTWiIkDMZly3+L5dGd4r
	Jmi7hiT59rzBpDIXAL9IvMYJOwseqIcJCl1AA+v1kg2QRQl/RbnnmSbdok1uH/o=
X-Gm-Gg: ASbGnctpp9slMAYOuPJaTq1cDhnFqDLCAxjFTg6OFYiJqsbXhlH0jsnt5/q9hPxWEAx
	+n8byENNlrqXeSXaLuEmXWcgNadhOP3sR3sos8alDGJh/bHroB9y82/2+eGw1U9COyaZin9Z7KG
	QQ3pFWP9urVPIw1t7wUp2TwEzSQVlmJ/TDUZBjq+ZI4G0NDibjCMAaCXkFkzQsfv0mlBlDzBOdG
	3lUTTDjL5X0+WoUAiRM1pdPQ7Fso/b/cc0OKlgUu/GCkUpcskxCUxRThuBmRX9lp5bHxERwXtPX
	cdAwEv+OzDhGEYnglZJ7pS5Bbk4/UfzkXnvW
X-Google-Smtp-Source: AGHT+IGsFcFgssSv3Q/bbtU+QPMUs+pd8hc7ThLbPWbmORFNznEyed0S9iXPab6Bquw3SZf1Tbv+1w==
X-Received: by 2002:a05:6512:334e:b0:542:218a:343 with SMTP id 2adb3069b0e04-542295989femr4074133e87.52.1735033634465;
        Tue, 24 Dec 2024 01:47:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223830207sm1581792e87.251.2024.12.24.01.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:47:13 -0800 (PST)
Date: Tue, 24 Dec 2024 11:47:11 +0200
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
Message-ID: <hadsywppxfppeqqbqejuztrc3igg3mwmgdhpffxxyj4vnrowjh@uxtjywpipdig>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
 <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
 <kssmfrzgo7ljxveys4rh5wqyaottufhjsdjnro7k7h7e6fdgcl@i7tdpohtny2x>
 <9bcbbd2b-7fe9-d0ad-656a-f759b14a32dc@quicinc.com>
 <srts5hm5kvbu2k6fxtejuei7eo2fjvvhpxho2giskto3w3nvoh@iymonedukgrs>
 <a2d98705-adb5-e33a-5047-4635bda11355@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d98705-adb5-e33a-5047-4635bda11355@quicinc.com>

On Tue, Dec 24, 2024 at 02:39:17PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/24/2024 12:24 PM, Dmitry Baryshkov wrote:
> > On Tue, Dec 24, 2024 at 11:34:10AM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 12/24/2024 12:27 AM, Dmitry Baryshkov wrote:
> > > > On Sun, Nov 24, 2024 at 07:02:48AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > 
> > > > > 
> > > > > On 11/15/2024 9:48 PM, Rob Herring wrote:
> > > > > > On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
> > > > > > > Add binding describing the Qualcomm PCIe switch, QPS615,
> > > > > > > which provides Ethernet MAC integrated to the 3rd downstream port
> > > > > > > and two downstream PCIe ports.
> > > > > > > 
> > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > ---
> > > > > > >     .../devicetree/bindings/pci/qcom,qps615.yaml       | 205 +++++++++++++++++++++
> > > > > > >     1 file changed, 205 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..e6a63a0bb0f3
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> > > > > > > @@ -0,0 +1,205 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Qualcomm QPS615 PCIe switch
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
> > > > > > > +  ports. The 3rd downstream port has integrated endpoint device of
> > > > > > > +  Ethernet MAC. Other two downstream ports are supposed to connect
> > > > > > > +  to external device.
> > > > > > > +
> > > > > > > +  The QPS615 PCIe switch can be configured through I2C interface before
> > > > > > > +  PCIe link is established to change FTS, ASPM related entry delays,
> > > > > > > +  tx amplitude etc for better power efficiency and functionality.
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    enum:
> > > > > > > +      - pci1179,0623
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  i2c-parent:
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > > > +    description: |
> > > > > > 
> > > > > > Don't need '|' if no formatting to preserve.
> > > > > > 
> > > > > ack
> > > > > > > +      A phandle to the parent I2C node and the slave address of the device
> > > > > > > +      used to do configure qps615 to change FTS, tx amplitude etc.
> > > > > > > +    items:
> > > > > > > +      - description: Phandle to the I2C controller node
> > > > > > > +      - description: I2C slave address
> > > > > > > +
> > > > > > > +  vdd18-supply: true
> > > > > > > +
> > > > > > > +  vdd09-supply: true
> > > > > > > +
> > > > > > > +  vddc-supply: true
> > > > > > > +
> > > > > > > +  vddio1-supply: true
> > > > > > > +
> > > > > > > +  vddio2-supply: true
> > > > > > > +
> > > > > > > +  vddio18-supply: true
> > > > > > > +
> > > > > > > +  reset-gpios:
> > > > > > > +    maxItems: 1
> > > > > > > +    description:
> > > > > > > +      GPIO controlling the RESX# pin.
> > > > > > 
> > > > > > Is the PERST# or something else?
> > > > > > 
> > > > > it is not PERST GPIO, it is similar to PERST in terms
> > > > > of functionality which brings switch out from reset.
> > > > 
> > > > Do you have an actual PERST# on upstream facing port? Is it a separate
> > > > wire? Judging by the RB3 Gen2 this line is being used as PERST#
> > > > 
> > > we had PERST# as a separate line. It has two inputs one is PERST# &
> > > other one is RESX# gpio functionality wise both are similar.
> > 
> > I don't think I follow. Are you describing the QPS615 side or the SoC side?
> > 
> These are QPS615 side. it has both PERST# as per PCIe spec and RESX# which
> belongs to only qps615 to bring out of reset. There are two different GPIO
> lines.

Hmm, okay. I indeed see two pins, PCIE_RESET_N and RESX. PCIE_RESET_N is
described as "Reset for PCIe block", while RESX is "System reset input".
RESX should be lifted before PCIE_RESET_N during QPS615 power on.
If I understand correctly, the reset-gpios is a RESX pin, which is
controlled manually by the QPS driver. Is PERST# controlled by the DWC3
driver or by the DWC3 controller itself?

> > > > > > > +
> > > > > > > +  qps615,axi-clk-freq-hz:
> > > > > > 
> > > > > > qps615 is not a vendor prefix.
> > > > > > 
> > > > > > > +    description:
> > > > > > > +      AXI clock rate which is internal bus of the switch
> > > > > > > +      The switch only runs in two frequencies i.e 250MHz and 125MHz.
> > > > > > > +    enum: [125000000, 250000000]
> > > > > > > +
> > > > > > > +allOf:
> > > > > > > +  - $ref: "#/$defs/qps615-node"
> > > > > > > +
> > > > > > > +patternProperties:
> > > > > > > +  "@1?[0-9a-f](,[0-7])?$":
> > > > > > 
> > > > > > You have 3 ports. So isn't this fixed and limited to 0-2?
> > > > > > 
> > > > > sure I will change it to below as suggested
> > > > > "@1?[0-3](,[0-1])?$"
> > > > 
> > > > Why do you still need '1?' ?
> > > > 
> > > we want to represent integrated ethernet MAC also here and to represent it
> > > we need '1' as it is multi function device. I will update the
> > > description to reflect the same.
> > 
> > Note, I has asked about the '1?' part, not about the [0-1].
> > 
> > However as you've mentioned it, you are describing the first level
> > subnodes. Per your example, these subnodes are "pcie@1,0", "pcie@2,0"
> > and "pcie@3,0". Thus this patternProperties should have the regexp of
> > "^pcie@[1-3],0$". The multifunction devices for the ethernet node are
> > hidden under the pcie@3,0 and as such they are not being matched against
> > this regexp.
> > 
> ack. I will use as the suggested one.
> > > > > > > +    description: child nodes describing the internal downstream ports
> > > > > > > +      the qps615 switch.
> > > > > > 
> > > > > > Please be consistent with starting after the ':' or on the next line.
> > > > > > 
> > > > > > And start with capital C.
> > > > > > 
> > > > > > 
> > > > > ack
> > > > > 
> > > > > > > +    type: object
> > > > > > > +    $ref: "#/$defs/qps615-node"
> > > > > > > +    unevaluatedProperties: false
> > > > > > > +
> > > > > > > +$defs:
> > > > > > > +  qps615-node:
> > > > > > > +    type: object
> > > > > > > +
> > > > > > > +    properties:
> > > > > > > +      qcom,l0s-entry-delay-ns:
> > > > > > > +        description: Aspm l0s entry delay.
> > > > > > > +
> > > > > > > +      qcom,l1-entry-delay-ns:
> > > > > > > +        description: Aspm l1 entry delay.
> > > > > > 
> > > > > > These should probably be common being standard PCIe things. Though, why
> > > > > > are they needed? I'm sure the timing is defined by the PCIe spec, so
> > > > > > they are not compliant?
> > > > > > 
> > > > > Usually the firmware in the endpoints/switches should do this these
> > > > > configurations. But the qps615 PCIe switch doesn't have any firmware
> > > > > running to configure these. So the hardware exposes i2c interface to
> > > > > configure these before link training.
> > > > 
> > > > If they are following the standard, why do you need to have them in the
> > > > DT? Can you hardcode thos evalues in the driver?
> > > > 
> > > These values can be changed from platform to platform based upon the
> > > different power goals and latency requirements so we can't have hard coded
> > > values.
> > > 
> > > And even DWC controllers also provide provision to change these values
> > > currently we are not using them. As bjorn suggested if we move these to
> > > common pcie bindings these can be used in future by controller drivers also.
> > 
> > Ack
> > 
> > > > > > > +
> > > > > > > +      qcom,tx-amplitude-millivolt:
> > > > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +        description: Change Tx Margin setting for low power consumption.
> > > > > > > +
> > > > > > > +      qcom,no-dfe-support:
> > > > > > > +        type: boolean
> > > > > > > +        description: Disable DFE (Decision Feedback Equalizer), which mitigates
> > > > > > > +          intersymbol interference and some reflections caused by impedance mismatches.
> > > > > > > +
> > > > > > > +      qcom,nfts:
> > > > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +        description:
> > > > > > > +          Number of Fast Training Sequence (FTS) used during L0s to L0 exit
> > > > > > > +          for bit and Symbol lock.
> > > > > > 
> > > > > > Also something common.
> > > > > > 
> > > > > > The problem I have with all these properties is you are using them on
> > > > > > both the upstream and downstream sides of the PCIe links. They belong in
> > > > > > either the device's node (downstream) or the bus's node (upstream).
> > > > > > 
> > > > > This switch allows us to configure both upstream, downstream ports and
> > > > > also embedded Ethernet port which is internal to the switch. These
> > > > > properties are applicable for all of those.
> > > > > > > +
> > > > > > > +    allOf:
> > > > > > > +      - $ref: /schemas/pci/pci-bus.yaml#
> > > > > > 
> > > > > > pci-pci-bridge.yaml is more specific and closer to what this device is.
> > > > > > 
> > > > > I tried this now, I was getting warning saying the compatible
> > > > > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > > > > pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching the
> > > > > given schema
> > > > >           from schema $id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> > > > > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > > > > pcie@0,0: Unevaluated properties are not allowed ('#address-cells',
> > > > > '#size-cells', 'bus-range', 'device_type', 'ranges' were unexpected)
> > > > > 
> > > > > I think pci-pci-bridge is expecting the compatible string in this format
> > > > > only "pciclass,0604".
> > > > 
> > > > I think the pci-pci-bridge schema requires to have "pciclass,0604" among
> > > > other compatibles. So you should be able to do something like:
> > > > 
> > > > compatible = "pci1179,0623", "pciclass,0604";
> > > > 
> > > > At least if follows PCI Bus Binding to Open Firmware document.
> > > > 
> > > let us try this and come back.
> > > > > 
> > > > > > > +
> > > > > > > +unevaluatedProperties: false
> > > > > > > +
> > > > > > > +required:
> > > > > > > +  - vdd18-supply
> > > > > > > +  - vdd09-supply
> > > > > > > +  - vddc-supply
> > > > > > > +  - vddio1-supply
> > > > > > > +  - vddio2-supply
> > > > > > > +  - vddio18-supply
> > > > > > > +  - i2c-parent
> > > > > > > +  - reset-gpios
> > > > > > > +
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +
> > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > +
> > > > > > > +    pcie {
> > > > > > > +        #address-cells = <3>;
> > > > > > > +        #size-cells = <2>;
> > > > > > > +
> > > > > > > +        pcie@0 {
> > > > > > > +            device_type = "pci";
> > > > > > > +            reg = <0x0 0x0 0x0 0x0 0x0>;
> > > > > > > +
> > > > > > > +            #address-cells = <3>;
> > > > > > > +            #size-cells = <2>;
> > > > > > > +            ranges;
> > > > > > > +            bus-range = <0x01 0xff>;
> > > > > > > +
> > > > > > > +            pcie@0,0 {
> > > > > > > +                compatible = "pci1179,0623";
> > > > > > > +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > > > > > +                device_type = "pci";
> > > > > > > +                #address-cells = <3>;
> > > > > > > +                #size-cells = <2>;
> > > > > > > +                ranges;
> > > > > > > +                bus-range = <0x02 0xff>;
> > > > > > > +
> > > > > > > +                i2c-parent = <&qup_i2c 0x77>;
> > > > > > > +
> > > > > > > +                vdd18-supply = <&vdd>;
> > > > > > > +                vdd09-supply = <&vdd>;
> > > > > > > +                vddc-supply = <&vdd>;
> > > > > > > +                vddio1-supply = <&vdd>;
> > > > > > > +                vddio2-supply = <&vdd>;
> > > > > > > +                vddio18-supply = <&vdd>;
> > > > > > > +
> > > > > > > +                reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> > > > > > > +
> > > > > > > +                pcie@1,0 {
> > > > > > > +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
> > > > > > > +                    #address-cells = <3>;
> > > > > > > +                    #size-cells = <2>;
> > > > > > > +                    device_type = "pci";
> > > > > > > +                    ranges;
> > > > > > > +                    bus-range = <0x03 0xff>;
> > > > > > > +
> > > > > > > +                    qcom,no-dfe-support;
> > > > > > > +                };
> > > > > > > +
> > > > > > > +                pcie@2,0 {
> > > > > > > +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
> > > > > > > +                    #address-cells = <3>;
> > > > > > > +                    #size-cells = <2>;
> > > > > > > +                    device_type = "pci";
> > > > > > > +                    ranges;
> > > > > > > +                    bus-range = <0x04 0xff>;
> > > > > > > +
> > > > > > > +                    qcom,nfts = <10>;
> > > > > > > +                };
> > > > > > > +
> > > > > > > +                pcie@3,0 {
> > > > > > > +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
> > > > > > > +                    #address-cells = <3>;
> > > > > > > +                    #size-cells = <2>;
> > > > > > > +                    device_type = "pci";
> > > > > > > +                    ranges;
> > > > > > > +                    bus-range = <0x05 0xff>;
> > > > > > > +
> > > > > > > +                    qcom,tx-amplitude-millivolt = <10>;
> > > > > > > +                    pcie@0,0 {
> > > > > > > +                        reg = <0x50000 0x0 0x0 0x0 0x0>;
> > > > > > > +                        #address-cells = <3>;
> > > > > > > +                        #size-cells = <2>;
> > > > > > > +                        device_type = "pci";
> > > > > > 
> > > > > > There's a 2nd PCI-PCI bridge?
> > > > > This the embedded ethernet port which is as part of DSP3.
> > > > 
> > > > So is there an adidtional bus for that ethernet device?
> > > > 
> > > yes for ethernet it has aditional bus assigned.
> > > 
> > > > > 
> > > > > - Krishna Chaitanya.
> > > > > > 
> > > > > > > +                        ranges;
> > > > > > > +
> > > > > > > +                        qcom,l1-entry-delay-ns = <10>;
> > > > > > > +                    };
> > > > > > > +
> > > > > > > +                    pcie@0,1 {
> > > > > > > +                        reg = <0x50100 0x0 0x0 0x0 0x0>;
> > > > > > > +                        #address-cells = <3>;
> > > > > > > +                        #size-cells = <2>;
> > > > > > > +                        device_type = "pci";
> > > > > > > +                        ranges;
> > > > > > > +
> > > > > > > +                        qcom,l0s-entry-delay-ns = <10>;
> > > > > > > +                    };
> > > > 
> > > > What is this?
> > > > 
> > > Ethernet endpoint is a multi function device which has 2 functions
> > > This node represents 2nd node. I will update the description to
> > > reflect the same.
> > 
> > If this is an ethernet device, why does it have a name of pcie@? Per
> > bindings the pcie@ name should be used only for devices with the class
> > 0604. Whas is the PCI device class for those devices? I think ethernet@
> > (0200) should probably be the best fit, judgin by your description.
> > 
> These are PCIe Ethernet endpoints with base class 2 & subclass 2, I taught

Hmm, 0x0202 is reserved for FDDI devices. Has somebody been
over-creative or is it me missing a part of the PCIe spec?

> all the PCIe devices should start with pcie irrespective of the class, can
> you point us the binding you are referring to. I was referring to this https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-device.yaml#L23

These bindings do not fix $nodename. A quick search through the existing
DTs should have provided you with the list of the endpoint device node
names as used by the kernel, which contains more than just pcie@N,M.

As for the spec, see [1], Table 1 on page 15. It defines node names for
various PCI classes.

[1] https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

> 
> As this is a endpoint device, I will cross check once if we can represent
> here or not and get back on this.

Unless you have to configure those ports, you should be able to skip
them. From your DT example it is not clear which part is actually
configurable: pcie@3,0 or its subdevices: DT example contains extra
properties in all those nodes.

> 
> - Krishna Chaitanya.
> > > 
> > > - Krishna Chaitanya.
> > > 
> > > > > > > +                };
> > > > > > > +            };
> > > > > > > +        };
> > > > > > > +    };
> > > > > > > 
> > > > > > > -- 
> > > > > > > 2.34.1
> > > > > > > 
> > > > 
> > 

-- 
With best wishes
Dmitry

