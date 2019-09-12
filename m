Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756AFB0C0F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfILJ5B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 05:57:01 -0400
Received: from mx.socionext.com ([202.248.49.38]:43784 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbfILJ5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 05:57:01 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Sep 2019 18:57:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 53CB6180077;
        Thu, 12 Sep 2019 18:57:00 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 12 Sep 2019 18:57:00 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id D975E1A04FC;
        Thu, 12 Sep 2019 18:56:59 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] PCI: endpoint: Fix clearing start entry in configfs
Date:   Thu, 12 Sep 2019 18:56:51 +0900
Message-Id: <1568282211-24713-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value of 'start' entry is no change whenever writing 0 to configfs.
So the endpoint that stopped once can't restart.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 1 +
 1 file changed, 1 insertion(+)

Since the possibility of restarting endpoint is up to each controller,
if restart is prohibited on purpose for some reason, this patch can be
ignored.

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d1288a0..4fead88 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -58,6 +58,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 
 	if (!start) {
 		pci_epc_stop(epc);
+		epc_group->start = 0;
 		return len;
 	}
 
-- 
2.7.4

