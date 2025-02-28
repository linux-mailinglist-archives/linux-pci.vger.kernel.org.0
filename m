Return-Path: <linux-pci+bounces-22648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCDA49DEC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3331895865
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBBA27560E;
	Fri, 28 Feb 2025 15:47:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B9271832;
	Fri, 28 Feb 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757621; cv=none; b=tHalEZDy9q5fUs7FR+1AK5XWmgOzxvGIT+XjESp2E9YezdUdXcmnW5EsFLJiR+k3EAyzjbdqERn8MR4ax6hn4PBm6jJ0KlwmP/hzbflaDCVgMiNlec6NjKenNz7TVYo1jJ3srxFaFvqgIqaZ+r+5LG7V5Sp+PgTE/tpBQW4T0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757621; c=relaxed/simple;
	bh=mLeeVYrTUsBbxtedph86DS195K5D9XKDOeRf6Q9qHP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwahahCgT8mQ6QilqKxBFUjdBU/CcjNwt78uGV6G2GMUCfySXcdCOxV5vGm1oLrceVPF89aHM9CrjazUEcSmG4RcQy6psS3wAIbp5FyOC2kyZrgXcxmSLJ0DhSxqcNEI+sPEOAiaGJ7AiMw5gaV34RXTuh9PwCwEeybhlMA/yhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 454AE1BB0;
	Fri, 28 Feb 2025 07:47:13 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D32043F5A1;
	Fri, 28 Feb 2025 07:46:54 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH v2 3/4] iommu: Keep dev->iommu state consistent
Date: Fri, 28 Feb 2025 15:46:32 +0000
Message-Id: <d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1740753261.git.robin.murphy@arm.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment, if of_iommu_configure() allocates dev->iommu itself via
iommu_fwspec_init(), then suffers a DT parsing failure, it cleans up the
fwspec but leaves the empty dev_iommu hanging around. So far this is
benign (if a tiny bit wasteful), but we'd like to be able to reason
about dev->iommu having a consistent and unambiguous lifecycle. Thus
make sure that the of_iommu cleanup undoes precisely whatever it did.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New

 drivers/iommu/iommu-priv.h | 2 ++
 drivers/iommu/iommu.c      | 2 +-
 drivers/iommu/of_iommu.c   | 6 +++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 17e245cf17bb..6574c1f97e14 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -17,6 +17,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
+void dev_iommu_free(struct device *dev);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 37b7088e129a..a3b45b84f42b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -352,7 +352,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 	return param;
 }
 
-static void dev_iommu_free(struct device *dev)
+void dev_iommu_free(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 97987cd78da9..e10a68b5ffde 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -116,6 +116,7 @@ static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
+	bool dev_iommu_present;
 	int err;
 
 	if (!master_np)
@@ -127,6 +128,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		mutex_unlock(&iommu_probe_device_lock);
 		return 0;
 	}
+	dev_iommu_present = dev->iommu;
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
@@ -147,8 +149,10 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
 
-	if (err)
+	if (err && dev_iommu_present)
 		iommu_fwspec_free(dev);
+	else if (err && dev->iommu)
+		dev_iommu_free(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
 	if (!err && dev->bus)
-- 
2.39.2.101.g768bb238c484.dirty


