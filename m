Return-Path: <linux-pci+bounces-17649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A329E3A42
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF16169B59
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D20D1CF7B8;
	Wed,  4 Dec 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvvE2bmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689991CEAD6;
	Wed,  4 Dec 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316368; cv=none; b=J+lJXgPJojHFmIGVhAVBinrLB4ulWwU51zigy7kZUNijGJQSVi0mI+EVxUETWF85cDTwmRwxnC8MqFpf9xQT3eDDIihryWd+Ph8TFJ0ysB4EI2xSxHL2MfWDtxRY7sLPKC1WCzmxsSOYf0owZY4OW61AB1MVvP+nE5HidbBBxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316368; c=relaxed/simple;
	bh=dBlxdtKKIDXUcPL3xGhsmTLyyToka/SogTL+AHvkSKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRZuaJeOp8n4x1NP/eb8gxR0pYSsB88bYgszKvWZH/k4gmqq2yueXl7TMxKhJjocvVf3YZboKIFSh8XzNU1DjJPvbTczoKtUgZ4B7f2LVmTS6UsIvS4v5/EaAeVTnU9LeSGj0D5x8iCBr1T9ABnYlyls0jkGibISAF5AtM2ZiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvvE2bmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B93C4CEFA;
	Wed,  4 Dec 2024 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316368;
	bh=dBlxdtKKIDXUcPL3xGhsmTLyyToka/SogTL+AHvkSKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvvE2bmFyi4ii+jCYmLHcpmKKMRJEfg0hBoi+/2HyuZoB3HV1+mlNJeuh7g450CiD
	 U03dL7MjZ4ID/ghfz07pzmH43kDP3IwFCEQJ3g2E+Zmp+Rum2T2sKaSLb0K7Cdb/6g
	 3mCZwrKf9V8Bm0i6PFcfQ61qerHrXkqy7vKoYNrrarzCxXvXm1lDfeQDmXPb62aho0
	 Q+6OnSJXvHtwl8+aexKkXpagX4X3QqMAKhp+8W2Qgo+Rg0mptwfEncNomGNxk1e4wv
	 Kxl859SUjsHr2Gbff15WCbnodlWTwo0XDzN5gmPwAMuOmpzZQW2y9O/7ETlJzAKrn8
	 fy3lHnX61HaTQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIola-000RHy-3u;
	Wed, 04 Dec 2024 12:46:06 +0000
From: Marc Zyngier <maz@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH 06/11] irqchip/imx-mu-msi: Convert to msi_create_parent_irq_domain() helper
Date: Wed,  4 Dec 2024 12:45:44 +0000
Message-Id: <20241204124549.607054-7-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204124549.607054-1-maz@kernel.org>
References: <20241204124549.607054-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that we have a concise helper to create an MSI parent domain,
switch the IMX letter soup over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-imx-mu-msi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index b3f656c6e7708..b73968423bb9f 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -226,17 +226,15 @@ static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *d
 	struct irq_domain *parent;
 
 	/* Initialize MSI domain parent */
-	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
-					  &imx_mu_msi_domain_ops, msi_data);
+	parent = msi_create_parent_irq_domain(fwnodes, &imx_mu_msi_parent_ops,
+					      &imx_mu_msi_domain_ops, 0,
+					      IMX_MU_CHANS, msi_data, NULL);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
 
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 	parent->dev = parent->pm_dev = dev;
-	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	parent->msi_parent_ops = &imx_mu_msi_parent_ops;
 	return 0;
 }
 
-- 
2.39.2


