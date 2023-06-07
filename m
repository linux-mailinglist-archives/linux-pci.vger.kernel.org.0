Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897B0725A81
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjFGJc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbjFGJcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 05:32:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010431720;
        Wed,  7 Jun 2023 02:32:53 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QbhrY6sgPzLqYS;
        Wed,  7 Jun 2023 17:29:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 17:32:51 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <jonathan.cameron@huawei.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v5 1/5] hwtracing: hisi_ptt: Factor out filter allocation and release operation
Date:   Wed, 7 Jun 2023 17:31:19 +0800
Message-ID: <20230607093123.51421-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230607093123.51421-1-yangyicong@huawei.com>
References: <20230607093123.51421-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Factor out the allocation and release of filters. This will make it easier
to extend and manage the function of the filter.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 63 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 30f1525639b5..548cfef51ace 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -354,6 +354,39 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 	return 0;
 }
 
+static void hisi_ptt_del_free_filter(struct hisi_ptt *hisi_ptt,
+				      struct hisi_ptt_filter_desc *filter)
+{
+	list_del(&filter->list);
+	kfree(filter);
+}
+
+static struct hisi_ptt_filter_desc *
+hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, struct pci_dev *pdev)
+{
+	struct hisi_ptt_filter_desc *filter;
+
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter) {
+		pci_err(hisi_ptt->pdev, "failed to add filter for %s\n",
+			pci_name(pdev));
+		return NULL;
+	}
+
+	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	filter->is_port = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT;
+	if (filter->is_port) {
+		list_add_tail(&filter->list, &hisi_ptt->port_filters);
+
+		/* Update the available port mask */
+		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(filter->devid, true);
+	} else {
+		list_add_tail(&filter->list, &hisi_ptt->req_filters);
+	}
+
+	return filter;
+}
+
 static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
 {
 	struct pci_dev *root_port = pcie_find_root_port(pdev);
@@ -374,23 +407,9 @@ static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
 	 * should be partial initialized and users would know which filter fails
 	 * through the log. Other functions of PTT device are still available.
 	 */
-	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
-	if (!filter) {
-		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
+	filter = hisi_ptt_alloc_add_filter(hisi_ptt, pdev);
+	if (!filter)
 		return -ENOMEM;
-	}
-
-	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
-
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
-		filter->is_port = true;
-		list_add_tail(&filter->list, &hisi_ptt->port_filters);
-
-		/* Update the available port mask */
-		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(filter->devid, true);
-	} else {
-		list_add_tail(&filter->list, &hisi_ptt->req_filters);
-	}
 
 	return 0;
 }
@@ -400,15 +419,11 @@ static void hisi_ptt_release_filters(void *data)
 	struct hisi_ptt_filter_desc *filter, *tmp;
 	struct hisi_ptt *hisi_ptt = data;
 
-	list_for_each_entry_safe(filter, tmp, &hisi_ptt->req_filters, list) {
-		list_del(&filter->list);
-		kfree(filter);
-	}
+	list_for_each_entry_safe(filter, tmp, &hisi_ptt->req_filters, list)
+		hisi_ptt_del_free_filter(hisi_ptt, filter);
 
-	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list) {
-		list_del(&filter->list);
-		kfree(filter);
-	}
+	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list)
+		hisi_ptt_del_free_filter(hisi_ptt, filter);
 }
 
 static int hisi_ptt_config_trace_buf(struct hisi_ptt *hisi_ptt)
-- 
2.24.0

