Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5CF6E8AF1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjDTHJu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 03:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjDTHJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 03:09:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A8558D;
        Thu, 20 Apr 2023 00:09:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-63b7588005fso676845b3a.0;
        Thu, 20 Apr 2023 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974559; x=1684566559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgJY1hiFKqX+w6LLZ3fee7l/ovDaM7Mvo24SInHmDsg=;
        b=V+ZsB60bpdgJy7Dn9GZC4OnTeeHxQPWo9NW7+bMfokCuZxbGmstFSeYHez97GS6a42
         QQAECBG9Pp1B7RogsbqgT3gkj0CZ57DStXkghmir9fl76hBozq60MOapPmNv6VuxEK4a
         QcupBobZmpVym6dZTlZWINENyzfoQsrVGh/1zMnEca3kYFCaTbjlRAbkTxJfs90kWJtT
         Bumq5J0dITt379+n84an6gwpXRV/6ke6MMi+dbCK8USYsIURfkiUmL4y9s7oBiwAvo52
         QDTbvDsFoPfTB8iXVyrgzJnRwp9G33SRbMvePwYf4SB0pkQWQWGiVRhsQXNge/vQI3nZ
         I/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974559; x=1684566559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgJY1hiFKqX+w6LLZ3fee7l/ovDaM7Mvo24SInHmDsg=;
        b=a1lIhHwWF/ZrnmRY0vfSSbMc+P30Zf7KR1f9QS7m0ARJoUAEC/Qsczz3s81OImOeUr
         cB18jwZv3hLjlnHXNU9YYepMPoBEKa4JAltytu5ehCwvcuESTigv19ejZNYdYy/0f98W
         pFMY0iFmMoIif0f0GHPG5hlLLW2Y7XWWOs8TMeWFi6S8epN9Nt7VbQFaFerYmRL6u6zY
         1eIqqQBJq8akDhgtN1S8Y83xbQa0y7q8FCWnu0UrKIwSI/obCAwHjQCaIlx2w7f0vTaA
         7sj/QdpbC/xNGDeVPpXb5ksIaNXl5Upvru46mnd6j+9WWxWYpjpaxFwrhatq69XaH9oB
         8YAA==
X-Gm-Message-State: AAQBX9foZmCyVzWXPfEshA21IW0w1UVIxDvTA8MjOHvr9ryKou7GhYOO
        Zech4wZXFP48YGIpaCW7HjI=
X-Google-Smtp-Source: AKy350Z8+n5KwNdXI9m+pUnlYONRImHCi5g8u9N65BgFlbMvpIkvdtVEjvlMqTmKZcZli4hvS17Ptg==
X-Received: by 2002:a05:6a20:8e0c:b0:ef:2389:66c5 with SMTP id y12-20020a056a208e0c00b000ef238966c5mr1277801pzj.12.1681974559066;
        Thu, 20 Apr 2023 00:09:19 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id h64-20020a638343000000b0051b603bf22csm503080pge.69.2023.04.20.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:09:18 -0700 (PDT)
From:   korantwork@gmail.com
To:     helgaas@kernel.org, nirmal.patel@linux.intel.com,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH v5] PCI: vmd: Add the module param to adjust MSI mode
Date:   Thu, 20 Apr 2023 15:09:14 +0800
Message-Id: <20230420070914.1383918-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

In the past, the vmd MSI mode can only be adjusted by configuring
vmd_ids table. This patch adds another way to adjust MSI mode by
adjusting module parameter, which allows users easier to adjust the vmd
according to the I/O scenario without rebuilding driver.

- "disable_msi_bypass=0 or other values":
  Under normal circumstances, we recommend enable the VMD MSI-X bypass
  feature, which improves interrupt handling performance by avoiding
  the VMD MSI-X domain interrupt handler.

- "disable_msi_bypass=1":
  Use this when multiple NVMe devices are mounted on the same PCIe
  node with a high volume of 4K random I/O. It mitigates excessive
  pressure on the PCIe node caused by numerous interrupts from NVMe
  drives, resulting in improved I/O performance. Such as:

  In FIO 4K random test when 4 NVME(Gen4) mounted on the same PCIE port:
    - Enable bypass: read: IOPS=562k, BW=2197MiB/s, io=644GiB
    - Disable bypass: read: IOPS=1144k, BW=4470MiB/s, io=1310GiB

As not all devices support VMD MSI-X bypass, this parameter is
only applicable to devices that support the bypass function and
have already enabled it, such as VMD_28C0. Besides, this parameter
does not affect the MSI-X working mode in guest.

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/pci/controller/vmd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6..8ee673810cbf 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -34,6 +34,20 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+/*
+ * The VMD disable_msi_bypass module parameter provides the alternative
+ * way to adjust MSI mode when loading vmd.ko. This parameter is only applicable
+ * to devices that both support and have enabled bypass, such as VMD_28C0.
+ * Besides, it does not affect MSI-X mode in the guest.
+ *
+ * 1: disable MSI-X bypass
+ * other values: not disable MSI-X bypass
+ */
+static int disable_msi_bypass;
+module_param(disable_msi_bypass, int, 0444);
+MODULE_PARM_DESC(disable_msi_bypass, "Whether to disable MSI-X bypass function.\n"
+	"\t\t  Only effective on the device supporting bypass, such as 28C0.");
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -875,6 +889,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			return ret;
 
 		vmd_set_msi_remapping(vmd, true);
+		dev_info(&vmd->dev->dev, "init vmd with remapping MSI-X\n");
 
 		ret = vmd_create_irq_domain(vmd);
 		if (ret)
@@ -887,6 +902,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
 	} else {
 		vmd_set_msi_remapping(vmd, false);
+		dev_info(&vmd->dev->dev, "init vmd with bypass MSI-X\n");
 	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
@@ -955,6 +971,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	return 0;
 }
 
+static void vmd_config_msi_bypass_param(unsigned long *features)
+{
+	/*
+	 * Not every VMD device supports and enables bypass MSI-X.
+	 * Make sure current device has the bypass flag set.
+	 */
+	if (disable_msi_bypass == 1 &&
+	  *features & VMD_FEAT_CAN_BYPASS_MSI_REMAP)
+		*features &= ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
+}
+
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned long features = (unsigned long) id->driver_data;
@@ -984,6 +1011,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (err < 0)
 		goto out_release_instance;
 
+	vmd_config_msi_bypass_param(&features);
+
 	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
 	if (!vmd->cfgbar) {
 		err = -ENOMEM;
-- 
2.31.1

