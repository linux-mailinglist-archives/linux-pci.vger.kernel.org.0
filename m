Return-Path: <linux-pci+bounces-34775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D2B370E7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F1A36746F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A834F46F;
	Tue, 26 Aug 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qb/tuKmQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F462E1757;
	Tue, 26 Aug 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227844; cv=none; b=lFiS7O1sq2lTzmszgKhMbGOMiFRQZz73bYLHE0qQ4D5N3e6AT5D3rCdLQDbG9iwPphz/THWhJ1Gn+rO4vwrL+rsZAui3dG01VwMfjE2S35WA0oMpGQuXj9ywf08U//7Teu9ISOLaxJghR9px3L4rm3WGzEOAXoa0wJtocSNTIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227844; c=relaxed/simple;
	bh=/lThjq42KooyqmXlxMvKPMrJ08XRA5pAEZauVmshh6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qF9mJz3r1WT6KQHNc9Kb9NpeKO10u/9XzTdNyQBP5iJrJQdPR73r0hJF7IaewSP5dOD/24LCWdI0FuUdawYNCmjtT6R7LHpMtABUzYr32z9DAp6LpTeNZL/uJInF2LrDi66YfL71GqOvRoeYNJfpoqfPUie6/AatY4HfvdZ1OPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qb/tuKmQ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s5
	9stUkZ2Vi7i0+if4thqpzTsJlJVwgNFTSLSvzvQiE=; b=qb/tuKmQTZjpwrrUqz
	HWKDvh5jvPvEvzpMKDXKysl0Xbg0khmYRe9/cRrnJi/KeVuTA59YllotL+C13bKG
	UWFuaMH7UWG3KBxP8uc30kWkgT+pZK2Za1JXlKljhgd2xtVOmExsd8NXY9HYxInD
	F1V5RzzSAUaEIl747BnNHondo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S4;
	Wed, 27 Aug 2025 01:03:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 2/8] PCI: Replace msleep with fsleep for precise secondary bus reset
Date: Wed, 27 Aug 2025 01:03:09 +0800
Message-Id: <20250826170315.721551-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826170315.721551-1-18255117159@163.com>
References: <20250826170315.721551-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr18Aw45ZFW5KrWUtw1xGrg_yoW5JrWfpF
	Z8GFyIyFn5JayfJws7A3W8CFy5JanxuFWUCF4xK3sYv3WayrWDuF45KFW5XrnrXFWxZr15
	ZFWrC3yUJayYyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYLv_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhe1o2it5y8lCwABsZ

The msleep() function with small values (less than 20ms) may not sleep
for the exact duration due to the kernel's timer wheel design. According
to the comment in kernel/time/sleep_timeout.c:

  "The slack of timers which will end up in level 0 depends on sleep
  duration (msecs) and HZ configuration. For example, with HZ=1000 and
  a requested sleep of 2ms, the slack can be as high as 50% (1ms) because
  the minimum slack is 12.5% but the actual calculation for level 0 timers
  is slack = MSECS_PER_TICK / msecs. This means that msleep(2) can
  actually take up to 3ms (2ms + 1ms) on a system with HZ=1000."

This unnecessary delay can impact system responsiveness during PCI
operations, especially since the PCIe r7.0 specification, section
7.5.1.3.13, requires only a minimum Trst of 1ms. We double this to 2ms
to ensure we meet the minimum requirement, but using msleep(2) may
actually wait longer than needed.

Using fsleep() provides a more precise delay that matches the stated
intent of the code. The fsleep() function uses high-resolution timers
where available to achieve microsecond precision.

Replace msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS) with
fsleep(2 * PCI_T_RST_SEC_BUS_DELAY_US) to ensure the actual delay is
closer to the intended 2ms delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 2 +-
 drivers/pci/pci.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c05a4c2fa643..81105dfc2f62 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4964,7 +4964,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 
 	/* Double this to 2ms to ensure that we meet the minimum requirement */
-	msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS);
+	fsleep(2 * PCI_T_RST_SEC_BUS_DELAY_US);
 
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4d7e9c3f3453..9d38ef26c6a9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -61,7 +61,7 @@ struct pcie_tlp_log;
 #define PCIE_LINK_WAIT_SLEEP_MS		90
 
 /* PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms */
-#define PCI_T_RST_SEC_BUS_DELAY_MS	1
+#define PCI_T_RST_SEC_BUS_DELAY_US	1000
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
-- 
2.25.1


