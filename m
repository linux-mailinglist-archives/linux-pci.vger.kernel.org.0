Return-Path: <linux-pci+bounces-45024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21CD2D82C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C4E9301583A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364B2D7DDF;
	Fri, 16 Jan 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EqCVV5Sj"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42007224240;
	Fri, 16 Jan 2026 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549960; cv=none; b=VsfxRAVjdu8T8tMtvGNhr+nc1QmuvHDOXDfPs6sYtTImuC7doVAR4tBsVSSoPkAOBD3W+FFRd4cXbi+iFTi+lII8KCnmYSvlWk7yHYqnGPYgVQI81RrY1NT2Jz2yWX1km3TG1sQG5XAPCtBVlfGkEmkdlYGEzxZXOVtYTgSgudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549960; c=relaxed/simple;
	bh=/woUAYAa+Rvl1TqiNjM7hekaZtjAweiHoYnZIyNJF28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaVcvtsZNgkBHNBb9n9PMd1uRD4/mkSHGBY+njLlpAUurgJ5AZRxYgraVq+Ff1DnKorivt+tZC9hdLJdir0ethPrCX3UhBUzW8f6pJO9W/YGczJ2vVyzN7TMKqlb6Yrk64hHQypxCNW0C+NHNjqhCOnvOts1/X6Ul/cTCYuxlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EqCVV5Sj; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SrOJJn0uHaQI5nwBo4evlkh4P3KvPi5BUYcQmVZGlDE=;
	b=EqCVV5Sjdz9e6H7Ae4v0u53JS0NpjcULzDFmFdi7QESxT/T2Rc7qEogRL8hqRTC4SZy14601C
	Nd3wcSWfeT41M57ou05jBUOdfHKkM/5w7NP/UcYyq18jrKQdIIZjzjguUUP072cIf3fbHBdT15/
	gar7QvKRDDQvZiIbKQDjSvM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dssRz1H0czLlTd;
	Fri, 16 Jan 2026 15:49:03 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 404814056C;
	Fri, 16 Jan 2026 15:52:23 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 15:52:22 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <alex@shazbot.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH v4 2/4] PCI/sysfs: Fix null pointer dereference during hotplug
Date: Fri, 16 Jan 2026 16:17:19 +0800
Message-ID: <20260116081723.1603603-3-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116081723.1603603-1-duziming2@huawei.com>
References: <20260116081723.1603603-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
index 18e5d4603b472..fbcbf39232732 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1227,12 +1227,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
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


