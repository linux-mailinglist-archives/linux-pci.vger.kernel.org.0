Return-Path: <linux-pci+bounces-6096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E288A0311
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767EBB24456
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908019DF4F;
	Wed, 10 Apr 2024 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgeTToln"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DB184134;
	Wed, 10 Apr 2024 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787209; cv=none; b=k5H7GvROlM5BjlyeE9+Z8SUW3sqebI408tlsrCAUOUuj/j0Q+PnJxx+2qOLqCRR9jh30sl1EUWvtskJU2P+VdqFXGj30XCYSgORG6DIjBH5H4SI1nE/GnizGwoxUVKGCtAvuC9gTkPgqeF2nfNuLO+4HM1LpjycsFosBNRuh9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787209; c=relaxed/simple;
	bh=5nbfHeG60eNzQJI5iVciR/vfXygkXSoILlSxcVaWD5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StkHtUXaGvrUrJYq/CuK0YVed7viggIj9C8hdKuPxQjmTgngPZN1l/UpC/4m69xXu4Gyb11fwG/g9c1TQXbQRolz2Nz2YnAETCm8ErKl4/kV0SOh5Ixxqr0Jq8uDq5PkVGhe1HKWQRt2udzdjPTnpHW25BaF/VPzuiDeAOi6FRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgeTToln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C25C433F1;
	Wed, 10 Apr 2024 22:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787209;
	bh=5nbfHeG60eNzQJI5iVciR/vfXygkXSoILlSxcVaWD5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgeTTolnYlCAy8OAzdiKscXxM/dzYw15RbiM3PYRgReAZHNbB4uWRykeO5TnX+B9d
	 T0hnL0JSff3HCkBFR1loHcYyJQcsrTB2OrX/20n+ga5yTsvDagkUyUxszEhr9DphZ+
	 6vgaxNTTpN2CgruYbgNVDXCbYz1/cDOs7LFinWBik7WSiHNeQzKa1LlvfRId+gkekb
	 d2C7n1vP7dJJ6FvCtzmYp8wFKZaEwReUkBPRfuY9s0N4HddmTiyQJHCCTb56uDRpvF
	 DyCuN4wF0r85D+0olwK5kPOBeuO3enpcR8TUfYbgwN6EES7b9zgY0QO+IaaeByTcXN
	 5TDPoDvTo61cg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 7/7] Revert "genirq/msi: Provide constants for PCI/IMS support"
Date: Wed, 10 Apr 2024 17:13:07 -0500
Message-Id: <20240410221307.2162676-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410221307.2162676-1-helgaas@kernel.org>
References: <20240410221307.2162676-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit e23d4192bf9b612bce5b24f22719fd3cc6edaa69.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/irqdomain_defs.h | 1 -
 include/linux/msi.h            | 2 --
 include/linux/msi_api.h        | 1 -
 3 files changed, 4 deletions(-)

diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 5c1fe6f1fcde..36653e2ee1c9 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -25,7 +25,6 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
 	DOMAIN_BUS_DMAR,
 	DOMAIN_BUS_AMDVI,
-	DOMAIN_BUS_PCI_DEVICE_IMS,
 	DOMAIN_BUS_DEVICE_MSI,
 	DOMAIN_BUS_WIRED_TO_MSI,
 };
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 26d07e23052e..84859a9aa091 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -573,8 +573,6 @@ enum {
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
 	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
-	/* Support for PCI/IMS */
-	MSI_FLAG_PCI_IMS		= (1 << 21),
 };
 
 /**
diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
index 391087ad99b1..5ae72d1912c4 100644
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -15,7 +15,6 @@ struct device;
  */
 enum msi_domain_ids {
 	MSI_DEFAULT_DOMAIN,
-	MSI_SECONDARY_DOMAIN,
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 
-- 
2.34.1


