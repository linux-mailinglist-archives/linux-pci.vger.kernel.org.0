Return-Path: <linux-pci+bounces-43102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F6CC1866
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 09:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE126304F13D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0041349B15;
	Tue, 16 Dec 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WFvvD/fe"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1F347FD2;
	Tue, 16 Dec 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872803; cv=none; b=Ufysem3HZW9BCwoJjIH98bgphYYzH+FGkKQq/37Mop227LAnw9yHZpa+GbUiokzjHOuyitTXT9sR/D6elCwkl2MbHgUddWebnRI655CR/Zs4dSk4T9zxf5qXCS3Hzfqarpa6/D2L0ay3x0LbxJmNtQecbrtD+wYjhXUogW9G7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872803; c=relaxed/simple;
	bh=MuTAF4fOLJk3khpF9NmDB9Q/WyViABe0U7dwSkkBHeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czfinxhHTUKC1w/mfuNnjD/xKDZBakyTv2GIzzsdDt9R7QYQ/7aiOho235qp3iXZ4vrIV8bfn71CBeAv7TG0MLfi6iWdE5MFLtES0UPVuIVYh9lpF8Vcn1QrgtyB065hN8DKTO83ARzSORFYvL/q8V/mqd6j3ejrUSPm7f0x+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WFvvD/fe; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BbVtg0J6THxhxcDCFoLlMEcYnobUuiVC/Whu7LrnJVI=;
	b=WFvvD/feMqWMFktjsNUYtn7DnS5lmWEo5JbfZgsHErgVC6j6Srr2GSSHjrZ/7fm/5FfOV94GA
	DiVUU8Z3ARP+aHHasuOhJjriL24j6RQqOuruH11NMZzSc9cciwb2hvyB8Rg/dfQOApvWL9WRFL7
	CxpkXmx5k8NYbLrj/TDjT0I=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dVqPg4Zyxz12LDy;
	Tue, 16 Dec 2025 16:11:03 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id ED90A1402C8;
	Tue, 16 Dec 2025 16:13:17 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Dec 2025 16:13:17 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chrisw@redhat.com>, <jbarnes@virtuousgeek.org>,
	<alex.williamson@redhat.com>, <liuyongqiang13@huawei.com>,
	<duziming2@huawei.com>
Subject: [PATCH 1/3] PCI/sysfs: fix null pointer dereference during PCI hotplug
Date: Tue, 16 Dec 2025 16:39:10 +0800
Message-ID: <20251216083912.758219-2-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216083912.758219-1-duziming2@huawei.com>
References: <20251216083912.758219-1-duziming2@huawei.com>
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

During the concurrent process of creating and rescanning in VF, the resource
files for the same "pci_dev" may be created twice. The second creation attempt
fails, resulting the "res_attr" in "pci_dev" to 'kfree', but the pointer is not
set to NULL. This will subsequently lead to dereferencing a null pointer when
removing the device.

When we perform the following operation:
"echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &
 sleep 0.5
 echo 1 > /sys/bus/pci/rescan
 pci_remove "$pfname" "
system will crash as follows:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
ESR = 0x0000000096000004
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x04: level 0 translation fault
Data abort info:
ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
CM = 0, WnR = 0, TnD = 0, TagAccess = 0
GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000020400d47b000
0000000000000000 pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 #1 SMP
CPU: 115 PID: 13659 Comm: testEL_vf_resca Kdump: loaded Tainted: G W E 6.6.0 #9
Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 0.98 08/25/2019
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __pi_strlen+0x14/0x150
lr : kernfs_name_hash+0x24/0xa8
sp : ffff8001425c38f0
x29: ffff8001425c38f0 x28: ffff204021a21540 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff20400f97fad0
x23: ffff20403145a0c0 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000000 x18: ffffffffffffffff
x17: 2f35322f38302038 x16: 392e3020534f4942 x15: 00000000fffffffd
x14: 0000000000000000 x13: 30643378302f3863 x12: 3378302b636e7973
x11: 00000000ffff7fff x10: 0000000000000000 x9 : ffff800100594b3c
x8 : 0101010101010101 x7 : 0000000000210d00 x6 : 67241f72241f7224
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
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


