Return-Path: <linux-pci+bounces-25045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE5A77778
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98523AC24E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3911EEA35;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORx/WcXp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B11EE7B9;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499058; cv=none; b=lBHaB1qUCmABJY6cKM2BSBeR9DxG7sjQtlNj6oqRBwBzeUwm3+hR2toa8+pEZhvB4B6HuOrWvp+bX/Y3uD9YLtEX3zg9g5KFDApsc/s8YC0ccOkMqQCTumD/2M7K6XOb0Zkrqfs9GpUKXACOBYE2g6qSU9qK+NiK9ro6/U16NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499058; c=relaxed/simple;
	bh=hY7d5l/jzCYASueLws6Rz29Q9HtgzeMl7jBFbrlIdNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RI4GzJNMvpvBDz5E+d9Yud8JTDEvmTrHaUS/54b+z4tUAIDHtk/iIJKWvRWt5koIJeHybEIengybWkP17TKcBO3C53FN7Ma3Dmn9bhw+eGX+QIwWCw60c16B0kJhM6OzY8tkV20Sgtc2MOTkJ2MhZwciym3jVpE4OonzT4wbVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORx/WcXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40C4C4CEEF;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499057;
	bh=hY7d5l/jzCYASueLws6Rz29Q9HtgzeMl7jBFbrlIdNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORx/WcXpgEBwhh0nSpDDQpENeE+uxDM7FwEXObBLzzjGDpc6GdlwD2j6Kkk3ayZml
	 7o4JCFr2t713RmSFpGFBTjzVYPRVEtO/9N0N1RceRQZHylYs1V8MK5dAkd20vE8MQW
	 6OYidH92Vuv3QLr7NJthrMdgDlgnF2FZBfrwEBa/BRzSlxcgUloRt3GxDHhbbjbOoo
	 UQdQSvSHWXHxZ4ISfYdE0GlN/iI1/D9wVIHtwjhwBN4ybw6y+qZvMvTwIlDftZaB5U
	 9qPhcUdvFcD0Zkn1TY1qmuxxbiGJVXCRZ6UtxqjD4LFPnE+yNSNxFCuIcD2f7p3mE4
	 6ud/22QNq8dQw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkV-001GqU-Mt;
	Tue, 01 Apr 2025 10:17:35 +0100
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: [PATCH v3 04/13] PCI: ecam: Allow cfg->priv to be pre-populated from the root port device
Date: Tue,  1 Apr 2025 10:17:04 +0100
Message-Id: <20250401091713.2765724-5-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250401091713.2765724-1-maz@kernel.org>
References: <20250401091713.2765724-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, mark.kettenis@xs4all.nl
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

In order to decouple ecam config space creation from probing via
pci_host_common_probe(), allow the private pointer to be populated
via the device drvdata pointer.

Crucially, this is set before calling ops->init(), allowing that
particular callback to have access to probe data.

This should have no impact on existing code which ignores the
current value of cfg->priv.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
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


