Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216DC6B7F9D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 18:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCMRie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 13:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMRid (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 13:38:33 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD12ED58;
        Mon, 13 Mar 2023 10:38:31 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id y11so13840018plg.1;
        Mon, 13 Mar 2023 10:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678729111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5EZDs6kXnSVYcikXXlYapDyzbwlC80fqfQCO/00Qrc=;
        b=fMXIagtLxBDhvjjuEu//L0RZiZKsyqq7JVOdZwWumUKwkxrBbF/QCzcj3Oh2lraz76
         1HPNcYMDvzx54ZizUo1MdJotAq72Re2cHzbJjz+7h2qSyXvH8rU67ZDPeH/sOhRCMaxj
         0RPj+lfVtfyG5d30VDhIc+rJnvGKh6Q87Lz8vwpyDc2nCjvtxtIMVq+obpiRkgUCK2mw
         4e4xlbFzOTEsmPwcIvsEeMdDvkHIvbi4CkGxPlhmyTrIxNDQ4MoBsAE9djcwU4u5ZesS
         uNEhtWsTP9UIWU94EHIlWDpQ6QcFber8BOPSY9pAtF92nB5XJ9ODIEuyIiOTbuAAcoZ3
         TRmQ==
X-Gm-Message-State: AO0yUKXCGZTqqcC1Ua0ihPZ/zGkqzUOOb9MUSMXLRpzbTcbvnZ637cnZ
        cbNZHovyHepsXcP2Lh2Vdcg=
X-Google-Smtp-Source: AK7set+K5X0r3LmBgdo7wHrqi7g4j77i+4gRAsbnAvLIQEJRuj9bOo4d5dJJD1sgCHuS3nTj5m7O/w==
X-Received: by 2002:a05:6a20:a88a:b0:d5:1f75:669a with SMTP id ca10-20020a056a20a88a00b000d51f75669amr798156pzb.13.1678729110953;
        Mon, 13 Mar 2023 10:38:30 -0700 (PDT)
Received: from localhost.localdomain (61-227-97-148.dynamic-ip.hinet.net. [61.227.97.148])
        by smtp.gmail.com with ESMTPSA id 12-20020a63184c000000b004fc2582aedbsm25873pgy.17.2023.03.13.10.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:38:30 -0700 (PDT)
From:   "You-Sheng Yang (vicamo)" <vicamo.yang@canonical.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     "You-Sheng Yang (vicamo)" <vicamo.yang@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: vmd: guard device addition and removal
Date:   Tue, 14 Mar 2023 01:37:33 +0800
Message-Id: <20230313173733.1815277-1-vicamo.yang@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD may fail to create sysfs entries while `pci_rescan_bus()` called in
some other drivers like t7xx wwan driver:

  sysfs: cannot create duplicate filename '/devices/.../resource0'
  Call Trace:
   <TASK>
   sysfs_warn_dup.cold+0x17/0x34
   sysfs_add_bin_file_mode_ns+0xc0/0xf0
   sysfs_create_bin_file+0x6d/0xb0
   pci_create_attr+0x117/0x260
   pci_create_resource_files+0x6b/0x150
   pci_create_sysfs_dev_files+0x18/0x30
   pci_bus_add_device+0x30/0x80
   pci_bus_add_devices+0x31/0x80
   pci_bus_add_devices+0x5b/0x80
   vmd_enable_domain.constprop.0+0x6b7/0x880 [vmd]
   vmd_probe+0x16d/0x193 [vmd]

Fixes: 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management Device (VMD)")
Signed-off-by: You-Sheng Yang (vicamo) <vicamo.yang@canonical.com>
---
 drivers/pci/controller/vmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..f050991bd1e9 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -838,9 +838,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
+	pci_lock_rescan_remove();
+
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
+		pci_unlock_rescan_remove();
+
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
@@ -893,6 +897,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	vmd_acpi_end();
 
+	pci_unlock_rescan_remove();
+
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 	return 0;
-- 
2.39.2

