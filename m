Return-Path: <linux-pci+bounces-39317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF410C093DB
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 006B24EF0C4
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44794303CAE;
	Sat, 25 Oct 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtrolAhz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D82302756;
	Sat, 25 Oct 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408673; cv=none; b=O8tmOgeck+kzpJAc9D3dm08xvpweTR4lidqIWVNKybHWwZuGlKaqFICNki7XWsS9yIuJXSwF9YAIcf8kg7/8DL2hAUFpO54aJQUBPZz//lGc2edjLBM9Y0GL6ChOl7Oty1t8l4TqT8OsWcRUtUSxc75B8LgpN+DkxngGpR3bbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408673; c=relaxed/simple;
	bh=hMlWPjIszmAb/MPeUXQqD3XjgKIF7LxpDjvm1UzIS9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYY68EpD4nV4LeC6gOZs9lrWPcDvpmJDQLKoxx6Q/nVL6YKLOry0N/Kl+6lT1P2DoBG6XzWCTd5EfIxr5xyCK7J+huknJC3av119VMDCrBic7iYqsli/MM3FnntMokPfhYSjhql08Ej/n7Q1hrdXwDw19lKjBgo4B+AW+oI67Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtrolAhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29611C4CEFF;
	Sat, 25 Oct 2025 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408673;
	bh=hMlWPjIszmAb/MPeUXQqD3XjgKIF7LxpDjvm1UzIS9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtrolAhzUcSE2+mIUmq9uZp3c7JhOgmNxOAyD1pQg/5rbNQacFjhDtEK5GDC7KNH8
	 xVQD253ghsPVh1uWxobyynMioMkTl1zblqet0P4Qh18wvShPcuPkVtWMmrrliKVo7p
	 RaFvtfMFFxP7psoR062IYflf1C0+gW95u1H6xjdXOUD5MWaYQvlhLCSbS7LICIKcTZ
	 Q7N6KqvldSgJ3Bfx/PqendryDHSTvs5fjKgGt6RE7CJ7yly+hePyHPn+/Ry3UFti3D
	 uIbEvoBAdeG0c1l4lxTCVRFxgE4ylEsfePVLYEA6SEbnKDeKw6rgQh2dFwrRYV6BjN
	 mRP1SykYpofJg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kwilczynski@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] selftests: pci_endpoint: Skip IRQ test if IRQ is out of range.
Date: Sat, 25 Oct 2025 11:54:29 -0400
Message-ID: <20251025160905.3857885-38-sashal@kernel.org>
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

[ Upstream commit 106fc08b30a2ece49a251b053165a83d41d50fd0 ]

The pci_endpoint_test tests the entire MSI/MSI-X range, which generates
false errors on platforms that do not support the whole range.

Skip the test in such cases and report accordingly.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
[mani: reworded description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250804170916.3212221-4-christian.bruel@foss.st.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

**Why This Fix Matters**
- Prevents false test failures: The tests iterate full MSI/MSI-X ranges
  regardless of what was actually allocated on the device. When a vector
  index is out of range, the kernel returns -EINVAL, which the old test
  treated as a failure.
- Skips unsupported cases correctly: The new checks treat out-of-range
  vectors as “not applicable” and mark the test as skipped, which
  accurately reflects platform capability instead of reporting an error.

**What Changed (Selftests Only)**
- In `tools/testing/selftests/pci_endpoint/pci_endpoint_test.c:122` and
  `:140`, after triggering an IRQ:
  - MSI loop: `pci_ep_ioctl(PCITEST_MSI, i);` then `if (ret == -EINVAL)
    SKIP(return, "MSI%d is disabled", i);` (`tools/testing/selftests/pci
    _endpoint/pci_endpoint_test.c:123`–`:126`)
  - MSI-X loop: `pci_ep_ioctl(PCITEST_MSIX, i);` then `if (ret ==
    -EINVAL) SKIP(return, "MSI-X%d is disabled", i);` (`tools/testing/se
    lftests/pci_endpoint/pci_endpoint_test.c:141`–`:144`)
- Uses existing kselftest skip mechanism (`SKIP(...)`) which is well-
  established in the harness
  (`tools/testing/selftests/kselftest_harness.h:110`–`:134`).

**Why -EINVAL Means “Out of Range” Here**
- The endpoint test driver queries the Linux IRQ number for a given
  vector via `pci_irq_vector(pdev, msi_num - 1)`, and immediately
  returns that error when negative
  (`drivers/misc/pci_endpoint_test.c:441`–`:443`).
- `pci_irq_vector()` returns -EINVAL precisely when the vector index is
  out of range/not allocated for the device
  (`drivers/pci/msi/api.c:311`–`:324`), which happens when the device
  supports fewer MSI/MSI-X vectors than the upper bound tested (MSI up
  to 32, MSI-X up to 2048).

**Scope and Risk**
- Small, contained change; affects only kselftests (no runtime kernel
  code).
- No API or architectural changes; just improves test correctness by
  skipping unsupported cases.
- Mirrors existing skip behavior already used in the same test suite
  (e.g., BAR test skips when disabled,
  `tools/testing/selftests/pci_endpoint/pci_endpoint_test.c:67`–`:70`).
- No security impact.

**Stable Backport Criteria**
- Fixes a real issue that affects users of stable kernels running
  selftests (false negatives on platforms with limited MSI/MSI-X
  vectors).
- Minimal risk and fully confined to `tools/testing/selftests`.
- Does not introduce new features; aligns with stable policy for test
  fixes.

Given the above, this is a good candidate for stable backport.

 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index da0db0e7c9693..cd9075444c32a 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -121,6 +121,8 @@ TEST_F(pci_ep_basic, MSI_TEST)
 
 	for (i = 1; i <= 32; i++) {
 		pci_ep_ioctl(PCITEST_MSI, i);
+		if (ret == -EINVAL)
+			SKIP(return, "MSI%d is disabled", i);
 		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI%d", i);
 	}
 }
@@ -137,6 +139,8 @@ TEST_F(pci_ep_basic, MSIX_TEST)
 
 	for (i = 1; i <= 2048; i++) {
 		pci_ep_ioctl(PCITEST_MSIX, i);
+		if (ret == -EINVAL)
+			SKIP(return, "MSI-X%d is disabled", i);
 		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI-X%d", i);
 	}
 }
-- 
2.51.0


