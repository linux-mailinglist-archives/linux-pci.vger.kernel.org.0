Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15E4665A8B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 12:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAKLnY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 06:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjAKLm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 06:42:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770CE0B9
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 03:41:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so19750871pjq.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 03:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH9vt83FVTay5mm3rIS7SlgtDXXGxJxNj0BGxkKfd2s=;
        b=Wg4x6bfvkxTfPYAlmxDxvXJtxohXxtVWE6cbO6bG+wfAiroXDjoQq3gbHUJT2zTDQw
         E/UV7gwj4xckA4/JVrgrdY6CLiFH1c/0HQMFN9aqUCn/i3e4dPIMdAaohF7d9887/yvE
         cAxTsO6JIpTz2M89IuqxPUX04QGOeBw6jlkllTgVQJcj+QTtQgUZgx0oQ14eVfe8rjXD
         jViJwLb7gk8sILVD2hefT36N8F+Cj6l5JpO5pr7YP1QM/4etP81ewSNM777dv1QQr3Q7
         x8OTqxog5q7+qnQ/NQhxU4JHjXCX+pe475L2HMmxJfy9kZDzRq/nRC19yxkpaEuIM39N
         02KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH9vt83FVTay5mm3rIS7SlgtDXXGxJxNj0BGxkKfd2s=;
        b=T3HJhO2U9YC0BvwUR0/mPtixUTTdeUGBMkuPaG/CffBzwesi1GrGmB4jrPNldxGbEm
         R9mEUbii0gNLUm7snL1IEkP/ck/4M+euZ8LtiKCqNC4pJfogAq08u9HbkmoEfy41f42Q
         zvKU/w6sgdwqBxl6m1tcVTerEqwczwqu43ZmQGnDIdWuUTxb0x7J/5lfB6J/rFexGYJ0
         0/uPMX5mQZxP5AKGx7LbgcuQlLaxD14dvsccCtH1+e3ClkyiYYcBuDIKrAuBB+i9Em7M
         tQc033/SATmyL8I4kevEdJSojFEP21xdbiX/L8mPrVAVI177w6in22e5ihoDL4pJCr7V
         irQA==
X-Gm-Message-State: AFqh2krcUTzmcneOh9GL+UzNyu7KYYKP6fu+53yn/KUu8j93fHFfO7T0
        951c82z7QJVtG1H7kf6zy+66
X-Google-Smtp-Source: AMrXdXupiESlafMbBbpuY+/ZXnQBHBLh7EwSN1/svtwmT2KZuuvn8C/KLT5Ub0Al9vfL/2yOHhRtPg==
X-Received: by 2002:a17:902:7d8e:b0:194:4981:2018 with SMTP id a14-20020a1709027d8e00b0019449812018mr1972566plm.60.1673437286659;
        Wed, 11 Jan 2023 03:41:26 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0018958a913a2sm9942688plf.223.2023.01.11.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:41:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND v4 3/5] PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
Date:   Wed, 11 Jan 2023 17:10:57 +0530
Message-Id: <20230111114059.6553-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
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

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 9 +++++----
 include/linux/pci-epc.h             | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2542196e8c3d..2c023db8f51c 100644
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
 
@@ -777,6 +777,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
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

