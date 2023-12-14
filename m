Return-Path: <linux-pci+bounces-1002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962498136E8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 17:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BB8B20BC8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBDD60BBB;
	Thu, 14 Dec 2023 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw4g39EK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310860BAB;
	Thu, 14 Dec 2023 16:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7C4C433C8;
	Thu, 14 Dec 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702572671;
	bh=/Qylc2+JKzSkPgqtG0O15AfjjZ9hpoVXvrfTV9+uIPA=;
	h=From:To:Cc:Subject:Date:From;
	b=Rw4g39EK4Oz975BOvXZXh6h9gnLJDQFsGE9qj6QwJbbXn59dZWCY2oC+Jm3rfAJry
	 poOCUcsm5X+40s3GlTO52kgrnj8YITcOc8xNYA9lzI3rzVZ48/So37jLNPuXi5sbOq
	 C9jCLamZVMBCmLWwVCTl68hCpTqTisLsU5MO2FEQKSAeRPPYCq2oxJopZKk4ICoOn3
	 dxaryI8HdITj+XGWhhuItNYvo/lJfoUbElVMMu5siFy2DptQgaaeVuPYyUIn8rvo4g
	 Buom6W9VT0cFvLFIF6fUTqIM4NPW1TL3yfM7JrlklrOCfbQzj3yVFllQeMbtzQxG/l
	 AxXqeB39K3a6A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Igor Mammedov <imammedo@redhat.com>,
	Fiona Ebner <f.ebner@proxmox.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Jonathan Woithe <jwoithe@just42.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
Date: Thu, 14 Dec 2023 10:51:02 -0600
Message-Id: <20231214165102.1093961-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 and the
subsequent fix to it:

  cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")

40613da52b13 fixed a problem where hot-adding a device with large BARs
failed if the bridge windows programmed by firmware were not large enough.

cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources()
only for non-root bus") fixed a problem with 40613da52b13: an ACPI hot-add
of a device on a PCI root bus (common in the virt world) or firmware
sending ACPI Bus Check to non-existent Root Ports (e.g., on Dell Inspiron
7352/0W6WV0) caused a NULL pointer dereference and suspend/resume hangs.

Unfortunately the combination of 40613da52b13 and cc22522fd55e caused other
problems:

  - Fiona reported that hot-add of SCSI disks in QEMU virtual machine fails
    sometimes.

  - Dongli reported a similar problem with hot-add of SCSI disks.

  - Jonathan reported a console freeze during boot on bare metal due to an
    error in radeon GPU initialization.

Revert both patches to avoid adding these problems.  This means we will
again see the problems with hot-adding devices with large BARs and the NULL
pointer dereferences and suspend/resume issues that 40613da52b13 and
cc22522fd55e were intended to fix.

Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
Fixes: cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Closes: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com
Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Closes: https://lore.kernel.org/r/3c4a446a-b167-11b8-f36f-d3c1b49b42e9@oracle.com
Reported-by: Jonathan Woithe <jwoithe@just42.net>
Closes: https://lore.kernel.org/r/ZXpaNCLiDM+Kv38H@marvin.atrad.com.au
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 601129772b2d..5b1f271c6034 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -512,15 +512,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					if (pci_is_root_bus(bus))
-						__pci_bus_size_bridges(dev->subordinate, &add_list);
+					__pci_bus_size_bridges(dev->subordinate,
+							       &add_list);
 				}
 			}
 		}
-		if (pci_is_root_bus(bus))
-			__pci_bus_assign_resources(bus, &add_list, NULL);
-		else
-			pci_assign_unassigned_bridge_resources(bus->self);
+		__pci_bus_assign_resources(bus, &add_list, NULL);
 	}
 
 	acpiphp_sanitize_bus(bus);
-- 
2.34.1


