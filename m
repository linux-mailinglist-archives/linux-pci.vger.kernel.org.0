Return-Path: <linux-pci+bounces-15996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD9A9BBEA2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A61BB210ED
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D621D0E26;
	Mon,  4 Nov 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnM6j3fz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC811D63C1;
	Mon,  4 Nov 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751310; cv=none; b=Sq/c2jeFbo56rvPtWpNgNj/fA8eVeN8yBdKKUM4nqxutAYuoCG5HiGMjbOhdiq4mhWCqWVwGJwY9XUINDdmQEt2z88yT5ZOdAI9TyNTGe+YCHgzhpA3ERVF+c4TcgBwWdnbB3NNw+NbK41dTfh1q5yZJ9+RjWmIfZ3uywfb3Ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751310; c=relaxed/simple;
	bh=epYdnbJKU5FFn0DdbqGPLAEbaoHaijlXYQL/Bm7Cau8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyLceI+s3rXfoaTrSb7C7MOprKJgPJKHY43gvqiaSQFElQiqkUB1tprBNI1b/75L9PMcUiB/RVq9n0qlzJ/Qm6nYVJz89eGl1xaIZSQPfbuyztiOkJ6nuwEIKx5HLJwBEOrsQdoWU4XRf/XFWBMHPPyta4GWds8Z1uqdkHkoVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnM6j3fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4DFC4CED0;
	Mon,  4 Nov 2024 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730751309;
	bh=epYdnbJKU5FFn0DdbqGPLAEbaoHaijlXYQL/Bm7Cau8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnM6j3fzhItRQO5T1tU17ntZzU8f5Tc6ZU6O1wzMJOULCAzSrHhQfJExxf2QzBZK3
	 wEXua2Zi4E3XxZSYkJaIVrF5sHuOHiuzpTDVXF4J9xxAbWxON06jLeUBiBMthPGesA
	 aaCmujVHtM1VTcDe95Wid6c6I9XNqpNzeZV8FxCWUU1JlHl62j17YSDlemuOShJRaO
	 0Rv7wMspOakg8qVM2sqT/tRPhXqQp7u59QMIOYMyb3thmDxv9z1pgXNuQnJpEk7724
	 1zsj+lRXjuHyGxybLtREvi8sK4taD/LXU4iOmclFdMQglsjorc1hhO9AUWYTpLec7m
	 gA96o9JSLKW6w==
Date: Mon, 4 Nov 2024 14:15:07 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/6] Add support for the root PCI bus device-tree node
 creation.
Message-ID: <20241104201507.GA361448-robh@kernel.org>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104172001.165640-1-herve.codina@bootlin.com>

On Mon, Nov 04, 2024 at 06:19:54PM +0100, Herve Codina wrote:
> Hi,
> 
> This series adds support for creating a device-tree node for a root PCI
> bus on non device-tree based system.
> 
> Creating device-tree nodes for PCI devices already exists upstream. It
> was added in commit 407d1a51921e ("PCI: Create device tree node for
> bridge"). Created device-tree nodes need a parent node to be attached
> to. For the first level devices, on device-tree based system, this
> parent node (i.e. the root PCI bus) is described in the base device-tree
> (PCI controller).
> 
> The LAN966x PCI device driver was recently accepted [1] and relies on
> this feature.
> 
> On system where the base hardware is not described by a device-tree, the
> root PCI bus node to which first level created PCI devices need to be
> attach to does not exist. This is the case for instance on ACPI
> described systems such as x86.
> 
> This series goal is to handle this case.
> 
> In order to have the root PCI bus device-tree node available even on
> x86, this top level node is created (if not already present) based on
> information computed by the PCI core. It follows the same mechanism as
> the one used for PCI devices device-tree node creation.
> 
> In order to have this feature available, a number of changes are needed:
>   - Patch 1 and 2: Introduce and use device_{add,remove}_of_node().
>     This function will also be used in the root PCI bus node creation.
> 
>   - Patch 3 and 4: Improve existing functions to reuse them in the root
>     PCI bus node creation.
> 
>   - Patch 5: Update the default value used when #address-cells is not
>     available in the device-tree root node.
> 
>   - Patch 6: The root PCI bus device-tree node creation itself.
> 
> With those modifications, the LAN966x PCI device is working on x86 systems.

That's nice, but I don't have a LAN966x device nor do I want one. We 
already have the QEMU PCI test device working with the existing PCI 
support. Please ensure this series works with it as well.

Rob

