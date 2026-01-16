Return-Path: <linux-pci+bounces-45022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE38FD2D8F0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33F25309DE21
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E972EACF2;
	Fri, 16 Jan 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gNhT2San"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12756224240;
	Fri, 16 Jan 2026 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549949; cv=none; b=r09K8trzA0TNFQv4Ek9S9FFZlRnnXHYSjLbXm5BECbTm16nUCqR8rJD3LxAzYy4g1rdv/q1CjpI27xLREaWxKeRfJbjjdld4R9iLsFwCfQn7h5nrcUDVFL1vqnbg3n5SsAQGR1bugcNfyoJ8HOyr8c/VmK4xp5+lQrEpzCdGr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549949; c=relaxed/simple;
	bh=Ud2R8irrjHV8oKAesOvvjnfDJQcG9DLau/Q333OJ60E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwJ2kyEFC8C/VTnJNA3SpoYCyIxXmMTBBAfInYEA8hq//Rl+5qWxOD8ehOUa4r/rtDL2Ih864V29yUomUnIrUFtx1gcAu5UAUSKZU+7djROj/gMPITcEaZ7GsxMfLjNzM5YC1DSS4SwDv7L0dVx+htA7qwJBzv+pR4T6UVUiGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gNhT2San; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dqybSqFRGWH2S5xIK9Mjnk5ZtSwQkwEhkJIGN6a62is=;
	b=gNhT2Sanmno83BrnYUVhut8QeP+WLWVvWvc0boguOaRphYR1j67TMTTe7ODcjv+FcHRk4iemW
	d02a6Y+eM+UakPzFKRvV+QBU4/dSicIB5FQFuENfe6DDPLxsm+yim9glZVnviOUK2ocaPfX9wYE
	tei1X7EotstbwX88QJeuV30=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dssSN5sHJznTVR;
	Fri, 16 Jan 2026 15:49:24 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id E35734056C;
	Fri, 16 Jan 2026 15:52:23 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 15:52:23 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <alex@shazbot.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH v4 4/4] PCI: Prevent overflow in proc_bus_pci_read()
Date: Fri, 16 Jan 2026 16:17:21 +0800
Message-ID: <20260116081723.1603603-5-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116081723.1603603-1-duziming2@huawei.com>
References: <20260116081723.1603603-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

proc_bus_pci_read() assigns *ppos directly to an unsigned integer variable.
For large offsets, this implicit conversion may truncate the value and
cause reads from an incorrect position.

proc_bus_pci_write() explicitly validates *ppos and rejects values larger
than INT_MAX, while proc_bus_pci_read() currently accepts them. This
difference in position handling is unjustified.

Fix this by validating *ppos in proc_bus_pci_read() and rejecting offsets
larger than INT_MAX before the assignment, matching proc_bus_pci_write().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziming Du <duziming2@huawei.com>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 2d51b26edbe74..f4ef7629dc78b 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -29,9 +29,12 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 				 size_t nbytes, loff_t *ppos)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
-	unsigned int pos = *ppos;
+	int pos;
 	unsigned int cnt, size;
 
+	if (*ppos > INT_MAX)
+		return -EINVAL;
+	pos = *ppos;
 	/*
 	 * Normal users can read only the standardized portion of the
 	 * configuration space as several chips lock up when trying to read
-- 
2.43.0


