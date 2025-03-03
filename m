Return-Path: <linux-pci+bounces-22745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D418A4BB30
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE46168BC0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6071F1505;
	Mon,  3 Mar 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RDhKJa8j"
X-Original-To: linux-pci@vger.kernel.org
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
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Bjorn,

On Fri, 28 Feb 2025 15:21:57 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Feb 24, 2025 at 03:13:55PM +0100, Herve Codina wrote:
> > PCI devices device-tree nodes can be already created. This was
> > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > bridge").
> > 
> > In order to have device-tree nodes related to PCI devices attached on
> > their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> > root bus device-tree node is needed. This root bus node will be used as
> > the parent node of the first level devices scanned on the bus. On
> > device-tree based systems, this PCI root bus device tree node is set to
> > the node of the related PCI host bridge. The PCI host bridge node is
> > available in the device-tree used to describe the hardware passed at
> > boot.
> > 
> > On non device-tree based system (such as ACPI), a device-tree node for
> > the PCI host bridge or for the root bus does not exist. Indeed, the PCI
> > host bridge is not described in a device-tree used at boot simply
> > because no device-tree are passed at boot.
> > 
> > The device-tree PCI host bridge node creation needs to be done at
> > runtime. This is done in the same way as for the creation of the PCI
> > device nodes. I.e. node and properties are created based on computed
> > information done by the PCI core. Also, as is done on device-tree based
> > systems, this PCI host bridge node is used for the PCI root bus.
> > 
> > With this done, hardware available in a PCI device that doesn't follow
> > the PCI model consisting in one PCI function handled by one driver can
> > be described by a device-tree overlay loaded by the PCI device driver on
> > non device-tree based systems. Those PCI devices provide a single PCI
> > function that includes several functionalities that require different
> > driver. The device-tree overlay describes in that case the internal
> > devices and their relationships. It allows to load drivers needed by
> > those different devices in order to have functionalities handled.  
> 
> Since this adds host bridge nodes, does this patch specifically enable
> device tree overlays for devices on the root bus?
> 
> Were we able to load DT overlays for devices deeper in the hierarchy
> already, even without this patch?
> 

This patch itself doesn't need any support for overlay.

Yes, without this patch we can load overlay but only on a device-tree based
system. This is done by the driver that needs an overlay to handle the PCI
device. This patch is needed to load overlays in the same way on non
device-tree based system i.e. on ACPI systems.

Best regards,
Hervé

