Return-Path: <linux-pci+bounces-25008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800ADA76711
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106A01886222
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C281DA62E;
	Mon, 31 Mar 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O6MG2Tei"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919533234;
	Mon, 31 Mar 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428736; cv=none; b=WiP1P124RdgJCcsO+49dYH+WcG65mIp9e5GrqJrVamxnKra+5YkhLxg7VvpgzMa/hG4iOPK9Ez/fMEv4E4yZ7yKSb/nYEDJnh253P6bRCPtLWkxN6l5gZagkY9mfq9wdPzvIIy/HeDwLSF6FM8Z/BdKzkhX6DaLYmhX4f3dj3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428736; c=relaxed/simple;
	bh=NTCru1twM6AuoKrQ04g241v64utTJ5vRDXMNNtjc05w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zm7QXZUyK0c030F9rS/fy3Pe3WfSnHZYnVnxqxG3q3D0J8wbtSvBLYBHhI5n20Ml6hHTAldOpFt02gPt1vQKEMAFy/oh7cyn38l0Z2GDRmGF5ojXwOO6UJ8HRT0pA1mZn2IqEYIlxIhNfZH4emfvMsB1Kv3M2AX1+JiCrZH/JXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O6MG2Tei; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZRC7S75H4z9v2m;
	Mon, 31 Mar 2025 15:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743428725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNki/BaaXgqFuAU7Rhxq4DYyRe0qZNwLMs+MQ5hVwvM=;
	b=O6MG2TeioBcAI1Qnb54BydAhuwf7Sbw68IacAKC7rClD0YCZTkxWf+oANHet08+Q4rOb3R
	of0jNuOcN2rTJxe1WpK5J3ZVocemDBwGWUlGpft0fVQN7oElFkngn/CJO3Cujk/s7uOApj
	rXtfDcWpqazz3Fjb0n6pCkvas8UIh4i40VO8lqjO5bWo4S0XyZ2E0RzgQPNu8IJGJPJmDU
	QbIeQzaZ7uTSPQsEifpXENxQU1cD7sBJ3VbtXtBOshefcFPeHQaiKmSD+4X5RFHNysx8hP
	lNAg0ssWH1K9brcMEa9uCjOj5LFO3BQREHj/rjRSJgquUE9C5BzN6XYq5cHeBw==
Message-ID: <4b5fc903-f2c1-4e7e-8a4f-629566bff3ad@mailbox.org>
Date: Mon, 31 Mar 2025 15:45:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84sk?=
 =?UTF-8?Q?i?= <kw@linux.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>,
 Kever Yang <kever.yang@rock-chips.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
 <20250330195715.332106-2-marek.vasut+renesas@mailbox.org>
 <20250331-excellent-nautilus-of-apotheosis-fbd30a@krzk-bin>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250331-excellent-nautilus-of-apotheosis-fbd30a@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8qjyfopxbb8111g3aaicaxtrreq91134
X-MBO-RS-ID: a0dc09d5d8d0cbf734d

On 3/31/25 10:19 AM, Krzysztof Kozlowski wrote:
> On Sun, Mar 30, 2025 at 09:56:09PM +0200, Marek Vasut wrote:
>> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>> index bb3f843c59d91..5e2624d4c62c7 100644
>> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>> @@ -46,12 +46,14 @@ properties:
>>         - const: app
>>   
>>     clocks:
>> -    maxItems: 2
>> +    minItems: 2
>> +    maxItems: 3
>>   
>>     clock-names:
> 
> missing minItems: 2
> 
> (xxx and xxx-names are always synced in dimensions)

Fixed, noted, thanks !

> I understand that clock is optional? Your diagram in commit msg suggests
> that clock is there always.

The clocks which supply the PCIe controller ("ref" clock) and PCIe bus 
("aux" clock) can be modeled as either, single clock (one clock for both 
controller AND bus, i.e. single "ref" clock), or two separate clocks 
(one for controller AND one for bus, i.e. "ref" clock AND "aux" clock).

That depends on whether the clock generator (the 9FGV0441 brick in the 
ASCII schematic in the commit message in this case) has one flip switch 
to enable both clock (controller and bus, i.e. "ref" clock only), or has 
separate flip switches to enable the different outputs (controller or 
bus, i.e. "ref" and "aux" clock).

So yes, the "aux" is optional from the software side, but on the 
hardware side, the "aux" bus clock are always there. They however do not 
always have separate flip switch to enable/disable them.

-- 
Best regards,
Marek Vasut

