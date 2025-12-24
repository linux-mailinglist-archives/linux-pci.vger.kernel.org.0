Return-Path: <linux-pci+bounces-43649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F2ACDBBBA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C75723007693
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1818314A7E;
	Wed, 24 Dec 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JrRlnldj"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FE30B529;
	Wed, 24 Dec 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566907; cv=none; b=YX64qAGDbvLJ6Jgxk7rCMgyRi5QjsbrlaMviAipVdddEgYmKSqFU7LUexZ6dFEH6I8oDt886Ftpyu+Hkud00gizilwlMKI/BT0GnOIuP78D2I8hanRnqFCyXf6d8cboX8eVoRhBI1voOBd09HvNbigVeTNp5vC5TRHAgXkGRwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566907; c=relaxed/simple;
	bh=IdhHESCbfV4q37Zk9vcG4CJ1b0S9nmD+dObf1YGwhrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQI83Pt1pkIunIsP69V6vf6D2KkP2o+naxQTIEEyx49kuF0SLcDRTsokczR6lhQDv3xKg941SD8IZTyLif/j6pb4CRAZSiJm4EAV72rZayHXddxcmXIhRZly4Vp1DMiOLd7+0eeh1a9w9/ey5NPtFGSPVQvI1lqtMZSd0gJ60eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JrRlnldj; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3zzZNBQowhMsIB/7RZytqeIdQImGje7POVm8OpbwEG4=;
	b=JrRlnldjD12qHhlyDRBsCCHXi5N6xT6c4SKTN0L1nEBVDHkCE5neZxU1ghIl3+apUebH81G+h
	W3g9qCRryXk/9svbNIg6w1gZbLDiuGwakbSLu5zd3jsBxAuI6i2Ny3J5bQ1ogI1gxbqqm0fN+Fc
	jktXraLJqKNEUT1QhHNYQK0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dbm4h69cxz12LKW;
	Wed, 24 Dec 2025 16:58:28 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 43C7320104;
	Wed, 24 Dec 2025 17:01:41 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 17:01:40 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>, <chrisw@redhat.com>,
	<alex.williamson@redhat.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 1/3] PCI/sysfs: Fix null pointer dereference during hotplug
Date: Wed, 24 Dec 2025 17:27:17 +0800
Message-ID: <20251224092721.2034529-2-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224092721.2034529-1-duziming2@huawei.com>
References: <20251224092721.2034529-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500012.china.huawei.com (7.202.195.23)

During the concurrent process of creating and rescanning in VF, the
resource files for the same pci_dev may be created twice. The second
creation attempt fails, resulting the res_attr in pci_dev to kfree(),
but the pointer is not set to NULL. This will subsequently lead to
dereferencing a null pointer when removing the device.

When we perform the following operation:
  echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &
  sleep 0.5
  echo 1 > /sys/bus/pci/rescan
  pci_remove "$pfname"
system will crash as follows:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Call trace:
   __pi_strlen+0x14/0x150
   kernfs_find_ns+0x54/0x120
   kernfs_remove_by_name_ns+0x58/0xf0
   sysfs_remove_bin_file+0x24/0x38
   pci_remove_resource_files+0x44/0x90
   pci_remove_sysfs_dev_files+0x28/0x40
   pci_stop_bus_device+0xb8/0x118
   pci_stop_and_remove_bus_device+0x20/0x40
   pci_iov_remove_virtfn+0xb8/0x138
   sriov_disable+0xbc/0x190
   pci_disable_sriov+0x30/0x48
   hinic_pci_sriov_disable+0x54/0x138 [hinic]
   hinic_remove+0x140/0x290 [hinic]
   pci_device_remove+0x4c/0xf8
   device_remove+0x54/0x90
   device_release_driver_internal+0x1d4/0x238
   device_release_driver+0x20/0x38
   pci_stop_bus_device+0xa8/0x118
   pci_stop_and_remove_bus_device_locked+0x28/0x50
   remove_store+0x128/0x208

Fix this by set the pointer to NULL after releasing res_attr immediately.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2df915ad2d2..7e697b82c5e1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1222,12 +1222,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr[i] = NULL;
 		}
 
 		res_attr = pdev->res_attr_wc[i];
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr_wc[i] = NULL;
 		}
 	}
 }
-- 
2.43.0


