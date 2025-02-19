Return-Path: <linux-pci+bounces-21796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557FCA3B397
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 09:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286103A785C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F231BD9C7;
	Wed, 19 Feb 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WvAibkzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DA42A93;
	Wed, 19 Feb 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953495; cv=none; b=MMqP9s0r/ZuUF/maINuTdYQC2dHk84ao5wbJHwnRuVblEinrPTBgYd1tULAf+IHyYEzdzO29aIhV8Npvm6stT6FAv5LQGClvh2aI+6DxEJaEG0meRHiIEcmVuQpHrABLYVjfxgutxACDQg/gtG+TiuncDDLSzKyZ+c1gltpPArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953495; c=relaxed/simple;
	bh=ZIJsfwsQLEyVHvM+8mOBi/uq5fGQbodBdhKs8C5LUNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VV4fyleGzS1mNuTEfK8ZW1j1fBbrZzbh/9ALDdwCVtKimMuBBfwb2NhJpynU1L9uAj9mcTPIDM5t+zatyN4167DymnCGPclPCNi7aSzEmN/y7LLDI75czHY730qsCrlM9DHpK1uIq+8qbAXHZXUAIixX11v6CmquYzIe/+eljHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WvAibkzs; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6353B44393;
	Wed, 19 Feb 2025 08:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739953490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KlqEuekQPjwpj8AhBcBtdSFLM+Obju+wE/z6BfHhf0M=;
	b=WvAibkzsumX6JV5bqT7TuhQsg7CpTgE5iEbehCMyNWFkZH3zykbb7eRAa7iIxk7Z2QQ7Jr
	P+CvGnmt1DPRn3Fx5OvMbotcQNl9DkTrkCD9CcQikaIrOs6LZmLnEx5XIfkrpC1nheeXNC
	GX+G4C8+toxkwMXwIL1aqM33ZbKcCscCqZCPOBykvrY2vdiwyOUFYh7C6n5/viOIRWCNiY
	tRWfq7G6weRObYu+iFHQeXYce/WANly+lxS301fltTSvKa+d228zJycjpv8hA2v8nI1CpP
	0wVx36Vzdln1xexmmAcSMlS3fJkzVzapwxjYqE+BDHi82vAvXWHEs5BzJdD0hw==
Date: Wed, 19 Feb 2025 09:24:48 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 0/5] Add support for the PCI host bridge device-tree
 node creation.
Message-ID: <20250219092448.2e3e8ac3@bootlin.com>
In-Reply-To: <20250204073501.278248-1-herve.codina@bootlin.com>
References: <20250204073501.278248-1-herve.codina@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvhfeljedtfedtjeevffegtddutdeghfettdduhfeuhfdttdffieeuiefgvdfhvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmp
 dhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihiihhhirdhhohhusegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

Hi Greg, Bjorn,


I took into account feedback received on v5 and sent the v6 on 01/10/2025.
I didn't receive any feedback on the v6. In the meantime, the kernel
v6.14-rc1 has been released. I rebased the v6 and sent the v7 on 12/09/2024.

Is there something blocking in this series from having feedback or having
the series applied?

Best regards,
Hervé

On Tue,  4 Feb 2025 08:34:55 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

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
> Compare to previous iteration, this v7 series is the v6 series rebased
> on top of v6.14-rc1 without other modifications.
> 
> Best regards,
> Hervé Codina
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
> 


