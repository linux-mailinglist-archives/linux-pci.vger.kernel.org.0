Return-Path: <linux-pci+bounces-37526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D12BB6504
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3004A1B97
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063D0288C89;
	Fri,  3 Oct 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="bLhP90S7"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59830288522;
	Fri,  3 Oct 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482287; cv=none; b=W7ShcRJdAxQkTq7ZZsXFL7sfCsPlyfbvw57Sw7NY3Q3qvkCRJ31A5oujy90t6ZaT/55LSCZMUkpAkXOuqBmqL2Ki/wc7i3+BY4ekBcIB9BGKcLFL7qqOSS09+2oWOmA58Qo3KxVXKOkUyV8h8NOH9742womIBtlrZdGFPEww7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482287; c=relaxed/simple;
	bh=7N5QWNataeghBjDyL+w2/JfSvD4OPbDvKNeREaM6sOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdeIqJnefmcONvtTF5mzwbCmE2aj4hK7u4OgpBPJwp0cx+8nMEvj3Tys8xSkSukKhFSEzBzb6tbVrbpXuXjQxAA3FrEl02Z/aRL8aQmWPsdKugS75hwUX0b8GLoW0txet1jlcvXy0qWe0W+0lFiwe42nMT6EmM3g8J3UaV6B+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=bLhP90S7; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482286; x=1791018286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EThcknCv/RwuqYAnw3foo0dHvAQW6OeUi0mVdys6TZg=;
  b=bLhP90S7beDcuJy3mgMSYnErGSx+kxD1nw5i/qdGdTzJswqmMkVfsHze
   ewqCqqClPB49kanKhoe+1fXSnApz3tJdzZXwzlhHSYZOLn9vemp1fL+d/
   MnvwtpKkQAWriWheYgVV0rA0LJOcMe1cgmlGnTcAhW60bXv/Daq9UFmrZ
   bXu833W7RZv3ZYeKVc9AtRthpbPsinsUN0Gqk75Nrai/xOx+1JBZVaJ0f
   yFOcrOyfVKZVPhhtSjW3xlUFxVN3ycI6JxDvFFdOAjPHB7S0xpARl3jCJ
   e05X/T5KVOfgRllS8glMAn4P1tTAeAg6CMC2OWVh2WVIuykeCpZ0fwqsA
   g==;
X-CSE-ConnectionGUID: TUrawTrnQYqfAxqHhC7PVQ==
X-CSE-MsgGUID: RXclbhseT6mKd9DrcPsrxg==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4203505"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:04:45 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:25443]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.171:2525] with esmtp (Farcaster)
 id 20957580-7853-4403-8847-56ac8f77b02f; Fri, 3 Oct 2025 09:04:45 +0000 (UTC)
X-Farcaster-Flow-ID: 20957580-7853-4403-8847-56ac8f77b02f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:04:45 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:04:42 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 08/13] pci: Save only spec-defined configuration space
Date: Fri, 3 Oct 2025 09:00:44 +0000
Message-ID: <93623324232f4ec4dcda830d497ac2890b19215f.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change PCI configuration space save/restore operations by
saving only the regions defined by the PCI specification avoiding any
potential side effects of undefined behaviour.

The current implementation saves the entire configuration space for
device restore operations, including reserved and undefined regions.
This change modifies the save logic to save only architecturally defined
configuration space regions and skipping the undefined areas.

This benefits the PCSC hitrate, as a 4byte access to a region where only
2 bytes are cacheable and 2 are undefined, therefore uncached, will lead
to a HW access instead.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 drivers/pci/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db940f8fd408..3e99baaaf8cd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1752,11 +1752,62 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
-	/* XXX: 100% dword access ok here? */
-	for (i = 0; i < 16; i++) {
-		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
-		pci_dbg(dev, "save config %#04x: %#010x\n",
-			i * 4, dev->saved_config_space[i]);
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+		for (i = 0; i < 13; i++) {
+			pci_read_config_dword(dev, i * 4,
+					      &dev->saved_config_space[i]);
+			pci_dbg(dev,
+				"saving config space at offset %#x (reading %#x)\n",
+				i * 4, dev->saved_config_space[i]);
+		}
+		pci_read_config_byte(
+			dev, PCI_CAPABILITY_LIST,
+			(u8 *)(&dev->saved_config_space[PCI_CAPABILITY_LIST /
+							4]) +
+				(PCI_CAPABILITY_LIST % 4));
+		pci_dbg(dev,
+			"saving config space at offset %#x (reading %#x)\n",
+			PCI_CAPABILITY_LIST,
+			dev->saved_config_space[PCI_CAPABILITY_LIST]);
+		pci_read_config_dword(
+			dev, PCI_INTERRUPT_LINE,
+			&dev->saved_config_space[PCI_INTERRUPT_LINE / 4]);
+		pci_dbg(dev,
+			"saving config space at offset %#x (reading %#x)\n",
+			PCI_INTERRUPT_LINE,
+			dev->saved_config_space[PCI_INTERRUPT_LINE]);
+	} else if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		for (i = 0; i < 13; i++) {
+			pci_read_config_dword(dev, i * 4,
+					      &dev->saved_config_space[i]);
+			pci_dbg(dev,
+				"saving config space at offset %#x (reading %#x)\n",
+				i * 4, dev->saved_config_space[i]);
+		}
+		pci_read_config_byte(
+			dev, PCI_CAPABILITY_LIST,
+			(u8 *)(&dev->saved_config_space[PCI_CAPABILITY_LIST /
+							4]) +
+				(PCI_CAPABILITY_LIST % 4));
+		pci_dbg(dev,
+			"saving config space at offset %#x (reading %#x)\n",
+			PCI_CAPABILITY_LIST,
+			dev->saved_config_space[PCI_CAPABILITY_LIST]);
+		for (i = 14; i < 16; i++) {
+			pci_read_config_dword(dev, i * 4,
+					      &dev->saved_config_space[i]);
+			pci_dbg(dev,
+				"saving config space at offset %#x (reading %#x)\n",
+				i * 4, dev->saved_config_space[i]);
+		}
+	} else {
+		for (i = 0; i < 16; i++) {
+			pci_read_config_dword(dev, i * 4,
+					      &dev->saved_config_space[i]);
+			pci_dbg(dev, "save config %#04x: %#010x\n", i * 4,
+				dev->saved_config_space[i]);
+		}
 	}
 	dev->state_saved = true;
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


