Return-Path: <linux-pci+bounces-28524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958DAC769D
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8FC3A7A21
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA12472BD;
	Thu, 29 May 2025 03:44:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5220B80C;
	Thu, 29 May 2025 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490299; cv=none; b=HMaNHTahjL7vOM3TLWHU1TTbMw/6r+n10kLYDZ1AOodtuwRrLEXUDh5l0B6PvreILiLf104aPNOB1wslFGcPafxFTLZYy9aht4FOC1cVuKgfDykbS/J3qygBYZ+WAHSFNJGfQ0oIBIqYMX1y2LgOgUwyQBzI2ka6Rpo2MdJMayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490299; c=relaxed/simple;
	bh=5bS2W4/zEIXzUiFAznWu+80l7WtTaUnP3K/p4gB4oBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9vPN8XCdXMMzVYjd4A4EY1OPDbv2F2stay88FHIXHAFgh6nQ5/P6Yl1gt0SNKkujz2G/J+5o6BdIf1F7X0HxzBakDDMcrbxH6TxPbHisUZ4yNuhcc7PibobhEsgnOcApNUWdTGZByIIGLeaIl0aLPODZjq3QNNPwbIoxlTcHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b7BzJ0SgvzvPsl;
	Thu, 29 May 2025 11:43:08 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D01B180492;
	Thu, 29 May 2025 11:44:53 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 May
 2025 11:44:52 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <airlied@redhat.com>, <jbarnes@virtuousgeek.org>,
	<benh@kernel.crashing.org>, <bhelgaas@google.com>,
	<tiago.vignatti@nokia.com>, <liuyuntao12@huawei.com>
Subject: [PATCH -next] pci:vga fix race condition in vga_arb_write
Date: Thu, 29 May 2025 03:32:10 +0000
Message-ID: <20250529033210.182807-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg500010.china.huawei.com (7.202.181.71)

The following code has a race condition under concurrency.

if (io_state & VGA_RSRC_LEGACY_IO)
	uc->io_cnt--;

in race condition:
pre:  uc->io_cnt = 1
post: uc->io_cnt = 4294967295

move vga_put code below changing uc->io_cnt code.

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 drivers/pci/vgaarb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..2d0e6cf9eef8 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1257,13 +1257,13 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 
-		vga_put(pdev, io_state);
-
 		if (io_state & VGA_RSRC_LEGACY_IO)
 			uc->io_cnt--;
 		if (io_state & VGA_RSRC_LEGACY_MEM)
 			uc->mem_cnt--;
 
+		vga_put(pdev, io_state);
+
 		ret_val = count;
 		goto done;
 	} else if (strncmp(curr_pos, "trylock ", 8) == 0) {
-- 
2.34.1


