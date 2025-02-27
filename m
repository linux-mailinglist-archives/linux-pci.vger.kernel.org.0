Return-Path: <linux-pci+bounces-22585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2DBA486C3
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5E3B6636
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EA1DE3C1;
	Thu, 27 Feb 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8Q3ZWrx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCF1DE2B9;
	Thu, 27 Feb 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677774; cv=none; b=FY+3f9DIxCcnBHEqZf1oZU0+YRb/GBYv1IhV2DVujVbIdZeGk9Pe2BwUsJJZJvy02hqXfBxBzHvNbWokGc6wk0y7+iRzLar+KP6rkGpxX6WCu75Q/I1cS3g5bXSUDxXkIOdEm0dV212hcdTl8c08nhIICL48BbhhdvzBVa/uiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677774; c=relaxed/simple;
	bh=Z0sfGr3HdnbzHvGkVfOwOcuQNt8HuNW7o8cV/1jRzxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ODa4tmskSMYpM51PZlo3O5EEHNDBE34kQ3Ekav9D5DrVCwKodSbgh6o8b6rCf4ko/FifwnYYeJaw87afG3yVmlrBTeEtKm0PKPIQQ7tWjSKqSVEwYdL7h1xiMV8cHx7ePhqOI1amd9rpYHNSroOA9HtV2MQfzXEIGNpzl7HQ3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8Q3ZWrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F61C4CEDD;
	Thu, 27 Feb 2025 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677774;
	bh=Z0sfGr3HdnbzHvGkVfOwOcuQNt8HuNW7o8cV/1jRzxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o8Q3ZWrx/8rEqCsDPoKylQmzyIaDvw29jbXi9gZA/BIWCoAkWaii/HoGER+rgWS2y
	 uUP8rKn8wgAxfWYw/k7syZkejPO1UepMZpIMaD5fWoOduZzyQVOk5IlxHTadMx9DkE
	 5ifD6XzKk81KEhQiKejribyArVlx2TSya5gcdrPcrWSCPxxh22aVRNj+SY77PWAeqI
	 MJmG//OfgdUYKrTZQWamiTwew52N26mos4JIgYLtFJeYUc6eduMaIriI7jA4S5J0D7
	 u65nkcbAmZggrQpI6YeHYNqVckzsqjPwZ7F2F+SVygUSZdMkxFDqmKB0vc7vJSyfe6
	 +rwaN7hbivPBA==
Date: Thu, 27 Feb 2025 11:36:12 -0600
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
Subject: Re: [PATCH v8 0/5] Add support for the PCI host bridge device-tree
 node creation.
Message-ID: <20250227173612.GA606350@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224141356.36325-1-herve.codina@bootlin.com>

