Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87B6AD94F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 09:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCGIgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 03:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGIgF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 03:36:05 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDE4D2AF;
        Tue,  7 Mar 2023 00:36:04 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l1so12498070pjt.2;
        Tue, 07 Mar 2023 00:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678178164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVV7L3qYLKYMexLWKRK/2c4/r4h3dFdM7tR8nzD9LW8=;
        b=pNkFSovT8XQOKBhC6qK1O+NeD/Jtmwwpf5x5NnPKAMoSjn0US7tVs9ocrmvxgJEVhu
         HYbW9VeL14bR4vd9qjdjmwG/MX6X/RR49sy+TCU4TN3UTvowxoKSHFSt0lisJ2pLEOr+
         xZMU6obCtg744zSEKJ/gsAGiFzji+XX36wZJOjyB1NI0MygwrpM+xChFHF9gzRBQN3nl
         JcWfWL9mAGNWjT7iLXJpcWy0Jc9MQbmR2EuunzLiwK7SSznbD+34W8hlpvu3A566TDZY
         KVYlzorXRvCDekSG8OyVRNFQcpn4McK5IiXrLbByfH47/Rl1G9GdF3gFxZmCrEiYYCmX
         B35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678178164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVV7L3qYLKYMexLWKRK/2c4/r4h3dFdM7tR8nzD9LW8=;
        b=iY5FUwkT/zx1jXC0oxKIw8W+EhhAybCr947f3c0WplAfWr00VtmoVPDVvnhoxXxlf0
         sylTUnb8wE4YGRm/1yk56TEXemf8dL64JtFhnrMm97koexPoGwHVjZf2x8zIxTjVbxSA
         NAtNH4IEc5dWnDlq+txTKOJd71aB5JFAnNNlG0tHy3OlyM0SGu9jvvb+OECkJQThfSnE
         +ox6sAZ4ZpC5fihPdJoZJrMe1JU9+OgXGmbHkdLTsoiOo/Q22im33E5xp4LDsbW0Iv1V
         lbNef5BQtoi4rcr/wTrd5ROL1TAeNauFQzrTwNdoIp/KYyqzDPt5tmSwmDPtj+24IMGG
         GpbA==
X-Gm-Message-State: AO0yUKXXOZKp+QNhpCn8nH9N8ZLHbUP4WhSJ8pkah00SQEAizptwuCx9
        +kv3Yorwy3WEf4jK0x/aLrk=
X-Google-Smtp-Source: AK7set+Li7VjSseMkvHU1Tjn56/7Rw2YZ9NQuKIQGizRKj+yFyFGEJY3TY0tSt6LJZ/QtaTLG8OZZw==
X-Received: by 2002:a05:6a20:9305:b0:cb:e98e:d1eb with SMTP id r5-20020a056a20930500b000cbe98ed1ebmr12664155pzh.29.1678178163927;
        Tue, 07 Mar 2023 00:36:03 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id 19-20020a631253000000b004fb171df68fsm7209860pgs.7.2023.03.07.00.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:36:03 -0800 (PST)
From:   korantwork@gmail.com
To:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH v2] PCI:vmd: add the module param to adjust msi mode
Date:   Tue,  7 Mar 2023 16:35:59 +0800
Message-Id: <20230307083559.2379758-1-korantwork@gmail.com>
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
params could be recognized: on, off. The default param is "NULL",
the goal is not to affect the existing settings of the device.

Signed-off-by: Xinghui Li <korantli@tencent.com>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6..8b42b2c1d949 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -34,6 +34,20 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+/*
+ * The VMD msi_remap module parameter provides the alternative way
+ * to adjust msi mode when loading vmd.ko other than vmd_ids table.
+ * There are two params could be recognized:
+ *
+ * 1-off
+ * 2-on
+ *
+ * The default param is "NULL", the goal is not to affect the existing
+ * settings of the device.
+ */
+char *msi_remap = "NULL";
+module_param(msi_remap, charp, 0444);
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -875,6 +889,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			return ret;
 
 		vmd_set_msi_remapping(vmd, true);
+		dev_info(&vmd->dev->dev, "init vmd with remapping msi-x\n");
 
 		ret = vmd_create_irq_domain(vmd);
 		if (ret)
@@ -887,6 +902,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
 	} else {
 		vmd_set_msi_remapping(vmd, false);
+		dev_info(&vmd->dev->dev, "init vmd with bypass msi-x\n");
 	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
@@ -955,6 +971,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	return 0;
 }
 
+static void vmd_config_msi_remap_param(unsigned long *features)
+{
+	if (strcmp(msi_remap, "on") == 0)
+		*features &= ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
+	else if (strcmp(msi_remap, "off") == 0)
+		*features |= VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+}
+
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned long features = (unsigned long) id->driver_data;
@@ -984,6 +1008,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (err < 0)
 		goto out_release_instance;
 
+	vmd_config_msi_remap_param(&features);
+
 	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
 	if (!vmd->cfgbar) {
 		err = -ENOMEM;
-- 
2.31.1

