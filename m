Return-Path: <linux-pci+bounces-44416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453ED0D0CE
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFBBA3025320
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56B343D62;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS4YRnk2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534922097;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=k3B0cGl+G4ukdD5CmG3ss+WFMiAviIdduu6K2CFtWV62CcxWgfBpWZB7bwgOqp0iOtpv8QzjavOc1mWn6Kes3NsuD+xAkQOpNXUi1oyq1XUBxKek2JYekVOKZsmLIdd13u+loXC+A08yg45f2M2ANa3+wnhTbGa944xfksruhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=hDPnw+4s+5AfhYRapWXIeYIqcco/LOIiPCYIsOdQ49Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mi6D3kbowxFpaPMxmDw5HOgvlYHHs8XncGtC7vWyREuWBcO9Zx1Ed5EkdFSMWU4mC2f0AgoKol+4EIF6rAO6uGRI7vF7D/+qEPOZsJ2RRf5M7NWJ58yp0o9MgkGDMaxPi0g9tlRUFRU3KJnMHsj+R6ReF6Dmf7z6YnidX/uUKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS4YRnk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A68B6C2BCB7;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028225;
	bh=hDPnw+4s+5AfhYRapWXIeYIqcco/LOIiPCYIsOdQ49Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VS4YRnk2PEE25T0jdogoLuk7ga23MFTeQpsg0EMM/7nu0jS88kgaotPPmuBGk+EuZ
	 +ZoAx+ao731/GVK1S4g2KQahecCIVnXAKlxvJ+YjSSCtc7SQSvNqOh+WrdiGniBRYu
	 61f5T2qcXEaetVGDxZJdyi/E+yRmXo6ocOdPkkqtuq+AiipSuWwhVAWGcM7yql+gBq
	 T0TbNlgmGiklxv49QcgFwZCSmPFhc3vMc62JVNC94G6opHJ6tDbzswSQgJIexXJLPM
	 09HFZOVUC5qg9SUjfh4frQ8pTw72J2UKrocd7svvhTfEtoV+tdzZXLH/LiSaScA/2J
	 vAPTH010m9j2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF9FD277CB;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:22 +0530
Subject: [PATCH v3 04/14] software node: Add software_node_match_device()
 API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-4-4faee7d0d5ae@oss.qualcomm.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
In-Reply-To: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mk+22vELC/3V7yY/NXlFA3vD3kSET8m5DTszs9AvqXY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg9Y99IanSmu9QJ6YjBWzXaYH1WMkXby+Z1k
 MFTY95nCtqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PQAKCRBVnxHm/pHO
 9YtIB/92vQe9mQsngvUdSjaLUQ7AU4/ek+jfJ1Sl4uMFPGnwNkfF/C0CnVYAqlo7kTSx3PMkS6e
 puOyptgLde2NI/FJAi9xWlPOAGZoEWA0UuR5vm5Ruua5a5pPDl/kN1P8TatbXHLxvZ270irGGgq
 kOr+XGlTA1xJbJo6dCnn9RnGsT0U71tNueOaiKoR4KuID2xszPv3rzhAVdmgnytX9C/MTCN4O6i
 uREiUhoOES477d29EqyCMIt0LupgeiftbShlhKO14mp57wvXz6awEaa5Von5aW4gGgSpQFm7PKw
 TT/z9GfBt82BZcIoCueY5KM9c4bEKdOE3uWmadm+lKv8D2wH
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add software_node_match_device() API to match the swnode device with the
swnode driver. The matching is based on the compatible property in the
device and the driver's of_match_table.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/base/swnode.c    | 16 ++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index cd722712b8e9..4a3b367dea02 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -372,6 +372,22 @@ void property_entries_free(const struct property_entry *properties)
 }
 EXPORT_SYMBOL_GPL(property_entries_free);
 
+bool software_node_match_device(struct device *dev, const struct device_driver *drv)
+{
+	const struct of_device_id *id;
+
+	if (!drv->of_match_table)
+		return false;
+
+	for (id = drv->of_match_table; id->compatible[0]; id++) {
+		if (device_is_compatible(dev, id->compatible))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(software_node_match_device);
+
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 272bfbdea7bf..7fe75ab732f6 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -14,6 +14,7 @@
 #include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/device.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -597,6 +598,8 @@ void software_node_unregister_node_group(const struct software_node * const *nod
 int software_node_register(const struct software_node *node);
 void software_node_unregister(const struct software_node *node);
 
+bool software_node_match_device(struct device *dev, const struct device_driver *drv);
+
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);

-- 
2.48.1



