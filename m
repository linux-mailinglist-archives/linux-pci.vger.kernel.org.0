Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B137D24D5FC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgHUNQ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgHUNQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 09:16:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF26C061388
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ba10so1392042edb.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFxcuowFu0Jv3evIc1dad6n3ZhAX6nITskxpnaVl5+I=;
        b=F7qrOUgTT3E74XyC9jWEuKSCWozpJkqtVAUNfrVyQYb7KuFQaRifAbrV29U+QTgdO7
         svaPN2mULjuJmM9GzglZwFzOSgvsCjum3Skmnma0ZxZOa0TjXvzHG00pItNlS0o+yHHb
         DHKfdTgv1Vsra0RFLIHnHM3PWZPg1i4t79wJcD/ye7C4kl6emXJwM47EZ2fqK9NjHU8Z
         7l+LTNCupWNFida4Mq7tKvQSx5gdmvST6bW+kSiDnNAhy1j/RRW6vu0KYRZKH8ouJXsm
         8/+XKVKeZNzd+4C8Jbsu4oNNebPMyjg8aTlotZFno4GFpdtboKUIpaIYzxudSgt9xQLD
         ZQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFxcuowFu0Jv3evIc1dad6n3ZhAX6nITskxpnaVl5+I=;
        b=tWCT16PqVtCn2wM0aHhMbb0EIckJTY1+4/RYk+RsnhhD2aN+8Rk1DLrs2sSGHpkzdB
         naGXbSFQXWzwWLL5eUL1yTaTmTVekhNhOHxKADiXbfWGwaZVr+MI0n0ea6s1zV4/rEJW
         oHCdCVgsIKPrwMEBUcPsIBHNYnAb1S3VrJnwXJb1QmlgnFIu2qT+uL41OqEqFJQ5BZ0I
         22pfeurS/r6mE8zlnTl4p30LWyfbBIc6YG47NfxRFNP9w+z8xcr7hNgFf4fJbNE3+eCI
         +YH2Ee3jxpJsBA0unSTkXhYEosa1VOZRKy/BEH2vEBIIGl7AYjdRutjsHRqltK3VilaC
         4Bew==
X-Gm-Message-State: AOAM531SB7gW4YEFEPllC5WJsiNJqqyug6yUBYJ7Gx5xDFnrT0ckcd5k
        u3bgkuvC3hXMue0VcwN1yCu9gw==
X-Google-Smtp-Source: ABdhPJxSuluZjkQxfsXp9THILY+NXbkzKwWS5DVjT4ygD1u7SdXIMGmAG5nqsAUF8rJME9RMD8pSxg==
X-Received: by 2002:a50:a2e6:: with SMTP id 93mr2650226edm.147.1598015771724;
        Fri, 21 Aug 2020 06:16:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:16:11 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 4/6] iommu/virtio: Add topology definitions
Date:   Fri, 21 Aug 2020 15:15:38 +0200
Message-Id: <20200821131540.2801801-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add struct definitions for describing endpoints managed by the
virtio-iommu. When VIRTIO_IOMMU_F_TOPOLOGY is offered, an array of
virtio_iommu_topo_* structures in config space describes the endpoints,
identified either by their PCI BDF or their physical MMIO address.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..70cba30644d5 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_TOPOLOGY			6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -27,6 +28,17 @@ struct virtio_iommu_range_32 {
 	__le32					end;
 };
 
+struct virtio_iommu_topo_config {
+	/* Number of topology description structures */
+	__le16					count;
+	/*
+	 * Offset to the first topology description structure
+	 * (virtio_iommu_topo_*) from the start of the virtio_iommu config
+	 * space. Aligned on 8 bytes.
+	 */
+	__le16					offset;
+};
+
 struct virtio_iommu_config {
 	/* Supported page sizes */
 	__le64					page_size_mask;
@@ -36,6 +48,38 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	struct virtio_iommu_topo_config		topo_config;
+};
+
+#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
+#define VIRTIO_IOMMU_TOPO_MMIO			0x2
+
+struct virtio_iommu_topo_pci_range {
+	/* VIRTIO_IOMMU_TOPO_PCI_RANGE */
+	__u8					type;
+	__u8					reserved;
+	/* Length of this structure */
+	__le16					length;
+	/* First endpoint ID in the range */
+	__le32					endpoint_start;
+	/* PCI domain number */
+	__le16					segment;
+	/* PCI Bus:Device.Function range */
+	__le16					bdf_start;
+	__le16					bdf_end;
+	__le16					padding;
+};
+
+struct virtio_iommu_topo_mmio {
+	/* VIRTIO_IOMMU_TOPO_MMIO */
+	__u8					type;
+	__u8					reserved;
+	/* Length of this structure */
+	__le16					length;
+	/* Endpoint ID */
+	__le32					endpoint;
+	/* Address of the first MMIO region */
+	__le64					address;
 };
 
 /* Request types */
-- 
2.28.0

