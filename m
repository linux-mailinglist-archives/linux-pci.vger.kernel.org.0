Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB086989BF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 02:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBPBMa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 20:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBPBM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 20:12:29 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4E2D14D;
        Wed, 15 Feb 2023 17:12:29 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676509947;
        bh=kc10ysum1fgE8G0TGJD9iTwul53Fadc9NPF5PzVzIRg=;
        h=From:Date:Subject:To:Cc:From;
        b=MJgsD76EQTYHTItU7zHR1kL/6enTjHlZGnXC59lcJwKs5Y6lK9aAZsAmmInnHm3Mu
         xAvtegaZtP6snFbMBDX7knQ5jIyMqRUahZ8k9NpJ+JOBWrbsBNppib3j9dS/HgJ2qz
         Xh+6wo1SKdpPCm6NoNsSpCEafDmAl/YRQPjGqC+w=
Date:   Thu, 16 Feb 2023 01:12:25 +0000
Subject: [PATCH] PCI/sysfs: Make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230216-kobj_type-pci-v1-1-46a63c8612b5@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPiC7WMC/x2N0QqDMAwAf0XyvEDbMR/2K2OMJsYZlVpaNybiv
 y/4eAfH7VClqFS4NzsU+WrVJRn4SwM8xPQW1M4YggtXF3yL00Lja92yYGbFW+uDY8+OmMAailW
 QSkw8WJU+82wyF+n1d04ez+P4A/z6ttt0AAAA
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676509945; l=1024;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kc10ysum1fgE8G0TGJD9iTwul53Fadc9NPF5PzVzIRg=;
 b=nBHSR5OXBM+Ng6q1iZbSBbnSSPh+rCujb5zkRIerfTPKT+OzqAlXXmmtbDGf0SARS07Eo2HLr
 nfuywLpMy4ADY0GoGdYoDcnpN9crUYoYBY4/lstsHHTXniWZooFG5dH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index a0c67191a8b9..0f87cade10f7 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -98,7 +98,7 @@ static struct attribute *pci_slot_default_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pci_slot_default);
 
-static struct kobj_type pci_slot_ktype = {
+static const struct kobj_type pci_slot_ktype = {
 	.sysfs_ops = &pci_slot_sysfs_ops,
 	.release = &pci_slot_release,
 	.default_groups = pci_slot_default_groups,

---
base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
change-id: 20230216-kobj_type-pci-56120c1c0bcb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

