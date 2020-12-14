Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322CD2D9851
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 13:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438295AbgLNMw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 07:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgLNMwn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 07:52:43 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA33C0613CF
        for <linux-pci@vger.kernel.org>; Mon, 14 Dec 2020 04:52:02 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so15139841wmf.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Dec 2020 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uA7Oxs/wyvYUE1Q5Z79HLkOoFQjgdYG73UpryFEtyeo=;
        b=A7JTYmymCT84foHfhEmNIHr/pEfSygaw0il7x05bSBXymRtmnEeQ9s8NImWZYvG1bR
         IJ7xCY9OfQNEa/YTNBx2CJk7Ipe6KY895wWjACUQcgcAwrrpE4Jqm8k7W/CzO6YM4aR/
         dscM1fFxsl/sItEgQ3EkazFzVcCs2S7RTUHBTYW31rZbDmyyz0X1ZLZMoXi3UKDQySQH
         gyixWe2v4wPss1+mh04uaNzSADC1nZCcohSWb/6SDx4QQlplS7Ew13lBe+/dE6xkGvdS
         aiKO2/ys+HAjPf1PsTGTiBKRnGpAosT6yCiq3CWjYQaTagjjvEcyO/TG5vcVPGXf3plk
         kSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uA7Oxs/wyvYUE1Q5Z79HLkOoFQjgdYG73UpryFEtyeo=;
        b=uCuTqfpnnNxrg2f58NDOzsitLmY5iSuqJXSHM4Yr/f9nDnBLtJsjLoHvSGXU8pXsuW
         kETAWotqxck0oFtEmM2Emx6eRVvMrNbfRWAK9jNk+LZZoziXWQ7BRQSvh0Xc6Q5dJzJg
         n+7JTZaifQ4uXZe4scN7vDYNVzPOJlwDEyyazVUFvlOEu+N74sAXxGPf+los9HEaeEcV
         AtjtY5XYIvGXnH5JGgkGuBX3Ck3qXlwZkRq6UToA36Lp/6RCWLKoFHYc/HJ55Y11VhMs
         tCCGIa6z56DAvOJYuUydk9PjKeYThLWwLDR5ZO8Gs8PbJLDCKp8fWvdFhTXqJmBdgNzm
         Mw7Q==
X-Gm-Message-State: AOAM532NKdNIrMrFLBH5o5tqERuDVZ7Bvvf2uxr5LomjRe/Y7yW9Nab1
        lWj8eGKU+zdgQXqaK95K9/kS2A==
X-Google-Smtp-Source: ABdhPJy7ckFB91jTR/PoEmgcekJEn+mvUgXVeEpBAXlu4Plmu8X+fq263Z3FizP3RlKSLXwiHojtUg==
X-Received: by 2002:a1c:b7d4:: with SMTP id h203mr27925588wmf.59.1607950321431;
        Mon, 14 Dec 2020 04:52:01 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j15sm31263649wrr.85.2020.12.14.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 04:52:00 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:51:41 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com
Subject: Re: [PATCH v8 4/9] of/iommu: Support dma-can-stall property
Message-ID: <X9dS9H9PrOZbND9E@myrica>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
 <20201112125519.3987595-5-jean-philippe@linaro.org>
 <d0a61d79-82fc-3af8-570e-e2ae3d485455@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a61d79-82fc-3af8-570e-e2ae3d485455@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 26, 2020 at 06:09:26PM +0000, Robin Murphy wrote:
> On 2020-11-12 12:55, Jean-Philippe Brucker wrote:
> > Copy the dma-can-stall property into the fwspec structure.
> 
> Can't we just handle this as a regular device property? It's not part of the
> actual IOMMU specifier, it doesn't need to be translated in any way, and
> AFAICS it's used a grand total of once, in a slow path. Simply treating it
> as the per-device property that it is should require zero additional code
> for DT, and a simple device_add_properties() call for IORT.
> 
> TBH that appears to be true of pasid-num-bits as well.

Right I think that's better, thanks for the pointer. I'll take care of
pasid-num-bits too. The Huawei quirk (fake PCIe supporting stall) is a
little worse this way, but it should work.

Thanks,
Jean

---
Diff untested on ACPI:

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e7b40e569488..ad5c55bc45b2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -591,8 +591,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
 struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
-	u32			num_pasid_bits;
-	bool			can_stall;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index aa76e775bd6d..1582f6585741 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -960,16 +960,19 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 static void iort_named_component_init(struct device *dev,
 				      struct acpi_iort_node *node)
 {
+	struct property_entry props[3] = {};
 	struct acpi_iort_named_component *nc;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!fwspec)
-		return;

 	nc = (struct acpi_iort_named_component *)node->node_data;
-	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
-					   nc->node_flags);
-	fwspec->can_stall = (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED);
+
+	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
+				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+						nc->node_flags));
+	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
+		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
+
+	if (device_add_properties(dev, props))
+		dev_warn(dev, "Could not register device properties\n");
 }

 static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 521ec7f0b2a0..571bd7c35a62 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2842,7 +2842,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (ret)
 		goto err_free_master;

-	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);

 	/*
 	 * Note that PASID must be enabled before, and disabled after ATS:
@@ -2858,7 +2859,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);

-	if ((smmu->features & ARM_SMMU_FEAT_STALLS && fwspec->can_stall) ||
+	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
+	     device_property_read_bool(dev, "dma-can-stall")) ||
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index d6255ca823d8..a9d2df001149 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -210,14 +210,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					     of_pci_iommu_init, &info);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
-
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec) {
-			of_property_read_u32(master_np, "pasid-num-bits",
-					     &fwspec->num_pasid_bits);
-			fwspec->can_stall = of_property_read_bool(master_np,
-								  "dma-can-stall");
-		}
 	}

 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 324dbe55836c..13a43a3d6347 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1828,12 +1828,17 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI

 static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 {
-	struct iommu_fwspec *fwspec;
+	struct property_entry properties[] = {
+		PROPERTY_ENTRY_BOOL("dma-can-stall"),
+		{},
+	};

 	pdev->eetlp_prefix_path = 1;
-	fwspec = dev_iommu_fwspec_get(&pdev->dev);
-	if (fwspec)
-		fwspec->can_stall = 1;
+
+	/* Device-tree can set the stall property */
+	if (!pdev->dev.of_node &&
+	    device_add_properties(&pdev->dev, properties))
+		pci_warn(pdev, "could not add stall property");
 }

 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);


