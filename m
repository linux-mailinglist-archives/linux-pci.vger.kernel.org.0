Return-Path: <linux-pci+bounces-27219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C00AAAE19
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D110B1BA0B89
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C42D37FC;
	Mon,  5 May 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK2Ic1vN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA72C2FB5;
	Mon,  5 May 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485117; cv=none; b=Der2wrlexbgEP6wLfRgNXCpuW/hqDSE8h3VzbkZ+Uhdp5slDjlQIIufPx1knkE2nbuM7JXcCSRQECubKjf8vl0PKfBO7ZEVevIEinPVlZ2Cko2L3YXrfhQo7HazQ13qbHyY/osyx52YikR+mV5JUiXfIG53ea/sa82JM3XjbeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485117; c=relaxed/simple;
	bh=DOMQdMoulpJm9HfsDdMRhCyd63nj7nNC6JWstqRzidA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJJV6qGGFTbpLB0OA9ObyOfHsna7zfp6KT5vjZfLWvnDP/39CrpkDU7sHBNVz26UWc9NvPUFQFzg7lfiS1iPZuxqQtYsCrJ8xCWJ5dYhE/+fx8h5mvhSL36Hw/8cA3eTkoK9XpiT2Oco1S8NiUyhDSXce2XWQxDkpoXs2PR/mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK2Ic1vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCF1C4CEED;
	Mon,  5 May 2025 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485116;
	bh=DOMQdMoulpJm9HfsDdMRhCyd63nj7nNC6JWstqRzidA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aK2Ic1vNNjWtvcjtmzBgPbSJquof7aqREgw22q1bMsAFcI8nQSVvIqcuxixPFDrLI
	 p+dGlB+7j3T9hcYYaAeE1vNnsWqj1y971IIZQUlWktTnsO3df2hUtPUrcWTCpN2X2o
	 egm5u0j2m5R1lTD5WiQ+da3PBOMua9hTLQP7kHFbvBhNwZ9ghJJfdQnOWfDspE2je4
	 0mOZ9y1+vHAtT7me39A9rV2DHJ4840IVr2KQaMCVK8/lDaxbOyYPtRC9WTWcODRTZh
	 DzmgzTa/nHRIpolv18SgbnOL1s0Px+SavT0+S5Fb1nDhbDEGUFIelzHSEZeGTrAMaX
	 Bc6ooZsy3LR4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kw@linux.com,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 170/486] misc: pci_endpoint_test: Give disabled BARs a distinct error code
Date: Mon,  5 May 2025 18:34:06 -0400
Message-Id: <20250505223922.2682012-170-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 7e80bbef1d697dbce7a39cfad0df770880fe3f29 ]

The current code returns -ENOMEM if test->bar[barno] is NULL.

There can be two reasons why test->bar[barno] is NULL:

  1) The pci_ioremap_bar() call in pci_endpoint_test_probe() failed.
  2) The BAR was skipped, because it is disabled by the endpoint.

Many PCI endpoint controller drivers will disable all BARs in their
init function. A disabled BAR will have a size of 0.

A PCI endpoint function driver will be able to enable any BAR that
is not marked as BAR_RESERVED (which means that the BAR should not
be touched by the EPF driver).

Thus, perform check if the size is 0, before checking if
test->bar[barno] is NULL, such that we can return different errors.

This will allow the selftests to return SKIP instead of FAIL for
disabled BARs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250123120147.3603409-3-cassel@kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index e22afb420d099..f05256b7c2084 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -287,11 +287,13 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
 
+	bar_size = pci_resource_len(pdev, barno);
+	if (!bar_size)
+		return -ENODATA;
+
 	if (!test->bar[barno])
 		return false;
 
-	bar_size = pci_resource_len(pdev, barno);
-
 	if (barno == test->test_reg_bar)
 		bar_size = 0x4;
 
-- 
2.39.5


