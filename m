Return-Path: <linux-pci+bounces-25044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2BBA7776B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E42A16A449
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068441EE034;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptrUq3FG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7191EE00C;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499057; cv=none; b=tGFn+Mdb6X27KhLwsfE9/YGekX+fxYbGsle3v9QdIbqgpqjPYk91E4ktRMrCb7HZxfQgwwwyEfyWZECzltm9R7FNkHBnjVbFpQKj5vaEPjf7KRC7XXcwtNnyz3z+wKI1easTlpG7nWBJ0IeQDZntOI4d0jKuaJeGy6eBi/HZmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499057; c=relaxed/simple;
	bh=JW2TE2r1cR57wQLKrvwB6bcnrT+ZGj91um79e0rab+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mgm06i3ralREFTalaXoVGpbQq9dV9EMcp9omPtExwWIGW+645i21loB50Tl/8bjyQ8I027gO1zCjzD1JeH+uHmwCMHPHcvOoqo4QYyfTNA5ODS1ypoA/k4A603r2c8/9fLkE6BV/cmhggRZPkuT2GTmYcVjGLtO5tuW3sbWOu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptrUq3FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986F8C4CEE8;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499057;
	bh=JW2TE2r1cR57wQLKrvwB6bcnrT+ZGj91um79e0rab+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptrUq3FGh1gzE3+DgT/l0b1lGlkd4t8knX/DzHIu60hktWMOjgwDh+S4YzHzoNd5T
	 MFatOxLFJ4FR4CGuq+hm6K/0cvoO2sgzeju87bOGWCp++NnQgenU2VUB3wjebgtoRk
	 8Zwfr4iON7Js3Yw61JIefUOG8sFYMIsJ3To0AOFmS9AtQHe4mj/2tDNArolEBJL/n3
	 Klk1AkLp87Hs31oWrCm+fDQ7Fi5SPSiWWhQzHt300wG8UexHhSwPGbls/hsvveCA7n
	 mbsmfK6TBHbXIBz49MK1dTQjRNNslCxtldhKHLpHGusiiVs3df4prWDGvO8uNjcD5n
	 HX0zcJdAMBEsw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkV-001GqU-FG;
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
Subject: [PATCH v3 03/13] PCI: host-generic: Extract an ecam bridge creation helper from pci_host_common_probe()
Date: Tue,  1 Apr 2025 10:17:03 +0100
Message-Id: <20250401091713.2765724-4-maz@kernel.org>
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

pci_host_common_probe() is an extremely userful helper, as it
abstracts away most of the gunk that a "mostly-ECAM-compliant"
device driver needs.

However, it is structured as a probe function, meaning that a lot
of the driver-specific setup has to happen in a .init() callback,
after the bridge and config space have been instantiated.

This is a bit awkward, and results in a number of convolutions
that could be avoided if the host-common code was more like
a library.

Introduce a pci_host_common_init() helper that does exactly that,
taking the platform device and a struct pci_ecam_op as parameters.

This can then be called from the probe routine, and a lot of the
code that isn't relevant to PCI setup moved away from the .init()
callback. This also removes the dependency on the device match
data, which is an oddity.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-host-common.c | 24 ++++++++++++++++--------
 include/linux/pci-ecam.h                 |  2 ++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index f441bfd6f96a8..466a1e6a7ffcd 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -49,23 +49,17 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	return cfg;
 }
 
-int pci_host_common_probe(struct platform_device *pdev)
+int pci_host_common_init(struct platform_device *pdev,
+			 const struct pci_ecam_ops *ops)
 {
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
-	const struct pci_ecam_ops *ops;
-
-	ops = of_device_get_match_data(&pdev->dev);
-	if (!ops)
-		return -ENODEV;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, bridge);
-
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
@@ -73,6 +67,8 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	platform_set_drvdata(pdev, bridge);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->enable_device = ops->enable_device;
@@ -81,6 +77,18 @@ int pci_host_common_probe(struct platform_device *pdev)
 
 	return pci_host_probe(bridge);
 }
+EXPORT_SYMBOL_GPL(pci_host_common_init);
+
+int pci_host_common_probe(struct platform_device *pdev)
+{
+	const struct pci_ecam_ops *ops;
+
+	ops = of_device_get_match_data(&pdev->dev);
+	if (!ops)
+		return -ENODEV;
+
+	return pci_host_common_init(pdev, ops);
+}
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
 
 void pci_host_common_remove(struct platform_device *pdev)
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3a10f8cfc3ad5..bc2ca2c72ee23 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -97,6 +97,8 @@ extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
 #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev);
+int pci_host_common_init(struct platform_device *pdev,
+			 const struct pci_ecam_ops *ops);
 void pci_host_common_remove(struct platform_device *pdev);
 #endif
 #endif
-- 
2.39.2


