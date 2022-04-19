Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0918506C5C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352312AbiDSM0w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 08:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352325AbiDSM0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 08:26:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560F36B69;
        Tue, 19 Apr 2022 05:24:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z99so21020916ede.5;
        Tue, 19 Apr 2022 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzsO0OH64I9oYEuJ3bY1ziODzwl46OGR5ery+8e6tc4=;
        b=d5gjhf9G7Vn0LovvZa0Oq+J+ZCB0V7X3xVKmA4Sx2lt6i5AYhIVJOjQ1sEwuGENuuo
         5KHP7n/VQ+PnGNDJ3zGdIME1nr9WigVXc7Xh+Z6Re0swBLxSk8u+6ZjOJyQkNDCVBHSw
         qVKj26pZNNAiyJ84z5uD6sd+QMQkNnNXEyHfciyS4I5eIprM2RrAuCVfmbBaCeptnXTl
         q01Oifc1VO+BtBJEa2ZoXaYSSPt5eGwVL9Txsp9f562Bg9N/0FzwGC+iOcCLeM3OUQLo
         5AbAs7xZE/sI0x3+8+IwH7ZQjE9k2MXhFEQQ+L+LsWWdAF4LSHypjdU/YVZIL4CL5qlE
         OIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzsO0OH64I9oYEuJ3bY1ziODzwl46OGR5ery+8e6tc4=;
        b=V09yf+VH5cFOWAloYa+hyygYh3knNTM7aG9RCS1d3Dixp3AfcXBXT4pc7RwWksJadh
         f+5qwCrwulIKXONooCW3vTPW1z8iKGwzMRNWuIECeafRS/Fg1OCufHGOtif5FcQx2RVO
         R3LkDpdPqmydzwvJXLiuphM8+xDCmyEJnl3T7gC2nq5faNBcDaFLxWgaQphb0GshP+qe
         5X/bYV9cVKYEsYiF4NcR3r1RmHbaazpL/D5QBsgyWOyaX5TIf1wAvUEwsMt7u75lIwuM
         A1+mosL8bkcXAapDBghyObkZ/8jXkmEkZ+oms4Quny4ArTOJUf9rG4NKojrj+0czYpS5
         mI+A==
X-Gm-Message-State: AOAM532tWhFtB/N8UYz71atSFsuu029D33tj2PKevDmpY7MTCWjY7Upg
        Cen7PFBdCWrtXo4j+WZ3jCQ=
X-Google-Smtp-Source: ABdhPJwl7YYLAHB1cYufiRrZQnZCufKblEilDH/00Ya4ENFxkswcO+Vd2WUXn11cvEU0Yx2qVKUDqA==
X-Received: by 2002:a50:8d09:0:b0:41c:b898:19a6 with SMTP id s9-20020a508d09000000b0041cb89819a6mr17120074eds.30.1650371041504;
        Tue, 19 Apr 2022 05:24:01 -0700 (PDT)
Received: from anparri.mshome.net (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm5644685ejm.189.2022.04.19.05.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:24:01 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 4/6] Drivers: hv: vmbus: Introduce vmbus_request_addr_match()
Date:   Tue, 19 Apr 2022 14:23:23 +0200
Message-Id: <20220419122325.10078-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419122325.10078-1-parri.andrea@gmail.com>
References: <20220419122325.10078-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function can be used to retrieve and clear/remove a transation ID
from a channel requestor, provided the memory address corresponding to
the ID equals a specified address.  The function, and its 'lockless'
variant __vmbus_request_addr_match(), will be used by hv_pci.

Refactor vmbus_request_addr() to reuse the 'newly' introduced code.

No functional change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c   | 65 ++++++++++++++++++++++++++++++------------
 include/linux/hyperv.h |  5 ++++
 2 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 585a8084848bf..49f10a603a091 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1279,17 +1279,11 @@ u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 }
 EXPORT_SYMBOL_GPL(vmbus_next_request_id);
 
-/*
- * vmbus_request_addr - Returns the memory address stored at @trans_id
- * in @rqstor. Uses a spin lock to avoid race conditions.
- * @channel: Pointer to the VMbus channel struct
- * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
- * next request id.
- */
-u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
+/* As in vmbus_request_addr_match() but without the requestor lock */
+u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			       u64 rqst_addr)
 {
 	struct vmbus_requestor *rqstor = &channel->requestor;
-	unsigned long flags;
 	u64 req_addr;
 
 	/* Check rqstor has been initialized */
@@ -1300,25 +1294,60 @@ u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
 	if (!trans_id)
 		return VMBUS_RQST_ERROR;
 
-	spin_lock_irqsave(&rqstor->req_lock, flags);
-
 	/* Data corresponding to trans_id is stored at trans_id - 1 */
 	trans_id--;
 
 	/* Invalid trans_id */
-	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap)) {
-		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap))
 		return VMBUS_RQST_ERROR;
-	}
 
 	req_addr = rqstor->req_arr[trans_id];
-	rqstor->req_arr[trans_id] = rqstor->next_request_id;
-	rqstor->next_request_id = trans_id;
+	if (rqst_addr == VMBUS_RQST_ADDR_ANY || req_addr == rqst_addr) {
+		rqstor->req_arr[trans_id] = rqstor->next_request_id;
+		rqstor->next_request_id = trans_id;
 
-	/* The already held spin lock provides atomicity */
-	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+		/* The already held spin lock provides atomicity */
+		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+	}
+
+	return req_addr;
+}
+EXPORT_SYMBOL_GPL(__vmbus_request_addr_match);
+
+/*
+ * vmbus_request_addr_match - Clears/removes @trans_id from the @channel's
+ * requestor, provided the memory address stored at @trans_id equals @rqst_addr
+ * (or provided @rqst_addr matches the sentinel value VMBUS_RQST_ADDR_ANY).
+ *
+ * Returns the memory address stored at @trans_id, or VMBUS_RQST_ERROR if
+ * @trans_id is not contained in the requestor.
+ *
+ * Acquires and releases the requestor spin lock.
+ */
+u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			     u64 rqst_addr)
+{
+	struct vmbus_requestor *rqstor = &channel->requestor;
+	unsigned long flags;
+	u64 req_addr;
 
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+	req_addr = __vmbus_request_addr_match(channel, trans_id, rqst_addr);
 	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+
 	return req_addr;
 }
+EXPORT_SYMBOL_GPL(vmbus_request_addr_match);
+
+/*
+ * vmbus_request_addr - Returns the memory address stored at @trans_id
+ * in @rqstor. Uses a spin lock to avoid race conditions.
+ * @channel: Pointer to the VMbus channel struct
+ * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
+ * next request id.
+ */
+u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
+{
+	return vmbus_request_addr_match(channel, trans_id, VMBUS_RQST_ADDR_ANY);
+}
 EXPORT_SYMBOL_GPL(vmbus_request_addr);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a7cb596d893b1..c77d78f34b96a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -788,6 +788,7 @@ struct vmbus_requestor {
 
 #define VMBUS_NO_RQSTOR U64_MAX
 #define VMBUS_RQST_ERROR (U64_MAX - 1)
+#define VMBUS_RQST_ADDR_ANY U64_MAX
 /* NetVSC-specific */
 #define VMBUS_RQST_ID_NO_RESPONSE (U64_MAX - 2)
 /* StorVSC-specific */
@@ -1042,6 +1043,10 @@ struct vmbus_channel {
 };
 
 u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr);
+u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			       u64 rqst_addr);
+u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			     u64 rqst_addr);
 u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
-- 
2.25.1

