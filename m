Return-Path: <linux-pci+bounces-10372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15F932994
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6252D283503
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A2E19B5A3;
	Tue, 16 Jul 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KrQ+Yfl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hoW7cth5"
X-Original-To: linux-pci@vger.kernel.org
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38919CD0F;
	Tue, 16 Jul 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141077; cv=none; b=EcOxxVwZX9AdTSN1WzUGnnlFmVL38vZppAOJ/E4oGqdSiEV1J9OqYI426E+WJg2kppVdgd66N42rNv5+ov91xK+ZpA0rAI1gkDkliZyCCF5yTHIF+gJSZjqjAbcQoLogB3yItOayxhXF85+Fammc131IGpMb/MyKNa8DoCQY2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141077; c=relaxed/simple;
	bh=mmtDwPVL52S1ppeyOGcnNXo9IJrhAWZKJS7aQ6gfkYw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Tdf32y2mx8S9P7o77QR6OG7AkQAmR7MLbVSWElQQdywZdmW7WNc5yj86OJsc2p9EAfBG7ilRRQyc3PaqkobqgxKclOZqqq0ZZLEB/Qm4FTx1ZO4D93MLurz+qLDx2Pr/dbu/UWn1qxYp1oPPoeBoiXR3A3lzq4FZYZswo5gInsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KrQ+Yfl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hoW7cth5; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id C3416200EC4;
	Tue, 16 Jul 2024 10:44:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Jul 2024 10:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721141074;
	 x=1721148274; bh=HdJd8R2v0UjEhqZCfsPDGAEjh3MgAu1qHR6wGuu4iUc=; b=
	KrQ+Yfl5XPrmhmvBUQ4viYOZ5BU/9t0cJnJKfn8BzZOV7J86Dc27qIzbbyRqmZkN
	L+RIF+FYOYSlA9jzGLh0YACdteyqUPbTWf9bhfOoBLC0IKbem2Y746umkeJYhKO1
	USpO3R7/KM1Wn2fyqJ+PdyaVweaCMbG3cg1BWFtXYswGobw0QF1w5cXK1lFrfVCL
	epgUay9MYSblfwLMYArlaz3dDnUSHBJBEZjVSObVyw1Ia/vi93VsmBqTnsPDPHag
	X48V1hTibYmOFiSNVL8LG1ruAqTy1hNeTfL87eAwqTxlXqaIHQXOT9vz+ojWX8b5
	koXReCi+2dgp1vgChQ7PmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721141074; x=
	1721148274; bh=HdJd8R2v0UjEhqZCfsPDGAEjh3MgAu1qHR6wGuu4iUc=; b=h
	oW7cth5YO/ae5/c6V4w0yozDre/5a5M2vpdkW4jmES5p+r7bMWgWijNxf6QCEgkY
	+orQ7LceDdtdadru66WV0LDdiGUFhuMR9cwR1xXsuX+qWEUbiqvcib5Fuuc1cdQB
	wFtLMZYDjgUFrpD16fAfTeDvShFoJn5y/czLAJl7qglL02WVe7DCyjzVztlH4pGF
	2SA7oPuno3JGV//uaX0SF/7bJmIMI8PScam2x1TXXqZkZ8IUC6IB1BC/o2uUDHjy
	kg101OgHbfAm2gyi9YYXQkVDtgwxhwDj2X99XzouZvFD2fTyXPMDC3Bwfx68wG7i
	MpJWTiBA7vxwW04Hy2DRA==
X-ME-Sender: <xms:UYeWZgOlzLVK6pPrE3NrPY78YiwTPVCb84BmEKwi9A8K1M6Mq7pLGQ>
    <xme:UYeWZm8QHUVGMAHXRL0vdH6hlTv32lXQFgfUJ-22spbA51y-f533cjst5JMMx9NDD
    icg581UmNi3x-mHCVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UYeWZnQR2OnTiBxDMja5WmiWQIWwkoYDv7cvsWUbfM-dGS7Q4W3jIw>
    <xmx:UYeWZosSgaQfnvpklvQAR7hZgOKSA_p44n9zCcSK7SOyHIkfcW8few>
    <xmx:UYeWZoeLBeC2WKu0TGio3_kbWuP1suwlEVoxl62TCsHZz7Tei0V9oA>
    <xmx:UYeWZs1OEpFYJkwzomTzgENZWRrJy_yFywvoeYb9UKks-NVwhwDuPA>
    <xmx:UoeWZvm5iwGDrgAAEN8i-IU9wGdWRNFAEeonKyUof9iwl06HMnKOPR0k>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B26ACB6008D; Tue, 16 Jul 2024 10:44:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7289bb54-99f2-4630-a437-21997a9e2b1f@app.fastmail.com>
In-Reply-To: <20240715141229.506bfff7@bootlin.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
 <20240627091137.370572-7-herve.codina@bootlin.com>
 <20240711152952.GL501857@google.com> <20240711184438.65446cc3@bootlin.com>
 <2024071113-motocross-escalator-e034@gregkh>
 <CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
 <20240712151122.67a17a94@bootlin.com>
 <83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com>
 <20240715141229.506bfff7@bootlin.com>
Date: Tue, 16 Jul 2024 16:44:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: "Rob Herring" <robh@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Conor Dooley" <conor@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Lee Jones" <lee@kernel.org>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Simon Horman" <horms@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, UNGLinuxDriver@microchip.com,
 "Saravana Kannan" <saravanak@google.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Lars Povlsen" <lars.povlsen@microchip.com>,
 "Steen Hegelund" <Steen.Hegelund@microchip.com>,
 "Daniel Machon" <daniel.machon@microchip.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 "Andrew Lunn" <andrew@lunn.ch>, devicetree@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Allan Nielsen" <allan.nielsen@microchip.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 6/7] mfd: Add support for LAN966x PCI device
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024, at 14:12, Herve Codina wrote:
> Hi Arnd,
>
> On Fri, 12 Jul 2024 16:14:31 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>> On Fri, Jul 12, 2024, at 15:11, Herve Codina wrote:
>> > On Thu, 11 Jul 2024 14:33:26 -0600 Rob Herring <robh@kernel.org> wr=
ote: =20
>> >> On Thu, Jul 11, 2024 at 1:08=E2=80=AFPM Greg Kroah-Hartman <gregkh=
@linuxfoundation.org> wrote: =20
>>=20
>> >> > >
>> >> > > This PCI driver purpose is to instanciate many other drivers u=
sing a DT
>> >> > > overlay. I think MFD is the right subsystem.   =20
>> >>=20
>> >> It is a Multi-function Device, but it doesn't appear to use any of=
 the
>> >> MFD subsystem. So maybe drivers/soc/? Another dumping ground, but =
it
>> >> is a driver for an SoC exposed as a PCI device.
>> >>  =20
>> >
>> > In drivers/soc, drivers/soc/microchip/ could be the right place.
>> >
>> > Conor, are you open to have the PCI LAN966x device driver in
>> > drivers/soc/microchip/ ? =20
>>=20
>> That sounds like a much worse fit than drivers/mfd: the code
>> here does not actually run on the lan966x soc, it instead runs
>> on whatever other machine you happen to plug it into as a
>> PCI device.
>
> Maybe drivers/misc ?

That's probably a little better, and there is already
drivers/misc/mchp_pci1xxxx in there, which also has some
aux devices.

Maybe we need a new place and then move both of these
and some of the similar devices from drivers/mfd to that, but
we don't really have to pick one now.

   Arnd

