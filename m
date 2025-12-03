Return-Path: <linux-pci+bounces-42596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FCACA1D00
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 23:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37353008FA8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 22:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF212D978A;
	Wed,  3 Dec 2025 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnIeqTQ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6432398FAA;
	Wed,  3 Dec 2025 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800716; cv=none; b=Mq31Kwu6smF+ZLUuEzC3W4F4ffdC30Kx15cvfT82Xsbf8GXbFFYxw9T2E2GvusiOkybjrSXWv9a2V8e1lLM+IEoth3j28z/soot4c3KV5OA2bIbcv5hcvQwGsxDKkYg4K47qdAQSP3T1VXqwXK0N9AdqRgt23O62JUMkLLXGbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800716; c=relaxed/simple;
	bh=Lz20JYhG2Ks2qngtuOg6zMoA7OAff3BZFOWUwsfcYKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ua4v3d9egx/EdR9zmhl8mi+UkxE1BK3fvVlpkJN2IVVHFspQqm2i0yfrlJl9PyJx+YZnrPTFoDUGAaW0iu90rysPqZuHf/gdSZomB/OSZUsybyegLxncM74LJ65Cx+j3RtjCYheMBDuMsg5ZU6qKwz8VGzBUWdIqkynI22Ogv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnIeqTQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B72C4CEF5;
	Wed,  3 Dec 2025 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764800715;
	bh=Lz20JYhG2Ks2qngtuOg6zMoA7OAff3BZFOWUwsfcYKI=;
	h=From:Date:Subject:To:Cc:From;
	b=WnIeqTQ+cdqNYnAy6sNbFCNTx4qk0M4TCU8OHTZAU/NsQ8tGp7XERtQJA/A3jOOe3
	 CthzZaoWxQCsufIZK1jA9YsfugBqCTKuZfhtyPKbXy92i7dn7A8On9fS4zf47A70zF
	 nSoyCKmnelIHdkDUhpArP30I7/cGHBgfKJq04RRGyF0q7qSdtPCL7nW49F8fEs3C5V
	 i6m+NZEyh7D9N+IZ9TzHPuVnZrySsxs/P//dOHW3QZ0ofYNdDgOadhL4BH/NC6ikWL
	 frUCc2Yur85IKbTxPp89cj7ntGh1iDvFdn5Wq98SlKU7IeEnLRIb681kvLVOmn5LtG
	 kg5Ej0fUZw2Tw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 03 Dec 2025 15:25:07 -0700
Subject: [PATCH] virt: Fix Kconfig warning when selecting TSM without
 VIRT_DRIVERS
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-fix-pci-tsm-select-tsm-warning-v1-1-c3959c1cb110@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMK4MGkC/yWNSw6DMAwFr4K8rqUQQEi9StUFJIYa0RTF4SMh7
 o6huzeLmbeDUGQSeGY7RFpY+BcU8kcG7tOEnpC9Mlhjq9yaAjvecHKMSb4oNJJL91ybGDj0WHl
 f29K7uiQDGpkiqXEfvN5/lrkdVLuqcBwnhrqPb4IAAAA=
X-Change-ID: 20251203-fix-pci-tsm-select-tsm-warning-5dd724dc74e0
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, 
 linux-pci@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Lz20JYhG2Ks2qngtuOg6zMoA7OAff3BZFOWUwsfcYKI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJkGO05eu3vg7N91G36nWG7aVcPL6S8a8KKd/eQa+2cTj
 pXbBS6q7ihlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQAT4ZjByHBc6H8G98Ndf20k
 f0U7Lp164k1sHofVRF9XrW2xaSs1vOcxMrza0l1kEOaefv+IhP33N0cuR9b8DnH8dPfbkkcu8cZ
 6v7kB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link
Encryption"), there is a Kconfig warning when selecting CONFIG_TSM
without CONFIG_VIRT_DRIVERS:

  WARNING: unmet direct dependencies detected for TSM
    Depends on [n]: VIRT_DRIVERS [=n]
    Selected by [y]:
    - PCI_TSM [=y] && PCI [=y]

CONFIG_TSM is defined in drivers/virt/coco/Kconfig but this Kconfig is
only sourced when CONFIG_VIRT_DRIVERS is enabled. Since this symbol is
hidden with no dependencies, it should be available without a symbol
that just enables a menu.

Move the sourcing of drivers/virt/coco/Kconfig outside of
CONFIG_VIRT_DRIVERS and wrap the other source statements in
drivers/virt/coco/Kconfig with CONFIG_VIRT_DRIVERS to ensure users do
not get any additional prompts while ensuring CONFIG_TSM is always
available to select. This complements commit 110c155e8a68 ("drivers/virt:
Drop VIRT_DRIVERS build dependency"), which addressed the build issue
that this Kconfig warning was pointing out.

Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511140712.NubhamPy-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/virt/Kconfig      | 4 ++--
 drivers/virt/coco/Kconfig | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index d8c848cf09a6..52eb7e4ba71f 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -47,6 +47,6 @@ source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
 
-source "drivers/virt/coco/Kconfig"
-
 endif
+
+source "drivers/virt/coco/Kconfig"
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index bb0c6d6ddcc8..df1cfaf26c65 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -3,6 +3,7 @@
 # Confidential computing related collateral
 #
 
+if VIRT_DRIVERS
 source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/pkvm-guest/Kconfig"
@@ -14,6 +15,7 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+endif
 
 config TSM
 	bool

---
base-commit: 4be423572da1f4c11f45168e3fafda870ddac9f8
change-id: 20251203-fix-pci-tsm-select-tsm-warning-5dd724dc74e0

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


