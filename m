Return-Path: <linux-pci+bounces-36002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C2B548CA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6E7A00E1A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7672E2EF5;
	Fri, 12 Sep 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SbSFrLLK"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB932DFA2F;
	Fri, 12 Sep 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671717; cv=none; b=gm2+04/NetNbGoOGOk7k+YKjkdldxlGqDMM37roJ84oBTvR9L7smaP/EIuGHEqmCbOz8tLm1I40lXoDtP2Emi2eou2SDrX2DXu3qho+Os7tJEUSIZj7EaV7wBCYwlOwalBjzBReMfKpJrJ+gBvW1x+cd+Cp6qdpedHTy/+Noktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671717; c=relaxed/simple;
	bh=zdZohGYX+BHWKzl9tDVr0ydMQAgONvsyNJMt8yZ4UME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8kjkW8OhZ3pF4k5qfP1KtnHaeV2ClD/x9KEzCHj8NU8XfR8aOQJ1W8IpjkDZIU6sW9GtAxEKtuxSYW9fgdSt2QqE57mwU3FC29TkY/WeuGHnF7dIkckEtAXwA8lKp7ghYZuwGS6sCByseRlqXt2AWqguegzMc6vAT/oGicZgqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SbSFrLLK; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CA8KRE498901;
	Fri, 12 Sep 2025 05:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757671700;
	bh=kPef8o51W2k/wgNz6zp8GrcjykT9Fj4+FXx9GO2BZNY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SbSFrLLKqTthZH1QyVyAbPGxHokQIBbq0jQjl43q5ZjJfG4kfcLI+hvx8veoIEyvZ
	 cB6U5SLpONKSJyRweOSRZpnQEB99tsf84BRKImLHFxX0z+moJi38hNvclcAphLubjk
	 s42EpueuBvGgJQ80vpc8RbDEYF3j2df9TyWRni5k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CA8KFc1228533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 05:08:20 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 05:08:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 05:08:20 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CA83MI3740807;
	Fri, 12 Sep 2025 05:08:15 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <sergio.paracuellos@gmail.com>,
        <18255117159@163.com>, <jirislaby@kernel.org>, <m-karicheri2@ti.com>,
        <santosh.shilimkar@ti.com>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/2] PCI: keystone: Remove the __init macro for the ks_pcie_host_init() callback
Date: Fri, 12 Sep 2025 15:37:59 +0530
Message-ID: <20250912100802.3136121-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912100802.3136121-1-s-vadapalli@ti.com>
References: <20250912100802.3136121-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The ks_pcie_host_init() callback registered by the driver is invoked by
dw_pcie_host_init(). Since the driver probe is not guaranteed to finish
before the kernel initialization phase, the memory associated with
ks_pcie_host_init() may already be freed by free_initmem().

It is observed in practice that the print associated with free_initmem()
which is:
	"Freeing unused kernel memory: ..."
is displayed before the driver is probed, following which an exception is
triggered when ks_pcie_host_init() is invoked which looks like:

	Unable to handle kernel paging request at virtual address ...
	Mem abort info:
	...
	pc : ks_pcie_host_init+0x0/0x540
	lr : dw_pcie_host_init+0x170/0x498
	...
	ks_pcie_host_init+0x0/0x540 (P)
	ks_pcie_probe+0x728/0x84c
	platform_probe+0x5c/0x98
	really_probe+0xbc/0x29c
	__driver_probe_device+0x78/0x12c
	driver_probe_device+0xd8/0x15c
	...

Fix this by removing the "__init" macro associated with the
ks_pcie_host_init() callback and the ks_pcie_init_id() function that it
internally invokes.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 21808a9e5158..c6e082dcb3bc 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -799,7 +799,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 }
 #endif
 
-static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
+static int ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
 	int ret;
 	unsigned int id;
@@ -831,7 +831,7 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
-static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
+static int ks_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-- 
2.43.0


