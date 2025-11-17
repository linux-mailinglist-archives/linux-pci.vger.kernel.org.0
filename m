Return-Path: <linux-pci+bounces-41446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F0C65BDD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3365B4E1DE5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C912868B4;
	Mon, 17 Nov 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="jOEfwW6I"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E730CDA8;
	Mon, 17 Nov 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404639; cv=none; b=rTaNW6EVeNJ/XqrjhUKT83GRzVkGmPSgf715w5Ko9xw10ju+4rFX4XPUFVehbHd3ZY9eVG9dq2jBnBh21ucVDnKHphYDmOeRvSiFM4CsfQNgKfObqUe6pVR3FR7WWIsbD/KP7C4gTFr7s6voTdgeXUffmHsDxNR6QR2OzOIwDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404639; c=relaxed/simple;
	bh=IA9dukPUv7yYp7i2jd6pN6ihgfXp6OJ/Njouogyv70U=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=TtSasa6NrZXQEDRdWAgv0+GJDfGPmiyc+EeA9D9lCxljagT4msNsV9oKYyFeoXlftyIs0rcuobD75W4DzMyxi0OVf9viVnuINcp5TfwnxhXetgkPMBFofmNxVx6OfC4YA4tLCEVjYNr4zL0OgVK2qIS8wwJ0UvO1qB64KD3dHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=jOEfwW6I; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=TMIpJ+MhqSoo9waohgGN9xZkGLLljhYSQoQl9IhRJyM=; b=j
	OEfwW6I2vL7Sh2VRIrmmb8Wfq4s38JGHDK/dpyPK0n/MExeXRst6N39hfh7HbOF/SAW64mObe4haM
	R1eonKQDWZbM3aqYxQyuBLOsM+GV7tVt5ZSb7aKvSrw3MDeUHjCF3oE9jgK8/SkgEdBs7CPnHWiJW
	WZyFB/pzCRjQ1d1ZJxO+8U1jLUwKiKpCretn2isNArq4slnrnLQ+MrqO12lqrLIdqdXm9vkS2buSR
	4k6LCegOcLd2ukkxKIZUEqT1GTuPrVCqu0qoz/UqRrwAPFWjks0msAGAzh8niHqiy+UyL9iIL1Xuj
	XeKJsQ0fLniYhlM6x2wroqo+uCJXW25RQ==;
Date: Mon, 17 Nov 2025 19:37:25 +0100 (CET)
Message-Id: <20251117.193725.1655587639439350088.rene@exactco.de>
To: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Clemens Ladisch <clemens@ladisch.de>, Guenter Roeck
 <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] hwmon: (k10temp) Add AMD Steam Deck APU ID
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Add AMD Custom APU 0405 PCI ID as used in the Valve Steam Deck to
k10temp.

Signed-off-by: René Rebe <rene@exactco.de>

---
Tested for nearly three years on my first gen Steam Deck.

index b98d5ec72c4f..1ab64adb63e9 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -553,6 +553,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M90H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..d86b203de1df 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -573,6 +573,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M40H_DF_F3 0x13f3
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_17H_M90H_DF_F3 0x1663
 #define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 
-- 
  René Rebe, ExactCODE GmbH, Berlin, Germany
  https://exactco.de | https://t2linux.com | https://rene.rebe.de

