Return-Path: <linux-pci+bounces-21969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666C4A3EEC4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 09:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119DB4211C2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A5C201004;
	Fri, 21 Feb 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S6J7F+HS"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F720124F;
	Fri, 21 Feb 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126874; cv=none; b=obPy4DSZb4WdNRw/xATnVQOcxlSJnlmOXZ6EhbwhJBBnKO+1CulxsORJIhx0UFrZYDTvvrnaUtqqV7fVGOcSNPw2OfdmuQPA/9TC7hrjVUCmPby4IATqPDlMTHbA0to8XhzmMymlrFyBtEYoSWtjOqBfh048cmNnENvuoBc8o08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126874; c=relaxed/simple;
	bh=zaRVgOwT6oHtTXJXZK0GZbB0pQZQMS4QkIAurMtM3n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLd920nPgxZyrxR3fCp4W7275Ammr5BhqU/jPB9/YBuU2vDSKKF1ZlLOiMtqM/d/lZZkBMYJz/uA7TiesWQHoUe1EscZq7g7l6+9dyRSxpP9OOsnfyjI0InWZUo4wkurgAIJkNisM4p8cc8XcJZdLcvXGrlBqb2y6evno4fjnCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S6J7F+HS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAC6E441A2;
	Fri, 21 Feb 2025 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740126869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/hAkJYr1MTXE9QbhqHRx2R7LVjm7if7A1UAshiK8iY=;
	b=S6J7F+HSU6fkbzT/xMd0/SL98AE2wV0CoKq8rM+XYmDbhRWG3tFkghZxib6ka+ec7KZbqB
	jp3gBXxgeEoUu9YXAB5kPtIdVI+HQsY20CG4sFucuSrOR7mG6H5brnTBDG/by+zBjXVjBJ
	CxRq2ejdwFCj02OY+3ukR7/455eiRPl99ETBfsN4IGdsZpjm4rKe48ZkYaXePW/ZDhwuKA
	v+nehWCDKuhOFG7boEFHeOgbgheOZ/lpdzVMq+RJgkhwH5q1JAN0VR4AIKhoeRn88wumzi
	Q3quNVewISor9FwIAsM1j1Ci+p+jOtald7upPYIsgz49EOFLK931TraNLBu9zw==
Date: Fri, 21 Feb 2025 09:34:27 +0100
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
Subject: Re: [PATCH v7 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20250221093427.3d83b9e3@bootlin.com>
In-Reply-To: <20250221000753.GA321042@bhelgaas>
References: <20250220092514.444e90e4@bootlin.com>
	<20250221000753.GA321042@bhelgaas>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Bjorn,

On Thu, 20 Feb 2025 18:07:53 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Feb 20, 2025 at 09:25:14AM +0100, Herve Codina wrote:
> > On Wed, 19 Feb 2025 11:39:12 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > On Tue, Feb 04, 2025 at 08:35:00AM +0100, Herve Codina wrote:  
> > > > PCI devices device-tree nodes can be already created. This was
> > > > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > > > bridge").
> > > > 
> > > > In order to have device-tree nodes related to PCI devices attached on
> > > > their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> > > > root bus device-tree node is needed. This root bus node will be used as
> > > > the parent node of the first level devices scanned on the bus. On
> > > > device-tree based systems, this PCI root bus device tree node is set to
> > > > the node of the related PCI host bridge. The PCI host bridge node is
> > > > available in the device-tree used to describe the hardware passed at
> > > > boot.
> > > > 
> > > > On non device-tree based system (such as ACPI), a device-tree node for
> > > > the PCI host bridge or for the root bus does not exist. Indeed, the PCI
> > > > host bridge is not described in a device-tree used at boot simply
> > > > because no device-tree are passed at boot.
> > > > 
> > > > The device-tree PCI host bridge node creation needs to be done at
> > > > runtime. This is done in the same way as for the creation of the PCI
> > > > device nodes. I.e. node and properties are created based on computed
> > > > information done by the PCI core. Also, as is done on device-tree based
> > > > systems, this PCI host bridge node is used for the PCI root bus.    
> > > 
> > > This is a detailed low-level description of what this patch does.  Can
> > > we include a high level outline of what the benefit is and why we want
> > > this patch?
> > > 
> > > Based on 185686beb464 ("misc: Add support for LAN966x PCI device"), I
> > > assume the purpose is to deal with some kind of non-standard PCI
> > > topology, e.g., a single B/D/F function contains several different
> > > pieces of functionality to be driven by several different drivers, and
> > > we build a device tree description of those pieces and then bind those
> > > drivers to the functionality using platform_device interfaces?  
> > 
> > What do you think if I add the following at the end of the commit log?
> > 
> >    With this done, hardware available in complex PCI device can be
> >    described by a device-tree overlay loaded by the PCI device driver
> >    on non device-tree based systems. For instance, the LAN966x PCI device
> >    introduced by commit 185686beb464 ("misc: Add support for LAN966x
> >    PCI device") can be available on x86 systems.  
> 
> This isn't just about complexity of the device.  There are NICs that
> are much more complex.
> 
> IIUC this is really about devices that don't follow the standard
> "one PCI function <--> one driver" model, so I think it's important to
> include something about the case of a single function that includes
> several unrelated bits of functionality that require different
> drivers.

Yes.

> 
> "LAN966x" might mean something to people who know that this thing has
> a half dozen separate things inside it, but the name by itself doesn't
> suggest that, so I don't think it's really helpful to the general
> audience.
> 

Does this one at the end of the commit log sound better?

    With this done, hardware available in a PCI device that doesn't follow
    the PCI model consisting in one PCI function handled by one driver can
    be described by a device-tree overlay loaded by the PCI device driver
    on non device-tree based systems. Those PCI devices provide a single PCI
    function that includes several functionalities that require different
    driver. The device-tree overlay describes in that case the internal
    devices and their relationships. It allows to load drivers needed by
    those different devices in order to have functionalities handled.

Best regards,
Hervé

