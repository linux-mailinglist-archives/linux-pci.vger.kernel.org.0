Return-Path: <linux-pci+bounces-31111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8FCAEE8E6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 23:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0658C1BC2911
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC9325C6E2;
	Mon, 30 Jun 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsrT9QP4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313721FF54;
	Mon, 30 Jun 2025 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317188; cv=none; b=lZ4W85osCM3hjHeHBpiF90noJjJWuwTgcp+HeOsg1mWymT3YFVjJfpjr8l84Vt8/wsZzC+TBjMzstn5mYJPTdIYli5wwgPRn/y4NAKiqLAg9qYApc/YrUlDYmGb3NfZznU9vjqQ2PydmG3te85inaheHt7AnMv7YySzEItu76r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317188; c=relaxed/simple;
	bh=ketVR18fpnW4xkFERzMsiFpAF9jtuIK0RiDKnTgJDp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L94ru+I5lN8AS6YAZU7mLv2E2sTNMBZ7MC5dMnz3EYghOwuDyTN2hDczIlfhIXHFEXe1oRfnYkdPyWIsUlj1SOivadcdS5CAuG8s5+Dw+EW3bShNSE78LzRLkNo2/s3r4T2nBpYnTzAJbClHMf1X5Wv4rvpGeK6hRZScZePXvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsrT9QP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A8EC4CEE3;
	Mon, 30 Jun 2025 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317187;
	bh=ketVR18fpnW4xkFERzMsiFpAF9jtuIK0RiDKnTgJDp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsrT9QP4hpSZ7+iQwvQyzaAvp1GqENjmzjxVMW5CHElpIZsdveY7ZfISw4/MalZ9A
	 PqUoJ8gH9qZzLjLKSyPVA3YqogUJo6yhFJgU59TEfxOPN+5lcvAVvfwux14jbKFKkg
	 /ucNlT5O1LOvmNEdkYTk9kzUoVjE5F3Gp9Bl/uDHNe3Rq34ceTbi81B3gLyJ1wI+Yo
	 lx0mpYFm+frK9fu90qugSwLtCducq1khGFWxcgWKLVNdsPA0Jn7iUiNM13c4CZkl4E
	 SlRsJiKJwbqX+cPyapCm+Du8rVMHHzC2RU7AJ/i5h/ATOzS0p0G2F/pma5pdXdgwjX
	 WUmgCGNEWVDeA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhe Qiao <qiaozhe@iscas.ac.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 05/21] Revert "PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()"
Date: Mon, 30 Jun 2025 16:45:20 -0400
Message-Id: <20250630204536.1358327-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204536.1358327-1-sashal@kernel.org>
References: <20250630204536.1358327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.35
Content-Transfer-Encoding: 8bit

From: Zhe Qiao <qiaozhe@iscas.ac.cn>

[ Upstream commit 2b8be57fa0c88ac824a906f29c04d728f9f6047a ]

This reverts commit 631b2af2f357 ("PCI/ACPI: Fix allocated memory release
on error in pci_acpi_scan_root()").

The reverted patch causes the 'ri->cfg' and 'root_ops' resources to be
released multiple times.

When acpi_pci_root_create() fails, these resources have already been
released internally by the __acpi_pci_root_release_info() function.

Releasing them again in pci_acpi_scan_root() leads to incorrect behavior
and potential memory issues.

We plan to resolve the issue using a more appropriate fix.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aEmdnuw715btq7Q5@stanley.mountain/
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20250619072608.2075475-1-qiaozhe@iscas.ac.cn
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and examination of the kernel code, I
need to determine if this revert should be backported.

**YES**, this commit should be backported to stable kernel trees.

## Extensive Explanation:

### 1. **Critical Double-Free Bug Fix**
This revert fixes a serious double-free bug introduced by commit
631b2af2f357. The code analysis reveals that when
`acpi_pci_root_create()` fails, it internally calls
`__acpi_pci_root_release_info()`, which then invokes the `release_info`
callback (`pci_acpi_generic_release_info()`). This callback already
frees:
- `ri->cfg` via `pci_ecam_free(ri->cfg)`
- `ci->ops` (which is `root_ops`) via `kfree(ci->ops)`
- `ri` via `kfree(ri)`

The explicit cleanup added by the reverted commit causes these resources
to be freed a second time, leading to memory corruption.

### 2. **Error Path Issue - High Impact**
The double-free occurs in the error handling path when
`acpi_pci_root_create()` fails. While this is not the common case,
PCI/ACPI initialization failures can occur due to:
- Hardware issues
- Firmware bugs
- Resource allocation failures
- Configuration problems

When such failures occur, the double-free can cause kernel crashes, data
corruption, or security vulnerabilities.

### 3. **Simple and Safe Fix**
The revert is straightforward - it removes the problematic error
handling code that was incorrectly added. The code changes show:
```diff
- if (!root_ops)
- goto free_ri;
+       if (!root_ops) {
+               kfree(ri);
+               return NULL;
+       }
```
This returns to the original, simpler error handling that only frees
what hasn't been passed to `acpi_pci_root_create()` yet.

### 4. **Matches Stable Backport Criteria**
This fix meets the stable kernel criteria:
- **Fixes a real bug**: Double-free causing potential crashes/corruption
- **Small and contained**: Only modifies error paths in one function
- **Already in Linus' tree**: This is a merged commit
- **No new features**: Pure bug fix
- **Low risk**: Reverts to previously known-working code

### 5. **Similar to Successful Backports**
Looking at the reference commits, this is similar to:
- "ARM64: PCI: Fix struct acpi_pci_root_ops allocation failure path"
  (Backported: YES) - Also fixed memory management in error paths
- "Revert 'PCI: acpiphp: Reassign resources on bridge if necessary'"
  (Backported: YES) - Also a revert fixing problematic behavior

The commit message explicitly states "We plan to resolve the issue using
a more appropriate fix," indicating the maintainers recognize there may
be an underlying issue to address, but the immediate concern is fixing
the double-free bug, making this suitable for stable backporting.

 drivers/pci/pci-acpi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e4173244..af370628e5839 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1676,19 +1676,24 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 
 	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops)
-		goto free_ri;
+	if (!root_ops) {
+		kfree(ri);
+		return NULL;
+	}
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg)
-		goto free_root_ops;
+	if (!ri->cfg) {
+		kfree(ri);
+		kfree(root_ops);
+		return NULL;
+	}
 
 	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		goto free_cfg;
+		return NULL;
 
 	/* If we must preserve the resource configuration, claim now */
 	host = pci_find_host_bridge(bus);
@@ -1705,14 +1710,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
-
-free_cfg:
-	pci_ecam_free(ri->cfg);
-free_root_ops:
-	kfree(root_ops);
-free_ri:
-	kfree(ri);
-	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
-- 
2.39.5


