Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF905115D5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiD0K7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiD0K7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 06:59:19 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775F4184C1;
        Wed, 27 Apr 2022 03:49:43 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 806BFC139B;
        Wed, 27 Apr 2022 09:48:16 +0000 (UTC)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3C889240005;
        Wed, 27 Apr 2022 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651052809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lo0sS2FamHTxkgucmXZLA8+CDYrMlYUMiwprP2QNxYs=;
        b=b8rym0FHvT+aDTJ1IxQd17RW7oC4z2hYhxZW1NOm7sm6arDCaW4fTWK4SDOfrs2NNBIpxa
        Y76MFcE/SmzMVSnPoIjoQEyU5FKqG/8DKxe59ceJdB+pOj7clvrVe3FbHTBuX+ekQRvDAU
        QRrwwFStrynfMiXEMg3msLr2jtgqb5R7nhTznaxmVdqDWwXwvMI5yMDu2wKCUDLcv/Thk+
        VzBLwJdSqeW4NQoAVvlcTyDnihjuVSW+1vHlkaZkycDx5cCGHrE1pY6BhyOPc0gASt2HUG
        8zyOJSc5ovNj8z/hVrTfixCiTXfu6b/LZPp74PaoeFr3eucxF9xZSGfyu6PWqQ==
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
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] of: always populate a root node
Date:   Wed, 27 Apr 2022 11:45:00 +0200
Message-Id: <20220427094502.456111-2-clement.leger@bootlin.com>
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

When enabling CONFIG_OF on a platform where of_root is not populated by
firmware, we end up without a root node. In order to apply overlays and
create subnodes of the root node, we need one. This commit creates an
empty root node if not present.

Co-developed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/base.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index e7d92b67cb8a..6b8584c39f73 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -177,6 +177,19 @@ void __init of_core_init(void)
 		pr_err("failed to register existing nodes\n");
 		return;
 	}
+
+	if (!of_root) {
+		of_root = kzalloc(sizeof(*of_root), GFP_KERNEL);
+		if (!of_root) {
+			mutex_unlock(&of_mutex);
+			pr_err("failed to create root node\n");
+			return;
+		}
+
+		of_root->full_name = "/";
+		of_node_init(of_root);
+	}
+
 	for_each_of_allnodes(np) {
 		__of_attach_node_sysfs(np);
 		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
@@ -185,8 +198,7 @@ void __init of_core_init(void)
 	mutex_unlock(&of_mutex);
 
 	/* Symlink in /proc as required by userspace ABI */
-	if (of_root)
-		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
+	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
 }
 
 static struct property *__of_find_property(const struct device_node *np,
-- 
2.34.1

