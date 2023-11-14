Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9087EB146
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjKNN4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 08:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjKNN4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 08:56:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13043D4D;
        Tue, 14 Nov 2023 05:56:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2BFC433C9;
        Tue, 14 Nov 2023 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699970193;
        bh=ccp3ogSsb4odknXliurziQtdOSnVHJBmXHc1B6Tc75s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqjCpx50IAiQYCU9k/IfgDPeIhFv+9uWmWFC6j2KoAkGQmt2kEAeY29cU/peo05pd
         mhPyqxa1sMwBW46MTeju7iHCWPFWOvJv6N6K5ZBrldwxnYVuvva41K+vR2H9s9+Ucw
         z5SFcCofn3ybaamOymSBoMfR7oVVcjqZzIvF7Dg7Byb9NnWwu6QBdGa/JwEVLrnxTi
         E6YJejE+CF7P272F1nJyC0QGl2ojxS98dzoyuIhUcOEHtIFtbApWpXkNRGLvOZsC9A
         oX/1obd0/Q3XG7FsvQO4lcQ8aP9MDLvnUFV3T+44UlhgnB6dZVxhE3r48J75wNi+iP
         P/FJXHIESqxuA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r2tu2-0008PX-3C;
        Tue, 14 Nov 2023 14:56:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/6] PCI/ASPM: Clean up disable link state parameter
Date:   Tue, 14 Nov 2023 14:55:52 +0100
Message-ID: <20231114135553.32301-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114135553.32301-1-johan+linaro@kernel.org>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the current 'sem' parameter to the __pci_disable_link_state()
helper with a more descriptive 'locked' parameter, which indicates
whether a pci_bus_sem read lock is already held.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pcie/aspm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 8cf8cc2d6bba..19b7256d2dc9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1041,7 +1041,7 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
 	return bridge->link_state;
 }
 
-static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
+static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
@@ -1060,7 +1060,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		return -EPERM;
 	}
 
-	if (sem)
+	if (!locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	if (state & PCIE_LINK_STATE_L0S)
@@ -1082,7 +1082,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		link->clkpm_disable = 1;
 	pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	mutex_unlock(&aspm_lock);
-	if (sem)
+	if (!locked)
 		up_read(&pci_bus_sem);
 
 	return 0;
@@ -1090,7 +1090,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
-	return __pci_disable_link_state(pdev, state, false);
+	return __pci_disable_link_state(pdev, state, true);
 }
 EXPORT_SYMBOL(pci_disable_link_state_locked);
 
@@ -1105,7 +1105,7 @@ EXPORT_SYMBOL(pci_disable_link_state_locked);
  */
 int pci_disable_link_state(struct pci_dev *pdev, int state)
 {
-	return __pci_disable_link_state(pdev, state, true);
+	return __pci_disable_link_state(pdev, state, false);
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
-- 
2.41.0

