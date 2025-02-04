Return-Path: <linux-pci+bounces-20694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A3A26F8A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 11:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD57B1880146
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294BE208992;
	Tue,  4 Feb 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fegEmxXK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF813C9D4
	for <linux-pci@vger.kernel.org>; Tue,  4 Feb 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666151; cv=none; b=Kdfs3YElSqwJ0Dx9dMjkLJh4U48gszMHe81tzGaWxGj/PFuPOdBXpEK0qCjvVSUmu9e8a8Qctb+qVBSjSjW9AAQ4oeEsTWsJM+oI1S5vLWeRIG+Kt1SSb27PGuRQEmLk8UDMUXprlVPTh8mSlU8kheMSQwJv+0glPQfmgU//Nm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666151; c=relaxed/simple;
	bh=1VvnRlA4HB5K0hDQ3uuD3lSzzTuQXpkQarseZUg1uHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owrPcIUP/d6WQ5TtgITtNNeAsyBY1tNzH5qmAjJEwChzOUxJ0t1jFmd2Tkad5tZDARQ3tdxouTO2rl87wvmdqqZTgQsAkuqH5sujv6UD7g0L3n1dYN1HheiKf/cYYXhd0m0LB8SIc/P9fiPiwVK9BVJlZPUWO6XhZIFjnS1yQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fegEmxXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3353CC4CEE4;
	Tue,  4 Feb 2025 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738666149;
	bh=1VvnRlA4HB5K0hDQ3uuD3lSzzTuQXpkQarseZUg1uHc=;
	h=From:To:Cc:Subject:Date:From;
	b=fegEmxXKz+GCUNJW7seGjhgdUPz0BjNGAMf/Jxv6WqeFmPrvrNxoXc1nBaRIT75gU
	 bxJ1tUAxANR25gdpvBtQ0PhNXonRdaLmMSzcsj9ETMexJaNvcmUxZH7FJCccJU4Z9q
	 KifMcvDV3kQouLSU6+o10CNATu500QyNYmN26iDeL9NVcS8YdeYhScvW+2OrJbTwXd
	 PL5SIMNtVvLsQ44V55g2/mU18uyX8is8chJNEuH0lghbbq4bGeLWqZBwsGXtdW5bVS
	 D/aFMIgijsUDl64GemB/HHLrUGV4ffwpUT55dTxBTqBeMynv79L+mnDZDvpMK5D04k
	 s3IArh7tONJaw==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] misc: pci_endpoint_test: Fix pci_endpoint_test_bars_read_bar() error handling
Date: Tue,  4 Feb 2025 11:48:04 +0100
Message-ID: <20250204104803.569684-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=cassel@kernel.org; h=from:subject; bh=1VvnRlA4HB5K0hDQ3uuD3lSzzTuQXpkQarseZUg1uHc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIXfkgW/8D9Ip4z9lnJf8bZnUfrawQLLYT+zeF8nHFCZ cr3Zz3NHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiI+Q6G/1WHfd6yfH8n0xl7 WeOvd/M6Pz7VOfwh+/1nFO+7ssD9+VpGhgNeT2YUPSxdHnjlYOikuzOfc2anmnGvr5rNrfFqAmN BIjsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
changed the return value of pci_endpoint_test_bars_read_bar() from false
to -EINVAL on error, however, it failed to update the error handling.

Fixes: f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a49386..6b881478b295 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
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


