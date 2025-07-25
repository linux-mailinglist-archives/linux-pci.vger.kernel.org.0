Return-Path: <linux-pci+bounces-32926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA7B11A86
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B042C189A7E6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32457272800;
	Fri, 25 Jul 2025 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQLLWAWu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080D2727E7;
	Fri, 25 Jul 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434399; cv=none; b=QZaauZfz4IKaJ6jjdCJu7Og44lHuBo6TJfDQ+sb6qbfAWeQvmHNr8xt5sl75pY1zzSgOAlI1etO4Wo7I3bVchuiodVJL4SnAAHJg3/6fi/cUnq2zZdzgUl77YF/0zomVvU6NL1LH5ZMni9KZbX7vkznLTisgOmJsQx4yL2WrIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434399; c=relaxed/simple;
	bh=13wYyH6yqFhcpM5wqK+jk6pe2mqkcvr4lJToHDrvCdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyYttRJ62JB1MPhyC2/qxron/BQRKZ9pQPpbGy4+B266GfJLYApUZBroZZkRSdhAPqU0CCUV0HH61hSMEfk7pYvj/Cdab0KLAqwwYHmdcvSMdga3o/VqPhWQoK58Gj59uWhAz89tRLZdcd+XJPXjFJs7ly3YFGhz0EkbQmCX4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQLLWAWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AD9C4CEF5;
	Fri, 25 Jul 2025 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753434398;
	bh=13wYyH6yqFhcpM5wqK+jk6pe2mqkcvr4lJToHDrvCdk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZQLLWAWuUj38IB5edesdX/ImEo63EMiNagQgL7BB2XK2s7qikm3SFf4vMmDRXcy+I
	 d3AMcfgRDjVHKxANzVp0x7/mOT1obMYAfKt4rNKihTYx52b8aZ0+dlL1MO85gSkwsC
	 xyR1bRCVMqJjDQiAKcCx/7XEo2hQfGSdM02SKsCkxytXqtx1NMQCtjrE2rWqjBF0ND
	 yGvfGEkWAHEnQxf+RnrWgSARjQreWBchCCbeZq1U1UUMXx6NDx8HScHM4m6IWUCQHQ
	 h5WBOVBN0azUN6wXtSUhEJSAkvLk2s9ym3zWuCYsfToBDEYNUR8KgPPokr0E5x1ACC
	 sS1cg2WwSescw==
From: Arnd Bergmann <arnd@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Hans Zhang <18255117159@163.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jiwei Sun <sunjw10@lenovo.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: fix out-of-bounds stack access
Date: Fri, 25 Jul 2025 11:06:28 +0200
Message-Id: <20250725090633.2481650-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added PCI_FIND_NEXT_EXT_CAP function calls a helper that
stores a result using a 32-bit pointer, but passes a shorter local
variable into it. gcc-15 warns about this undefined behavior:

In function 'cdns_pcie_read_cfg',
    inlined from 'cdns_pcie_find_capability' at drivers/pci/controller/cadence/pcie-cadence.c:31:9:
drivers/pci/controller/cadence/pcie-cadence.c:22:22: error: write of 32-bit data outside the bound of destination object, data truncated into 8-bit [-Werror=extra]
   22 |                 *val = cdns_pcie_readb(pcie, where);
      |                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'dw_pcie_read_cfg',
    inlined from 'dw_pcie_find_capability' at drivers/pci/controller/dwc/pcie-designware.c:234:9:
drivers/pci/controller/dwc/pcie-designware.c:225:22: error: write of 32-bit data outside the bound of destination object, data truncated into 8-bit [-Werror=extra]
  225 |                 *val = dw_pcie_readb_dbi(pci, where);
      |                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the macro to remove the invalid cast and extend the target
variables as needed.

Fixes: 1b07388f32e1 ("PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/pci.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index da5912c2017c..ac954584d991 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -109,17 +109,17 @@ int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
 ({									\
 	int __ttl = PCI_FIND_CAP_TTL;					\
 	u8 __id, __found_pos = 0;					\
-	u8 __pos = (start);						\
-	u16 __ent;							\
+	u32 __pos = (start);						\
+	u32 __ent;							\
 									\
-	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
+	read_cfg(args, __pos, 1, &__pos);				\
 									\
 	while (__ttl--) {						\
 		if (__pos < PCI_STD_HEADER_SIZEOF)			\
 			break;						\
 									\
 		__pos = ALIGN_DOWN(__pos, 4);				\
-		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
+		read_cfg(args, __pos, 2, &__ent);			\
 									\
 		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
 		if (__id == 0xff)					\
-- 
2.39.5


