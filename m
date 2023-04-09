Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AD76DC12D
	for <lists+linux-pci@lfdr.de>; Sun,  9 Apr 2023 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDITQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Apr 2023 15:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDITQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Apr 2023 15:16:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D92697
        for <linux-pci@vger.kernel.org>; Sun,  9 Apr 2023 12:16:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l8-20020a252508000000b00b8c009b9341so8986214ybl.18
        for <linux-pci@vger.kernel.org>; Sun, 09 Apr 2023 12:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681067812;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ljKEFp+m5lCMmz1N98vjgXQQW2tr/lts9JuzP7U0RuI=;
        b=duOEW3HAKFM4M6Nrfms9s+CyTdnAFwOKKBxqZ08VQeNRpvSLup+8z3NB+ItqNHB+7F
         EUoXpG0rsZABYi3ITpNHbifpKkoFQ6UpPKHUn2WabgB9xpkS0hvsfy9j475SzsktABWF
         JpJsOSruFqg7tVJ1HEpFyllLuGDbmV3lswWeNSghrC70AkWGWmRZmiB8VRQs7a/AH7VG
         btq8x+obr5SdGznzMhvINAqsyuDyjH7RbRBcxExR/BdZik+SBcGdan9/GJFxIWHKor1F
         R+ik1EK14wQQnqvCiRT5vgzyp8YnoIe1RzbkwNpknghYG+BWQBn4jMkZnvOKN+mi3lLO
         0JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681067812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljKEFp+m5lCMmz1N98vjgXQQW2tr/lts9JuzP7U0RuI=;
        b=plge7/5CUakmjz2jWNKsmqpdAt8ifQ0DkcuREVGovjz+x+Pc6Y0zYSft/4ZB3sGsFj
         wgzpdUHldjizgBA4tloOyHJG5mJyql88aT2baBfM7u6nZhhSPLS3dnH4bsQmy2T0VY6s
         xbSj52bxDa2RRCy6f8fqFEtltfhW0PLpqlE3f30b7k4b9J9B3JE8d0mZlgcY6LI7E9P9
         zeb+F5tFYZdZkLM+pIK2z5TXV8PuAv3UBvqspMo/PxbqXRYtk27GOUYEQj/bf7/dSNuZ
         vZbmhu9UqHhw9EW6F2saGENNKPANd/y+Fu5zj/jjklZzN9QCUhO/C72hBnf37lDE5au/
         rD5A==
X-Gm-Message-State: AAQBX9eaZ/tevlYAbfxJ0FRFcf0YB+fQoIxaC5yGC6CHioTexvtql7ZD
        F/opE32z2Dn4+vv+L0hS0ZSJ6pQdaKybH9TcHh+GAJRgEZfGpbiZLhGTo1gL1+KRIGMeBO8+SdN
        SeYrzEX3wFKjq3d9ougJ9A9M=
X-Google-Smtp-Source: AKy350a9H5GWAC1wKaQ4XxJU6T9mWijZ9OQU8H5A1R6W3mbmtDT9OX5eWHanm2ANizl1Tu7+OZGmpVl4MzYh4NF0XA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:ad22:0:b0:54d:8263:d509 with SMTP
 id l34-20020a81ad22000000b0054d8263d509mr4550843ywh.2.1681067812757; Sun, 09
 Apr 2023 12:16:52 -0700 (PDT)
Date:   Mon, 10 Apr 2023 00:46:27 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230409191627.2786149-1-ajayagarwal@google.com>
Subject: [PATCH v3] PCI: dwc: Wait for link up only if link is started
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>, nikhilnd@google.com,
        manugautam@google.com, Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>,
        William McVicker <willmcvicker@google.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In dw_pcie_host_init() regardless of whether the link has been
started or not, the code waits for the link to come up. Even in
cases where start_link() is not defined the code ends up spinning
in a loop for 1 second. Since in some systems dw_pcie_host_init()
gets called during probe, this one second loop for each pcie
interface instance ends up extending the boot time.

Wait for the link up in only if the start_link() is defined.

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
- Wait for the link up if start_link() is really defined.
- Print the link status if the link is up on init.

 drivers/pci/controller/dwc/pcie-designware-host.c | 15 ++++++++------
 drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..39c7219ec7c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -485,15 +485,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
-	if (!dw_pcie_link_up(pci)) {
-		ret = dw_pcie_start_link(pci);
+	ret = dw_pcie_start_link(pci);
+	if (ret)
+		goto err_remove_edma;
+
+	if (dw_pcie_link_up(pci)) {
+		dw_pcie_print_link_status(pci);
+	} else if (pci->ops && pci->ops->start_link) {
+		ret = dw_pcie_wait_for_link(pci);
 		if (ret)
-			goto err_remove_edma;
+			goto err_stop_link;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
-
 	bridge->sysdata = pp;
 
 	ret = pci_host_probe(bridge);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..03748a8dffd3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
-int dw_pcie_wait_for_link(struct dw_pcie *pci)
+void dw_pcie_print_link_status(struct dw_pcie *pci)
 {
 	u32 offset, val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+
+	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
+		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
+		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+}
+
+int dw_pcie_wait_for_link(struct dw_pcie *pci)
+{
 	int retries;
 
 	/* Check if the link is up or not */
@@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-
-	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
-		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
-		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+	dw_pcie_print_link_status(pci);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..615660640801 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+void dw_pcie_print_link_status(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-- 
2.40.0.577.gac1e443424-goog

