Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1233648A6
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbhDSQ6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 12:58:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2885 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhDSQ6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 12:58:01 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FPCV30fR9z68Bs6;
        Tue, 20 Apr 2021 00:50:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 18:57:30 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 17:57:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH v3 4/4] cxl/mem: Add a debug parser for CDAT commands
Date:   Tue, 20 Apr 2021 00:54:51 +0800
Message-ID: <20210419165451.2176200-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logs a pretty printed version of the CDAT table entries at driver load.

I find this helpful for development, so including as an extra patch
that I would suggest is never merged.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 v3: renames to match changes in doe function naming.
 
 drivers/cxl/mem.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 32354d443f2e..b357dba9048b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1042,6 +1042,104 @@ static int cdat_to_buffer(struct pci_doe *doe, u32 *buffer, size_t length)
 	return 0;
 }
 
+static int cdat_dump(struct pci_doe *doe)
+{
+	struct pci_dev *dev = doe->pdev;
+	int entry_handle = 0;
+	int rc;
+
+	if (doe == NULL)
+		return 0;
+
+	dev = doe->pdev;
+	do {
+		/* Table access is available */
+		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
+		u32 cdat_response_pl[32];
+		struct pci_doe_exchange ex = {
+			.vid = PCI_DVSEC_VENDOR_ID_CXL,
+			.protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+			.request_pl = &cdat_request_pl,
+			.request_pl_sz = sizeof(cdat_request_pl),
+			.response_pl = cdat_response_pl,
+			.response_pl_sz = sizeof(cdat_response_pl),
+		};
+		u32 *entry;
+
+		rc = pci_doe_exchange_sync(doe, &ex);
+		if (rc < 0)
+			return rc;
+
+		/* Skip past table response header */
+		entry = cdat_response_pl + 1;
+		if (entry_handle == 0) {
+			pci_info(dev,
+				 "CDAT Header (Length=%u, Revision=%u, Checksum=0x%x, Sequence=%u\n",
+				 entry[0],
+				 FIELD_GET(CDAT_HEADER_DW1_REVISION, entry[1]),
+				 FIELD_GET(CDAT_HEADER_DW1_CHECKSUM, entry[1]),
+				 entry[2]);
+		} else {
+			u8 entry_type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, entry[0]);
+
+			switch (entry_type) {
+			case CDAT_STRUCTURE_DW0_TYPE_DSMAS:
+				pci_info(dev,
+					 "CDAT DSMAS (handle=%u flags=0x%x, dpa(0x%llx 0x%llx)\n",
+					 FIELD_GET(CDAT_DSMAS_DW1_DSMAD_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSMAS_DW1_FLAGS, entry[1]),
+					 CDAT_DSMAS_DPA_OFFSET(entry),
+					 CDAT_DSMAS_DPA_LEN(entry));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSLBIS:
+				pci_info(dev,
+					 "CDAT DSLBIS (handle=%u flags=0x%x, ent_base=0x%llx, entry[%u %u %u])\n",
+					 FIELD_GET(CDAT_DSLBIS_DW1_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSLBIS_DW1_FLAGS, entry[1]),
+					 CDAT_DSLBIS_BASE_UNIT(entry),
+					 FIELD_GET(CDAT_DSLBIS_DW4_ENTRY_0, entry[4]),
+					 FIELD_GET(CDAT_DSLBIS_DW4_ENTRY_1, entry[4]),
+					 FIELD_GET(CDAT_DSLBIS_DW5_ENTRY_2, entry[5]));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSMSCIS:
+				pci_info(dev,
+					 "CDAT DSMSCIS (handle=%u sc_size=0x%llx attrs=0x%x)\n",
+					 FIELD_GET(CDAT_DSMSCIS_DW1_HANDLE, entry[1]),
+					 CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry),
+					 FIELD_GET(CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS,
+						   entry[4]));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSIS:
+				pci_info(dev,
+					 "CDAT DSIS (handle=%u flags=0x%x)\n",
+					 FIELD_GET(CDAT_DSIS_DW1_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSIS_DW1_FLAGS, entry[1]));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_DSEMTS:
+				pci_info(dev,
+					 "CDAT DSEMTS (handle=%u EFI=0x%x dpa(0x%llx 0x%llx)\n",
+					 FIELD_GET(CDAT_DSEMTS_DW1_HANDLE, entry[1]),
+					 FIELD_GET(CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR,
+						   entry[1]),
+					 CDAT_DSEMTS_DPA_OFFSET(entry),
+					 CDAT_DSEMTS_DPA_LENGTH(entry));
+				break;
+			case CDAT_STRUCTURE_DW0_TYPE_SSLBIS:
+				pci_info(dev,
+					 "CDAT SSLBIS (type%u ent_base=%llu...)\n",
+					 FIELD_GET(CDAT_SSLBIS_DW1_DATA_TYPE,
+						   entry[1]),
+					 CDAT_SSLBIS_BASE_UNIT(entry));
+				break;
+			}
+		}
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
+					 cdat_response_pl[0]);
+	} while (entry_handle != 0xFFFF);
+
+	return 0;
+}
+
 static void cxl_mem_free_irq_vectors(void *data)
 {
 	pci_free_irq_vectors(data);
@@ -1136,6 +1234,10 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 	cxlm->table_doe = pci_doe_find(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 				       CXL_DOE_PROTOCOL_TABLE_ACCESS);
 
+	rc = cdat_dump(cxlm->table_doe);
+	if (rc)
+		return NULL;
+
 	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
 	return cxlm;
 }
-- 
2.27.0

