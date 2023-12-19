Return-Path: <linux-pci+bounces-1192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECDE819255
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 22:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB481F257C5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412030FB3;
	Tue, 19 Dec 2023 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOChbYds"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02C3B2A8
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4260bbc84c5so42503431cf.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 13:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703021679; x=1703626479; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ6HZXMgbmpTgr8PpNdjNqBO87Wu/Pv5RD/wkslCUu8=;
        b=kOChbYds8LKiYWTLDjgFKVAev8hxT8A/zEQjNv5EHVcUIvfiLNZY8BKB9mS99SqyRS
         5mERBPQea1psmM0/6nj9EB2b3iCfO5K73PZV7a6AIECFKrzP68exYCjXy36N/m1ElNKV
         Ud8cYui69djsq58pKwlLygx0921HIxY6XJlZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703021679; x=1703626479;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQ6HZXMgbmpTgr8PpNdjNqBO87Wu/Pv5RD/wkslCUu8=;
        b=k7kI1zZJ+SV0u1QILMZ00VzZRxh/8IwMh0zWukyUNt7VXYexwMbIGXrb2aNM28DPgw
         D7MbOCd26Tx4Eiv3BGCpixG5o5AtHUoNMXqt04OXiZjtwQcLH3KB2wbU4rwYxYFC6rAf
         C/+Zcay3Sn+niGBMQcT8bOGzvsdjmwRNJD8tS2GB7TDW91e7FaLGawcThHZc0pB1g4U1
         Gr9JB6+JziTV+KAW5HybywJlFjYro10dQWLIvXUsr3QQCpe33Dn14JI5dm4RRypM5XQ1
         R5CTI7E2RDYDwlC34k1/36OVHnRhYQrsJkSw51cl/RZaPtsS70OBJpkpoPHiPUo1C3b4
         YxpQ==
X-Gm-Message-State: AOJu0Yx9bMBjCoQq/1CysBcnnrcnnht8NXCjZLpi1Yax3w13jn3R0Rzt
	hiWR68v8eawmsiPlsiRZB8Ug3OXq9hZ6Y2YUKE0=
X-Google-Smtp-Source: AGHT+IG3+LxITZAJ8ZF0p+BbVZRrdPBBw1tYDmppXKgewWa3mwUDq59cHMLuQel1aog8vcQ+Erx+Gg==
X-Received: by 2002:ac8:7f94:0:b0:425:a5ba:f126 with SMTP id z20-20020ac87f94000000b00425a5baf126mr26650374qtj.105.1703021679273;
        Tue, 19 Dec 2023 13:34:39 -0800 (PST)
Received: from eshimanovich.nyc.corp.google.com ([2620:0:1003:314:e32b:502a:7a4:a977])
        by smtp.gmail.com with ESMTPSA id t22-20020ac85316000000b0041cb787ff41sm10510228qtn.67.2023.12.19.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:34:39 -0800 (PST)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Tue, 19 Dec 2023 16:34:33 -0500
Subject: [PATCH v2] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org>
X-B4-Tracking: v=1; b=H4sIAGkMgmUC/4WNQQqDMBBFryKz7hSTCGpXvYe40DiagWpkEqVFv
 HtTL9Dle/DfPyCQMAV4ZAcI7RzYLwn0LQPrumUi5CEx6FwbpVWN0W3LQNL7V8TVMq5dtA4LpIF
 KZfvKGFtAWq9CI7+vctMmdhyil891tKuf/d/cFSosqCJTlmbMu/ppnfiZt/nuZYL2PM8vOsi9h
 sEAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rajat Jain <rajatja@google.com>, 
 Esther Shimanovich <eshimanovich@chromium.org>
X-Mailer: b4 0.12.3

On Lenovo X1 Carbon Gen 7/8 devices, when a platform enables a policy to
distrust removable PCI devices, the build-in USB-C ports stop working at
all.
This happens because these X1 Carbon models have a unique feature; a
Thunderbolt controller that is discrete from the SoC. The software sees
this controller, and incorrectly assumes it is a removable PCI device,
even though it is fixed to the computer and is wired to the computer's
own USB-C ports.

Relabel all the components of the JHL6540 controller as DEVICE_FIXED,
and where applicable, external_facing.

Ensure that the security policy to distrust external PCI devices works
as intended, and that the device's USB-C ports are able to enumerate
even when the policy is enabled.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
---
Changes in v2:
- nothing new, v1 was just a test run to see if the ASCII diagram would
  be rendered properly in mutt and k-9
- for folks using gmail, make sure to select "show original" on the top
  right, as otherwise the diagram will be garbled by the standard
  non-monospace font
- Link to v1: https://lore.kernel.org/r/20231219-thunderbolt-pci-patch-4-v1-1-4e8e3773f0a9@chromium.org
---
 drivers/pci/quirks.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..58401b099407 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3873,6 +3873,116 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       quirk_apple_poweroff_thunderbolt);
 #endif
 
