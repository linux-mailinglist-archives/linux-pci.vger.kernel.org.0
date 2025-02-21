Return-Path: <linux-pci+bounces-22020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE4A3FE96
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B87B7ADE3E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0053250BFB;
	Fri, 21 Feb 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr+BZI1a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C291D5AA7;
	Fri, 21 Feb 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161981; cv=none; b=ng8ivSQCc4LZqPya6h+w1QH+dJJf6usAemV64N1/EMj/2c5zVSpRwCHa8DOZaYeAoJ9fmrlCleo2YDgyX/u8CSqy6XR90qSLEaecoTO3b8/pslOsX+7/6pDC3NOZmfLJb66FQlLx+XWkmI5y3tro5z/s+34Rv8QpGgY6tpkgS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161981; c=relaxed/simple;
	bh=4vSeGG+kxcYAxGRnNrN1TSagj87TxXGRn6oSMGUXYLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OeXfFvXRimnFulyVH2lPvCsURFq7jNj7VJlJtXMeI6X+fVMkR7BAH2vwhwTNOWZlqLnLVx/uwfXNomnznwlqnsqXRkHAzkgnjUcQTpIR5nBOkJ+sptBtPmCkTw9miVqZMQee5E7vQkS4b7oLx83XA0idQ8ZABcunP5nMLU/LmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr+BZI1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC826C4CED6;
	Fri, 21 Feb 2025 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740161981;
	bh=4vSeGG+kxcYAxGRnNrN1TSagj87TxXGRn6oSMGUXYLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gr+BZI1aYh23TMrdhw8XBRwlWvhHRuYPRHopsd5dndfnftQfFoaYgePUToB1KA6qV
	 eS4Kjtaao8ynimXs9KWT39YV2Dp+/7icAMV8TQCoffK1sKu8Zp7F57E3c6ndTSVZI1
	 WFGKRIRqN0c+LAaA+NkTPZ7O5lRGmMjDVw9U7fbJVP2SHZZ/MQRQ4cg23KyWiXsvUv
	 3LLS81crp5w0Y3+ld1nxb5A9H/g+NH96YmRXWzH7DSPcBhRacR6DkrSyIXdgEaYF6m
	 FtE3dggt6nRK0Jpo0CNQmTFj1mqoqdTnpP65ZV1jmJbejPsmRbX54L5js4ucAs37UT
	 gZNF+NAp0xfIg==
Date: Fri, 21 Feb 2025 12:19:38 -0600
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
Message-ID: <20250221181938.GA352971@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221093427.3d83b9e3@bootlin.com>

On Fri, Feb 21, 2025 at 09:34:27AM +0100, Herve Codina wrote:
> Hi Bjorn,
> 
> On Thu, 20 Feb 2025 18:07:53 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Thu, Feb 20, 2025 at 09:25:14AM +0100, Herve Codina wrote:
> > > On Wed, 19 Feb 2025 11:39:12 -0600
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > On Tue, Feb 04, 2025 at 08:35:00AM +0100, Herve Codina wrote:  
> > > > > PCI devices device-tree nodes can be already created. This was
> > > > > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > > > > bridge").
> > > > > 
> > > > > In order to have device-tree nodes related to PCI devices attached on
> > > > > their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> > > > > root bus device-tree node is needed. This root bus node will be used as
> > > > > the parent node of the first level devices scanned on the bus. On
> > > > > device-tree based systems, this PCI root bus device tree node is set to
> > > > > the node of the related PCI host bridge. The PCI host bridge node is
> > > > > available in the device-tree used to describe the hardware passed at
> > > > > boot.
> > > > > 
> > > > > On non device-tree based system (such as ACPI), a device-tree node for
> > > > > the PCI host bridge or for the root bus does not exist. Indeed, the PCI
> > > > > host bridge is not described in a device-tree used at boot simply
> > > > > because no device-tree are passed at boot.
> > > > > 
> > > > > The device-tree PCI host bridge node creation needs to be done at
> > > > > runtime. This is done in the same way as for the creation of the PCI
> > > > > device nodes. I.e. node and properties are created based on computed
> > > > > information done by the PCI core. Also, as is done on device-tree based
> > > > > systems, this PCI host bridge node is used for the PCI root bus.    
> > > > 
> > > > This is a detailed low-level description of what this patch does.  Can
> > > > we include a high level outline of what the benefit is and why we want
> > > > this patch?
> > > > 
> > > > Based on 185686beb464 ("misc: Add support for LAN966x PCI device"), I
> > > > assume the purpose is to deal with some kind of non-standard PCI
> > > > topology, e.g., a single B/D/F function contains several different
> > > > pieces of functionality to be driven by several different drivers, and
> > > > we build a device tree description of those pieces and then bind those
> > > > drivers to the functionality using platform_device interfaces?  
> > > 
> > > What do you think if I add the following at the end of the commit log?
> > > 
> > >    With this done, hardware available in complex PCI device can be
> > >    described by a device-tree overlay loaded by the PCI device driver
> > >    on non device-tree based systems. For instance, the LAN966x PCI device
> > >    introduced by commit 185686beb464 ("misc: Add support for LAN966x
> > >    PCI device") can be available on x86 systems.  
> > 
> > This isn't just about complexity of the device.  There are NICs that
> > are much more complex.
> > 
> > IIUC this is really about devices that don't follow the standard
> > "one PCI function <--> one driver" model, so I think it's important to
> > include something about the case of a single function that includes
> > several unrelated bits of functionality that require different
> > drivers.
> 
> Yes.
> 
> > 
> > "LAN966x" might mean something to people who know that this thing has
> > a half dozen separate things inside it, but the name by itself doesn't
> > suggest that, so I don't think it's really helpful to the general
> > audience.
> > 
> 
> Does this one at the end of the commit log sound better?
> 
>     With this done, hardware available in a PCI device that doesn't follow
>     the PCI model consisting in one PCI function handled by one driver can
>     be described by a device-tree overlay loaded by the PCI device driver
>     on non device-tree based systems. Those PCI devices provide a single PCI
>     function that includes several functionalities that require different
>     driver. The device-tree overlay describes in that case the internal
>     devices and their relationships. It allows to load drivers needed by
>     those different devices in order to have functionalities handled.

Yep, thanks.