On Mon, Feb 24, 2025 at 03:13:50PM +0100, Herve Codina wrote:
> Hi,
> 
> This series adds support for creating a device-tree node for the PCI
> host bridge on non device-tree based system.
> 
> Creating device-tree nodes for PCI devices and PCI-PCI bridges already
> exists upstream. It was added in commit 407d1a51921e ("PCI: Create
> device tree node for bridge"). Created device-tree nodes need a parent
> node to be attached to. For the first level devices, on device-tree
> based system, this parent node (i.e. the PCI host bridge) is described
> in the base device-tree. The PCI bus related to this bridge (PCI root
> bus) inherit of the PCI host bridge device-tree node.
> 
> The LAN966x PCI device driver, available since commit 185686beb464
> ("misc: Add support for LAN966x PCI device"), relies on this feature.
> 
> On system where the base hardware is not described by a device-tree, the
> PCI host bridge to which first level created PCI devices need to be
> attach to does not exist. This is the case for instance on ACPI
> described systems such as x86.
> 
> This series goal is to handle this case.
> 
> In order to have the PCI host bridge device-tree node available even
> on x86, this top level node is created (if not already present) based on
> information computed by the PCI core. It follows the same mechanism as
> the one used for PCI devices device-tree node creation.
> 
> As for device-tree based system, the PCI root bus handled by the PCI
> host bridge inherit of this created node.
> 
> In order to have this feature available, a number of changes are needed:
>   - Patch 1 and 2: Introduce and use device_{add,remove}_of_node().
>     This function will also be used in the root PCI bus node creation.
> 
>   - Patch 3 and 4: Improve existing functions to reuse them in the root
>     PCI bus node creation.
> 
>   - Patch 5: The PCI host bridge device-tree node creation itself.
> 
> With those modifications, the LAN966x PCI device is working on x86 systems
> and all device-tree kunit tests (including the of_unittest_pci_node test)
> pass successfully with the following command:
>   qemu-system-x86_64 -machine q35 -nographic \
>     -kernel arch/x86_64/boot/bzImage --append console=ttyS0 \
>     -device pcie-root-port,port=0x10,chassis=9,id=pci.9,bus=pcie.0,multifunction=on,addr=0x3 \
>     -device pcie-root-port,port=0x11,chassis=10,id=pci.10,bus=pcie.0,addr=0x3.0x1 \
>     -device x3130-upstream,id=pci.11,bus=pci.9,addr=0x0 \
>     -device xio3130-downstream,port=0x0,chassis=11,id=pci.12,bus=pci.11,multifunction=on,addr=0x0 \
>     -device i82801b11-bridge,id=pci.13,bus=pcie.0,addr=0x4 \
>     -device pci-bridge,chassis_nr=14,id=pci.14,bus=pci.13,addr=0x0 \
>     -device pci-testdev,bus=pci.12,addr=0x0
> 
> Compare to previous iteration, this v8 series mainly improves a commit
> log.
> 
> Best regards,
> Hervé Codina
> 
> Changes v7 -> v8
>   v7: https://lore.kernel.org/lkml/20250204073501.278248-1-herve.codina@bootlin.com/
> 
>   - Patch 1
>     Add 'Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>'
>     Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'
> 
>   - Patch 2, 3, 4
>     Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'
> 
>   - Patch 5
>     Improve commit log adding a high level part outlining the benefit of
>     changes.
>     Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'
> 
> Changes v6 -> v7
>   v6: https://lore.kernel.org/lkml/20250110082143.917590-1-herve.codina@bootlin.com/
> 
>   Rebase on top of v6.14-rc1
> 
> Changes v5 -> v6
>   v5: https://lore.kernel.org/lkml/20241209130339.81354-1-herve.codina@bootlin.com/
> 
>   - Patch 1
>     Add a return error code in device_add_of_node()
> 
>   - Patches 2 and 5
>     Handle the device_add_of_node() error code
> 
>   - Patches 3 and 4
>     No changes
> 
> Changes v4 -> v5
>   v4: https://lore.kernel.org/lkml/20241202131522.142268-1-herve.codina@bootlin.com/
> 
>   - Patch 1
>     Use dev_warn() instead of WARN()
> 
>   - Patches 2 to 4
>     No changes
> 
>   - Patch 5 (v4 patch 6)
>     Use dev_err()
>     Fix a typo in commit log
> 
>   Patch removed in v5
>     - Patch 5 in v4
>       Already applied
> 
> Changes v3 -> v4
>   v3: https://lore.kernel.org/lkml/20241114165446.611458-1-herve.codina@bootlin.com/
> 
>   Rebase on top of v6.13-rc1
> 
>   - Patches 1 to 6
>     No changes
> 
> Changes v2 -> v3
>   v2: https://lore.kernel.org/lkml/20241108143600.756224-1-herve.codina@bootlin.com/
> 
>   - Patch 5
>     Fix commit log.
>     Use 2 for #size-cells.
> 
>   - Patches 1 to 4 and 6
>     No changes
> 
> Changes v1 -> v2
>   v1: https://lore.kernel.org/lkml/20241104172001.165640-1-herve.codina@bootlin.com/
> 
>   - Patch 1
>     Remove Cc: stable
> 
>   - Patch 2
>     Remove Fixup tag and Cc: stable
> 
>   - Patches 3 and 4
>     No changes
> 
>   - Patch 5
>     Add #address-cells/#size-cells in the empty root DT node instead of
>     updating default values for x86.
>     Update commit log and commit title.
> 
>   - Patch 6
>     Create device-tree node for the PCI host bridge and reuse it for
>     the PCI root bus. Rename functions accordingly.
>     Use "pci" instead of "pci-root" for the PCI host bridge node name.
>     Use "res->start - windows->offset" for the PCI bus addresses.
>     Update commit log and commit title.
> 
> Herve Codina (5):
>   driver core: Introduce device_{add,remove}_of_node()
>   PCI: of: Use device_{add,remove}_of_node() to attach of_node to
>     existing device
>   PCI: of_property: Add support for NULL pdev in of_pci_set_address()
>   PCI: of_property: Constify parameter in of_pci_get_addr_flags()
>   PCI: of: Create device-tree PCI host bridge node
> 
>  drivers/base/core.c       |  61 ++++++++++++++++++++
>  drivers/pci/of.c          | 115 +++++++++++++++++++++++++++++++++++++-
>  drivers/pci/of_property.c | 114 +++++++++++++++++++++++++++++++++++--
>  drivers/pci/pci.h         |   6 ++
>  drivers/pci/probe.c       |   2 +
>  drivers/pci/remove.c      |   2 +
>  include/linux/device.h    |   2 +
>  7 files changed, 295 insertions(+), 7 deletions(-)

Applied to pci/devtree-create, planning for v6.15, thanks!

