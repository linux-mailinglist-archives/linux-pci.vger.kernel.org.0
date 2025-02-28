Return-Path: <linux-pci+bounces-22647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEADA49E06
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F7A3A7C38
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF4F272925;
	Fri, 28 Feb 2025 15:46:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B5C271815;
	Fri, 28 Feb 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757616; cv=none; b=NN9qIMzfRDQtw4O0qB7IQ/XCwnAiBdKVwzFJLcpevnIniP4WDVVbakDKT4Vqpqv1bqW1CGaWLExkl6QimCmdHDszdOnN1H8aaIvBKQ3uBuMpcs2mvX5bxskGm2eAkrHgqv4QYFzgWaFPH1gt7XJYFVASuQMFVwswTWBsu4P0a2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757616; c=relaxed/simple;
	bh=OM3WqQe6UPxqXED9zxKjghMTvhNE1uX1j7I1+kuUglE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNTHeuKxdV4hunrPUhglbMCE0u4YJKNkQO/wDFReZWKjw5msH1wqvwPJfGwpb0mXQk9PAhABCxyqILF632PcnmqGQNNUwTzTIMZQabNIqz3lE4F0o+rksG0yBBwaFXPYz+NBMlQbXNMk8Stw+YQCRWdNgBd3Wso/+zqBe5IJCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36FD1A25;
	Fri, 28 Feb 2025 07:47:09 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D14A3F5A1;
	Fri, 28 Feb 2025 07:46:51 -0800 (PST)
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
Subject: [PATCH v2 2/4] iommu: Resolve ops in iommu_init_device()
Date: Fri, 28 Feb 2025 15:46:31 +0000
Message-Id: <fa4b6cfc67a352488b7f4e0b736008307ce9ac2e.1740753261.git.robin.murphy@arm.com>
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

Since iommu_init_device() was factored out, it is in fact the only
consumer of the ops which __iommu_probe_device() is resolving, so let it
do that itself rather than passing them in. This also puts the ops
lookup at a more logical point relative to the rest of the flow through
__iommu_probe_device().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New

 drivers/iommu/iommu.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 179617bb412d..37b7088e129a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -404,14 +404,28 @@ EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
  */
-static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+static int iommu_init_device(struct device *dev)
 {
+	const struct iommu_ops *ops;
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
+	/*
+	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
+	 * instances with non-NULL fwnodes, and client devices should have been
+	 * identified with a fwspec by this point. Otherwise, we can currently
+	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
+	 * be present, and that any of their registered instances has suitable
+	 * ops for probing, and thus cheekily co-opt the same mechanism.
+	 */
+	ops = iommu_fwspec_ops(dev->iommu->fwspec);
+	if (!ops) {
+		ret = -ENODEV;
+		goto err_free;
+	}
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -514,22 +528,10 @@ DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
-	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	struct group_device *gdev;
 	int ret;
 
-	/*
-	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
-	 * instances with non-NULL fwnodes, and client devices should have been
-	 * identified with a fwspec by this point. Otherwise, we can currently
-	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
-	 * be present, and that any of their registered instances has suitable
-	 * ops for probing, and thus cheekily co-opt the same mechanism.
-	 */
-	ops = iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -543,7 +545,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (dev->iommu_group)
 		return 0;
 
-	ret = iommu_init_device(dev, ops);
+	ret = iommu_init_device(dev);
 	if (ret)
 		return ret;
 
-- 
2.39.2.101.g768bb238c484.dirty


