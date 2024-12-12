Return-Path: <linux-pci+bounces-18293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB59EE8C3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47AE1888F9C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF02153C3;
	Thu, 12 Dec 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QxtHhaRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E82153D2
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013669; cv=none; b=kkzD2G2W/KeR612kfpIa8/exvgXSLVIynRuaqV12bntudLu4fNu2qioicV61HY+tgLmoAKCNlb/dV+AcxZBtloDlvDwiXxF99EiVAkBRZZ+SwMAX17aobJAj8aRhsUAEC0rseynPXRDstF8tKacXWtQj1QWZL8H/6jiv2kDqnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013669; c=relaxed/simple;
	bh=GRiIT5pvwD31mvZyR0X6blzW3J8WpkGphNv+YVNMVQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM5VMibyxP2ou3uJpJHq9hFFp5jBsMzP4DaTZNR4r+zUQUAkT01x3U3XXaEcLj0doBf+1GAEhNby5CKBXf/yHQWQ/lZf/gaXqhcEw70P/2R42+wUogCyY28NenDXXIXv7h5gyDmpnpjhv6r9uUYjIsv9D5EbeXrtxdoZ0BqIE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QxtHhaRf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCWuJK021240;
	Thu, 12 Dec 2024 14:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=HSGZe
	4lY7VIrUUYET6MDemMEQV7I2+pvJCFHu2LOc9s=; b=QxtHhaRfwu9uxo4uOrR+N
	9SA4W37Z8jcc6r8OTBUStituRvvOJiSaPfbwCuUYoSO+DdzGIgmXVTI7SjABlgSk
	FoLm3L8FVP3xyl3METLWw854FX9ItGv7h7dyQJ4olljpwMqHj/txLlS2mMY5XEZw
	i37bCUl6qdp3Gx+CKAsPUdhRDf61h5PK5rv+nZLTrQsuUT1Dv0l/pEKw/BSQDhCd
	rAl6fRjjKSfWTTzwT2CTtvcCQRZyjKq54QOAjaZaq4xkg24khvXMwXvSj8CShngK
	OAVN8ZOnOabFWoTe/OOJH9yGpHfA3rv/B+9URMJJeqIlvlrlPhc0CqGGsPtFNdD8
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89b1vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 14:27:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDD4bf038147;
	Thu, 12 Dec 2024 14:27:44 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43cctht4wt-5;
	Thu, 12 Dec 2024 14:27:43 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC 4/4] PCI: Add 'cor_err_reporting_enable' attribute
Date: Thu, 12 Dec 2024 14:27:32 +0000
Message-ID: <79d9894fd866714cbce7438390924f2622448d69.1734005191.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734005191.git.karolina.stolarek@oracle.com>
References: <cover.1734005191.git.karolina.stolarek@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120104
X-Proofpoint-GUID: RuPbTHaLxXLxJRzD5p27MuF8s-opuDS3
X-Proofpoint-ORIG-GUID: RuPbTHaLxXLxJRzD5p27MuF8s-opuDS3

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


