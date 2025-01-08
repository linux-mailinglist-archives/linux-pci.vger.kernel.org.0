Return-Path: <linux-pci+bounces-19543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF6A05DA2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3709D1882230
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD11FCCF3;
	Wed,  8 Jan 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kx15iy0l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FD1514F8
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344556; cv=none; b=jLGyUuNcpz+gvusn61KfQotiqOCof8/+5PermeajleTSrkgBhOpXqJVTJeGJeBZRix8b88YHYONhjTBRYRXtJPrD7fYq6g6oH/U4APjkYLSG5HvyBEPcDHPxaZw7vgEsSWnHrKzFocM6pH3AZ4gNJ4fUHLF1ITiFS0n0JH5ViwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344556; c=relaxed/simple;
	bh=GRiIT5pvwD31mvZyR0X6blzW3J8WpkGphNv+YVNMVQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcIvD56hpBhenDreiYAco9pHlzLtUQfN5uEQ9MyPAue9qSt/BJtB2B5/55DLxTtIMUe7uf3z1J0zeZMCtaA1lXhPcqfPz1nkr5NaX3ZgLzHyt36GdTUl92QTSuCOzf6AoqC3D6+CTkjIZo1XW+65V7oEeILffRcev4xxgXgRg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kx15iy0l; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081tpC9015719;
	Wed, 8 Jan 2025 13:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=HSGZe
	4lY7VIrUUYET6MDemMEQV7I2+pvJCFHu2LOc9s=; b=kx15iy0ldXLvrs3iwcnmm
	vAYIAOBV1ozqT3L+8ZunpfInBB+H2cSU1ZmaJ+1dcFYngFxmbPEMnwb3KZQ31ZQJ
	Z8G5MMVooE3QprfWg+D3O5z1bii3WRyNTOeG0W1xmPyt2lqubTWb4tcPmaLMRPPB
	aLRVXTf8HLsj+cHmTam6inBZMwmOEOsMzBIXoCWCrcqF559yxV6s9CmJcmK1thNM
	BFdHi+spFEor1B9sPuCwji0f0KWGxZfU4+4b1Ep5O8FnCxjeza3j63b1CwgJlOLH
	Xy7qpsBdEH1yvHgyBUG0/EzJrfYQsStapKNI4sTpgXXvCPJySYsBwrLIm+97IjcA
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb6w72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508CS9b7027327;
	Wed, 8 Jan 2025 13:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea1gc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 508Dtjx4011911;
	Wed, 8 Jan 2025 13:55:51 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43xuea1g3k-5;
	Wed, 08 Jan 2025 13:55:51 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>
Subject: [PATCH RESEND 4/4] PCI: Add 'cor_err_reporting_enable' attribute
Date: Wed,  8 Jan 2025 13:55:34 +0000
Message-ID: <2c0fb509158d31b89f9a3faa099efa956967c011.1736341506.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736341506.git.karolina.stolarek@oracle.com>
References: <cover.1736341506.git.karolina.stolarek@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_03,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080115
X-Proofpoint-GUID: BW2GzQVqM5cYf_VRmWcMi5tNzn8z__nS
X-Proofpoint-ORIG-GUID: BW2GzQVqM5cYf_VRmWcMi5tNzn8z__nS

In some cases, the number of Correctable Error messages is overwhelming,
and even with the rate limit imposed, they fill up the logs. The system
cannot do much about such errors, so a user might wish to silence them
completely.

Add a sysfs attribute to control reporting of the Correctable Error
Messages per device.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  7 +++++
 drivers/pci/pci-sysfs.c                 | 42 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5da6a14dc326..dba72ee37ce4 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -479,6 +479,13 @@ Description:
 		The file is writable if the PF is bound to a driver that
 		implements ->sriov_set_msix_vec_count().
 
+What:		/sys/bus/pci/devices/.../cor_err_reporting_enable
+Date:		December 2024
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This file exposes a bit to control sending of Correctable Error
+		Messages. The value comes from the Device Control register.
+
 What:		/sys/bus/pci/devices/.../resourceN_resize
 Date:		September 2022
 Contact:	Alex Williamson <alex.williamson@redhat.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6f1bb7514efb..f7f0d7971ad7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -186,6 +186,47 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t cor_err_reporting_enable_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 reg;
+	int err;
+
+	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &reg);
+
+	if (err)
+		return pcibios_err_to_errno(err);
+
+	return sysfs_emit(buf, "%u\n", reg & PCI_EXP_DEVCTL_CERE);
+}
+
+static ssize_t cor_err_reporting_enable_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 reg;
+	u8 val;
+	int err;
+
+	if (kstrtou8(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &reg);
+
+	reg &= ~PCI_EXP_DEVCTL_CERE;
+	reg |= val;
+	err = pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, reg);
+
+	if (err)
+		return pcibios_err_to_errno(err);
+
+	return count;
+}
+static DEVICE_ATTR_RW(cor_err_reporting_enable);
+
 static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -659,6 +700,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_cor_err_reporting_enable.attr,
 	NULL,
 };
 
-- 
2.43.5


