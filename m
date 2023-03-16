Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5A6BCF53
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 13:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjCPMXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 08:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCPMXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 08:23:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5856BB5FFF;
        Thu, 16 Mar 2023 05:23:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so1394393pjt.5;
        Thu, 16 Mar 2023 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678969406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jp98pcJvp2BMW6waSR5UgWY6ClpK9vkkyQOvxLLdxMI=;
        b=nzUBAztbb9bVMYfCDxdQTXRl5XlgQ2pmh7dQRqHNLkqNiw7NjeVXZm4XeXgIiwlrCJ
         +BDL5qaaAqu88COBowmHFtXLjqTHlfvRhK6RGUD5V/aQENp1mE3zzEoigEmn8pw6paNr
         bbUBZwI8oI5hzZaXFP39g+KR0xG3nrwlJCHIJN1fkYClTst3uuHFfNOCVw+ublCQFKVt
         hREy5Ohawjta3N9vAQpzE9fWty2yyfsj+qkLDWW5EAPsqSSBz5RQJafiCx8gzdOlq2xO
         ciubWECpNNpPNYy5BFVwQbXPkLljDCGsUfo7ykDzv2bt0yYB1C8qpiuAqjC2Vfg20SSU
         WN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678969406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jp98pcJvp2BMW6waSR5UgWY6ClpK9vkkyQOvxLLdxMI=;
        b=iM4wzHZSndFaACn4mmzzAqaN2lClTNfFO8d5lT9ZDPXSP96UP7bMUlxTh6Tr4eZHLD
         m8sVfga+Wr80tLnuXFWIulJtPE+q/+NvIVIY8QgGIDMHRpWNhRqR5BJXM7JJ5+e8GJeH
         q0xwLxpHLki2RZ+tgEEeFQF6o+21Jz7N1lN8pGUI5c3Gx1csZ6pIogZ4UtuVSQ+IAnEo
         DbsWevUArLiz+Lqp8JYTuDIV6Q4zdYxGYjWJz666wvfcZmDMwa25PYnuvNoVfJwbW02F
         7dgZOy7W2sLgk0MYaEHpN62upAqaZDk+0qhzhtBI0et9WhWyEmQDK+Ny12TU847porkK
         QaYQ==
X-Gm-Message-State: AO0yUKXGRtwDchei6DgzeXagTfl6pmF8sPvno96JaqISENeodfjsCBnU
        K0oYzZUVnrbsu1YiDpzBlMg=
X-Google-Smtp-Source: AK7set8ecygV9aU2bUDT/Mk5Ljc3NSJ1KprV4D/+2IG//HJ037con+rnr1hL42Ww4hHo1aUL/EMU9g==
X-Received: by 2002:a05:6a20:729c:b0:cc:eb3b:56e9 with SMTP id o28-20020a056a20729c00b000cceb3b56e9mr4725476pzk.1.1678969406412;
        Thu, 16 Mar 2023 05:23:26 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id m5-20020aa79005000000b005d22639b577sm5335083pfo.165.2023.03.16.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:23:25 -0700 (PDT)
From:   korantwork@gmail.com
To:     helgaas@kernel.org, nirmal.patel@linux.intel.com,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH v3] PCI: vmd: Add the module param to adjust MSI mode
Date:   Thu, 16 Mar 2023 20:23:22 +0800
Message-Id: <20230316122322.339316-1-korantwork@gmail.com>
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

In the legacy, the vmd MSI mode can only be adjusted by configing
vmd_ids table. This patch adds another way to adjust MSI mode by
adjusting module param, which allow users easier to adjust the vmd
according to the I/O scenario without rebuilding driver. There are two
params could be recognized: on, off. The default param is NULL,
the goal is not to effect the existing settings of the device.

Signed-off-by: Xinghui Li <korantli@tencent.com>
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
+ * off: enable MSI bypass
+ * on: enable MSI remapping
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

