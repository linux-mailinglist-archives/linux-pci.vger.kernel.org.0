Return-Path: <linux-pci+bounces-27147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC23AA920C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 13:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7259F3AE6B0
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84011202F83;
	Mon,  5 May 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eTZJc3OQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423C201116
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444512; cv=none; b=Ol7N4fB5sJeyWQF6u80BoqHuuEy99fFNPv9CTcVxwbKLws/4wi74tpuY+QnTd5X6uLcVMMl2cMv1RAs05slBf5Wp3ENX4YQIoQq23n/VmlF3LFRCnk7+NZG2zOYNsMCQ1FSlMMLhYHWGmLkWVYh3BiT5RHAmDi3qpONoXgGIP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444512; c=relaxed/simple;
	bh=fozcw/cPzDCRQYDoH/cphECQbWBs/UYkwW7QVUbB8js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9aEanY/fD1fFJBOjhVz/vhc5iGn4Wh9PAnBO8IDClEEs3OwNGfhVjVdHty5WGOPZCyReAyAIad4q/l/gcsW92vwYQLW6tFaPrNLr04DMB0qSfxGKtWrNKqLdSV+gheLwtYjanE+/1uRyIqm+yWjt74glXNE1g+xOqi9pWGWkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eTZJc3OQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acae7e7587dso687117066b.2
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746444509; x=1747049309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aB3cMr3JDp0nKZr8OwsHEx3We5XLotlduuz1352Eao4=;
        b=eTZJc3OQPMj7DocRX3Tt8i2/6sbj6z2miUhjFkXj04/Om61jg2DT7Zr6Jg2jf++EZe
         kWMz9+OtS/v02i1chVzzI3i8/K52U+txzz5cJGKgtVRv/3AnSkPNuBcjzYTo5nJqD7dy
         dBSm9p3iFS8Krq2nW5TzhYOFTPckgYX2yguj4fY9DZs27MuKc8fp8+SpqJwgz+JJSHeu
         tyCLBcMecAgOfybpELIL2+vkdYN/BFQieuBKnnTYeXzNj7BRGCZCuQRE+8fEC5y+aDXB
         LKH/IK6cVeGe0krbIu3e21nj7SBGRcvllDZmS4AeujDYeN4ddvnzTEtIf/6pMk4MZL51
         +mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746444509; x=1747049309;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aB3cMr3JDp0nKZr8OwsHEx3We5XLotlduuz1352Eao4=;
        b=C8uEwapak0DjG/dSlcFAgwd2tzq30INjWn3x5IbpF1rEJOvVf0s/dHsqPWIta7REvX
         8RcpGcG9OcCK1D4yiHH+rbCR3obtC7hMZan//NIAWFhOvA5iP5d5wFYhVdE3jFxkRmMs
         jZg+l4SR5COK9SuEGng/kh/ajp5JYlyF2josXwRSVxaw+Q7jxGEyUovBWtinLeP9Uvnh
         DS5koxLhFk9c+s5GnUhO1kjvX4ocntaug34f/2Jy/+3NUoIcFhP4AyQ1WcY05kr232rm
         qjVslTocftf6oT1WxfotT/kZPE3602msOeASvczIv2TvYyJr8C3XS3pRpsRxu6fsIzIe
         27YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGbSPeuZ2UgLd11k8H+72i3c644g6W1OXY4D6IuuyF7ohcfk5p2cuMXPsLM2wg6+yg0LlB+/uiFJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RsC55iZtuuNeGn1ykUl0GMTN1yYbk5dM+DuwAd2VpV96tZfh
	RNhUor2gZPH5mOO1j9e2FF4huY+/WZYQSQsIUQVGCOCkXTZrhkiAVC9OtYgnDQU=
X-Gm-Gg: ASbGnctQDQcE8Ld9ecnQdxMz9m4fRGBV4Nv91wEo5KOQsyHhSZpNw5dy/VytMuazhXs
	DSiIPg9BzTLCDVglcfqjQX7mUSJ+tbOVwy8Dze2a+DDjtaAcsF/nyocNh315qvRv5JtbuWP6AKk
	3iBY/SNy87meGX4TQ3HkhgUdng4RJYF9Eb+JpUcXLmXvabEhh2aDbe4dsOFNnBCdhBsgJKRONnG
	OED6iZdh0NctRptEZ+Ttz/Tz5QX20FOrdf3auAqV2gii31Xk9bQ+9BI0aDlAXZ3r6CwgwTdHDrc
	bmNYVR7jaHDOamR+82grXLHRyJw5OsRRLdCqXxrT/J0cGUUUeXhGMRsxjYgS
