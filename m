Return-Path: <linux-pci+bounces-7662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6588C9F14
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 16:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2CB1C21B55
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7189137772;
	Mon, 20 May 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pBvoH/8e"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0C137743
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216863; cv=none; b=Mv+xfbd5byCgzfmvtZ6uXLs65VPLwHzO9XHo3jRy5CSZgIoh+GsoQrWH3b0o7r9it7PGjsCa4g6pzGDMaiDQKE1MVSmjcUCgZNJ/1QEbCYe8PahU1Xc5Mm9LB2VOgssLe0pJIDVIBB/02VUoGUkQu5SbO4ccfnA3Fqel2CYK8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216863; c=relaxed/simple;
	bh=Z1/InqPro1U0+pj2thLeLheiLnUhwHnjffb+hYMRUik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0nsbH/ceSQ2A06yRTP0DZMA7hn4LcGvwQ+Y1Kl/rGBwWdB0au+HP7akU0Lw0r9UETKQHxFgVHhCnEzIaw+vTy+n8xDPIFIffgLmyPuFMHfyd7z+oB8fYdVB0/6GqE+6A9YwDRorTGIyafwEYcBI0OLYbs75MHvD+blu7hEPc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pBvoH/8e; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716216860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQwH77/vqcL6nAroUqOCPsVDtJd7S7+cLJcYruhNakw=;
	b=pBvoH/8efJEugUE9jNRbNpcO7Ugvrf9vZkfx0TBnxwyqrjgD15xaD1qrOPoURAeXuuCwC+
	9BmLFlJl3xeq2Le1KR/sxxnOIZ4nJh6F3v/b/OwL1tj+07PNhV4GxktJZxtA+LsUrOQlid
	xl1NFvbvhGruDAT+u1+58x0jT4r2UAE=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 4/7] PCI: xilinx-nwl: Rate-limit misc interrupt messages
Date: Mon, 20 May 2024 10:53:59 -0400
Message-Id: <20240520145402.2526481-5-sean.anderson@linux.dev>
In-Reply-To: <20240520145402.2526481-1-sean.anderson@linux.dev>
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
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


