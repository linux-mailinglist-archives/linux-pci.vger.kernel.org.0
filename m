Return-Path: <linux-pci+bounces-22649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C2A49DEF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26010188E210
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E127293A;
	Fri, 28 Feb 2025 15:47:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B41B4250;
	Fri, 28 Feb 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757627; cv=none; b=JPhjVgD8Mg2HQZi2X0SBD/7DePeWCM2bklsAC2gU/Ms7zVDf+j3KstYPqrF3cQ7ZDx/6vN5mlXIxfltubZ0aVVdkZrPSCcWdTt+jX0NiAc6Lrj+9cDYCZQswBCTjsfGSgFe2BjHamnl+RR8hoyoJThjTWGPUrTLs943Yai5KRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757627; c=relaxed/simple;
	bh=0uq6Cn06X091gzvACtt4/MKouFd6h2E8vwvJG9rsgXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfHIeArIu/GH2QRXDdFYOVdPomrOXT/nYc0f9FUVF+4xVHY59dihqAoajPZEfEwN3DriM0w1msIMQiV02oPswBnjQtXd8QAj/Uq1sivH9Or/zMFNK+BIVYoCYzKef/HEP4yMRQcI3nV14dzA3Ykoxd/43ECSRVz8jr1DWO9EVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492811D14;
	Fri, 28 Feb 2025 07:47:20 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D718B3F5A1;
	Fri, 28 Feb 2025 07:47:01 -0800 (PST)
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
Subject: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe path
Date: Fri, 28 Feb 2025 15:46:33 +0000
Message-Id: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
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

In hindsight, there were some crucial subtleties overlooked when moving
{of,acpi}_dma_configure() to driver probe time to allow waiting for
IOMMU drivers with -EPROBE_DEFER, and these have become an
ever-increasing source of problems. The IOMMU API has some fundamental
assumptions that iommu_probe_device() is called for every device added
to the system, in the order in which they are added. Calling it in a
random order or not at all dependent on driver binding leads to
malformed groups, a potential lack of isolation for devices with no
driver, and all manner of unexpected concurrency and race conditions.
We've attempted to mitigate the latter with point-fix bodges like
iommu_probe_device_lock, but it's a losing battle and the time has come
to bite the bullet and address the true source of the problem instead.

The crux of the matter is that the firmware parsing actually serves two
distinct purposes; one is identifying the IOMMU instance associated with
a device so we can check its availability, the second is actually
telling that instance about the relevant firmware-provided data for the
device. However the latter also depends on the former, and at the time
there was no good place to defer and retry that separately from the
availability check we also wanted for client driver probe.

Nowadays, though, we have a proper notion of multiple IOMMU instances in
the core API itself, and each one gets a chance to probe its own devices
upon registration, so we can finally make that work as intended for
DT/IORT/VIOT platforms too. All we need is for iommu_probe_device() to
be able to run the iommu_fwspec machinery currently buried deep in the
wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
surprisingly straightforward to bootstrap this transformation by pretty
much just calling the same path twice. At client driver probe time,
dev->driver is obviously set; conversely at device_add(), or a
subsequent bus_iommu_probe(), any device waiting for an IOMMU really
should *not* have a driver already, so we can use that as a condition to
disambiguate the two cases, and avoid recursing back into the IOMMU core
at the wrong times.

Obviously this isn't the nicest thing, but for now it gives us a
functional baseline to then unpick the layers in between without many
more awkward cross-subsystem patches. There are some minor side-effects
like dma_range_map potentially being created earlier, and some debug
prints being repeated, but these aren't significantly detrimental. Let's
make things work first, then deal with making them nice.

With the basic flow finally in the right order again, the next step is
probably turning the bus->dma_configure paths inside-out, since all we
really need from bus code is its notion of which device and input ID(s)
to parse the common firmware properties with...

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-driver.c
Acked-by: Rob Herring (Arm) <robh@kernel.org> # of/device.c
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2:
 - Comment bus driver changes for clarity
 - Use dev->iommu as the now-robust replay condition
 - Drop the device_iommu_mapped() checks in the firmware paths as they
   weren't doing much - we can't replace probe_device_lock just yet...
 
 drivers/acpi/arm64/dma.c        |  5 +++++
 drivers/acpi/scan.c             |  7 -------
 drivers/amba/bus.c              |  3 ++-
 drivers/base/platform.c         |  3 ++-
 drivers/bus/fsl-mc/fsl-mc-bus.c |  3 ++-
 drivers/cdx/cdx.c               |  3 ++-
 drivers/iommu/iommu.c           | 24 +++++++++++++++++++++---
 drivers/iommu/of_iommu.c        |  7 ++++++-
 drivers/of/device.c             |  7 ++++++-
 drivers/pci/pci-driver.c        |  3 ++-
 10 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
index 52b2abf88689..f30f138352b7 100644
--- a/drivers/acpi/arm64/dma.c
+++ b/drivers/acpi/arm64/dma.c
@@ -26,6 +26,11 @@ void acpi_arch_dma_setup(struct device *dev)
 	else
 		end = (1ULL << 32) - 1;
 
