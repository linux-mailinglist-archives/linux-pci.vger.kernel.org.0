Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09508243B3B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 16:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMOI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 10:08:58 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46334 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgHMOI4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 10:08:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6EBE640790;
        Thu, 13 Aug 2020 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597327736; bh=PBFHVYTZnuXshU388gRtv06RDv5hgd7kuG7xqKakvoE=;
        h=From:To:Cc:Subject:Date:From;
        b=Th385v3jHPRoF0F+Pur9+q4Ea/rt2T3H65Jzt5xo0OYZC46D1xwTRqNXJqxLgWbcz
         fi0n5SPNEbv556lrIBTsCngZaWERzMXuHkOmAans5xyV5IdATfaTDiGQF0EtCa7ctK
         QJyzSBj9bxiKwZcchav4qa6j0PiHUI6lfVTWCL/YJ4zX5XNJIonSxcsRPaopBJRCPI
         LO2C2IPmq8h9bnR/LTAI72NaEjPJBuBZLQi+XhqNAgjaJlenWGo5F9v0olPGZNXeha
         fcEiMgmLeGYxKeIxVAulxjaoCVwRups45vlA4OVFkaMBQLRVQ9OulQnhxjKZ5HL7KM
         xpofeVl0BSyXQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B773EA005A;
        Thu, 13 Aug 2020 14:08:54 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] PCI: Add #defines for max payload size options
Date:   Thu, 13 Aug 2020 16:08:50 +0200
Message-Id: <3c9aea7c585171eefe40e0bec6e2b996ec894d84.1597327415.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add #defines for the max payload size options. No functional change
intended.

Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 include/uapi/linux/pci_regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f970141..db625bd 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -503,6 +503,12 @@
 #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
 #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
 #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
+#define  PCI_EXP_DEVCTL_PAYLOAD_128B  0x0000 /* 128 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_256B  0x0020 /* 256 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_512B  0x0040 /* 512 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
 #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
 #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
-- 
2.7.4

