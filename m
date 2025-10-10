Return-Path: <linux-pci+bounces-37815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2640BCD9EE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F55635561C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9561F2F656B;
	Fri, 10 Oct 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U43nJxiY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C92F6195;
	Fri, 10 Oct 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108038; cv=none; b=kBIFBiNqE0YnHj3yL586KFPN9ruoC+TjTzDwlNYwefjWP3Zhwt56FUy/KT0daSYyFDiMFBjeKYSSwDbxdxNAkTknYY70T84j3dgySVVzvrfmDWgJP+ib10TnyXJrZ4v/qC2CedO9b5Znc5jJ0KhUAKAYxCsnHbnwGvQggVE5r8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108038; c=relaxed/simple;
	bh=+FYk2Aiw0NILrjGxho9f8f5Z/1azgXY7bYe01i9lapM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fqHDQAPVqmBxkcEWxVtkRwH1d/GInYD88ReIGw3ao5aIE41lerfQjhocXsNZUI708RCDLgU40cMXh+FquTWS/+nb+NpkmUlngpVv4U2+bxynAnqaN/ujvmBfFSVFH3uZim8bRPVwOh+TyqLrfQZ406jJP9M9xdf86B7fSAV9xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U43nJxiY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0D
	+8AaCyd4XMgbrnCJCI0RxpX33lz6o2ehjmms18h4M=; b=U43nJxiYt9nMDNq9WZ
	Aycac17TCAO4kHYaK5MvubjrCJ7z37J/VJXmsA52YJ1ic7lu4ozxLVyM/ovmex+L
	8ggTgJPchgXJ6lK6Qz9h31bKfZcjC91By3DO+0w8mWFXXeI4WYCo3tIib3OLTvqA
	rgmH4aomu30wxHROnez1dW3mQ=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3XvSCG+lo5o4zBw--.11679S2;
	Fri, 10 Oct 2025 22:43:15 +0800 (CST)
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
Subject: [PATCH v2] pci: cadence-ep: Fix incorrect MSI capability ID
Date: Fri, 10 Oct 2025 22:43:07 +0800
Message-Id: <20251010144307.12979-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3XvSCG+lo5o4zBw--.11679S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1DAw4fWFy7ur4Dur1kuFg_yoW8Ary5pF
	W8GF1IkF18JFWa93Wq9a17ZF13tas5A347Wa92kw15ZF17CFyUGFn2gF45KFsxGrs7ZF13
	ZrWDtryvkFsrArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRR6wJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwzio2jpExLohgAAss

In a previous change, the MSIX capability ID (PCI_CAP_ID_MSIX)
was mistakenly used when trying to locate the MSI capability in
cdns_pcie_ep_get_msi(). This is incorrect as the function handles
MSI functionality, not MSIX.

Fix this by replacing PCI_CAP_ID_MSIX with the correct MSI capability
ID(PCI_CAP_ID_MSI) when calling cdns_pcie_find_capability(). This
ensures the MSI capability is properly located, allowing MSI functionality
to work asintended.

Fixes: 907912c1daa7 ("PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/r/aOfMk9BW8BH2P30V@laps/
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


