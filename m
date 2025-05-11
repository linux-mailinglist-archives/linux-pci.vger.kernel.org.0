Return-Path: <linux-pci+bounces-27556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970CFAB2759
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D57016FC76
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 08:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A51118FC80;
	Sun, 11 May 2025 08:35:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5428FD;
	Sun, 11 May 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746952517; cv=none; b=jrDmMpzmnLQBv0QdXR63yVLrkw+9jdoxMiE+j3GyXY+mdILG5JB+QCn80L7uqoXdS1gkEzriIPPW9EE4ufaaM0dKs1IKi4asAicMM8qYnEmBYkZIxFFrVYQJ63ei3ukCew4cd8NaDNdcl4miankd1Y47Qkyt4CMNfc+r8IEZN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746952517; c=relaxed/simple;
	bh=XKgoizKohGLc5o1IpqBL8R16M1GP53nFsI/as1dXJz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcF4VXPXH3eERz3RObdB8AFn9VqLjoKj7ho6/fiUwSgCrxXnoTbp/grUJjXJjSb1IwD1e9ViukS2/yadZuszGrxo4ih1y78xORh+xgOcDad2PXvJtMdLYIi2Y9VEhbuYku+B30/4qkGuAWdn7z08Zt4xEsigfyN1FEUzisKsR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8DxvnNAYSBoTfDeAA--.4335S3;
	Sun, 11 May 2025 16:35:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.186])
	by front1 (Coremail) with SMTP id qMiowMCxKcQZYSBoUlbGAA--.49349S4;
	Sun, 11 May 2025 16:35:11 +0800 (CST)
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
	stable@vger.kernel.org,
	Ming Wang <wangming01@loongson.cn>
Subject: [PATCH V3 2/2] PCI: Prevent LS7A Bus Master clearing on kexec
Date: Sun, 11 May 2025 16:34:13 +0800
Message-ID: <20250511083413.3326421-3-chenhuacai@loongson.cn>
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
X-CM-TRANSID:qMiowMCxKcQZYSBoUlbGAA--.49349S4
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4ftrW8GFy3tF1kCrWfJFc_yoW8GF1Dpa
	97KFWF9rWfGa1aqws8XF18ua45Jan3Xay5KF4UC34fuFsxAa4rKa47ta4xA3ZrCFWvqr47
	J3WDt3y8W3WUJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

This is similar to commit 62b6dee1b44a ("PCI/portdrv: Prevent LS7A Bus
Master clearing on shutdown"), which prevents LS7A Bus Master clearing
on kexec.

The key point of this is to work around the LS7A defect that clearing
PCI_COMMAND_MASTER prevents MMIO requests from going downstream, and
we may need to do that even after .shutdown(), e.g., to print console
messages. And in this case we rely on .shutdown() for the downstream
devices to disable interrupts and DMA.

Only skip Bus Master clearing on bridges because endpoint devices still
need it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ming Wang <wangming01@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 602838416e6a..8a1e32367a06 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -517,7 +517,7 @@ static void pci_device_shutdown(struct device *dev)
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && !pci_is_bridge(pci_dev) && (pci_dev->current_state <= PCI_D3hot))
 		pci_clear_master(pci_dev);
 }
 
-- 
2.47.1


