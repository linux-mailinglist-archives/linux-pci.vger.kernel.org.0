Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3876C7BA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjHBIAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjHBIAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 04:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A530E9
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 00:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED556617B4
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 07:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4A6C433C7;
        Wed,  2 Aug 2023 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690963188;
        bh=DPtHQkSgaeEpcijgqXAMXl2TZmqWK1rPP/HuOaZUICc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUnrUE1UgEu0zVV4FDrAwqOmJ2Lu0GKSMF6aMm3ckcs2uQ+mUqSEcv2yAZ7IBKTjn
         K7u7OeymC5bLN/CWJQg2Oy1Ucz8++jeGBar/FevKQL3QoAqgwWB7A5qvnji+lIfLlY
         gNCLxlAtz5QM5XszLziJBIw8wTUnXSJD5d67rAvCKSuhLb6v5VNqtjJbce8ktzpIa1
         +GLReD17fBEA9RGGiT28fiS6OjpjqMlnAwQHOnfZhE+mGHTMQc23imqp43PbxzixTU
         30MOMGBxDfwCz+r2PoVA+D//xf2MgPiTwGxZ+isCEGiymVRPLLEdQ7g1sbnFgmbuGV
         59gBQmGxSpP2A==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/2] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Date:   Wed,  2 Aug 2023 16:59:43 +0900
Message-ID: <20230802075944.937619-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802075944.937619-1-dlemoal@kernel.org>
References: <20230802075944.937619-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more explicit about the type
of IRQ being referenced as well as to match the PCI specifications
terms. Redefine PCI_IRQ_LEGACY as an alias to PCI_IRQ_INTX to avoid the
need for doing the renaming tree-wide. New drivers and new code should
now prefer using PCI_IRQ_INTX instead of PCI_IRQ_LEGACY.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 include/linux/pci.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ff7500772e6..7692d73719e0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1048,11 +1048,13 @@ enum {
 	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
 };
 
-#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
+#define PCI_IRQ_INTX		(1 << 0) /* Allow INTx interrupts */
 #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
 #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
 #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
 
+#define PCI_IRQ_LEGACY		PCI_IRQ_INTX	/* prefer PCI_IRQ_INTX */
+
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-- 
2.41.0

