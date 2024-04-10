Return-Path: <linux-pci+bounces-6064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDF89FF52
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818ACB269F8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122E617F373;
	Wed, 10 Apr 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cl1faToI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF517F36E
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772024; cv=none; b=YR6bM0NJ99pfQCeMSR51Q2EhRJyZGJCcmZ+snTFAz31eoXpVfRUC7/4CtZQ08v2a7cX0iJObxcOXYRY1s5aavG5l738zldxXEIC13YxHZe2MYyBNl1i1w2mnw+LW802cbhhd+T59pma3OpAPXLYjvbUY5+i/Sw/SRhy1g4c5Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772024; c=relaxed/simple;
	bh=Ds7ajWYR8A7yLwF6a0aj+BXOtr1axRcbVl7JsyTJu5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy36lHKIiYaxdfZagbmGFsRwzBy8N8AXlvgu4Tz3pNS27jEBdlgJ4ysmi3vJnzz8j8lhwRTy5vjmrkXBEyqIYGURsXRmhu3C5vQFnq3fMcwyn+T3I3pW9Fa0hemEPpUzczM8fNDhT9UNVq8F+aprMqLqZj8KkhPiYHHha3nUHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cl1faToI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d886dd4f18so43790891fa.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712772019; x=1713376819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ccLsCR2InDzvNTsN3aah4jcUq2TjT937xPnrA+vAYdA=;
        b=Cl1faToIrYhMg4FU8b0uRnbuYk7lGmqaElRlEQScmxtJzMVMQusMYTwnjBl2s9y9Yw
         Jr/YnQ0Kb0WnIUI3ZAVAyrRihCq7S6hT/GGQAoMr9Q/xpk9IdV9GM0zhIYNzWI6IhDw9
         QQlzD4A4Qnw5VWln6X6Whx1UTX9/nz+DPpLxHj8tj+H0fomoZLxI3NWNiL+MWEFUo8gL
         POnzG5RSbxL1dVuuS48WHQiRNRdtyWelCbJzsFyWQktBgNZ4GAgTq9sVmOTLWrKuZV2W
         NdU1fhOmzPUp4qIkubEQ0BKmUx0h/pJ5ynrubFhHYVtlXXFUCItGgZRX5jhyMoNSbap4
         4Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772019; x=1713376819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccLsCR2InDzvNTsN3aah4jcUq2TjT937xPnrA+vAYdA=;
        b=wPuXoFvOCw0yS1WXBQR/jcCaprJt1M2frnsUfnKD095grahAWVnhXlblZQpAhm13vS
         2qngkqeURF8wkPsQcrdQrVlRpcOng052R6sitIaw8jXlr8IuM717M8ABtrekxhSK+Ezo
         klaGIkSyF50wsCGHllgzuaMg4AMIGvUr0eJYqix3njx6pdI/nziugNDekGFEf4ntK0Dm
         OsOPqn3kUQLitrPRZrNdAludyz4IZpbxi+WFO/9PC1elozBJmSXX9npBy95eUCSV2BI5
         xCMD54nfotPfbi/hPoHdFMecdeASkvDz4Ytn/MqJikbtcuU3QMZ2QkwRTg6r4Kv0hBen
         UH4w==
X-Forwarded-Encrypted: i=1; AJvYcCV5v/+MXQW7GC5rke3QuYalMINxZoo/v4FI938KdzGWIlB0LFYhEmlt7hsB/CSHxExym2GFMODbLannGilct82kw5O7ZCtIUEnS
X-Gm-Message-State: AOJu0YzlYC/RkP4V4eYiviUEHhS3qqKmyUuCBd0X1bqaHCTmdpAtulYe
	KimuCBMESEf+2okw2uG68m90C4Zlnp3LA1Mccj8oSyw1jatcKayTCDs4rO8EWjY=
