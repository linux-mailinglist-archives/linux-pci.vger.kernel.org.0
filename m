Return-Path: <linux-pci+bounces-28300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63584AC17D5
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D318803ED
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C482D8DC5;
	Thu, 22 May 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrdVwkLv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4722D8DC1;
	Thu, 22 May 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956245; cv=none; b=XcEcTmAKxj6IO6zm6ejnkluQDM1Eqwjfsny+WqCtNjf+3a9DXwmZMUDjPBtumKbXktyLad9n+18ogsfry+kADnFMXTLiml276wFF820PMKDAxu34/rre63YpiWt/7cDQV/urDe8tMN1BB7snzukSL2v+o1VamsUs1SsWY0LXMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956245; c=relaxed/simple;
	bh=k8jIGcmmJTsTorkecrSYGUokEgm0UmcwpovGAJ2cVHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3mSQbujR8cS0eX9t/qO6NqCEFY8eJvawzywsz8qKT3GAOY/nXcS1ItaUElxGDGkX+uwS7L0VEBmpnQDWJsoKvNjAFS1o/TAHT6+g75b7aD0W3bVwZ7ItOOJU0ohwVq8U0HKaK4UnRZa2rMlJNVuBoGkF53r7ZeBQuCi8IhJ+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrdVwkLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B38C4CEE4;
	Thu, 22 May 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956245;
	bh=k8jIGcmmJTsTorkecrSYGUokEgm0UmcwpovGAJ2cVHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrdVwkLvYhii/xN9pOwZjCNATgKkqRdCqFLtsUv16mwkDqRif34AdMaRz5XVbI/sj
	 GRPZnNUcIID4wGX7gOXMfBcvnnsLZLTLiansFM6UErVL+sv1Y/2AGCZNr0Gz9EqTp4
	 hKZ8jjrzKuwulgz3kYPXvH+vPXqmAAljxckOcYkmXpjoOlA1goEN+3UWjykL0AZJ6e
	 tS1Lax4V8KnwedNBSgDh5fOpgMayXDzGQNJ+T4/9I1coAOgDxkTY6Vv0lgFNOm0UG2
	 iHWSeUjaf92KrmmHoNOjD/oV6QiovkalrRvBQNK6UHu1C6eduERdVyek+362kTERzr
	 9ErhC4Rlvlc4A==
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
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 13/20] PCI/ERR: Add printk level to pcie_print_tlp_log()
Date: Thu, 22 May 2025 18:21:19 -0500
Message-ID: <20250522232339.1525671-14-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

aer_print_error() produces output at a printk level (KERN_ERR/KERN_WARNING/
etc) that depends on the kind of error, and it calls pcie_print_tlp_log(),
which previously always produced output at KERN_ERR.

Add a "level" parameter so aer_print_error() can control the level of the
pcie_print_tlp_log() output to match.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      | 3 ++-
 drivers/pci/pcie/aer.c | 5 +++--
 drivers/pci/pcie/dpc.c | 2 +-
 drivers/pci/pcie/tlp.c | 6 ++++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 705f9ef58acc..1a9bfc708757 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -613,7 +613,8 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      struct pcie_tlp_log *log);
 unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc);
 void pcie_print_tlp_log(const struct pci_dev *dev,
-			const struct pcie_tlp_log *log, const char *pfx);
+			const struct pcie_tlp_log *log, const char *level,
+			const char *pfx);
 #endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIEPORTBUS
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f80c78846a14..f0936759ba8b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -734,7 +734,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	__aer_print_error(dev, info);
 
 	if (info->tlp_header_valid)
-		pcie_print_tlp_log(dev, &info->tlp, dev_fmt("  "));
+		pcie_print_tlp_log(dev, &info->tlp, level, dev_fmt("  "));
 
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
@@ -797,7 +797,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 			aer->uncor_severity);
 
 	if (tlp_header_valid)
-		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
+		pcie_print_tlp_log(dev, &aer->header_log, info.level,
+				   dev_fmt("  "));
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 6c98fabdba57..7ae1590ea1da 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -222,7 +222,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 			  dpc_tlp_log_len(pdev),
 			  pdev->subordinate->flit_mode,
 			  &tlp_log);
-	pcie_print_tlp_log(pdev, &tlp_log, dev_fmt(""));
+	pcie_print_tlp_log(pdev, &tlp_log, KERN_ERR, dev_fmt(""));
 
 	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG + 1)
 		goto clear_status;
diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 890d5391d7f5..71f8fc9ea2ed 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -98,12 +98,14 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
  * pcie_print_tlp_log - Print TLP Header / Prefix Log contents
  * @dev: PCIe device
  * @log: TLP Log structure
+ * @level: Printk log level
  * @pfx: String prefix
  *
  * Prints TLP Header and Prefix Log information held by @log.
  */
 void pcie_print_tlp_log(const struct pci_dev *dev,
-			const struct pcie_tlp_log *log, const char *pfx)
+			const struct pcie_tlp_log *log, const char *level,
+			const char *pfx)
 {
 	/* EE_PREFIX_STR fits the extended DW space needed for the Flit mode */
 	char buf[11 * PCIE_STD_MAX_TLP_HEADERLOG + 1];
@@ -130,6 +132,6 @@ void pcie_print_tlp_log(const struct pci_dev *dev,
 		}
 	}
 
-	pci_err(dev, "%sTLP Header%s: %s\n", pfx,
+	dev_printk(level, &dev->dev, "%sTLP Header%s: %s\n", pfx,
 		log->flit ? " (Flit)" : "", buf);
 }
-- 
2.43.0


