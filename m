Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537B7106F8E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfKVLQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:16:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41531 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfKVKvE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:51:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so8024071wrj.8
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8FVNRvH5irJ2zDaBsxloUo7UX0pFrVUzjUZiLfKvwU=;
        b=KE4FZyVJ7oTMaqEmjpbPlG5DZcuerskPQmr4Oz+oBjjiJHvGL6H8exZ0GXrlPmDu4L
         fjock0LX/ANKXLc2tQLf8axKFLTKAmNc1cOarXAmF0mUTryD4ji2KpaeIUDw6KdwzCw2
         MxmVyNC6Z760rlRWN+O0jtt5nJoCB5GWkiGoJq9XOXrGI1Q2/py21NNS6EZZJTYshlH1
         dixx5JojDpj/FfGb3I7ZZgOUrdLQ8kn2WEIgbTcnNR0ah1Bdppb6CTCz4NURwPA8aLfS
         EJmBtSrx3Y1mMzNCGoqbw/42Xt3due4SSZ7dusRabMT5A8dSeghZrBgyRs8JtWKzrXen
         CdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8FVNRvH5irJ2zDaBsxloUo7UX0pFrVUzjUZiLfKvwU=;
        b=ZZYkCv0OdiFXX1vwv/TFS1mL5Wmy3LgbRl6mbApIris+LrM5rHQ9LHO8FeZD1YQGv4
         Y5r2stuo3LKS7tcC9O+Gtg46jJWCBaNoPB+vbN3cETHNYQsfXUnHlu9OOqBv/CepNO64
         lvOAAEX/IsSlWnAXXs4sJ2I/Xna13X3ohXnCOrK5e1Lm9FlcUHpQICSUhXFrKs0Dvxrk
         X74LEXUIQUCWplvnaJ9Ir8ZYRRlGK219sapAKXs1wPs0OM4nFmyIweHoSzPYDxKp2OX9
         c9ZKQNgNGZYHAFw6v/yMyeaT2mLn6ozafSnmRqAXadxN1MGcgpzELscHBGO5aKoERMsA
         +tYw==
X-Gm-Message-State: APjAAAUAmNSTymbhNUARIGNcS3+D0xSevi8lIGcCPZdaCcp313CT8uIF
        rEiPoLO3ZFvUiTa5pwyekhDogyL/6cA=
X-Google-Smtp-Source: APXvYqxupzAk9/+hAGuqo2zCmryiXsqWB8zdfYtdzuCH8fYncJHID5ipVvqg0xilqWNq9KeWUZb/LQ==
X-Received: by 2002:adf:de0a:: with SMTP id b10mr17179236wrm.268.1574419862914;
        Fri, 22 Nov 2019 02:51:02 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:51:02 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 09/13] iommu/virtio: Create fwnode if necessary
Date:   Fri, 22 Nov 2019 11:49:56 +0100
Message-Id: <20191122105000.800410-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The presence of a fwnode on a PCI device depends on the platform. QEMU
q35, for example, creates an ACPI description for each PCI slot, but
QEMU virt (aarch64) doesn't. Since the IOMMU subsystem relies heavily on
fwnode to discover the DMA topology, create a fwnode for the
virtio-iommu if necessary, using the software_node framework.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 56 ++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d7682999..8efa368134c0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -966,6 +966,48 @@ static struct iommu_ops viommu_ops = {
 	.of_xlate		= viommu_of_xlate,
 };
 
+static int viommu_set_fwnode(struct viommu_dev *viommu)
+{
+	/*
+	 * viommu->dev is the virtio device, its parent is the associated
+	 * transport device.
+	 */
+	struct device *dev = viommu->dev->parent;
+
+	/*
+	 * With device tree a fwnode is always present. With ACPI, on some
+	 * platforms a PCI device has a DSDT node describing the slot. On other
+	 * platforms, no fwnode is created and we have to do it ourselves.
+	 */
+	if (!dev->fwnode) {
+		struct fwnode_handle *fwnode;
+
+		fwnode = fwnode_create_software_node(NULL, NULL);
+		if (IS_ERR(fwnode))
+			return PTR_ERR(fwnode);
+
+		set_primary_fwnode(dev, fwnode);
+	}
+
+	iommu_device_set_fwnode(&viommu->iommu, dev->fwnode);
+	return 0;
+}
+
+static void viommu_clear_fwnode(struct viommu_dev *viommu)
+{
+	struct device *dev = viommu->dev->parent;
+
+	if (!dev->fwnode)
+		return;
+
+	if (is_software_node(dev->fwnode)) {
+		struct fwnode_handle *fwnode = dev->fwnode;
+
+		set_primary_fwnode(dev, NULL);
+		fwnode_remove_software_node(fwnode);
+	}
+}
+
 static int viommu_init_vqs(struct viommu_dev *viommu)
 {
 	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
@@ -1004,7 +1046,6 @@ static int viommu_fill_evtq(struct viommu_dev *viommu)
 
 static int viommu_probe(struct virtio_device *vdev)
 {
-	struct device *parent_dev = vdev->dev.parent;
 	struct viommu_dev *viommu = NULL;
 	struct device *dev = &vdev->dev;
 	u64 input_start = 0;
@@ -1084,9 +1125,11 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
-	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
+	ret = viommu_set_fwnode(viommu);
+	if (ret)
+		goto err_sysfs_remove;
 
+	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 	iommu_device_register(&viommu->iommu);
 
 #ifdef CONFIG_PCI
@@ -1119,8 +1162,10 @@ static int viommu_probe(struct virtio_device *vdev)
 	return 0;
 
 err_unregister:
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+	viommu_clear_fwnode(viommu);
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
@@ -1131,8 +1176,9 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
 
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+	viommu_clear_fwnode(viommu);
+	iommu_device_sysfs_remove(&viommu->iommu);
 
 	/* Stop all virtqueues */
 	vdev->config->reset(vdev);
-- 
2.24.0

