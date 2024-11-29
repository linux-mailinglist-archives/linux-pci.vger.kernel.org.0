Return-Path: <linux-pci+bounces-17446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06E9DC164
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 10:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D4716446B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08022175D35;
	Fri, 29 Nov 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ddo/KhnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZt1gedD"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F5156F28;
	Fri, 29 Nov 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872228; cv=none; b=WikJCEf4eglfAAwzIm4jeWP76ftVzYQxQiHuOlcPSuh75pauU5w8rj0BAuwEq2+c8T0Ld/x6slTAL2tV64yj5ZLyL2p6I2zU5+9P5vAmWIRiY0JjIOVW70sfKiFxcvWsRQfmHzgbhubtAR+di0i0BajYfmDOwlTz/CVsgiB+dvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872228; c=relaxed/simple;
	bh=+B/4weM0/EUGguG/BqQcks88RtE9urCqPFe8Kwp9UB4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Io8EHP/KiFf6j0DecGR0qaSZ+xecyvzAZ09IuVtLR3kUpjItiH1S7uL4EypW0jY1aGM9KEo8VPfeK46UeWmvZtBX3SUlys+pWjVdlEsMNnQ7+GdXb4sRxW9bC3rttIlz43uDW8zM7uuCh62/4I67AZcZ2SicTKujqA0TwxfoKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ddo/KhnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tZt1gedD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07B7625400F5;
	Fri, 29 Nov 2024 04:23:45 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 29 Nov 2024 04:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732872224;
	 x=1732958624; bh=6JoH9bTLLNPgqK4rstk02jf2g1g5I4XEBTfZgtUBOaU=; b=
	Ddo/KhnB/zvVE0eA+K+XdWB/soHKnOPOOmDyAnGvTKmKSrM80jkWjrdR/eW1a10u
	hDiS8ZljUw1ee79JC2JMlqXNmoaobS+MDnTY12XV74X4XwLdnde6lu0ZSHSp6FUt
	zy4ZzgyPR53mKV55Ou4bprp1aNHmKyOveZrnHMV0KkaZMd1OGZD7PHnk4tbbFDzn
	8AGWRZa+QMcLaqCZwiWqja7Zeeg88A8nO04bShOuxDtdQh3LvhjZpamuiQ34n0Cz
	q4NJgVcskQ9QlbDExitYtLle3KEwjaVH1TB6yTIVkMdZZAhqR7RGHuc7D9kIcul/
	t6gRhNARly08EZRGKWmIvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732872224; x=
	1732958624; bh=6JoH9bTLLNPgqK4rstk02jf2g1g5I4XEBTfZgtUBOaU=; b=t
	Zt1gedD41mirEjCd0k8Ry7bsJ7WNAJ5hzfyvUz1CaQtooYr7s+ENutSJHOma8PNS
	XJ5XBgvqR3qTGxWzkTyzXnmz1ye31iWQAAauSFLt+z86xdXZSeFbWOOGDK9iFI2v
	0F8NHUcYiBbgNxium9R7WKhJkShQVxdygDpHesV4HXP398wtx9paTpUnQfp0ArkM
	Sk54toAgkqETaDfa2mGjiFxF2m3VQmF4N8+sIjOtywV1kVhQlNx39k34xpyhrZfL
	S8YKy6XHHywCddE90HDC8O/iwgURjsmtPCe5YrbVY5ESGdepUSvWNilT2MS3o6Fi
	sF3FYFZHRlbSiZq+e2FhQ==
X-ME-Sender: <xms:H4hJZ2wScKKDoFkbmffti2XgLRon-rOtXwdmdn1I06hG8Y_7Rkiexg>
    <xme:H4hJZyT8ysWmzOdm8l7RET9uRPFzX65262mo90h_HfZ2znHDnccno0AVXzZl3kqNM
    MaAu3LYP0ILp3b4t_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeej
    vdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeffedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvrhgvkhdrkhhivghrnhgrnhesrg
    hmugdrtghomhdprhgtphhtthhopegurhgrghgrnhdrtghvvghtihgtsegrmhgurdgtohhm
    pdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtg
    hpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphht
    thhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnugih
    rdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdprhgtphhtthhopegshhgvlhhgrg
    grshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomh
X-ME-Proxy: <xmx:H4hJZ4ULhjYre35Nr7LeimF34eDMT9QrYAEfvNLxQ4HCSaTeF-ZLPw>
    <xmx:H4hJZ8jR697AYXyTB0_yJGKBx7Rr_wRabBiuDS9kaxfe5gelt6ANRA>
    <xmx:H4hJZ4DGhdlI5HRWqxuGrW0gYHU11SKPh02XxTqCJ0hNpjkNIW8_fQ>
    <xmx:H4hJZ9IgM013bnDtM7LQ9mwj85lQkdwUQ0OR4axgWyptEYcrYufw7A>
    <xmx:IIhJZwa_k9cjV1TQWoNQPYleFfTjyB1NFLrbiBqw5uTGZlE1MY0Xmn5N>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B95212220071; Fri, 29 Nov 2024 04:23:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 10:23:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Herve Codina" <herve.codina@bootlin.com>,
 "Michal Kubecek" <mkubecek@suse.cz>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Simon Horman" <horms@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Lars Povlsen" <lars.povlsen@microchip.com>,
 "Steen Hegelund" <Steen.Hegelund@microchip.com>,
 "Daniel Machon" <daniel.machon@microchip.com>,
 UNGLinuxDriver@microchip.com, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 "Andrew Lunn" <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Allan Nielsen" <allan.nielsen@microchip.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Message-Id: <93ad42dc-eac6-4914-a425-6dbcd5dccf44@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdWXgXiHNUhrXB9jT4opnOQYUxtW=Vh0yBQT0jJS49+zsw@mail.gmail.com>
References: <20241010063611.788527-1-herve.codina@bootlin.com>
 <20241010063611.788527-2-herve.codina@bootlin.com>
 <dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
 <20241129091013.029fced3@bootlin.com>
 <1a895f7c-bbfc-483d-b36b-921788b07b36@app.fastmail.com>
 <CAMuHMdWXgXiHNUhrXB9jT4opnOQYUxtW=Vh0yBQT0jJS49+zsw@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] misc: Add support for LAN966x PCI device
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024, at 09:44, Geert Uytterhoeven wrote:
> On Fri, Nov 29, 2024 at 9:25=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Fri, Nov 29, 2024, at 09:10, Herve Codina wrote:
>> I would write in two lines as
>>
>>         depends on PCI
>>         depends on OF_OVERLAY
>>
>> since OF_OVERLAY already depends on OF, that can be left out.
>> The effect is the same as your variant though.
>
> What about
>
>     depends on OF
>     select OF_OVERLAY
>
> as "OF" is a clear bus dependency, due to the driver providing an OF
> child bus (cfr. I2C or SPI bus controller drivers depending on I2C or
> SPI), and OF_OVERLAY is an optional software mechanism?

OF_OVERLAY is currently a user visible option, so I think it's
intended to be used with 'depends on'. The only other callers
of this interface are the kunit test modules that just leave
out the overlay code if that is disabled.

If we decide to treat OF_OVERLAY as a library instead, it should
probably become a silent Kconfig option that gets selected by
all its users including the unit tests, and then we can remove
the #ifdef checks there.

Since OF_OVERLAY pulls in OF_DYNAMIC, I would still prefer that
to be a user choice. Silently enabling OF_OVERLAY definitely has
a risk of introducing regressions since it changes some of the
interesting code paths in the core, in particular it enables
reference counting in of_node_get(), which many drivers get wrong.

      Arnd

