Return-Path: <linux-pci+bounces-22676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6BA4A4E7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5952168069
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0411CAA74;
	Fri, 28 Feb 2025 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQRaHARH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4B23F370;
	Fri, 28 Feb 2025 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777719; cv=none; b=TU5xnq9FsUMMtypwE2kuNrnN4HJJIuS7qfIYoUE32GAGwnhArI4jZIQClaAPuhXh1lX16/9E/zUfnk6gNTUrtp33DVuEYOoa6+U+1J8RaTk4vpuuxm029eSDpJiVD1uholOtwIcUzKi/tITnDz1zlLREPWeApnxglkHJn2dX5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777719; c=relaxed/simple;
	bh=L60g470j6clFCW48lLfoAGvl3xJyYtc+qdJGB29Tw0U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MxcBpsgGKM2RNNpM0b9nCRWLZkl2SLTGyayAydc0iDJhQAqPDlyBvSoFGEzwyUBYhaD7uNMcrYuarxl72lOYCeYvSsz03xFmijiRZ6i9IfNIjxYZA34Ujj3VTtfR1be4K6oufgZswJCMO77EHeF9e1k1JgEe4/oQPtxMeFwiTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQRaHARH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA5BC4CED6;
	Fri, 28 Feb 2025 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777718;
	bh=L60g470j6clFCW48lLfoAGvl3xJyYtc+qdJGB29Tw0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WQRaHARHm6m16LbuYiEpYgtbK6lA9zVejxWIMCipLoe9xO1Zu8cjAtI76ZBpsBFXK
	 Z8DKDHLxWxLnn5bJ6qTfG24dG4U9oduE3vhfG8EsOIn9F9NrY7yGmVje6/CTqeBN57
	 Q8jz0TuAUSD2z6pIC6wLIgyE+S9qh15MYsl+ldHQzyTbUJbLaX1ZPs2Puo810HgMaH
	 J29HfUx2GG43Xh05jsLmiNPV1UBKadv27VFjU3+/E7tXx1M1d7KHwi0G2TqUb3lPYV
	 Vk4IG0qbkK2k/tuFklAVln/8f3BquQpP10ZBpFdYAPPnewgOzstz8BC/t2/A6BNhy7
	 n848WO7raVMcA==
Date: Fri, 28 Feb 2025 15:21:57 -0600
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
Subject: Re: [PATCH v8 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20250228212157.GA70383@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224141356.36325-6-herve.codina@bootlin.com>

On Mon, Feb 24, 2025 at 03:13:55PM +0100, Herve Codina wrote:
> PCI devices device-tree nodes can be already created. This was
> introduced by commit 407d1a51921e ("PCI: Create device tree node for
> bridge").
> 
> In order to have device-tree nodes related to PCI devices attached on
> their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> root bus device-tree node is needed. This root bus node will be used as
> the parent node of the first level devices scanned on the bus. On
> device-tree based systems, this PCI root bus device tree node is set to
> the node of the related PCI host bridge. The PCI host bridge node is
> available in the device-tree used to describe the hardware passed at
> boot.
> 
> On non device-tree based system (such as ACPI), a device-tree node for
> the PCI host bridge or for the root bus does not exist. Indeed, the PCI
> host bridge is not described in a device-tree used at boot simply
> because no device-tree are passed at boot.
> 
> The device-tree PCI host bridge node creation needs to be done at
> runtime. This is done in the same way as for the creation of the PCI
> device nodes. I.e. node and properties are created based on computed
> information done by the PCI core. Also, as is done on device-tree based
> systems, this PCI host bridge node is used for the PCI root bus.
> 
> With this done, hardware available in a PCI device that doesn't follow
> the PCI model consisting in one PCI function handled by one driver can
> be described by a device-tree overlay loaded by the PCI device driver on
> non device-tree based systems. Those PCI devices provide a single PCI
> function that includes several functionalities that require different
> driver. The device-tree overlay describes in that case the internal
> devices and their relationships. It allows to load drivers needed by
> those different devices in order to have functionalities handled.

Since this adds host bridge nodes, does this patch specifically enable
device tree overlays for devices on the root bus?

Were we able to load DT overlays for devices deeper in the hierarchy
already, even without this patch?

Bjorn

