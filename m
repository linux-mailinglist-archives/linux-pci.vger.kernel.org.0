Return-Path: <linux-pci+bounces-23475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F619A5D7CE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EE3189DBFB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E6232377;
	Wed, 12 Mar 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsoMAARq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250A232364;
	Wed, 12 Mar 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766811; cv=none; b=djv/YAAUKEltQsqORPFOl7ZXywDm4wasL/bp5xXBpDkU3QhH1ZeludPCF/kL7RXzNrD9wSzAsTBNiXRK280ApW6EQ9n72iylRq6lsq057As+R7ux5u96vQ2XNHHwyQPgpNuCPZi/45dhwZBGcrASKq95UCXcB2x79GZMLxeKvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766811; c=relaxed/simple;
	bh=8/aqzVkQhaCsfezDRLPycVmFSKSk0ZnXQ8yaaEJW60Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pr40HNpu7tIYIBascDd3JZO3G3WdvGK/ENIvIjBUOeC/p5YXyb41flW8IsRKgPjd4NW+jiwc5eb44pXZUQof7SsNzHtquxYQBRdxVIxqv+uovDWpJtxxZ2QuyVDFQZP6E473MFIFqBpvrQ6gMAWhaImIHIg5lIXLXm2fI2Lj5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsoMAARq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE246C4CEEA;
	Wed, 12 Mar 2025 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741766810;
	bh=8/aqzVkQhaCsfezDRLPycVmFSKSk0ZnXQ8yaaEJW60Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsoMAARqEI7pAj3h6fSaKPbdTl/tb1+CB5Rv1rlynbU8zn9TODlEvSqbd614Kl9L8
	 zq8VVaEx/6pRIx7+rorYfooD6ssaZGGqThufVWU0w5prMWDd7YMW66QIHPRLU1Zzsq
	 y/XYSoXzCF2LAlIGJmeQfINYLI27bu+fejH9vuoIO7Nzb7Zmj5uc7F7MjAW6M5lMR/
	 GEI+osKsFd4bzTHuhPBBGgOsywD/+5j/yyz24irRqIuDbMwxLJkQyCVw7ujQJGWg9O
	 Rq+tUqqSpCmqf8meSvc+rmtQkcXyVzlA896gETNvezdxNB4siPMXvWFd/fnbPidhA3
	 xa6FIaBGFyW3g==
From: Philipp Stanner <phasta@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: Fix wrong length of devres array
Date: Wed, 12 Mar 2025 09:06:34 +0100
Message-ID: <20250312080634.13731-3-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312080634.13731-2-phasta@kernel.org>
References: <20250312080634.13731-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The array for the iomapping cookie addresses has a length of
PCI_STD_NUM_BARS. This constant, however, only describes standard BARs;
while PCI can allow for additional, special BARs.

The total number of PCI resources is described by constant
PCI_NUM_RESOURCES, which is also used in, e.g., pci_select_bars().

Thus, the devres array has so far been too small.

Change the length of the devres array to PCI_NUM_RESOURCES.

Cc: <stable@vger.kernel.org>	# v6.11+
Fixes: bbaff68bf4a4 ("PCI: Add managed partial-BAR request and map infrastructure")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/pci/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3431a7df3e0d..728ed0c7f70a 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -40,7 +40,7 @@
  * Legacy struct storing addresses to whole mapped BARs.
  */
 struct pcim_iomap_devres {
-	void __iomem *table[PCI_STD_NUM_BARS];
+	void __iomem *table[PCI_NUM_RESOURCES];
 };
 
 /* Used to restore the old INTx state on driver detach. */
-- 
2.48.1


