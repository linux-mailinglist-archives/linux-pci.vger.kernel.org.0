Return-Path: <linux-pci+bounces-20881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A5A2C0A5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 11:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3067A4297
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C918FDD5;
	Fri,  7 Feb 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mqmKUKFO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157753A7;
	Fri,  7 Feb 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924386; cv=none; b=JW2M/dwXxge/fFOd6GSoXI31HCUSNpeGBHBPytAmM8PYcT+fuEG5mJLlCCbO4cIA9+n8cp8XWe39W7Yta/BgxTY16oeF6D8yNRGoeGx0EprtGwRrXHDo+2mi2GnHD2gk2G9O8KR84XhMhdgNaDJxA0MaeQH1bQm3Io51+giIDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924386; c=relaxed/simple;
	bh=WTDr/G1skVjWh8EnYLcNXt+LRgyLBrCm/eeyjKJlj/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCu6+JpGergC9Ssif3ghH5tCqVBmroNJ7jRmHFYRntvPaJrfiSg/f9kdQo3mCEndqyASwtvXBgr6Hj1kSOxIk2jz2n10Lo7NozrxXCAQ+EbBFE7WoFNLt1B08MxUpSHk0A9vPF6WAgeHnZS7wAyGUbJjmV2U8x6x8mVp6ZVhJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mqmKUKFO; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eGngS
	niGDrpZdwRnlYe6zvDuqB1QaaruKTmGkVzWykQ=; b=mqmKUKFOh3Qufl1/u/9Cb
	2VuNFBU2ymjULKWifLfcBMdH+Eg6oqU5RPxVlSNPqgp532PpoBZq6H2AfUlx2a17
	go1ld8S14sq21CvO+fWg8e7v5nlDxFKBuiXV57x4145sVYdC8glJD4m2oDsW/UaZ
	2Mt4RLqMQKEBk1zUxDE2wI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3gALo4KVn4NbiBg--.39589S2;
	Fri, 07 Feb 2025 18:31:06 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	bwawrzyn@cisco.com,
	cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	"hans.zhang" <hans.zhang@cixtech.com>
Subject: [PATCH] PCI: cadence: Fix sending message with data or without data
Date: Fri,  7 Feb 2025 18:31:01 +0800
Message-Id: <20250207103101.31287-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3gALo4KVn4NbiBg--.39589S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13Cw1fJw45CF4rtw48tFb_yoW8CF1xpF
	yUG34Syw1xJrWavan5Z3WDXF13JFnayF9rJw4q934fuF17u34UGr12kFyrGFW5GrWvqr17
	uw1DtF9rGF4fA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIzuJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxvso2el3j8yPQAAs3

From: "hans.zhang" <hans.zhang@cixtech.com>

View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
Registers below:

axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.

Signed-off-by: hans.zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
 drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..0bf4cde34f51 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	spin_unlock_irqrestore(&ep->lock, flags);
 
 	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
-		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
-		 CDNS_PCIE_MSG_NO_DATA;
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..39ee9945c903 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
 #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
 	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+#define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
 

base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
-- 
2.47.1


