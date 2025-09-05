Return-Path: <linux-pci+bounces-35503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E1B44D7E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 07:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82343ADAA0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 05:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDD5B21A;
	Fri,  5 Sep 2025 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKdG7fhG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D76FBF;
	Fri,  5 Sep 2025 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050125; cv=none; b=KjUmCHE8OZ9v6zp5W/DrQta8YdOZ3T0Mx2q27pgT6bwXslL6jPNOtSzOOQw+/p9hGjf6DFNRfGredWONLLggiAUlSl5R8DRgtlWKNEP7RkP7VL5JODYxWmfPpTmL+evVtcnj2ew7uyoNQgT8Zxyoi5H+5OYxS0glJLIycJlyBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050125; c=relaxed/simple;
	bh=rH5A0s5ImlEW8CCamjv0C9bsrZqiEVscDZ+4NlPYlew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PfcIh29JujrI9MRCvQevvhdcuEYYSx/2lfm2PkWu7scbzZPiemJgUXCERZY8B+o0nqcfHWE1CZ2YHsbQyToCEVbPKjQWW0oh3uMDpe8SJ6nRcP4uUK/RbMqUvGqDuyYpFZIneKUrfveaosJqILGxM+qOr16EsUGjDkbnF6GwAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKdG7fhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBB8C4CEF1;
	Fri,  5 Sep 2025 05:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757050124;
	bh=rH5A0s5ImlEW8CCamjv0C9bsrZqiEVscDZ+4NlPYlew=;
	h=From:To:Cc:Subject:Date:From;
	b=CKdG7fhG7H4kHHOx5HS4QTp1JSpgRQbIHQdtVLNAr3UIOVj50x7MXYwsq+k+KehSd
	 mu2aZnNzQys/eMtfhcbMsVH3K4ZY6D0KLCVQqgApn5U55nmqlzq9XUCoqqW/Z3xgde
	 dupJ/1WThnfz6MqlzUDKM2yfm3nuYtI9Qc2M3DKO52jgnSqQlgmCdO/SscLxI2Zd8V
	 ywmo5F5xkVxqhMtocGQey4+vvIqxvoRtm5qhXZtCfBFMNBqU4g72eyFE2R397uS0EZ
	 XUhoZtKy/1fGd/BajUuWrqsvL3eb1lnXeceknDJ8l5pBqtBYumXF8VLo9UHrNkuKWR
	 pugNCSE20bM+A==
From: Kees Cook <kees@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
Date: Thu,  4 Sep 2025 22:28:41 -0700
Message-Id: <20250905052836.work.425-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501; i=kees@kernel.org; h=from:subject:message-id; bh=rH5A0s5ImlEW8CCamjv0C9bsrZqiEVscDZ+4NlPYlew=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm7SjnXPZ7u2LPu+PQqrtY5ci8udk8qXaXSu0lkq7XcR 5/tdmEOHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMRymb472oaGKv+P06m8My6 MM8HUS9OHLkfPEfs0LQCrwXScYFf3jP8z1vKl/I/a5/jzaQGjyN2vzj/XS6UW1V78IGUe69akKk IMwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
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

Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: lkft-triage@lists.linaro.org
Cc: Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ben Copeland <benjamin.copeland@linaro.org>
Cc: <lkft-triage@lists.linaro.org>
Cc: <linux-pci@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..005b92e6585e 100644
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
2.34.1


