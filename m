Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D861A625D01
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiKKO1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiKKO1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:27:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A47C12;
        Fri, 11 Nov 2022 06:27:31 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N81HV1c9rzHvp9;
        Fri, 11 Nov 2022 22:27:02 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 22:27:27 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jianjay.zhou@huawei.com>, <zhuangshengen@huawei.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <xiehong@huawei.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [RFC 3/4] pci/sriov: add sriov_numfs_no_scan interface
Date:   Fri, 11 Nov 2022 22:27:21 +0800
Message-ID: <20221111142722.1172-4-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20221111142722.1172-1-longpeng2@huawei.com>
References: <20221111142722.1172-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Add sriov_numfs_no_scan interface, we can enable the sriov without
adding all VFs immediately.

For example:
 echo 16 > /sys/bus/pci/devices/0000\:65\:00.0/sriov_numvfs_no_scan
 ( Enable 16 VFs, but not add it to the system. )

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 drivers/pci/iov.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 886489aae0de..cb24d4b60e0d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -491,6 +491,68 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	return count;
 }
 
+static ssize_t sriov_numvfs_no_scan_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+	u16 num_vfs;
+
+	if (kstrtou16(buf, 0, &num_vfs) < 0)
+		return -EINVAL;
+
+	device_lock(&pdev->dev);
+	/* Clear the flag when disabling VFs */
+	pdev->no_vf_scan = num_vfs ? 1 : 0;
+	device_unlock(&pdev->dev);
+
+	ret = sriov_numvfs_common(pdev, num_vfs);
+	if (ret < 0)
+		goto fail;
+
+	if (!num_vfs)
+		return count;
+
+	/*
+	 * Special case: set the same num_vfs again.
+	 */
+	if (test_bit(0, pdev->sriov->vf_bitmap))
+		return count;
+
+	/*
+	 * Default to enabling VF0, we need to read some config registers that are the
+	 * same across all associated VFs. See pci_read_vf_config_common().
+	 */
+	ret = pci_iov_add_virtfn(pdev, 0);
+	if (ret < 0) {
+		int rc;
+
+		rc = sriov_numvfs_common(pdev, 0);
+		if (rc < 0)
+			pci_warn(pdev, "Roll back to SR-IOV disabled state failed, %d\n", rc);
+
+		goto fail;
+	}
+
+	return count;
+
+fail:
+	device_lock(&pdev->dev);
+	if (pdev->no_vf_scan)
+		pdev->no_vf_scan = 0;
+	device_unlock(&pdev->dev);
+
+	return ret;
+}
+
+static ssize_t sriov_numvfs_no_scan_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sriov_numvfs_show(dev, attr, buf);
+}
+
 static ssize_t sriov_offset_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -544,6 +606,7 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
 
 static DEVICE_ATTR_RO(sriov_totalvfs);
 static DEVICE_ATTR_RW(sriov_numvfs);
+static DEVICE_ATTR_RW(sriov_numvfs_no_scan);
 static DEVICE_ATTR_RO(sriov_offset);
 static DEVICE_ATTR_RO(sriov_stride);
 static DEVICE_ATTR_RO(sriov_vf_device);
@@ -552,6 +615,7 @@ static DEVICE_ATTR_RW(sriov_drivers_autoprobe);
 static struct attribute *sriov_pf_dev_attrs[] = {
 	&dev_attr_sriov_totalvfs.attr,
 	&dev_attr_sriov_numvfs.attr,
+	&dev_attr_sriov_numvfs_no_scan.attr,
 	&dev_attr_sriov_offset.attr,
 	&dev_attr_sriov_stride.attr,
 	&dev_attr_sriov_vf_device.attr,
-- 
2.23.0