+	if (dev->dma_range_map) {
+		dev_dbg(dev, "dma_range_map already set\n");
+		return;
+	}
+
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
 		end = dma_range_map_max(map);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9f4efa8f75a6..fb1fe9f3b1a3 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1632,13 +1632,6 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		err = viot_iommu_configure(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * iommu_probe_device() call for dev, replay it to get things in order.
-	 */
-	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
-
 	return err;
 }
 
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 8ef259b4d037..71482d639a6d 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -364,7 +364,8 @@ static int amba_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, attr);
 	}
 
-	if (!ret && !drv->driver_managed_dma) {
+	/* @drv may not be valid when we're called from the IOMMU layer */
+	if (!ret && dev->driver && !drv->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6f2a33722c52..1813cfd0c4bd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1451,7 +1451,8 @@ static int platform_dma_configure(struct device *dev)
 		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
 		ret = acpi_dma_configure(dev, attr);
 	}
-	if (ret || drv->driver_managed_dma)
+	/* @drv may not be valid when we're called from the IOMMU layer */
+	if (ret || !dev->driver || drv->driver_managed_dma)
 		return ret;
 
 	ret = iommu_device_use_default_domain(dev);
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index d1f3d327ddd1..a8be8cf246fb 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -153,7 +153,8 @@ static int fsl_mc_dma_configure(struct device *dev)
 	else
 		ret = acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
 
-	if (!ret && !mc_drv->driver_managed_dma) {
+	/* @mc_drv may not be valid when we're called from the IOMMU layer */
+	if (!ret && dev->driver && !mc_drv->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index c573ed2ee71a..780fb0c4adba 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -360,7 +360,8 @@ static int cdx_dma_configure(struct device *dev)
 		return ret;
 	}
 
-	if (!ret && !cdx_drv->driver_managed_dma) {
+	/* @cdx_drv may not be valid when we're called from the IOMMU layer */
+	if (!ret && dev->driver && !cdx_drv->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a3b45b84f42b..1cec7074367a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 	/*
-	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
-	 * instances with non-NULL fwnodes, and client devices should have been
-	 * identified with a fwspec by this point. Otherwise, we can currently
+	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
+	 * is buried in the bus dma_configure path. Properly unpicking that is
+	 * still a big job, so for now just invoke the whole thing. The device
+	 * already having a driver bound means dma_configure has already run and
+	 * either found no IOMMU to wait for, or we're in its replay call right
+	 * now, so either way there's no point calling it again.
+	 */
+	if (!dev->driver && dev->bus->dma_configure) {
+		mutex_unlock(&iommu_probe_device_lock);
+		dev->bus->dma_configure(dev);
+		mutex_lock(&iommu_probe_device_lock);
+	}
+	/*
+	 * At this point, relevant devices either now have a fwspec which will
+	 * match ops registered with a non-NULL fwnode, or we can reasonably
 	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
 	 * be present, and that any of their registered instances has suitable
 	 * ops for probing, and thus cheekily co-opt the same mechanism.
@@ -426,6 +438,12 @@ static int iommu_init_device(struct device *dev)
 		ret = -ENODEV;
 		goto err_free;
 	}
+	/*
+	 * And if we do now see any replay calls, they would indicate someone
+	 * misusing the dma_configure path outside bus code.
+	 */
+	if (dev->driver)
+		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e10a68b5ffde..6b989a62def2 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		dev_iommu_free(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
-	if (!err && dev->bus)
+	/*
+	 * If we're not on the iommu_probe_device() path (as indicated by the
+	 * initial dev->iommu) then try to simulate it. This should no longer
+	 * happen unless of_dma_configure() is being misused outside bus code.
+	 */
+	if (!err && dev->bus && !dev_iommu_present)
 		err = iommu_probe_device(dev);
 
 	if (err && err != -EPROBE_DEFER)
diff --git a/drivers/of/device.c b/drivers/of/device.c
index edf3be197265..5053e5d532cc 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -99,6 +99,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	bool coherent, set_map = false;
 	int ret;
 
+	if (dev->dma_range_map) {
+		dev_dbg(dev, "dma_range_map already set\n");
+		goto skip_map;
+	}
+
 	if (np == dev->of_node)
 		bus_np = __of_get_dma_parent(np);
 	else
@@ -119,7 +124,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		end = dma_range_map_max(map);
 		set_map = true;
 	}
-
+skip_map:
 	/*
 	 * If @dev is expected to be DMA-capable then the bus code that created
 	 * it should have initialised its dma_mask pointer by this point. For
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f57ea36d125d..4468b7327cab 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1653,7 +1653,8 @@ static int pci_dma_configure(struct device *dev)
 
 	pci_put_host_bridge_device(bridge);
 
-	if (!ret && !driver->driver_managed_dma) {
+	/* @driver may not be valid when we're called from the IOMMU layer */
+	if (!ret && dev->driver && !driver->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
-- 
2.39.2.101.g768bb238c484.dirty


