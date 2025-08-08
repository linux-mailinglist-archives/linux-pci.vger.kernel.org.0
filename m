Return-Path: <linux-pci+bounces-33627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C058B1E74E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41ECA4E43BF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01734274B3D;
	Fri,  8 Aug 2025 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fzDoCjIX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A33274B25
	for <linux-pci@vger.kernel.org>; Fri,  8 Aug 2025 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652420; cv=none; b=AjPVMjNJ+vinFM6XxyRtawlmYoMADg2bYQgx/t3/0feLUjSKEtgm62Rj8SrSEKrsq2ILoMtyRh+0X7U0RixuaUyl3j/IudEkP+rMQKGPqlyDa1V83MDWclhqNap4/JGciwx7b2rPbpUwZK6dMT+SMwc05+GqV3soqQGfMLd+zw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652420; c=relaxed/simple;
	bh=PHwIx/DdNtH6flF1xerQiN6Sk7tIPcKXZKHuKQM8yJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5QdgbLwrRxd+XqqhN0/mK3XmRPqF1GQlRGqwH/hqRLLAvD1Cur7zhRf5lI+Rrfs0cz5CLzCY+e6Y7UWghXkhSPF5m/iUsTIJpFNost41zwcB3G1g8kRJWm8VcS3SINLaUiet6OiPg/UOeKKEwQfvTETB23c3T2lBDUEjGseB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fzDoCjIX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458c063baeaso11719975e9.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Aug 2025 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754652417; x=1755257217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQD9ZN86fbnOv3Py6c0GNoRIiGV/UrKy3H7tuotUIpg=;
        b=fzDoCjIXV/4UdeKdFmlmaB8G5G/Uylcj6tY5c+8e35wa4iRkq9rFY322hzLktQ54MO
         j4oj09k+WhbZS9heeaEyGeZDQUcld/H6lPCq23fM55va8rAYIfPfrTogT0rgK3r/cpAt
         gRpUaNCh7AB5V7YLRPpjQJ3c4feS2vX8dAeLHF/Y9NG3GkZOHSowU/VsBtSeCRSgYwqL
         LDPbS7SeMmf87H/OE8gKlBWW7NWqto+/Kl2Wd5Wx+D1MMm/S/jF+9eKikQFleuwQK5Tb
         gVrhy7Ib+9pXkWvnbNTd2yYLy3y3sOnG+JU/wQInTlJ6aF5fUv8EGqKgFph4iQVpm9H2
         7sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652417; x=1755257217;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQD9ZN86fbnOv3Py6c0GNoRIiGV/UrKy3H7tuotUIpg=;
        b=hQh8sSIPu3znYLUm7int9eue0gAWmjOQ2xvtn85bnA9Q6QzqXz0Ke3HQg6JXmPVKkp
         FRd7pXzJPN0SkP4v9LdL76bJdUonNiqs3Fe2976TNRufT9wPhC9xReTbznbiimZVAaEQ
         WpBrXimPJUjc8ZMespYM2rhU7ECUgkXbD3RiESi+5AYBcLaoOLCdPJ2S04Qr3ENZnlL/
         HpoduPEt7+OCvL0BXY1JyRLmKlWZxJbP4n3rdH1yTgZjm426Cy64eTbTP7oO1BrzD1QM
         Sz/GwdS/Z4GZXAiSugueiYnOJVtfEKZS37Xa2K5wu1fTV0TI6NwBalomBav+N1LG6py6
         9XXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEWvqRUXW5PDKPzCddNSCPzeg2pwSapyU9lBebHKcsrep9cqRQjtpgeCqWwjzOG6w+fmSi033o/Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhEstrJIvgUc7+hs1YwRNLCZmqttt8WcD+1O39PCgfnOjWOaS
	gpX8VcP1cQ41M0u1sPq4UpLDBNPdUyr29QGeTxFqDKiEDyWKMQ8ZEVjqhihjM0/t6sc=
