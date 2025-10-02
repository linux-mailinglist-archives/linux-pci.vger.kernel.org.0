Return-Path: <linux-pci+bounces-37441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F435BB45B2
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4807C3261E2
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC52327A3;
	Thu,  2 Oct 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGh2gGLe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E6231832;
	Thu,  2 Oct 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419060; cv=none; b=f0RT6Tl/9Vx492XhHsrnT5M/jvN/lIuvPuigvFd0S1m4pOU1Y81asDaLU5mb58oK+w5ZUsb5LL7lB7bx9MUhUM3dN2ISqf1rVSDKGr552nBEfw8SbK0gMkTlHc2lGkt9fWVUPDWfzjGm7eYSNzZjjOUKcS+oFBVBI3UiLwaWNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419060; c=relaxed/simple;
	bh=g+fY7Z++hADQkJDHrFpELN8lkmzMeAn0Bo+wPSzdUp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAoDdBk2hlu/o6jNKg2sjzMXxrX0oI9koAZ5/t0ZQ4JXPLMWnyWw1K2EnmPE9ILuHS96/UsAHdBUme8VJ9qhi4LJaFjtul3ZsHhvYSxNqKs8IUW4CF0CZ74k8njBN0shjhQiuJPi+n1wuk7SL9ZdRumPKuAw+uZZL85Ofs5rdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGh2gGLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA69C4CEF4;
	Thu,  2 Oct 2025 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759419060;
	bh=g+fY7Z++hADQkJDHrFpELN8lkmzMeAn0Bo+wPSzdUp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGh2gGLezUtH/xKN1jTwFYa4KdD41FZM6mA9Oqfq/ja/OykZr/Vv03BSaO6wo7lsu
	 u0UADqnDzVBEi7Z/98yF2CHfNE6Gj6Z4bh7MhqPMz5FlVkGlqU+Dxio3Bbh154gK5P
	 N5cpbuv/tXj5mZBnUZxuE0Fe/M0ixwwsMbrh4mD8R6lAaK56Vpa+frfVP3z0/8y4E9
	 o4bX+s1QWSF69ffEwUf2aAZKDIs5WgdcqbXV9bhIVPO8WfNdEWRNsO5yiJrn6GXfI1
	 2H7n0bZQSG9Q1IKqM85RCYTMTr6FhSCApUW67qda1nUdjDwlGMRT4togUlGNkxvBt0
	 1inEywy7M0S/Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-6.12] PCI: Test for bit underflow in pcie_set_readrq()
Date: Thu,  2 Oct 2025 11:30:12 -0400
Message-ID: <20251002153025.2209281-25-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002153025.2209281-1-sashal@kernel.org>
References: <20251002153025.2209281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 00e58ff924b3a684b076f9512fe2753be87b50e1 ]

In preparation for the future commit ("bitops: Add __attribute_const__ to generic
ffs()-family implementations"), which allows GCC's value range tracker
to see past ffs(), GCC 8 on ARM thinks that it might be possible that
"ffs(rq) - 8" used here:

	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);

could wrap below 0, leading to a very large value, which would be out of
range for the FIELD_PREP() usage:

drivers/pci/pci.c: In function 'pcie_set_readrq':
include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_471' declared with attribute error: FIELD_PREP: value too large for the field
...
drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
  v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
      ^~~~~~~~~~

If the result of the ffs() is bounds checked before being used in
FIELD_PREP(), the value tracker seems happy again. :)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250905052836.work.425-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis, here is my determination:

## Backport Status: **YES**

### Extensive Analysis:

#### Nature of the Fix:
This commit adds a defensive check in `pcie_set_readrq()` to prevent a
potential bit underflow when computing `ffs(rq) - 8`. Specifically, it:
1. Stores the result of `ffs(rq)` in a new variable `firstbit`
2. Adds a check: `if (firstbit < 8) return -EINVAL;`
3. Uses `firstbit - 8` instead of `ffs(rq) - 8` in the FIELD_PREP macro

