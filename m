Return-Path: <linux-pci+bounces-8715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A17906574
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 09:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBAA1C2345D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4B13C3EE;
	Thu, 13 Jun 2024 07:43:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A3213C9D5;
	Thu, 13 Jun 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264592; cv=none; b=mvYbzmnx5qwnW7iuGu6nUpeE93EhQ+4plKltEoU30fkhKNzBYpqkYqjh80QMvoJq6KReqJOlB9xZF/4f/G9emvedvip9nQqPGchFEjLEanIJTC2DUSqY1Sdn+lqlHONLZwhTcCh46rE8PfSoOGG4hxbKvwfoC2RTTxzEQ0RdDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264592; c=relaxed/simple;
	bh=YehfgFC2fciO3pRMzakftx9BA51/qmvAe+pwvzKRskQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=guCLtaW+5LIKrn9ftAsFlv9qHCyU/+gUy1ExaY/8nZhFfX7Y0ymdZuUqqzRAKTiZIFX6JARp+rkMpVJ5pacWCmwoWIbg0ddKGKnJv7bUminZOEFa+hBSlMvcy7DCMOiZUdy3E0m8e8ekKk3gM814vW987dk8wqPFrEVDubCDPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.133.93])
	by gateway (Coremail) with SMTP id _____8Cxe+oLo2pmEW0GAA--.26167S3;
	Thu, 13 Jun 2024 15:43:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.133.93])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxusYKo2pmd2AeAA--.9308S2;
	Thu, 13 Jun 2024 15:43:06 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Markus Elfring <Markus.Elfring@web.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Belits <abelits@marvell.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Nitesh Narayan Lal <nitesh@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hongchen Zhang <zhanghongchen@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v3] PCI: pci_call_probe: call local_pci_probe() when selected cpu is offline
Date: Thu, 13 Jun 2024 15:42:58 +0800
Message-Id: <20240613074258.4124603-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxusYKo2pmd2AeAA--.9308S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAHB2ZqUJQEggACsN
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1DKryktr1ktw1rJrWfXrc_yoW8Gr1fpF
	ZrG34Skr4kJF4UG3Wqqay8uFyFganrJa429a1xCwnxZFZxAF10y3Z7ArW3Jr1UWrWkZr1a
	v3WDAryUGFWUArbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
@cpu is a offline cpu would cause system stuck forever.

This can be happen if a node is online while all its CPUs are
offline (We can use "maxcpus=1" without "nr_cpus=1" to reproduce it).

So, in the above case, let pci_call_probe() call local_pci_probe()
instead of work_on_cpu() when the best selected cpu is offline.

Fixes: 69a18b18699b ("PCI: Restrict probe functions to housekeeping CPUs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
v2 -> v3: Modify commit message according to Markus's suggestion
v1 -> v2: Add a method to reproduce the problem
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..32a99828e6a3 100644
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
2.33.0


