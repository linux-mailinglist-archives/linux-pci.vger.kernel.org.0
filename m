Return-Path: <linux-pci+bounces-43945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4797CEEE18
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 16:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E933011762
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8936326E710;
	Fri,  2 Jan 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6qnuSRk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF51EDA2C;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368105; cv=none; b=p8i29vxLIpwTiWVZ8euU5p9EYtSWgsaak+mVsk4Kj4Dam2vIwI1Z9nABBaRPAPETrDvs1DAXHxg70NiwXgvBVr9ePCGnIpfRM8ps2WACta6Qq7k8++xjiXaNADdoDwnw0tj8UplasERINeZK5haQPWuT2/NvS6PQIRfAT0fvhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368105; c=relaxed/simple;
	bh=1TILJpA94tm+NjdIdR07UOJcYaE5858nIVxioO1NGMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sjd3FzSj10hduITREmtpR0acgm8cQ5Iv7ugDLSJ37xmtoJYmgPwJxa+kD0wGs9vANwgmckEyJjRml5WWyMyimM0/EmGei7CBhjtqtudXQJS3yjob5sjqgwoW3C/kVL6e6AHN1Tm9XiAotHsRCEdDBplL59Pl5gw/cYJJ6ICKH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6qnuSRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 721B9C116D0;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767368104;
	bh=1TILJpA94tm+NjdIdR07UOJcYaE5858nIVxioO1NGMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N6qnuSRkrvEWVnBqyYtCTYC9Lol5VkOc29JzXXnqjJBfu35/hYItKoLx970sCqftc
	 d0WKm9j+dcGywT+8dercKKJRbJfgey2qqF3fTMYv19uVQLukB3xTgQ0YVS0ToIMFos
	 N42/Be6Jrp86UsVBswkXnsicQF8xjjR1utHMn9bs+7DYttQ3R/+OsZc2Yn6zf+aSsT
	 RybdDAOhboySkxTRCzXM7AbM+KBOWulR4m9+Wmma5DQw0oJhYM5G1VwutqW228akUU
	 inHDRCEm+GK4vYDMftmx00uD6OdQwVsa4TT2jumMq5DXO31phrPZQWjpw2FYiqAvqw
	 6zRNc6dLtNAJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A7FA3752;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 02 Jan 2026 21:04:47 +0530
Subject: [PATCH v3 1/4] PCI: Enable ACS only after configuring IOMMU for OF
 platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
In-Reply-To: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
 Xingang Wang <wangxingang5@huawei.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3997;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=5UbTaCqlSfsZh3mFkk650olnLwfrJC/TA0PViCutZMg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpV+Wm1DB6YPxGpFaNimOGigjiqMZEILNVe2hId
 3WdA7gPUuuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVflpgAKCRBVnxHm/pHO
 9QyWCACWSH1UrGgxuShZFc3H/mSHakZIiuUJWYNWLHowr0+LG8fEbpljGe1qbrPwdfHJmvIq7Nr
 4dhgOIWLCncoAc8uEbHVP7XhFQCoYrdIF5fQQR4mgAFUgPSBzY2LF6Fzt3YRNvMJQqWb7QIpknh
 1qbq7JPK+S4tG4ggD28ap67z4rmqU/11MNPQ65qzR9toO1KCeLPc12WFBG0AbLI5uWgNqTuyYgy
 2xgi/XqW+/8jf3NpQKwpJCAxA5u01SMJtFvLSZ1UgAFiU9sIaW7MGLDjSfAuWKa0kXGbYLwrhjo
 0VNbn2LxYQvyN2+kZMgz3K7NOdcE9F+KX/1jtC1PZvtHFirE
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

For enabling ACS without the cmdline params, the platform drivers are
expected to call pci_request_acs() API which sets a static flag,
'pci_acs_enable' in drivers/pci/pci.c. And this flag is used to enable ACS
in pci_enable_acs() helper, which gets called during pci_acs_init(), as per
this call stack:

-> pci_device_add()
	-> pci_init_capabilities()
		-> pci_acs_init()
			/* check for pci_acs_enable */
			-> pci_enable_acs()

For the OF platforms, pci_request_acs() is called during
of_iommu_configure() during device_add(), as per this call stack:

-> device_add()
	-> iommu_bus_notifier()
		-> iommu_probe_device()
			-> pci_dma_configure()
				-> of_dma_configure()
					-> of_iommu_configure()
						/* set pci_acs_enable */
						-> pci_request_acs()

As seen from both call stacks, pci_enable_acs() is called way before the
invocation of pci_request_acs() for the OF platforms. This means,
pci_enable_acs() will not enable ACS for the first device that gets
enumerated, which is usally the Root Port device. But since the static
flag, 'pci_acs_enable' is set *afterwards*, ACS will be enabled for the
ACS capable devices enumerated later.

To fix this issue, do not call pci_enable_acs() from pci_acs_init(), but
only from pci_dma_configure() after calling of_dma_configure(). This makes
sure that pci_enable_acs() only gets called after the IOMMU framework has
called pci_request_acs(). The ACS enablement flow now looks like:

-> pci_device_add()
	-> pci_init_capabilities()
		/* Just store the ACS cap */
		-> pci_acs_init()
	-> device_add()
		...
		-> pci_dma_configure()
			-> of_dma_configure()
				-> pci_request_acs()
			-> pci_enable_acs()

For the ACPI platforms, pci_request_acs() is called during ACPI
initialization time itself, independent of the IOMMU framework.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci-driver.c | 8 ++++++++
 drivers/pci/pci.c        | 8 --------
 drivers/pci/pci.h        | 1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7c2d9d596258..301a9418e38e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1650,6 +1650,14 @@ static int pci_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(to_pci_dev(dev));
+
 	pci_put_host_bridge_device(bridge);
 
 	/* @drv may not be valid when we're called from the IOMMU layer */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..2c3d0a2d6973 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3648,14 +3648,6 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa001..4592ede0ebcc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -939,6 +939,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
+void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);

-- 
2.48.1



