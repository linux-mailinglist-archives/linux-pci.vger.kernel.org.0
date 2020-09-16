Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B66F26BCA6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIPGVB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 02:21:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbgIPGU4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 02:20:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9333F9C127C521A72810;
        Wed, 16 Sep 2020 14:20:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:46 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] PCI: rpadlpar: use for_each_child_of_node() and for_each_node_by_name
Date:   Wed, 16 Sep 2020 14:21:28 +0800
Message-ID: <20200916062128.190819-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use for_each_child_of_node() and for_each_node_by_name macro
instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index f979b7098..0a3c80ba6 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -40,13 +40,13 @@ static DEFINE_MUTEX(rpadlpar_mutex);
 static struct device_node *find_vio_slot_node(char *drc_name)
 {
 	struct device_node *parent = of_find_node_by_name(NULL, "vdevice");
-	struct device_node *dn = NULL;
+	struct device_node *dn;
 	int rc;
 
 	if (!parent)
 		return NULL;
 
-	while ((dn = of_get_next_child(parent, dn))) {
+	for_each_child_of_node(parent, dn) {
 		rc = rpaphp_check_drc_props(dn, drc_name, NULL);
 		if (rc == 0)
 			break;
@@ -60,10 +60,10 @@ static struct device_node *find_vio_slot_node(char *drc_name)
 static struct device_node *find_php_slot_pci_node(char *drc_name,
 						  char *drc_type)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 	int rc;
 
-	while ((np = of_find_node_by_name(np, "pci"))) {
+	for_each_node_by_name(np, "pci") {
 		rc = rpaphp_check_drc_props(np, drc_name, drc_type);
 		if (rc == 0)
 			break;
-- 
2.23.0

