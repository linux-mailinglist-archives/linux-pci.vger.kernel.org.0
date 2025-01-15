Return-Path: <linux-pci+bounces-19850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D7A11C0D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E088B3A6140
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C11E7C03;
	Wed, 15 Jan 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UStlwaza"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958B1DB133
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930018; cv=none; b=aR3/l37wh50vrH293GVo2GRGtZ8eOl1DV/5COKxcprfgiOUQptj/BmXLVkC2tXLrdWZL/6kMK+gRlQE5sU3mpPsNnKyRt2aOM7ToTGYSfTxvtdLpGYWRXYbFCDxDp1H8r5JpDeCru+AFDS0alxfxEFmbxS16jE7OqUl2ATtrKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930018; c=relaxed/simple;
	bh=OLV44hQwSkTwfh1ZuTQ5b5xC0Pp4SOufeb2WtRRywRU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=egARJWI+gRCHUj0GW6NeA6b3d27tXtXT7jq+6vVEBOUzy/20AWOFkT/DYUjQlZuUzT97NE3MrwY3F30ZiZxFGwVKcHefYZXSnl++ykZXK2LaqTU6nM+ysLvaX6oCvj82AIh0zb1UrD+zLit4tUblsAPjiWDjrHQ8bDzCWi7xCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielsftsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UStlwaza; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielsftsai.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so11614615a91.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736930016; x=1737534816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FsAiUdba5Mucqo50oO6EIg3p9URSe0dEK+Xh8dUE2cE=;
        b=UStlwaza0+cCvXea2ndQMiGFOpj8oszJQ3AB9vttQscjHuj13wvOK4p7CUNGMeiC9g
         xdY2mJrbnwTqCFNL8wpQgQ+WfYht8F923B2msKTOr1+DW2du3gPBRdmQC3gQTMPfJjye
         ChucVmjqCh4Uw40hH1k9IBp8GZNxEa0jViGc7ZXJbbNFKh5pNyhhLzetHtWFr9ZLAwU+
         GFwDrdc+6VBOYKYd4WVtj+jgFbmUGOI62FiVXCdSVnbLVjQC76LXcRJpGtICk0q94kze
         kSKddObh1FzeUL/0xyVVOot1pBBGgUEn3xk7q9ygZA9S4bINB4n0fvHO+AK6dfoXUXVC
         u2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930016; x=1737534816;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsAiUdba5Mucqo50oO6EIg3p9URSe0dEK+Xh8dUE2cE=;
        b=JyrmIlxIZiyXYyfRqoUmrtWwmkt1zdnnr13Wa9wPUsUN/2oQp4CMendHrc7sJpSbSl
         2+sc8yi0jwqIAK7Q2CNj8CNkDfuGCH5XLusceXSaJxvfjzIYIk+s4HcZ0kiT1ht0zt38
         QAUfO5Ypq/unG5ajYNxhWyuwynC7TzKBMHrawSBb5Ceh7G7aIB270kNHPh1vs012wX9m
         vd6PU798pq0mHt9LeRw3i4A9Mar2D+KY64nFOotVUCcqmSLtH+BXRKSHogBh7BV2POEQ
         HdJDjJo7nf2R/DfGc9npLybj39LUTB5KrtdCk6TmP7iN1WN4ZD95rNtHGM3D5lIo61I4
         eFGg==
X-Forwarded-Encrypted: i=1; AJvYcCUAFTe79YC+Wg2vJP4vIvy6Jr4ZrsRcnrFrOg8DraA35mlWzgO89iaW63rq8MzMZnC3VHHTky1f9Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PJoAeAl/NegbszEIqKt5E1Y0M62sUnRbrZ0PD8L9jCou4MiQ
	AqIHfouwGU4W/egHfux7T1rliFLbOADSNBRO/IP6fpTLkwNCe+0Vi3025l09xbosRL/ffyutz/k
	6intP9PojlzsVmTM2mZ8/66l0gw==
