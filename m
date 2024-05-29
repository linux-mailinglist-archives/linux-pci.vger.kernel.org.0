Return-Path: <linux-pci+bounces-8017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B258D355A
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6822899F8
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F916DECF;
	Wed, 29 May 2024 11:19:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C87A13DDB2;
	Wed, 29 May 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981595; cv=none; b=ibkuHZ0rp//L2P9aadcr13nk15MjjkE17tE798ZTDb+muZO+eG5XkN3snsPG8k6hT85+DZ1BTp7vIkzvD9/b1p6yWvd4/Tp1VpwXxDH6Oh3IG2EuTtnGlzNswSGJUiFal4Lv0ZNKACqlGdYtzJ27HsnN9ExrT4rHtEP+cK6CyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981595; c=relaxed/simple;
	bh=cTpW4h0esAKGMKfykiWz6wsPp/48KJ+ilI1XLm2O+rw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgMDVzmDDUXWUyE0roODwpNSf6JDgfs2rkG4caDr1PoNXPJoPdl/jWP+drrxQpbzb5jmYBZiWXISr5/t70+VP42K5XLYjCyNflDi8YO/As8L2ITIH1YnG1hWVgKEtLweuqeqSjTJvsL+mnrY2jcAYU35dtfe/wNlb9QY+eH+NjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.133.93])
	by gateway (Coremail) with SMTP id _____8AxW+pWD1dmRB4BAA--.4656S3;
	Wed, 29 May 2024 19:19:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.133.93])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfcdVD1dmDewMAA--.34229S2;
	Wed, 29 May 2024 19:19:50 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hongchen Zhang <zhanghongchen@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: use local_pci_probe when best selected cpu is offline
Date: Wed, 29 May 2024 19:19:47 +0800
Message-Id: <20240529111947.1549556-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfcdVD1dmDewMAA--.34229S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAMB2ZWihIEpwAnsm
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF1rXr18WryfXw1UZr1UJwc_yoWfAFX_ua
	48Wrs7Wr4UCr10k3s09r1fZrZak3WjvFs2gF4xKa4rZa42yr4UtasrZry5Jr1ru3y5JF9F
	yr1UXF1rZr17JosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU

When the best selected cpu is offline, work_on_cpu will stuck
forever. Therefore, in this case, we should call
local_pci_probe instead of work_on_cpu.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
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


