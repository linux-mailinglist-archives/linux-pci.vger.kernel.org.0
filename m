Return-Path: <linux-pci+bounces-20262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E06A19E3A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 06:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38AF7A2DEA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E0136E3B;
	Thu, 23 Jan 2025 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fuoDHjAL"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5472C2FD;
	Thu, 23 Jan 2025 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611552; cv=none; b=SRZC3f/EeuThmWtcArOFmnV6VTTecsbPwQaDLhb04Sr0uCpj2WmZ6pXnx8t1kUdd1VDka9JaLOdvHNvhjKfJycoLOn8uQhfXxUCYQKglXv4CGjA/4xOSE+91EAX+5OdY90UMBZjHzL4fvDbMBagmX1l8tqxbjPokgHA5eMCvJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611552; c=relaxed/simple;
	bh=zPfd2wsYvCHUkuP7O8rme07rC0QW8LHh5xBKN9/yqRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcfzpPQ1HyjZ7EW/hytgKibIJBj5S5ur9TCQoR41V9qVWg00oyLlFPwb+t8ky8Ga3EVVr0Qqtb37esdeeGACMmNAvbwQGAvLDPPRFNE/i/QMv1CkEP4StXy0vw9Of32CPbm+fG4A3ED5rfc6hgnd5LGmcwuaJQWTHG/brk4NlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fuoDHjAL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=m2D3TK/wDGpgftow+9dKzgwXIks/NmyWWEukqak6kfU=;
	b=fuoDHjAL+pXnW8UaL91wJy1m0qMVEi8EfZN6nv2pUR+iOrNgUMsd6oyruTMbBY
	4O1xV26O+PZ9HakEIathEDU5Cyyky1vnR33TGxfNe2XOUaEk/Rd31QyiDujh7SX6
	bgWzlccGa6l/zP+YVpeBY3AgpwBVyuezx5GqDiV/QWx3s=
Received: from jiwei-VirtualBox.lenovo.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXxy392JFnt3jOHw--.51666S3;
	Thu, 23 Jan 2025 13:52:00 +0800 (CST)
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
Subject: [PATCH v4 1/2] PCI: Fix the wrong reading of register fields
Date: Thu, 23 Jan 2025 13:51:54 +0800
Message-Id: <20250123055155.22648-2-sjiwei@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123055155.22648-1-sjiwei@163.com>
References: <20250123055155.22648-1-sjiwei@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXxy392JFnt3jOHw--.51666S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4rtFWDWw15uF1DGw4Uurg_yoW5uFyxp3
	W3ur90yrW8Gw47u3s5Gas7Xa4xXFn3GF129rnrWrn0qFyrJ34kAF10k3sIqry7Ar40kry8
	X3srZr45G3W2kFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzYLkUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiWx3dmWeR07BWzwAAsO

From: Jiwei Sun <sunjw10@lenovo.com>

The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just use
the link speed field of the registers. However, there are many other
different function fields in the Link Control 2 Register or the Link
Capabilities Register. If the register value is directly used by the two
macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).

In order to avoid the above-mentioned potential issue, only keep link speed
field of the two registers before using.

Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..aeca10ce2028 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -337,12 +337,14 @@ void pci_bus_put(struct pci_bus *bus);
 
 #define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
 ({									\
-	((lnkcap) == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
+	u32 lnkcap_sls = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
+									\
+	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
+	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
+	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
+	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
+	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
+	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
 	 PCI_SPEED_UNKNOWN);						\
 })
 
@@ -357,13 +359,17 @@ void pci_bus_put(struct pci_bus *bus);
 	 PCI_SPEED_UNKNOWN)
 
 #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
-	((lnkctl2) == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
-	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
-	 PCI_SPEED_UNKNOWN)
+({									\
+	u16 lnkctl2_tls = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
+									\
+	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
+	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
+	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
+	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
+	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT :	\
+	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT :	\
+	 PCI_SPEED_UNKNOWN);						\
+})
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-- 
2.34.1


