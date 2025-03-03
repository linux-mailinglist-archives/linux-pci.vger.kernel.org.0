Return-Path: <linux-pci+bounces-22889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697FBA4EA74
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D78A0717
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8F2BF123;
	Tue,  4 Mar 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RDhKJa8j"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB62BE7B8
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109812; cv=fail; b=TOXwkqCSGJQOgys3quzrB0fJHWW83ZXW2bkK+6gJdOLiHOCBl4H/H7X8yQNU3aeyYwV7XgLd4/b+yrPYiMOSjMRAuLs/XvgREUHvO168bsZpe00cK+kJI+F7b5EaXkfkep51Q9Fm0LK6f37ds2TK3AWgo/qReOtadMhlS+mkgyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109812; c=relaxed/simple;
	bh=9zHi+8RomsfhpWtpBaOxr3Ei0qZXgRnHOMl12AmsHbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jakOdVN1jGS3afZia7Ud10tvq5jaH2RzC3aS8OvBdqnUfK1CFu4BRrgplFfoAKj2+gZjy9DmKABIuKV0pKm7haYCFR/4JBreyKeUkwIsNfeHgeK+NGtR889RhDx8JtTcTrqqVc5vy+yiEl7C/JBuRjYWbun8SsVS6oPvWaNurKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RDhKJa8j reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.197; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 3D72F40D0C8F
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 20:36:49 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=RDhKJa8j
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dF34y89zFwZY
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:22:47 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C05574274E; Tue,  4 Mar 2025 17:22:39 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RDhKJa8j
X-Envelope-From: <linux-kernel+bounces-541312-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RDhKJa8j
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 0BF5243271
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:51:24 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 96A142DCE5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:51:24 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226D93ADA48
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD81F153A;
	Mon,  3 Mar 2025 09:50:11 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F01F1300;
	Mon,  3 Mar 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995408; cv=none; b=KB0K+VKeygY6Bq4wXxiXyPlET3k+uvubAPW66BZE8g5t8YOiSaQwO669Wg+NbT+/QXWOkcW1zVvjMhD+kR76LUBiyxv3Ulx9h3E8jBFtsJGFEzAvjTRcKegQfZygs4tQsSlq0rI9h/vbhzyRSwAAqjsCOFCr9Z0wftInSmX1OVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995408; c=relaxed/simple;
	bh=YrL7lBJ8oAc02s3z8Zojwlbn+Tin70LuBO8u1zjAZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awP0LTy2II8gQQgN5j69SpDQRTYDpgUrMees7XVrjbg+/yKsG0PFM8PH0/ARxbU5zSaQXUWmy1yomw8oVdaHjkuWFpsiivRHjy9dqwX4RE/3arWhUuJqK47UOjMohwzMnX47/efg2QcnhNONwIMKIcaYnUuT/aVUHOkla7QFe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RDhKJa8j; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7178432F4;
	Mon,  3 Mar 2025 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740995399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qR5QgJotOCF1eFXi0LYVVo5+GDBF3gUo4Bkrohe5o4A=;
	b=RDhKJa8jRUogPl7e/7nrf2DXZwQzqN+GAvd2OmlhxhcDUbUfVraMOgiSDZzX96MjPlKRFC
	WnO5ic6DAqzZCvLOFV1AybLAJGA3Ovgkad+GichMFvwkVM8Fxa66C3T8VM+s82wl41rBDj
	3fzLZDuo8CmNs0Q44TK+0uoOvDRaop/n5ibv1Zb5ZBnXEqGQrD9maeqMND7grIHREvOTan
	oY9vQv84WiY0MzLx7QUu8lSx6uYdvuxCiwE/xtiJiyCugsJTmufW2yYPEtZ23lrrZqj60J
	CkD1qOAz4Ib3NlnhN0fm29X7eROCYlQLA/doP5qA5LXW0sW9J1EjtTGyoWW7mw==
Date: Mon, 3 Mar 2025 10:49:58 +0100
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
Subject: Re: [PATCH v8 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20250303104958.459e72ed@bootlin.com>
In-Reply-To: <20250228212157.GA70383@bhelgaas>
References: <20250224141356.36325-6-herve.codina@bootlin.com>
	<20250228212157.GA70383@bhelgaas>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomh
X-GND-Sasl: herve.codina@bootlin.com
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dF34y89zFwZY
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714501.81311@p9idSPDlsRoKg6lZP9iewQ
X-ITU-MailScanner-SpamCheck: not spam

Hi Bjorn,

On Fri, 28 Feb 2025 15:21:57 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Feb 24, 2025 at 03:13:55PM +0100, Herve Codina wrote:
> > PCI devices device-tree nodes can be already created. This was
> > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > bridge").
> >=20
> > In order to have device-tree nodes related to PCI devices attached on
> > their PCI root bus (the PCI bus handled by the PCI host bridge), a PC=
I
> > root bus device-tree node is needed. This root bus node will be used =
as
> > the parent node of the first level devices scanned on the bus. On
> > device-tree based systems, this PCI root bus device tree node is set =
to
> > the node of the related PCI host bridge. The PCI host bridge node is
> > available in the device-tree used to describe the hardware passed at
> > boot.
> >=20
> > On non device-tree based system (such as ACPI), a device-tree node fo=
r
> > the PCI host bridge or for the root bus does not exist. Indeed, the P=
CI
> > host bridge is not described in a device-tree used at boot simply
> > because no device-tree are passed at boot.
> >=20
> > The device-tree PCI host bridge node creation needs to be done at
> > runtime. This is done in the same way as for the creation of the PCI
> > device nodes. I.e. node and properties are created based on computed
> > information done by the PCI core. Also, as is done on device-tree bas=
ed
> > systems, this PCI host bridge node is used for the PCI root bus.
> >=20
> > With this done, hardware available in a PCI device that doesn't follo=
w
> > the PCI model consisting in one PCI function handled by one driver ca=
n
> > be described by a device-tree overlay loaded by the PCI device driver=
 on
> > non device-tree based systems. Those PCI devices provide a single PCI
> > function that includes several functionalities that require different
> > driver. The device-tree overlay describes in that case the internal
> > devices and their relationships. It allows to load drivers needed by
> > those different devices in order to have functionalities handled. =20
>=20
> Since this adds host bridge nodes, does this patch specifically enable
> device tree overlays for devices on the root bus?
>=20
> Were we able to load DT overlays for devices deeper in the hierarchy
> already, even without this patch?
>=20

This patch itself doesn't need any support for overlay.

Yes, without this patch we can load overlay but only on a device-tree bas=
ed
system. This is done by the driver that needs an overlay to handle the PC=
I
device. This patch is needed to load overlays in the same way on non
device-tree based system i.e. on ACPI systems.

Best regards,
Herv=C3=A9


