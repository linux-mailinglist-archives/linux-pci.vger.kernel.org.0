Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A1F5F6884
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiJFNuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiJFNuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 09:50:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECC28E27
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 06:49:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fw14so1799086pjb.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Oct 2022 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mWMJic3+3eVweR7Hb3wJwKAsDypmbh3PTgAfppiGim0=;
        b=ZkJ3eSSvWEQHG4zrCYO/rtAQMC+rTCblUgkXT/sojUfeAz6djcfzmaQhTE1VFhHlb5
         c1atXYEjU3xEGE7hI13KaDEcIgKWkEtN1hvwHwEilxv96++sncyPLWqzhVGEXpdUs06G
         CdnNu3apyqKTZeVSCSOWHTmHzGnFe3F2KnJM3MWKtya9Y3YnYefumWTirYL9USS1lYub
         A/mEPLmhBfwN3a8nKOKM2rGPY5Mu7KrZF82KX4Ex4dyspcvVZE3FoiZPzuE8M8MOv+bw
         OGNw6BEO2hAZNd93A/lo5mHGoPx0ZTYnxKuuVNn8KZcYJUWz6h7H+Lqu3yOpWNU2Gh62
         93nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mWMJic3+3eVweR7Hb3wJwKAsDypmbh3PTgAfppiGim0=;
        b=qh4qFs/4LQKzku6PoSLoLFTdga8SuFGUHRQm5Sfs2Z8uqFdZvxdOogAqYxO4e0TL3y
         QD1GIpHc6mjcjTYgKXXueLq/203PaCgnfUmNoi1eyWg4dvf1zcUzRodXUiCVzQWvgBDI
         Fvt8+Q1SJ3Aj1vK5tI8DPaZB4ZhiglPRPxmDpdGMx1Sb1HWedvMP6MPcOZWFl8cb2Qpz
         M+/wGPS+3P8HwUteXJFR1Gw2R4eYiuE90bNoKLxfbWADoGISmL54YuWB18Ddau1SFM8u
         TIBTHaDN3ji+X7BRJFBEsFXUvIdXg66CQF51tckngW29dVk2wMrLJhZ2pTKqfNikp4dN
         VLUQ==
X-Gm-Message-State: ACrzQf0hfQPMHkI6uYxuZa45GHenUoAR9Xc/C1vo7dI4iI9sf2ymk2qM
        Mh0llHCMHmkx6FPncdyp7DXL
X-Google-Smtp-Source: AMsMyM6adD7Qiz1npAI/QIQqcXzzqSFAqQ7y/8Uf2egzhAubDRgCFWLfQ2y5Xniqseks4ePMXNdkGg==
X-Received: by 2002:a17:90a:4b47:b0:20a:e47c:1450 with SMTP id o7-20020a17090a4b4700b0020ae47c1450mr10742123pjl.198.1665064195847;
        Thu, 06 Oct 2022 06:49:55 -0700 (PDT)
Received: from localhost.localdomain ([220.158.158.220])
        by smtp.gmail.com with ESMTPSA id k25-20020a635a59000000b00434760ee36asm1874053pgm.16.2022.10.06.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:49:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/5] PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
Date:   Thu,  6 Oct 2022 19:19:25 +0530
Message-Id: <20221006134927.41437-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The EPC controller maintains a list of EPF drivers added to it. For
protecting this list against the concurrent accesses, the epc->lock
(used for protecting epc_ops) has been used so far. Since there were
no users trying to use epc_ops and modify the pci_epf list simultaneously,
this was not an issue.

But with the addition of callback mechanism for passing the events, this
will be a problem. Because the pci_epf list needs to be iterated first
for getting hold of the EPF driver and then the relevant event specific
callback needs to be called for the driver.

If the same epc->lock is used, then it will result in a deadlock scenario.

For instance,

...
	mutex_lock(&epc->lock);
	list_for_each_entry(epf, &epc->pci_epf, list) {
		epf->event_ops->core_init(epf);
		|
		|-> pci_epc_set_bar();
			|
			|-> mutex_lock(&epc->lock) # DEADLOCK
...

So to fix this issue, use a separate lock called "list_lock" for
protecting the pci_epf list against the concurrent accesses. This lock
will also be used by the callback mechanism.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 9 +++++----
 include/linux/pci-epc.h             | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..6cce430d431b 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -613,7 +613,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 	if (type == SECONDARY_INTERFACE && epf->sec_epc)
 		return -EBUSY;
 
-	mutex_lock(&epc->lock);
+	mutex_lock(&epc->list_lock);
 	func_no = find_first_zero_bit(&epc->function_num_map,
 				      BITS_PER_LONG);
 	if (func_no >= BITS_PER_LONG) {
@@ -640,7 +640,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 
 	list_add_tail(list, &epc->pci_epf);
 ret:
-	mutex_unlock(&epc->lock);
+	mutex_unlock(&epc->list_lock);
 
 	return ret;
 }
@@ -672,11 +672,11 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 		list = &epf->sec_epc_list;
 	}
 
-	mutex_lock(&epc->lock);
+	mutex_lock(&epc->list_lock);
 	clear_bit(func_no, &epc->function_num_map);
 	list_del(list);
 	epf->epc = NULL;
-	mutex_unlock(&epc->lock);
+	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
 
@@ -773,6 +773,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	}
 
 	mutex_init(&epc->lock);
+	mutex_init(&epc->list_lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
 	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..fe729dfe509b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -122,6 +122,7 @@ struct pci_epc_mem {
  * struct pci_epc - represents the PCI EPC device
  * @dev: PCI EPC device
  * @pci_epf: list of endpoint functions present in this EPC device
+ * list_lock: Mutex for protecting pci_epf list
  * @ops: function pointers for performing endpoint operations
  * @windows: array of address space of the endpoint controller
  * @mem: first window of the endpoint controller, which corresponds to
@@ -139,6 +140,7 @@ struct pci_epc_mem {
 struct pci_epc {
 	struct device			dev;
 	struct list_head		pci_epf;
+	struct mutex			list_lock;
 	const struct pci_epc_ops	*ops;
 	struct pci_epc_mem		**windows;
 	struct pci_epc_mem		*mem;
-- 
2.25.1

