Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718556290A1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 04:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiKODN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 22:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiKODNX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 22:13:23 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD9BCB4
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 19:13:21 -0800 (PST)
X-ASG-Debug-ID: 1668481999-1eb14e7e63898a0001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id AEK4qm34JgfWn1ro (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 15 Nov 2022 11:13:19 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 15 Nov
 2022 11:13:19 +0800
Received: from localhost.localdomain (10.32.64.1) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 15 Nov
 2022 11:13:16 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
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
Subject: [PATCH v2 5/5] ACPI/PCI: Config PCIe devices's AER register
Date:   Tue, 15 Nov 2022 11:13:15 +0800
X-ASG-Orig-Subj: [PATCH v2 5/5] ACPI/PCI: Config PCIe devices's AER register
Message-ID: <20221115031315.1667355-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1668481999
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 791
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.3900 1.0000 -0.0264
X-Barracuda-Spam-Score: -0.03
X-Barracuda-Spam-Status: No, SCORE=-0.03 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.102147
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

Call the func pci_acpi_program_hest_aer_params() for every PCIe device.
Extracting register values from HEST PCIe AER structures and programming
them into AER Capabilities are implemented in this function.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b66fa42c4b1f..02bf9180e96d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2263,6 +2263,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_serr(dev);
 
 	pci_acpi_program_hp_params(dev);
+	pci_acpi_program_hest_aer_params(dev);
 }
 
 static void pci_release_capabilities(struct pci_dev *dev)
-- 
2.20.1

