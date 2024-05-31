Return-Path: <linux-pci+bounces-8127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C88D667F
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E541B1C231AC
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3517C23B;
	Fri, 31 May 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hg8s1bou"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9E178387
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172039; cv=none; b=IMPj6kN5NzuBF12CN+hktFAXtRjIjpLO0WljhtWJqF6idnqgJAzONFxAs1Ag6KU8nVLDEr9a9N+aFKiYzbPnDJQrBDXTBoPaLgFROU+DV8vP1iAHobh0DziN5C481K6/b468a+tDrDo43t8R1Rpv3fT9cr2ntYsNex5sfON/bGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172039; c=relaxed/simple;
	bh=Z1/InqPro1U0+pj2thLeLheiLnUhwHnjffb+hYMRUik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Usw+ydb0BupgVZVKCF4GdZhTYJa3pyAg8ar+CdTcCdSe1N5a6VtEaGuV257BFey98bhWVLAVtM1ixLHmL0iGmUffS3u+N6knWnpvQGNt23rkA1JU2oH4J92i/pI4t1PY9kBDB1oAs5UexXSw7uRJvYSC+3RfBSRIZgUBj2jh02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hg8s1bou; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQwH77/vqcL6nAroUqOCPsVDtJd7S7+cLJcYruhNakw=;
	b=Hg8s1bouZl+ida3T6HXKTL1xqOvO37uDzdllecimHNNY7LSHrlVFqFCU2qYwP433yDukvA
	uD8msPtQq/YKipvreuhjEuxd3dVw3P8/MNFw5P04AiPDrfq1KswWY5agap5Em8K6mbH593
	dEk3ke4o69Agx4BLXpNCrnRyeODN4sM=
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
Subject: [PATCH v4 4/7] PCI: xilinx-nwl: Rate-limit misc interrupt messages
Date: Fri, 31 May 2024 12:13:34 -0400
Message-Id: <20240531161337.864994-5-sean.anderson@linux.dev>
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

The conditions logged by the misc interrupt can occur repeatedly and
continuously. Avoid rendering the console unusable by rate-limiting
these messages.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/pci/controller/pcie-xilinx-nwl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index ce881baac6d8..c0a60cebdb2e 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -267,37 +267,37 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	if (misc_stat & MSGF_MISC_SR_RXMSG_OVER)
-		dev_err(dev, "Received Message FIFO Overflow\n");
+		dev_err_ratelimited(dev, "Received Message FIFO Overflow\n");
 
 	if (misc_stat & MSGF_MISC_SR_SLAVE_ERR)
-		dev_err(dev, "Slave error\n");
+		dev_err_ratelimited(dev, "Slave error\n");
 
 	if (misc_stat & MSGF_MISC_SR_MASTER_ERR)
-		dev_err(dev, "Master error\n");
+		dev_err_ratelimited(dev, "Master error\n");
 
 	if (misc_stat & MSGF_MISC_SR_I_ADDR_ERR)
-		dev_err(dev, "In Misc Ingress address translation error\n");
+		dev_err_ratelimited(dev, "In Misc Ingress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_E_ADDR_ERR)
-		dev_err(dev, "In Misc Egress address translation error\n");
+		dev_err_ratelimited(dev, "In Misc Egress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_AER)
-		dev_err(dev, "Fatal Error in AER Capability\n");
+		dev_err_ratelimited(dev, "Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_AER)
-		dev_err(dev, "Non-Fatal Error in AER Capability\n");
+		dev_err_ratelimited(dev, "Non-Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_CORR_AER)
-		dev_err(dev, "Correctable Error in AER Capability\n");
+		dev_err_ratelimited(dev, "Correctable Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_UR_DETECT)
-		dev_err(dev, "Unsupported request Detected\n");
+		dev_err_ratelimited(dev, "Unsupported request Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_DEV)
-		dev_err(dev, "Non-Fatal Error Detected\n");
+		dev_err_ratelimited(dev, "Non-Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
-		dev_err(dev, "Fatal Error Detected\n");
+		dev_err_ratelimited(dev, "Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_LINK_AUTO_BWIDTH)
 		dev_info(dev, "Link Autonomous Bandwidth Management Status bit set\n");
-- 
2.35.1.1320.gc452695387.dirty


