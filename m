Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E806B3FD2C8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 07:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbhIAFRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 01:17:10 -0400
Received: from mx.socionext.com ([202.248.49.38]:8845 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240774AbhIAFRI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 01:17:08 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Sep 2021 14:16:11 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id BB8182059036;
        Wed,  1 Sep 2021 14:16:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 1 Sep 2021 14:16:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 540D0B62B7;
        Wed,  1 Sep 2021 14:16:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: register notifier if only core_init_notifier is enabled
Date:   Wed,  1 Sep 2021 14:16:00 +0900
Message-Id: <1630473361-27198-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Need to register pci_epf_test_notifier function even if only
core_init_notifier is enabled.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3..80456ad 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -874,7 +874,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		epf_test->dma_supported = false;
 
-	if (linkup_notifier) {
+	if (linkup_notifier || core_init_notifier) {
 		epf->nb.notifier_call = pci_epf_test_notifier;
 		pci_epc_register_notifier(epc, &epf->nb);
 	} else {
-- 
2.7.4

