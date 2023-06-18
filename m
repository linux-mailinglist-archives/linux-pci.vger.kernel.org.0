Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039247346F4
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jun 2023 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjFRQZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jun 2023 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFRQZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jun 2023 12:25:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D9E54
        for <linux-pci@vger.kernel.org>; Sun, 18 Jun 2023 09:25:14 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AvD8qePgkuHEfAvD8qbYZF; Sun, 18 Jun 2023 18:25:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687105506;
        bh=vduJtJTiTmHUwJwzG9QCoqetEOnDC2NYSydhpCqW9gc=;
        h=From:To:Cc:Subject:Date;
        b=NPPoVt207fx+2FC33z2MVoeTxXkm9k09DcOPbGD0D3RkNi0f+UxKLDl6X3pYb3hDW
         SZxE7eyw7r2GUPDUo+9AoERBYNQ7WuMoFJ0jCx9mDdhZmdT3N/GNIkfSZwstPePhoz
         g8m3bN07KQGcQlye+6qAHKAUFVd7ako43Ic98m3GPo+vDi/O0YdsmzrYSFU2+Uhxpk
         NECioTiGEm9WvXLNxdKE65oNpUSXJ4osn0O6kLxcrSdhE6xT3gQGUFytANaQQLVaM8
         lbzN0hy//t4GqnI54KtGjhHld/wBy21owR9yEMv8FY4DLlQyMnOKye61FwsMz2A+l0
         dV4rj+Gf0qUpg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Jun 2023 18:25:06 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Reorder some fields in 'struct pci_dev'
Date:   Sun, 18 Jun 2023 18:24:54 +0200
Message-Id: <407b17c3e56764ef2c558898d4ff4c6c04b2d757.1687105455.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Group some bitfield variables to reduce hole.
On x86_64, this shrinks the size of 'struct pci_dev' by 16 bytes when
compiled with 'allmodconfig'. This goes from 3576 to 3560.

The move related to CONFIG_PCIEASPM depends on the config. But it gives
the opportunity to merge to bitfields.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c69a2cc1f412..106754757279 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -366,8 +366,8 @@ struct pci_dev {
 	pci_power_t	current_state;	/* Current operating state. In ACPI,
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
-	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	u8		pm_cap;		/* PM capability offset */
+	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
@@ -392,9 +392,9 @@ struct pci_dev {
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
+	u16		l1ss;		/* L1SS Capability pointer */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
-	u16		l1ss;		/* L1SS Capability pointer */
 #endif
 	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
-- 
2.34.1

