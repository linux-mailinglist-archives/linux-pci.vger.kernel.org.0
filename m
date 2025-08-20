Return-Path: <linux-pci+bounces-34394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D592AB2E20E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC1E1888DC3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9DC31CA72;
	Wed, 20 Aug 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i5Y24KXK"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFD322765;
	Wed, 20 Aug 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706210; cv=none; b=Cb6fFdrxMcGbjxrCYmpXbwgLVoGwpDmDILmMjmqcY+azDnRfHSUpKNYo1SElCeClXTL/+ScZbmLwsMWZ0A7+GlcIGah/fCxsTM/+sbLBZ3hHDjXLqa2zzI3uMkUF7uD7CB70snUYoflBla7QbHtBTXZGErZpOOOgudjZy49xup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706210; c=relaxed/simple;
	bh=NTou8EmjTbUR8n6aiqTmtX7rT7XqprHS+AiGXm1HlU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A66wu4KpIvDRBnyG3fByzWXLmgySmlYNmtwjjnlRRmtaTjxEJdnF5lJSPWZNJcY+x53dhFM2wUREnZk0x8LXtEKHVI/hpQjakga9NwqXZFU9s5CvUNReT53DCYF+taPxqkb2fVY4XqjS2DRYjEHpg0I3GEOZWscTNw/22Wm5Gxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i5Y24KXK; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0w
	lj+lHSrPL3rr7FK3/SFmDrvWcbFBtlQDjjoWbFa/E=; b=i5Y24KXKBdHS/H8mlS
	YxM52iacLuBbcjo7ve9PGKqwJlwi2eBe4ThNhbN/KZ3Jfm1zcWYYO6HRQTblVtMJ
	lyDckqMbj5+G60e+pfotfrg07m/C7TSisCMi8CwmI9uZwaxLpJXOn6wHoovfOXKG
	dI/mtcg1F6jylBcfJIa5onDuA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXjAhK86Vo_3zUDA--.17615S2;
	Thu, 21 Aug 2025 00:09:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: Replace msleep(2) with usleep_range() for precise delay
Date: Thu, 21 Aug 2025 00:09:44 +0800
Message-Id: <20250820160944.489061-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXjAhK86Vo_3zUDA--.17615S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr48WrW5AF1DWr47Aw4DCFg_yoW5Cr4Upa
	yrCw1jyF1rJrnxXrs8Ja1xCrn8CFnrZrW8Zayku345ua4a9w4xKr4SkFW5Xr13Zr4kA34Y
	q3WYyr43ZF48Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRJCzXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhuvo2il7UG7hgAAsx

The msleep(2) may sleep up to 20ms due to timer granularity, which can
cause unnecessary delays. According to PCI spec v3.0 7.6.4.2, the minimum
Trst is 1ms and we doubled that to 2ms to meet the requirement. Using
usleep_range(2000, 2001) provides a more precise delay of exactly 2ms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Dear maintainers,

During the development process, I often check whether the file encoding meets the
basic rules. A warning appears when checking the following files:

./scripts/checkpatch.pl --no-tree --show-types --ignore EMAIL_SUBJECT,FILE_PATH_CHANGES,\
GERRIT_CHANGE_ID,UNDOCUMENTED_DT_STRING,TYPO_SPELLING -f drivers/pci/pci.c

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#4914: FILE: drivers/pci/pci.c:4914:
+	msleep(2);


In addition, I also found that the following documents all have similar problems.
Here, I'll first submit a patch to ask everyone. If it's necessary, I'll continue
to submit related patches later. If not, please ignore it.

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#4630: FILE: drivers/pci/pci.c:4630:
+		msleep(1);

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#342: FILE: drivers/pci/controller/pcie-rcar-host.c:342:
+		msleep(1);

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#1368: FILE: drivers/pci/controller/pcie-brcmstb.c:1368:
+		msleep(5);

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#42: FILE: drivers/pci/controller/pcie-rcar.c:42:
+		msleep(5);

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#106: FILE: drivers/pci/hotplug/pciehp_hpc.c:106:
+		msleep(10);
WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#286: FILE: drivers/pci/hotplug/pciehp_hpc.c:286:
+		msleep(10);

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#138: FILE: drivers/pci/pcie/dpc.c:138:
+		msleep(10);

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
#3970: FILE: drivers/pci/quirks.c:3970:
+		msleep(10);
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..ffe491635144 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4967,7 +4967,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
 	 * this to 2ms to ensure that we meet the minimum requirement.
 	 */
-	msleep(2);
+	usleep_range(2000, 2001);
 
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);

base-commit: b19a97d57c15643494ac8bfaaa35e3ee472d41da
-- 
2.25.1


