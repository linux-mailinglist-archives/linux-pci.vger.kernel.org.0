Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE7F70F2FD
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjEXJhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEXJgw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 05:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE170E7A
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 02:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8770E6101A
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 09:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8EC433EF;
        Wed, 24 May 2023 09:36:42 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kevin Tian <kevin.tian@intel.com>, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>
Subject: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
Date:   Wed, 24 May 2023 17:36:23 +0800
Message-Id: <20230524093623.3698134-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms (such as LoongArch) cannot provide enough irq numbers as
many as logical cpu numbers. So we should limit pci irq numbers when
allocate msi/msix vectors, otherwise some device drivers may fail at
initialization. This patch add a cmdline parameter "pci_irq_limit=xxxx"
to control the limit.

The default pci msi/msix number limit is defined 32 for LoongArch and
NR_IRQS for other platforms.

Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/msi/msi.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index ef1d8857a51b..6617381e50e7 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -402,12 +402,34 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	return ret;
 }
 
+#ifdef CONFIG_LOONGARCH
+#define DEFAULT_PCI_IRQ_LIMITS 32
+#else
+#define DEFAULT_PCI_IRQ_LIMITS NR_IRQS
+#endif
+
+static int pci_irq_limits = DEFAULT_PCI_IRQ_LIMITS;
+
+static int __init pci_irq_limit(char *str)
+{
+	get_option(&str, &pci_irq_limits);
+
+	if (pci_irq_limits == 0)
+		pci_irq_limits = DEFAULT_PCI_IRQ_LIMITS;
+
+	return 0;
+}
+
+early_param("pci_irq_limit", pci_irq_limit);
+
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 			   struct irq_affinity *affd)
 {
 	int nvec;
 	int rc;
 
+	maxvec = clamp_val(maxvec, 0, pci_irq_limits);
+
 	if (!pci_msi_supported(dev, minvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
 
@@ -776,7 +798,9 @@ static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *en
 int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
 			    int maxvec, struct irq_affinity *affd, int flags)
 {
-	int hwsize, rc, nvec = maxvec;
+	int hwsize, rc, nvec;
+
+	nvec = clamp_val(maxvec, 0, pci_irq_limits);
 
 	if (maxvec < minvec)
 		return -ERANGE;
-- 
2.39.1

