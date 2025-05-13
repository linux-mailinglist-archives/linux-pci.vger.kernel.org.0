Return-Path: <linux-pci+bounces-27653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD69AB5B3A
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D791890891
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC22BEC2F;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyq8BCiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53C2BE7CA;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157310; cv=none; b=VFugc8Q0ANdOsi6jLW+YW8f5OseNzCJ973sNPxi3TzXZy6f8XT2h4yr8i4H7CmStbPFtsOFwJSDCFdlcF6lMmqk7MSzLSy6+J7v29ndeP2t7j10IhsW5UT8wBLWMXoF2SiTiRV3/OIUT6nfi1Y05APSJnxC5ri8dLF7bPzEU6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157310; c=relaxed/simple;
	bh=S6Ff81MD23ujzW5xAirjeHQsiPS7s/q55XaQYWojlYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctTLmzqE0SigYC0qdowpNrj9fV1ZjpPhjV0yereubNGXGr9VJToaxPtPZkxu+leyTxNS1/VUftMZXgNZkQ/yvQUzgZMTEU+ZAUYzpuRg3FonbRH9f8sk8CSLB6wlrkrp/8CfUcRIo9sl9SM0o6+okqrGbDtJmxC2nJPU6jMDruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyq8BCiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C17CC4CEF0;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157310;
	bh=S6Ff81MD23ujzW5xAirjeHQsiPS7s/q55XaQYWojlYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyq8BCiX/3xyRfa3lsPePerZ4XYr2gQBFZqvmeb7/qKSW75wAxFL6fUXhfVSUEUc6
	 b/GKae5N+5Ixi29qAZpnKUICt1ts6fYpNH8l+KOb9Y0l56+4Zu8Vm/W8kk429CRNVb
	 bBRUlQEguuK0QbspT19D7PjzXmmgNc3YdTVLYCbFax9QqHuEi7WOl9pqq3iGdY2WSs
	 Sc1etVrBqzkn+UHZQR/yjkRhhhv4NYUcDn9FngvI1M94j/iXNbKYqkvJkXJ3DGUMQA
	 4WEDgsbwaho1o4A0O3n8IpGC7iQIbgSKHn+DXy3W/4DNMlbIOKkLH68Gnwh0G5RYeT
	 MG7B7f0Sj1zoA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQa-00EbRz-AA;
	Tue, 13 May 2025 18:28:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 2/9] genirq/msi: Add helper for creating MSI-parent irq domains
Date: Tue, 13 May 2025 18:28:12 +0100
Message-Id: <20250513172819.2216709-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250513172819.2216709-1-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io, thierry.reding@gmail.com, jonathanh@nvidia.com
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
 include/linux/msi.h |  4 ++++
 kernel/irq/msi.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8c0ec9fc05a39..56c69d14ef4a2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -628,6 +628,10 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
 
+struct irq_domain_info;
+struct irq_domain *msi_create_parent_irq_domain(struct irq_domain_info *info,
+						const struct msi_parent_ops *msi_parent_ops);
+
 bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  const struct msi_domain_template *template,
 				  unsigned int hwsize, void *domain_data,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a8f7701c2929f..e702e536c8034 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -903,6 +903,32 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 	return __msi_create_irq_domain(fwnode, info, 0, parent);
 }
 
+/**
+ * msi_create_parent_irq_domain - Create an MSI-parent interrupt domain
+ * @info:		MSI irqdomain creation info
+ * @msi_parent_ops:	MSI parent callbacks and configuration
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
+ */
+struct irq_domain *msi_create_parent_irq_domain(struct irq_domain_info *info,
+						const struct msi_parent_ops *msi_parent_ops)
+{
+	struct irq_domain *d;
+
+	info->hwirq_max		= max(info->hwirq_max, info->size);
+	info->size		= info->hwirq_max;
+	info->domain_flags	|= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	info->bus_token		= msi_parent_ops->bus_select_token;
+
+	d = irq_domain_instantiate(info);
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


