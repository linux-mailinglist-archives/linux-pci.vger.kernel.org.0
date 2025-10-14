Return-Path: <linux-pci+bounces-38020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B267ABD7F9B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BE6B4E3F33
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8CE22A4DA;
	Tue, 14 Oct 2025 07:41:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839562D9EF6;
	Tue, 14 Oct 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427686; cv=none; b=ss8NcSNdLe3J4v4py0JGgJDWbA5D0c/jzKhvnHdCkSAt4g3vHNt9qxOHScxCwBbD+90UEc3T1tqOnDu+AjljsfsWbC3YV9VSVdhSTdUsKktOwPAgJQ+FQ5cLDx9pw/4pIbdMQ6udX7HTlr6HCs9obdT67dmbomOu2imc4+Idpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427686; c=relaxed/simple;
	bh=wDM35rgVxVwoNdmY6Y9MC3x7jXbMbSj//nUk1VoIbSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kY/UnbWXSZjSFXYeE2jT+d5ZaRON/P+X9ZYkvRcZcwB6QpEuuLXJi640yClWYBX1JLUsqOrTTFJoxsWHW3fNIboBj+VZnh64jJQ0Hl3TvfCqyfGCUFFb5Xa8a9XumAAyhSknuKwy6kdZpM8Q+J2iBxmAiQGXGJt0ya564t4DLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8CxaNGa_u1owOsVAA--.47472S3;
	Tue, 14 Oct 2025 15:41:14 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJAxPMGV_u1o8CvhAA--.17379S2;
	Tue, 14 Oct 2025 15:41:13 +0800 (CST)
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
Subject: [PATCH Resend] PCI: Limit islolated function probing on bus 0 for LoongArch
Date: Tue, 14 Oct 2025 15:41:00 +0800
Message-ID: <20251014074100.2149737-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxPMGV_u1o8CvhAA--.17379S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJry8Cr43tF1DZFyxAFyxWFX_yoW8Ar48pF
	Z5u3y8Ary0kFy3AFZIy3y0kry3Ka97A34UCFWUG3y5XFsxt3WIq398tFyaqrnrGrZ2vFyS
	qa1DZrZ8u3WxA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUJ529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==

We found some discrete AMD graphics devices hide funtion 0 and the whole
is not supposed to be probed.

Since our original purpose is to allow integrated devices (on bus 0) to
be probed without function 0, we can limit the islolated function probing
only on bus 0.

Cc: stable@vger.kernel.org
Fixes: a02fd05661d73a8 ("PCI: Extend isolated function probing to LoongArch")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
Resend to correct the subject line.

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


