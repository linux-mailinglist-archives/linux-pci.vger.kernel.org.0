Return-Path: <linux-pci+bounces-21938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458FA3E8FF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC3119C45AE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61913A50;
	Fri, 21 Feb 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+d8IImj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0C79FD;
	Fri, 21 Feb 2025 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096476; cv=none; b=UjPCcAKorv8Bg1tIaB/kKc80FRlEOxyTD8H01m+YMM+drB1/j/cBmc3VXjuOy2Eb8e/r71LaGAdG5TlFaCGxn+1iL+/3QSf3uz5kjjCIoHEmIgwW590uSnw5P/VM9LpEhoiQhgh1agu+VNWGzrHha7GB9Lw+OOjikjdYsxAzXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096476; c=relaxed/simple;
	bh=MPbfCbKAkSdljx/wX1JlhNJCEQqGUqYR8EvE7LJRmyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m4pYHIBWdjpzY4d4QK7tWvndzWEc1Z/ILhpltR2gv9gaJo8lOYbKJm4p2XSf9gOd3Qi/z3+u88YfIhpFop1LQq43nYHuvlwVKsXWlfOb/dTQuxK3A1M2HUtkCOQTzkrBe/KlWWedOeecGLvK96FDNwcEFhxg7vF1VcFru4+v20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+d8IImj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D21C4CED1;
	Fri, 21 Feb 2025 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740096475;
	bh=MPbfCbKAkSdljx/wX1JlhNJCEQqGUqYR8EvE7LJRmyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X+d8IImjHxMPta5Rx3DMNAhdbWYzxB3hGSwWgR2QVBL44VMjwlIji1WcBS2pSzNSQ
	 THSX/CT/78mVYBSeI722N2qQslP3okYN78UgqZ7aQ9y/LC5yNWjTOh87xV7Sfv3Mcz
	 DLlkLVWuPM3f/Zq6EvNsQJlYTF2WKJn8Xj7WsAp1OTfAWiNVQC2wYFpQFl97ppN/AC
	 D6L8qdCdfZ15PS973HanZFoHv8mhk19rgwDnP+CHcRQsFdWB5fRgDDOTKzGqyyZsWT
	 2G3a4XgpXjljvEJ15QiKWFndHbAqfPuJ01rpgCun3/wi/O4jSV7lPx93ED9cSZkHCE
	 Owm6rucZVjdUQ==
Date: Thu, 20 Feb 2025 18:07:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20250221000753.GA321042@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220092514.444e90e4@bootlin.com>

On Thu, Feb 20, 2025 at 09:25:14AM +0100, Herve Codina wrote:
> On Wed, 19 Feb 2025 11:39:12 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Feb 04, 2025 at 08:35:00AM +0100, Herve Codina wrote:
> > > PCI devices device-tree nodes can be already created. This was
> > > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > > bridge").
> > > 
> > > In order to have device-tree nodes related to PCI devices attached on
> > > their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> > > root bus device-tree node is needed. This root bus node will be used as
> > > the parent node of the first level devices scanned on the bus. On
> > > device-tree based systems, this PCI root bus device tree node is set to
> > > the node of the related PCI host bridge. The PCI host bridge node is
> > > available in the device-tree used to describe the hardware passed at
> > > boot.
> > > 
> > > On non device-tree based system (such as ACPI), a device-tree node for
> > > the PCI host bridge or for the root bus does not exist. Indeed, the PCI
> > > host bridge is not described in a device-tree used at boot simply
> > > because no device-tree are passed at boot.
> > > 
> > > The device-tree PCI host bridge node creation needs to be done at
> > > runtime. This is done in the same way as for the creation of the PCI
> > > device nodes. I.e. node and properties are created based on computed
> > > information done by the PCI core. Also, as is done on device-tree based
> > > systems, this PCI host bridge node is used for the PCI root bus.  
> > 
> > This is a detailed low-level description of what this patch does.  Can
> > we include a high level outline of what the benefit is and why we want
> > this patch?
> > 
> > Based on 185686beb464 ("misc: Add support for LAN966x PCI device"), I
> > assume the purpose is to deal with some kind of non-standard PCI
> > topology, e.g., a single B/D/F function contains several different
> > pieces of functionality to be driven by several different drivers, and
> > we build a device tree description of those pieces and then bind those
> > drivers to the functionality using platform_device interfaces?
> 
> What do you think if I add the following at the end of the commit log?
> 
>    With this done, hardware available in complex PCI device can be
>    described by a device-tree overlay loaded by the PCI device driver
>    on non device-tree based systems. For instance, the LAN966x PCI device
>    introduced by commit 185686beb464 ("misc: Add support for LAN966x
>    PCI device") can be available on x86 systems.

This isn't just about complexity of the device.  There are NICs that
are much more complex.

IIUC this is really about devices that don't follow the standard
"one PCI function <--> one driver" model, so I think it's important to
include something about the case of a single function that includes
several unrelated bits of functionality that require different
drivers.

"LAN966x" might mean something to people who know that this thing has
a half dozen separate things inside it, but the name by itself doesn't
suggest that, so I don't think it's really helpful to the general
audience.

Bjorn

