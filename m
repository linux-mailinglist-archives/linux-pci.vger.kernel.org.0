Return-Path: <linux-pci+bounces-33656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87BB1F217
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 06:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57747210D7
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 04:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754B2566F7;
	Sat,  9 Aug 2025 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RNmbtTat";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJllSzE+"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC81C5F39;
	Sat,  9 Aug 2025 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754714081; cv=none; b=e4yW3cOnbqCnGS+VK1OVIJYU18fJDkNxa9RgUpsdKtfsyAr7/lz+Sxg19qTi+zSYBWoewAQ4q13sk5kE54bIt90VL1kmEMewtW/GlDCDH0JHdmF7L0/ZsV+93tIzz6TnEvNkGFqDszQL+p4SYBpo6t/vuBhViqsnLliH7dCyqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754714081; c=relaxed/simple;
	bh=Zo5T/SiS5M4Weqq0nzxX1Pv8LNiMgmasLtemMo5oUYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUHlp2VZUmCE/nFDyqkFhIhqpOHgLh3XGmsFubdVSbqEujsAsRok3hglzwhlnZj39BhLqyDH0HBiz0Tu8MQ52whfw/xY89D1PN6TJ4zuDISAcoJvVjxAHWG3ikcLMwMOw+6jQiYmZaPTPBnjNuX1MPO0eo37ajJ8YiYQKcJFtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RNmbtTat; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJllSzE+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 9 Aug 2025 06:34:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754714074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GY9fZRN4+9czE0M2vraIOlP6NJn0IsJJVkshQTSPj84=;
	b=RNmbtTatAqUOIi2DvukzXCEycc11ZqQmQL8Bt3+8bUmtjupXPeqMQ/93JY7JteTLBXqUjl
	0mi7PWpTZHHD9fqXylihhb2ivzbo4Q7tlvphvu3EVgZR7yirJrzSPh5kBgD6XYXShlBv4H
	Lcz6Gb/Yxt/GCoW4dgmENjDt2NcjkTcVtmF7rsaHNTzSsAHRbwO9yDScMOuUhs1r9IoRY1
	aXOU9+UHpMyvxutVNcv/4YxkHKrp97DrjBcKSM2rGBZNLZ23mMndJff9ORkEUUb9bnK+Au
	IF6K+egkbeOPO3ES39oXJo69dvuro8PRC27rEKVxFJT2ChygJaX2duao8ORIuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754714074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GY9fZRN4+9czE0M2vraIOlP6NJn0IsJJVkshQTSPj84=;
	b=jJllSzE+Yz5qJz3JzG5wN4Xrr+afLYWuAcUfUDmppGiah79YxC40eU/k1YGl5wzlRVPccC
	PxMNP3Xl0yybp2Aw==
From: Nam Cao <namcao@linutronix.de>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org, namcaov@gmail.com
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <20250809043409.wLu40x1p@linutronix.de>
References: <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
 <87ectlr8l4.fsf@yellow.woof>
 <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>

On Sat, Aug 09, 2025 at 07:52:30AM +0900, Ammar Faizi wrote:
> I can do that. Send me a git diff. I'll test it and back with the dmesg
> output.

That would be very helpful, thanks!

Please bear with me, this may take a few iterations.

Let's first try the below.


diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9bbb0ff4cc15..ce477c030990 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -304,11 +304,14 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent,
 				  struct msi_domain_info *info)
 {
+	pr_err("%s: bus_token=%d\n", __func__, (int)info->bus_token);
 	if (WARN_ON_ONCE(info->bus_token != DOMAIN_BUS_PCI_DEVICE_MSIX))
 		return false;
 
-	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info)) {
+		pr_err("%s:%d err=msi_lib_init\n", __func__, __LINE__);
 		return false;
+	}
 
 	info->chip->irq_enable		= vmd_pci_msi_enable;
 	info->chip->irq_disable		= vmd_pci_msi_disable;
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 818d55fbad0d..e5f83036d76f 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -265,6 +265,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSIX) {
+		pci_err(dev, "%s:%d msix\n", __func__, __LINE__);
 		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
 						affd, flags);
 		if (nvecs > 0)
