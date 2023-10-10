Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A927C41D5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjJJUpL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjJJUpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:45:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5999;
        Tue, 10 Oct 2023 13:45:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1621C433C8;
        Tue, 10 Oct 2023 20:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970700;
        bh=SgJRtupS7nAWYb0BB4CUnQ7/s6tkDFcfcPN1MGYpdEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMAdtbkfo0lFfisjm0xLwJhX+R52fe8k7WECE9pmsA7xM3yYuTx6kE4Ox1n5qq2fF
         0MoMu8wmTgTbx6b+gOg4DLQdAKadVkhaRvJ7T9H8XlMPcy3COgUh8X+4QQPKQoGZ5d
         cSwmx/IrvM3TfUMYX6ydn4VK53tuLGYsk70KpB42F9dXJJKmGL2G9EpUpHdz5ne2Rq
         88MX9zIiAndMbxwm9RtoKbQlDKXxJtGR6HQ9Gq95ShgoxWL44sTHPK1kgUJD2ZW7Cq
         m+D/wkYmUbb2f972cZEIGm2JfWT5H9O/SCaGmrW0e6SiSVR3wO4HovWmFolu1bquNU
         3oFM+qUicDxqA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 07/10] PCI/PME: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:33 -0500
Message-Id: <20231010204436.1000644-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pme.c        | 4 +++-
 include/uapi/linux/pci_regs.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index ef8ce436ead9..a2daebd9806c 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -9,6 +9,7 @@
 
 #define dev_fmt(fmt) "PME: " fmt
 
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -235,7 +236,8 @@ static void pcie_pme_work_fn(struct work_struct *work)
 			pcie_clear_root_pme_status(port);
 
 			spin_unlock_irq(&data->lock);
-			pcie_pme_handle_request(port, rtsta & 0xffff);
+			pcie_pme_handle_request(port,
+				    FIELD_GET(PCI_EXP_RTSTA_PME_RQ_ID, rtsta));
 			spin_lock_irq(&data->lock);
 
 			continue;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e97a06b50f95..9fb8a69241f4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -637,6 +637,7 @@
 #define PCI_EXP_RTCAP		0x1e	/* Root Capabilities */
 #define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
 #define PCI_EXP_RTSTA		0x20	/* Root Status */
+#define  PCI_EXP_RTSTA_PME_RQ_ID 0x0000ffff /* PME Requester ID */
 #define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
 #define  PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
 /*
-- 
2.34.1

