Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D4278979F
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 17:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjHZPHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Aug 2023 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHZPGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 11:06:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28EE7F
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 08:06:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf078d5f33so15263745ad.3
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693062394; x=1693667194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZDr/QoX1SGI6WCegd87zMXpRP3udrKlKAnd69niEvM=;
        b=ZWCwvK9RPU4SWKMiLQR1mm6HX/q+eWJmewxcNZuVA9OSS1DRFoZVX+EUBCAZfAm1Hw
         aJDYuRHlMCxU9kbTlcOiO7srSkYpbR1K67u7vMlqL/W3pLHfuAcVcAsLsu4x3y2Q7MIS
         +4KTqRHB9Gc4U1sb4kw5RpQgiERp/TQhBJjN6iPlb0hu519rAATR8/cy3r7mxZCDWcGX
         YkCZ6SaaJItlk8Krh86UdwM+Bc8pnEpe9dYVvpz8P/9LaXVGQciMXD8eIpy18jS5w0Nf
         aib4uqJFTzACj+NXUsV4PIEJ1NcuVGSLlOOO8XjsVVpMO2NvOEYojemvAx4NNLRzlDzh
         4jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693062394; x=1693667194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZDr/QoX1SGI6WCegd87zMXpRP3udrKlKAnd69niEvM=;
        b=CUlAqMyhUQrGdhemndJIHTOltjrdd8Gj1JbuhcY0Qsrq1eTSVuGlvN/zXo8USMq+tc
         fVE5xz8xWwl0tcVTsNWFH/23TUBqMc8Dfk2dd4Sd69Z22utg8N+JYq0VZSpUVO7+wLAn
         APPTKppA7OCdcCLGFgNsRzwrZGLPm0wtuX0apVE/JTzjx7HXgdD3x8xT1HQMBayRwpkM
         IXl1MAqeTIl19apW4Zbg0V3Bnb1MLDp3Tq7td9Ug0oLJUuVY0XGWCjnBBhvpSfXTsgWc
         EyjU69UXXs5gFDN/HycTemZGl2ESGTT7gRDAWcheuiN9JDQeZSkLMaMZnR82h3T2aeLc
         I5CA==
X-Gm-Message-State: AOJu0YyK1VXfbEqy1DPp+EGmQgmKIvCqFmy1DZLtqWWJlTTOJuUubRzl
        2cdBvVlNAzsjooWuiY3qIdey
X-Google-Smtp-Source: AGHT+IE4u92j97rFy4KPYSk0a6QYrzQJQye05JIdyOapYHU5tlwJrXqptPMTXQ5r3XHF+Mg6wMH/Dg==
X-Received: by 2002:a17:902:e54f:b0:1bc:61d6:5fcc with SMTP id n15-20020a170902e54f00b001bc61d65fccmr27215634plf.51.1693062394654;
        Sat, 26 Aug 2023 08:06:34 -0700 (PDT)
Received: from localhost.localdomain ([117.206.116.138])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001b8052d58a0sm3801231pld.305.2023.08.26.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 08:06:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: epf-mhi: Really use "align" from EPF core
Date:   Sat, 26 Aug 2023 20:36:26 +0530
Message-Id: <20230826150626.23309-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit <15fe2e279c19> was supposed to make use of "align" parameter from
the EPF core, but it incorrectly used the outbound window "page_size".
Fix it!

Fixes: 15fe2e279c19 ("PCI: epf-mhi: Make use of the alignment restriction from EPF core")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index bb7de6884824..bb4669eafcca 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -92,6 +92,7 @@ static const struct pci_epf_mhi_ep_info sdx55_info = {
 };
 
 struct pci_epf_mhi {
+	const struct pci_epc_features *epc_features;
 	const struct pci_epf_mhi_ep_info *info;
 	struct mhi_ep_cntrl mhi_cntrl;
 	struct pci_epf *epf;
@@ -102,9 +103,9 @@ struct pci_epf_mhi {
 	int irq;
 };
 
-static size_t get_align_offset(struct pci_epc *epc, u64 addr)
+static size_t get_align_offset(struct pci_epf_mhi *epf_mhi, u64 addr)
 {
-	return addr % epc->mem->window.page_size;
+	return addr % epf_mhi->epc_features->align;
 }
 
 static int __pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
@@ -138,8 +139,7 @@ static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
 				 size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	struct pci_epc *epc = epf_mhi->epf->epc;
-	size_t offset = get_align_offset(epc, pci_addr);
+	size_t offset = get_align_offset(epf_mhi, pci_addr);
 
 	return __pci_epf_mhi_alloc_map(mhi_cntrl, pci_addr, paddr, vaddr,
 				      offset, size);
@@ -164,9 +164,7 @@ static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
 				   size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	struct pci_epf *epf = epf_mhi->epf;
-	struct pci_epc *epc = epf->epc;
-	size_t offset = get_align_offset(epc, pci_addr);
+	size_t offset = get_align_offset(epf_mhi, pci_addr);
 
 	__pci_epf_mhi_unmap_free(mhi_cntrl, pci_addr, paddr, vaddr, offset,
 				 size);
@@ -190,8 +188,7 @@ static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 				      void *to, size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	struct pci_epc *epc = epf_mhi->epf->epc;
-	size_t offset = get_align_offset(epc, from);
+	size_t offset = get_align_offset(epf_mhi, from);
 	void __iomem *tre_buf;
 	phys_addr_t tre_phys;
 	int ret;
@@ -219,8 +216,7 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
 				     void *from, u64 to, size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	struct pci_epc *epc = epf_mhi->epf->epc;
-	size_t offset = get_align_offset(epc, to);
+	size_t offset = get_align_offset(epf_mhi, to);
 	void __iomem *tre_buf;
 	phys_addr_t tre_phys;
 	int ret;
@@ -277,6 +273,10 @@ static int pci_epf_mhi_core_init(struct pci_epf *epf)
 		return ret;
 	}
 
+	epf_mhi->epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epf_mhi->epc_features)
+		return -ENODATA;
+
 	return 0;
 }
 
-- 
2.25.1

