Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C337E6A3B5C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 07:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjB0GsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 01:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0GsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 01:48:06 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F639752;
        Sun, 26 Feb 2023 22:48:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z11so2878754pfh.4;
        Sun, 26 Feb 2023 22:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPgzz5/dNgdhuDQ13YjvjBHzKfgCJZSuUYX8uPM+e5o=;
        b=nsvE4BjdVgwlk5DfuOm60xQ6aEviuOGt9an9oE183fcSRBxcb1L3EAvlrPoe5sfiXn
         Xuze/DqJ/f4WowL4w2PaM5Y3BI2wxLDdSHJGuAyJ2I7dcGg3+ujvNMoXdt3A7xvr/2F7
         PCYOLukfUzlYAlaRUHnMUHiRLstC8k7G5dgcXoRIi4wh8URDvHNJlz6CFxqg7Jq+6HB8
         dlk61kq17g5NjIWQgwXpglYxDkqBCx6UsXZ8l08sLTKJQjWhyorNur54rsim0Z8n+FEB
         U9ViPQbG4Csjsn7g4J8qY8Ya0riCL5uR/s5qnn9HoUncs0z8bmSwJ1n1OQtOCEHZSYvi
         x7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPgzz5/dNgdhuDQ13YjvjBHzKfgCJZSuUYX8uPM+e5o=;
        b=c6fD00yrpCtOqhUVXQ5ShWoejuNQZyU3b1yPe4rxWmeOjVCevifszUwrfclZuMyRJd
         o5GdJxSd8ggrl2KKqhaTapjdXYpDsoAdIjYcrLs+VN3aZXhJJ91JH80r61KVzrtKsmwZ
         U08L45vxfAjfTYFDOpBmhotGpJ43RYhtwrt08hJz4pCX+zYMQiIHZLOuw0BJSNuCmt+7
         mGWmS7jsJf1qvUkRwhUu5aLhbhKefrQ4bqwHLOdKzQyTjWdtpitO6k3qKun1sKdcdOnS
         3qHkpTk2aiihP6oKgP0XxJTK4ggUG4HAAVfyVb7I6qxioxTaPvhyd+4dV5DMgUkpy8Nl
         MJkQ==
X-Gm-Message-State: AO0yUKV1SN3PtDPiToZXq5CKYT0NraT5XBO2FJfbtd+V5xjntTjV+UzP
        0nLyBkp2ZJuc36jIsRzL7+o=
X-Google-Smtp-Source: AK7set8fg6X6HQM4Xt1Xw76b0qyu6hi6c2pcD9UFSY2H46WsU6xGczs6UTMQDvsKHtchnO6FHkQQOw==
X-Received: by 2002:a62:7b07:0:b0:577:272f:fdb with SMTP id w7-20020a627b07000000b00577272f0fdbmr21125975pfc.29.1677480485015;
        Sun, 26 Feb 2023 22:48:05 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005a8b4dcd213sm3467107pfn.78.2023.02.26.22.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 22:48:04 -0800 (PST)
From:   korantwork@gmail.com
To:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH] PCI:vmd: add the module param to adjust msi mode
Date:   Mon, 27 Feb 2023 14:48:00 +0800
Message-Id: <20230227064800.340833-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

In the legacy, the vmd msi-mode can only be adjusted by configing
vmd_ids table.This patch adds another way to adjust msi mode by
adjusting module param, which allow users easier to adjust the vmd
according to the I/O scenario without rebuilding driver.There are two
params could be recognized: remapping, bypass.

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/pci/controller/vmd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..6d3272f5598d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -34,6 +34,18 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+/*
+ * The VMD msi_mode module parameter provides the alternative way
+ * to adjust msi_mode when load vmd.ko other than vmd_ids table.
+ * There are two params could be recognized:
+ *
+ * 1-remapping
+ * 2-bypass
+ *
+ */
+char *msi_mode = "default";
+module_param(msi_mode, charp, 0444);
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -820,6 +832,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			return ret;
 
 		vmd_set_msi_remapping(vmd, true);
+		dev_info(&vmd->dev->dev, "init vmd with remapping msi-x\n");
 
 		ret = vmd_create_irq_domain(vmd);
 		if (ret)
@@ -832,6 +845,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
 	} else {
 		vmd_set_msi_remapping(vmd, false);
+		dev_info(&vmd->dev->dev, "init vmd with bypass msi-x\n");
 	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
@@ -898,6 +912,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	return 0;
 }
 
+static void vmd_config_msi_mode_param(unsigned long *features)
+{
+	if (strcmp(msi_mode, "remapping") == 0)
+		*features &= ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
+	else if (strcmp(msi_mode, "bypass") == 0)
+		*features |= VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+}
+
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned long features = (unsigned long) id->driver_data;
@@ -927,6 +949,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (err < 0)
 		goto out_release_instance;
 
+	vmd_config_msi_mode_param(&features);
+
 	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
 	if (!vmd->cfgbar) {
 		err = -ENOMEM;
-- 
2.34.1

