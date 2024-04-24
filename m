Return-Path: <linux-pci+bounces-6607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E0C8B00BE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 06:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB728411F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 04:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEC715443B;
	Wed, 24 Apr 2024 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CFU16qSi"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF304328DB;
	Wed, 24 Apr 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934730; cv=none; b=D4aWc6zWgf3AIJPGdHyCDBo59pMl5HEVzNjSRiI8mapZMss0invRLecVDsphyybEEyocDpmxoSCd4NZSnN+t3jsnppFRLSIvBCb+tWfGwPqeTS2G2JEtUe6fbWPH5uV+kK0VyFlEnMBDff5PYNy2v9DnwfOkBSXzR9K1fVC8EbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934730; c=relaxed/simple;
	bh=D7UyNDqPHiQq41A1G/ELD4v22j7VF9aHGVynSyNdsas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBTYHXwBqq6EefNe60r2+WOP4nHvF9b+ywkaVai4rfDD8EVVHuQ4U2DRjyNuZbupvntlUSo5qe0jKsHpWyLyW6r9MdyVaeB37XFlEi6HVzHhjXTBlnKzTKjvUusD+6YamBzaado5zZaBzVeBA04+9qZ0mqyovq/FQ9wSKRkpFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CFU16qSi; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713934727; x=1745470727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D7UyNDqPHiQq41A1G/ELD4v22j7VF9aHGVynSyNdsas=;
  b=CFU16qSiJ6qc43YAwPvug5OVhEmzCuUTn5nIpB2/c0a/hSFPUTrLR586
   eJ15X841DWvY8YXVzFzTuG7vPV/8UKpCSEnLJOZcOmN9kmD/l/ZTPOOcL
   DXCtMuh+17aMCYOCbEPIQlg+ofqmZLxLVj+fjNT8z4turZLEmopCMixkJ
   AbwOAhU58aQ8umr8uTJDFTqRaJlvaSbplz1rcfDd1qNT4kKZnMPW0O2Na
   rxOkbL73//k3ER88I06F9wWaxkR4btLLzgWFS345Q+1FtckPWKCoVkGvC
   E2kMVqwWcnwx/DzLyzoYOGMgAScblXtPBYIwB1LRImQoh1VETPksy/RfS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="156805551"
X-IronPort-AV: E=Sophos;i="6.07,225,1708354800"; 
   d="scan'208";a="156805551"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:58:38 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BA6EAE8DAE;
	Wed, 24 Apr 2024 13:58:36 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id ECEF831B07;
	Wed, 24 Apr 2024 13:58:35 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id AF44220059A9;
	Wed, 24 Apr 2024 13:58:35 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v6 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Wed, 24 Apr 2024 14:01:02 +0900
Message-ID: <20240424050102.26788-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424050102.26788-1-kobayashi.da-06@fujitsu.com>
References: <20240424050102.26788-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.

In CXL1.1, the link status of the device is included in the RCRB mapped to
the memory mapped register area. Critically, that arrangement makes the
link status and control registers invisible to existing PCI user tooling.

Export those registers via sysfs with the expectation that PCI user
tooling will alternatively look for these sysfs files when attempting to
access to these CXL 1.1 endpoints registers.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/pci.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..c10797adde2c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -786,6 +786,106 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+static ssize_t rcd_link_cap_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	port = cxl_mem_find_port(cxlmd, &dport);
+	if (!port)
+		return -EINVAL;
+
+	endpoint_parent = port->uport_dev;
+	if (!endpoint_parent)
+		return -ENXIO;
+
+	guard(device)(endpoint_parent);
+	if (!endpoint_parent->driver)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkcap);
+}
+static DEVICE_ATTR_RO(rcd_link_cap);
+
+static ssize_t rcd_link_ctrl_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	port = cxl_mem_find_port(cxlmd, &dport);
+	if (!port)
+		return -EINVAL;
+
+	endpoint_parent = port->uport_dev;
+	if (!endpoint_parent)
+		return -ENXIO;
+
+	guard(device)(endpoint_parent);
+	if (!endpoint_parent->driver)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkctrl);
+}
+static DEVICE_ATTR_RO(rcd_link_ctrl);
+
+static ssize_t rcd_link_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	port = cxl_mem_find_port(cxlmd, &dport);
+	if (!port)
+		return -EINVAL;
+
+	endpoint_parent = port->uport_dev;
+	if (!endpoint_parent)
+		return -ENXIO;
+
+	guard(device)(endpoint_parent);
+	if (!endpoint_parent->driver)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkstatus);
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
+__ATTRIBUTE_GROUPS(cxl_rcd);
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -969,6 +1069,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.44.0


