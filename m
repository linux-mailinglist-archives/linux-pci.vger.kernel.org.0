Return-Path: <linux-pci+bounces-24639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426EA6ED8E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308F13AFB2D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19F253F00;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9toO01I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035181F03CD;
	Tue, 25 Mar 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898395; cv=none; b=RIzaRGk4yI3yCS8B20/HKk+56+BSqDfLqM3yXtPE10EshyoeiSSgKlZ8qcPM4w0rbjkU+37aIlwCzSG0tBBVGjE75dhDc4ztcYPbvgZbh3FWL3Ktx6A6OUvIXvYlWIni+Y9YRbVPhNeZrx7Th21bi1bFSjFoimYAJIcgIn4ubuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898395; c=relaxed/simple;
	bh=TwzXn1kE0ZZbpOOI5lgQzmVfbZhL31GqLAvtVhL+thU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+dI3vJwAJZbQj3HUybVGdd02lfzUsSfRJ+gtD8tSzH0AKhlWWYvpLelsRUm2Inq3BEh8cpACWpzDgr85wpzS0Et+neYkW4PxsRlSYMCo7wquRw/VF2SE34N2A7X544P6dlvjjzoNRHJ7hdkg0Kg9bjH5MspHWYWBZxAvunMlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9toO01I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85205C4CEEE;
	Tue, 25 Mar 2025 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898394;
	bh=TwzXn1kE0ZZbpOOI5lgQzmVfbZhL31GqLAvtVhL+thU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9toO01Ipxpj+HABtOLsSc8rJ9MvHXp68OXI3f+1nFsb54ZdRe4uxiWLt76UWSj1I
	 jjjKMrQkIBMqrCIHPexkCsls1Sy6+jMWOxBZS1dO8/qDAkrKM1G4R+dAJlrShWg5rG
	 wZvvVmCDwtxKeHeJqfk4Nx/C3ENFet0mzej38JeF9Jb2bp3b3EfcainIo4uDiCTsY0
	 FYwXKr4he9kLvlFUIcqJ/9AbP2kxpVxXC/NsSXTSNTwFh1gqF6BTBIeyoRjq3mnw+c
	 XKWN08PpYZ77GCbL+YDuQDuVIpUyWwi/o46Q/gTbEFKOu7GTxGRmBv2xBYdBXZqbF9
	 kU6AM59v6b3Ug==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UO-00GsRS-Kb;
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
Subject: [PATCH v2 02/13] PCI: host-generic: Extract an ecam bridge creation helper from pci_host_common_probe()
Date: Tue, 25 Mar 2025 10:25:59 +0000
Message-Id: <20250325102610.2073863-3-maz@kernel.org>
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


