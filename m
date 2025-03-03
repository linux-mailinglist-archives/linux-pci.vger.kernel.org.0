Return-Path: <linux-pci+bounces-22861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B39A4E3D7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0492A7AA5C6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F1261578;
	Tue,  4 Mar 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BlXvatPq"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474A25525E
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102027; cv=fail; b=B/jgzTCgevhljOLXvuDRVbogLHYaSp7WxPq7ByJvUmz6sampDHKUFrPvXu9qVkubLdXHF7YFzIEnp9YLVcCM+99yMZccpWlhAManTjSQciky+FXbGGKsVBgLgdel4iuqt7dIzKvSMRezu71zKtX5IKEyvtSsTkhhGJTDbCDtdBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102027; c=relaxed/simple;
	bh=sN4YSNfJeXwI6mPGqMCpZpwXwEjPNNbxYaAxaMDv8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvXtcjWLyjvEn7xMxz9i4QF1JzZe04ytUwPmlg7tRS2PUu2jcur3HhawombrQM9DFiJDnRhaqosPDAo065U2dOxlKCOXnS1bhAtn/rijDrldRSye4wBm5BOVFshurzI9h5uWAADBuZqmO8/BxNJzrJ+3/XOFW8fg4imqttV/8m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BlXvatPq reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.193; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id E98AB40D1ECC
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:27:03 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fcl1mDyzG0Kn
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:24:55 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8B1544274C; Tue,  4 Mar 2025 18:24:47 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BlXvatPq
X-Envelope-From: <linux-kernel+bounces-541291-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BlXvatPq
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 6F153432D3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:43:20 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 4C6392DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:43:20 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236381892A78
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F911F1517;
	Mon,  3 Mar 2025 09:43:06 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B151CDFCA;
	Mon,  3 Mar 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994983; cv=none; b=ubD85LpSwCDvu/aZez4O2pkwLHip2qBe1IOapu6YdoYkHZanbEwERTcSa1KjVQGvsYcbMNu9Qu5ac9EPxanHE+i7yy1LFMaXtdG96wHnP98baKmcOjzEH9AuLrbIjCzsik1zzfrygeO6uqjNuwCbMMfTMmGCRK4ceVg5ivRyRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994983; c=relaxed/simple;
	bh=Ef92XLEjUubEUguFoFaEsSiJbp2zpAJ3HBgHzHTie0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHG6U1JJwnmoY1tYTwF/0bsQgNVuCxNpceZ98u8ilW0Liyk9EcjCQqINiObK+46GjCM7XjKc915pXYaUOP/kth8qeSXg5sxxN2QFT+xIXF9FeObePn3t6hFRnwIv8XgQOmzsvSi6fXWoltvHUfN/LxqbyflYSvl6oOzvuRUwUow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BlXvatPq; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E476243308;
	Mon,  3 Mar 2025 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740994979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aohfSAJAihchV7qkXkrdXJ9Pj4eAK1H+KH7QBBsTIk4=;
	b=BlXvatPqxMPRvd6/D9QDvMcM6PIzd/xRBddwsU+RNRT9dt5gXyksu4odKthtnWZQjSJ6as
	Ff7dBmKLfYCeECddGoIWPHB21IjSLaYhHMn0nlzxtRfZte7X/8IP2LnLCr7YShrA3vFXsU
	+1KkfK2HOIT75WA3ct9BGp2vzauUUJZYQkDhPrVCc8BA8zhDVWYWDu6AtkalQWq2EoIlCu
	pufyw2tRBwZbBklZ4LGgaaSKfYpxf6UJJXti9H66EZyJ268bAk8HESRbjPN5Xj6mFwzGSG
	Q7Pp67li5M1vQXb8btIPoFEsF2Wt6sYts8fdmoDCt1NLX7Y6/QFcgWcp3mv9Pg==
Date: Mon, 3 Mar 2025 10:42:56 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 2/5] PCI: of: Use device_{add,remove}_of_node() to
 attach of_node to existing device
Message-ID: <20250303104256.48329d89@bootlin.com>
In-Reply-To: <20250228205855.GA67436@bhelgaas>
References: <20250224141356.36325-3-herve.codina@bootlin.com>
	<20250228205855.GA67436@bhelgaas>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomh
X-GND-Sasl: herve.codina@bootlin.com
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fcl1mDyzG0Kn
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706718.48275@BJPeJlMx4ObtIQJeCz3v/g
X-ITU-MailScanner-SpamCheck: not spam

On Fri, 28 Feb 2025 14:58:55 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Feb 24, 2025 at 03:13:52PM +0100, Herve Codina wrote:
> > The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> > creates of_node for PCI devices. The newly created of_node is attache=
d
> > to an existing device. This is done setting directly pdev->dev.of_nod=
e
> > in the code.
> >=20
> > Even if pdev->dev.of_node cannot be previously set, this doesn't hand=
le
> > the fwnode field of the struct device. Indeed, this field needs to be
> > set if it hasn't already been set.
> >=20
> > device_{add,remove}_of_node() have been introduced to handle this cas=
e. =20
>=20
> I guess another way to say this is:
>=20
>   - If dev->of_node has already been set, it is an error and we want
>     to do nothing.  The error is impossible in this case because
>     of_pci_make_dev_node() returns early if dev->of_node has been set.
>=20
>   - Otherwise, we want to set dev->of_node (just as we previously
>     did), and
>=20
>   - if dev->fwnode has not been set, we want to set that too.
>=20
> So the whole point of this is to set dev->fwnode, which we didn't do
> before.  But has np->fwnode been set to anything?  Maybe it's buried
> somewhere inside of_changeset_create_node(), but I didn't see it.

np->fwnode can be set by ACPI. We are at the frontier between ACPI and
device-tree.

The ofnode is created and filled from an already existing device. This
device can be created from information provided by the ACPI world.
In that case, np->fwnode is set to and ACPI fwnode.

Best regards,
Herv=C3=A9


