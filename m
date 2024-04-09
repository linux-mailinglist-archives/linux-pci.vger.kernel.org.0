Return-Path: <linux-pci+bounces-5918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07589D346
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CB6B23CEA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604227E574;
	Tue,  9 Apr 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kBIlOl2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F97E105;
	Tue,  9 Apr 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648086; cv=none; b=qWsthREPESos0/5/MAs5WIF3GDVnAVgMP4TS2RCZY7iJY/DcG85KWELi1mz/aAx1i9kzklIlxcpWvFzXj0yiSx7kO3gC/ZaMfVohD/lmTeHryP7KMuEh7UZxlFYr1EiJeMMhx0lJ0XthxNXx4UAdyPCrkzffknDoxm0sIY+9tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648086; c=relaxed/simple;
	bh=J3w0/ylkb4XiYg+NOVUCBlML1Xs+JJ1NLrEyKUxtTsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzJUWEgZI7khyNs3uHrzlf8j5GGFDw4Tn1Uzqo19SWbdvnGCNOGRbfOrE93JHvdlrQBnyglOrGMpzO0JUbtJrN2AMn1PuFzpUgq44OtkB0klrGBCk91gxR0w4jko9TIh68qV8EFdY7lTZlDCenuyKSZu8CJZ3o/EXNUI5xiCYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kBIlOl2/; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712648084; x=1744184084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3w0/ylkb4XiYg+NOVUCBlML1Xs+JJ1NLrEyKUxtTsc=;
  b=kBIlOl2/GeAVXj0EeSQ5Izo5xQT77mG/Ejow8SdDKGH0TsyyPAI+3+tT
   wWr5sO9WnIn7WtHk7n++7s6bnwMZIi3JRTN+WWjpxCDqXGumz/dSYdypN
   ZplT1RdKC9DQJK0VukP2vo+UHJS/F3Ab7FrqXzFx4yIke5iIRlyUUHwHJ
   CzxTzBCjwQBbySgyvD+k8VEjYN6Lb7aknj08CUlxlvxYUFU0DS838XWaf
   7kywr5/p37Vc9vddRA0TD2BNUnfN+rXFxoB/+OCDh7NAI0NOrL6GhQe8j
   A6+heO1ADEMv3C3ctfs9Fd5GIpkMY/eifxgZ4bsXZRBrx8nCChf8AYMdi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="133822738"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; 
   d="scan'208";a="133822738"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:33:31 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D38AE9A34;
	Tue,  9 Apr 2024 16:33:29 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B037D35C3E;
	Tue,  9 Apr 2024 16:33:28 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 85718204E19B;
	Tue,  9 Apr 2024 16:33:28 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	linux-pci@vger.kernel.org,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Tue,  9 Apr 2024 16:35:28 +0900
Message-ID: <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
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
the memory mapped register area. Critically, that arrangement makes the link
status and control registers invisible to existing PCI user tooling.

Export those registers via sysfs with the expectation that PCI user
tooling will alternatively look for these sysfs files when attempting to
access to these CXL 1.1 endpoints registers.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/pci.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..0ff15738b1ba 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -786,6 +786,79 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+static ssize_t rcd_link_cap_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct device *parent = dev->parent;
+	struct pci_dev *parent_pdev = to_pci_dev(parent);
+
+	port = cxl_pci_find_port(parent_pdev, &dport);
+	if (!port)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkcap);
+}
+static DEVICE_ATTR_RO(rcd_link_cap);
+
+static ssize_t rcd_link_ctrl_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct device *parent = dev->parent;
+	struct pci_dev *parent_pdev = to_pci_dev(parent);
+
+	port = cxl_pci_find_port(parent_pdev, &dport);
+	if (!port)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkctrl);
+}
+static DEVICE_ATTR_RO(rcd_link_ctrl);
+
+static ssize_t rcd_link_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct device *parent = dev->parent;
+	struct pci_dev *parent_pdev = to_pci_dev(parent);
+
+	port = cxl_pci_find_port(parent_pdev, &dport);
+	if (!port)
+		return -EINVAL;
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
@@ -969,6 +1042,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.44.0


