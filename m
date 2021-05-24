Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2F38E7DD
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhEXNmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 09:42:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5542 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhEXNmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 09:42:38 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpdZf3QVBzwSrd;
        Mon, 24 May 2021 21:38:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 21:41:07 +0800
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 14:41:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, Fangjian <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 1/5] PCI: Add vendor ID for the PCI SIG
Date:   Mon, 24 May 2021 21:39:34 +0800
Message-ID: <20210524133938.2815206-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This ID is used in DOE headers to identify protocols that are defined
within the PCI Express Base Specification.

Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4c3fa5293d76..dcc8b4b14198 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -149,6 +149,7 @@
 #define PCI_CLASS_OTHERS		0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
+#define PCI_VENDOR_ID_PCI_SIG		0x0001
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
-- 
2.19.1