+/*
+ * On most ThinkPad Carbon 7/8s, JHL6540 Thunderbolt 3 bridges are set
+ * incorrectly as DEVICE_REMOVABLE despite being built into the device.
+ * This is the side effect of a unique hardware configuration.
+ *
+ * Normally, Thunderbolt functionality is integrated to the SoC and
+ * its root ports.
+ *
+ *                          Most devices:
+ *                    root port --> USB-C port
+ *
+ * But X1 Carbon Gen 7/8 uses Whiskey Lake and Comet Lake SoC, which
+ * don't come with Thunderbolt functionality. Therefore, a discrete
+ * Thunderbolt Host PCI controller was added between the root port and
+ * the USB-C port.
+ *
+ *                        Thinkpad Carbon 7/8s
+ *                 (w/ Whiskey Lake and Comet Lake SoC):
+ *                root port -->  JHL6540   --> USB-C port
+ *
+ * Because the root port is labeled by FW as "ExternalFacingPort", as
+ * required by the DMAR ACPI spec, the JHL6540 chip is inaccurately
+ * labeled as DEVICE_REMOVABLE by the kernel pci driver.
+ * Therefore, the built-in USB-C ports do not enumerate when policies
+ * forbidding external pci devices are enforced.
+ *
+ * This fix relabels the pci components in the built-in JHL6540 chip as
+ * DEVICE_FIXED, ensuring that the built-in USB-C ports always enumerate
+ * properly as intended.
+ *
+ * This fix also labels the external facing components of the JHL6540 as
+ * external_facing, so that the pci attach policy works as intended.
+ *
+ * The ASCII diagram below describes the pci layout of the JHL6540 chip.
+ *
+ *                         Root Port
+ *                 [8086:02b4] or [8086:9db4]
+ *                             |
+ *                        JHL6540 Chip
+ *     __________________________________________________
+ *    |                      Bridge                      |
+ *    |        PCI ID ->  [8086:15d3]                    |
+ *    |         DEVFN ->      (00)                       |
+ *    |       _________________|__________________       |
+ *    |      |           |            |           |      |
+ *    |    Bridge     Bridge        Bridge      Bridge   |
+ *    | [8086:15d3] [8086:15d3]  [8086:15d3] [8086:15d3] |
+ *    |    (00)        (08)         (10)        (20)     |
+ *    |      |           |            |           |      |
+ *    |     NHI          |     USB Controller     |      |
+ *    | [8086:15d2]      |       [8086:15d4]      |      |
+ *    |    (00)          |          (00)          |      |
+ *    |      |___________|            |___________|      |
+ *    |____________|________________________|____________|
+ *                 |                        |
+ *             USB-C Port               USB-C Port
+ *
+ *
+ * Based on what a JHL6549 pci component's pci id, subsystem device id
+ * and devfn are, we can infer if it is fixed and if it faces a usb port;
+ * which would mean it is external facing.
+ * This quirk uses these values to identify the pci components and set the
+ * properties accordingly.
+ */
+static void carbon_X1_fixup_relabel_alpine_ridge(struct pci_dev *dev)
+{
+	if (!dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon 7th") &&
+	    !dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon Gen 8"))
+		return;
+
+	/* Is this JHL6540 PCI component embedded in a Lenovo device? */
+	if (dev->subsystem_vendor != 0x17aa)
+		return;
+
+	/* Is this JHL6540 PCI component embedded in an X1 Carbon Gen 7/8? */
+	if (dev->subsystem_device != 0x22be && // Gen 8
+	    dev->subsystem_device != 0x2292) { // Gen 7
+		return;
+	}
+
+	dev_set_removable(&dev->dev, DEVICE_FIXED);
+
+	/* Not all 0x15d3 components are external facing */
+	if (dev->device == 0x15d3 &&
+	    dev->devfn != 0x08 &&
+	    dev->devfn != 0x20) {
+		return;
+	}
+
+	dev->external_facing = true;
+}
+
+/*
+ * We also need to relabel the root port as a consequence of changing
+ * the JHL6540's PCIE hierarchy.
+ */
+static void carbon_X1_fixup_rootport_not_removable(struct pci_dev *dev)
+{
+	if (!dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon 7th") &&
+	    !dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon Gen 8"))
+		return;
+
+	dev->external_facing = false;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d3, carbon_X1_fixup_relabel_alpine_ridge);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d2, carbon_X1_fixup_relabel_alpine_ridge);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d4, carbon_X1_fixup_relabel_alpine_ridge);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x02b4, carbon_X1_fixup_rootport_not_removable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9db4, carbon_X1_fixup_rootport_not_removable);
+
 /*
  * Following are device-specific reset methods which can be used to
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231219-thunderbolt-pci-patch-4-ede71cb833c4

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


