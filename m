Return-Path: <linux-pci+bounces-40314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ABFC340C7
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 07:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6FD44E23AF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4D22C0292;
	Wed,  5 Nov 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iq6FnMH/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C62BF005
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324115; cv=none; b=byzQs+lmfscw4ip1y2s68FyguX2w/qUtAga/Xk6qbUMK7HBMb/DLumUJuOxMYYmeO2hMIcqzfZQeJJNL6LnX3a2ScMw3MZD2cLFueAd35zXpQDYxGYrJ4kaKpBUC5HvZu/Mt/Z5I7aRdskvSF5jA3Swvp9WTVt3EUZFUEUSAGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324115; c=relaxed/simple;
	bh=3FiroJxrQIhTUXDgWPdJEs83lUs7Rhdwifkg2x3t8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoFak1c5SJ+OgqVvQx1LugrVoD53uKs3fNjv5FBIB0XWG2CXXNGaKKtnxEqLkKdx+B6gVyFn3svN9AK8wCqj9YSpXDH5MavQvtcnBaTBPAu5n6p9s0HYb9AVS4fwMS4y6z8W39KsE3YODa7DoKoQ2vyygqVOWT61c8CdQOGA7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iq6FnMH/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34101107cc8so3063051a91.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 22:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762324114; x=1762928914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5H6EdMxDpSqpmsIQ4cEg0ZlQTdzaOtsaMR+Q6cSWnBg=;
        b=iq6FnMH/OuAtEb9vxBIoCjdmrv76QSlxzb6NNHVDIFOe7RVdJ8+F8sz9Nw/7m1RlHY
         4HLzCEyzDxpQllfhklhDllyX0m25HSyayobFMYKeposp1aEqZ4gErrpQBvM7/625a6tO
         ClBwQCXqQbFXKGjYFe1IQmyN3UXM/Np5GlFps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324114; x=1762928914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5H6EdMxDpSqpmsIQ4cEg0ZlQTdzaOtsaMR+Q6cSWnBg=;
        b=BDk+tTM8GDtpaVyrUhgRT8S9DaqqC3jJGUVE7ADW6IHTIvxV0CPY3dc7uM4jdg+IZM
         QcTphdoeY06ttKfunsBBvlrSmJzJYO7nMG0P7tWHjeGFHFFWvU7QVbGxqUjb6Y3ySYU9
         8UTKok2jwB8+BOxR9C7/UUenDHiGO5rA56ZD+Sc6RTob3Pt0JxM/kXOvD7hmYLOkfzNX
         ewHUbuoBpdZwiIgOypyBab7V1J0F+NyoLp7do6faCVSFKerBwK6IS1uTG+pt60n6v9P6
         Mp3xt9tc8kL5beighfiNhdr6aIczOHaYrsxc5lu4PBEtAPPRaAGLed2Vi5ngDvP3K+n1
         tSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzp6+XPCOzLS2hFK2kTyoDBwRxvh1CR+h5VAzWDRJh/B4JDAYULhTcWubQVSRRfAtHkj4ePNQsONk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nbJnehgszz2+cY4VacGjkGP6xq+ngY/BEAdCU4K31xVCu1vp
	CJ4USUg4a8CC5+U8N8gwgmqVXVkeEFo3PICMVNQrkIC4piRTxfEbX8WpbT6KNKUg2g==
X-Gm-Gg: ASbGncvFn1veCjLCSKfdlOX77644op65x3I+VhCmZnnUKCW/TZCefPIwIKZocNi2jP/
	E48qLIzcSwb33pXyq493MGlWCqJJ/hg1WeunAIqmGZt7rnYSfQV0NoTBpYcNBRaaAtt3vxIom54
	rjuIH8Wj2pljEshaqor6BClcFpvLEp5Y1CJuggIhR+P8ezg2K2K2TqisDJ09ALP9/BE2y2niXQK
	cJuzUpLiS+zSzconchDyHfQ5R1ioFfNrC2uUhTgU/HjYZeWcPX7lWMrsB+7R69zjA6VZzbbAGw3
	gtgfGOTTI4WJz4Pn2JvhPi7br5edCY2kysC4lKfdkOzdmgiTMNr6ec8dbwJbXsE+8mUhIUrRP3Q
	BZFYSDlizdni2nMNvc9ykQRB7ADSdukoEpl2tEcHr076Ea7jpZ0Xc4P2I6cXJj7QZ4Qao0Du85H
	6I3Ee02q178bEbsfDykwysQTe+pWQSVaXsw9N7Xl6vh8OFk8VHQFH2jRcB7TtNlEfLYBU+
X-Google-Smtp-Source: AGHT+IHcxT8eopl534bKfusC4Hown9kjuaRa6MI3B1tgGIQ3dMjZZ/a/cIEyK3gcb84dHOtYByhoug==
X-Received: by 2002:a17:902:f542:b0:295:2d2c:1ba6 with SMTP id d9443c01a7336-2962ae10211mr34787125ad.36.1762324113674;
        Tue, 04 Nov 2025 22:28:33 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:c3d3:7b72:a22e:7adf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019bb9d3sm48438615ad.50.2025.11.04.22.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:28:33 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
Date: Wed,  5 Nov 2025 14:28:14 +0800
Message-ID: <20251105062815.966716-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling into
common code") come up later" in the code, it is possible for link up to
occur later:

  Let's standardize this to succeed as there are usecases where devices
  (and the link) appear later even without hotplug. For example, a
  reconfigured FPGA device.

Another case for this is the new PCIe power control stuff. The power
control mechanism only gets triggered in the PCI core after the driver
calls into pci_host_probe(). The power control framework then triggers
a bus rescan. In most driver implementations, this sequence happens
after link training. If the driver errors out when link training times
out, it will never get to the point where the device gets turned on.

Ignore the link up timeout, and lower the error message down to a
warning.

This makes PCIe devices that have not-always-on power rails work.
However there may be some reversal of PCIe power sequencing, since now
the PERST# and clocks are enabled in the driver, while the power is
applied afterwards.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
The change works to get my PCIe WiFi device working, but I wonder if
the driver should expose more fine grained controls for the link clock
and PERST# (when it is owned by the controller and not just a GPIO) to
the power control framework. This applies not just to this driver.

The PCI standard says that PERST# should hold the device in reset until
the power rails are valid or stable, i.e. at their designated voltages.
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 75ddb8bee168..5bdb312c9f9b 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -504,10 +504,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		ltssm_index = PCIE_LTSSM_STATE(val);
 		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
 			      "Unknown state" : ltssm_str[ltssm_index];
-		dev_err(pcie->dev,
-			"PCIe link down, current LTSSM state: %s (%#x)\n",
-			ltssm_state, val);
-		return err;
+		dev_warn(pcie->dev,
+			 "PCIe link down, current LTSSM state: %s (%#x)\n",
+			 ltssm_state, val);
+
+		/*
+		 * Ignore the timeout, as the link may come up later,
+		 * such as when the PCI power control enables power to the
+		 * device, at which point it triggers a rescan.
+		 */
 	}
 
 	mtk_pcie_enable_msi(pcie);
-- 
2.51.2.1026.g39e6a42477-goog


