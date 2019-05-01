Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7910C15
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfEARhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 13:37:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42139 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEARhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 13:37:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so15478442eda.9
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3xPTSPJw6iXFSiPTAFBwEzjmdm3DJtxn26MyBE7/ci4=;
        b=CVI1N4BlG8HwXPhLobOU6JAKTbRtMIUjDK6ECuX9wHHKeV08OuvfPs7JCW/zhln6zx
         VeRfsSMzyuQzlAQP4XUJGGYxkwegvObFdmcJ7eXh2y4mdwktDgaPQY4+scz4a/eqMGMg
         IvcHOuRD+rxgwsloHSZJoKCD2uIgDL4cTg7Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xPTSPJw6iXFSiPTAFBwEzjmdm3DJtxn26MyBE7/ci4=;
        b=ujqkbNRlWSNUwnDMt+RdZ9nnchI2kbQKONGF0clw3X2/orshdK1A3uCY318tu5jHwF
         r0e1uI/H2Nuk9mmg2qCbBNIVrYjBdpwILkFvhqTtfL4e4MEoMIyTNjFKf2NYLhg43isP
         WIdDqI6Az/95K+IdNEif5rus7MsW7MPxKO4mpdLVbiN1XC56b5vPfjCwrxQptR8cb7YF
         Di7x4CuOWz3c9ekilxk1gkf8DQecgTYsLFkFOP12DVCFT68t9l3aToFNGpIXUV9atfgt
         VP2ZDFyDyRrtAWs+23xipovOJgw1tN67N8aOVIMLPzZO2VsYZSJ3fryou8BAqHV2XkMa
         kKeg==
X-Gm-Message-State: APjAAAXMy94Ge5iDbSbZRBWYpV3tngbAwd5MBtXy1/B3YMb3vEdZdSp8
        xniti5WHpQU5UD9cqdyvcrQbgw==
X-Google-Smtp-Source: APXvYqxMHzoyOGYf0drHmb/y6wXO6syp/FMQbIZyj+iJbtVBJ6FIp7okadJfXPNtGbt+KmI0BUYQqA==
X-Received: by 2002:a17:906:49c4:: with SMTP id w4mr34032869ejv.0.1556732230217;
        Wed, 01 May 2019 10:37:10 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s6sm2462671eji.13.2019.05.01.10.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:37:09 -0700 (PDT)
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
Subject: [PATCH v5 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
Date:   Wed,  1 May 2019 23:06:25 +0530
Message-Id: <1556732186-21630-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dma_ranges field of PCI host bridge structure has resource entries in
sorted order of address range given through dma-ranges DT property. This
list is the accessible DMA address range. So that this resource list will
be processed and reserve IOVA address to the inaccessible address holes in
the list.

This method is similar to PCI IO resources address ranges reserving in
IOMMU for each EP connected to host bridge.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe6..da94844 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -212,6 +212,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
@@ -221,6 +222,24 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_ranges) {
+		end = window->res->start - window->offset;
+resv_iova:
+		if (end - start) {
+			lo = iova_pfn(iovad, start);
+			hi = iova_pfn(iovad, end);
+			reserve_iova(iovad, lo, hi);
+		}
+		start = window->res->end - window->offset + 1;
+		/* If window is last entry */
+		if (window->node.next == &bridge->dma_ranges &&
+		    end != ~(dma_addr_t)0) {
+			end = ~(dma_addr_t)0;
+			goto resv_iova;
+		}
+	}
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
-- 
2.7.4

