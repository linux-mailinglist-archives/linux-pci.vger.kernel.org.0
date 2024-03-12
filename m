Return-Path: <linux-pci+bounces-4744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AAF878F64
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 09:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F24281C83
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C66997C;
	Tue, 12 Mar 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hLuXymeF"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2669D27;
	Tue, 12 Mar 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230618; cv=none; b=VTcTByz+VTMFn7rcAl0tvZwaqaBpEKrniN1ksKQO91JPFmYiuq0ML47W1nFffBfJ9rj+54MuvY02mQe3SJIClLtnB6sqECBTWHVGVf60MxMX2DuGQWDUPfDqYTKHKrhhXPsBr6tm5xanjtzaAHVHOasSMIDM4l+ELfFT5cRRdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230618; c=relaxed/simple;
	bh=93hyZud3vcQZs2ffGam3on1ad+lH6NbUD2RKxJY+hlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S83JY73inCh7QxuyOv2MTNaS7lFmVJgHZz2AMJcxaVJTFv0+FnABp/uQ0xP41nTQHt0n/pxKqpEjI/dUr/Yv1RK+uJZCuu05iBPhzhp85nSu+10EYhTi+GpSHTFVmFl6bnADl5vApXs0epWI5LJ+i6dOiwSsATVAkSTojT8m7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hLuXymeF; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710230615; x=1741766615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93hyZud3vcQZs2ffGam3on1ad+lH6NbUD2RKxJY+hlM=;
  b=hLuXymeFFEUglI20Y4SGeTnZjAy/arw+mjaxriL5+bG0yZCrTdMj+Msm
   40e4+83g3d3CqdjWAJgUf5j2C0coanJiQ1r5P9tvPTh8xgIMZOtmhu4gH
   grKmahAmhCw53G0HZME8s6ETZ5OJzZFRx2X33iSKHzNx7W+9R4ckmTubV
   k4M7l/WACpnLMdDNFVlcbe8l7osZ9Sl+OWOl0GL6bxoLw039PTJWD5bmf
   OoKw6Lz5u0PAcTDoaLhVcWUwb0zEnd8IWUUxOGpdiA4qsawnMomSbEgoU
   1wI99bSCRQgVlbJcyJkSgJcWUYRmc9s6d8pEu3BGPZ6ATAXIKrKFmyRn4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="152270008"
X-IronPort-AV: E=Sophos;i="6.07,118,1708354800"; 
   d="scan'208";a="152270008"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:03:25 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 73565D4802;
	Tue, 12 Mar 2024 17:03:23 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A01D3FD84A;
	Tue, 12 Mar 2024 17:03:22 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 66D6A20059BA;
	Tue, 12 Mar 2024 17:03:22 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Date: Tue, 12 Mar 2024 17:05:57 +0900
Message-ID: <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/pci.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4fd1f207c84e..8f66f80a7bdc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -781,6 +781,195 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+static u8 cxl_rcrb_get_pcie_cap_offset(void __iomem *addr){
+	u8 offset;
+	u32 cap_hdr;
+
+	offset = readb(addr + PCI_CAPABILITY_LIST);
+	cap_hdr = readl(addr + offset);
+	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
+		offset = (cap_hdr >> 8) & 0x000000ff;
+		if (offset == 0) // End of capability list
+			return 0;
+		cap_hdr = readl(addr + offset);
+	}
+	return offset;
+
+}
+
+static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t rcrb)
+{
+	void __iomem *addr;
+	u8 offset;
+	u32 linkcap;
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
+	offset = cxl_rcrb_get_pcie_cap_offset(addr);
+	if (offset)
+		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
+	else
+		goto out;
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
+	u8 offset;
+	u16 linkctrl;
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
+	offset = cxl_rcrb_get_pcie_cap_offset(addr);
+	if (offset)
+		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
+	else
+		goto out;
+
+	linkctrl = readw(addr + offset + PCI_EXP_LNKCTL);
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
+	u8 offset;
+	u16 linksta;
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
+	offset = cxl_rcrb_get_pcie_cap_offset(addr);
+	if (offset)
+		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
+	else
+		goto out;
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
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -806,6 +995,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
+	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
+	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
+	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);
 	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->rcd = is_cxl_restricted(pdev);
@@ -967,6 +1159,7 @@ static struct pci_driver cxl_pci_driver = {
 	.err_handler		= &cxl_error_handlers,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups	= cxl_rcd_groups,
 	},
 };
 
-- 
2.43.0


