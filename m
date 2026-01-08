Return-Path: <linux-pci+bounces-44240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCBD008F2
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 02:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2621D300E7DD
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 01:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1C288D6;
	Thu,  8 Jan 2026 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="G2U+uf3e"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C22221DAC;
	Thu,  8 Jan 2026 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836080; cv=none; b=XaPXnz6BjSLiVXL2hGVgwH+nZ3LnUcdHZaUFeaBYzL5bTVkoZSBQU6bWYCc1ZJgvBtNYBc6oQLVjDNn8x+Kk3XE2pICVl7H8U6pCTaeQ1xpGCgVpwDEVDm6kryYyRxrl4jlbKob2GmcWr1LxWTP7a9bj1jkEDu6NbD3FNjq6d70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836080; c=relaxed/simple;
	bh=lHTvFXYZIzQLTkbk1gikqRp1FcuQNH2Pq1L64DE4OC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MylYMAazgGiMudyP6gY//UAkJQ/06lu2FCI8wvP97qnYtAd7f247OuNZqPuLcEKiAEGopR6ycE403m4piRaKMtre3mzJ9COetuQzeGZvGf6TeXy2SvzMeLlOJlZuUvYf1nEn8gg0X9yJegqjsp4U/NL+IjbjdYYgSX3jRyygYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=G2U+uf3e; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4qORrS6UZxVvILfwa9yv4XwWt8ZAlaWo+8PvTeZI4Xk=;
	b=G2U+uf3ezkKLYTGp2zEXopsRiLY0wtazUCB4ZuxPtaW807q+wza4EwB/n2Zjln0vYw+MFRALN
	Ke69NKzV4gMEqdF3OQgHwU3D0jLKAn/jv4YIvWhw13h1usGGm6OJMy9R/mfFtpwOXLmlQ1PH/Vb
	EzdlzKHXj/gipJTCKJQT4TM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dmnRN4jSMzcZyR;
	Thu,  8 Jan 2026 09:30:56 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id AC84F40363;
	Thu,  8 Jan 2026 09:34:29 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 09:34:29 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v3 1/3] PCI/sysfs: Fix null pointer dereference during hotplug
Date: Thu, 8 Jan 2026 09:59:42 +0800
Message-ID: <20260108015944.3520719-2-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108015944.3520719-1-duziming2@huawei.com>
References: <20260108015944.3520719-1-duziming2@huawei.com>
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
  echo $sriov_totalvfs > /sys/class/net/"$pfname"/device/sriov_numvfs &
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

Fix this by set the pointer to NULL after releasing 'res_attr' immediately.

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


