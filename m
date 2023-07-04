Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C27274706B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGDMFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGDMFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:05:50 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD00172B
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 05:05:36 -0700 (PDT)
X-ASG-Debug-ID: 1688472332-1eb14e179e10230001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id kCJ0Eque3WP18wCw (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 04 Jul 2023 20:05:32 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:05:32 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:05:31 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <leoliu-oc@zhaoxin.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>
Subject: [PATCH v3 3/5] PCI: Add PCIe to PCI/PCI-X Bridge AER fields
Date:   Tue, 4 Jul 2023 20:05:30 +0800
X-ASG-Orig-Subj: [PATCH v3 3/5] PCI: Add PCIe to PCI/PCI-X Bridge AER fields
Message-ID: <20230704120530.1322257-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1688472332
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1188
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.110906
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

Define Secondary Uncorrectable Error Mask Register, Secondary
Uncorrectable Error Severity Register and Secondary Error Capabilities and
Control Register bits in AER capability for PCIe to PCI/PCI-X Bridge.
Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
5.2.3.3 and 5.2.3.4.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 include/uapi/linux/pci_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d964939..28e20c4d0afc3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -800,6 +800,9 @@
 #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
 #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
+#define PCI_ERR_UNCOR_MASK2		0x30	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_UNCOR_SEVER2	0x34	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_CAP2			0x38	/* PCIe to PCI/PCI-X Bridge */
 
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
-- 
2.34.1

