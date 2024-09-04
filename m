Return-Path: <linux-pci+bounces-12714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC596AEDC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 04:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7501F24E68
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 02:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208639AE3;
	Wed,  4 Sep 2024 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="V4Em4oeb"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71A10A12
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418692; cv=none; b=nH/fJ7GDchBjNSTgyCbwNWEEAY/IYECkuBF/1GTz8eNZYw5L8KiCLQa+EIfCj6NK2UBd+XM13q2PlEYrT76TQHqx7K0MDTHYA2tZKkHCveS5GSTCtUmEQtHPb9bzSCw++qT7Kmj1ZCdGt/cgAy9FBaEbpI3vcgcWRBwzk6TtVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418692; c=relaxed/simple;
	bh=by9RdirP/Jb4Aoul1O13/PTZDhBgVtR7sKW6j+/+jj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R05hNH4IqaE4Js51cwNOIBn4Sq6u408aAtdWhDojnpwJXVR9X6d4GKtNHHaj8WZJP95WXVJyoFzi4GuOdSoph1gWVoZtim5Y7KmEJqRQHqVbzt8kcC34DMZfRm3zKl7d8fw8aM11CLAWFhP66V6Bjm2JdJ6mr9x0gLrKc42/qzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=V4Em4oeb; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1725418690; x=1756954690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=by9RdirP/Jb4Aoul1O13/PTZDhBgVtR7sKW6j+/+jj4=;
  b=V4Em4oeb/uocu+LA56n6t6EZGDna9TvETiMLqKW3LoXHzcGG6BQwm324
   qwwNrUS4yhmvwgW9ofrzRvE4ptwp/ZCMURCbefMRFQ6/F9NOBKQxRp/3+
   tcF+7Khl4D6aEBc0sMXq3NS+qCNJWJX18kv8XkbtF/FVcPZOI4CivOEsJ
   BKyv544L1MsITIg589EhkQjNitueC3lRJoKXcC9/RFEtrYjrGLV/R3rDc
   yDrI/xVY+yjJgtfEM9tjnRhH7cldsD9+WpckJ1kIXiBBGaxuMc2SsV82k
   WCffpcr59oLwvlgZ6TI9lf9m/1ufPHEeS0W/SiaE1cO2LBjnlJNoBghSb
   g==;
X-CSE-ConnectionGUID: 5pyo54bcSJ+HfR6dkj7XVA==
X-CSE-MsgGUID: FgKdFPtPQaascKYuLJO+xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="152059814"
X-IronPort-AV: E=Sophos;i="6.10,200,1719846000"; 
   d="scan'208";a="152059814"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 11:58:02 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BF508DAD30
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 11:57:58 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C00BCFA5D
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 11:57:58 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 0858C2005340;
	Wed,  4 Sep 2024 11:57:58 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v2] Export PBEC Data register into sysfs
Date: Wed,  4 Sep 2024 12:00:35 +0900
Message-ID: <20240904030035.284423-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

This proposal aims to add a feature that outputs PCIe device power 
consumption information to sysfs.

Add support for PBEC (Power Budgeting Extended Capability) output 
to the PCIe driver. PBEC is defined in the 
PCIe specification(PCIe r6.0, sec 7.8.1) and is
a standard method for obtaining device power consumption information.

PCIe devices can significantly impact the overall power consumption of
a system. However, obtaining PCIe device power consumption information 
has traditionally been difficult. 

The PBEC Data register changes depending on the value of the PBEC Data 
Select register. To obtain all PBEC Data register values defined in the 
device, obtain the value of the PBEC Data register while changing the 
value of the PBEC Data Select register.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/pci/pci-sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2321fdfefd7d..468c929a9347 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t power_budget_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	size_t len = 0;
+	int i, pos;
+	u32 data;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return -EINVAL;
+
+	for (i = 0; i < 0xff; i++) {
+		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
+		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+		if (!data) {
+			if (len == 0)
+				return -EINVAL;
+			break;
+		}
+		len += sysfs_emit_at(buf, len, "%04x\n", data);
+	}
+
+	return len;
+}
+static DEVICE_ATTR_RO(power_budget);
+
 static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_power_budget.attr,
 	NULL,
 };
 
-- 
2.45.0


