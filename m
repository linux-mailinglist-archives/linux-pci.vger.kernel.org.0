Return-Path: <linux-pci+bounces-30735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18986AE9B81
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381136A58BD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445232DF3E1;
	Thu, 26 Jun 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhksvSFz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AE25B678;
	Thu, 26 Jun 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933730; cv=none; b=I6MBzYsVkZL0IIMcHnvULBs0oqNVqFLs+pXCq2yjcBrlI4BE1faGQzv1RMO4I2rp+yJ5L04HQUFbzJdozGRGMz7NolImGUoiv+W8ng4TNOJU27Zg7of5r/68hlFcOMatQ+h1YLU6+lH6+WguqAN2TA/FJDJG1MtCtF4giBBY+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933730; c=relaxed/simple;
	bh=qQUoYRDsuGgB8vCzbvbRUy/RkIeih4RsG46sVkq+6kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQanUVAH05R/FOoI9tdCVhWDsnWAy6V/pbPNc3EvlP9spTe8hU1Gt/OxGza28Ym8GC0rqo/qHQPRegCbBAAUlV9rJALaaCiBrsU8s0cFyBPusHICwOYqB3IfzVmBv5yuxdn7qnkK1RlTnSUWHw148YbKV4VNh2qOYJh+wLyQN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhksvSFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7416C4CEEF;
	Thu, 26 Jun 2025 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933729;
	bh=qQUoYRDsuGgB8vCzbvbRUy/RkIeih4RsG46sVkq+6kI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nhksvSFzXRN+TKFDSpqakiEQuYMf0nrMn8e/Crho+x+7CpfIf1L6RuonQzTqh+9UJ
	 DMu9gmVnKPAsrwyVbELQfoIjc/GWunHPi6mVg2gLQt+u9M5b1YGwhrAjWTHijsKNzN
	 zUopEj7hSAVaH5oiMiqIMutAgFQEN+yrz6O5jm7RPf5/+c1tqoPC8upmJkLqnHZjif
	 dsp67vEKjfrQszIUjFtGAuD/VJ4Wzn5zoru3tYcf0vVEkirl3cQiXWRLvmcxarzoaW
	 AVEjkvQk8SzILg0BZYrJEazVXLDZrGg5Zo6qfv+cFVZAE+WQOAu/fTJ/Mr7HSAo2Gp
	 N4Il5UWwOixZQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:18 +0200
Subject: [PATCH v6 27/31] irqchip/msi-lib: Add
 IRQ_DOMAIN_FLAG_FWNODE_PARENT handling
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-27-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
In-Reply-To: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

In some irqchip implementations the fwnode representing the IRQdomain
and the MSI controller fwnode do not match; in particular the IRQdomain
fwnode is the MSI controller fwnode parent.

To support selecting such IRQ domains, add a flag in core IRQ domain
code that explicitly tells the MSI lib to use the parent fwnode while
carrying out IRQ domain selection.

Update the msi-lib select callback with the resulting logic.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-msi-lib.c | 5 ++++-
 include/linux/irqdomain.h     | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 246c30205af4..454c7f16dd4d 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -133,11 +133,14 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 {
 	const struct msi_parent_ops *ops = d->msi_parent_ops;
 	u32 busmask = BIT(bus_token);
+	struct fwnode_handle *fwh;
 
 	if (!ops)
 		return 0;
 
-	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
+	fwh = d->flags & IRQ_DOMAIN_FLAG_FWNODE_PARENT ? fwnode_get_parent(fwspec->fwnode)
+						       : fwspec->fwnode;
+	if (fwh != d->fwnode || fwspec->param_count != 0)
 		return 0;
 
 	/* Handle pure domain searches */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 7387d183029b..25c7cbeed393 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -212,6 +212,9 @@ enum {
 	/* Address and data pair is mutable when irq_set_affinity() */
 	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
 
+	/* IRQ domain requires parent fwnode matching */
+	IRQ_DOMAIN_FLAG_FWNODE_PARENT	= (1 << 12),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the

-- 
2.48.0


