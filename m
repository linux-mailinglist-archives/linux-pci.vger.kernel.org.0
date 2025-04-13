Return-Path: <linux-pci+bounces-25724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBBDA87140
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C321897B7D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8719ABD8;
	Sun, 13 Apr 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VNCSjzTk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z5hHSyYG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043B18C32C;
	Sun, 13 Apr 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536553; cv=none; b=fpPfA9HitCqQJpUtflBaNGIwGU2cByIP3pa2RDv5aQWPQ8mdTYvkSxtkbvtAzxH9RAu4Q+HP6hEvfZiJzb680x9M5ZK4RKNWGkTylz5t9BPAVGswxhZuyQdMKNLm9osxgQnB6YvSpUX2KQpFE+by8oR6vaOC5ZKm8Jb8ifo+rJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536553; c=relaxed/simple;
	bh=gAC5LAQumBDmHJcR25hr6uZMlYiGu3JMTUs4+VWXT3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgGuH4SdzblsW4ZhVZJOIKc6TxOLt2x4wmUwCdkIMZJuDr8QmdBsvlEgtSr0xNM4AB2ufj1mwDHCA3GpUPFkdE5zBRDNqONkzV3L61vi/gWFOfZZwcfxwKNbyHRU6uX/z8GwQiRRzHQ10Q8v7WW39okcfQHj3CnH8Aqy6aXlouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VNCSjzTk; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Z5hHSyYG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Zb4qg1q66z9t87;
	Sun, 13 Apr 2025 11:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1744536543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLigHGDaIeu/1Png7nmdn+cp2yXJhXD50jHy7YJID8c=;
	b=VNCSjzTk21Eve7Z+hAqaCoAoIaDO686a1/uXqp2xVsziv26bF5vn6E9rsnU2/ugYcJjrI5
	syuFZWiDwaseaXZRo+WyhhWeFDtw9ycr6zfxHpodzkx0WrXEXc/qDIbQzREeCkesOlRbnm
	POuIINCHvixCQ/vclA/kbYEs21KEMXeRsujd0LTzVgdVdpkaEdlcH4kN11LvJAVweYnjf0
	ZSDEZ5f9crvnuMyDK1gttT/D7EWeBQG5wQR2ONBpZBVDmVJvMlqgDkct1GSImhLkHxb8Og
	M+cRGpS4cFMkZcyLMAzUiqzALHwN52cNWOQ3kgblqZEjA5t0mqa5Ao5+hIZPtg==
Message-ID: <40c400ab-8770-4595-9a4c-004e6157c348@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1744536541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLigHGDaIeu/1Png7nmdn+cp2yXJhXD50jHy7YJID8c=;
	b=Z5hHSyYGUjCJ8sxEk2uc5ghic5sz5e161r4Uzv5vy9eHgrABVAWnuMIWd7jNQ3IY0PR+mj
	NElEyXHt9jEOUHCmcuhUVQLyFDvJzGDofkOKs9+PJI4bRM6edNgnr/h0yyBp9U/i7gZFsz
	7eA8jBRPtuh67u5wRTV7Abl1BcYvr/XEEpAgI93xMhX7YOTHUoVb8qgHEXLvFRLr4zIhkQ
	O0jiQB0yb+VxZ+kwBbzj2zomPxkwut6ybYHgahwx5wkXZSzAAUUg7A/CW/fSsDQT1xxI+F
	8Tj0gGHmpTeZtVCKjZLdzmjT4H0+Huhc9mc0+Q/YM2SKH7174AnR5sg/I3yT/Q==
Date: Sun, 13 Apr 2025 11:28:54 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
To: Rob Herring <robh@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>,
 Kever Yang <kever.yang@rock-chips.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
 <20250406144822.21784-2-marek.vasut+renesas@mailbox.org>
 <20250410204845.GA1027003-robh@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250410204845.GA1027003-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 56af0dbc93e5c7e09ea
X-MBO-RS-META: pc3z5wauiworu1bkpr5dqhfdbznjkp6g
X-Rspamd-Queue-Id: 4Zb4qg1q66z9t87

On 4/10/25 10:48 PM, Rob Herring wrote:
> On Sun, Apr 06, 2025 at 04:45:21PM +0200, Marek Vasut wrote:
>> Document 'aux' clock which are used to supply the PCIe bus. This
>> is useful in case of a hardware setup, where the PCIe controller
>> input clock and the PCIe bus clock are supplied from the same
>> clock synthesiser, but from different differential clock outputs:
>>
>>   ____________                    _____________
>> | R-Car PCIe |                  | PCIe device |
>> |            |                  |             |
>> |    PCIe RX<|==================|>PCIe TX     |
>> |    PCIe TX<|==================|>PCIe RX     |
>> |            |                  |             |
>> |   PCIe CLK<|======..  ..======|>PCIe CLK    |
>> '------------'      ||  ||      '-------------'
>>                      ||  ||
>>   ____________       ||  ||
>> |  9FGV0441  |      ||  ||
>> |            |      ||  ||
>> |   CLK DIF0<|======''  ||
>> |   CLK DIF1<|==========''
>> |   CLK DIF2<|
>> |   CLK DIF3<|
>> '------------'
>>
>> The clock are named 'aux' because those are one of the clock listed in
>> Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml which
>> fit closest to the PCIe bus clock. According to that binding document,
>> the 'aux' clock describe clock which supply the PMC domain, which is
>> likely PCIe Mezzanine Card domain.
> 
> Pretty sure that PMC is "power management controller" given it talks
> about low power states.
> 
> 
>>
>> Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> NOTE: Shall we patch Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
>>        instead and add 'bus' clock outright ?
> 
> Based on the diagram, this has nothing to do with the specific
> controller. It should also probably a root port property, not host
> bridge.
How would you suggest I describe the clock which supply the PCIe bus 
clock lane (CLK DIF1 in the diagram) , which have to be enabled together 
with clock which supply the PCIe controller input clock lane (CLK DIF0) ?

