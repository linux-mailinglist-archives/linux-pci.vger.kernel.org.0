Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455BF66923F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 10:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbjAMJFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 04:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjAMJEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 04:04:20 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A174641
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 01:04:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b17so15328582pld.7
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 01:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BZHqfo7sFuXP72fnPp/JPxWAqzMlK6d2jnnMQV3zqE=;
        b=mCZTClX+9zwz1K99NSs2vAa1hO/adLIB4vn6t+EUxTWLPFL5Ma3Ao5JOXnwQNCUetj
         FARd3QvLL4iLl5lWb8wlV6zbIX52LEacsNm51RT4Q7z/5RxQKIzp7elDl29oDTeUJHkl
         BN8zW4m6JUifl0QCt4mSrLlxyQd7xhyJqe7lfNzP5C9tGxpGXnSlLxDebAgPSplqFAPB
         TGF/RxQHr0AqWA2zm+5n3sKmE9yDOiHT/dsWmpKZHtdxrCmuFds1uDzTyEYSREUyLE7L
         yr7k4Y5W3kGu/8YMYXmgrqfGSLf9DyAQ1pPtcp10kyz9qQre5n8oLj5M9wKQrQ8I5vJg
         h26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BZHqfo7sFuXP72fnPp/JPxWAqzMlK6d2jnnMQV3zqE=;
        b=MCV7yINwfkcOvMQqdFtFDo4r9ZmLA9TJn6WlyL6duElOkGYoLK9/Vj088B7QtY2VYY
         JpsWTZQRzgBt55cZ6dDJV9wztT3BBZCWjmWJpqgUMmaz6a5ihcaLbDBV62pQb2omtS2k
         7Xpidp+O8yGwhGqRSaNuvHUCrDpSHbJSIz+VzA6rfXpcEeWGnzbgXa409vjV9BIXvsVd
         X1ya6hwk3hEPT+as5mE4itXHsYnQPn96E2D2vgQX4B7qNV0VrPPxwDHYa1Fzr1G/VAM0
         Kowd9oBIhapkaTrEdt2O4EwOhWv1jCWp+u62c5T92cJ+Qqq9C+JKJ10xMlfRMt+zYBcH
         CnLw==
X-Gm-Message-State: AFqh2krQIMXpZzZTJp0UQwKkU/EFk6Y6B4hiGTNSetwOHBwacTACjOpN
        9bJ8Yz+Zx1OGrPfLM+clBDOFhQ==
X-Google-Smtp-Source: AMrXdXton3HGLHrvkGuNbTEbGlI/Mo+sFQahSF2HIwe598OifzLl925iAO71L7ad4MOjLVut2A7K/Q==
X-Received: by 2002:a17:902:da83:b0:189:8425:730d with SMTP id j3-20020a170902da8300b001898425730dmr111444062plx.27.1673600641918;
        Fri, 13 Jan 2023 01:04:01 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b00189bf5deda3sm13645510plf.133.2023.01.13.01.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:04:01 -0800 (PST)
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
Subject: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware map/unmaping
Date:   Fri, 13 Jan 2023 18:03:48 +0900
Message-Id: <20230113090350.1103494-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113090350.1103494-1-mie@igel.co.jp>
References: <20230113090350.1103494-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add an align_mem operation to the EPC ops, which function is used to
pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
restriction of EPC. The map function maps an aligned memory to include a
requested memory region.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 57 ++++++++++++++++++++++++-----
 include/linux/pci-epc.h             | 10 +++--
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2542196e8c3d..60d586e05e7d 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -430,8 +430,12 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
  * Invoke to unmap the CPU address from PCI address.
  */
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			phys_addr_t phys_addr)
+			phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
 {
+	u64 aligned_phys;
+	void __iomem *aligned_virt;
+	size_t offset;
+
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return;
 
@@ -441,9 +445,22 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (!epc->ops->unmap_addr)
 		return;
 
+	if (epc->ops->align_mem) {
+		mutex_lock(&epc->lock);
+		aligned_phys = epc->ops->align_mem(epc, phys_addr, &size);
+		mutex_unlock(&epc->lock);
+	} else {
+		aligned_phys = phys_addr;
+	}
+
+	offset = phys_addr - aligned_phys;
+	aligned_virt = virt_addr - offset;
+
 	mutex_lock(&epc->lock);
-	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
+	epc->ops->unmap_addr(epc, func_no, vfunc_no, aligned_phys);
 	mutex_unlock(&epc->lock);
+
+	pci_epc_mem_free_addr(epc, aligned_phys, aligned_virt, size);
 }
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
 
@@ -458,26 +475,46 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
  *
  * Invoke to map CPU address with PCI address.
  */
-int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
+void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		u64 pci_addr, phys_addr_t *phys_addr, size_t size)
 {
 	int ret;
+	u64 aligned_addr;
+	size_t offset;
+	void __iomem *virt_addr;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (!epc->ops->map_addr)
-		return 0;
+		return ERR_PTR(-ENOPTSUPP);
+
+	if (epc->ops->align_mem) {
+		mutex_lock(&epc->lock);
+		aligned_addr = epc->ops->align_mem(epc, pci_addr, &size);
+		mutex_unlock(&epc->lock);
+	} else {
+		aligned_addr = pci_addr;
+	}
+
+	offset = pci_addr - aligned_addr;
+
+	virt_addr = pci_epc_mem_alloc_addr(epc, phys_addr, size);
+	if (!virt_addr)
+		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
-				 size);
+	ret = epc->ops->map_addr(epc, func_no, vfunc_no, *phys_addr, aligned_addr, size);
 	mutex_unlock(&epc->lock);
+	if (ret)
+		return ERR_PTR(ret);
 
-	return ret;
+	*phys_addr += offset;
+
+	return virt_addr + offset;
 }
 EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..8f29161bce80 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -84,6 +84,7 @@ struct pci_epc_ops {
 			       phys_addr_t phys_addr, u8 interrupt_num,
 			       u32 entry_size, u32 *msi_data,
 			       u32 *msi_addr_offset);
+	u64	(*align_mem)(struct pci_epc *epc, u64 addr, size_t *size);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
@@ -218,11 +219,12 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		       struct pci_epf_bar *epf_bar);
-int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-		     phys_addr_t phys_addr,
-		     u64 pci_addr, size_t size);
+void __iomem *pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       u64 pci_addr, phys_addr_t *phys_addr,
+			       size_t size);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			phys_addr_t phys_addr);
+			phys_addr_t phys_addr, void __iomem *virt_addr,
+			size_t size);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    u8 interrupts);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
-- 
2.25.1

