Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32696461809
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhK2O1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 09:27:32 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:36693 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377914AbhK2OZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 09:25:32 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J2nYD5bwnz9sSh;
        Mon, 29 Nov 2021 15:19:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LwES2UsVuC5K; Mon, 29 Nov 2021 15:19:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J2nY40V0Hz9sSk;
        Mon, 29 Nov 2021 15:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F268A8B7AA;
        Mon, 29 Nov 2021 15:19:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ei4h0soNuQth; Mon, 29 Nov 2021 15:19:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A85B88B7B3;
        Mon, 29 Nov 2021 15:19:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1ATEJTOa959584
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 15:19:29 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1ATEJTOR959583;
        Mon, 29 Nov 2021 15:19:29 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Toan Le <toan@os.amperecomputing.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 09/10] sizes.h: Add SZ_1T macro
Date:   Mon, 29 Nov 2021 15:19:23 +0100
Message-Id: <1b6216bb8452ea53636767a198691590ed58560a.1638195388.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638195388.git.christophe.leroy@csgroup.eu>
References: <cover.1638195388.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638195562; l=1333; s=20211009; h=from:subject:message-id; bh=gHcpRE3PXyrvhupmS2R1SHs0FcIlaQvnE07fWVmC6zo=; b=N39fJanSMWTr99TJn+jPqf/PObIwPcsu+EiN1AGB+aqgWYAIbNkFN9ND9Jh3wVXWqjtx1cKcfVxl UUGEu9iJCOVMePGjJGanJ+Wwdh+O+OYhhtDFW2ee9ZJlM3KZ06Pv
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Today drivers/pci/controller/pci-xgene.c defines SZ_1T

Move it into linux/sizes.h so that it can be re-used elsewhere.

Cc: Toan Le <toan@os.amperecomputing.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: new
---
 drivers/pci/controller/pci-xgene.c | 1 -
 include/linux/sizes.h              | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 56d0d50338c8..716dcab5ca47 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -49,7 +49,6 @@
 #define EN_REG				0x00000001
 #define OB_LO_IO			0x00000002
 #define XGENE_PCIE_DEVICEID		0xE004
-#define SZ_1T				(SZ_1G*1024ULL)
 #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
 
 #define XGENE_V1_PCI_EXP_CAP		0x40
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index 1ac79bcee2bb..84aa448d8bb3 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -47,6 +47,8 @@
 #define SZ_8G				_AC(0x200000000, ULL)
 #define SZ_16G				_AC(0x400000000, ULL)
 #define SZ_32G				_AC(0x800000000, ULL)
+
+#define SZ_1T				_AC(0x10000000000, ULL)
 #define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.33.1

