Return-Path: <linux-pci+bounces-27555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6827AB2757
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 10:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDA53BBD09
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AC199943;
	Sun, 11 May 2025 08:35:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412492F2E;
	Sun, 11 May 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746952502; cv=none; b=o17JBGwlZEKTZ7wyPszD3gvvwB1KYzgHaZmYS0MC0f8PGqybthTK6X4iapz6xBlqNdZOOZdBN4eaA716MGQ3WBvZHaIhv9fTmVePJKax1GrBDL2tt0ooy+oIHI4DqY4rv/vV/xMFA/nrVU0HyIjI8irYsly3JSKY7nC1A49Dh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746952502; c=relaxed/simple;
	bh=WOac4Pa/PJcEOfpqfuPJDtiRbQ23JcR1jjUr4bw/+2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqueOGiZB72+MXA2jp5rw+y2gSkrmP8vTd2MrrucE950Ne1tvoOgFvDKNSkah3sS83rgBYV6kzin2jEZD2OHTDCQZByZ2Bhii1NeVMFp5eHvxZnFTmA3H2T/92MRNAb7ez0mrm4Co9hbuUbyigSBiiF6EXkGNkAUHGZBzWI6h8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8CxPuMvYSBoLvDeAA--.1755S3;
	Sun, 11 May 2025 16:34:55 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.186])
	by front1 (Coremail) with SMTP id qMiowMCxKcQZYSBoUlbGAA--.49349S3;
	Sun, 11 May 2025 16:34:54 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Hongchen Zhang <zhanghongchen@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 1/2] PCI: Use local_pci_probe() when best selected cpu is offline
Date: Sun, 11 May 2025 16:34:12 +0800
Message-ID: <20250511083413.3326421-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250511083413.3326421-1-chenhuacai@loongson.cn>
References: <20250511083413.3326421-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxKcQZYSBoUlbGAA--.49349S3
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur43AFWDWFyxAw4UWr1xJFc_yoWkJFg_uF
	1jgrs3Gr4UCry0y34Yvr4fZrZYk3Wj9an7GF4xtFyrZa42ka15ta4DCFyUJr48uw45JF9I
	yw1UXr4F9r17JosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4BHqDUUUU

From: Hongchen Zhang <zhanghongchen@loongson.cn>

When the best selected CPU is offline, work_on_cpu() will stuck forever.
This can be happen if a node is online while all its CPUs are offline
(we can use "maxcpus=1" without "nr_cpus=1" to reproduce it), Therefore,
in this case, we should call local_pci_probe() instead of work_on_cpu().

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index c8bd71a739f7..602838416e6a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		free_cpumask_var(wq_domain_mask);
 	}
 
-	if (cpu < nr_cpu_ids)
+	if ((cpu < nr_cpu_ids) && cpu_online(cpu))
 		error = work_on_cpu(cpu, local_pci_probe, &ddi);
 	else
 		error = local_pci_probe(&ddi);
-- 
2.47.1


