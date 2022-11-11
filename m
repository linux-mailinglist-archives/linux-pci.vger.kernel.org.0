Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815D3625D00
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiKKO1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKKO1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:27:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418F1BB4;
        Fri, 11 Nov 2022 06:27:31 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N81Ck5sMrzbngJ;
        Fri, 11 Nov 2022 22:23:46 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 22:27:28 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jianjay.zhou@huawei.com>, <zhuangshengen@huawei.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <xiehong@huawei.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [RFC 4/4] pci/sriov: add sriov_scan_vf_id interface
Date:   Fri, 11 Nov 2022 22:27:22 +0800
Message-ID: <20221111142722.1172-5-longpeng2@huawei.com>
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

The users can add a specific VF through the sriov_scan_vf_id interface.

For example:
 echo 4 > /sys/bus/pci/devices/0000\:65\:00.0/sriov_scan_vf_id
 ( Add VF4 into the system. )

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 drivers/pci/iov.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index cb24d4b60e0d..2b585b3a9ad8 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -553,6 +553,51 @@ static ssize_t sriov_numvfs_no_scan_show(struct device *dev,
 	return sriov_numvfs_show(dev, attr, buf);
 }
 
+static ssize_t sriov_scan_vf_id_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 vf_id;
+	ssize_t ret;
+
+	if (kstrtou16(buf, 0, &vf_id) < 0)
+		return -EINVAL;
+
+	device_lock(&pdev->dev);
+
+	if (!pdev->sriov->num_VFs) {
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	if (vf_id >= pdev->sriov->num_VFs) {
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	if (test_bit(vf_id, pdev->sriov->vf_bitmap)) {
+		ret = -EEXIST;
+		goto exit;
+	}
+
+	device_unlock(&pdev->dev);
+
+	/* Already scanned VF0 when enabling VFs */
+	if (vf_id == 0)
+		return count;
+
+	ret = pci_iov_add_virtfn(pdev, vf_id);
+	if (ret < 0)
+		return ret;
+
+	return count;
+
+exit:
+	device_unlock(&pdev->dev);
+	return ret;
+}
+
 static ssize_t sriov_offset_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -607,6 +652,7 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
 static DEVICE_ATTR_RO(sriov_totalvfs);
 static DEVICE_ATTR_RW(sriov_numvfs);
 static DEVICE_ATTR_RW(sriov_numvfs_no_scan);
+static DEVICE_ATTR_WO(sriov_scan_vf_id);
 static DEVICE_ATTR_RO(sriov_offset);
 static DEVICE_ATTR_RO(sriov_stride);
 static DEVICE_ATTR_RO(sriov_vf_device);
@@ -616,6 +662,7 @@ static struct attribute *sriov_pf_dev_attrs[] = {
 	&dev_attr_sriov_totalvfs.attr,
 	&dev_attr_sriov_numvfs.attr,
 	&dev_attr_sriov_numvfs_no_scan.attr,
+	&dev_attr_sriov_scan_vf_id.attr,
 	&dev_attr_sriov_offset.attr,
 	&dev_attr_sriov_stride.attr,
 	&dev_attr_sriov_vf_device.attr,
-- 
2.23.0

