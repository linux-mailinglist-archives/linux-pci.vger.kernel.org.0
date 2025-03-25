Return-Path: <linux-pci+bounces-24640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F22CA6ED90
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E013B0221
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE8254AE5;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/vhHGya"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77460254857;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898395; cv=none; b=izCH4nS8zyaKr29ipfpjU//rpz1n2wR3JY/6Hv4uptJaxcw93Hivmj8K5a3LeKqymK/mrhlRYi/zD7RFbIXVeqw1iDJiw1wIFTgeHKWC4r9GpOOlVr2mBmOsV2UZeF9amrqkMfZ5fxfCxeNg2eNa1Ce9JAOOyir6R4xgzzeDfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898395; c=relaxed/simple;
	bh=khvmda81Vor6ELCVCuRt/OG1eU4tA4ZfEAJHXcgitdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mu/XNQkv01il3ODShDagfjxcBeXM19qJ2a+wdBlAl0ZANlLzeKUAAdSnmd9n0kapkMiNensPGcd2XEvVrGGYcPyawPLCPi+OzSh1qI9nnjYMLLwrLZoEml5cFu+nX9WWfNLWPCZ8CW/xMeAe/fuANGLOuhlS4Raa187ZWWEktKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/vhHGya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690DC4CEE8;
	Tue, 25 Mar 2025 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898395;
	bh=khvmda81Vor6ELCVCuRt/OG1eU4tA4ZfEAJHXcgitdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/vhHGyaqwh1rnTLsKJxY99Gn6mvVieJtZJMPvBvbzGB5tcM2b3c614iEVhoyzIRo
	 WlM3lrXldAiHAp1xIloJZ1ZRtwpSO3YTobH0W2lscNBjfAq/vvQibiEoa6E1pnvIeZ
	 rJGIZR61JW7RR/USAyDJZ4aqzA9RKwt7w9d25sqQxPudlg2i39K4TKLryf0X/YZJNr
	 yb9aedZCw11ax+G3UybagMzZLIpQqaWRA/kPr47grZQxmqVMQMs/qGBR8D/B05+yb4
	 y3PwXAL55i2v5HCHF2qg9vcgW6rdXIY4Xb/+biAjnpuN7/eHhOPalEi6n5uvvcO/IL
	 w5z9u+u8eMzZQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UO-00GsRS-Rw;
	Tue, 25 Mar 2025 10:26:32 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v2 03/13] PCI: ecam: Allow cfg->priv to be pre-populated from the root port device
Date: Tue, 25 Mar 2025 10:26:00 +0000
Message-Id: <20250325102610.2073863-4-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

In order to decouple ecam config space creation from probing via
pci_host_common_probe(), allow the private pointer to be populated
via the device drvdata pointer.

Crucially, this is set before calling ops->init(), allowing that
particular callback to have access to probe data.

This should have no impact on existing code which ignores the
current value of cfg->priv.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/ecam.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 260b7de2dbd57..2c5e6446e00ee 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -84,6 +84,8 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 			goto err_exit_iomap;
 	}
 
+	cfg->priv = dev_get_drvdata(dev);
+
 	if (ops->init) {
 		err = ops->init(cfg);
 		if (err)
-- 
2.39.2


