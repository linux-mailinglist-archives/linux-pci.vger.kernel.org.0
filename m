Return-Path: <linux-pci+bounces-19417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5345A04158
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58971887091
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338781E9B35;
	Tue,  7 Jan 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="F8vsNASp"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981B156F3F;
	Tue,  7 Jan 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258303; cv=none; b=ikYjwT7gsC7uPkXK7yi2sTb83HsG6H52QAm2cCzQCEuFeLzQcb1GNNcyUqOwKN4XlYixpWRv38PCQSofyogSAwg19OYaoW/9EH2PMFyEKi833XTQGzhOx22UXXOPoD+Ns373tkGh45fQfruPFZQMvdRVy+dwVFtC5hk5LhIjzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258303; c=relaxed/simple;
	bh=hvmF2G+QyQTwEd0DImfqLbOwhIsQiy6O0tbU3HTjok0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Q73dpiffov0CmRo3q8CEtfjgbEttnSomcxJ3S2EdXautKTFNDyawbnaTquUzuNYemaBF5opAQflDm+gs/VR8VTIrPcveEu3VJ+bP5nob1Hp90NxUAPBGyF9ch5ryuOo0CU4GfLXVIJypyOQLda6v3HyKf9Gsm/NO7aV0xLA/XwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=F8vsNASp; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736257987; bh=4WImHf7ibhl0oIG2DZWRQ3D6E5qWafRBol0+xL22Ydg=;
	h=From:To:Cc:Subject:Date;
	b=F8vsNASp+cLDeVsoiqYkzAcqhXRDqg9YVRg1vPkyRT8/k9sdAwVn4cGkFwlERTXSC
	 tAPFTb2csxVYm8mfZyudLHR/6SWvcdwZa1e32xb30x1587pNIlUYCFK6x2xLerB1qi
	 fZQ3cNkmRxqCFOyIiTUcjr+CrIb4a4Fee1XjccIs=
Received: from Ubuntu.. ([240e:305:25d4:e300:6504:4e8:136:29f6])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id CD9B7810; Tue, 07 Jan 2025 21:51:25 +0800
X-QQ-mid: xmsmtpt1736257885tbb9idyeg
Message-ID: <tencent_F1132FBA08580D482F6A1EF7605710E5F005@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgGxEArPodSHT1lbOg/DEmyEKAiir5dGzO3A+IEgvLrBstSQFRn+
	 b2BZeF8oelangiWHaTJ5TGUW5TwOpH65Xem8FpX74Cc8MB2dyIH/QJKH+66dbo0DpUMhqYvIq5zo
	 svCLpyiCOfmaPrhSwwruOMotUdP1bc9PAU0MskH6t4sQOsMLn9xCb/H9om63OrQFNlXKZH2v0Gur
	 OAc4vZwgtd8xD7H2SgdTokW5UC+hCPowzDuwO8Sy5P6bWm3iHcAZZazB+H73vDx+uhcsTdG6tBCB
	 CLEESh9UM1/7CEN9o7rRBLtBM/x9QmBLIlkfTwZPgY+2eqaQzZk1SglgcTFiAz3gZkMjuYtmIXSL
	 FiPS9IjCzbgxI8iEDXcrRn1I4iS+l/ISFytYOImejHvu1CETGcnwuJZvunNj2SKy1TP7YStl3IKy
	 mQ5YVdtGfyNnhjCN0FruMv+hI+1a/otdcHH9Hd+iwjT9vAAbpdhcmSqtJxuxQUHbPl2veoGDhLGU
	 fxC1r+Af2nlfwulz5SIMV4XBj2fvM+LZSiv9Ut+VRaUslLzyxByaly7r1dJIX44P9MF85ykIfV5u
	 C3pGHDHIEIlHinw1NbM/J/VTc6kBEkEaVRHrUMWee+DqrMcEQZs87FpAH0R5lmWqOe34HGhN5Qu0
	 WfHY+G9If2pUBJkVUg/wi7/uguZx4v5gngPHNJ2cLWe8M2BUaRwqCfXLq5WER+pQcnkxg7iYISwI
	 q1XqsBS8Htr/yrXttzJD6QP8SRtlc+e5gLdTxGyVSkipjcpdJhDsOxTnyvfOFaDjOoxiRmF7XGNW
	 6yWZueqCIONPSOpP6s7ysNuCH3Hewq2Jr0kXxfsax3udvQmLQl+XXIaaFHCLCBNSt/wDGdtqxD5A
	 2oZPzVruORlqYjbY0ArMmYIads8A4/Um735mU3IXGnW4p0WPCkQjguzYibGwOHUOXTB9JSsPRhsQ
	 EKbFWw4ep5TNk5rX1hPmJ7L6ohwoVeZcvz5kxVevPAx+Dk8aZJ+dLlveFuYHl1LEaIgJcxHYJdxK
	 qu2Zdd+JdjkUg+jXc39/ajjqeb2VFN19SHIKZiYw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: kingdix10@qq.com
To: marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	prabhakar.csengg@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	King Dix <kingdix10@qq.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region
Date: Tue,  7 Jan 2025 21:51:23 +0800
X-OQ-MSGID: <20250107135123.804269-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: King Dix <kingdix10@qq.com>

When using devm_request_mem_region to request a resource, if the passed
variable is a stack string variable, it will lead to an oops issue when
executing the command cat /proc/iomem.

Fix this by replacing outbound_name with the name of the previously
requested resource.

Fixes: 2a6d0d63d999 ("PCI: rcar: Add endpoint mode support")

Signed-off-by: King Dix <kingdix10@qq.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Changes in v4:
  - Add more information to the comment.
Changes in v3:
  - Fix the spelling issue in the comment.
Changes in v2:
  - Fix the code indentation issue.
---
 drivers/pci/controller/pcie-rcar-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 047e2cef5afc..c5e0d025bc43 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
 		}
 		if (!devm_request_mem_region(&pdev->dev, res->start,
 					     resource_size(res),
-					     outbound_name)) {
+					     res->name)) {
 			dev_err(pcie->dev, "Cannot request memory region %s.\n",
 				outbound_name);
 			return -EIO;
-- 
2.43.0


