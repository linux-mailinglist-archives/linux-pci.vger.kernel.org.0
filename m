Return-Path: <linux-pci+bounces-43707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485ECDD2CC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 02:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905413014DA1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 01:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC621C16E;
	Thu, 25 Dec 2025 01:28:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413554C98;
	Thu, 25 Dec 2025 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766626139; cv=none; b=Onpr+HBNxB1yYz46zRJ28bXdIeYnJZy+kmyg0yrivS8D7ehdnbwaSJ95gr9jrgcguQ/nlvu90LCO0jQG1ojp1Jw4Bn60dwWo/oFadwUBf/eA3joQSC4vPSs88Ob2RCI7DcCHej5QbqUk8FGwh8QK3BY0asrQGOHDbR38tO97LRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766626139; c=relaxed/simple;
	bh=h32bf6KjHQTp5SK1HXI68lXo33LUmPJTzH2E2SeTrNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g2aj+YhAFXN57vlhrRvfQuHUn2EGIOhfvMKLPjxnhOxxW48hEoKpwds2uSLNzAqMbTxHZrVpz0PxPflwGsE4TpYNNzkykAN/Zg+tfG2OtiDZhdmXJVizf9O35pKC/qRInm0808HX6SbE5VJPnj2GCUBrlp2t9gVGU2qq7S7KOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowADn_tU3k0xpZm7nAQ--.9817S2;
	Thu, 25 Dec 2025 09:28:24 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH] x86/PCI: add a check for alloc_pci_root_info()
Date: Thu, 25 Dec 2025 09:28:21 +0800
Message-Id: <20251225012821.1610670-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADn_tU3k0xpZm7nAQ--.9817S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1xAw18CF13WF4kXF45Awb_yoW3XrcE9a
	4a9wsrJrZ5t3s293yUAF4fGw13Aw1xKr4rWF1fAr13tFy3KF15Z397tFn8tr40g3yDAry5
	JasxJr1UAF18CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCREHE2lMko4BwwAAs3

Add a return value check for alloc_pci_root_info() to
prevent null pointer dereference in update_res().

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 arch/x86/pci/broadcom_bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
index 2db73613cada..d0cf7d2acc65 100644
--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -27,6 +27,8 @@ static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
 	fbus = read_pci_config_byte(bus, slot, func, 0x44);
 	lbus = read_pci_config_byte(bus, slot, func, 0x45);
 	info = alloc_pci_root_info(fbus, lbus, 0, 0);
+	if (!info)
+		return;
 
 	/*
 	 * Add the legacy IDE ports on bus 0
-- 
2.25.1


