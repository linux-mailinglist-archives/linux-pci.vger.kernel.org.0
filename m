Return-Path: <linux-pci+bounces-21883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CD3A3D322
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762587A8572
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E071EB1A9;
	Thu, 20 Feb 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JJtzbQXX"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F41E570A;
	Thu, 20 Feb 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039922; cv=none; b=RFT6NmNUC5tLX7aOSkFok9LJ/Cxi934F/nZ+zzY1GmBZyi4Kp28pnjPuBLrrKZJDyKv64QoHoKdPTnrN1suAmKSpK1q0Wzu1L7ixIqS6GijxYviFhdU/MjFfFcE7gQ/xXywpMeZp3kw+ZEEWMz+ZCm6LBdxUufc6YoJubvy4z2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039922; c=relaxed/simple;
	bh=ysNNG9ZlilUKBcSKMDvjgsnfPVd926BIJx7Z7I2t+Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjxlJax80u1aaWsy/qUkfmMbeQjugZNfD5QO/iygbCMww0NqQ7qg7fceFJEnBPegEonyi/xFI6pKxyI64fFH7YoJexjIvRIl+0DXQjlZ6mAUgvkg0zS6Sw+gN1vKuu5AtRDkrOVtmwP4/b9mEVmyJ5UycGYigFkW5XDv1kUJ4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JJtzbQXX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30490442C3;
	Thu, 20 Feb 2025 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740039916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ar1JIwTqv1OVOapMhuNMncreMZJ2lwcBjQdY8/QsJY=;
	b=JJtzbQXXxSl5TKEr/lCNYPk1kI9RHk6Lww+JXrt8vvn10Jn75sp4LkiI5Gb5vPfDdawyHH
	h2+8GiKZSJMJmzX9LJPU8JAeYzDrNFm3VR6oRd5nltQ2VsBGQRFSeQKUNcIdcAUyS05rfM
	Ne99MZVPoTE6vA5FXh17tp93/Hwj0s8BAnHiGqTLp3deZRROxX37zYLYXs0sPef+2WR2qA
	d/gluJ1Zz/GQdCsLI2vTQ9uzMO6zVEJHYUwCRa0jkT3LHd9NV4fU232EtF7bYwnjpc3no3
	IoSoOJokQWGhm2EwFZk44ZxNW9Rrq+TWAp9gtddQBIbX5rUJJ2ufV7Nn/eD4Gw==
Date: Thu, 20 Feb 2025 09:25:14 +0100
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
Message-ID: <20250220092514.444e90e4@bootlin.com>
In-Reply-To: <20250219173912.GA224527@bhelgaas>
References: <20250204073501.278248-6-herve.codina@bootlin.com>
	<20250219173912.GA224527@bhelgaas>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgp
 dhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Bjorn,

On Wed, 19 Feb 2025 11:39:12 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Feb 04, 2025 at 08:35:00AM +0100, Herve Codina wrote:
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
> 
> This is a detailed low-level description of what this patch does.  Can
> we include a high level outline of what the benefit is and why we want
> this patch?
> 
> Based on 185686beb464 ("misc: Add support for LAN966x PCI device"), I
> assume the purpose is to deal with some kind of non-standard PCI
> topology, e.g., a single B/D/F function contains several different
> pieces of functionality to be driven by several different drivers, and
> we build a device tree description of those pieces and then bind those
> drivers to the functionality using platform_device interfaces?
> 

What do you think if I add the following at the end of the commit log?

   With this done, hardware available in complex PCI device can be
   described by a device-tree overlay loaded by the PCI device driver
   on non device-tree based systems. For instance, the LAN966x PCI device
   introduced by commit 185686beb464 ("misc: Add support for LAN966x
   PCI device") can be available on x86 systems.


Best regards,
Hervé