@@ -272,6 +273,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSI) {
+		pci_err(dev, "%s:%d msi\n", __func__, __LINE__);
 		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
 		if (nvecs > 0)
 			return nvecs;
@@ -279,6 +281,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 
 	/* use INTx IRQ if allowed */
 	if (flags & PCI_IRQ_INTX) {
+		pci_err(dev, "%s:%d INTx\n", __func__, __LINE__);
 		if (min_vecs == 1 && dev->irq) {
 			/*
 			 * Invoke the affinity spreading logic to ensure that
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0938ef7ebabf..6695508e9e53 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -13,8 +13,10 @@ int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	struct irq_domain *domain;
 
 	domain = dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
+	if (domain && irq_domain_is_hierarchy(domain)) {
+		pci_err(dev, "%s:%d err=\n", __func__, __LINE__);
 		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, nvec);
+	}
 
 	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
 }
@@ -355,6 +357,7 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 	if (!domain || !irq_domain_is_hierarchy(domain)) {
 		if (IS_ENABLED(CONFIG_PCI_MSI_ARCH_FALLBACKS))
 			return mode == ALLOW_LEGACY;
+		pci_err(pdev, "%s:%d err\n", __func__, __LINE__);
 		return false;
 	}
 
@@ -364,6 +367,7 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 		 * msi_domain_info::flags is the authoritative source of
 		 * information.
 		 */
+		pci_err(pdev, "%s:%d not msi parent\n", __func__, __LINE__);
 		info = domain->host_data;
 		supported = info->flags;
 	} else {
@@ -374,6 +378,7 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 		 * per device domain because the parent is never
 		 * expanding the PCI/MSI functionality.
 		 */
+		pci_err(pdev, "%s:%d is msi parent\n", __func__, __LINE__);
 		supported = domain->msi_parent_ops->supported_flags;
 	}
 
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 34d664139f48..028281d51fd0 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -31,19 +31,25 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
 	struct pci_bus *bus;
 
 	/* MSI must be globally enabled and supported by the device */
-	if (!pci_msi_enable)
+	if (!pci_msi_enable) {
+		pci_err(dev, "%s:%d err=pci_msi_enable\n", __func__, __LINE__);
 		return 0;
+	}
 
-	if (!dev || dev->no_msi)
+	if (!dev || dev->no_msi) {
+		pci_err(dev, "%s:%d err=no_msi\n", __func__, __LINE__);
 		return 0;
+	}
 
 	/*
 	 * You can't ask to have 0 or less MSIs configured.
 	 *  a) it's stupid ..
 	 *  b) the list manipulation code assumes nvec >= 1.
 	 */
-	if (nvec < 1)
+	if (nvec < 1) {
+		pci_err(dev, "%s:%d err=nvec\n", __func__, __LINE__);
 		return 0;
+	}
 
 	/*
 	 * Any bridge which does NOT route MSI transactions from its
@@ -60,8 +66,10 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
 	 * at probe time.
 	 */
 	for (bus = dev->bus; bus; bus = bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI) {
+			pci_err(dev, "%s:%d bus_flags\n", __func__, __LINE__);
 			return 0;
+		}
 
 	return 1;
 }
@@ -86,8 +94,10 @@ static int pcim_setup_msi_release(struct pci_dev *dev)
 		return 0;
 
 	ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
-	if (ret)
+	if (ret) {
+		pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, ret);
 		return ret;
+	}
 
 	dev->is_msi_managed = true;
 	return 0;
@@ -671,17 +681,23 @@ static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *ent
 	struct pci_dev *dev __free(free_msi_irqs) = __dev;
 
 	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
