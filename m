Return-Path: <linux-pci+bounces-42925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A8CB4A25
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 04:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A15F30054B2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 03:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51517202979;
	Thu, 11 Dec 2025 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qCcTlk27"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAD43147
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765424277; cv=none; b=WoO37icqtHy5AyYX/QqvwTGp9wLGKixCK9GDNuU13x+JTtfQRRRYm8y3LRGZOwnsAqN2hEnn6x+zMnNj//swEwK/uGZ4Q+iMnHMRihs+ONUKcwd6wlU69AO+OQ0u//+EY3ttFdYsQR/AmPz+1GLRJd2HtppvEEaOqa0kPgn2bfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765424277; c=relaxed/simple;
	bh=wFcvDCmtdNCGgrYx2A1va56VlW4GqXTiGzx59R3BHLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxKb0hzvR9FaBWnpgpllBrnHnXSYrxc9gZzvduXKAe2JM6Ll2iSHhlVZXFDh8uf6w/xHKmcR5smlJh61fmomxF0dWErUNHMtJdZcljCH1+3gYzYlnTIpGReYxlenwyuwvu0YAaV6F4lubG73/WwtZ5glM1WOo6rslq67EQjX+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qCcTlk27; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765424270; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ldU+SI6DALIn81byqoHlcR87VLUgKb0SsE0/aLJi1c8=;
	b=qCcTlk27mG6A1cyhKsDHArZC3DEaV6cLcsGmQZtYFgw/yyyMolxj7oPfqhEAw1dhIRdkUR5RwnTmtOneUAddq4exDfHH0qNyEpEPR3jWyHALiH2jyAuT/mcfJcSoB1uEGQaSc1QqEuWSBGE43GvmwjYk/lLdm6kJ+mPQoPerO6E=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuYoYFu_1765424266 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 11:37:50 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v7 1/2] PCI: Introduce named defines for pci rom
Date: Thu, 11 Dec 2025 11:37:40 +0800
Message-ID: <20251211033741.53072-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211033741.53072-1-kanie@linux.alibaba.com>
References: <20251211033741.53072-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation patch for the next fix patch.
Convert some magic numbers to named defines.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/rom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e18d3a4383ba..3e00611fa76b 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -9,9 +9,20 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/bits.h>
 
 #include "pci.h"
 
+#define PCI_ROM_HEADER_SIZE			0x1A
+#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
+#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
+#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
+#define PCI_ROM_IMAGE_LEN			0x10
+#define PCI_ROM_IMAGE_LEN_UNIT_SZ_512		512
+#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
+#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
+#define PCI_ROM_DATA_STRUCT_LEN			0x0A
+
 /**
  * pci_enable_rom - enable ROM decoding for a PCI device
  * @pdev: PCI device to enable
-- 
2.43.0


