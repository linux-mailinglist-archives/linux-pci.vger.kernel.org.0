Return-Path: <linux-pci+bounces-19897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79434A12511
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93330160BB4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465EF24A7D5;
	Wed, 15 Jan 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="US4hrto/"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335224A7C7;
	Wed, 15 Jan 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948569; cv=none; b=kkLEB+Lyh2xTFYR9AhBOowZNTk53EyWQ6B7qUEXs7q7qUtH+4v9ePlJThjrf4K3D7NFc/JDVd3C8Y7VEDLNMKA81JfRRywKPPhusG2+fhWUFz7BXllZqaNwIZizLd42lFOra4R+sG7og9BGosLBnTMBgtpEGRS8zxiGb75gBIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948569; c=relaxed/simple;
	bh=0tzsS8jZO2uaMm7Z3cvVp0JD+mdP5Nm03TNvgpeQxSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAV+Yq5nFRia0qzEXTI5S11vkUty1Rs+ib64EJG2D0Suqkw5JrjA6B9aMzST4KhqNArZp19Z23TiO1Mjqpyp/8seUk8onFzQKd/MjzD5jinmJEEonbGShQADCSngRpEAlavjPq4piK6GuUVYrjc6MYTwM5zxGYCxnfzZQc4lNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=US4hrto/; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=dzqSX4sKpVY9kqmidsCSYED7WC/dHaZXWeU3NkoOWnU=;
	b=US4hrto/SI6vueWQqPX0h2F8em8+fU7ZWzt0FUHoLigBROp/X3vmz9yHfQoXt+
	XKFwksPO4befh8iE/49ZiMzHJ4aI7vuhCJB6ZQxx6V9rsJvuMU+YLrMWvBYtMcO5
	C2bhK4qg0YELY2mI12GZVBQV7aYfqok2NHokraX+iOX3Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnFHcku4dnv58iGA--.58526S3;
	Wed, 15 Jan 2025 21:41:59 +0800 (CST)
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
Subject: [PATCH v2 1/2] PCI: Fix the wrong reading of register fields
Date: Wed, 15 Jan 2025 21:41:53 +0800
Message-Id: <20250115134154.9220-2-sjiwei@163.com>
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
X-CM-TRANSID:_____wDnFHcku4dnv58iGA--.58526S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4rtFWkKry3ZF4UtF17GFg_yoW5CF45p3
	W3ur90yrW8Cw47C3s5Was7Xa4xXFn3CF1Y9rnrWr98XFyxJ3s5AF1I9r9Iqry7Ar4jkry8
	X3srXr43Cw12kFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwF4_UUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/xtbBDw-VmWeHtGV+VAAAsX

From: Jiwei Sun <sunjw10@lenovo.com>

The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just uses
the link speed field of the registers. However, there are many other
different function fields in the Link Control 2 Register or the Link
Capabilities Register. If the register value is directly used by the two
macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).

In order to avoid the above-mentioned potential issue, only keep link
speed field of the two registers before using.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 drivers/pci/pci.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..b7e5af859517 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -337,12 +337,13 @@ void pci_bus_put(struct pci_bus *bus);
 
 #define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
 ({									\
-	((lnkcap) == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
-	 (lnkcap) == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
+	u32 __lnkcap = (lnkcap) & PCI_EXP_LNKCAP_SLS;		\
+	(__lnkcap == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
+	 __lnkcap == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
 	 PCI_SPEED_UNKNOWN);						\
 })
 
@@ -357,13 +358,16 @@ void pci_bus_put(struct pci_bus *bus);
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
+	u16 __lnkctl2 = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;	\
+	(__lnkctl2 == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
+	 __lnkctl2 == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
+	 PCI_SPEED_UNKNOWN);						\
+})
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-- 
2.34.1


