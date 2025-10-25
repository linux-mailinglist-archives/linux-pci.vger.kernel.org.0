Return-Path: <linux-pci+bounces-39324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D147C09965
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A52EE4F0C6F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD4D27A444;
	Sat, 25 Oct 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+bodoc6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A087278165;
	Sat, 25 Oct 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409292; cv=none; b=WDpZxObSWhag9sVgKlo46RCcclHVsoIP+bn/kJPWHtBhldvpJQhaJT0Zmvj22dK1YdCpq63SgD7oN6t7XP9Uc+tBGHNA/t0YSmXfdJS9uGiJnJPxRSUAsawlfjvtywAxTb+ZVVRyaQuepr6try0jOBUr2Z7g0VR2ugGHOK+YGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409292; c=relaxed/simple;
	bh=A+4ql5Hfcsty8pn7TphhOYuosXBMtNh1B3DEM40cS7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beIxwrKxguTZTX2DJrvaavJrRHsvKFhn03CG41QhpNBmR+fOyl2USHg2EQRyLO/sS/1xld46sQZl8s4LFNDDS+yCS8QKMmaV7yv9q+z7ylfG7xt0DcNM2kXLtkJlP9hIDD2zb5/F2GbbiVvH2h4JGTixLmYV9tH/StHd3XDpWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+bodoc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88617C19422;
	Sat, 25 Oct 2025 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409292;
	bh=A+4ql5Hfcsty8pn7TphhOYuosXBMtNh1B3DEM40cS7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+bodoc6nP5H+XUxHW16dljrl8rnEtWnv5PMvOgYmNxVYzpzDlPBvzradDqV+OtBh
	 /rEauBS9BLRBPkzkEDOybfyT+r9qf7OGqZ8ZglCK67kNPAjOLRPe7TG56kGNuA2fqO
	 0DoBtvwOVkYX6Pc7HJT8TpC+w0vdgWK2Cfl58wNBde3oLp4xdACe6fNMnCgM4gUi96
	 RXKBu16zsOPCm56GJiqz2ukSq+C3JBk10/eR6RyRtaRqzB1xLP3nkx692zTX9oFf7X
	 nneG/fbNT7Htv5PO4W2Wj1gV5No0dUfcYb04IEwZD9khXL9eW2DRUc1AWjhvHSwrYe
	 gNyhtTK1mWRxg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] misc: pci_endpoint_test: Skip IRQ tests if irq is out of range
Date: Sat, 25 Oct 2025 11:58:15 -0400
Message-ID: <20251025160905.3857885-264-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Bruel <christian.bruel@foss.st.com>

[ Upstream commit cc8e391067164f45f89b6132a5aaa18c33a0e32b ]

The pci_endpoint_test tests the 32-bit MSI range. However, the device might
not have all vectors configured. For example, if msi_interrupts is 8 in the
ep function space or if the MSI Multiple Message Capable value is
configured as 4 (maximum 16 vectors).

In this case, do not attempt to run the test to avoid timeouts and directly
return the error value.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250804170916.3212221-2-christian.bruel@foss.st.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation:
- What it fixes: The endpoint host test currently tries every MSI/MSI-X
  vector in the nominal 32/2048 range even when the device only enabled
  fewer vectors. For disabled/out-of-range vectors, no interrupt ever
  arrives from the endpoint side, so the host side waits 1 second and
  fails with a timeout (-ETIMEDOUT) per attempt. This is both slow and
  semantically wrong: the error is “invalid vector” rather than
  “timeout”.
- Core change: The patch adds an early range check using
  `pci_irq_vector()` before attempting to trigger an interrupt. If the
  requested vector is not valid for the device, it returns immediately
  with the error from `pci_irq_vector()` (typically -EINVAL), skipping
  the test and avoiding a 1s timeout.
  - Early check added: drivers/misc/pci_endpoint_test.c:441-444
    - `irq = pci_irq_vector(pdev, msi_num - 1);`
    - `if (irq < 0) return irq;`
  - Trigger and wait unchanged otherwise:
    drivers/misc/pci_endpoint_test.c:445-456
  - Post-wait verification now uses the pre-fetched `irq` value:
    drivers/misc/pci_endpoint_test.c:457-460
- Previous behavior (pre-patch): The test wrote the registers and waited
  up to 1s for completion, then only after success called
  `pci_irq_vector()` to compare the vector number. If the vector was
  actually invalid, the wait timed out first and the function returned
  -ETIMEDOUT, masking the real reason and wasting time.
- Alignment with selftests: Kselftests iterate through the full
  MSI/MSI-X ranges and expect -EINVAL for disabled vectors in order to
  SKIP them rather than fail:
  - MSI test expects -EINVAL to SKIP:
    tools/testing/selftests/pci_endpoint/pci_endpoint_test.c:122-127
  - MSI-X test expects -EINVAL to SKIP:
    tools/testing/selftests/pci_endpoint/pci_endpoint_test.c:140-145
  This change makes the driver return -EINVAL for out-of-range vectors,
matching selftests and preventing spurious failures/timeouts.
- Scope and risk:
  - Small, contained change in a single helper:
    drivers/misc/pci_endpoint_test.c:434-461.
  - No architectural changes; only the order of operations and error
    path are adjusted.
  - `pci_irq_vector()` has well-defined semantics and returns -EINVAL
    for out-of-range vectors (drivers/pci/msi/api.c:309-320).
  - Functional behavior for valid vectors is unchanged; the post-wait
    check still verifies the exact IRQ delivered (`irq ==
    test->last_irq`).
  - The only user-visible change is the error code for invalid vectors
    (-EINVAL instead of -ETIMEDOUT), which aligns with the intended API
    usage and the selftests.
- Backport criteria:
  - Fixes a real user-visible issue (spurious timeouts and failing tests
    when not all vectors are configured).
  - Minimal and low risk; confined to the pci_endpoint_test driver.
  - No new features; no impact on core PCI or IRQ subsystems.
  - Improves test reliability and reduces needless delays.

Given these points, this is a good candidate for stable backport.

 drivers/misc/pci_endpoint_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f935175d8bf55..506a2847e5d22 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -436,7 +436,11 @@ static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 {
 	struct pci_dev *pdev = test->pdev;
 	u32 val;
-	int ret;
+	int irq;
+
+	irq = pci_irq_vector(pdev, msi_num - 1);
+	if (irq < 0)
+		return irq;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
 				 msix ? PCITEST_IRQ_TYPE_MSIX :
@@ -450,11 +454,7 @@ static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	if (!val)
 		return -ETIMEDOUT;
 
-	ret = pci_irq_vector(pdev, msi_num - 1);
-	if (ret < 0)
-		return ret;
-
-	if (ret != test->last_irq)
+	if (irq != test->last_irq)
 		return -EIO;
 
 	return 0;
-- 
2.51.0


