Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1921F127AF0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 13:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLTMYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 07:24:43 -0500
Received: from mx.socionext.com ([202.248.49.38]:46531 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfLTMYn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 07:24:43 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Dec 2019 21:24:41 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id E610C18008B;
        Fri, 20 Dec 2019 21:24:41 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 20 Dec 2019 21:25:28 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A4D241A01CF;
        Fri, 20 Dec 2019 21:24:41 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH RESEND] PCI: endpoint: Fix clearing start entry in configfs
Date:   Fri, 20 Dec 2019 21:24:37 +0900
Message-Id: <1576844677-24933-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value of 'start' entry is no change whenever writing 0 to configfs.
So the endpoint that stopped once can't restart.

The following command lines are an example restarting endpoint and
reprogramming configurations after receiving bus-reset.

    echo 0 > controllers/66000000.pcie-ep/start
    rm controllers/66000000.pcie-ep/func1
    ln -s functions/pci_epf_test/func1 controllers/66000000.pcie-ep/
    echo 1 > controllers/66000000.pcie-ep/start

However, the first 'echo' can't set 0 to 'start', so the last 'echo' can't
restart endpoint.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 1 +
 1 file changed, 1 insertion(+)

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

