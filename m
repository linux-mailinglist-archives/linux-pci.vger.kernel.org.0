Return-Path: <linux-pci+bounces-4088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DBF868ACA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 09:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD87282B12
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371567A73A;
	Tue, 27 Feb 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="guTBRE1Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8C7A723;
	Tue, 27 Feb 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022720; cv=none; b=BF4Ci/FwzzJPotUrenVoiBBDCDqyeRS1cSaTpMtW+/wNyhzuevXgHUAY68VhImFnluo2gfZjueqY7QLuzFjSfeg2p+oUTDSCINJGzG8Y3Y4bf6UjV8r2AYHCF13Hh8uKqhKY3odHEGx7ridBMZWi7nRAtwGJqHj1c+S8htrzfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022720; c=relaxed/simple;
	bh=MdImde67V1+KeHYJRF9wIvQoZwXcoa6xLwBzOuoI9Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H40Tyd4Jkm7pU/eFEKfvI2BL/CXN09GMKqvy2sP+tqpi9zIXvjalBdmTjy4sRTNVPYWx/VMTiCnGCoVA56+qT3niJhwyyKI1NHGkwGx+S9CC25tD0LX6ONhUyU035CzbVZ/uJG/UkMW8Lc9HVzQ3lNFg5IgfDsz0VYIS6LdQV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=guTBRE1Z; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709022716; x=1740558716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MdImde67V1+KeHYJRF9wIvQoZwXcoa6xLwBzOuoI9Cw=;
  b=guTBRE1ZdtQZukir9J9DBY3puCno7UcBr6wHn29IoczdlGZKLgwo+VXZ
   iQewiybMu/DAHJyvUaQIfSZ6NrXF860kkxXewskvFO+CCAZ3X2CX73+cR
   eWi1XiOKRggaA+81xojifGVlesWQOdBli4ShwkOq2tZQf7f4V57rRU0oA
   i+U35+Tx4knaZ7/SmFG6pSmmBbXZ/oMnE8y3yJDARu9KwOb6HEuUUINgv
   dPrqy0zuA0twBEU7MJDPcDPdXhIg13srPSvVRVBCtTpCm9MbjWRbETuLw
   7qIHkxi1PCpYqVS8KuHGWQeyjDRCe1Fn70xdvs269KZ/M4CHeJIklAxgz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="152321666"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; 
   d="scan'208";a="152321666"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 17:30:45 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9DF6D1590F3;
	Tue, 27 Feb 2024 17:30:44 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C5E2E6E01A;
	Tue, 27 Feb 2024 17:30:43 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 8BBFD20C19DC;
	Tue, 27 Feb 2024 17:30:43 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH v2 1/3] Add sysfs attribute for CXL 1.1 device link status
Date: Tue, 27 Feb 2024 17:33:11 +0900
Message-ID: <20240227083313.87699-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
References: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

This patch implements a process to output the link status information 
of the CXL1.1 device to sysfs. The values of the registers related to 
the link status are outputted into three separate files.

In CXL1.1, the link status of the device is included in the RCRB mapped to
the memory mapped register area. This function accesses the address where
the device's RCRB is mapped.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/pci.c | 201 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4fd1f207c84e..8302249819d0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -780,6 +780,203 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 
 	return 0;
 }
