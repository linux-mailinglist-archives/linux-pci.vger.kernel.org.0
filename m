Return-Path: <linux-pci+bounces-8126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37BC8D667D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD70628C9C2
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8C1779BD;
	Fri, 31 May 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z6sCcpOq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA3176ABD
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172038; cv=none; b=BCLRTjqRvYP75wdK22XOgxHVtJ/aw6X0XKYYTbCOhn8ivMHVfgPLSdO+6ErTg23t+07UGxQBVQTSVxCfJnutGMS0jgSvzIt6316Gi1fAboze/nGoBe9hkXWGHnTT4s+AqqjssE2Z4YqbWXk0i5TYUMve419QL4OEJtyxlRv71Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172038; c=relaxed/simple;
	bh=R6C/JcAy4XUIj+2mid0YFJ1dW39G3VQ8kRlz1b3tSQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+bnFlZ80sibFpjsJ3eSNx9iO0oEbH0BedcvAtfxk27QpTvZ1aHAaXXpbgDsFyqi91f5U5mY3me/ySRs0o3uahkmgBlSBQlc9edAy0Gx/j0Bzn1jO4oPEi3RVGGhcJ+EObvsA1p34WGN0zLLbkHgchr1Zo14xP0SOGK3xgmN5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6sCcpOq; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+uuIXz4xj0FsFVOIz/Umf+nSIXJTEGtc5WA6Ask/xo=;
	b=Z6sCcpOqzSVcuaGASWHHmXpSMSd9vPee84mF4IxSp48Qle9k7CqVtiNfpvlPwj6sJpbOUH
	XvEYmeBxv4GHnX1PjkmNXkfyHEbBySMUy/jULaJZnSDAEGcMFKTSfksDj9ME6V3P1m1k8D
	ZtinJguMIHjeVd/XiXklQ65iZ8tlmA0=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 3/7] PCI: xilinx-nwl: Fix register misspelling
Date: Fri, 31 May 2024 12:13:33 -0400
Message-Id: <20240531161337.864994-4-sean.anderson@linux.dev>
In-Reply-To: <20240531161337.864994-1-sean.anderson@linux.dev>
References: <20240531161337.864994-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

MSIC -> MISC

Fixes: c2a7ff18edcd ("PCI: xilinx-nwl: Expand error logging")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/pci/controller/pcie-xilinx-nwl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 437927e3bcca..ce881baac6d8 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -80,8 +80,8 @@
 #define MSGF_MISC_SR_NON_FATAL_DEV	BIT(22)
 #define MSGF_MISC_SR_FATAL_DEV		BIT(23)
 #define MSGF_MISC_SR_LINK_DOWN		BIT(24)
-#define MSGF_MSIC_SR_LINK_AUTO_BWIDTH	BIT(25)
-#define MSGF_MSIC_SR_LINK_BWIDTH	BIT(26)
+#define MSGF_MISC_SR_LINK_AUTO_BWIDTH	BIT(25)
+#define MSGF_MISC_SR_LINK_BWIDTH	BIT(26)
 
 #define MSGF_MISC_SR_MASKALL		(MSGF_MISC_SR_RXMSG_AVAIL | \
 					MSGF_MISC_SR_RXMSG_OVER | \
@@ -96,8 +96,8 @@
 					MSGF_MISC_SR_NON_FATAL_DEV | \
 					MSGF_MISC_SR_FATAL_DEV | \
 					MSGF_MISC_SR_LINK_DOWN | \
-					MSGF_MSIC_SR_LINK_AUTO_BWIDTH | \
-					MSGF_MSIC_SR_LINK_BWIDTH)
+					MSGF_MISC_SR_LINK_AUTO_BWIDTH | \
+					MSGF_MISC_SR_LINK_BWIDTH)
 
 /* Legacy interrupt status mask bits */
 #define MSGF_LEG_SR_INTA		BIT(0)
@@ -299,10 +299,10 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
 		dev_err(dev, "Fatal Error Detected\n");
 
-	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
+	if (misc_stat & MSGF_MISC_SR_LINK_AUTO_BWIDTH)
 		dev_info(dev, "Link Autonomous Bandwidth Management Status bit set\n");
 
-	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
+	if (misc_stat & MSGF_MISC_SR_LINK_BWIDTH)
 		dev_info(dev, "Link Bandwidth Management Status bit set\n");
 
 	/* Clear misc interrupt status */
-- 
2.35.1.1320.gc452695387.dirty


