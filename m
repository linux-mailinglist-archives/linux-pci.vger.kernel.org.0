Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC743B392B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhFXW3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 18:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232845AbhFXW33 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 18:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E16606137D;
        Thu, 24 Jun 2021 22:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624573630;
        bh=bSHnjsAOWAaXk6MagAsbXeDOrNG/Ncxs7ohUVA+0BuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRWhlRafjZbl+wBmI/y7AraGDR5rU9KdfJQc0ku6xPvkckDKJaijFM1CSZ4TWQ67V
         zK796sQS6yGypRB1t39rp+IpMkVj45LRUykEo//kvDaqx4+1RH/Q3LKPQketQ5Cmx8
         XGHmSi/K2oKN4c/vtWjglLIQKKMskPYntKoKzieo+32Pz2u9b7WtXEFiC6FZmndBac
         nQP3C/tr5J79qEi6ipmCR1hjUr+rFOM21VyBVQo9XWfj1FvCL433RD6WoNGJVjjEB+
         LDO9EO1ObUoMxC9T4mk/mWE8Luizo/NQugBARVa2NXgIikTcJlEm8g8cRTnDvKIBY3
         DgECG4jXtwYXw==
Received: by pali.im (Postfix)
        id 1717FBFC; Fri, 25 Jun 2021 00:27:08 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Remi Pommarel" <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 2/5] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Date:   Fri, 25 Jun 2021 00:26:18 +0200
Message-Id: <20210624222621.4776-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624222621.4776-1-pali@kernel.org>
References: <20210624222621.4776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define a macro PCI_EXP_DEVCTL_PAYLOAD_* for every possible Max Payload
Size in linux/pci_regs.h, in the same style as PCI_EXP_DEVCTL_READRQ_*.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 include/uapi/linux/pci_regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8235e7..ff6ccbc6efe9 100644
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
+#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
 #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
 #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
-- 
2.20.1