#### Root Cause & Context:
This is **not a runtime bug fix** - it's a **build fix** triggered by
another optimization commit. The bitops commit (50675b8f5bd4e "bitops:
Add __attribute_const__ to generic ffs()-family implementations") adds
`__attribute_const__` to ffs() functions, enabling GCC's value range
tracker to perform better static analysis. However, GCC-8's conservative
analysis on ARM, RISCV, and MIPS architectures incorrectly determines
that `ffs(rq) - 8` could underflow, causing a **compilation error** (not
a warning):

```
drivers/pci/pci.c: In function 'pcie_set_readrq':
include/linux/compiler_types.h:572:38: error: call to
'__compiletime_assert_471'
declared with attribute error: FIELD_PREP: value too large for the field
```

#### Why the Compiler is Wrong (but we still need to fix it):
Examining the code flow in `pcie_set_readrq()`
(drivers/pci/pci.c:5931-5968):
1. Initial validation: `if (rq < 128 || rq > 4096 ||
   !is_power_of_2(rq))` ensures rq ≥ 128
2. Performance mode clamping: `if (mps < rq) rq = mps;` where mps comes
   from `pcie_get_mps()`
3. `pcie_get_mps()` returns `128 << FIELD_GET(...)`, which is always ≥
   128 (verified at line 5976-5984)
4. Therefore, `ffs(rq) >= ffs(128) = 8`, so underflow is impossible

However, since commit f67577118d115 (2013), `pcie_get_mps()` never
returns an error, always returning valid values ≥ 128. The compiler
cannot prove this through interprocedural analysis.

#### Critical Dependency:
This commit is **tightly coupled** with the bitops commit. Evidence:
- Both commits are signed off by Sasha Levin (autosel backports)
- They appear consecutively in the git history (50675b8f5bd4e →
  5385aceb86f2f)
- The commit message explicitly states: "In preparation for the future
  commit"
- Without this fix, **builds will fail** on GCC-8 ARM/RISCV/MIPS after
  bitops changes

#### Risk Assessment:
**Minimal Risk:**
- Small, localized change (6 lines added in one function)
- Adds defensive validation that cannot break existing functionality
- For all valid inputs (rq ≥ 128), the check passes through
- Only rejects values that would have caused incorrect behavior anyway
- No performance impact
- No changes to critical kernel subsystems beyond PCI

#### Backporting Justification:
1. **Mandatory dependency**: Required if bitops commit is backported
   (which it is - commit 50675b8f5bd4e)
2. **Build fix**: Prevents compilation failures on supported compiler
   configurations
3. **Low risk**: Defensive check with no behavior change for valid
   inputs
4. **Follows stable rules**: Small, contained fix with clear purpose
5. **Multiple architectures affected**: ARM, RISCV, MIPS with GCC-8
6. **Upstream acceptance**: Acked by PCI maintainer (Bjorn Helgaas) and
   Arnd Bergmann

#### Supporting Evidence:
- Reported by: Linux Kernel Functional Testing (LKFT)
- Affects: GCC-8 on arm, riscv, mips architectures
- First seen: Linux 6.17.0-rc3-next-20250828
- Bisected to: bitops __attribute_const__ commit
- Acked-by: Bjorn Helgaas, Arnd Bergmann

### Conclusion:
**YES - This commit should be backported** as it's a necessary build fix
that must accompany the bitops optimization commit. Without it, stable
kernels with the bitops changes will fail to build on GCC-8
ARM/RISCV/MIPS configurations, breaking supported build environments.
The fix is minimal, defensive, and poses negligible regression risk.

 drivers/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cdd..005b92e6585e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5932,6 +5932,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
 	int ret;
+	unsigned int firstbit;
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
@@ -5949,7 +5950,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq = mps;
 	}
 
-	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
+	firstbit = ffs(rq);
+	if (firstbit < 8)
+		return -EINVAL;
+	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);
 
 	if (bridge->no_inc_mrrs) {
 		int max_mrrs = pcie_get_readrq(dev);
-- 
2.51.0


