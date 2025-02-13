Return-Path: <linux-pci+bounces-21380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C27A34EB2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E0416C5D8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20720245B10;
	Thu, 13 Feb 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="KV6je5oO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNKk9yU4"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400B245B05;
	Thu, 13 Feb 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476321; cv=none; b=sVZxW6ymSfSmJmJx8tf9PykTDDIYxTwjeyf49jf8efNPdGOmhav6k+Ot4tfF2nNeVOB+srByfXAvMA2QqHSxokeUWIcifqviYWZ3oFa7SPbuUy1YetipuYRFDi+V6g/+I763gD8gxK4Vm0WQV29WHqY6p2a6fHmYG265YnsHPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476321; c=relaxed/simple;
	bh=dvNGHrTeA6ys468eoHNYSsVhvMpC15PcGXt3+qXaffg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AT39sSkdu0vPHqZ54LCgLBWVVQ5fMi5ITySqIaFIJucWsXHE9brmzN72/zRZD1DEuwmDvTG5+nm5sWvl5/5r0tw8D5oSqGrmCO8nPFKWs0CdxGDgjOYrin+Gw3B6VuDs/2nNDUoJw4kxdIbGj2Kvdkfg2kSdmj/+55jm20TeoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=KV6je5oO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNKk9yU4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC5611140222;
	Thu, 13 Feb 2025 14:51:57 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Thu, 13 Feb 2025 14:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739476317; x=1739562717; bh=+1icS1ornuLOryc0NeZcleF/lysfwDHd
	eIVIyTWVEzA=; b=KV6je5oOvDIlLt2IcOKKIavwfangEhqoB+zLeVLNjrhtb8ga
	ko1I6oJrJzwJI0euTefgVhxm2kbY5xzyv2RV2XCFsCh7EnNqhbcvsRqV8TUI4Lsz
	A3xdPdxGbH2jaoJGSDReNrRP3Mm0/JXhOouR4F7Aendba5svC5sVxkdbwzXI2lR8
	D7ITQRsq4RMkmL2/PwqTGWO2IcgAGRQ4y5sz03KJ/NAh2wWA8sJBmdjeo5T2CnoN
	TAC1AUr9D+bRPVP885VVIcHpLCS3Efyr83E6Y1jACHBmlbkBYVW//mF91GcdjpOy
	lvcME+rNn7EC0Ob76NDXPOjKN7Z6cjgXTuokYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739476317; x=
	1739562717; bh=+1icS1ornuLOryc0NeZcleF/lysfwDHdeIVIyTWVEzA=; b=j
	NKk9yU4fJCx9uyRFkIOvviP8jixh33cVwdZSooMJ+mN45xl1qK8kPJ7gtQazgoKg
	gZzzEtUpWM6MCbI0bVduq4FqPWQNZtmrc1oChTGj1eom9nJ9B5a/t5u3RuXXUzv0
	6LAOM6CnoVuwaQHvVMzs88DEEWNPqzWjzaCa9nD1AlPjhsNsFY0/LrblA3ciQszb
	va8AgUyDnN6tFl1In4C/7l1xs7JqONRMoyx5Gh3tLOm8qo7ZYXNMGS6F9EYtOZur
	LQmqHnXKQXfpWzEbnJdfTElldsIwW7ZMMBVKMiVI7ToQDzO4tCtW+tdBKV1akjYx
	cwbUuyl/aST1GzFrV7+lg==
X-ME-Sender: <xms:XU2uZybhXhFLU0OeqFw5r7L3mpSEfL0QlDD6zoef10vdrtLeWXWdwA>
    <xme:XU2uZ1YdrG79cucHNEjBZ2JiNE7dxcAYNFCF6qEx33LDHyzJK7N-rQANe6tywi4bv
    BnyIcJJWSdZvs02QqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrnhestg
    horhgvlhhlihhumhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhivghr
    rghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgriieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghnihhvrghnnhgrnhdrshgrughhrghsihhvrghmsehlihhnrghrohdrohhrghdprhgtph
    htthhopehkfieslhhinhhugidrtghomh
X-ME-Proxy: <xmx:XU2uZ88ZTFgef8cAWzc8dX8o9v685TS2_ZzLi1GHY__qmJsqtlyaSQ>
    <xmx:XU2uZ0pjTonlmsWbpyay6fwx5DEuaYtHCISTD-LlOH_Rt5IW_YyOfg>
    <xmx:XU2uZ9qGENScLPwOvIevVSsLZZr_mP0EvPTI5fjO6sPoTgr-C4H8LA>
    <xmx:XU2uZyTjDwJjL5mJ7S5FefJZ0FIiRnjdZGnvxbGeCdqbxiJwG7hfiA>
    <xmx:XU2uZzZKl2o40-GDvILbgU7vTYyK6xpADGju3BZ9aQPnlOz7YPfR1-yP>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C5C3BA0070; Thu, 13 Feb 2025 14:51:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Feb 2025 20:51:31 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Marc Zyngier" <maz@kernel.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Hector Martin" <marcan@marcan.st>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Mark Kettenis" <kettenis@openbsd.org>,
 "Stan Skowronek" <stan@corellium.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ae7bdc0c-c691-43a7-8cd7-b1c22c7623c0@app.fastmail.com>
In-Reply-To: <86y0ybsd0d.wl-maz@kernel.org>
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
 <20250211-pcie-t6-v1-7-b60e6d2501bb@rosenzweig.io>
 <86y0ybsd0d.wl-maz@kernel.org>
Subject: Re: [PATCH 7/7] PCI: apple: Add T602x PCIe support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Wed, Feb 12, 2025, at 10:55, Marc Zyngier wrote:
> On Tue, 11 Feb 2025 19:54:32 +0000,
> Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
>> 
>> From: Hector Martin <marcan@marcan.st>
>> 
>> This version of the hardware moved around a bunch of registers, so we
>> drop the old compatible for these and introduce register offset
>> structures to handle the differences.
>> 
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> ---
>>  drivers/pci/controller/pcie-apple.c | 125 ++++++++++++++++++++++++++++++------
>>  1 file changed, 105 insertions(+), 20 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index 7f4839fb0a5b15a9ca87337f53c14a1ce08301fc..7c598334427cb56ca066890ac61143ae1d3ed744 100644
...
>
>> +	else
>> +		rmw_set(PHY_LANE_CFG_REFCLKCGEN, port->phy + PHY_LANE_CFG);
>> +	rmw_clear(PORT_APPCLK_CGDIS, port->base + PORT_APPCLK);
>> +
>
> Can you elaborate on this particular change?
>
> I always assumed this was some clock-gating that needed to occur
> *before* the link training was started. This is now taking place after
> training, and the commit message doesn't say anything about it.

It's been a while but as far as I can tell APPCLK seems to be related
to the IOMMUs attached to this controller. If it's disabled all reads
from the respective IOMMU MMIO either came back as 0xffff.. or SError
(don't remember which one it was) but pcie itself worked just fine
(until any device tried DMA ofc).

At least on M1 this entire sequence only works because we already
setup PORT_APPCLK_EN inside m1n1. If we didn't do this (like e.g
for the thunderbolt pcie/dart) the DART probe would already fail.



Sven

