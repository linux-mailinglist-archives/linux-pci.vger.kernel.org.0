Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53F5669243
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 10:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbjAMJFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 04:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjAMJFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 04:05:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA79736F0
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 01:04:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso26426481pjt.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 01:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZXGSNWlfPLDUVH1iGddBW0l88BlZlK09bpAmm1lhmY=;
        b=6Xi6bt0Ya85oYGvBiB8XVOqsGmOeuImFPi8YUQmFpLyBbvMRW8wQ3ncWNYy7CrCCP5
         7Bp5l3FqLFwFc+teXf4lcKx+tqseBiI2In/92EvMSusgGuUBXI/UCMeQwC6r6Wz5gzfs
         amr/e/jV8iGhrmJhLxiP8n2OS+iX0vmNVJUHGxQKw2YHPv/2JDPG2O9eOXgzYWh2lIGb
         LmtMbMob2J/Si3uqRiG35feI1RnRG+KZn5lP6ZzLKohi1mFsEOiFAQd2eRGExtc01dHX
         CWILOI9FP8bc78/Yj3N1kjOirm3B+DToda7tD1rD+NXyeMAAkTZhFjYT9viuZcC36Ug8
         KvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZXGSNWlfPLDUVH1iGddBW0l88BlZlK09bpAmm1lhmY=;
        b=kMTdFfMM8tLEPeSlcsw/KTRgutg55tLn/SgCAZa713dze1YGC1ON9r/x43Rti0Qvvm
         9zgZmoAcQnPfZA/o8utEL4TkivWW0hz7QvPYTuLJBNYp6wQgJcHPbWZRh1ddfvWMRQCX
         VtF1VdeRaBEDo1LPdha4kQfBRLwqRNiP8e0kLsG77uYg4ZJHbm+2+AHyFT3pXRRp6yM8
         2LuvnxDQ758hXLItpzt4ldtaRh7/etYlRES9Rvq8BSxh4hVwdZOf8NCubjfKZSoXNhzZ
         71AAdBmfvCsSde6WX87BJsJZTe0cC0IHDmrR8ljanAHeCP998ruBlwtu4WgVYQdY+ISN
         J1hw==
X-Gm-Message-State: AFqh2krJdthsrBT56BKknFUx82iI6rX1dqb8Kz1INorQ8n9olZqWzYfE
        pPjNSKlUh69Tbg0XiOdVFcB1rA==
X-Google-Smtp-Source: AMrXdXvri2Qepeukyexki5xgsBZ2ZmJCQ1Uu3PE520x2rvuu313ZsZ+U3mGUYtdp0BpMZzcbYrlxdw==
X-Received: by 2002:a17:902:b609:b0:192:e9cf:93ba with SMTP id b9-20020a170902b60900b00192e9cf93bamr32178510pls.12.1673600649254;
        Fri, 13 Jan 2023 01:04:09 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b00189bf5deda3sm13645510plf.133.2023.01.13.01.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:04:08 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] PCI: endpoint: support pci_epc_mem_map/unmap API changes
Date:   Fri, 13 Jan 2023 18:03:50 +0900
Message-Id: <20230113090350.1103494-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113090350.1103494-1-mie@igel.co.jp>
References: <20230113090350.1103494-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The APIs have changed to support non aligned memory mapping on
endpoint. Adapt the new API to pci-epf-test. The API allocate
pci epc memory inside, so remove allocations.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 89 +++++--------------
 1 file changed, 24 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 55283d2379a6..73e75591fd81 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -323,37 +323,22 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	size_t size = reg->size;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
-	if (!src_addr) {
-		dev_err(dev, "Failed to allocate source address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
-			       reg->src_addr, reg->size);
-	if (ret) {
+	src_addr = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, reg->src_addr,
+			       &src_phys_addr, size);
+	if (IS_ERR(src_addr)) {
 		dev_err(dev, "Failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
-		goto err_src_addr;
-	}
-
-	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
-	if (!dst_addr) {
-		dev_err(dev, "Failed to allocate destination address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err_src_map_addr;
+		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
-			       reg->dst_addr, reg->size);
+	dst_addr = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, reg->dst_addr,
+			       &dst_phys_addr, size);
 	if (ret) {
 		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
-		goto err_dst_addr;
+		goto err_src_map_addr;
 	}
 
 	ktime_get_ts64(&start);
@@ -393,16 +378,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
-
-err_dst_addr:
-	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr, dst_addr, size);
 
 err_src_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr);
-
-err_src_addr:
-	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr, src_addr, size);
 
 err:
 	return ret;
@@ -410,7 +389,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
 static int pci_epf_test_read(struct pci_epf_test *epf_test)
 {
-	int ret;
+	int ret = 0;
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
@@ -424,21 +403,14 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	size_t size = reg->size;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
-	if (!src_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->src_addr, reg->size);
-	if (ret) {
+	src_addr = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no,
+				    reg->src_addr, &phys_addr, size);
+	if (IS_ERR(src_addr)) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
-		goto err_addr;
+		goto err;
 	}
 
 	buf = kzalloc(reg->size, GFP_KERNEL);
@@ -489,10 +461,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
-
-err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr, src_addr, size);
 
 err:
 	return ret;
@@ -500,7 +469,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 static int pci_epf_test_write(struct pci_epf_test *epf_test)
 {
-	int ret;
+	int ret = 0;
 	void __iomem *dst_addr;
 	void *buf;
 	bool use_dma;
@@ -513,21 +482,14 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	size_t size = reg->size;
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
-	if (!dst_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->dst_addr, reg->size);
-	if (ret) {
+	dst_addr = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no,
+				    reg->dst_addr, &phys_addr, size);
+	if (IS_ERR(dst_addr)) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
-		goto err_addr;
+		goto err;
 	}
 
 	buf = kzalloc(reg->size, GFP_KERNEL);
@@ -585,10 +547,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
-
-err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr, dst_addr, size);
 
 err:
 	return ret;
-- 
2.25.1

