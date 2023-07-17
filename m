Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B117755C27
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGQGzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 02:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjGQGzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 02:55:16 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71114E72
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2023 23:55:14 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-565f3881cbeso2865626eaf.2
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2023 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689576913; x=1692168913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywAnQod/2AqwT52mE4IcwiOccI2A/vlz7fI3wixXChQ=;
        b=COxSewSo57T9BYc2XB2RPZ4S4/p9vHVhb/9T0vJbWnE3ejosuOiGQqop/S61n/1m3J
         gkiP8ON7pKLZ4ZVgLDBQauxT8OH/GamXdZYAaroBax+c+pJyxkwIDgHV4BvBvU9cz9gC
         ORuA9rzT+Y+pVl7xVbwIs18jJZgMBzv68WrrTbl3zb0fVEbvL9sLnd0o7OinkY7ktJHR
         IpPkpcEIYO0/QaLZJB1U2axaO88F7fOPuIflkBqIFtuV0HCdprTqD5/abDDBplGCj/Ux
         w8aGmGaoDRFuS8oyYO93MLY3hceXm7PI38z7O0T9iTutiJPqwfc8HRnO4u/bLl7wJUjM
         XbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576913; x=1692168913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywAnQod/2AqwT52mE4IcwiOccI2A/vlz7fI3wixXChQ=;
        b=TaIZelHsmjlqbIMyauclWVCu8shGlX+OVxaiolmeEkHoig0uCRSXJWKfhqPYta5mXR
         hY5FNAbhPxCh8u/j2hkRgfqObA5cx5v/QcBXaMPTmbj4tAg/qMuylCWrlme9SbqfLUiK
         UBtsT+qBVRxuKEBA/PWUV56goz3Ka9LQoGnK7PNc4mUrGyuYuXshXKINBB/NeLAhAsT7
         47qbQgQag18740EWC7z++j5xH/2cEH5+bAitBWt1LV/Enyxf5l6Ki7tGNzLE0KhnUEE9
         VE42i4FhNHSY5CjAA7hC2UQyG4Ki7PW8UT8mPbKDqWrd75eTg6myWinyvs5wJ0HOQavx
         K/1g==
X-Gm-Message-State: ABy/qLY4h1dAxH37ti9/7vZcubMZXg86GSrM4oPLB0RAsBszfyoL4E5O
        eMzfzc/rGdwr2deIU3Qj2fX5
X-Google-Smtp-Source: APBJJlHX3QrNZi1kF0ACqAndRyoTeRH+RwIj7l0pEb3csyqHwPIlTIViF8Yxs4dhF5BQV/6Kba6YoQ==
X-Received: by 2002:a05:6358:9184:b0:134:c37f:4b64 with SMTP id j4-20020a056358918400b00134c37f4b64mr8163188rwa.30.1689576913646;
        Sun, 16 Jul 2023 23:55:13 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.209])
        by smtp.gmail.com with ESMTPSA id x7-20020a62fb07000000b006675c242548sm11196422pfm.182.2023.07.16.23.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:55:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/7] PCI: epf-mhi: Make use of the alignment restriction from EPF core
Date:   Mon, 17 Jul 2023 12:24:54 +0530
Message-Id: <20230717065459.14138-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
References: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of hardcoding the alignment restriction in the EPF_MHI driver, make
use of the info available from the EPF core that reflects the alignment
restriction of the endpoint controller.

For this purpose, let's introduce the get_align_offset() static function.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 9c1f5a154fbd..bb7de6884824 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -102,6 +102,11 @@ struct pci_epf_mhi {
 	int irq;
 };
 
+static size_t get_align_offset(struct pci_epc *epc, u64 addr)
+{
+	return addr % epc->mem->window.page_size;
+}
+
 static int __pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
 				 phys_addr_t *paddr, void __iomem **vaddr,
 				 size_t offset, size_t size)
@@ -134,7 +139,7 @@ static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct pci_epc *epc = epf_mhi->epf->epc;
-	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
+	size_t offset = get_align_offset(epc, pci_addr);
 
 	return __pci_epf_mhi_alloc_map(mhi_cntrl, pci_addr, paddr, vaddr,
 				      offset, size);
@@ -161,7 +166,7 @@ static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct pci_epf *epf = epf_mhi->epf;
 	struct pci_epc *epc = epf->epc;
-	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
+	size_t offset = get_align_offset(epc, pci_addr);
 
 	__pci_epf_mhi_unmap_free(mhi_cntrl, pci_addr, paddr, vaddr, offset,
 				 size);
@@ -185,7 +190,8 @@ static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 				      void *to, size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	size_t offset = from % SZ_4K;
+	struct pci_epc *epc = epf_mhi->epf->epc;
+	size_t offset = get_align_offset(epc, from);
 	void __iomem *tre_buf;
 	phys_addr_t tre_phys;
 	int ret;
@@ -213,7 +219,8 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
 				     void *from, u64 to, size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	size_t offset = to % SZ_4K;
+	struct pci_epc *epc = epf_mhi->epf->epc;
+	size_t offset = get_align_offset(epc, to);
 	void __iomem *tre_buf;
 	phys_addr_t tre_phys;
 	int ret;
-- 
2.25.1

