Return-Path: <linux-pci+bounces-37769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EEBCA225
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4831A66AE5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6B18EAB;
	Thu,  9 Oct 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kH2WUT/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C9A31;
	Thu,  9 Oct 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026252; cv=none; b=OokRcY7jb3L/k7ZZOxfyTHWqEEv0BDxxBO3dlkeeySP9bz8u+HYeFt1I6felkfI7fiNxkBQbaVWCxZXpbiRiL+kYwq2lveUy4k3In4IPjXZmRaWLgjUHigp7cLQUw0w4srId1CCS82Di1oCRPVtkAADpa8NU3j/9NJTeaRDm9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026252; c=relaxed/simple;
	bh=izkihJ33wlkjdJFsMV55MVUcg9ClBiMbxSP8IDAJ59w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fALHNitm96TttopF2VIBRIVYzCr/Z2jfofNucNM/9dTm04WNsAKH7sZ4n+NmA/2y5aD4UAWe6AQTXyKHJXWI+1VmgNL+hP3jIbxHJITpYtv8oyTvqvEVqs1QxBErNsbf9+099KtuOt6F7BQv62HEBbKkPogvfpX83mql85yDIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kH2WUT/m; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Uv
	Bu29OvmaJiQFO+ljfkeIWKV/YWE9IorPpK7ihAF90=; b=kH2WUT/mZxFAYxu7yH
	mnNgfVNrA4bZfA+vKvM0seyQ+eD9XNHgVe/VTZIrID8jRmmM/tgytOVELvZZLj8n
	vPHfgl1KdY5Fh9mhLPqpyvd7FmY/faHCAmdakgeolZctOFxVGWYcGnVDcx7h9hqm
	555ysWg+B0O3p1Ff3obpmkdsE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn75R23udon_9rDA--.20296S2;
	Fri, 10 Oct 2025 00:10:31 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	sashal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] pci: cadence-ep: Fix incorrect MSI capability ID
Date: Fri, 10 Oct 2025 00:10:11 +0800
Message-Id: <20251009161011.11235-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn75R23udon_9rDA--.20296S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1DAw4fWFy7ur4Dur1kuFg_yoW8XrWfpF
	WrGF1IkF18JFWa93Wq9a1UJF13tas5A347Wa929ry5uF17CFyUGFsrKF45KFsxGrs7ZF13
	X3yDtryvkFsrAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRN4SnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgHho2jn2EmgpgAAsh

In a previous change, the MSIX capability ID (PCI_CAP_ID_MSIX)
was mistakenly used when trying to locate the MSI capability in
cdns_pcie_ep_get_msi(). Thisis incorrect as the function handles
MSI functionality, not MSIX.

Fix this by replacing PCI_CAP_ID_MSIX with the correct MSI capability
ID(PCI_CAP_ID_MSI) when calling cdns_pcie_find_capability(). This
ensures theMSI capability is properly located, allowing MSI functionality
to work asintended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Dear Maintainer,

Since the previous patch mistakenly changed the MSI ID to MSIX ID,
a patch is submitted here to fix it. Thank you very much, Sasha, for
pointing it out.

Best regards,
Hans
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1eac012a8226..c0e1194a936b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -255,7 +255,7 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 	u16 flags, mme;
 	u8 cap;
 
-	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	/* Validate that the MSI feature is actually enabled. */
-- 
2.34.1


