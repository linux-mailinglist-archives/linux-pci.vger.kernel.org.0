Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3486E5648
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 03:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDRBRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 21:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDRBR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 21:17:28 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FF44B7;
        Mon, 17 Apr 2023 18:17:26 -0700 (PDT)
From:   Patrick McLean <chutzpah@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Patrick McLean <chutzpah@gentoo.org>
Subject: [PATCH 1/2] gpu: Move ASPEED vendor ID definition to pci_ids.h
Date:   Mon, 17 Apr 2023 18:17:19 -0700
Message-Id: <20230418011720.3900090-2-chutzpah@gentoo.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418011720.3900090-1-chutzpah@gentoo.org>
References: <20230418011720.3900090-1-chutzpah@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the ASPEED PCI vendor ID is defined in drivers/gpu/drm/ast/ast_drv.c,
move that to include/linux/pci_ids.h with all the rest of the PCI vendor ID
definitions. Rename the definition to follow the format that the other
definitions follow.

Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
---
 drivers/gpu/drm/ast/ast_drv.c | 4 +---
 include/linux/pci_ids.h       | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index d78852c7cf5b..232e797793b6 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -70,12 +70,10 @@ static const struct drm_driver ast_driver = {
  * PCI driver
  */
 
-#define PCI_VENDOR_ASPEED 0x1a03
-
 #define AST_VGA_DEVICE(id, info) {		\
 	.class = PCI_BASE_CLASS_DISPLAY << 16,	\
 	.class_mask = 0xff0000,			\
-	.vendor = PCI_VENDOR_ASPEED,			\
+	.vendor = PCI_VENDOR_ID_ASPEED,			\
 	.device = id,				\
 	.subvendor = PCI_ANY_ID,		\
 	.subdevice = PCI_ANY_ID,		\
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62e616d..6634741aea80 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -815,6 +815,8 @@
 #define PCI_VENDOR_ID_ASUSTEK		0x1043
 #define PCI_DEVICE_ID_ASUSTEK_0675	0x0675
 
+#define PCI_VENDOR_ID_ASPEED		0x1a03
+
 #define PCI_VENDOR_ID_DPT		0x1044
 #define PCI_DEVICE_ID_DPT		0xa400
 
-- 
2.40.0

