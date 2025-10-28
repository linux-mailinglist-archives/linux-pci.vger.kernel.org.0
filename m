Return-Path: <linux-pci+bounces-39517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F64C144E1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 12:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0874B3455A5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F82FD696;
	Tue, 28 Oct 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0OZqRxO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373B5227
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650063; cv=none; b=e1A1cFzxMI0kS1zKNYgzyttQArJIvLQg+rt7PYKtt4t/bVfew3ikMGZr2NNNICHdNsdz+0l7/praK4JECo46aSq5PXFYvSC6tkEo5Mp7D8E6gzMzOPKvEwDf8UaUtOCWv9hkWoz8koghdFs2MzTHk7VQAJT72KdfQ6bqM4nJLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650063; c=relaxed/simple;
	bh=UvfI+0Dexvqi89jOuSdlxco1E27i3zPPumESPPyhntQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3tnh25OXW8lgDNgZIkmhC9dTzFeQHPeRPxuvb/ekfdiY1ZYUqoPYLm1xS+DOxxzJxYVSpPA99GOvHgHfv12cbv/fulOe8f+UKN1PcZ13GxLn4x1r2bW49dHG55X9wcJcoAG9A5WaZEom5zwUGeMS9pPzbuyTH3LPz8yJvTd3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0OZqRxO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so913594166b.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761650060; x=1762254860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjFpI9BYeJIGawQior8vsJoD7SmwJll5ZNIMlbkQNe0=;
        b=R0OZqRxOtBqxX/rZBL4S2C3y3U3RNMl6iz0/8oIqXKU28NYDvTmLrqGxYShitik6MK
         VAPqJiZFBjuDjj9f9zlX5DkBXo8nscRRtYYNnHTeHO8825Ypcd0Y0W2KvHLiMrNYw+AL
         9kmWhZ9K7qpj/mOCKh/lyDJg1MNNLapfnFeMmNSRFLMK6BYKQV0Hwjocg3p/FV16BNlu
         a+4fz630T6RaGNUF7jLe1QCGdCnsIgurM/D3uU0rtstzJ7tHjcDiUtq9Y79At3lkmaHc
         PzRTa56pXXPgmBSJ65ev5DJwY4cSK+MMLNH8+i3Wmk6122maSf1jnSvPS1tQFpwhCBw6
         za4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650060; x=1762254860;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjFpI9BYeJIGawQior8vsJoD7SmwJll5ZNIMlbkQNe0=;
        b=KRPnrCEr4Hf2FYnR7/HbqMIeH9MMgZFOrn3R4tFdvfwUWXSZCewI5uw32t/vkxLwkR
         QtpNpP/0OEQZer5HrF1z4c5CIQTrY81I/QABrIxCtCNG57tOtmAZAoxCs+m/fkBWY2ma
         uvnMW8vR2cDCaNoUGEiRsyWYPpVBA/ixx16wXHYEoW2DfyngnKogOQxFLf8mhilWBY3x
         YVcNLwnl799/D+F6HHbmV0B19Z4w4mNfpMVnGdyRe0EbNLwVIz3l/EKfYJI2CnVxh6i+
         kRgz9GWHXvLaa3IoR7TJuZXAayTzysE/8E9zILZKQPF6wnQ5ui/nYzX3B353kImBrNJY
         i+dA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCciL1ohQTGsQjuMg4Hl9+RPCHt7jTrkwUuHLqhAcfCNacjlLI1S9vxkaD/JVodQdg1NiO0sbyt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcoIgQ6JVNYNoJ7dGytnmQyWhsd46WqoBKQcpgS75Z+A1nK9C2
	LPpFYmkkR3qDLfhDRSHfG1FEqbDIWDyPg/67d2ddohF0ZR7lV3bIBA7r
X-Gm-Gg: ASbGncv4lIg3LCDKOTf5h5UNtyJJ3FrYGmmD3BHv03zhVpI4puhe2iUeeq6a3G6PPQs
	RypKj5q5mWmdME2Iaz8lVtSNGbuRdeOnNpnAiKd885kTJAnVsbnNdyIAoM0c5widcS4mida5s2q
	RjshU3wHJIavPbiqj7lhO/lR5DUIoxt8/MXS6rfN1gZOJKXrxoXRg9DmEszQH6orhtRrZG4BNfz
	AbjmMGBG5suRaMc07D9CpBXBHDCNsilQPHOT+H4ZAdykaynlBl2XrpD1h4vAcUSDwtgCMGHWFJ1
	B06fFOldDK97cMUiinsY950B2daXS+PIWCpEd6dXFrdTT9bAb3wgJRfom+GjyyXLgf6+Vb92Xlk
	lH3Iq1Z+/oJZEdK+JreaEEqD7IxaQ/SnViZW99eVpcNXZyK/y5MXF3sI6taGFHvVBCYSgYXH2w1
	Bz1hGIU0csoH9Mm0W6avhx5rWab7hsZD+5ehZXxbaOSmV4pMFYlXA3JxPCq+fUk/OAz9Q5Oo91t
	33SflcMs+ouC1YK5etXqdnFWbzgAfiygCVuS9LR2qMwIgvWBErYIg==
X-Google-Smtp-Source: AGHT+IGFhB1uFC3jfUFSa2Q1GaChneZzYP9rrCvUKq1g/2kn74sMQ9tiDca6CquKILqpFbpXF/Q/Kg==
X-Received: by 2002:a17:907:7f0a:b0:b4a:ed12:ce51 with SMTP id a640c23a62f3a-b6dba498fe6mr339684266b.23.1761650059938;
        Tue, 28 Oct 2025 04:14:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077ddsm1052436566b.11.2025.10.28.04.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:14:19 -0700 (PDT)
Message-ID: <05610ae5-4a8a-47e9-808b-7ff98fade78e@gmail.com>
Date: Tue, 28 Oct 2025 12:14:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 Ethernet
To: Sjoerd Simons <sjoerd@collabora.com>, Andrew Lunn <andrew@lunn.ch>,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-12-de259719b6f2@collabora.com>
 <4f82aa17-1bf8-4d72-bc1f-b32f364e1cf6@lunn.ch>
 <8f5335a703905dea9d8d0c1840862a3478da1ca7.camel@collabora.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <8f5335a703905dea9d8d0c1840862a3478da1ca7.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/25 10:21 PM, Sjoerd Simons wrote:
> On Fri, 2025-10-17 at 19:31 +0200, Andrew Lunn wrote:
>>> +&mdio_bus {
>>> +	phy15: ethernet-phy@f {
>>> +		compatible = "ethernet-phy-id03a2.a411";
>>> +		reg = <0xf>;
>>> +		interrupt-parent = <&pio>;
>>> +		interrupts = <38 IRQ_TYPE_EDGE_FALLING>;
>>
>> This is probably wrong. PHY interrupts are generally level, not edge.
> 
> Sadly i can't find a datasheet for the PHY, so can't really validate that easily. Maybe Eric can
> comment here as the author of the relevant PHY driver.
> 
> I'd note that the mt7986a-bananapi-bpi-r3-mini dts has the same setup for this PHY, however that's
> ofcourse not authoritative.
> 

Lucien would have access to the correct information about the interrupt.


