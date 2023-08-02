Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD476C99D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjHBJku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjHBJkl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 05:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0169FE4D
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 02:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9407F618CF
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 09:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FE7C433CB;
        Wed,  2 Aug 2023 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690969240;
        bh=q8gMZfhxJ905SlKm2kBP3DywiUEuAK2io3SKc0PIe4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVbKytiraD/WcpDFJQnn2ZdGCUD4u8FByBYPKe0/7qkmq6UQAV1fHuPD8oGVpM0eP
         2CZWrsoWThi8qerE3zb7ypIHeJSYewPhJgrY5b6y6rQpr+KdyM3FnTHMa6CJ5v87Ff
         u7PcBmHv+3B9GpHIokL2GYyrMR2o1bSHgACm06lq1JT9R0Bt4Jqa+YztLF+jnsZ22M
         2gmsEGHw0uR1Q7vlVPlLE7Lq5aLldzTH27guqlT0Jm3vz22JYrAfmnJbB+Bs53SM92
         R1zwWe6kmLh0ciNlJSyDPGfK69Jrqc3VKJ4fgvOLXd74FGG3iDHjB3YELOKAWDCuQ6
         upzhdxcLPQqQA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 1/2] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Date:   Wed,  2 Aug 2023 18:40:35 +0900
Message-ID: <20230802094036.1052472-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802094036.1052472-1-dlemoal@kernel.org>
References: <20230802094036.1052472-1-dlemoal@kernel.org>
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 include/linux/pci.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ff7500772e6..9e97f0027227 100644
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
 
+#define PCI_IRQ_LEGACY		PCI_IRQ_INTX /* Deprecated! Use PCI_IRQ_INTX */
+
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-- 
2.41.0