+static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t rcrb)
+{
+	void __iomem *addr;
+	u8 offset = 0;
+	u32 cap_hdr;
+	u32 linkcap = 0;
+
+	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
+		return 0;
+
+	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
+		return 0;
+
+	addr = ioremap(rcrb, SZ_4K);
+	if (!addr)
+		goto out;
+
+	offset = readw(addr + PCI_CAPABILITY_LIST);
+	offset = offset & 0x00ff;
+	cap_hdr = readl(addr + offset);
+	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
+		offset = (cap_hdr >> 8) & 0x000000ff;
+		if (!offset)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+
+	if (offset)
+		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
+
+	linkcap = readl(addr + offset + PCI_EXP_LNKCAP);
+	iounmap(addr);
+out:
+	release_mem_region(rcrb, SZ_4K);
+
+	return linkcap;
+}
+
+static ssize_t rcd_link_cap_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct device *parent = dev->parent;
+	struct pci_dev *parent_pdev = to_pci_dev(parent);
+	u32 linkcap;
+
+	port = cxl_pci_find_port(parent_pdev, &dport);
+	if (!port)
+		return -EINVAL;
+
+	linkcap = cxl_rcrb_to_linkcap(dev, dport->rcrb.base + SZ_4K);
+	return sysfs_emit(buf, "%x\n", linkcap);
+}
+static DEVICE_ATTR_RO(rcd_link_cap);
+
+static u16 cxl_rcrb_to_linkctr(struct device *dev, resource_size_t rcrb)
+{
+	void __iomem *addr;
+	u8 offset = 0;
+	u16 linkctrl = 0;
+	u32 cap_hdr;
+
+	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
+		return 0;
+
+	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
+		return 0;
+
+	addr = ioremap(rcrb, SZ_4K);
+	if (!addr)
+		goto out;
+
+	offset = readw(addr + PCI_CAPABILITY_LIST);
+	offset = offset & 0x00ff;
+	cap_hdr = readl(addr + offset);
+	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
+		offset = (cap_hdr >> 8) & 0x000000ff;
+		if (!offset)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+
+	if (offset)
+		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
+	linkctrl = readw(addr + offset + PCI_EXP_LNKCTL);
+
+	iounmap(addr);
+out:
+	release_mem_region(rcrb, SZ_4K);
+
+	return linkctrl;
+}
+
+static ssize_t rcd_link_ctrl_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct device *parent = dev->parent;
+	struct pci_dev *parent_pdev = to_pci_dev(parent);
+	u16 linkctrl;
+
+	port = cxl_pci_find_port(parent_pdev, &dport);
+	if (!port)
+		return -EINVAL;
+
+
+	linkctrl = cxl_rcrb_to_linkctr(dev, dport->rcrb.base + SZ_4K);
+
+	return sysfs_emit(buf, "%x\n", linkctrl);
+}
+static DEVICE_ATTR_RO(rcd_link_ctrl);
+
+static u16 cxl_rcrb_to_linkstatus(struct device *dev, resource_size_t rcrb)
+{
+	void __iomem *addr;
+	u8 offset = 0;
+	u16 linksta = 0;
+	u32 cap_hdr;
+
+	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
+		return 0;
+
+	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
+		return 0;
+
+	addr = ioremap(rcrb, SZ_4K);
+	if (!addr)
+		goto out;
+
+	offset = readw(addr + PCI_CAPABILITY_LIST);
+	offset = offset & 0x00ff;
+	cap_hdr = readl(addr + offset);
+	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
+		offset = (cap_hdr >> 8) & 0x000000ff;
+		if (!offset)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+
+	if (offset)
+		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
+
+	linksta = readw(addr + offset + PCI_EXP_LNKSTA);
+	iounmap(addr);
+out:
+	release_mem_region(rcrb, SZ_4K);
+
+	return linksta;
+}
+
+static ssize_t rcd_link_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct device *parent = dev->parent;
+	struct pci_dev *parent_pdev = to_pci_dev(parent);
+	u16 linkstatus;
+
+	port = cxl_pci_find_port(parent_pdev, &dport);
+	if (!port)
+		return -EINVAL;
+
+
+	linkstatus = cxl_rcrb_to_linkstatus(dev, dport->rcrb.base + SZ_4K);
+
+	return sysfs_emit(buf, "%x\n", linkstatus);
+}
+static DEVICE_ATTR_RO(rcd_link_status);
+
+static struct attribute *cxl_rcd_attrs[] = {
+		&dev_attr_rcd_link_cap.attr,
+		&dev_attr_rcd_link_ctrl.attr,
+		&dev_attr_rcd_link_status.attr,
+		NULL
+};
+
+static umode_t cxl_rcd_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (is_cxl_restricted(pdev))
+		return a->mode;
+
+	return 0;
+}
+
+static struct attribute_group cxl_rcd_group = {
+		.attrs = cxl_rcd_attrs,
+		.is_visible = cxl_rcd_visible,
+};
+
+__ATTRIBUTE_GROUPS(cxl_rcd);
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -806,6 +1003,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
+	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
+	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
+	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);
 	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->rcd = is_cxl_restricted(pdev);
@@ -967,6 +1167,7 @@ static struct pci_driver cxl_pci_driver = {
 	.err_handler		= &cxl_error_handlers,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups	= cxl_rcd_groups,
 	},
 };
 
-- 
2.43.0


