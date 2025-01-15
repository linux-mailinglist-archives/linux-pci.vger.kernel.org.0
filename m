Return-Path: <linux-pci+bounces-19896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9763A12510
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090661885F4E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD524A7D1;
	Wed, 15 Jan 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F2HlUZRh"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4524A7C7;
	Wed, 15 Jan 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948563; cv=none; b=CPEhVpXdbEeMoljwmfZjo2QCJa1BxjENa+UeuLd8LlyjHT4Z+DFjOWigiwdkkBkIHm+kI6pVVWTKIGQI26tHunNCOtaV/HABqAgD3pFZNCNTx0yO3QxMYgzZI3cg/Hd2wrNzabXa/HsbNstMTgBVv5/L1hBbYV5w5rQU4emaId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948563; c=relaxed/simple;
	bh=0sFC0/1apnb6+GajuBVSeiqpAhgKXRyTiZwo5lkzeNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLVTkjXTsLUTZX291RZe/sxvMxdubYu7/eP8heCn3+TsUZezc8zUDcc4v3A1QsjJhWpDr7MGl75bA6mXojZLNnEMjCF8scJYHKg0amdOc5LmiEELnHVCUfsgO5854mHF3TkKwhpMu4wsucTHIc7jMrKStcq9xI5lw1BToSrvFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F2HlUZRh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=N0T0gGwwAZhSqzFeAgR7UZ1plHLkxcbedda5haZ+NrU=;
	b=F2HlUZRh/+ywai7tGWgygIo8wLVbsqVRDd++YH51LixRVbdyQ3YDFW2G0PdnE+
	3bp7qPXa31a4M8oSJxGzOYWQo9zDQhKDlBUus30nFzAYP0Wv0UkIttU8+lsiifU2
	H80CxufHlY83Otq4Zj/tqR4V+GjxSqgN0pHZjMupfvluA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnFHcku4dnv58iGA--.58526S4;
	Wed, 15 Jan 2025 21:42:00 +0800 (CST)
From: Jiwei Sun <sjiwei@163.com>
To: macro@orcam.me.uk,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	helgaas@kernel.org,
	lukas@wunner.de,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com,
	sunjw10@outlook.com
Subject: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before using
Date: Wed, 15 Jan 2025 21:41:54 +0800
Message-Id: <20250115134154.9220-3-sjiwei@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115134154.9220-1-sjiwei@163.com>
References: <20250115134154.9220-1-sjiwei@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFHcku4dnv58iGA--.58526S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW5CrW7Ar1rAr4UAr4kXrb_yoWkJrg_ur
	y8X3ZrJr4UtF43Jw1jyF43Zr1Yya429r4qgr1rt343AFy2g342vrZ7CFyqyF43GF1SgFya
	kr9rXw42kr9F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1lksPUUUUU==
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiWwLVmWeHs++KNAAAsX

From: Jiwei Sun <sunjw10@lenovo.com>

Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
PCIe Link Speed"), the local variable "lnkctl2" is not changed after
reading from PCI_EXP_LNKCTL2 in the pcie_failed_link_retrain(). It might
cause that the removing 2.5GT/s downstream link speed restriction codes
are not executed.

Reread the Link Control 2 Register before using.

Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a..02d2e16672a8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -123,6 +123,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 			return ret;
 		}
 
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	}
 
-- 
2.34.1


