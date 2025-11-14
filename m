Return-Path: <linux-pci+bounces-41213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D4C5BAE0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 08:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 306DD4E8C5F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8138619F137;
	Fri, 14 Nov 2025 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Kkr8BUxq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqrKIJLk"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188B12DDA1;
	Fri, 14 Nov 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103809; cv=none; b=aTgyu+3eIItJqmxCeWXB6mZdmUtLQS+eucGmrYBjQQNNHV6yrf2wyCG+8xoYovn8uguE8VEEZmkTOA0w3rjBagFUahntq7cXt6es4rLAyxViqNUn0r3IilegNm8EROl4p3zSSacoZ5fLyNN81dQTFsEMcMnGILWyav38p8nemoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103809; c=relaxed/simple;
	bh=JJmcUa8kzgG4fsYeJvqgfTT9tu3JsO3ITBAzyO0ISvc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ix8p8dVetKtbdjFlvm8C5udWmFz5eLxzY1sOxmKAURk1yduo8PCFRGPBOdkGwg+DwOytB2CdxSr4Eb0qtYrdFWVxig/wwypQcbqdWRiJj/cRLKKAQjnePGv/Ik7ahKWqMFnYacABRthqOT1JlEEXjrMUyLfmXvGAbX+Vh7aPL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Kkr8BUxq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqrKIJLk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0A797A013D;
	Fri, 14 Nov 2025 02:03:25 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 02:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763103805;
	 x=1763190205; bh=+9e6FQJYDBsPl1jkD3novF2T5qQ3BDazY3CfaJMvju8=; b=
	Kkr8BUxqPGK1Z3+4BpwkcXn5eWZ9hMKOCWH9VvtuOl+T5CZniYPcirw4hz4KbzdQ
	GKsbIF3vOFzTZntkQ6NCK/rtrMeAMNRe3j5OUq9xExIihhTwc3Z/qRom3f8tL3yS
	7n2V4faSNEDFfp/ujiH3LAvBsSEziqCvB2Rf++cCpMXwi+2OnPSN9NwwtHrT3YYW
	Wz0ea1xFFlEXs3HBXsI9GRf7hXxIOlfP3v7G46WAjSqJVOZJary7yua61l1Afuaj
	0qYzD+bxLzOZnEc+QWoEm2VXAp8kvLkMR/gXCROlc91RF47RX6WrFjoRjiv9CFZq
	qG3sIpCL8ks0PqG32b3rtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763103805; x=
	1763190205; bh=+9e6FQJYDBsPl1jkD3novF2T5qQ3BDazY3CfaJMvju8=; b=V
	qrKIJLkCU7Mup7XIDF1GPVKKA5HtwWZ8hfI1GSxMH389tPz/7C6xyCWjp3gvQEDZ
	foJS+VzCfYF2PT0hBwbTr4KUYAlAO0HaEExLkiyAHoKg10wDZoFKMsbFFoj114Dc
	5Wity2sFlDERE1MOMPiMQZZJR0VhsYMMxYofbe8ltLdnxvvvqoqswy/wRopAjq68
	N9WQnOW/dayWEX5etQkEAVT+sYVCJ6olEbiIJX6T10NXQDNao54wMcsP6krVnCrc
	aeXE/f5cr2JL/yezBvx2EWoH0EuaefrGUHPI98nKSWvaIr5711lWo8X/2prxgu5K
	y4g+Fa6yM8jYn6zirN7Fw==
X-ME-Sender: <xms:PNQWacaVLBgC9nNxAwigGX5Drf_gq_HI7fBsev8LJN1HNxR62q6Ygg>
    <xme:PNQWaSN9ovvEr8UNpipQJTb-Tytj75m2UJODHaIoQWt_WNoGL43TEbXLsZ-HG9x7t
    0j-cAa8b-NsPptu3MkCZOWxBU6FuCLfPHKLizBNIb53mu5cfuCk_4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhishhhohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkfihilhgtiiihnhhs
    khhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    uhhnihgtohhrnhgpfigrnhhgsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepshdqvh
    gruggrphgrlhhlihesthhirdgtohhm
X-ME-Proxy: <xmx:PNQWaXUUidTCGn64MDLMVcH47OvgeHBQFXeYoNhlQ4GbuQwTL4iPsg>
    <xmx:PNQWaUwbGym5csyq4rlEQA7cA_CwvSknjLXJiP2xEfbGuENE6u-Uvg>
    <xmx:PNQWaWxviwxkJ9-dMGWL06UcV7Ck3G16huzVzBcb5QYNJk0HI3Oxmw>
    <xmx:PNQWaR24J5sgWpWmsX9owMhMU2_lhQL0E23a1XmsLbzraobsEovf6w>
    <xmx:PdQWafCtN7VisKCATc9zZ-SqIK6ihquremM1SW5EHRJqIbo3FQZzl7kE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE6DB700054; Fri, 14 Nov 2025 02:03:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO4N9SNPwumV
Date: Fri, 14 Nov 2025 08:03:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Chen Wang" <unicorn_wang@outlook.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
Message-Id: <201b9ad1-3ebd-4992-acdd-925d2e357d22@app.fastmail.com>
In-Reply-To: <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
 <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
 <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from tristate
 to bool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 14, 2025, at 06:47, Siddharth Vadapalli wrote:
> On Thu, 2025-11-13 at 11:13 +0100, Arnd Bergmann wrote:
>> On Thu, Nov 13, 2025, at 10:27, Siddharth Vadapalli wrote:

> Thank you for the suggestion. I think that the following Makefile changes
> will be sufficient and Kconfig doesn't need to be modified:
>
> diff --git a/drivers/pci/controller/cadence/Makefile
> b/drivers/pci/controller/cadence/Makefile
> index 5e23f8539ecc..1a97c9b249b8 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,4 +4,6 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> +pci_j721e-y := pci-j721e.o pcie-cadence.o
>  obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
> +pci_sg2042_host-y := pci-sg2042.o pcie-cadence.o
>
> If either of PCI_J721E or SG2042_HOST is selected as a built-in module,
> then pcie-cadence-host.c, pcie-cadence-ep.c and pcie-cadence.c drivers will
> be built-in. If both PCI_J721E and SG2042_HOST are selected as loadable
> modules, only then the library drivers will be enabled as loadable modules.
>
> Please let me know what you think.

I don't think that the version above does what you want,
this would build the pcie-cadence.o file into three separate
modules and break in additional ways if a subset of them are
built-in.

I would still suggest combining pcie-cadence{,-ep,-host}.o into
one module that is used by the other drivers, as that would address
the build failure you are observing.

An alternative would be to change the pcie-j721e.c file to only
reference the host portion if host support is enabled for this
driver.

      Arnd

