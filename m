Return-Path: <linux-pci+bounces-31258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66482AF5822
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ABF4A0398
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60C42AA3;
	Wed,  2 Jul 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OxJo/61J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oioy0nL0"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBD238171;
	Wed,  2 Jul 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461838; cv=none; b=M3P0TSDdeYHGd+GPtNfAiqQEZHnTzZB3t/Hq0KsIa4L5ljlC1BjwFw/DyxFOFXH8SBNgkZOjunSXzNWmyM3XBhG+LDD/Ne6P3VAYGMKz8czxIUzgNrewFzJUCYCWwd5ZUijB0fPbgvITl0I60TdkFgb3bVELPWyj0Kn+y6MlUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461838; c=relaxed/simple;
	bh=9XLrbCw1N01QjplnBFVI2vCLvEjPgQ/3fvn7M31CDMM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b7j0mJf9ORzelPY4+JgNeTg+bvSF7Qli0gdESdDaOgxBKmK0sHPJO/dozsvyAKVoztlG984Zwc5B5jnXfVTa/yRXu7sfMrxTYZbGPP10Aw91HgQvkTQTxY45C923s0/xXK9q+W4GZv0EUr1xz6r6AaOVC6o+R4QgTM947Az9Mqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OxJo/61J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oioy0nL0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76C7E7A011C;
	Wed,  2 Jul 2025 09:10:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 02 Jul 2025 09:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751461834;
	 x=1751548234; bh=CM3Dw6fk0gSQNr36cfugEFxzFt86GurJoNVnL/gx6DQ=; b=
	OxJo/61J9FxWBD5vXi51ni4VO3YDjHIsSBVAI1jDDpHYnFBAVYW+lcRzpOhHKJ/L
	FDRH5eroTw9O8Vol6a/LcRcPGdSQd/VJu0CV/uBp0K2wx9W3XO/yo3ehYO1ZzzFl
	/VE6KY1I4YU5aKjdcjrp6hKwTI6FbAc6NzqCY8qi9038GWPAroOJ1qvS1RbZ3bxk
	hMDOZgasYMA3Kzw/dY9me9pZjGES+x0hWnzAjOxMcJETVZs7ck3GrDwWI2WdYkZZ
	NOXrrvGQal52e26lbILJWmHz15Q/98duAYC3PZv5irq2pSK81pS+3qsUdfwYfdep
	B3GmKnD7dk0bApFwVV8Pqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751461834; x=
	1751548234; bh=CM3Dw6fk0gSQNr36cfugEFxzFt86GurJoNVnL/gx6DQ=; b=O
	ioy0nL0UuuH/VEUCszIpHiwpflPl8+BXJ816b/fzc9Jp/RTFeZKdsQoIplenPgBS
	AfP7YF9hlZsZCXXxRWp5sT789xeYk/625OGxxhRrc3Fw/rG+T7dj8lkEq8AO+YQp
	sJCYVVB6NtOj//m0bfOCFdCVapIGPF2IBbqqH2i5mx97VEe8zTGXRql24q/FIjVT
	SBUbNrEtoGsaV8FMlA96CCEhBS1frY9ryRX981Tf1ufnoxOmYG/JzY8yMv27fAlQ
	w0Cj0vqdiRKtX38OuCnYjLzAHO1wVWRng+5tgGS+FyyWtJkI1nyn2uCEbr/ZzdJE
	toxKktTfKs+HjCJrKC4bA==
X-ME-Sender: <xms:yC9laH3rtdKfBplfWPFJcQbY5j5AKXtVIWrfLx-N7hyea5W56mf3eg>
    <xme:yC9laGGuOe4L0aNp-mefHz2cjYFE6UfxUJMuhnr1LoDh0tJk4fCdWuX3JQm4gIxiI
    aNz2KMooFRX-jupWxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehsrghs
    tghhrgdrsghishgthhhofhhfsegrrhhmrdgtohhmpdhrtghpthhtohepthhimhhothhhhi
    drhhgrhigvshesrghrmhdrtghomhdprhgtphhtthhopehsfhhrsegtrghnsgdrrghuuhhg
    rdhorhhgrdgruhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdp
    rhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hirhhishhlrggshieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yC9laH69BhhdIzMOjdAALm72oNgRutcG7Q4g4hoSRIetagBiwpVjHQ>
    <xmx:yC9laM1OKYIG1lJfC1tCMaok8A9Eo361dNg47oYEE2W6vej_M0sFzw>
    <xmx:yC9laKF_oi88OqTJZV_fCnh3MYBsX-Vnbiyp-bA95w3kd0U_xYKz-A>
    <xmx:yC9laN-ZLQ6oSxli4TXPq31FzgpUCl6ph9hE5TdtWMUBl1fyGr9SPQ>
    <xmx:yi9laEmXJtgcOFm7oVPKQmrrLqGk_gvqYdiWuvDo3A679EPdanbb0P1v>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D2377700065; Wed,  2 Jul 2025 09:10:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8b561bdf24069c70
Date: Wed, 02 Jul 2025 15:10:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Sascha Bischoff" <sascha.bischoff@arm.com>,
 "Timothy Hayes" <timothy.hayes@arm.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Slaby" <jirislaby@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <09dd654f-c7d7-4046-92a7-ee4e9f8076d3@app.fastmail.com>
In-Reply-To: <aGUqEkascwGFD9x+@lpieralisi>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
 <20250626-gicv5-host-v6-20-48e046af4642@kernel.org>
 <20250702124019.00006b01@huawei.com> <aGUqEkascwGFD9x+@lpieralisi>
Subject: Re: [PATCH v6 20/31] irqchip/gic-v5: Add GICv5 PPI support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 2, 2025, at 14:46, Lorenzo Pieralisi wrote:
> On Wed, Jul 02, 2025 at 12:40:19PM +0100, Jonathan Cameron wrote:
>> On Thu, 26 Jun 2025 12:26:11 +0200
>> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>> 
>> > The GICv5 CPU interface implements support for PE-Private Peripheral
>> > Interrupts (PPI), that are handled (enabled/prioritized/delivered)
>> > entirely within the CPU interface hardware.
>> 
>> I can't remember where I got to last time so if I repeat stuff that
>> you already responded to, feel free to just ignore me this time ;)
>> 
>> All superficial stuff. Feel free to completely ignore if you like.
>
> We are at v6.16-rc4, series has been on the lists for 3 months, it has
> been reviewed and we would like to get it into v6.17 if possible and
> deemed reasonable, I am asking you folks please, what should I do ?
>
> I can send a v7 with the changes requested below (no bug fixes there)
> - it is fine by me - but I need to know please asap if we have a
> plan to get this upstream this cycle.

I think the priority right now should be to get the series into
linux-next, as there is a good chance that the added regression
testing will uncover some problem that you should fix.

I had another look at all your patches, mainly to see how much
of them actually change existing code, and there is thankfully
very little of that. Without actual gicv5 hardware implementations
there is very low risk in adding the new driver as well: anything
that still comes up can be fixed on top of v6 or a v7 if you send
it again.

I assume that Thomas will make this a separate branch in the tip
tree, given the size of the series. If he still wants to wait for
more feedback or changes before adding it to tip, I would suggest
you ask Stephen to add your latest branch to linux-next in the
meantime.

    Arnd

