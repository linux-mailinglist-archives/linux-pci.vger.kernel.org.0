Return-Path: <linux-pci+bounces-20695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A2A26FD3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 12:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6617B3A8376
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D520AF97;
	Tue,  4 Feb 2025 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeWZjn7I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8016B3A1
	for <linux-pci@vger.kernel.org>; Tue,  4 Feb 2025 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667205; cv=none; b=ZL9hUIr9D/iDYJl/6XUqksBo9Anox/D4ahteRYGSGqgabsojSVzl+3GmdI9r7WvVOHCeYmr5tQu2NU9f5NBOfVtZaa+BrZIar4GqvxNaUqL9LOdt7dxW96V8hwuvhys+le9OMUy3bwUM/Vsxgn4jGxohRlgx4nBv+ZnUtnAjYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667205; c=relaxed/simple;
	bh=MHHCj5oTqb53y87XRBk6qdxXa0JUQc/s9ZyYDOwxyLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuKnz4mIZtGE9GUymdZjB2HSTWE/uz7VrAPjBz/K3u0jRNqt2/K8+oy8wMyEmiKcS7ZSmFwxxCPtOTYWlLCZ0pperCX7txlRB/NTpFMooJLeoD9dEv6IinX6v+iOoqg2BOIx9KRgQDK7N0YJd9nxTUhaHuRO9ztZ+OV2Feshk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeWZjn7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1546FC4CEDF;
	Tue,  4 Feb 2025 11:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738667205;
	bh=MHHCj5oTqb53y87XRBk6qdxXa0JUQc/s9ZyYDOwxyLA=;
	h=From:To:Cc:Subject:Date:From;
	b=BeWZjn7IXZ2acATxM5CljqV3P+bYms+VPdvmK7L43IKhpDNMUUyKx2KIecjRfPRzS
	 rmeGIJgG+VrDrEt1cOQq/LG2QiidVtKHEhTXMTFXIOK6Gedo4DD4kJt2Om8fHEtlcO
	 5ReM9vHAd0qrXq9AZjAYZLwBlYsurVOH8MoTRB2jjudR6uGULwTsDuLwISr+JcgEEQ
	 sBTFyNUFyuooyNMHKrdVHe2L9VaX7tUR/IFcl7fJy17D41II09qCtlnky77NpBGPsP
	 PxtN84pwagiI5zedGtdHMcTx0HZJe9EU6r3sndDfTlWLE0aF1xRwyePjE/rZ5TDV5N
	 xDSNnZ5IhRDug==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] misc: pci_endpoint_test: Fix pci_endpoint_test_bars_read_bar() error handling
Date: Tue,  4 Feb 2025 12:06:41 +0100
Message-ID: <20250204110640.570823-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=cassel@kernel.org; h=from:subject; bh=MHHCj5oTqb53y87XRBk6qdxXa0JUQc/s9ZyYDOwxyLA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIXfjnQuFx2Y1uxnOJ6i0ORIa/bmRlX8qdufOL/WKIg8 EPBuulHOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRG78Z/ukttS1aEv9gS7m+ hOi5n1Ps2qIdK/6wcNnE71dubFv/4S4jw+2jO7d/iRS53+F38sRU1qXPfjy4xl3+OfbdYpdgpVP vd/EDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
changed the return value of pci_endpoint_test_bars_read_bar() from false
to -EINVAL on error, however, it failed to update the error handling.

Fixes: f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Changed the type of the variable ret to int to match the new return type.

 drivers/misc/pci_endpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a49386..7584d1876859 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -382,7 +382,7 @@ static int pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
 static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 {
 	enum pci_barno bar;
-	bool ret;
+	int ret;
 
 	/* Write all BARs in order (without reading). */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
@@ -398,7 +398,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar]) {
 			ret = pci_endpoint_test_bars_read_bar(test, bar);
-			if (!ret)
+			if (ret)
 				return ret;
 		}
 	}
-- 
2.48.1


