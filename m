Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF34335C6A1
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbhDLMq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 08:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241374AbhDLMqu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 08:46:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE58161246;
        Mon, 12 Apr 2021 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618231593;
        bh=FAJNnlUYEhHXgw/A1PLCHY++bTMhHaSsvsaga1wXF+c=;
        h=From:To:Cc:Subject:Date:From;
        b=ga10UkXRIRS5/5IQXR9qdOOPZX4QcC/lWGJjEbXlwRIlvN28uD2U+SE6mMTQIYJXF
         GpCIDValtsCAj4MtdHisfIEjEbbFI++k488myHaLF5jBGavoINAdIMZXuWb7hfKDOx
         hRujtH73+HKm5oEbJUZnsRJPYwJCXf8VVl6UonJvPdadApNoa0NxHvARWeZkhMiktk
         o594bqJd70b9lx4z6a2VWn0iL4lR0n9tKlIRd2lGT0RF5mzLzGkyrhbsSnXoZkzMhJ
         o3zACCQQ4Gnn0l8KwO9LlKHCvPXZgkmUzkD4poOlHW0anns6pFOypA+O2lgntP5yfz
         /7oLbXd6B1LsQ==
Received: by pali.im (Postfix)
        id CE3D6687; Mon, 12 Apr 2021 14:46:30 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Date:   Mon, 12 Apr 2021 14:46:02 +0200
Message-Id: <20210412124602.25762-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define new PCI_EXP_DEVCTL_PAYLOAD_* macros in linux/pci_regs.h header file
for Max Payload Size. Macros are defined in the same style as existing
macros PCI_EXP_DEVCTL_READRQ_* macros.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 include/uapi/linux/pci_regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8235e7..8f1b15eea53e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -504,6 +504,12 @@
 #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
 #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
 #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
+#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00A0 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
 #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
 #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
-- 
2.20.1

