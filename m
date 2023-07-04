Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE9747072
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGDMGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGDMGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:06:43 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5111727
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 05:06:24 -0700 (PDT)
X-ASG-Debug-ID: 1688472381-086e23149914920001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id 55EaRqoPMr21gjIz (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 04 Jul 2023 20:06:21 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:06:20 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:06:19 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <leoliu-oc@zhaoxin.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>
Subject: [PATCH v3 5/5] PCI: Config PCIe devices's AER register
Date:   Tue, 4 Jul 2023 20:06:18 +0800
X-ASG-Orig-Subj: [PATCH v3 5/5] PCI: Config PCIe devices's AER register
Message-ID: <20230704120618.1322425-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1688472381
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 793
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

Call the func pci_acpi_program_hest_aer_params() for every PCIe device.
Extracting register values from HEST PCIe AER structures and programming
them into AER Capabilities are implemented in this function.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8bac3ce02609c..8946d35fcc416 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2274,6 +2274,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_serr(dev);
 
 	pci_acpi_program_hp_params(dev);
+	pci_acpi_program_hest_aer_params(dev);
 }
 
 static void pci_release_capabilities(struct pci_dev *dev)
-- 
2.34.1

