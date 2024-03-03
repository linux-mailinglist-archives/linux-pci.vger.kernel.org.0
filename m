Return-Path: <linux-pci+bounces-4378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DCC86F489
	for <lists+linux-pci@lfdr.de>; Sun,  3 Mar 2024 11:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356D9B2242B
	for <lists+linux-pci@lfdr.de>; Sun,  3 Mar 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6DB664;
	Sun,  3 Mar 2024 10:57:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA190947B;
	Sun,  3 Mar 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.89.151.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709463475; cv=none; b=ikG6RWvpDe4JEgMrvlmReFKnXAn/wMSU6fnNxFcTxaEPC1WpT4H+dnS1XMOv9aiS0RShGTZRaBv0hd1yy53TtBhdBuGcULJ9OCCfNvkuhSFE22UuskSS0BqVL7alIxhEoU4jzeuiYmqgETQj5K+YsnDCziObPN1hbSziOVib9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709463475; c=relaxed/simple;
	bh=7I1M0XKAfIrhItJO/PERH8zWFQjuo/z2v7W4UV2ieXg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jn3zir5SabL5uFK7VdpHSMKh6wSHj/hhJIdqkOi2X19QcxH+N4x2oeIM54fOrp5nC5RiKDj50P6BNHorRi+W84+RajKMUsRx6fDO8ahT4Dxi2QLeq75GgnYNsFsgDT6jbwe9i9unvnKeP8CUHyrFS2j9Cho5FDay8NBhOzERp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.89.151.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.16.66])
	by mail-app2 (Coremail) with SMTP id by_KCgD3OqqZV+RlIRuXAg--.47332S2;
	Sun, 03 Mar 2024 18:57:38 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] PCI: of_property: handle int_map allocation failure
Date: Sun,  3 Mar 2024 18:57:29 +0800
Message-Id: <20240303105729.78624-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgD3OqqZV+RlIRuXAg--.47332S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWDJF1DKw1rZr47XFy8uFg_yoWDXwc_ur
	ykZ3Z7Cr4UCrnagr1Utan3XrZ7C3W8ZFs3uFn3tFyfCry7ursYqrnrZ3s5JFs7G3yxAF95
	ta4UArn5Cr1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoo7KDUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIIAWXjdVMBCAA0sV
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The kcalloc() in of_pci_prop_intr_map() will return null if
the physical memory has run out. As a result, both int_map
and mapp will point to the null area. If we dereference mapp,
the null pointer dereference bugs will happen.

Return -ENOMEM from of_pci_prop_intr_map() if kcalloc() fails
for int_map.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/pci/of_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index c2c7334152b..03539e50537 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -238,6 +238,8 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 		return 0;
 
 	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
+	if (!int_map)
+		return -ENOMEM;
 	mapp = int_map;
 
 	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
-- 
2.17.1


