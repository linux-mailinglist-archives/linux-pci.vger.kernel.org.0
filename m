Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4E6C132D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCTNXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjCTNXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 09:23:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A12700;
        Mon, 20 Mar 2023 06:23:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so12550762pjp.1;
        Mon, 20 Mar 2023 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679318600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwCDKhpVotUuQMaBr5jTrfbX68cNb9ff470+ysZxzzQ=;
        b=DbPUt+EfMJ+gN+n6cCxeLDCHK554tVu7xveqEz1ELZYrSZU538T3sIDkOC2iEjLIj3
         vxyOtqP1ORPBGGeWWY46uhEHukWiZdqTrcJYK4WmRBV+BqNwsat4pGHhP2lpFDF6X8qY
         wBmIMBPiigRbDggFkUwax/ZeAKqVtNKlUN7cLHY58OLU9kqmdvMT70JBWt3eNt0b6chR
         9o8ugYkJBCfDbaPcUQ4/rc0MjCMCgNjWj+2RYSMV4u2rVtzUGNU0GTJk1Nt6ypxmTN9A
         HRbkkDGmm7Xir+AWDuEMejFwBSvZp0Vqijsia2SVlSi3FPDyy4xAD4239RbBglvz8Ds/
         Ynow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679318600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwCDKhpVotUuQMaBr5jTrfbX68cNb9ff470+ysZxzzQ=;
        b=LwVGFqdirmwgB2zMNLQM/y/VhtGJBVP/4pGZWQoVAaviilX7VJfoW26awcJz0jAYbI
         10onTQgrZeImbOtG7b8oMMS3DV+ItLeeZVZdDNxTTxy1ksMjwKhYql9D/Fy4FbDRlnJ0
         6mHOKb7ws0RmGnatenb/RqgvFOSBUxW4mpm9SBDb3uMlSuHy5gxnb5t3rZNRFh9dTn9H
         glDmQSWQh2zWMXM+Xqw8HnBoxG00ZpFIpQmdvg3lixf4T5kMynrEOVlab9yELXiUeKLH
         3F0uB5S8Remqrq/gBd7IEMG6NQwTQkoaIFsrJEI42Jp2Dmv1t++rYJt6RG8SaTsen+vx
         MqWw==
X-Gm-Message-State: AO0yUKUlh2MbdCFNRKwYeOidRzcYSHI2skSUeZvSinovnB7zW8GH9qXQ
        xzqJd+tk5fbdBLc+fmEVhPk=
X-Google-Smtp-Source: AK7set8aYmCTfdKijx/Xv5EdBgScVTAJQugwVEr8ZpKjCsLK3YBjTocbHsvANkrz6b03DDcBWUhaGQ==
X-Received: by 2002:a17:90b:380d:b0:232:fa13:4453 with SMTP id mq13-20020a17090b380d00b00232fa134453mr19012364pjb.13.1679318600483;
        Mon, 20 Mar 2023 06:23:20 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090aa51300b00233db0db3dfsm9824478pjq.7.2023.03.20.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:23:20 -0700 (PDT)
From:   korantwork@gmail.com
To:     helgaas@kernel.org, nirmal.patel@linux.intel.com,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
Date:   Mon, 20 Mar 2023 21:23:16 +0800
Message-Id: <20230320132316.3126838-1-korantwork@gmail.com>
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

In the legacy, the vmd MSI mode can only be adjusted by configuring
vmd_ids table. This patch adds another way to adjust MSI mode by
adjusting module param, which allows users easier to adjust the vmd
according to the I/O scenario without rebuilding driver. There are two
params that could be recognized: on, off. The default param is NULL,
the goal is not to effect the existing settings of the device.

Signed-off-by: Xinghui Li <korantli@tencent.com>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6..fb61181baa9e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -34,6 +34,19 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+/*
+ * The VMD msi_remap module parameter provides the alternative way
+ * to adjust MSI mode when loading vmd.ko other than vmd_ids table.
+ * There are two params could be recognized:
+ *
+ * off: disable MSI remapping
+ * on:  enable MSI remapping
+ *
+ */
+static char *msi_remap;
+module_param(msi_remap, charp, 0444);
+MODULE_PARM_DESC(msi_remap, "Whether to enable MSI remapping function");
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -875,6 +888,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			return ret;
 
 		vmd_set_msi_remapping(vmd, true);
+		dev_info(&vmd->dev->dev, "init vmd with remapping MSI\n");
 
 		ret = vmd_create_irq_domain(vmd);
 		if (ret)
@@ -887,6 +901,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
 	} else {
 		vmd_set_msi_remapping(vmd, false);
+		dev_info(&vmd->dev->dev, "init vmd with bypass MSI\n");
 	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
@@ -955,6 +970,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	return 0;
 }
 
+static void vmd_config_msi_remap_param(unsigned long *features)
+{
+	if (msi_remap) {
+		if (strcmp(msi_remap, "on") == 0)
+			*features &= ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
+		else if (strcmp(msi_remap, "off") == 0)
+			*features |= VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+	}
+}
+
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned long features = (unsigned long) id->driver_data;
@@ -984,6 +1009,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (err < 0)
 		goto out_release_instance;
 
+	vmd_config_msi_remap_param(&features);
+
 	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
 	if (!vmd->cfgbar) {
 		err = -ENOMEM;
-- 
2.31.1

