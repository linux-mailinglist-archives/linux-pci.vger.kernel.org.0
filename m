Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274D74C62A0
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 06:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiB1Fcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 00:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiB1Fcv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 00:32:51 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2485F3FDA0
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 21:32:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e13so9763838plh.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 21:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zt5yG2/AIuh58baIFrL7CF1jcLSWp/+HZOTSJf5d7NQ=;
        b=b7NwzpIVwlYqDvvKLnONGL8kears9DE7ord8WnaiDDwPdS3Ggvxu6FggIxv8MJA1M/
         J+1bWhLizd9gVhjHpT/H1uOahYxeCb0TKp/E6dwE5y1aQqQ6ASLbDoA2Fs4eW3R3uAy1
         ger0jrB/hhDQeQ0LyyIwS77yDrPgc70m1AtIvdH6gVciMpzaZuaB0U5GKK48RA61+CoB
         km1SFaGOWVb1RI0ysu2jfsOYaxCQwm97f3ZusOjhaTOX7CjmOs+4bU5bAs4YBl6J+AWd
         zuWnp+KhjWOcK9Oe8T22zJ3yVCBVaXIe1+U7JotaoNBs2Wkz0vZ0FHcf+8Y/AX4pW1hT
         K81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zt5yG2/AIuh58baIFrL7CF1jcLSWp/+HZOTSJf5d7NQ=;
        b=0K/MWa6txRcTMN4QWpylty2Q3wb5bTiaBmX21v+MemQtGa1HsabZpxewoc9ey6HI/6
         4oGZ21/7vFFs8sxnOB7bCpKcdBPQDoGEJSu5Vks1TUC1sUVkKJBgENot6fL9wMirjxR8
         r4h1SeV9TMjWXFlek1HHUZ4u4j3q+QfbtGZK2Zxk8+xaKoB79Br7Kl/3C8chu6Ykw6bB
         8C1eeKXSZaYKQwHjyrH0Fe3461qfi1miL75Dkpp9k99n4ly+zZ/0zxzNl7+VQzsX3xzM
         /cg3mRIqnY6o5wuuDP9fsKVSV4dZhJKRU+6R9brJZkSymPacBAMfa4Uq7ZbHfbcKjJwS
         hIIg==
X-Gm-Message-State: AOAM531Cxqc5R8btS/3EG6qGEGCPjD+54IYqOQIlVXGTJYAj5ZD+5ntF
        wTkfjNcgtqPjhpTPDpAmPpCP
X-Google-Smtp-Source: ABdhPJxZc/BTEAuj9x5C2k3riOwaVUIb+L9Tl/2fOVKyvK7OzISMCizxK35I4A9itytUYdU8quoSgQ==
X-Received: by 2002:a17:902:ead1:b0:14f:a8e2:4005 with SMTP id p17-20020a170902ead100b0014fa8e24005mr18736546pld.10.1646026332549;
        Sun, 27 Feb 2022 21:32:12 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00158500b004f0f12b320asm12102353pfk.6.2022.02.27.21.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 21:32:12 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: endpoint: Use blocking notifier instead of atomic
Date:   Mon, 28 Feb 2022 11:01:59 +0530
Message-Id: <20220228053159.4946-1-manivannan.sadhasivam@linaro.org>
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
 drivers/pci/endpoint/pci-epc-core.c | 10 +++++-----
 include/linux/pci-epc.h             |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6120d99bff73..6ad9b38b63a9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -693,7 +693,7 @@ void pci_epc_linkup(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
+	blocking_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -710,7 +710,7 @@ void pci_epc_linkdown(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, LINK_DOWN, NULL);
+	blocking_notifier_call_chain(&epc->notifier, LINK_DOWN, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkdown);
 
@@ -727,7 +727,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+	blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
@@ -744,7 +744,7 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, BME, NULL);
+	blocking_notifier_call_chain(&epc->notifier, BME, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
 
@@ -808,7 +808,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 	mutex_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
-	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 8454610df4c3..7a5c7705f86f 100644
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
@@ -195,13 +195,13 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
 static inline int
 pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&epc->notifier, nb);
+	return blocking_notifier_chain_register(&epc->notifier, nb);
 }
 
 static inline int
 pci_epc_unregister_notifier(struct pci_epc *epc, struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&epc->notifier, nb);
+	return blocking_notifier_chain_unregister(&epc->notifier, nb);
 }
 
 struct pci_epc *
-- 
2.25.1

