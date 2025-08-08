Return-Path: <linux-pci+bounces-33628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE804B1E756
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1097587E70
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A03274668;
	Fri,  8 Aug 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VbmPTxgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F72749D8
	for <linux-pci@vger.kernel.org>; Fri,  8 Aug 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652502; cv=none; b=YlZ8a96KeqzaPcAShrxkLKV58lo7pQ9638HZZQj4HVfKVJQ4Ku6VE32NGHD6LbOqWTf0eMMhwKSCVkY68av6i1TPa+Xf7auurfXnUoG6c6m9f/yohPvMSv8pHaykLXDRlMhx8LVxPhC3N0caD9pQR/ajI1lznXZ5WL//79729lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652502; c=relaxed/simple;
	bh=z5ZUekvUvpNnLWumH7i0r1l/KVlw1EnwwX2WWJ5MDqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocW6s9alOht3YhSiX/vyMsGygFugz6wi/3YtpN0Y1OqKQxITW8oUQ6QNeec31eixi6MNm5g8J6Jp2vC/5EluYNBmNyrIdUVeyfSteijYQVLQdhKUbE/miNVzqDwPwhmwz4nAj7aUywpJb93zzyI912bgpjZxNmOoT7sFp8V8AnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VbmPTxgG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459e794b331so12710455e9.3
        for <linux-pci@vger.kernel.org>; Fri, 08 Aug 2025 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754652496; x=1755257296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuJVZzZIQCTzLTzieTR01L1RJwkvyO7UMJraS2W9Ndo=;
        b=VbmPTxgG4Y61wXHUE1kifFFnwgMm0Mb7eYZrrlaWde/WnCbl2/XYjJj6+Lp7B+w0LL
         SvUsT8pWRZUzM+r2JIIVBQUXmOWBhytN05zObJhNHfcSAo6qXRynvpB45PNbQlim0WaV
         4LD9zyOWSl5fsj9t7s7FSEYmMryIuCvwYWhavvzUcJaRQx6J3Qeyj8k8TmULyJnvxiLV
         smOM9IJE/t/0i5X/NAZkENweSSpX/y9O8sxwYeVtttRjL6Qkwun8GuN1zyqzxW9bvZjD
         79t2XHBg4mpqOOzmzxeDozahqOlwqXNA3SFgx8ZMNrdBWyNbPmFLlbzjUxSaW6gWUv9q
         +lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652496; x=1755257296;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuJVZzZIQCTzLTzieTR01L1RJwkvyO7UMJraS2W9Ndo=;
        b=ZJRslVtyInY994GM/f65Masfj/rlPDNeqN1WXIFgu0CrlC8BgtlV6HGi6gyal+Vt1q
         2x44dp/94i+C01bk4Qybk7ku7eAYNDasCagPyvJVVrSnUqUknY4rEQoEdVSodHnsNrS2
         d/1VGlDCI5s770jH508JHSDnxgBEdSuFV/LhAQVzAxeirHuURSC89V8L9P8LA3NQo/cg
         54BWYNJ7pj/N8pRjO0vRLvojDZ2cEypBTYcCl2KWN68XGzH72hHXhU+bx/IMT2ataD2o
         AU0JdTn1vvRKYFmPvcTUpgyAzO5bgYKw0JD2M/yb05ngL48EbWPJDjEVGZ/WCv8ZroXV
         RDlg==
X-Gm-Message-State: AOJu0YxTLzsWMYbRA7229Ap4WqdFJnvEdRLlWKXVsDLJlDE+9BQzT05u
	7NZueIBe6JyzvxMwdZDOsSl08PhC0U/a1d+3gi2NgLQw5ZnBHJOO/DYt+NaInbJFtvk=
X-Gm-Gg: ASbGncuk8MKKyWmDIKF2SKdwSvRNmgzp02VfRUTPUD55114AKMdA2+zmnExlYZK6YlW
	PxOc4boXe98dryKXRUeKkWAa6Ul6ZHr60ajywDaowSK0sqprWHHG5WLuiGaB38uqNYLnjCT+paf
	Md4mnD2hxP8XcF9di4odG7A6/LPM2RG24H0upGvphGfHZBnW0XBaSI+ITermJhfXKL+M29pOfeP
	THfvuXEO6HQ7PAPVbMFz7symxW62UgCRNc1roXR0XuywuBSH3knz5xwSR0p0eNwO+XBON+vl+RB
	kbIpjvDWjsrxwBAFnC4N3TJeJxvW2QYywff06kTqYZ5ZJb4/HJdKnRUpzGs0+9t3sLOugisbp4u
	yXjbDSpaB6wXPsSN9xHhBSXqdzXo7EXE=
X-Google-Smtp-Source: AGHT+IEaRRICyrF0MfupXKJ2sBoN8+NsjzhBxiQBkAqrwCfw85T5RHBvLEqeXF14peiWqYwm1M7yag==
X-Received: by 2002:a05:600c:3b1f:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-459f4f3e226mr21968055e9.33.1754652495747;
        Fri, 08 Aug 2025 04:28:15 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm249864835e9.14.2025.08.08.04.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 04:28:15 -0700 (PDT)
Message-ID: <fa0da331-273a-414b-b0d8-229c6772692d@tuxon.dev>
Date: Fri, 8 Aug 2025 14:28:13 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "lizhi.hou@amd.com" <lizhi.hou@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113464920ECAC2C3CB89DE2D5864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7c8c7a25-c373-452a-9fe8-8b2d92ddd885@tuxon.dev>
 <TY3PR01MB113467C09DF7D3D0D7833A6598649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY3PR01MB113467C09DF7D3D0D7833A6598649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 09.07.2025 08:05, Biju Das wrote:
> Hi Claudiu Beznea,
> 
>> -----Original Message-----
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Sent: 08 July 2025 11:10
>> Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
>>
>> Hi, Biju,
>>
>> On 07.07.2025 11:18, Biju Das wrote:
>>> Hi Claudiu,
>>>
>>>> -----Original Message-----
>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>> Sent: 04 July 2025 17:14
>>>> Subject: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
>>>> dma-ranges for PCIe
>>>>
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The first 128MB of memory is reserved on this board for secure area.
>>>> Update the PCIe dma-ranges property to reflect this.
>>>
>>> I see R-Car PCIe dma-ranges[1] and [2] maps all possible DDR area supported by the SoC?
>>> Do we need to make board specific as well there?
>>
>> I'm not familiar with R-Car, but if there are ranges reserved for other purposes, I think we should
>> reflect it in board specific device trees.
> 
> 
> Already Linux has this DDR info[1]. Linux provides DMA memory only from this region.

What we provide though dma-ranges DT property is setup in the PCI
controller register corresponding to the AXI windows. It is the same in
case of R-Car (as of my investigation on driver).

> 
> In your testing, have you faced any issue like system allocated DMA region other than [1]
> and you don't want to use it, then the changes are ok??

I haven't currently encounter any issues.

As the values passed though the dma-ranges DT property are setup in the
controller register for AXI windows, and the DMA endpoints can act as bus
masters, to avoid any issue where the DMA endpoints may corrupt memory
specific to the secure area, I chose to update the "dma-ranges" though
board specific bindings (to reflect the presence of the secure area and
tell the PCIe controller to not use it).

> 
> Not sure, PCIe can work on internal memory such as SRAM?

Inbound window is RAM, outbound window is a PCIe specific memory described
though "ranges" DT property.

Thank you for your review,
Claudiu

> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi?h=next-20250708#n31
> 
> Cheers,
> Biju