X-Google-Smtp-Source: AGHT+IHn00OwbuG3HUBN6piQN5R2qfT1W3uqqRLmC4NHhKa11yICw++JD6EczvUSI21a/LlVMWMFv0huHeYaEPtHvIo=
X-Received: from pjbsz8.prod.google.com ([2002:a17:90b:2d48:b0:2e0:9fee:4b86])
 (user=danielsftsai job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d00c:b0:2ee:c5ea:bd91 with SMTP id 98e67ed59e1d1-2f548f1d783mr39875970a91.29.1736930016608;
 Wed, 15 Jan 2025 00:33:36 -0800 (PST)
Date: Wed, 15 Jan 2025 08:32:15 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115083215.2781310-1-danielsftsai@google.com>
Subject: [PATCH] PCI: dwc: Separate MSI out to different controller
From: Daniel Tsai <danielsftsai@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tsai Sung-Fu <danielsftsai@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Tsai Sung-Fu <danielsftsai@google.com>

Setup the struct irq_affinity at EP side, and passing that as 1 of the
function parameter when endpoint calls pci_alloc_irq_vectors_affinity,
this could help to setup non-default irq_affinity for target irq (end up
in irq_desc->irq_common_data.affinity), and we can make use of that to
separate msi vector out to bind to other msi controller.

In current design, we have 8 msi controllers, and each of them own up to
32 msi vectors, layout as below

msi_controller0 <- msi_vector0 ~ 31
msi_controller1 <- msi_vector32 ~ 63
msi_controller2 <- msi_vector64 ~ 95
.
.
.
msi_controller7 <- msi_vector224 ~ 255

dw_pcie_irq_domain_alloc is allocating msi vector number in a contiguous
fashion, that would end up those allocated msi vectors all handled by
the same msi_controller, which all of them would have irq affinity in
equal. To separate out to different CPU, we need to distribute msi
vectors to different msi_controller, which require to allocate the msi
vector in a stride fashion.

To do that, the CL make use the cpumask_var_t setup by the endpoint,
compare against to see if the affinities are the same, if they are,
bind to msi controller which previously allocated msi vector goes to, if
they are not, assign to new msi controller.

Signed-off-by: Tsai Sung-Fu <danielsftsai@google.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 80 +++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2291c3ceb8be..192d05c473b3b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -181,25 +181,75 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 				    void *args)
 {
 	struct dw_pcie_rp *pp = domain->host_data;
-	unsigned long flags;
-	u32 i;
-	int bit;
+	const struct cpumask *mask;
+	unsigned long flags, index, start, size;
+	int irq, ctrl, p_irq, *msi_vec_index;
+	unsigned int controller_count = (pp->num_vectors / MAX_MSI_IRQS_PER_CTRL);
+
+	/*
+	 * All IRQs on a given controller will use the same parent interrupt,
+	 * and therefore the same CPU affinity. We try to honor any CPU spreading
+	 * requests by assigning distinct affinity masks to distinct vectors.
+	 * So instead of always allocating the msi vectors in a contiguous fashion,
+	 * the algo here honor whoever comes first can bind the msi controller to
+	 * its irq affinity mask, or compare its cpumask against
+	 * currently recorded to decide if binding to this msi controller.
+	 */
+
+	msi_vec_index = kcalloc(nr_irqs, sizeof(*msi_vec_index), GFP_KERNEL);
+	if (!msi_vec_index)
+		return -ENOMEM;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
-				      order_base_2(nr_irqs));
+	for (irq = 0; irq < nr_irqs; irq++) {
+		mask = irq_get_affinity_mask(virq + irq);
+		for (ctrl = 0; ctrl < controller_count; ctrl++) {
+			start = ctrl * MAX_MSI_IRQS_PER_CTRL;
+			size = start + MAX_MSI_IRQS_PER_CTRL;
+			if (find_next_bit(pp->msi_irq_in_use, size, start) >= size) {
+				cpumask_copy(&pp->msi_ctrl_to_cpu[ctrl], mask);
+				break;
+			}
 
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
+			if (cpumask_equal(&pp->msi_ctrl_to_cpu[ctrl], mask) &&
+			    find_next_zero_bit(pp->msi_irq_in_use, size, start) < size)
+				break;
+		}
 
-	if (bit < 0)
-		return -ENOSPC;
+		/*
+		 * no msi controller matches, we would error return (no space) and
+		 * clear those previously allocated bit, because all those msi vectors
+		 * didn't really successfully allocated, so we shouldn't occupied that
+		 * position in the bitmap in case other endpoint may still make use of
+		 * those. An extra step when choosing to not allocate in contiguous
+		 * fashion.
+		 */
+		if (ctrl == controller_count) {
+			for (p_irq = irq - 1; p_irq >= 0; p_irq--)
+				bitmap_clear(pp->msi_irq_in_use, msi_vec_index[p_irq], 1);
+			raw_spin_unlock_irqrestore(&pp->lock, flags);
+			kfree(msi_vec_index);
+			return -ENOSPC;
+		}
+
+		index = bitmap_find_next_zero_area(pp->msi_irq_in_use,
+						   size,
+						   start,
+						   1,
+						   0);
+		bitmap_set(pp->msi_irq_in_use, index, 1);
+		msi_vec_index[irq] = index;
+	}
 
-	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_info(domain, virq + i, bit + i,
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+
+	for (irq = 0; irq < nr_irqs; irq++)
+		irq_domain_set_info(domain, virq + irq, msi_vec_index[irq],
 				    pp->msi_irq_chip,
 				    pp, handle_edge_irq,
 				    NULL, NULL);
+	kfree(msi_vec_index);
 
 	return 0;
 }
@@ -207,15 +257,15 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 static void dw_pcie_irq_domain_free(struct irq_domain *domain,
 				    unsigned int virq, unsigned int nr_irqs)
 {
-	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct irq_data *d;
 	struct dw_pcie_rp *pp = domain->host_data;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
-			      order_base_2(nr_irqs));
-
+	for (int i = 0; i < nr_irqs; i++) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		bitmap_clear(pp->msi_irq_in_use, d->hwirq, 1);
+	}
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..95629b37a238e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -14,6 +14,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/cpumask.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma/edma.h>
 #include <linux/gpio/consumer.h>
@@ -373,6 +374,7 @@ struct dw_pcie_rp {
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
+	struct cpumask		msi_ctrl_to_cpu[MAX_MSI_CTRLS];
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
-- 
2.48.0.rc2.279.g1de40edade-goog


