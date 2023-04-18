Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD646E6FB7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 00:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDRW6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 18:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDRW6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 18:58:09 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C12072B4;
        Tue, 18 Apr 2023 15:58:08 -0700 (PDT)
From:   Patrick McLean <chutzpah@gentoo.org>
To:     Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR AST SERVER
        GRAPHICS CHIPS), linux-kernel@vger.kernel.org (open list),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc:     Patrick McLean <chutzpah@gentoo.org>
Subject: [PATCH] PCI: Add ASPEED vendor ID
Date:   Tue, 18 Apr 2023 15:57:57 -0700
Message-Id: <20230418225757.1361301-1-chutzpah@gentoo.org>
X-Mailer: git-send-email 2.40.0
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

Currently the ASPEED PCI vendor ID is defined in
drivers/gpu/drm/ast/ast_drv.c, move that to include/linux/pci_ids.h
with all the rest of the PCI vendor ID definitions. Rename the definition
to follow the format that the other definitions follow.

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
index 45c3d62e616d..40e04e88ca5a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2553,6 +2553,8 @@
 #define PCI_DEVICE_ID_NETRONOME_NFP3800_VF	0x3803
 #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
 
+#define PCI_VENDOR_ID_ASPEED		0x1a03
+
 #define PCI_VENDOR_ID_QMI		0x1a32
 
 #define PCI_VENDOR_ID_AZWAVE		0x1a3b
-- 
2.40.0

