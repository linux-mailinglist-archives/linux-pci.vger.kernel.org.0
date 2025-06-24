Return-Path: <linux-pci+bounces-30475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2028AE5CC9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5F71B63F87
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1C41D63C0;
	Tue, 24 Jun 2025 06:29:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53E230996;
	Tue, 24 Jun 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746596; cv=none; b=uKwHtNHCIf2cMCfLtcyGblEGtuiNC9s5ZcpLZ0cP+b/eDTzMIKxuefucGyolMrI2O8V+OmL70Mjw6AFCYVLoRXXjmVWJV4qPCfVBhikbI6f4yR9MRaZ8SXdaFopEmkb3Xzv7JvhFkcz3oj1Y6XiavVk4dv/3qYLAOrbmpZfrIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746596; c=relaxed/simple;
	bh=Xlgt+AJdlMJAX9PYVZcWhhPh/iLrjRKOC69qLTabt28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1coY2Yg4MH7zJZdRFoCRR36LzaeMob4lFGRdMTDbEyRV4qQWWk3bBzfhMoPOFKRBGPOKz2qjiBnqSPpl6QHWGw7hoyGLadFZkXFlImeA2Kizf0aoEsFg0pBTLyxwtHORtFdjn99QNiQB71VBDPKAnrFDXg0fGOcdHXJI8u6sHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8BxIK_dRVpo1wwcAQ--.60552S3;
	Tue, 24 Jun 2025 14:29:49 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMCxqhrPRVpomGsoAQ--.33729S2;
	Tue, 24 Jun 2025 14:29:48 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	virtualization@lists.linux.dev,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: Extend isolated function probing to LoongArch
Date: Tue, 24 Jun 2025 14:29:27 +0800
Message-ID: <20250624062927.4037734-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxqhrPRVpomGsoAQ--.33729S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw1UAFWfCrW8JrWrWrW5XFc_yoWDtwc_Aw
	n3XF4xWrs7ZFy2ga9rWrZ7JF1rWw40yr1rZr1vqr4Ykas0ya1DGwnrJF9xJ3W8GF47ZrZI
	k3WfW3ySyr12gosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Like s390 and the jailhouse hypervisor, LoongArch's PCI architecture
allows passing isolated PCI functions to a guest OS instance. So it is
possible that there is a multi-function device without function 0 for
the host or guest.

Allow probing such functions by adding a IS_ENABLED(CONFIG_LOONGARCH)
case in the hypervisor_isolated_pci_functions() helper.

This is similar to commit 189c6c33ff421def040b9 ("PCI: Extend isolated
function probing to s390").

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/linux/hypervisor.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index 9efbc54e35e5..be5417303ecf 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -37,6 +37,9 @@ static inline bool hypervisor_isolated_pci_functions(void)
 	if (IS_ENABLED(CONFIG_S390))
 		return true;
 
+	if (IS_ENABLED(CONFIG_LOONGARCH))
+		return true;
+
 	return jailhouse_paravirt();
 }
 
-- 
2.47.1


