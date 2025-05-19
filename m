Return-Path: <linux-pci+bounces-28025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E3ABCA1B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2BB189D3F2
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9D22425D;
	Mon, 19 May 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAAYFKyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A222424C;
	Mon, 19 May 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690627; cv=none; b=dP03CjZ50ym55VqUxnE7lZY6ztyn72Wg+D8IMWbf6+oLPf4xh/6zLx8QVdMRieqO0ACgTA49mIjps95AgLMXK8AwYqxQZatsTpG/P4Y3CogtFSUrxTkQDUWBR3PgLqJuQsxP0UyvBIqKKaCWHL60NeemPbsres08NZl7crjmj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690627; c=relaxed/simple;
	bh=NAhGtd5JfzeBCzQA1T4NEmRuVhhFv6g9vasKC+2bs3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omI5on8dy3AEtKod09HEgXtqIFoVVBZfR0fFwxnMFLTinC6B5J8TNGNjutrG0DTb/rBynSv/VV91IbOr9TOPKhNjg6AgNXJZOjD7IT3+Wa4z3ahnalv6K3hh4HA6iBerDAePyFVuFBC+C9401YPrusK7oAZEXdp39nMdyW8XxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAAYFKyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA77C4CEE4;
	Mon, 19 May 2025 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690626;
	bh=NAhGtd5JfzeBCzQA1T4NEmRuVhhFv6g9vasKC+2bs3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAAYFKytJKXtguC5OPN1vhjjWORgKkZigyL38b0hhsQXwcn4lVNVWyJadazNUOw2e
	 Uj40NWIQbfSHMR1iNgSam3gqXtzMymyBWMJtEGvbXCtG4uUfL+YxwT7ZZKwChpfcc/
	 JQRK1MP4GmjKcBUkEv/7ICdkHqIYkpKfkfr+VRiuWrIjXUdshB/XWAP2IflgiHgOX/
	 Dpsy6Asz22yeMeR0l7LHgZx/fxDsgR5Yt3qq2os9g53ntjlEv6yWLfH1oiyScwDqqw
	 XS6b0kFhQzFoQ4DnzDLUpXb6sA3gZgjx9eDKxMVoQ/AFklCNrf5uCsVPMQ/61IHR+a
	 NaAFQQqbXNz2g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
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
Subject: [PATCH v6 10/16] PCI/AER: Combine trace_aer_event() with statistics updates
Date: Mon, 19 May 2025 16:35:52 -0500
Message-ID: <20250519213603.1257897-11-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519213603.1257897-1-helgaas@kernel.org>
References: <20250519213603.1257897-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

As with the AER statistics, we always want to emit trace events, even if
the actual dmesg logging is rate limited.

Call trace_aer_event() directly from pci_dev_aer_stats_incr(), where we
update the statistics.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index eb80c382187d..4683a99c7568 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -625,6 +625,9 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 	u64 *counter = NULL;
 	struct aer_stats *aer_stats = pdev->aer_stats;
 
+	trace_aer_event(pci_name(pdev), (info->status & ~info->mask),
+			info->severity, info->tlp_header_valid, &info->tlp);
+
 	if (!aer_stats)
 		return;
 
@@ -741,9 +744,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
-
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -782,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	info.status = status;
 	info.mask = mask;
+	info.tlp_header_valid = tlp_header_valid;
+	if (tlp_header_valid)
+		info.tlp = aer->header_log;
 
 	pci_dev_aer_stats_incr(dev, &info);
 
@@ -799,9 +802,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
-
-	trace_aer_event(pci_name(dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
-- 
2.43.0