-	if (ret)
+	if (ret) {
+		pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, ret);
 		return ret;
+	}
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
-	if (ret)
+	if (ret) {
+		pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, ret);
 		return ret;
+	}
 
 	/* Check if all MSI entries honor device restrictions */
 	ret = msi_verify_entries(dev);
-	if (ret)
+	if (ret) {
+		pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, ret);
 		return ret;
+	}
 
 	msix_update_entries(dev, entries);
 	retain_and_null_ptr(dev);
@@ -736,8 +752,10 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	}
 
 	ret = msix_setup_interrupts(dev, entries, nvec, affd);
-	if (ret)
+	if (ret) {
+		pci_err(dev, "%s:%d err=setup irqs\n", __func__, __LINE__);
 		goto out_disable;
+	}
 
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
@@ -793,30 +811,40 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 {
 	int hwsize, rc, nvec = maxvec;
 
-	if (maxvec < minvec)
+	if (maxvec < minvec) {
+		pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, -ERANGE);
 		return -ERANGE;
+	}
 
 	if (dev->msi_enabled) {
-		pci_info(dev, "can't enable MSI-X (MSI already enabled)\n");
+		pci_err(dev, "can't enable MSI-X (MSI already enabled)\n");
 		return -EINVAL;
 	}
 
-	if (WARN_ON_ONCE(dev->msix_enabled))
+	if (WARN_ON_ONCE(dev->msix_enabled)) {
+		pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, -EINVAL);
 		return -EINVAL;
+	}
 
 	/* Check MSI-X early on irq domain enabled architectures */
-	if (!pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX, ALLOW_LEGACY))
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX, ALLOW_LEGACY)) {
+		pci_err(dev, "%s:%d err=ENOTSUPP\n", __func__, __LINE__);
 		return -ENOTSUPP;
+	}
 
 	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
 		return -EINVAL;
 
 	hwsize = pci_msix_vec_count(dev);
-	if (hwsize < 0)
+	if (hwsize < 0) {
+		pci_err(dev, "%s:%d err=hwsize\n", __func__, __LINE__);
 		return hwsize;
+	}
 
-	if (!pci_msix_validate_entries(dev, entries, nvec))
+	if (!pci_msix_validate_entries(dev, entries, nvec)) {
+		pci_err(dev, "%s:%d err=validate entries\n", __func__, __LINE__);
 		return -EINVAL;
+	}
 
 	if (hwsize < nvec) {
 		/* Keep the IRQ virtual hackery working */
@@ -826,21 +854,27 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 			nvec = hwsize;
 	}
 
-	if (nvec < minvec)
+	if (nvec < minvec) {
+		pci_err(dev, "%s:%d err=ENOSPC\n", __func__, __LINE__);
 		return -ENOSPC;
+	}
 
 	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
 
-	if (!pci_setup_msix_device_domain(dev, hwsize))
+	if (!pci_setup_msix_device_domain(dev, hwsize)) {
+		pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, -ENODEV);
 		return -ENODEV;
+	}
 
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
-			if (nvec < minvec)
+			if (nvec < minvec) {
+				pci_err(dev, "%s:%d err=%d\n", __func__, __LINE__, -ENOSPC);
 				return -ENOSPC;
+			}
 		}
 
 		rc = msix_capability_init(dev, entries, nvec, affd);
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index d1b68c18444f..44d1c0cd79fa 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -190,6 +190,7 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 		goto intx_irq;
 
 	/* Try to use MSI-X or MSI if supported */
+	pr_err("%s:%d\n", __func__, __LINE__);
 	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
 		return 0;
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dc473faadcc8..1771b6a24765 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -229,13 +229,17 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 
 	if (WARN_ON((info->size && info->direct_max) ||
 		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && info->direct_max) ||
-		    (info->direct_max && info->direct_max != info->hwirq_max)))
+		    (info->direct_max && info->direct_max != info->hwirq_max))) {
+		pr_err("%s:%d\n err", __func__, __LINE__);
 		return ERR_PTR(-EINVAL);
+	}
 
 	domain = kzalloc_node(struct_size(domain, revmap, info->size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(info->fwnode)));
