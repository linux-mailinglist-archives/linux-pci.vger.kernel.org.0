Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883FD6791A7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjAXHMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjAXHMq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:12:46 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A7D3EC51
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9so13856816pll.9
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH9vt83FVTay5mm3rIS7SlgtDXXGxJxNj0BGxkKfd2s=;
        b=KpayRy1mwChJZrnXae442WsM2cwAA8qXgwj4GzK6axTqDd6Gw56qrfgcyEzk+jiW1m
         lA/0YVULthaerJWfY2IDUDE4Nk7kG4Ils5j/PBdP/TgfGkfMb5haMfOf/jdiYXP3/r8i
         +Vpr6A0fZ3rIjOQUg9NBx8zJ9cOkYBIs+bRv/fmLG1U7hykUhmywmxtVyeCHIDNgUvJd
         DfeeqDLcfc2d7pFBYPWXY+03fdm19/EuJSEzPBTFqVKEflWr1nyiNacn9G1Uw1/T0v6m
         XvM1fm4Z+AEp0Jyfpf5LNu8c5fyhRlMssYkXQUqysPQwPOhofUpYspWu55ELGAgFFTYZ
         xAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH9vt83FVTay5mm3rIS7SlgtDXXGxJxNj0BGxkKfd2s=;
        b=MY+yMwU8iBwhjEwHI7810unv4mpZkM204/3PpAzCYIIbdb0+p8GPgj7o9dPg5lqGVi
         BgGQSoU99oxwHRR0Q1pXcbvGSofw/Bn5eXwt7wjE7z+9hxQQQUnAEYOXnunxCojtHynw
         UD9P25iLQRkNdLh65orz9PWlHIwvZuLxtX98mJ60SeqSIKiecBSVqZi7br0ko5uWHmYW
         hExiCrX8bgmV15PmJZo083K79PzlXEu+EWEI5OW389+0Ce+eY48jB4SFyzDVlMt1/iyr
         jxsoo3jW+Vp26Isq+OFUTCwR1VwEr5Js/QvF3WLA1p+Q7Rv7+K82U2DNxMMl2w2/4755
         P15A==
X-Gm-Message-State: AFqh2koKIY7RlDqtyWds9hUMtHVhK92C4jOtjW6kqvCSrGJJYUUCY81m
        tjJkGNvHdq7WGIrUPRNV7VLK
X-Google-Smtp-Source: AMrXdXs8ooTqmK4dc0XqlbmRGaIi84s0kWxQa/jmoNfq4Q01JMFzY21M++oIxnJoDNO0nipXns06Yg==
X-Received: by 2002:a05:6a20:3a82:b0:b8:7e6d:5b72 with SMTP id d2-20020a056a203a8200b000b87e6d5b72mr25572101pzh.36.1674544356275;
        Mon, 23 Jan 2023 23:12:36 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b00219220edf0dsm736041pjm.48.2023.01.23.23.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:12:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 3/5] PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
Date:   Tue, 24 Jan 2023 12:41:56 +0530
Message-Id: <20230124071158.5503-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

