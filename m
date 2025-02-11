Return-Path: <linux-pci+bounces-21214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9776A31618
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E841162898
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C112641FC;
	Tue, 11 Feb 2025 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="xzz1DCD+"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E826562A
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303691; cv=none; b=KL1+KAJR1bR2sr7LgiyjcAPqKJFfv9m2lc8fgSifZQaNALMe+2h2VVymiz3wFIASxpHoI9Djf4eFaX0d5KsUivxTvcvUJkC0Zz88m7tb58gTe3cG2IZWzX4+kHZnEOesR8bu74Gk3P4Nl/NBMMQ7bXYVcFjQAvWsFw8+3NQJS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303691; c=relaxed/simple;
	bh=ijjkUgwKg3l3OQBJXgW0kLaftwa4pdX/Qb8rBdmDSZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCpLMFUCGrvyeJidjBOMveN1t/0rmcAiKlCWZjsyvBQb2JhwZG+PWQo34L20PzwbuT1bJObQdGeWor3vWyhgbHCRGiJEdl3FV4S8a//+j/ZaRgEafh3Arb/+EQcWySAdqn82e1r5j434cWWR699+yvZqhSiVRM7IWA9VwyPOiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=xzz1DCD+; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvMzFvDFPtNYc9beeiDGU1QfzgA0X8H/s3MjLPK83/s=;
	b=xzz1DCD+FgNmcew4nFWLGjYQFCe6sA/KdgUUqLpzSUt/rVZxxKiUOqy/svVsjOYt+xalNc
	b5YmIlV3Lp3B1CbeAT8KesfeYujrLuPGOQ+iOlUe6oXY5IEFsVGuLCkIr9xCPokU7VYi8D
	RiEYC6twxK57MfnQysTn+iJaQqpGzx/SNkUWguQQ2dNUyVkTMmBSPv91QxaBvKCIxnui6L
	+0wJCWCnyXFKfxDQuVfyvzbh9oEJFSrqUsA4dcrudKgEqApNVwSPfKIqGvzTbl/MS9x71P
	6AG0bxHFkpwFj38uaoOpwTx7wQFHwASWJAdJIblBqa6VMIAOSeZ9lTTFCsxpwA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 14:54:30 -0500
Subject: [PATCH 5/7] PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pcie-t6-v1-5-b60e6d2501bb@rosenzweig.io>
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
In-Reply-To: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=PXCtvv5N3o1ijghyFwcjjiYtA4dsCcCo/zzcFKCevKk=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r28PCvGN2V+WHKUhGyarStlr41tcudnZ4dQ
 HvrlQVn2XOJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9gAKCRD+/lBaCvVY
 Dbj7EACMcBHDuzhazrjCZuOERME9/KkzaAPLCGa0fd3dYJCK+QaS12j3u8D/lYk3EG01TwqvOAN
 BWDWE8iSmcW0ewo61p2NbdmyabmMA2EKewdDsrt/1+SVwd/ntYv4737LIcHp9OkrCKTP2BRCV0x
 UvEPG8ZZXvS3Re4spQB9qn5Ke07KReBKO/iDfzogMEq1LN3z71RI6e1HLcBtWBKF8zQoXhsEE5D
 oq57PxA3WF5OPxQzgZNVVdIjrdHoaZ5o+xbZbCcuZa3tCqHBJ5ArzTSMNNsn9saOeiNCsar6ZYZ
 FW4nllMh9LOamx+DCMTlJHiEn/TOr6/KYRFGCnUInmhNwfbBQaQo/ysulv9XXNL3V7SJEcDdEkz
 IDjYbtRU95ua9kDZJ0FeMwWr7QjMS7D7fWxVRqmnRcHFdcLIT6RRPhvs5w425SpiGCkKqn3jF5N
 CfRI0ApM/sKjFEFgRYJ7d/ToBVIC8JlHD/u+ppPR++qpe5/xuU9I+739xPAqojxE1tZ9Qj2RIcR
 HatGJszXFASmiKwQeRxU2VGp+iWN5pc9I8ebm7wJ5WWOw2peN56Nyq6AR1Dti+k3G3sMpFRGCkk
 eEAmlhwJmyfIvYDUFejCIfkU4tgAvhzp7bm9n7fnAUrTbuzTokwxCgqw5H9ilj9Qj5xSGZXVHZz
 xroFVy45lDiCe5A==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Hector Martin <marcan@marcan.st>

This is checking a core refclk in per-port setup which doesn't make a
lot of sense, and the bootloader needs to have gone through this anyway.

It doesn't work on T602x, so just drop it across the board.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 806eeb911bbd4f1ae5832b34f775fa18c866670b..209535db7855fa1ee0d75290b33525dce18f560d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -472,12 +472,6 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	u32 stat;
 	int res;
 
-	res = readl_relaxed_poll_timeout(pcie->base + CORE_RC_PHYIF_STAT, stat,
-					 stat & CORE_RC_PHYIF_STAT_REFCLK,
-					 100, 50000);
-	if (res < 0)
-		return res;
-
 	rmw_set(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
 	rmw_set(PHY_LANE_CFG_REFCLK0REQ, port->phy + PHY_LANE_CFG);
 

-- 
2.48.1


