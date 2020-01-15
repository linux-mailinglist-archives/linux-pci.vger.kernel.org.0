Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776C613C1CA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgAOMxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgAOMxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so15629157wrw.8
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4JsCWxXHC8YjpStG5e1vl4meeR6Q/c6EwcKRZXnP4g=;
        b=aXJPmp/sKIZ5yC9KBcjnGQmv1XjAweQHEtcUgTg2t1f4RaKASZpxE0QgHtFcPpXhtr
         zuRxyd6cxN1TQxoh4rbqDR7WBcRd4tEgKHx8rO2EA4sizmz9+u3Jj9j0scxlL4EJk++O
         cTJCK10bVQ46L1ggzNaZc0nCeNdENkaupJUJ/N3yZrK+35GOcSbGhtTs+PbglqRBlwFn
         GehwR0sBGV4BJqBQF75lMXIgDMtRlFjtv0+5Um4sxb6fiupoh60wvhmDsM2kHUjL8Ltd
         DOh6y87UY2NRSaT4pkknohlksIkCfsd4uhpTxZtTfBZrs1PZcGZGXmkGLcie4afvrR7G
         8KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4JsCWxXHC8YjpStG5e1vl4meeR6Q/c6EwcKRZXnP4g=;
        b=p8FWYOu+3UVJLc4zQ7sM8QJf6rkGcCKWvr9A0z5d8XfykXnCfHBTVrhOJXQIVqiYI2
         RbufNoaAtJvLtOq7nxu0dbSwVCBHm5FV+e5le5ppO8uscEzP1do8MezrV7dvyVNdtjy0
         GhcJnahU2dMgPd21sp/cOxUdtWnOl7pjIS7fcKIDkJJsuiaH+/Mc9gU6p/yOceAcuVyw
         sjUzHnlptO4qtKeChRkVXssyvniB8r2V0veIOSq7cIAz/B0NhCdP56D9Kc1SSkVlB71Z
         rw0U/D2xCqwMpAhj99rDn+x6Tvq+dVBliA6VfuEIUZPrBxcUh+BMVKqEcycnzIY/s0tP
         ampA==
X-Gm-Message-State: APjAAAUUqEfGUTEpcKnPJCTS/avnh9ugbBBMIVVCAH+jG5dBM76oR1km
        9F4CX97vGqHEaS5g9+IsBlQK8aiNOPY=
X-Google-Smtp-Source: APXvYqwyWdcuVyXOArs9ruSvzlL64ZWCgE+mSWyIpxT1nfnA2LYFgbtI4Sv85S0HrzG+WGrNdd51xA==
X-Received: by 2002:a5d:6206:: with SMTP id y6mr30259146wru.130.1579092810915;
        Wed, 15 Jan 2020 04:53:30 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:30 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 03/13] iommu/arm-smmu-v3: Parse PASID devicetree property of platform devices
Date:   Wed, 15 Jan 2020 13:52:29 +0100
Message-Id: <20200115125239.136759-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For platform devices that support SubstreamID (SSID), firmware provides
the number of supported SSID bits. Restrict it to what the SMMU supports
and cache it into master->ssid_bits, which will also be used for PCI
PASID.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 13 +++++++++++++
 drivers/iommu/of_iommu.c    |  6 +++++-
 include/linux/iommu.h       |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d4e8b7f8d9f4..837b4283b4dc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -292,6 +292,12 @@
 
 #define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
 
+/*
+ * When the SMMU only supports linear context descriptor tables, pick a
+ * reasonable size limit (64kB).
+ */
+#define CTXDESC_LINEAR_CDMAX		ilog2(SZ_64K / (CTXDESC_CD_DWORDS << 3))
+
 /* Convert between AArch64 (CPU) TCR format and SMMU CD format */
 #define ARM_SMMU_TCR2CD(tcr, fld)	FIELD_PREP(CTXDESC_CD_0_TCR_##fld, \
 					FIELD_GET(ARM64_TCR_##fld, tcr))
@@ -638,6 +644,7 @@ struct arm_smmu_master {
 	u32				*sids;
 	unsigned int			num_sids;
 	bool				ats_enabled;
+	unsigned int			ssid_bits;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -2571,6 +2578,12 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
+		master->ssid_bits = min_t(u8, master->ssid_bits,
+					  CTXDESC_LINEAR_CDMAX);
+
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
 		iommu_group_put(group);
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 026ad2b29dcd..b3ccb2f7f1c7 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -196,8 +196,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			if (err)
 				break;
 		}
-	}
 
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (!err && fwspec)
+			of_property_read_u32(master_np, "pasid-num-bits",
+					     &fwspec->num_pasid_bits);
+	}
 
 	/*
 	 * Two success conditions can be represented by non-negative err here:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f2223cbb5fd5..956031eab3ef 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -570,6 +570,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
+ * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -578,6 +579,7 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	u32			flags;
+	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
-- 
2.24.1