X-Gm-Gg: ASbGncu4++fKV9/26kWLRK2ysDcJy9n8xF9XIXNe1GBwbfXN/RGPs2T6ARL1SjpE5VY
	BtTQA6Xr7yWheO0YrAT6TfudZfXnJ47gr/olY/nFdDGMhC2Da5lSs+FRdwAVfexnk7+7cK2ZBta
	U7pZS3t+iPDdW13wVJr3sLu2ghlHU55uoMirDGEWEXv5WzVY6fjmunqa+dY8lMCd/ARN0KrAtFJ
	v3Wjht2dut4Id8sxaSDh8RYSzje4dl/G5y8AVeOTo3XQm54GfFGFz6OuyIivMlKlmKnhcpvQEDF
	2YbQ8YMoGk4KNM97gdC6XrN6Yqo6W/cJ2zq4Re4xrNXmKf+Y6M568gD+qE/U1dY0mk7FUJ7NSPn
	1vdI7gGLT+xAtj5tAGbiUqe2n4L2LtNo=
X-Google-Smtp-Source: AGHT+IGrw6qJfbOAqNVKVNHju607OPKnyRwv/T0hcF1UsbBaa/pvlDY7WeC0PqYLDYFHFXx38VFdTg==
X-Received: by 2002:a05:6000:26c9:b0:3b7:89c2:464b with SMTP id ffacd0b85a97d-3b900b4496bmr2232459f8f.5.1754652416806;
        Fri, 08 Aug 2025 04:26:56 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2187sm31150895f8f.70.2025.08.08.04.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 04:26:56 -0700 (PDT)
Message-ID: <0addc570-a3c6-4d7e-9cbd-06eedd2447bb@tuxon.dev>
Date: Fri, 8 Aug 2025 14:26:54 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
To: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250709132449.GA2193594@bhelgaas>
 <2e0d815a-774a-4e31-92f1-71e0772294c7@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <2e0d815a-774a-4e31-92f1-71e0772294c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, all,

Apologies for the late reply.


On 09.07.2025 16:43, Krzysztof Kozlowski wrote:
> On 09/07/2025 15:24, Bjorn Helgaas wrote:
>> On Wed, Jul 09, 2025 at 08:47:05AM +0200, Krzysztof Kozlowski wrote:
>>> On 08/07/2025 18:34, Bjorn Helgaas wrote:
>>>> On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
>>>>> Base Specification 4.0. It is designed for root complex applications and
>>>>> features a single-lane (x1) implementation. Add documentation for it.
>>>>
>>>>> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
>>>>
>>>> The "r9a08g045s33" in the filename seems oddly specific.  Does it
>>>> leave room for descendants of the current chip that will inevitably be
>>>> added in the future?  Most bindings are named with a fairly generic
>>>> family name, e.g., "fsl,layerscape", "hisilicon,kirin", "intel,
>>>> keembay", "samsung,exynos", etc.
>>>>
>>>
>>> Bindings should be named by compatible, not in a generic way, so name is
>>> correct. It can always grow with new compatibles even if name matches
>>> old one, it's not a problem.
>>
>> Ok, thanks!
>>
>> I guess that means I'm casting shade on the "r9a08g045s33" compatible.
>> I suppose it means something to somebody.
> 
> Well, I hope it matches the name of the SoC, from which the compatible
> should come :)

The r9a08g45s33 is the part number of a device from the RZ/G3S group. This
particular device from RZ/G3S group supports PCIe.

In the RZ/G3S group there are more SoC variants (each with its own part
number). Not all support PCIe. To differentiate b/w PCIe and non-PCIe
variants it has been chosen to use the full part number here.

The available RZ/G3S part numbers are listed in Table 1.1 Product Lineup at [1]

(The following steps should be followed to access the manual:
1/ Click the "User Manual" button
2/ Click "Confirm"; this will start downloading an archive
3/ Open the downloaded archive
4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
5/ Open the file r01uh1014ej*-rzg3s.pdf)

We use a similar compatible scheme in other drivers.

Geert, I may be wrong. Please correct me otherwise, as I don't have the
full picture of this.

Maybe, the other variant would be to use "renesas,rzg3s-pcie", or maybe a
more generic one "renesas,rz-pcie" (though I think this last one is too
generic).

Geert, please let us know if you have some suggestions here with regards to
the compatible. The IP on RZ/G3S is compatible also with the one in RZ/V2H,
RZ/G3E.

Thank you,
Claudiu

[1]
https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12

> 
> Best regards,
> Krzysztof


