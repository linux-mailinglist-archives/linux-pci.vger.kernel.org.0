Return-Path: <linux-pci+bounces-16332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3179C1F6D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 15:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1CB1F25FF4
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC91F6699;
	Fri,  8 Nov 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IquwqNOR"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2971F4295;
	Fri,  8 Nov 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076572; cv=none; b=a4yxyYoqvdbD0S68ONqFQootnhYnopVPSseBI/ibjD0LPYleeKSHSMReHrjJ2uMq36FN/z0YFM82OsYzxf4fjwbUmWlAdgbrP4VO7kMwnfLNQfyv6lluMPKggsd9G4+tJ8TpbgnoIgJ3fZf9ZurpMCr1nha8YxPAAo7VnRW7BLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076572; c=relaxed/simple;
	bh=6slO009d/9VQJg5blm25QM7TQPdNoNYn/yLCwGyNYeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLwew3yqleV1dvE8ceCUUZ0IOMG7TrvXFj9cztR9RYDXTuponZFCeZRqhK28VuEu81rRmztNGtbNkGnB0Kht5RELf5GPHrYnoSNc6TjzLzaDvxSB0J0JoShDyN+kMnFPW/Mqq1neADh/DdPHNq1QayygcvRyE0xjkR3IHxTtACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IquwqNOR; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 722B420004;
	Fri,  8 Nov 2024 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731076568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OgyLhE+jNXZk7m4HF7bpGki7AeOrZWO847eMX6Y0+o=;
	b=IquwqNOR4EnGHdegHxI9dVN3UTG9kf0ueY3C6wpWTPwhdamaUcup9x5YbQk8EnZhjWcOZw
	GcEfTFf6G8MNjEbOEawHlWM1gVcLVVdxCLOgeFHWh0MxI7lIdjDqEqeehLDf4M8Z+FGEcW
	9d/okO+nvGOl/KCZBvMCI2NXOOavUzhEpr0yu38qYr8V3hPpkQyNx1SbpNrlFo4xxD2XCe
	3jVBsmmZUctWM5pA2F1omGiM7YWFhxe3+Jw6XymaId4crtdxHsmTDG7x+XTnb56/E7NiSj
	FNpnF05NV0uTeMQHxLukYkzge1HCAnxf3KDD3dMop6wiJkL11jUQTBHR9qCYBg==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 5/6] of: Add #address-cells/#size-cells in the device-tree root empty node
Date: Fri,  8 Nov 2024 15:35:58 +0100
Message-ID: <20241108143600.756224-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241108143600.756224-1-herve.codina@bootlin.com>
References: <20241108143600.756224-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On systems where ACPI is enabled or when a device-tree is not passed to
the kernel by the bootloader, a device-tree root empty node is created.
This device-tree root empty node doesn't have the #address-cells and the

This leads to the use of the default address cells and size cells values
which are defined in the code to 1 for address cells and 1 for size cells

According to the devicetree specification and the OpenFirmware standard
(IEEE 1275-1994) the default value for #address-cells should be 2.

Also, according to the devicetree specification, the #address-cells and
the #size-cells are required properties in the root node.

Modern implementation should have the #address-cells and the #size-cells
properties set and should not rely on default values.

On x86, this root empty node is used and the code default values are
used.

In preparation of the support for device-tree overlay on PCI devices
feature on x86 (i.e. the creation of the PCI root bus device-tree node),
the default value for #address-cells needs to be updated. Indeed, on
x86_64, addresses are on 64bits and the upper part of an address is
needed for correct address translations. On x86_32 having the default
value updated does not lead to issues while the uppert part of a 64bits
address is zero.

Changing the default value for all architectures may break device-tree
compatibility. Indeed, existing dts file without the #address-cells
property set in the root node will not be compatible with this
modification.

Instead of updating default values, add required #address-cells and

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/empty_root.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
index cf9e97a60f48..5017579f34dc 100644
--- a/drivers/of/empty_root.dts
+++ b/drivers/of/empty_root.dts
@@ -2,5 +2,11 @@
 /dts-v1/;
 
 / {
-
+	/*
+	 * #address-cells/#size-cells are required properties at root node
+	 * according to the devicetree specification. Use same values as default
+	 * values mentioned for #address-cells/#size-cells properties.
+	 */
+	#address-cells = <0x02>;
+	#size-cells = <0x01>;
 };
-- 
2.46.2


