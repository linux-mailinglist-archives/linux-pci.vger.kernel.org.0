Return-Path: <linux-pci+bounces-11001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AECF940348
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 03:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0D81C210CF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B852905;
	Tue, 30 Jul 2024 01:16:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CC28EB
	for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2024 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302206; cv=none; b=aMZvnhIECKxYzh95Dzf87sWhASNTOoBczD7cbJh8ptMCJLej/wayOZh2sEhE9oXZZmvPt9v6jVYiPM8yZS5oKWErTu07dPMA8RfXQfpsryZK3anX+Dav2wso1wFeyZNNs7nyXpdds9ksM4wiOiiiYonJw1VRA4XysYN5yq6BorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302206; c=relaxed/simple;
	bh=yfAXMyjDkdzcbj93j3URVw8D9ZOb/VV5Cmxxn/XaE68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BW5evNjBt/iZdI6wXVfdgREe3uTPcNoI7XCMLflwCmcM/a5Fez0ix/2TfGLCbZm0PnSi3lkUkRU1Si8FBK+aBQowOsgsINSrHqA690QuvLlHNBAgyN11C/lwb/3tkMe2wGXeuvMSUQdB/TQUrr4D0f5BnodQVvzHZynCE6+fkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WXxzC3qLpzPtDY;
	Tue, 30 Jul 2024 09:12:23 +0800 (CST)
Received: from kwepemd100012.china.huawei.com (unknown [7.221.188.214])
	by mail.maildlp.com (Postfix) with ESMTPS id EC2F4180105;
	Tue, 30 Jul 2024 09:16:40 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemd100012.china.huawei.com (7.221.188.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 30 Jul 2024 09:16:40 +0800
From: Jay Fang <f.fangjian@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<dinghui@sangfor.com.cn>, <f.fangjian@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH] PCI/ASPM: Update ASPM sysfs on MFD function removal to avoid use-after-free
Date: Tue, 30 Jul 2024 09:16:39 +0800
Message-ID: <20240730011639.2590846-1-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100012.china.huawei.com (7.221.188.214)

From 'commit 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal
to avoid use-after-free")' we know that PCIe spec r6.0, sec 7.5.3.7,
recommends that software program the same ASPM Control(pcie_link_state)
value in all functions of multi-function devices, and free the
pcie_link_state when any child function is removed.

However, ASPM Control sysfs is still visible to other children even if it
has been removed by any child function, and careless use it will
trigger use-after-free error, e.g.:

  # lspci -tv
    -[0000:16]---00.0-[17]--+-00.0  Device 19e5:0222
                            \-00.1  Device 19e5:0222
  # echo 1 > /sys/bus/pci/devices/0000:17:00.0/remove       // pcie_link_state will be released
  # echo 1 > /sys/bus/pci/devices/0000:17:00.1/link/l1_aspm // will trigger error

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
  Call trace:
   aspm_attr_store_common.constprop.0+0x10c/0x154
   l1_aspm_store+0x24/0x30
   dev_attr_store+0x20/0x34
   sysfs_kf_write+0x4c/0x5c

We can solve this problem by updating the ASPM Control sysfs of all
children immediately after ASPM Control have been freed.

Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/pci/pcie/aspm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..eee9e6739924 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1262,6 +1262,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_config_aspm_path(parent_link);
 	}
 
+	pcie_aspm_update_sysfs_visibility(parent);
+
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
-- 
2.33.0


