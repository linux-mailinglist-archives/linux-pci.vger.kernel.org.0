Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF84AB170
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 05:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfIFD62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 23:58:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38541 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbfIFD62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 23:58:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id w11so2458373plp.5
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2019 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZNViCP0N32DHFiUhZ1GT+X+dOsTn4cyOWa7lJoIVdEI=;
        b=AXfYOfO0nGdxTFvFA7g0aGzz0arsdR5meyAvEGBw6nC3K67QP0Ra7Uk5EVbjWL3/8z
         bWLSvw9aR6b/xweX585dT3l7yJ/s9nlYMCd/Z8U42n0mGBzCI5yusHShTAoCbh+wRly8
         eP2Ik++ors6kq2CxzobNcYIckfffB4q9lI4u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZNViCP0N32DHFiUhZ1GT+X+dOsTn4cyOWa7lJoIVdEI=;
        b=h1o+JMvIiaWlmuJy9ubKahO7N6k6SCRkTdxdXoS/4hzYMcteWpRq8TmdLKMZRw45+b
         y0lgYYwNYTmNhWjnxOX5VVMNhHfgXS7DZjq5pJNlc84S7UkJTCAypFeTgGFNmpJfoArj
         Pcc4rxw2cS3PricCPbikW1iAWRZcJOuODucwoAcgHyClw/TUGCPBhxn/suSfVnDOekYf
         p74rEsZaC066tFdfnt6Kug+Bk09cCsPwmSwYCjIiRa2YNLnyqXPVQgh3FTgtT0GBssbB
         lctfVIYzNdmR0n7A1J6bmVK6DUVu2AgckQ2XWwFKDcFKz2YTioYrRyr63T/pJGPHOUTv
         ciAA==
X-Gm-Message-State: APjAAAW8B88g5dKMbkvWg84w2UQwhpnP7/E+ypRfp8PUbQfupbmd4SXX
        1+mQArA3caTrkxGKTHz5WkAhAA==
X-Google-Smtp-Source: APXvYqy3UPGT19hWhmdlkeWD30hDNsKTu1kGQ8bZGVywyq175psYPAMutrsptQzkk73s2qaqbfANzg==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr7049132plb.93.1567742307277;
        Thu, 05 Sep 2019 20:58:27 -0700 (PDT)
Received: from ashah1-OptiPlex-7010.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b5sm6748512pfp.38.2019.09.05.20.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 20:58:26 -0700 (PDT)
From:   Abhishek Shah <abhishek.shah@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Abhishek Shah <abhishek.shah@broadcom.com>
Subject: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before programming it
Date:   Fri,  6 Sep 2019 09:28:13 +0530
Message-Id: <20190906035813.24046-1-abhishek.shah@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Invalidate PAXB inbound/outbound address mapping each time before
programming it. This is helpful for the cases where we need to
reprogram inbound/outbound address mapping without resetting PAXB.
kexec kernel is one such example.

Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index e3ca46497470..99a9521ba7ab 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1245,6 +1245,32 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 	return ret;
 }
 
+static void iproc_pcie_invalidate_mapping(struct iproc_pcie *pcie)
+{
+	struct iproc_pcie_ib *ib = &pcie->ib;
+	struct iproc_pcie_ob *ob = &pcie->ob;
+	int idx;
+
+	if (pcie->ep_is_internal)
+		return;
+
+	if (pcie->need_ob_cfg) {
+		/* iterate through all OARR mapping regions */
+		for (idx = ob->nr_windows - 1; idx >= 0; idx--) {
+			iproc_pcie_write_reg(pcie,
+					     MAP_REG(IPROC_PCIE_OARR0, idx), 0);
+		}
+	}
+
+	if (pcie->need_ib_cfg) {
+		/* iterate through all IARR mapping regions */
+		for (idx = 0; idx < ib->nr_regions; idx++) {
+			iproc_pcie_write_reg(pcie,
+					     MAP_REG(IPROC_PCIE_IARR0, idx), 0);
+		}
+	}
+}
+
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
 			       struct device_node *msi_node,
 			       u64 *msi_addr)
@@ -1517,6 +1543,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	iproc_pcie_perst_ctrl(pcie, true);
 	iproc_pcie_perst_ctrl(pcie, false);
 
+	iproc_pcie_invalidate_mapping(pcie);
+
 	if (pcie->need_ob_cfg) {
 		ret = iproc_pcie_map_ranges(pcie, res);
 		if (ret) {
-- 
2.17.1

