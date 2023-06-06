Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550AF724178
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 13:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbjFFL6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 07:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbjFFL6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 07:58:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F3B186
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 04:58:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b04706c85fso56202615ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Jun 2023 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686052717; x=1688644717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vScY3E4RObHEz5P1xKAaD36hA/8YhvR3M5FwIPwlZU=;
        b=UyKHjYlFKGEv7V+UmkB+tBQTolnof2AaJHHca835LpFsLOW2aW9K2eR9g9sF3od/o1
         PMMZmdydHq1chF4Zbbv3hyGMlxdIDRQoHvtRKsKMsMWcf120seebbf0Rz3OKSxqffgdZ
         AthdX5S3+HQmu/wfmgRVyeGmRxDhjCMjbh4tFALeHnQOZnY/mVFnPWu9S7h1+xw7iHOx
         zDaUvNbOS+ESsiUDnt5aPLvszk2a2jcCjQOG4PYMI2610sG6oCOXc531+B6R1uWRRkXZ
         eFaIaRoSnH7PKNHGj0XFjfOI1VATCqaIqOiiDmrKVTT1rfzJlgVefIu59fXo4pdTqaB6
         91EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052717; x=1688644717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vScY3E4RObHEz5P1xKAaD36hA/8YhvR3M5FwIPwlZU=;
        b=WizUjLcLsZxScF28XO5d8RAlN/zxNqCuCgD092aWZNtHMZ86kk5a161bgtuwFk5E6t
         pJmgzBzAQ6QflpqUW5wDs3CJmpYvxQj+5n2ygrY6WDyQwc8tYXCW72brotBaxJh0yFbD
         a+kU+UrCMWelxWLumAbM1AkfoaJdq6nR26NVc2MvDRw+eTu5O8qJQA3sTMjqEIt8j1su
         mat3ynnkfyHnEdaERgnixdLVjKxHryRk4ql5dbd7vEZzyIxqZ9rQRB1JNaDG8ywnbYsz
         Eg1BYjesg1Nc/epPyLcW3KkTkryBul3QZI4KjsgK8GHWXuglYSJOrB9wVdmI8eG+WvMM
         JR3w==
X-Gm-Message-State: AC+VfDz0FAAl5VLRc5vtvgp5faB4Zqbf8+DoU0Q2jfYJF0EiSP2Ip67R
        12dIeSyE8FWm/KrAxwZ+6B+P
X-Google-Smtp-Source: ACHHUZ6JtzIp1MckXBk9Sidb8LFAo1Mrx14hi0OzRicqigbH0obqArdcceesM0LmEw09UeMHl+eUtg==
X-Received: by 2002:a17:902:ecc2:b0:1b0:42d1:ecd0 with SMTP id a2-20020a170902ecc200b001b042d1ecd0mr2424521plh.66.1686052716914;
        Tue, 06 Jun 2023 04:58:36 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001acaf7e22bdsm8419226plh.14.2023.06.06.04.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:58:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/7] PCI: epf-mhi: Make use of the alignment restriction from EPF core
Date:   Tue,  6 Jun 2023 17:28:09 +0530
Message-Id: <20230606115814.53319-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
References: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 1227f059ea12..cef866f7d204 100644
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

