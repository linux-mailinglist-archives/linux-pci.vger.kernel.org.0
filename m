Return-Path: <linux-pci+bounces-20632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B73A24CB6
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 07:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CB27A2334
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1341C6E;
	Sun,  2 Feb 2025 06:24:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DEE573;
	Sun,  2 Feb 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738477466; cv=none; b=WmdaxhagM5hyJhwrk8CTfimt4PysfKYZSOZ3dDdjmMuJaps2q4Q1WsHFO+xyICzuEjZm7LKG+q5TBJfjAaShrsS8V3QbR6MhOoruNdZI6yMvM+SDzTW3bNrvynOlJr0tb0AFzdlKDMKF+QRWK90W4rGsdbb9UJmCCwZS1ZRmBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738477466; c=relaxed/simple;
	bh=l3kfPrN9XiWFm/I7IsTWoZhsvRgKtXYUos4XXP6YSUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2bPBM89qBvjG+B+zB+t34g+g511z49cuEYz0ovD/TdzZJv1e2wMe+Xtgecy6W/u74I6qGsCFWodcJhZ+szju2aGG7pkrNERyQMKYxd6ds++Dh1V+wkf7CMPe74/XtVfXEkxFgbDseQrkroexrdlYntmsNNORJMKCJRJLpkpj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABHTlp+D59nwltaCg--.15816S2;
	Sun, 02 Feb 2025 14:24:08 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: bhelgaas@google.com,
	rafael.j.wysocki@intel.com,
	yinghai@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] PCI: fix reference leak in pci_alloc_child_bus()
Date: Sun,  2 Feb 2025 14:23:57 +0800
Message-Id: <20250202062357.872971-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHTlp+D59nwltaCg--.15816S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13CrykKFykXw4DtrW8WFg_yoW8JF47pa
	s7Ga909rZ5JwnF9w48ZF18ZFyFkanFya4rurWrG347ua95CryxtFWakFy5Ww1kJFZ2yF1Y
	q3ZrJa45KF4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbsYFJUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

When device_register(&child->dev) failed, we should call put_device()
to explicitly release child->dev.

As comment of device_register() says, 'NOTE: _Never_ directly free
@dev after calling this function, even if it returned an error! Always
use put_device() to give up the reference initialized in this function
instead.'

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- modified the description as suggestions.
Changes in v2:
- added the bug description about the comment of device_add();
- fixed the patch as suggestions;
- added Cc and Fixes table.
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..51b78fcda4eb 100644
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