-	if (!domain)
+	if (!domain) {
+		pr_err("%s:%d\n err", __func__, __LINE__);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	err = irq_domain_set_name(domain, info);
 	if (err) {
@@ -328,14 +332,18 @@ static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_info
 
 	if (info->dgc_info) {
 		err = irq_domain_alloc_generic_chips(domain, info->dgc_info);
-		if (err)
+		if (err) {
+			pr_err("%s:%d\n err=%d", __func__, __LINE__, err);
 			goto err_domain_free;
+		}
 	}
 
 	if (info->init) {
 		err = info->init(domain);
-		if (err)
+		if (err) {
+			pr_err("%s:%d\n err=%d", __func__, __LINE__, err);
 			goto err_domain_gc_remove;
+		}
 	}
 
 	__irq_domain_publish(domain);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9b09ad3f9914..b86ed78be575 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -316,11 +316,14 @@ int msi_setup_device_data(struct device *dev)
 		return 0;
 
 	md = devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);
-	if (!md)
+	if (!md) {
+		dev_err(dev, "%s:%d err=ENOMEM\n", __func__, __LINE__);
 		return -ENOMEM;
+	}
 
 	ret = msi_sysfs_create_group(dev);
 	if (ret) {
+		dev_err(dev, "%s:%d err=%d\n", __func__, __LINE__, ret);
 		devres_free(md);
 		return ret;
 	}
@@ -1035,16 +1038,22 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	const struct msi_parent_ops *pops;
 	struct fwnode_handle *fwnode;
 
-	if (!irq_domain_is_msi_parent(parent))
+	if (!irq_domain_is_msi_parent(parent)) {
+		dev_err(dev, "%s:%d err=not parent\n", __func__, __LINE__);
 		return false;
+	}
 
-	if (domid >= MSI_MAX_DEVICE_IRQDOMAINS)
+	if (domid >= MSI_MAX_DEVICE_IRQDOMAINS) {
+		dev_err(dev, "%s:%d err=max domain\n", __func__, __LINE__);
 		return false;
+	}
 
 	struct msi_domain_template *bundle __free(kfree) =
 		kmemdup(template, sizeof(*bundle), GFP_KERNEL);
-	if (!bundle)
+	if (!bundle) {
+		dev_err(dev, "%s:%d err=mem\n", __func__, __LINE__);
 		return false;
+	}
 
 	bundle->info.hwsize = hwsize;
 	bundle->info.chip = &bundle->chip;
@@ -1077,23 +1086,32 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	if (!fwnode)
 		return false;
 
-	if (msi_setup_device_data(dev))
+	if (msi_setup_device_data(dev)) {
+		dev_err(dev, "%s:%d err=setup\n", __func__, __LINE__);
 		return false;
+	}
 
 	guard(msi_descs_lock)(dev);
-	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid))) {
+		dev_err(dev, "%s:%d err=get domain\n", __func__, __LINE__);
 		return false;
+	}
 
-	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
+	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info)) {
+		dev_err(dev, "%s:%d err=init_msi_info\n", __func__, __LINE__);
 		return false;
+	}
 
 	domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE, parent);
-	if (!domain)
+	if (!domain) {
+		dev_err(dev, "%s:%d err=create domain\n", __func__, __LINE__);
 		return false;
+	}
 
 	dev->msi.data->__domains[domid].domain = domain;
 
 	if (msi_domain_prepare_irqs(domain, dev, hwsize, &bundle->alloc_info)) {
+		pr_err("%s:%d\n err=prepare_irqs", __func__, __LINE__);
 		dev->msi.data->__domains[domid].domain = NULL;
 		irq_domain_remove(domain);
 		return false;

