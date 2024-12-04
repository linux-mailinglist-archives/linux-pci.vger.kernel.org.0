Return-Path: <linux-pci+bounces-17645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65489E3A39
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962D02868BB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA41BF300;
	Wed,  4 Dec 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbsX5b4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72A1BD4E5;
	Wed,  4 Dec 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316367; cv=none; b=N4QEqGqdxLRx71o5YXTUwRG4h6ihwWu1LTa6e2F1NHT3ODDtHQJ66z1iInD+O+UDFkBTNnYJhGXR4m8PY/DkBpzVoJ2gwqxdxsIaEwaClIIcq8mx3bKPrNJomPDm6SQsfyuU4nep8JW576tVMgrEct+O4h0I3Wgf4cYcekrOmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316367; c=relaxed/simple;
	bh=qwPg4vWceORrtj1oc93ZKHM01ZRkNO9H4Rht+pty/UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gslhZVQV5KKhsxIROcmSwC5D9OUDSbJazvLr4uGnXpHPqqJ4MQzIB4ju1/90CKfGsxIvN1j3rSlGm6+jwX7cU3FGMSNyg6ZklimShX/4MjqQtuzWFo2ztiUBhibKf0PsDHvzkbQEejSWdJy+Zi9imsL7bboWioWSec6BBBF2m7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbsX5b4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA878C4CEE4;
	Wed,  4 Dec 2024 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316366;
	bh=qwPg4vWceORrtj1oc93ZKHM01ZRkNO9H4Rht+pty/UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbsX5b4sS2duxSnQFRgweC+d/Bee9ibNyDCNoabkrmRvCqNOgOhoQ3ADrPSUOnM5U
	 o+Nr3uW+TvyLMkm9CisvsQggJkZ1IVv0AuEY++SlZh8YAxNEtCV2fyxh0adj5UqEUu
	 317dZM5JQqEHNwvYjxNxX68nL8dmm6CK89JwY0cjORMOYC5uHDIral646J9slE02WH
	 Q5LuzUp7Q2OAlbljEKOqQsLJv/JiWiaTgmkXpWut9mjJUTGbJhMXpwxbyHlo/P3Kai
	 8Xu0LlKRXaOW9eqH+W+47IDf5dDkvgc51bIKJsN/IGsAg93OKdvd6t4eCfMFL5a0jL
	 0i047dADaKKTA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIolY-000RHy-Gv;
	Wed, 04 Dec 2024 12:46:04 +0000
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
Subject: [PATCH 02/11] genirq/msi: Add helper for creating MSI-parent irq domains
Date: Wed,  4 Dec 2024 12:45:40 +0000
Message-Id: <20241204124549.607054-3-maz@kernel.org>
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

Creating an irq domain that serves as an MSI parent requires
a substantial amount of esoteric boiler-plate code, some of
which is often provided twice (such as the bus token).

To make things a bit simpler for the unsuspecting MSI tinkerer,
provide a helper that does it for them, and serves as documentation
of what needs to be provided.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/msi.h |  7 +++++++
 kernel/irq/msi.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00ea..f08d14cf07103 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -594,6 +594,13 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
 
+struct irq_domain *msi_create_parent_irq_domain(struct fwnode_handle *fwnode,
+						const struct msi_parent_ops *msi_parent_ops,
+						const struct irq_domain_ops *ops,
+						unsigned long flags, unsigned long size,
+						void *host_data,
+						struct irq_domain *parent);
+
 bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  const struct msi_domain_template *template,
 				  unsigned int hwsize, void *domain_data,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56b..037d85cf0b21c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -885,6 +885,46 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 	return __msi_create_irq_domain(fwnode, info, 0, parent);
 }
 
+/**
+ * msi_create_parent_irq_domain - Create an MSI-parent interrupt domain
+ * @fwnode:		Optional fwnode of the interrupt controller
+ * @msi_parent_ops:	MSI parent callbacks and configuration
+ * @ops:		Interrupt domain ballbacks
+ * @flags:		Interrupt domain flags
+ * @size:		Interrupt domain size (0 if arbitrarily large)
+ * @host_data:		Interrupt domain private data
+ * @parent:		Parent irq domain
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
+ */
+struct irq_domain *msi_create_parent_irq_domain(struct fwnode_handle *fwnode,
+						const struct msi_parent_ops *msi_parent_ops,
+						const struct irq_domain_ops *ops,
+						unsigned long flags, unsigned long size,
+						void *host_data,
+						struct irq_domain *parent)
+{
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.size		= size,
+		.hwirq_max	= size,
+		.ops		= ops,
+		.host_data	= host_data,
+		.domain_flags	= flags | IRQ_DOMAIN_FLAG_MSI_PARENT,
+		.parent		= parent,
+		.bus_token	= msi_parent_ops->bus_select_token,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	if (IS_ERR(d))
+		return NULL;
+
+	d->msi_parent_ops = msi_parent_ops;
+	return d;
+}
+EXPORT_SYMBOL_GPL(msi_create_parent_irq_domain);
+
 /**
  * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info down
  *				  in the domain hierarchy
-- 
2.39.2