X-Google-Smtp-Source: AGHT+IE4FXe9FSZ4eRDMGzWkvFO3kI6yoJGdyAHguGTa3zbbtbJx+F3WexVwDuK+/2EA3ytcG3csyQ==
X-Received: by 2002:a05:651c:1a11:b0:2d8:e159:23b3 with SMTP id by17-20020a05651c1a1100b002d8e15923b3mr976848ljb.52.1712772019011;
        Wed, 10 Apr 2024 11:00:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5242000000b00343c0c24a65sm14198575wrc.89.2024.04.10.11.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:00:18 -0700 (PDT)
Message-ID: <57827422-1042-4ef6-a11e-cb53fd930a41@linaro.org>
Date: Wed, 10 Apr 2024 20:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: PCI: host-bridges: switch from
 deprecated pci-bus.yaml
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Will Deacon <will@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Srikanth Thokala <srikanth.thokala@intel.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Joseph <tjoseph@cadence.com>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20240407102000.37213-1-krzysztof.kozlowski@linaro.org>
 <20240407102000.37213-3-krzysztof.kozlowski@linaro.org>
 <20240410174806.GA788199-robh@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240410174806.GA788199-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 19:48, Rob Herring wrote:
> On Sun, Apr 07, 2024 at 12:20:00PM +0200, Krzysztof Kozlowski wrote:
>> dtschema package with core schemas deprecated pci-bus.yaml schema in
>> favor of pci-host-bridge.yaml.  Update all bindings to use the latter
>> one.
>>
>> The difference between pci-bus.yaml and pci-host-bridge.yaml is only in
>> lack of "reg" property defined by the latter, which should not have any
>> effect here, because all these bindings define the "reg".
>>
>> The change is therefore quite trivial, except mediatek,mt7621-pcie.yaml
>> binding which have children nodes being also host bridges, apparently.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml   | 2 +-
>>  Documentation/devicetree/bindings/pci/apple,pcie.yaml         | 2 +-
>>  Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml    | 2 +-
>>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml      | 2 +-
>>  Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml     | 2 +-
>>  Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml   | 2 +-
>>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml   | 2 +-
>>  Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml   | 2 +-
>>  Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml | 2 +-
>>  Documentation/devicetree/bindings/pci/loongson.yaml           | 2 +-
>>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml         | 4 ++--
>>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 2 +-
>>  .../devicetree/bindings/pci/microchip,pcie-host.yaml          | 2 +-
>>  Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml   | 2 +-
>>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml          | 2 +-
>>  Documentation/devicetree/bindings/pci/rcar-pci-host.yaml      | 2 +-
>>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml        | 2 +-
>>  .../devicetree/bindings/pci/rockchip,rk3399-pcie.yaml         | 2 +-
>>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml       | 2 +-
>>  Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml   | 2 +-
>>  Documentation/devicetree/bindings/pci/versatile.yaml          | 2 +-
>>  Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml  | 2 +-
>>  Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml | 2 +-
>>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml      | 2 +-
>>  Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml     | 2 +-
>>  25 files changed, 26 insertions(+), 26 deletions(-)
> 
> 
>> diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
>> index 61d027239910..5bbb4a3f3dbd 100644
>> --- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
>> @@ -14,7 +14,7 @@ description: |+
>>    with 3 Root Ports. Each Root Port supports a Gen1 1-lane Link
>>  
>>  allOf:
>> -  - $ref: /schemas/pci/pci-bus.yaml#
>> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
>>  
>>  properties:
>>    compatible:
>> @@ -33,7 +33,7 @@ properties:
>>  patternProperties:
>>    '^pcie@[0-2],0$':
>>      type: object
>> -    $ref: /schemas/pci/pci-bus.yaml#
>> +    $ref: /schemas/pci/pci-host-bridge.yaml#
> 
> I think this one should be pci-pci-bridge.yaml instead since it says 
> these are root ports and based on the unit-address here.

I was thinking about this as well, but pci-pci-bridge.yaml defines
compatible which is not present here at all. Since you suggest pci-pci,
I'll go with this and make it a separate patch for easier review.

Best regards,
Krzysztof


