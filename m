Return-Path: <linux-pci+bounces-20111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245CDA160A9
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 08:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7503C7A25B1
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DDB188714;
	Sun, 19 Jan 2025 07:06:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398E1FB4;
	Sun, 19 Jan 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737270378; cv=none; b=T0L19van+UbRJFbcipdGzc+1JwqLv+1h6jBK6P7Y2o/t+WMvMgTzG5ERzGXZVyLbrfmP49dDEtijBraMpKV9bzarB43wOL8Geo5aDzofhUl34MpDfdwuaRifgHvuKNfgsqai1hwGY4MQ92dpwgfi58Qh2svdv1fLdy2OAHirqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737270378; c=relaxed/simple;
	bh=cSjPzIwSf6STSPIyu5L+H3gShh7nVHaQevsZxMB2pk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/oiWaoYlrYiwXQXofHTQbUpFQHbQRT/8L3iI0QZMUlRXXQkEmvTrcb2U43VmFjS+0tNRkKHoTbzF44tdGgy2RyOuKxQhVEn06AzKP+FjxQCuwOaOQl49M0fiMVeLpYCJ0vBMHTOCemLLDQpBGT93wyde7kuxyHHIuNBA6GABVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAD3_KBQpIxnb7YHCA--.54944S2;
	Sun, 19 Jan 2025 15:06:02 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: bhelgaas@google.com,
	yinghai@kernel.org,
	rafael.j.wysocki@intel.com,
	akpm@linux-foundation.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] PCI: fix reference leak in pci_alloc_child_bus()
Date: Sun, 19 Jan 2025 15:05:50 +0800
Message-Id: <20250119070550.2278800-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3_KBQpIxnb7YHCA--.54944S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45AF4xGr4kZFy7WFyrCrg_yoW8JFyfpa
	srGayYkrW8JrnrCw4kZF10vF9YkanFya4F9r4rGw12ka9xuryFqa4aqFy5G3WDAws2yF1U
	XF17Jry8GF4UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbE1v3UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

When device_register(&child->dev) failed, calling put_device() to
explicitly release child->dev. Otherwise, it could cause double free
problem.

device_register() includes device_add(). As comment of device_add()
says, 'if device_add() succeeds, you should call device_del() when you
want to get rid of it. If device_add() has not succeeded, use only
put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- added the bug description about the comment of device_add();
- fixed the patch as suggestions;
- added Cc and Fixes table.
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..ae12f92c6a9d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		put_device(&child->dev);
+		return NULL;
+	}
 
 	pcibios_add_bus(child);
 
-- 
2.25.1


