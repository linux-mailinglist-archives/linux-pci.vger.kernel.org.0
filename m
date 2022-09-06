Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0E5AF7D7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIFWYc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIFWYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:24:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E5AA37A;
        Tue,  6 Sep 2022 15:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C3FBB81AAC;
        Tue,  6 Sep 2022 22:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52FEC433C1;
        Tue,  6 Sep 2022 22:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503046;
        bh=JiLQVQZBxN5nRTMlR7cEglY0khs6D7MoN1CEw3gMigY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WB/Q/NGNxNddoHQZVZnZ49FOmWp0IHWFoYWk8jnMiTy3qwlpYySJ/m34isSAP38/v
         p4cDMYCxZWrY498gXfajG5pAummooJHA7LICDLDdyRvhzQNYuZbD2T2MOsu5gl2QBZ
         NP524JN2QOFsL7jcfNnHMQvVhICL4c+HqQ/d3hfIVQJcsNern9p99hRMRKJZyrsS7L
         iiRsBKbr+MCaP3z2UHgarMwy9zQ/6n1voHtQjhYTDj9COoKpQRz42BlemYwscF9VuH
         CQns395hbUc3wCGHBxyEVOLDOIYcQuogbVtzNPF6qhtYHC2AHQwAChQPLjIRb240oI
         1WxXcZogNOwmw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 06/10] PCI/PTM: Add pci_enable_ptm() wrapper
Date:   Tue,  6 Sep 2022 17:23:47 -0500
Message-Id: <20220906222351.64760-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906222351.64760-1-helgaas@kernel.org>
References: <20220906222351.64760-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Implement pci_enable_ptm() as a wrapper around an internal
__pci_enable_ptm() that we can use during resume to enable PTM without
emitting log messages.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 762299984469..4a9f045126ca 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -152,7 +152,7 @@ void pci_ptm_init(struct pci_dev *dev)
 		pci_enable_ptm(dev, NULL);
 }
 
-int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+static int __pci_enable_ptm(struct pci_dev *dev)
 {
 	int ptm = dev->ptm_cap;
 	struct pci_dev *ups;
@@ -177,6 +177,17 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 		ctrl |= PCI_PTM_CTRL_ROOT;
 
 	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
+	return 0;
+}
+
+int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+{
+	int rc;
+
+	rc = __pci_enable_ptm(dev);
+	if (rc)
+		return rc;
+
 	dev->ptm_enabled = 1;
 
 	pci_ptm_info(dev);
-- 
2.25.1

