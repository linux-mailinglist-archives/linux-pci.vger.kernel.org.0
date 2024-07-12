Return-Path: <linux-pci+bounces-10206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091492FC56
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 16:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248091C2115F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3977B171644;
	Fri, 12 Jul 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pZVEWh9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+4fH3QW"
X-Original-To: linux-pci@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239322318;
	Fri, 12 Jul 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793696; cv=none; b=gOCNtcvlcUYMGXM3jXWBruayU85QloqKAi96ly8Q7cKPnOCIeSWSyLIwFfMtSmFX1KfVIFNa7SwF4qD9RZ72S3Dini0xvi7KBMdltfgHvWZsEtE/jQ/rBQoRKfxP6Mw78XBXp6IidhMMojOSVh9uDUOhl7PHofovgC7alurJEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793696; c=relaxed/simple;
	bh=BgA2R8gexmF+9ke0asXQJoh/HhRGzQ61Tx/Nl5xODjQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PSNrAXRcT8Q03+1V9MOhEFLQXBwfgT7e45exAuo2jIlDvbBdmxCxg4XWSCCd70dIEtNkrwTHDM2PGfEgRD+qzi6tU9FArxyWQABeB3BxTezAOLBIBocgewbwGK7ibdVFcCgFDLbT8xCe7EZ2MyZl/njf4dz11SNFQdq1c5LjFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pZVEWh9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+4fH3QW; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 8BB2C20093B;
	Fri, 12 Jul 2024 10:14:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 10:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720793693;
	 x=1720800893; bh=BftO1T01GSoM+8PN7T8u36RJnUOU1h1HJSVyxCSIoSg=; b=
	pZVEWh9I9vaFUzPoxT4jjeIXw4w+iLT4gdX8/IgwDmz2wBQMJvic9nkXpWWlbot8
	23LJZyL4jQ+5fnV3bBqS/zXvFprAoSNNEOhWOn3rEZfaHRlQeJpe3uMDUr3TPsoi
	/sEgfw40wB1bSxWvvvTqMv1xyJ1QKjRPeXipari7ix3SyB44PgX0JJmDIFiFoSjU
	H5zurUUlDdUv63dMdGnC5EHvW306VoPoYrNd44RWOowof0x6yKp06qGkDRrWvQOH
	tq26sKpffn7SgagR+AMtsOZ1DBeNQ4hlGRaLu9ROoWN457zp7yUtWhv22dqOmX7G
	NTKfxZG3xskq/sKVFx7lBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720793693; x=
	1720800893; bh=BftO1T01GSoM+8PN7T8u36RJnUOU1h1HJSVyxCSIoSg=; b=t
	+4fH3QW+ZHGR2/aEYsu9wdw8vCyyikX7mmCZ+u/Rv3h+oxA43l55QvbLvK1nWtnB
	FkzGOWO3N2b0J1Pguaa1A74K3RdX16HWgARrbL3AeqcaprAhulEIFyUwYWwpN1OB
	CYLGNzIuqyiThSspX0vyR4Tan6IWOa8XnkaLSy3F+kfp1UYJH+Au4Jx+4qEFiTyH
	jxeUe0XULgXoUEZNNzJqNs3VaVxb9QWPD4mXBSbE+ew4XoiCzLXs+85tUpggxNgd
	l9JMWdX7sM3eqTwgza/GEoaUyun2IdqEf1XghJu8TXfj5ktWgk8fifV9UJO8bVwe
	rDwX9Ria2lOJj/11UMSPw==
X-ME-Sender: <xms:XDqRZugrECnBKUPW6cIbA8bOPTUdNrUQR4BV5O4I-_8vP9W0Tmy2TA>
    <xme:XDqRZvA9K_Wsxl0ZKU9jzkp7T7uZz1eiTOP2umcHzEYUacgth8Nma1WfXK8w_-T4I
    o7iPMR5drMQysA2-A4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XDqRZmFXr23rR1gZgW30f5dQg6MfGpebMOHRppimKy7JdjfwA1PyLQ>
    <xmx:XDqRZnTGeCz_MYMQwQcFHdReda53d7Et3W5uNIbO7o2uLDMLJ-ubDQ>
    <xmx:XDqRZrx77Dgnt22QYXjFE0ZjWble_yDqRkuwhoNmbDhfTaPP9xXVoA>
    <xmx:XDqRZl4zEk5uGGsRhf2n4hcFwCnUwhK_bocHmXukig3hvO84QKxJAQ>
    <xmx:XTqRZmKWIEikoCW9PIG3CwX-uvy-tWEID1pCFI2viaApfw9xOM1vZDMb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3C3BBB6008D; Fri, 12 Jul 2024 10:14:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com>
In-Reply-To: <20240712151122.67a17a94@bootlin.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
 <20240627091137.370572-7-herve.codina@bootlin.com>
 <20240711152952.GL501857@google.com> <20240711184438.65446cc3@bootlin.com>
 <2024071113-motocross-escalator-e034@gregkh>
 <CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
 <20240712151122.67a17a94@bootlin.com>
Date: Fri, 12 Jul 2024 16:14:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herve Codina" <herve.codina@bootlin.com>,
 "Rob Herring" <robh@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Conor Dooley" <conor@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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

On Fri, Jul 12, 2024, at 15:11, Herve Codina wrote:
> On Thu, 11 Jul 2024 14:33:26 -0600 Rob Herring <robh@kernel.org> wrote:
>> On Thu, Jul 11, 2024 at 1:08=E2=80=AFPM Greg Kroah-Hartman <gregkh@li=
nuxfoundation.org> wrote:

>> > >
>> > > This PCI driver purpose is to instanciate many other drivers usin=
g a DT
>> > > overlay. I think MFD is the right subsystem. =20
>>=20
>> It is a Multi-function Device, but it doesn't appear to use any of the
>> MFD subsystem. So maybe drivers/soc/? Another dumping ground, but it
>> is a driver for an SoC exposed as a PCI device.
>>=20
>
> In drivers/soc, drivers/soc/microchip/ could be the right place.
>
> Conor, are you open to have the PCI LAN966x device driver in
> drivers/soc/microchip/ ?

That sounds like a much worse fit than drivers/mfd: the code
here does not actually run on the lan966x soc, it instead runs
on whatever other machine you happen to plug it into as a
PCI device.

      Arnd

