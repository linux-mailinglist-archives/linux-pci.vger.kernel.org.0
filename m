Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E24C62B3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 06:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiB1Fxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 00:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiB1Fxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 00:53:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABBDDE8E
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 21:52:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id ay5so6962793plb.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 21:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FGVyqcRhA3FOHpBtjYMfLTMY/AEpBQwbSy9bJblggI=;
        b=Lzsq0flf1Peawv9YIxTb4si+LwH45dAarQEgouedmzJ5DPr3OKlAEOE/zXiVZuhimo
         16l74awZObG6YUNX69s4ZQD9j3u+dpxRV+FIF2ajwaJ5W2Sch8HA3gYbT7ylq5aYhzpz
         +UiI40kZeg8vB4pCNaZED2s6C9a2U02SHSQdR5nYatjQ3FdCu0zjPjHc0V6E8odQfCiC
         uXagAPqDU8SRUjvYVZHQJUytBGetSz7RXaDRCP3Lh7nwbQcmdZd10hekiOIxVEUYLxGz
         WYJNwRvLyGDJhitCprkIcon1rdC/CKy3qjNdWu9TFXuI/5MkReR8bMM+lQRgGw80LjQU
         w0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FGVyqcRhA3FOHpBtjYMfLTMY/AEpBQwbSy9bJblggI=;
        b=vPV4U7a9w8yw37GlRVwvYd8/sGR6LkQH/fjIU6nQJJe29TioGVESXhZT1zpjeE7vO8
         B++SimtcreuI98QQrMiit4+Z9XGmnnODX8iKKUKWc8JuLoLZ2GIiYUjxD/1ZE9mE5O+7
         Ymd/eIMjQXzb/oXS5MT/sE4OM6j94JfmNfsn8LhBXsvURRVK6c5pl41HV7KpbEZ4qZ86
         rpj68KYWQzWkicbttIIE+PjzstLz9xicUfk7+rX6qdb99juhJxI8eKTW6nGPc/VmB8by
         VQLKAHvGJIjluzcWQvBs3Ev38krVMI+MSWL8FcbL2jE9+PDwLraGChF3REHKawIh56Q+
         vzeA==
X-Gm-Message-State: AOAM530B9pkx4YNwRq2EX+P6WE4LFdWUSnztgyq1YghOY3isSMfbzHk5
        PqJeM6U/KOJELTcKN/bOodaW
X-Google-Smtp-Source: ABdhPJwFoRlHY3Zz7LvDla501/Ax2UTABJkTUcPDmAvq7T5FJDh2bDtG/0+erKzsCm+aTmibOX8h9g==
X-Received: by 2002:a17:902:9a4c:b0:14d:b0c0:1f7a with SMTP id x12-20020a1709029a4c00b0014db0c01f7amr18521618plv.57.1646027569344;
        Sun, 27 Feb 2022 21:52:49 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id l17-20020a056a0016d100b004c34686e322sm12291191pfc.182.2022.02.27.21.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 21:52:49 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] PCI: endpoint: Use blocking notifier instead of atomic
Date:   Mon, 28 Feb 2022 11:22:40 +0530
Message-Id: <20220228055240.24774-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The use of atomic notifier causes sleeping in atomic context bug when
the EPC core functions are used in the notifier chain. This is due to the
use of epc->lock (mutex) in core functions protecting the concurrent use of
EPC.

So switch to blocking notifier for getting rid of the bug as it runs in
non-atomic context and allows sleeping in notifier chain.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Removed the changes related to non-upstreamed patches

 drivers/pci/endpoint/pci-epc-core.c | 6 +++---
 include/linux/pci-epc.h             | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..c4347f472618 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -693,7 +693,7 @@ void pci_epc_linkup(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
+	blocking_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -710,7 +710,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+	blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
@@ -774,7 +774,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 	mutex_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
-	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..04a2e74aed63 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -149,7 +149,7 @@ struct pci_epc {
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
 	unsigned long			function_num_map;
-	struct atomic_notifier_head	notifier;
+	struct blocking_notifier_head	notifier;
 };
 
 /**
@@ -195,7 +195,7 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
 static inline int
 pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&epc->notifier, nb);
+	return blocking_notifier_chain_register(&epc->notifier, nb);
 }
 
 struct pci_epc *
-- 
2.25.1

