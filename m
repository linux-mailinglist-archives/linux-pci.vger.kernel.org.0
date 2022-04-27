Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2907C51162A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiD0LD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiD0LCl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 07:02:41 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9C29A0FB;
        Wed, 27 Apr 2022 03:41:17 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id AF743C136F;
        Wed, 27 Apr 2022 09:48:54 +0000 (UTC)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A378924000F;
        Wed, 27 Apr 2022 09:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651052813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltHOMKbgCOhHd9y0Bf1O4j4UMymB2yRYerupfKTXBio=;
        b=VhqLHmU/Cly7FViEHinBRlikaQPRsXHVfF7C4wV8yiUUBoY79Gqu/QU7fyHIFD2vYL5Of/
        TduJDdeMjD+JjoPlFc2SbDaCdyEi72c1xX4vXEnCO2OfylgrjmoWEG5utpzfg47QAEUFAl
        ZK41p1c3mU2x4OS4d9NR4HJdbCURuCr9dfSmI5o+b+9dssbSfoTL3hGo6bsH0pTkLlSGhd
        VCs1lVIFrbBt+qmwp04R2vIF1CZu2BNMyLf62gY5sa2FfOw/ubUjR4hMukvi7EpLUlpW/9
        sSquoOQ4Q1dzVFRAk/aH4uHBOQjSDKyI8SOiW6O4XUSdHPhM9VTV/6dPIQAzvA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] of: overlay: add of_overlay_fdt_apply_to_node()
Date:   Wed, 27 Apr 2022 11:45:02 +0200
Message-Id: <20220427094502.456111-4-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220427094502.456111-1-clement.leger@bootlin.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using a driver which load an overlay and applies it on the of_node
of device it represent, the target node isn't known in advance. This is
for example the case when applying an overlay from a PCI driver. PCI
cards might be plugged on whatever slot the user want and thus, the
target node of the overlay framgents are unknown. This function allows
to specify the node on which the overlay fragments will be applied.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/overlay.c | 21 +++++++++++++--------
 include/linux/of.h   | 17 +++++++++++++----
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index d80160cf34bb..4dabe1b65343 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -730,7 +730,8 @@ static struct device_node *find_target(struct device_node *info_node)
  * detected in @tree, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
-		const void *fdt, struct device_node *tree)
+		const void *fdt, struct device_node *tree,
+		struct device_node *target)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
@@ -792,7 +793,10 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 
 		fragment = &fragments[cnt];
 		fragment->overlay = overlay_node;
-		fragment->target = find_target(node);
+		if (target)
+			fragment->target = target;
+		else
+			fragment->target = find_target(node);
 		if (!fragment->target) {
 			of_node_put(fragment->overlay);
 			ret = -EINVAL;
@@ -877,6 +881,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * @fdt:	base of memory allocated to hold the aligned FDT
  * @tree:	Expanded overlay device tree
  * @ovcs_id:	Pointer to overlay changeset id
+ * @target:	Target node to override target-path property value
  *
  * Creates and applies an overlay changeset.
  *
@@ -914,7 +919,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  */
 
 static int of_overlay_apply(const void *fdt, struct device_node *tree,
-		int *ovcs_id)
+		int *ovcs_id, struct device_node *target)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
@@ -947,7 +952,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	if (ret)
 		goto err_free_tree;
 
-	ret = init_overlay_changeset(ovcs, fdt, tree);
+	ret = init_overlay_changeset(ovcs, fdt, tree, target);
 	if (ret)
 		goto err_free_tree;
 
@@ -1014,8 +1019,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	return ret;
 }
 
-int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id)
+int of_overlay_fdt_apply_to_node(const void *overlay_fdt, u32 overlay_fdt_size,
+				 int *ovcs_id, struct device_node *target)
 {
 	void *new_fdt;
 	void *new_fdt_align;
@@ -1053,7 +1058,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 		goto out_free_new_fdt;
 	}
 
-	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
+	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id, target);
 	if (ret < 0) {
 		/*
 		 * new_fdt and overlay_root now belong to the overlay
@@ -1072,7 +1077,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 out:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
+EXPORT_SYMBOL_GPL(of_overlay_fdt_apply_to_node);
 
 /*
  * Find @np in @tree.
diff --git a/include/linux/of.h b/include/linux/of.h
index 2dc77430a91a..4df653606936 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1566,8 +1566,8 @@ struct of_overlay_notify_data {
 
 #ifdef CONFIG_OF_OVERLAY
 
-int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id);
+int of_overlay_fdt_apply_to_node(const void *overlay_fdt, u32 overlay_fdt_size,
+				 int *ovcs_id, struct device_node *target);
 int of_overlay_remove(int *ovcs_id);
 int of_overlay_remove_all(void);
 
@@ -1576,8 +1576,10 @@ int of_overlay_notifier_unregister(struct notifier_block *nb);
 
 #else
 
-static inline int of_overlay_fdt_apply(void *overlay_fdt, u32 overlay_fdt_size,
-				       int *ovcs_id)
+static inline int of_overlay_fdt_apply_to_node(const void *overlay_fdt,
+					       u32 overlay_fdt_size,
+					       int *ovcs_id,
+					       struct device_node *target)
 {
 	return -ENOTSUPP;
 }
@@ -1604,4 +1606,11 @@ static inline int of_overlay_notifier_unregister(struct notifier_block *nb)
 
 #endif
 
+static inline int of_overlay_fdt_apply(const void *overlay_fdt,
+				       u32 overlay_fdt_size, int *ovcs_id)
+{
+	return of_overlay_fdt_apply_to_node(overlay_fdt, overlay_fdt_size,
+					    ovcs_id, NULL);
+}
+
 #endif /* _LINUX_OF_H */
-- 
2.34.1

