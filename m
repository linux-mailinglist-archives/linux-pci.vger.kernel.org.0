Return-Path: <linux-pci+bounces-17659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DD9E3EBA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C323B38553
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F420B1F5;
	Wed,  4 Dec 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0ONyUa0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2120ADFE;
	Wed,  4 Dec 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324511; cv=none; b=tTWj42mx4nvw7+po1KQJf0BL9zwnWFRncMP3SAPAkmpRN2DFO4miiqhYgd0mQLGqV+xkXV/fr57SrSFh0yLAjfh+TUJkjydqi1yJ2XKgeeJznoE+rocLpilv99UkQeNor/Pq/CjwgMq5IrIW8rWklNvUSXtOtVi16xPxMFSYO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324511; c=relaxed/simple;
	bh=bGrthp6P6OjGXSuGAAT9PJ7U09h7+JZZ06Vtmr7nZv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpAI4X7l1IoTJbD44j7bfdOhwUkMSz/uaLYEUrpiK+YihDzLjoIH5TNxhcGuwgRFNaHC7ZsN259J4wNZKTK7+y+MVOEBD2YovfQoZCgrlHLS1CfJmoHBcOb8hXFcFQjjySpXIKAChPiVgi/n39td6E87/jGHPlj+iwI+2essb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0ONyUa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCA5C4CEDF;
	Wed,  4 Dec 2024 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733324511;
	bh=bGrthp6P6OjGXSuGAAT9PJ7U09h7+JZZ06Vtmr7nZv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0ONyUa0NIju4sT0cu7zhe0Q1Zo9jkyng1DWVpBdqZLqgUuK2IMVW8/iM+9uQ/yim
	 Sy3wMVyXF0OM4fZiIKEUoFR5QVtfcKVtHcaiz4kgxNfw4AEda2sYch16JtEbhQPZgC
	 uN1yH/2mjrL35RlGeL+7w+wvzb8BPLPXcoH29bLM+Rp6diKOhE41ehjSvRmk7knvBR
	 bnp8KN+AanPUfepm0Az5oJkmXhTYb8sJ3hmg4qDHj+fyDQZkd0tmyu2cboIkO0uWtm
	 71krdOeC8i0jo2P6uVCvZIGQbpg7oUdr3Z4Yi9BHBdqI9wUXVRL9peU4pBNed/w3dh
	 6bkRRob4dP6fQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIqsv-000TvG-1E;
	Wed, 04 Dec 2024 15:01:49 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/2] PCI: host-generic: Allow {en,dis}able_device() to be provided via pci_ecam_ops
Date: Wed,  4 Dec 2024 15:01:44 +0000
Message-Id: <20241204150145.800408-2-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204150145.800408-1-maz@kernel.org>
References: <20241204150145.800408-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, alyssa@rosenzweig.io, Frank.Li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

In order to let host controller drivers using the host-generic
infrastructure use the {en,dis}able_device() callbacks that can
be used to configure sideband RID mapping hardware, provide these
two callbacks as part of the pci_ecap_ops structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-host-common.c | 2 ++
 include/linux/pci-ecam.h                 | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index cf5f59a745b37..f441bfd6f96a8 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -75,6 +75,8 @@ int pci_host_common_probe(struct platform_device *pdev)
 
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
+	bridge->enable_device = ops->enable_device;
+	bridge->disable_device = ops->disable_device;
 	bridge->msi_domain = true;
 
 	return pci_host_probe(bridge);
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3a4860bd27586..3a10f8cfc3ad5 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -45,6 +45,10 @@ struct pci_ecam_ops {
 	unsigned int			bus_shift;
 	struct pci_ops			pci_ops;
 	int				(*init)(struct pci_config_window *);
+	int				(*enable_device)(struct pci_host_bridge *,
+							 struct pci_dev *);
+	void				(*disable_device)(struct pci_host_bridge *,
+							  struct pci_dev *);
 };
 
 /*
-- 
2.39.2


