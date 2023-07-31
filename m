Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0BD768995
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 03:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGaBZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 21:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGaBZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 21:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954510C0
        for <linux-pci@vger.kernel.org>; Sun, 30 Jul 2023 18:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6FC60E0A
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 01:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A1EC433CB;
        Mon, 31 Jul 2023 01:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690766753;
        bh=upo1CuPZJsxX7y49VoZJhnb6J8TYHOt5sFgin6rrSJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMKWrKiumaotCLSsVDRm//1lrJJNMd/6GqwLn5H1W04MYEWhNokjOJtX+2LVeILjJ
         bCl+/T9KFolxx4XC6IDVzpg8Gm2PlWNLGA8lZ37Kx7ZrwnjGMwLskMTUD8sJNnIVHD
         8YCSfIzok/Ons0gLWU8fAYdrFj5gxYA/OshZkZVUwYpqyLf7+q7IRkGEr+4K2SRGPa
         NZUDWb/2fDynwuLh/WsXjds/2Cx5vjpCDApv6+rpw7SeuciQNWPnEuh8FepsICOmfV
         tCjk1yyEpuQTru0Eb1cpmYi5qd1o00HFZ+CkXn2hS/pSApS2Qdhxf0NHnrR5YiucxY
         GdPGVWN/gQDCQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Date:   Mon, 31 Jul 2023 10:25:49 +0900
Message-ID: <20230731012550.728070-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731012550.728070-1-dlemoal@kernel.org>
References: <20230731012550.728070-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>

Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more explicit about the type
of IRQ being referenced as well as to match the PCI specifications
terms. The macro PCI_IRQ_LEGACY is redefined as an alias to PCI_IRQ_INTX
to avoid the need for doing the renaming tree-wide. New drivers and new
code should now prefer using PCI_IRQ_INTX instead of PCI_IRQ_LEGACY.

Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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