X-Google-Smtp-Source: AGHT+IGvEp3fdacUme4FWMSlQbtpUEv8ay4IyBgw8S68wSBoAmf9cWSX9tpMSyCX12ZWHunmUEvARQ==
X-Received: by 2002:a17:907:3e09:b0:ace:c43a:63e9 with SMTP id a640c23a62f3a-ad1a4a8d7dfmr571983666b.42.1746444508643;
        Mon, 05 May 2025 04:28:28 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad18914733esm476716866b.33.2025.05.05.04.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 04:28:28 -0700 (PDT)
Message-ID: <542674b6-bdcf-4149-99b4-a5568745eabd@tuxon.dev>
Date: Mon, 5 May 2025 14:28:26 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org, saravanak@google.com,
 p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250501201636.GA776341@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250501201636.GA776341@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 01.05.2025 23:16, Bjorn Helgaas wrote:
> On Wed, Apr 30, 2025 at 01:32:32PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
>> Base Specification 4.0. It is designed for root complex applications and
>> features a single-lane (x1) implementation. Add documentation for it.
>> The interrupts, interrupt-names, resets, reset-names, clocks, clock-names
>> description were obtained from the hardware manual.
> 
>> +        pcie@11e40000 {
>> +            compatible = "renesas,r9a08g045s33-pcie";
>> +            reg = <0 0x11e40000 0 0x10000>;
>> +            ranges = <0x03000000 0 0x30000000 0 0x30000000 0 0x8000000>;
>> +            dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x8000000>;
>> +            bus-range = <0x0 0xff>;
>> +            clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
>> +                     <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
>> +            clock-names = "aclk", "clkl1pm";
>> +            resets = <&cpg R9A08G045_PCI_ARESETN>,
>> +                     <&cpg R9A08G045_PCI_RST_B>,
>> +                     <&cpg R9A08G045_PCI_RST_GP_B>,
>> +                     <&cpg R9A08G045_PCI_RST_PS_B>,
>> +                     <&cpg R9A08G045_PCI_RST_RSM_B>,
>> +                     <&cpg R9A08G045_PCI_RST_CFG_B>,
>> +                     <&cpg R9A08G045_PCI_RST_LOAD_B>;
>> +            reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
>> +                          "rst_rsm_b", "rst_cfg_b", "rst_load_b";
> 
> Could this be structured in a way that separates the shared Root
> Complex properties from the ones that are specific to the Root Port?
> I know the current hardware only supports a single Root Port, but I
> think we should plan to be able to support multiple Root Ports.

I'm not sure how should I do this. These are just the reset signals as the
manual describes them. Can you, please, point me an example driver/device
tree that I could check?

Thank you for your review,
Claudiu

> 
>> +            interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "int_serr", "int_serr_cor", "int_serr_nonfatal",
>> +                              "int_serr_fatal", "axi_err_int", "inta_rc",
>> +                              "intb_rc", "intc_rc", "intd_rc",
>> +                              "intmsi_rc", "int_link_bandwidth", "int_pm_pme",
>> +                              "dma_int", "pcie_evt_int", "msg_int",
>> +                              "int_all";
>> +            #interrupt-cells = <1>;
>> +            interrupt-map-mask = <0 0 0 7>;
>> +            interrupt-map = <0 0 0 1 &pcie_intx 0>, /* INT A */
>> +                            <0 0 0 2 &pcie_intx 1>, /* INT B */
>> +                            <0 0 0 3 &pcie_intx 2>, /* INT C */
>> +                            <0 0 0 4 &pcie_intx 3>; /* INT D */
>> +            device_type = "pci";
>> +            num-lanes = <1>;
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            power-domains = <&cpg>;
>> +            renesas,sysc = <&sysc>;
>> +            vendor-id = <0x1912>;
>> +            device-id = <0x0033>;
>> +
>> +            pcie_intx: legacy-interrupt-controller {
>> +                interrupt-controller;
>> +                #interrupt-cells = <1>;
>> +                #address-cells = <0>;
>> +                interrupt-parent = <&gic>;
>> +                interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>> +                             <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>> +                             <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
>> +                             <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
>> +            };
>> +        };
>> +    };
>> +
>> +...
>> -- 
>> 2.43.0
>>


