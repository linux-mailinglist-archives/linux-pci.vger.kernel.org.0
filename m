Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8D516AAF
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiEBGKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 02:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383424AbiEBGKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 02:10:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D574EF49
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 23:06:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z16so11555937pfh.3
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FL4JimMUhmY1BeTMTK+TnPmU576KVxmETjweuyLuCOo=;
        b=OFXE66pE/ktWSt/5voVeEhMhzzjJ3ORO0W5OjxJds9qw+k7j2EG9ORxSHmD5i8yEm5
         nC9O4KPZiYx+rv4InxZiPdWLN2X4hDs0DhNp1k2iT/ZeAFpAmYyTDJIBCYb9udtNrq+G
         xPCzCRXZ2b+LgvRYHNkcR98uDFeQdjZNhZ9q7kZSRWU2Z0MDzV3ZeYTHPoWoNpv7+fQs
         cky8tLry5aLxOdICsNscsAYGlpDeRdlIcFXEG11VuGjhzJ9+YMFlhmiwe7E7yb13rf+H
         4HE25MLXBrJ52iZQPuL9A9rrp+85ZdIa9POCM2WQQBOBUr8zfcQh0BR8L4/uAdM8Mxz6
         4TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FL4JimMUhmY1BeTMTK+TnPmU576KVxmETjweuyLuCOo=;
        b=rg8iLMDwTYiqS38r5vQolJi3L58DnU3UDNhnRJnrTay/V12S6dC+h73s4BQNQGHm3P
         5ze+z4dxp9p6ju9PocjSjLMW6NllGj+6Sn2RRU8bS/O1kzJaKElotMYe6DmVUAp8PNlU
         frFMMuy4OUGz7i19y3+hLZ0nPhE7cWrYGpJzMNk1DVIu8LED8HRZDtQsBv6u6vnkYrn5
         Ik98CX/yWXePHkmPdWUwqIFFj8Vw2bH4No2jQPi3t02WZ/BpeNxNw7ya6wcm/M5/1vAM
         Z6sBrgWpSJqkGMDyHpZs80DREtEvW0OPB6MSjleNKbJUTeSFgq5X2+ibGrFcbPJymhCu
         9P6Q==
X-Gm-Message-State: AOAM530lHV15XsAWCm3AJgh0WBwsETQ8BBQpJPhCh19L4+e3ylN+w6Wv
        aLjN/tL+NHy1BIOsaEa8bkk3
X-Google-Smtp-Source: ABdhPJxb6iPxT001JHILmsfK5SvyQcjtft+sZmMyKCsyzDQDauyPZCbU2PiXuVxii4Sz+RFpxlBhLQ==
X-Received: by 2002:a62:e518:0:b0:4fa:9333:ddbd with SMTP id n24-20020a62e518000000b004fa9333ddbdmr10156182pff.11.1651471596890;
        Sun, 01 May 2022 23:06:36 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm3933826pfn.91.2022.05.01.23.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 23:06:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/8] PCI: endpoint: Add linkdown notifier support
Date:   Mon,  2 May 2022 11:36:07 +0530
Message-Id: <20220502060611.58987-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
References: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the linkdown event from the
EPC device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 17 +++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..8401c2750c9e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -697,6 +697,23 @@ void pci_epc_linkup(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
+/**
+ * pci_epc_linkdown() - Notify the EPF device that EPC device has dropped the
+ *			connection with the Root Complex.
+ * @epc: the EPC device which has dropped the link with the host
+ *
+ * Invoke to Notify the EPF device that the EPC device has dropped the
+ * connection with the Root Complex.
+ */
+void pci_epc_linkdown(struct pci_epc *epc)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, LINK_DOWN, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_epc_linkdown);
+
 /**
  * pci_epc_init_notify() - Notify the EPF device that EPC device's core
  *			   initialization is completed.
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c414a08bfd67..d346ab9ae061 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -215,6 +215,7 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 0c94cc1513bc..b1fcd88d0b1f 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -20,6 +20,7 @@ enum pci_epc_interface_type;
 enum pci_notify_event {
 	CORE_INIT,
 	LINK_UP,
+	LINK_DOWN,
 };
 
 enum pci_barno {
-- 
2.25.1

