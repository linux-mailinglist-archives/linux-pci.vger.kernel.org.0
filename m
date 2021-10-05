Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8223422FAC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhJESLs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJESLs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:11:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5246C6124D;
        Tue,  5 Oct 2021 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457397;
        bh=rRt1NW6lmVR5NA1lyQPy77mKt6mOXDJr2fUlBgo9Vi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1RSbz4wQU4X0PVgQAjDr93t9gfonClOhk28cpOyE4qSyiyAC5q+tFFbPX4G7heMu
         nbdpjE5RThOA8qOZlImVcxxIEznhCf23o5eWAHimaSgMsiN591WEcW9ph2c+3Hw8eD
         MQIkEtKJsZgPEwESXOr0+FvyD8O2dLCTAYMWXfVAp4pKVo+b1kV2UffbtafMVp3Wt8
         lL/QRPsHyf6j4274+6vRQXcS8RxBLUUE0ioNmaSWg4Refo5G89h1hR3lpMlVa66XjH
         Qo9wRFy69JreyiSGd6Ice4O6QOasAUe1QMI/jtxP6sRkumAPCKsJMsiGdVe2QUuxnz
         LukoK8SHQy4qw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 01/13] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Date:   Tue,  5 Oct 2021 20:09:40 +0200
Message-Id: <20211005180952.6812-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Define a macro PCI_EXP_DEVCTL_PAYLOAD_* for every possible Max Payload
Size in linux/pci_regs.h, in the same style as PCI_EXP_DEVCTL_READRQ_*.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Marek Behún <kabel@kernel.org>
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
2.32.0

