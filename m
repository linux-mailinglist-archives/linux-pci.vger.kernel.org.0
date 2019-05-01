Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09510C14
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfEARhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 13:37:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37408 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARhF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 13:37:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so15504287edw.4
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFszwaQY5oH4KxJcDNAltHmQUtC7DYEBegh+wY9ZhAU=;
        b=cNeTm+C8Sqi5mAJCHuRT7Oc0+dO/63ZhzRkoYfADHFXz8zh3Pndmn65kGUCDlaz81t
         J1j2eYjGQGPsgGjy3R6Bsi/O4r3Zanvv/sQbLPmkG44qaK4qFSP4oGbz3udaTje1EMYY
         2vcMpgjUgXXa577nrS8MTreZN9ECfSQLgLE4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aFszwaQY5oH4KxJcDNAltHmQUtC7DYEBegh+wY9ZhAU=;
        b=hPq6hdIgnWmq3WrsMlKrsQDHVKmERdd/D48Eiigc2g8+sARx8Gv+DJTfkJx307PTnT
         8u41vr1uUo/7xmCE+qp8AZrVtbDtH8WpqGzYC1GKdoEjYP6bwpakm6PipCNXwCNf/tFx
         JWV9q0UEISr/B83rwucXF7/q0B2P19iZbfyozFehT9/WE86qHJ97C1WyAHLrF0tfplYl
         jrZTqMfoHHYO8gAbUBPFlg0bH/VO3iAnFxqBbYjaWzfElrJT8Jqidw1ukuCaGPAjud47
         r1P7VTyvREVKpzTz/26DCplDWFjsY+hjmdoLVSPre+YAXN9FM8B0o9rVAVcGt8of43uu
         KPSQ==
X-Gm-Message-State: APjAAAV/HTk2uW1W3h8S6kMzOtqrjKxDu6zWX841UQSrYlpv/7IUG8cr
        WiJrWTWfMmvxaf6qxDKb5pN9hw==
X-Google-Smtp-Source: APXvYqxGBQcZ/qykETC1CAlXAsxs7RgZAz0rpL8xixum/V2QqoCz8gnlSBK3/rkrc2PtiS9UiScFoQ==
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr25776880eja.121.1556732223856;
        Wed, 01 May 2019 10:37:03 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s6sm2462671eji.13.2019.05.01.10.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:37:03 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 1/3] PCI: Add dma_ranges window list
Date:   Wed,  1 May 2019 23:06:24 +0530
Message-Id: <1556732186-21630-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a dma_ranges field in PCI host bridge structure to hold resource
entries list of memory regions in sorted order given through dma-ranges
DT property.

While initializing IOMMU domain of PCI EPs connected to that host bridge,
this list of resources will be processed and IOVAs for the address holes
will be reserved.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7e12d01..72563c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -595,6 +595,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -623,6 +624,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -632,6 +634,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_ranges);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7744821..bba0a29 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -490,6 +490,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4

