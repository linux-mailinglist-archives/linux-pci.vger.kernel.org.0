Return-Path: <linux-pci+bounces-43652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6CCDBBC3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6588C303F28E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696D732F77B;
	Wed, 24 Dec 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oIu51P+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD98314A8A;
	Wed, 24 Dec 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566909; cv=none; b=sE2N/jX7o7hEVgHVbljpqeOkOOwovfAQr8TYB0TkQ9ujGTOyfEJ/5XOSuEoKGIZvl3oSoAbsDiv9kHV/vA6gnWFbFzTasZ+C7MyDVNgKQpvZHgwKf6rgbX5izdrUWnf2fFsk7D5CWOcvzvc8Ii3oGZ86akMaCAJM/L1SM86YCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566909; c=relaxed/simple;
	bh=sO7UHcb/eUGLpdl+ntAUbze0WfDTxTM88mnwukPDwFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljgVICICzMPaaYf/4Z3fnytFEBP41LqypT9x3VPALRL6PfqLbDs6BBg08qU4plUuESaDVXy7hCWAA4lZQRtRU49VPPZNTFBtFvaAKXJJ4vwVEbgf0fGksA99UztknEYEJ4pG1YJgB6RX4F+VnHkRbQOIOS1mAGwHOGUAcbC894E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oIu51P+u; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4FTwMVa6Sjk6xK1eTvo9FnDHO5W9eKanW66S/6WEpzU=;
	b=oIu51P+uy7aHuHB1sVb/T24N9aVdJ1vqHv+g8Ks6aR1NWcFXBeSNl+4daRM4FPXUIMHC7HSz/
	hR5Wpe3mKGUhOCUQ3VPvKZpLIBSwV/gP0oCwMFHvWg+GAibXc4IL8D8xc7D+QZnBuvgJlIll1e7
	sHF63tC/DQHG7IYzJDI9/6w=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dbm4q3PX7zcZxm;
	Wed, 24 Dec 2025 16:58:35 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id A685D40538;
	Wed, 24 Dec 2025 17:01:41 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 17:01:41 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>, <chrisw@redhat.com>,
	<alex.williamson@redhat.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 2/3] PCI: Prevent overflow in proc_bus_pci_write()
Date: Wed, 24 Dec 2025 17:27:18 +0800
Message-ID: <20251224092721.2034529-3-duziming2@huawei.com>
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

From: Yongqiang Liu <liuyongqiang13@huawei.com>

When the value of ppos over the INT_MAX, the pos is over set to a negtive
value which will be passed to get_user() or pci_user_write_config_dword().
Unexpected behavior such as a softlock will happen as follows:

 watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
 RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
 Call Trace:
  <TASK>
  pci_user_write_config_dword+0x126/0x1f0
  proc_bus_pci_write+0x273/0x470
  proc_reg_write+0x1b6/0x280
  do_iter_write+0x48e/0x790
  vfs_writev+0x125/0x4a0
  __x64_sys_pwritev+0x1e2/0x2a0
  do_syscall_64+0x59/0x110
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

Fix this by add check for the pos.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..200d42feafd8 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	if (ret)
 		return ret;
 
-	if (pos >= size)
+	if (pos >= size || pos < 0)
 		return 0;
 	if (nbytes >= size)
 		nbytes = size;
-- 
2.43.0


