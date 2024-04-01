Return-Path: <linux-pci+bounces-5474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B78939D3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81F91F20FF7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A19101C5;
	Mon,  1 Apr 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiZ4sCAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D71119B
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965429; cv=none; b=KJKsuyOWxrmYMtLstQ9I9PodWXtC9H9ZsGH59J84Vk4r6wbFQpCIKFvESSOax2JiZijmJ+hqL5dPSESPz0BHhIsb1AzNbOSPXlLHqp/r3WZL5runPib2OXxA0WI25ctJXhmY3/UnhmWwhzvbH2rI6qNImFygw6Rk/cr+1ycbuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965429; c=relaxed/simple;
	bh=MXrD1XHlk4Ri6wS4xrNFVm5EmsePQ4GsEKWiZrbMOcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWT1cS9r2Fbnpy815ETaylgDEdLC9RhymdhUdgG+/zForBCzpd1ruHaM9MzxXH9h0mD8egMOx/15mbPsH3PcByyuV4o9FzIGzb79YOEWAEhA0GCiOwE2xWPp0Bzupyo6t5tNAoiKngMZbFSrnsshmVWdELTk+2yOHC8x/Rt2cfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YiZ4sCAx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56bc8cfc19fso4040799a12.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711965426; x=1712570226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pNxyOU0TK6s/eBpUUq++3gl10VSUBotVXGhvU/SrY8M=;
        b=YiZ4sCAxPNHqrn4uGboIVKQzzhQ83lKCVdh1ScnYhis928Vz0u2bJsRcSkt4sl0BFu
         7fCYnsdCRAG1b543izb4QszBkwlLPxuq2MF/dtgiXiXOGyYTdot3WQKquvBqQkeIaJdv
         tsKAW1PKfDo0UHF7K+EEYr12Ll3eMM1tTqalNakZbPHthn+uEOSSvMEldIOjrnFh9dad
         nP+7DSg9QRTlheK3C+ua+ddEgBVqWOQgJvQ3NgDaMFKDJI2losMT4qRAwJcaK1JdwVZt
         PEDTAykOM1YiPTUkL4NgxrdQAZczBHAzsQG1wPXwaG8tDyjHO+LIPya0+SrdqSaYIgBK
         P6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711965426; x=1712570226;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNxyOU0TK6s/eBpUUq++3gl10VSUBotVXGhvU/SrY8M=;
        b=o+dXfXQHIo6Kt81J2savYVxMw14L0kJinyDhrm3j/6Zcl2qmLjKYzr9lz8RibPfcvg
         CP6WbLZ5BuE/Bwo1F/OQVVmvUGJYBQmTgAsqMQ5KIdajd1AVFBIGqx2pz9n8x6o5Lfbi
         BnE8GQe6UyWCWnAdQHvYcMwc3mkWlyDtxDG/RBhTYumxWH0FC9AtbHVJsnjUAObCBPcS
         Jf3Btuqq6ooz5DPZzoxFWPKlwXxPcjTAbRoM1G/8k53PBe8Q/4emAtCck6El3Fh2dOYo
         iAvpgtNFAn7XFnIJS8Jbo1B4rXVyj1gZB59Qrj45Hy4so/mgQ8hw5hd5dGeIrM0T+Nrs
         jiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/OaHI14Fd0sfyBYWuoONIxrA2PCdGqE+UXpU86GSX0lI3I6XvKJ679IJO/pPFQX+8mmFLwfyRvPe7he985caVdpQlfd86Gs6e
X-Gm-Message-State: AOJu0YxwDTzDspIdLdweGBiYZgZCfzKhL8E9/p9MNcPDwzQ4Tq6OuyCY
	gHis4BocXENLAiD9srzPln4wKOI9+bFhsfWB4JUUK/yIDle7+1CqWms0ruDM7Sk=
X-Google-Smtp-Source: AGHT+IECEoyLtT4w3AH+Zhlt29Dbm0o4hodOjNAf1JlCMoNXW4dToGYBgYKyLMxIUAmDZuq/EoVoSg==
X-Received: by 2002:a17:906:39c6:b0:a4e:2686:4f1b with SMTP id i6-20020a17090639c600b00a4e26864f1bmr5397597eje.2.1711965426168;
        Mon, 01 Apr 2024 02:57:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id y17-20020a170906071100b00a4e6626ae21sm1395816ejb.0.2024.04.01.02.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 02:57:05 -0700 (PDT)
Message-ID: <518f04ea-7ff6-4568-be76-60276d18b209@linaro.org>
Date: Mon, 1 Apr 2024 11:57:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add
 ep-gpios property
To: Damien Le Moal <dlemoal@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-18-dlemoal@kernel.org>
 <b020b74e-8ae1-448a-9d47-6c9bb13735f9@linaro.org>
 <c75cb54a-61c7-4bc3-978e-8a28dde93b08@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c75cb54a-61c7-4bc3-978e-8a28dde93b08@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2024 01:06, Damien Le Moal wrote:
> On 3/30/24 18:16, Krzysztof Kozlowski wrote:
>> On 30/03/2024 05:19, Damien Le Moal wrote:
>>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>>
>>> Describe the `ep-gpios` property which is used to map the PERST# input
>>> signal for endpoint mode.
>>>
>>> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml       | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>> index 6b62f6f58efe..9331d44d6963 100644
>>> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>> @@ -30,6 +30,9 @@ properties:
>>>      maximum: 32
>>>      default: 32
>>>  
>>> +  ep-gpios:
>>> +    description: Input GPIO configured for the PERST# signal.
>>
>> Missing maxItems. But more important: why existing property perst-gpios,
>> which you already have there in common schema, is not correct for this case?
> 
> I am confused... Where do you find perst-gpios defined for the rk3399 ?
> Under Documentation/devicetree/bindings/pci/, the only schema I see using
> perst-gpios property are for the qcom (Qualcomm) controllers.

You are right, it's so far only in Qualcomm.

> The RC bindings for the rockchip rk3399 PCIe controller
> (pci/rockchip,rk3399-pcie.yaml) already define the ep-gpios property. So if

Any reason why this cannot be named like GPIO? Is there already a user
of this in Linux kernel? Commit msg says nothing about this, so that's
why I would expect name matching the signal.

Best regards,
Krzysztof


