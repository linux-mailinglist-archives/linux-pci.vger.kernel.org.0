Return-Path: <linux-pci+bounces-38019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E624BD7F95
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973A418A32B2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8B23D7FF;
	Tue, 14 Oct 2025 07:39:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C429BD81;
	Tue, 14 Oct 2025 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427588; cv=none; b=CMGJcEVxAxb/L8Y76nbY22mLhcu9uW5RpYfiEtWjT7apOuKj88YBvj6V/njrZCNIy+cUnZGVOq8z4hvA4mI2wCNbK0LNcY7+NAdM1qz23dJZCkoKeYiGhe/esxCAvZo8kYOQ1gclLaFobbJ6Q9mNDd2A+0inMN0ZrH47hlkD1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427588; c=relaxed/simple;
	bh=BQ9jer1zGLwz8HVUVnXNwihqaOBybFGc85+G5DL43uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sstp+Z3vwLncn3DdWZx/RYUo6Yk164+QKV4YsPZeVgZOeXAOCyMlZ3D8neKH9BT6YYEcpfGscvKbwypzb9P2uxvprJ/x3yL3TP4lKnJZ4nm63bOV2QVMm16VOETJGtyi+xnkjTLr60p9LDbW6fxYyIE40wJn3HQqpqvyqSVZ8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8CxK9I+_u1opesVAA--.45392S3;
	Tue, 14 Oct 2025 15:39:42 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJDxscI5_u1oWivhAA--.63490S2;
	Tue, 14 Oct 2025 15:39:41 +0800 (CST)
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
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH 03/15] PCI: Limit islolated function probing on bus 0 for LoongArch
Date: Tue, 14 Oct 2025 15:39:29 +0800
Message-ID: <20251014073929.2143907-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxscI5_u1oWivhAA--.63490S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJry8Cr43tF1DZFyxAFyxWFX_yoW8Ww18pF
	Z5u3y8Ary8KFy3ArZxA3y0kr15K397A34UCFWUG345XanxJ3Wxtws8tF1aqrnrGrWIvFyF
	qa1DZrW5u3WxA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxUc0eHDUUUU

We found some discrete AMD graphics devices hide funtion 0 and the whole
is not supposed to be probed.

Since our original purpose is to allow integrated devices (on bus 0) to
be probed without function 0, we can limit the islolated function probing
only on bus 0.

Cc: stable@vger.kernel.org
Fixes: a02fd05661d73a8 ("PCI: Extend isolated function probing to LoongArch")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/probe.c        | 2 +-
 include/linux/hypervisor.h | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec12..da6a2aef823a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2883,7 +2883,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 			 * a hypervisor that passes through individual PCI
 			 * functions.
 			 */
-			if (!hypervisor_isolated_pci_functions())
+			if (!hypervisor_isolated_pci_functions(bus->number))
 				break;
 		}
 		fn = next_fn(bus, dev, fn);
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index be5417303ecf..30ece04a16d9 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -32,13 +32,15 @@ static inline bool jailhouse_paravirt(void)
 
 #endif /* !CONFIG_X86 */
 
-static inline bool hypervisor_isolated_pci_functions(void)
+static inline bool hypervisor_isolated_pci_functions(int bus)
 {
 	if (IS_ENABLED(CONFIG_S390))
 		return true;
 
-	if (IS_ENABLED(CONFIG_LOONGARCH))
-		return true;
+	if (IS_ENABLED(CONFIG_LOONGARCH)) {
+		if (bus == 0)
+			return true;
+	}
 
 	return jailhouse_paravirt();
 }
-- 
2.47.3


