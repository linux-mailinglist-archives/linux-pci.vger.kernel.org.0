Return-Path: <linux-pci+bounces-11349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB294899B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 08:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5024280FE1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848C1BB683;
	Tue,  6 Aug 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CE0rgNhV"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE815B147;
	Tue,  6 Aug 2024 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927080; cv=none; b=MjBSV9ZbhYGB6EwCs2XQTSM2Q6R2UO5kQ5SsvBq/fLn0uMnAEXpuGc19QXt7VghWIRObhKI4UlkBugXLN21vPS95JERrOLUtJHXkX0cnSJY+d6ejjBSTvoT3BPciRD3LSzy1qxd2xV1b/2C+mciCyTKkAjqEeShtAjbYYpnyWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927080; c=relaxed/simple;
	bh=h+DeojCVC/NICWJOC06XfVPSavc/6auwVEn7lSTy6BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBOv6YekwZYu0YPnG8/hdhdjtyVsNPhybaMSrNP2FXwaYwgRW3/qS9mpohMgbl/qRh1ukvpGcYx/uwHjamn5JHYAMQmJMbcruhzn7j0yHaue2Not0IPalKhNOQEsfo06ThEJjj7hvUdd9g/dcw9FNJ89DpK1IT1CuLvqwJ3po/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CE0rgNhV; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fl+tN
	pmNyji4s1//Vo+z9LPfct+I+zcp/W5+el3aMdM=; b=CE0rgNhVMx59c8zc6PuRY
	DejPBQPrjtI4GYgDAVGbcZ5aMlS+KW5w3A8W32v0IvMlTnZMqsyaMSH0RMpnPStN
	9ZaJReXEl91SSD8yRkRXfvmzAfEylFl0EL9/XV3eLAn6u7ogAs4FEstseaZx/SeP
	bf9pFkB/DnXGC0WLVZX0vk=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wD3v__Mx7FmXV1hAA--.9145S2;
	Tue, 06 Aug 2024 14:50:54 +0800 (CST)
From: 412574090@163.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH] PCI/ERR: Use PCI_POSSIBLE_ERROR() to check config reads
Date: Tue,  6 Aug 2024 14:50:50 +0800
Message-Id: <20240806065050.28725-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v__Mx7FmXV1hAA--.9145S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW8Jr4DGrW8GrWrGrWfKrg_yoW8Gry5pr
	W5Jay3tF45tFyUJF4vv3yrWr909a9xKrWkGr1Ik3sru3Z0k345JrW3JF12qw12gFWkXF1I
	vwn8XFs8X3WUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOEfOUUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/1tbivhEzAGV4Ka3wbwAAsa

From: weiyufeng <weiyufeng@kylinos.cn>

Use PCI_POSSIBLE_ERROR() to check the response we get when we read data
from hardware.  This unifies PCI error response checking and makes error
checks consistent and easier to find.

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 drivers/pci/hotplug/cpqphp_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index e9f1fb333a71..718bc6cf12cb 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -138,7 +138,7 @@ static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 o
 
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
 		return -1;
-	if (vendID == 0xffffffff)
+	if (PCI_POSSIBLE_ERROR(vendID))
 		return -1;
 	return pci_bus_read_config_dword(bus, devfn, offset, value);
 }
@@ -253,7 +253,7 @@ static int PCI_GetBusDevHelper(struct controller *ctrl, u8 *bus_num, u8 *dev_num
 			*dev_num = tdevice;
 			ctrl->pci_bus->number = tbus;
 			pci_bus_read_config_dword(ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
-			if (!nobridge || (work == 0xffffffff))
+			if (!nobridge || PCI_POSSIBLE_ERROR(work))
 				return 0;
 
 			dbg("bus_num %d devfn %d\n", *bus_num, *dev_num);
-- 
2.25.1


