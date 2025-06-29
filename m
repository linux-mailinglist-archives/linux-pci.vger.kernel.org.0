Return-Path: <linux-pci+bounces-30993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79159AEC674
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBDA7A63F2
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FAC2236E1;
	Sat, 28 Jun 2025 09:52:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D51922DE;
	Sat, 28 Jun 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751104342; cv=none; b=N69f/2b5lsSoUYLy7l/hvo6E8zBU5Q9Sj8tKgZGbOiVrxhcNHDbi4PoEiuYJRcbV/VpRp4/VczqIO9UPJ6aGWJn0Iqyclp3JKc/N/QXBtZtP0C1aJKgwstp/+8gLm2Em9sAsDda29g2AMgxsRpzEQ3++MOga7HQf83BjfduLaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751104342; c=relaxed/simple;
	bh=8N1MHhtt2T7DcOn+RZNnPkLDBgNMQLf1rSn5tWEJ00s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZapjEO6GMStL0k36izbVzEBBEqPFlvzfx6JwFH7WSrS/BAVopcJDp86RnehFkMrLRPF+yOZNzkOWhAJ0YZOxSQ6zwmvQI9fxgzbgK9NivWjTwlf3fS1RLgxZGEeOxDUqIqtYA0nxPcTjMnSFoFx7RSZbtoe0HTPx4855q2nq2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bTnfp5fgWz2CfCJ;
	Sat, 28 Jun 2025 17:48:18 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id AA0B5140294;
	Sat, 28 Jun 2025 17:52:17 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp200004.china.huawei.com
 (7.202.195.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Jun
 2025 17:52:17 +0800
From: zhangjian <zhangjian496@huawei.com>
To: <lossin@kernel.org>, <aliceryhl@google.com>, <dakr@kernel.org>,
	<simona.vetter@ffwll.ch>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci: fix uaf for resource file
Date: Sun, 29 Jun 2025 11:05:47 +0800
Message-ID: <20250629030547.1073425-1-zhangjian496@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp200004.china.huawei.com (7.202.195.99)

concurrently creating attr files may cause uaf. We meet this in concurrently
plug and unplug network card. For example:

echo 20 > /sys/class/net/eth3/device/sriov_numvfs &
echo 1 > /sys/bus/pci/rescan

crash log snips as following:

Call Trace:
 <TASK>
 ? _die_body+0x1a/0xe0
 ? page_fault_oops+0x81/0x150
 ? _wake_up_sync_key+0x37/0x50
 ? exc_page_fault+0x525/0x730
 ? asm_exc_page_fault+0x22/0x30
 ? pci_create_attr+0x160/0x180
 ? pfx_strlen+0x10/0x10
 kernfs_name_hash+0x12/0x80
 kernfs_find_ns+0x35/0xc0
 kernfs_remove_by_name_ns+0x46/0xc0
 pci_stop_bus_device+0x7c/0x90
 pci_stop_and_remole_bus_device+0xe/0x20
 pci_iov_remove_virtfn+0xbd/0x120
 sriov_disable+0x34/0xe0
 hinic_pci_sriov_diisable+0x35/0xa0 [hinic]
 hinic_remove+0x22e/0x2a0 [hinic]
 pci_device_remove+0x3b/0xb0
 device_release_driver_internal+0x19b/0x200
 pci_stop_bus_device+0x6c/0x90
 pci_stop_and_remolre_bus_device_locked+0x16/0x30
 remove_store+0xfc/0x130
 kernfs_fop_write_iter+0x11b/0x200

set resource pointer to zero to fix this problem.

Signed-off-by: zhangjian <zhangjian496@huawei.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa..12dba9228 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1180,12 +1180,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
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
2.33.0


