Return-Path: <linux-pci+bounces-41365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC3C63120
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E3184EFF76
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A1320A38;
	Mon, 17 Nov 2025 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pl1Mou2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gtUVWTtW"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7173246F7;
	Mon, 17 Nov 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370486; cv=none; b=M17XqDMzzgODtdba06N6KIBt3NI5QVqiAfRG+rjbeU0qckLNPLxTAQMKnlft7IUcBTEzMy0bMbdWRdny2+adbUd6tt+5dRHe+62QLu5m2Y1koipkWKC08z/vcXNQYgAdpPpU+EPtQ4gu7frsDNT2PdZb3iyQ1PJXILCxaRbi314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370486; c=relaxed/simple;
	bh=MQJ8YPH8Nssy1ljCLQGwWx/LUNDSH+o2Sk5H8NIyyYc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=atDBbIRPrnOIQpVVDA6oBBoWnBSwKegTokSaTfexuIeiaOFAeucgpst0wYQ35Jk7RILQIXMTLzY4v4oa2wIO5XdBbrx8OPM2Q4rBNTZVC8inktuuAZqDUW9ZXi6Qwxp7tpYZ/wTk4mKo7xFiTVJLrAdCMoKHPXymxJTPSPovviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pl1Mou2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gtUVWTtW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FC731400138;
	Mon, 17 Nov 2025 04:08:03 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 17 Nov 2025 04:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763370483;
	 x=1763456883; bh=PO+HprFxowvXbocpvtAlTvfgsKxJ9kwRQfs+WUVErPM=; b=
	pl1Mou2a8h7kYUp3llgfzWaQkTkptKjNgKWve02MAli3WV7Yy+zFFzUiMVV55q8C
	Gp9sO5auj0GBfNeNQSZFd45BmUjMqTPIEr/60m1CKIQny8PWwO/CiplylIBhEwxK
	KPLSfkD5eEfxClT7Prcdsw5IzdArD3ReYb+bPpp3S7lYVqy5zAWZpp8JUxmhA1Yq
	8jmkklnrt4xxtxWsvzZvuhtvWKGes3TQJUzguU4fIPMWnipTK/d6D6EYlr0Qp+Hy
	bYHDTu2OduDkeTL/JPGJfLIHNPvG1IMBj2vGL/S+ywoodvbh5FlyeYK3K9bgS1dl
	p/SP3CP2uWErMGLKjHavyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763370483; x=
	1763456883; bh=PO+HprFxowvXbocpvtAlTvfgsKxJ9kwRQfs+WUVErPM=; b=g
	tUVWTtWQ9suuL5LE40z44bT+w2Tc0tk/1HmA3x9NuY7ziwGlRqlDman8J8F+71vg
	cJjaFHJwUtsw3qZFyN26JF6jMgwp31QPsqVrNdgbjXK2/6jgC0wwOeWJpNQFivE/
	HNvR4jVkAzHAutI9LXVQf+DqiG76fwr0PweuF+MT8xQ2vx+wQw3yZRr7UF+kUQV1
	Xg8iyh9qRWPxSxPwtDx9mNzu92I62pxTQ0lNapNUJ/ICsMWWAfyo//0yAFCDRDet
	fs6QP2t2z+xOWIxUVzhiLWKDzIKAadJiuiK86z7wKnz0KY3UwoNfAZKfPITmz8CB
	M4IPzbNXf9ffR8J+y8BdQ==
X-ME-Sender: <xms:8uUaaUo3h4NKJxokYbYGzN1po5V5t6oJllHAQTC1H277R2Kv3GeaKA>
    <xme:8uUaaVfaBXz5BBBqyxYdy3U_GsM1p8yCymviuTaYLY2gksVrVsmVRFbKV2JdtG4Pi
    qve-MD0bAgnWxMFJdbNGD6ldAB329EE_UMjPDMSOqID6Rcp06-5MlH5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudektdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8uUaaXkPpeIadKJMvzQsGDBOWh1Tjcyb_HYNz-fc5QIn_5I_yTtsIA>
    <xmx:8-UaaQCUOi64x4mS4xdvxIWltUmj6-C2bwKXVe8MKvDIl17qfISE1Q>
    <xmx:8-UaaRCMU9_LSXcsRQbaYW2jNnFweHe2YeZWhDYIUnZBMUItkuS2VA>
    <xmx:8-UaafFBR8Oni9HUqk8SYx1FY8THGzhwWa1NMngIWtX0bbzWGBCJDw>
    <xmx:8-UaafQesAiugEDtRmw1jUGiKcTBd3esQoZhIahysN1L032ZoLvjuIN3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DF8F9700063; Mon, 17 Nov 2025 04:08:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO4N9SNPwumV
Date: Mon, 17 Nov 2025 10:06:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Chen Wang" <unicorn_wang@outlook.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>, stable@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
Message-Id: <37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com>
In-Reply-To: <7eaa4d917f7639913838abd4fd64ae8fe73a8cfc.camel@ti.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
 <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
 <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
 <201b9ad1-3ebd-4992-acdd-925d2e357d22@app.fastmail.com>
 <7eaa4d917f7639913838abd4fd64ae8fe73a8cfc.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from tristate
 to bool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 17, 2025, at 07:05, Siddharth Vadapalli wrote:
> On Fri, 2025-11-14 at 08:03 +0100, Arnd Bergmann wrote:
>> On Fri, Nov 14, 2025, at 06:47, Siddharth Vadapalli wrote:

> I understand that the solution should be fixing the pci-j721e.c driver
> rather than updating Kconfig or Makefile. Thank you for the feedback. I
> will update the pci-j721e.c driver to handle the case that is triggering
> the build error.

Ok, thanks!

I think a single if(IS_ENABLED(CONFIG_PCI_J721E_HOST)) check
is probably enough to avoid the link failure

--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -669,7 +669,8 @@ static void j721e_pcie_remove(struct platform_device *pdev)
        struct cdns_pcie_ep *ep;
        struct cdns_pcie_rc *rc;
 
-       if (pcie->mode == PCI_MODE_RC) {
+       if (IS_ENABLED(CONFIG_PCI_J721E_HOST) &&
+           pcie->mode == PCI_MODE_RC) {
                rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
                cdns_pcie_host_disable(rc);


but you may want to split it up further to get better dead
code elimination and prevent similar bugs from reappearing when
another call gets added without this type of check.

If you split j721e_pcie_driver into a host and an ep driver
structure with their own probe/remove callbacks, you can
move the IS_ENABLED() check all the way into module_init()
function.

     Arnd

