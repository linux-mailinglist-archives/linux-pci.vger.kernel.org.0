Return-Path: <linux-pci+bounces-28301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D87AC17D7
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F57E7AECA2
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0AC2D8DDE;
	Thu, 22 May 2025 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIKJjdVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F72D8DDA;
	Thu, 22 May 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956246; cv=none; b=J5BjL1Rt0EzMwqKDHkLxPSaqUyke3ExaIaixTqc5BwF35q4a/GY+xXggBvr0xKDCE9AzL85L2nHfrdFZ7PJpqKshgUQgms5BX9AtHOu6JQHBwRn+CUcONDmcWYba8rfXg0BpAagjOPPl03bG5W91OvcSGGvHpnayXe4beZXccF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956246; c=relaxed/simple;
	bh=oYnRbf5eM382uxxio2T4IzMms5Vip3YfxnE2tqRR/yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtPJyhRkK/S5zfasVumTsPsvCXu2wCJwvQ02on5fqxCXYjyt7cwALNq8K0591Gx90A5dD+C0eri8mS9dsri0dyDT/sbTqtPkjL1TTJAYy6T3tFIcoQ8Khycwr3cqETeU98trRu75TVgOb4iUs1VRyHrEOZKmucZDORj4n1fHP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIKJjdVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8714CC4CEE4;
	Thu, 22 May 2025 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956246;
	bh=oYnRbf5eM382uxxio2T4IzMms5Vip3YfxnE2tqRR/yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIKJjdVW9YlYiyDbOFV4Uyr8YPX5CqE4M/Bnp89E4wVpf9JMpbN9soHDG715gKa0i
	 FldBSW69STXzjnKNTOQO3EvTFqQQLqO0+RaT9Am7z7dz6t99ZDvCDy79Gi37bGk9OB
	 6iK+UPaNJ2vqiiEr1EzX4GnhUyi6L3qnKPE6Sp4AIdjG2aUTwIDcQMpHic71MA7Y6u
	 v7v/kulpxhK8OUV6HagE8yM5WtGCQMTIA6HciftYNUtlqrpRdVo15aFKV4rCiKvVCM
	 XfDhp+/co791lchVrgqTDx6aWwV5Ce7oY6jp+E3X/y3PWRBkf2DREVjnSGUF4DV6v6
	 S7PFuuQraInWQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v8 14/20] PCI/AER: Reduce pci_print_aer() correctable error level to KERN_WARNING
Date: Thu, 22 May 2025 18:21:20 -0500
Message-ID: <20250522232339.1525671-15-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Karolina Stolarek <karolina.stolarek@oracle.com>

Some existing logs in pci_print_aer() log with error severity by default.

Convert them to use KERN_WARNING for correctable errors and KERN_ERR for
uncorrectable errors.

[bhelgaas: commit log]
Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250520215047.1350603-14-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f0936759ba8b..16779f281b2f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -787,14 +787,15 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
+		   status, mask);
 	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(info.level, dev, "aer_layer=%s, aer_agent=%s\n",
+		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+		aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
+			   aer->uncor_severity);
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, info.level,
-- 
2.43.0


