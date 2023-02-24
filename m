Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88126A232F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 21:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBXUjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 15:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBXUjq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 15:39:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C0688CA
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677271185; x=1708807185;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v1qUnELKQ00qA8hySGsRlbyDjsCVkcExj6WJlj6CSi0=;
  b=Ej3UUYtkL6CxWI10r7zd5C1i/Yp+jfDZrWSJP04gw1dkldxaWmFNcjgV
   7op+QsIC7PCVf3FFoTIHRQsPZSRmDUM2rPBaHMwqDJnu5+U2g41my6MnY
   1PMZmoNWPA2ArYH9f4U6oP07l1VAUZ5l1YZ+FvYyurSFhn0Yx+sTvN4ej
   WHwb3rARYqghMHEmTeRob2w2fkniHIdtyvc59ohO4Qy349kfrq9PcTNVy
   Jd4mFSyejwtImmeXa4IYQAe8/JTKUG3biDYBpd24NgqGPIlFCayQS/PNM
   3y+iOQq2GEGJ8zwXdvtM1HmNrWOaE8vgHBoC52SNI9zQeErHCbRHe++P6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="333582367"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="333582367"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 12:39:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="741770150"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="741770150"
Received: from unknown (HELO ocsbesrhlrepo01.amr.corp.intel.com) ([10.2.230.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 12:39:44 -0800
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH] PCI: vmd: Reset VMD config register between soft reboots
Date:   Fri, 24 Feb 2023 13:28:11 -0700
Message-Id: <20230224202811.644370-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD driver can disable or enable MSI remapping by changing
VMCONFIG_MSI_REMAP register. This register needs to be set to the
default value during soft reboots. Drives failed to enumerate
when Windows boots after performing a soft reboot from Linux.
Windows doesn't support MSI remapping disable feature and stale
register value hinders Windows VMD driver initialization process.
Adding vmd_shutdown function to make sure to set the VMCONFIG
register to the default value.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Fixes: ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
---
 drivers/pci/controller/vmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..50a187a29a1d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -979,6 +979,13 @@ static void vmd_remove(struct pci_dev *dev)
 	ida_simple_remove(&vmd_instance_ida, vmd->instance);
 }
 
+static void vmd_shutdown(struct pci_dev *dev)
+{
+        struct vmd_dev *vmd = pci_get_drvdata(dev);
+
+        vmd_remove_irq_domain(vmd);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int vmd_suspend(struct device *dev)
 {
@@ -1056,6 +1063,7 @@ static struct pci_driver vmd_drv = {
 	.id_table	= vmd_ids,
 	.probe		= vmd_probe,
 	.remove		= vmd_remove,
+	.shutdown	= vmd_shutdown,
 	.driver		= {
 		.pm	= &vmd_dev_pm_ops,
 	},
-- 
2.27.0

