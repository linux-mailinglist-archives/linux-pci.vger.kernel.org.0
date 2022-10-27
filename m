Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202960EEE6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 06:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiJ0EGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 00:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ0EFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 00:05:55 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2816A7FFB5
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 21:05:52 -0700 (PDT)
X-ASG-Debug-ID: 1666840557-1eb14e7e6453460001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id aOnCnFBwzooTMRpX (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Oct 2022 11:15:57 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Thu, 27 Oct
 2022 11:15:57 +0800
Received: from localhost.localdomain (10.32.64.1) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Thu, 27 Oct
 2022 11:15:55 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>, leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH 3/5] ACPI/PCI: Add AER bits #defines for PCIE/PCI-X bridges
Date:   Thu, 27 Oct 2022 11:15:54 +0800
X-ASG-Orig-Subj: [PATCH 3/5] ACPI/PCI: Add AER bits #defines for PCIE/PCI-X bridges
Message-ID: <20221027031554.2856036-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1666840557
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1074
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.3226 1.0000 -0.2556
X-Barracuda-Spam-Score: -0.26
X-Barracuda-Spam-Status: No, SCORE=-0.26 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101705
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

Define PCI Express Advanced Error Reporting Extended Capabilities bits.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 include/uapi/linux/pci_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 57b8e2ffb1dd..3662106fd8dc 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -799,6 +799,11 @@
 #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
 
+/* PCI Express Advanced Error Reporting Extended Capabilities for Bridges */
+#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
+#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
+#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */
+
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
 #define  PCI_VC_CAP1_EVCC	0x00000007	/* extended VC count */
-- 
2.20.1

