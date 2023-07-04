Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83850747067
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGDMF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGDMFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:05:24 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636F10D9
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 05:05:23 -0700 (PDT)
X-ASG-Debug-ID: 1688472320-1eb14e179f10210001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id KPRdqURlNPZNorAm (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 04 Jul 2023 20:05:20 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:05:19 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:05:18 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <leoliu-oc@zhaoxin.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>
Subject: [PATCH v3 2/5] ACPI/APEI: Remove static from apei_hest_parse()
Date:   Tue, 4 Jul 2023 20:05:17 +0800
X-ASG-Orig-Subj: [PATCH v3 2/5] ACPI/APEI: Remove static from apei_hest_parse()
Message-ID: <20230704120517.1322195-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1688472320
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1646
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

Each dev with AER capability needs to call the apei_hest_parse function to
match and extract register values from HEST PCIe AER structures.
Therefore, remove static from apei_hest_parse() so that it can be called
in another file.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 2 +-
 include/acpi/apei.h      | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index fb839a5c480ee..fd40c035c9b2e 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -132,7 +132,7 @@ static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
 	return false;
 }
 
-static int apei_hest_parse(apei_hest_func_t func, void *data)
+int apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 8a0b2b9edbafe..f975e4fe78fcb 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -37,9 +37,14 @@ typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
 
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int apei_hest_parse(apei_hest_func_t func, void *data);
 int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
 #else
 static inline void acpi_hest_init(void) { }
+static inline int apei_hest_parse(apei_hest_func_t func, void *data)
+{
+	return -EINVAL;
+}
 static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
 {
 	return -EINVAL;
-- 
2.34.1

