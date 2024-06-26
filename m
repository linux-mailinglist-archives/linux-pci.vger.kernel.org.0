Return-Path: <linux-pci+bounces-9262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11191777E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 06:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E8AB21D18
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86A13D635;
	Wed, 26 Jun 2024 04:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HikR2f6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E513AD11
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376914; cv=none; b=Njb3E0wQNKGY3eFqciM2MleS+NA7AaprFayK06wBe5VyLC3sEk/Viyr/P2n2qLPH485AubN89n9MfXltcwa9XjPY9cIdk86PMJ8OV9NOxAL9HxMrJBlEuMBt2CihUaNdup4rp4uYPpEeoYO0cJXLILsl5+1luJCgDsqm31S0xng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376914; c=relaxed/simple;
	bh=mb/MY4IbFc/sJoOl6YAyEq4RGKOzzkGN9YxEwyOd8bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHvHqhVaE69ga7CscxX4de7Djv6Dk8rD5mqK6/R8NXUybDUuiW6AIDIhnQDah2rCFh3Q9jlBnUZA15HwokcTpxMN0Fw63wIgy/JjuGfOAP+T/8U65DcKnCRIqUgQcLyb0cYXzXeNSgidjzdJISxSAP3zUD78oAiLxKP4+D4FIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HikR2f6V; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1719376911; x=1750912911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mb/MY4IbFc/sJoOl6YAyEq4RGKOzzkGN9YxEwyOd8bc=;
  b=HikR2f6Vh9m+eu+YKEB/QWkWmdC9LAiGJUGWf5hfSGpIdID1BFmg8WH+
   1eeqmpTcjEcMEo5IaJZwYCgxWgtokfEY9WleOj4mF4ZM3i2BUah7MNyA3
   42mi1VU5bPpbggstyQFuK/fIUo2mLZLBUgm9vnj25oGQviD/3uH2PDVUB
   qTzzZ5VGwIA1GzDtUoR+j3IRRadUEQK42ctyS2wiC6bydw1zAwgPV1onu
   +N2L7kc1YJx5pkZMyswCvGpTzsaO4IT5pfX+AeO6+OC5B3lWSF9ioa5UO
   AR5eVAI3Re3fmBCPSzLnG+gaicuCGz1tqGaUhp3FbrNnwI16o6xJU8a0X
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="153245457"
X-IronPort-AV: E=Sophos;i="6.08,265,1712588400"; 
   d="scan'208";a="153245457"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 13:40:40 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4B5C0C9443
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 13:40:38 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A2771D3F20
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 13:40:37 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 8A3EB2005975;
	Wed, 26 Jun 2024 13:40:37 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-pci@vger.kernel.org
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [RFC PATCH v1] Export PBEC Data register into sysfs
Date: Wed, 26 Jun 2024 13:43:30 +0900
Message-ID: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
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

This feature can be implemented by adding support for PBEC (Power 
Budgeting Extended Capability) output to the PCIe driver. PBEC is 
defined in the PCIe specification(7.8.1) and is a standard method for
obtaining device power consumption information.

PCIe devices can significantly impact the overall power consumption of
a system. However, obtaining PCIe device power consumption information 
has traditionally been difficult. This is because the 'lspci' command, 
which is a standard tool for displaying information about PCI devices, 
cannot access PBEC information. `lspci` is a standard tool for displaying
information about PCI devices.

The PBEC Data register changes depending on the value of the PBEC Data 
Select register. To obtain all PBEC Data register values defined in the 
device, obtain the value of the PBEC Data register while changing the 
value of the PBEC Data Select register.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/pci/pci-sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2321fdfefd7d..b13d30da38a1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t pbec_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	size_t len = 0;
+	int i, pos;
+	u32 data;
+
+	if (!pci_is_pcie(pci_dev))
+		return 0;
+
+	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
+	if (!pos)
+		return 0;
+
+	for (i = 0; i < 0xff; i++) {
+		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
+		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
+		if (!data)
+			break;
+		len += sysfs_emit_at(buf, len, "%04x\n", data);
+	}
+
+	return len;
+}
+static DEVICE_ATTR_RO(pbec);
+
 static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_pbec.attr,
 	NULL,
 };
 
-- 
2.44.0


