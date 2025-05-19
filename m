Return-Path: <linux-pci+bounces-28020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E2DABCA21
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FB1616C4
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9B2222AB;
	Mon, 19 May 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0u+lzw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185C221FD7;
	Mon, 19 May 2025 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690619; cv=none; b=ZxV9Wu5Ii97Z9fHGcP6BKkfZ3dpKx0Tmqs4rELivn68jNnijnvVKYgc3cYFYJ8V9wF+EdsQ9wu7B8sY21CPqPCyOaM2smrvLgCrPEBQ/gWu9O02sy358Nv+mUSXwegmDkFPlKl0tZrfxsOQf8KKQegyebkKq6xcREH9pMXqrmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690619; c=relaxed/simple;
	bh=A1yGfiEGjU/jCFLLlMoihWTgBNPiIjwSNSe9WDii04I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVLH4/edKtUJr5oXx3uR6ws8wmhMYwGJhJ+jGRYFdR/ksx6bS7KVTkddHj4FSNuPVZxiFzf2OD4bRYSeBgwUn9vXOgXUr6sHIj+elncE7xxgC5VKmWHXv18hIBZTs+zSx3f4WiLws0UjmivvHiig2cWc6pFE64wc2VvFuMyfhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0u+lzw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D435C4CEE9;
	Mon, 19 May 2025 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690618;
	bh=A1yGfiEGjU/jCFLLlMoihWTgBNPiIjwSNSe9WDii04I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0u+lzw8mDvA9gp+eW5zaUTMK0Yi1JFv7zXkVhXfkvjhywdPzm3i6FkxnY/W5BMhf
	 o9js162JL5kbYNpLaZ2Z4NpqGKhJGWDLa4Mk26f0Zd7JGJrz+ttfR2UP7q+z1zvs86
	 3mskUEo8sBxYpq0Tli0DkBX6WDmGDRwpMGkBE7y62gkAzroOgWt4FmhTC7iV8mvpL0
	 zSHTVwK/lC3UnYDlIqFtfbaymQcBWk4CkQrm3he+H3bnRisxkBZ+ue5iW0Kj5XXvlR
	 kGLvwaULc7n4egAQd9sxJ5ejSLW3czHNk71051pve/VlFo6Gulg7eFYyE7kyrSm18F
	 R7bHyL54YolvA==
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
Subject: [PATCH v6 05/16] PCI/AER: Rename aer_print_port_info() to aer_print_source()
Date: Mon, 19 May 2025 16:35:47 -0500
Message-ID: <20250519213603.1257897-6-helgaas@kernel.org>
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

From: Jon Pan-Doh <pandoh@google.com>

Rename aer_print_port_info() to aer_print_source() to be more descriptive.
This logs the Error Source ID logged by a Root Port or Root Complex Event
Collector when it receives an ERR_COR, ERR_NONFATAL, or ERR_FATAL Message.

[bhelgaas: aer_print_rp_info() -> aer_print_source()]
Link: https://lore.kernel.org/r/20250321015806.954866-5-pandoh@google.com
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index dc8a50e0a2b7..eb42d50b2def 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -733,8 +733,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
-				const char *details)
+static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
+			     const char *details)
 {
 	u16 source = info->id;
 
@@ -932,7 +932,7 @@ static bool find_source_device(struct pci_dev *parent,
 	 * RCEC that received an ERR_* Message.
 	 */
 	if (!e_info->error_dev_num) {
-		aer_print_port_info(parent, e_info, " (no details found)");
+		aer_print_source(parent, e_info, " (no details found)");
 		return false;
 	}
 	return true;
@@ -1299,7 +1299,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 0;
 
 		if (find_source_device(pdev, &e_info)) {
-			aer_print_port_info(pdev, &e_info, "");
+			aer_print_source(pdev, &e_info, "");
 			aer_process_err_devices(&e_info);
 		}
 	}
@@ -1318,7 +1318,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 0;
 
 		if (find_source_device(pdev, &e_info)) {
-			aer_print_port_info(pdev, &e_info, "");
+			aer_print_source(pdev, &e_info, "");
 			aer_process_err_devices(&e_info);
 		}
 	}
-- 
2.43.0


