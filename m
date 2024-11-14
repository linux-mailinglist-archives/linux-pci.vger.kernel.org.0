Return-Path: <linux-pci+bounces-16780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA069C9129
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D77B3C824
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070A18C907;
	Thu, 14 Nov 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I55iAXwJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB718595B;
	Thu, 14 Nov 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603302; cv=none; b=EcO2xCTiUQbAUXLzOfl7YyLEOi7AMircd5RMNqzN/9Zcnv58VyGljGr89xN1a7etDuKhG4Tno1mrle4OP6zXv0Yf5mC6VK8DuYxtlNVLDg7mL8fXJjdNRQpSwSesj1G6QURZpSSAHxKJ8mL9uQ9lRqQ7VKLxZqel4JowLIt/66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603302; c=relaxed/simple;
	bh=TOW/EzyDbIvADmJ/cMQpnmtwR6NOgiVR9PmYtOf7bXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC77YyRHg9LnpY1oAfCLgAt0R3EwtKxDT+EyKSyIL/2xQtVXBibOsH9I2OM/ZwYm1bzsERN1AWCiCaXG9d3Pk+Ie/nT7jorXuxbJ+mdOmGz/pNiGvsKZHBBvrkHxkXcNaH9rbjQvgbtqPNGc5T5ays2o29H/0VnVR+nE7FqFUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I55iAXwJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5EE4EE0003;
	Thu, 14 Nov 2024 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731603298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVpn7dEumaHVgEROgoe+qNLD7BNzHl5S0UXnNdPNwZ4=;
	b=I55iAXwJrP8aIcS1pof1327x7ZtUiQTg+l/Kai4vFmms7jPyD8sqa2eaC9PqqcXBovtjc7
	AQi5fv6OD2a1ETUz0eEo95lL9+pvqeX2K5rSILdqbIiq2gtprvLBcVBH1O2ks8wyEa7Kvf
	Ou3OyEO8qw6dEl0yB4UUta7+vg5WsTlDUXKLj+GZosBgkW5TPRW42IHs/BRYQISIxXorDz
	RqknvSVHtBqJmgzdoenyXRAwbB17gNUlkTaT3WnRpBLUlx9DZ9ikxCq0+5zwFTz4cCUqTF
	1oPkbN7IJM9eJP1zuYiXu9gv8BRTh2qNuLlgz6MQADse2HUfh+h6ZLJ48Sl3Wg==
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
Subject: [PATCH v3 5/6] of: Add #address-cells/#size-cells in the device-tree root empty node
Date: Thu, 14 Nov 2024 17:54:41 +0100
Message-ID: <20241114165446.611458-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114165446.611458-1-herve.codina@bootlin.com>
References: <20241114165446.611458-1-herve.codina@bootlin.com>
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
This device-tree root empty node does not have the #address-cells and
the #size-cells properties

This leads to the use of the default address cells and size cells values
which are defined in the code to 1 for the address cells value and 1 for
the size cells value.

According to the devicetree specification and the OpenFirmware standard
(IEEE 1275-1994) the default value for #address-cells should be 2.

Also, according to the devicetree specification, the #address-cells and
the #size-cells are required properties in the root node.

The device tree compiler already uses 2 as default value for address
cells and 1 for size cells. The powerpc PROM code also uses 2 as default
value for address cells and 1 for size cells. Modern implementation
should have the #address-cells and the #size-cells properties set and
should not rely on default values.

On x86, this root empty node is used and the code default values are
used.

In preparation of the support for device-tree overlay on PCI devices
feature on x86 (i.e. the creation of the PCI root bus device-tree node),
the default value for #address-cells needs to be updated. Indeed, on
x86_64, addresses are on 64bits and the upper part of an address is
needed for correct address translations. On x86_32 having the default
value updated does not lead to issues while the upper part of a 64-bit
value is zero.

Changing the default value for all architectures may break device-tree
compatibility. Indeed, existing dts file without the #address-cells
property set in the root node will not be compatible with this
modification.

Instead of updating default values, add both required #address-cells
and #size-cells properties in the device-tree empty node.

Use 2 for both properties value in order to fully support 64-bit
addresses and sizes on systems using this empty root node.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/empty_root.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
index cf9e97a60f48..cbe169ba3db5 100644
--- a/drivers/of/empty_root.dts
+++ b/drivers/of/empty_root.dts
@@ -2,5 +2,12 @@
 /dts-v1/;
 
 / {
-
+	/*
+	 * #address-cells/#size-cells are required properties at root node.
+	 * Use 2 cells for both address cells and size cells in order to fully
+	 * support 64-bit addresses and sizes on systems using this empty root
+	 * node.
+	 */
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
 };
-- 
2.47.0


