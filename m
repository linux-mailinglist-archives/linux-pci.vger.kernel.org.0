Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD5367C51
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhDVISC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 04:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbhDVISC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 04:18:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C976C06138C
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 01:17:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so31155520pfn.6
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuOOsLHj/oNZjBm4RnvuivSFFV92Va82CrZ+fAg7zfY=;
        b=SU4sVnlV04xSgoofQca5QyBITV+0IvFAevjbJUPql51e/WJmwt753FvY8Mkg5m2V9K
         KltjB0Yf/owsba7VaGE5I/jyIpffrwgwzMWGj5OuANSMmX9kAJK1YudQOntlivYBBgBL
         ojHwCuXZ3zEWizTS3cOusPjXwW4Dim4zSAIxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuOOsLHj/oNZjBm4RnvuivSFFV92Va82CrZ+fAg7zfY=;
        b=smKaiJ8I+klLhRSyM04s10vnxxaWmG2SUMQyKafMYVl68JmuQe9oQHR2TRakHqsCZ/
         FzK3CwE9Bsio8iLtu4jNvjn+z1PI65jFTL40Ztv7L6rRfuPLa+VbLjCRuv08PnjaJ3H+
         rNEYQfzqHt3Gno5zr1tf2O7aBYTefQlcmuRfzhsAFefwrmLvfcSJ96nlck+ctGrh4cWh
         3CPCE4kP+D1Gvu3eJ2sk1a8CoTGtY4PHiMUVx4Wn7NKh6VyRuRDvmvDATYGMrH6W19aZ
         HLerEWwCYLf7JmR3p96JRIQok3JGnjRctQiKoZ/sx0OSP2wKCP4JZOHxdrdLzmfeJ5Ke
         5Epw==
X-Gm-Message-State: AOAM530IJfc87a2pDnYEh7XJJWIaM8Vb0gKFrEh3faYP3Xd2SbOnHVuu
        OjjX7pGkPNfwquSuw6Uup/+1OQ==
X-Google-Smtp-Source: ABdhPJwbWgS0cLJAD3Tg8wl4hIiA/h+MeZ9ZtrvoWlgRDwgrWUw8WsaWULCcDmGHjuLEWNOlKJKskA==
X-Received: by 2002:aa7:8703:0:b029:261:4680:9723 with SMTP id b3-20020aa787030000b029026146809723mr2287757pfo.70.1619079446787;
        Thu, 22 Apr 2021 01:17:26 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:1a8e:1bde:f79e:c302])
        by smtp.gmail.com with UTF8SMTPSA id i22sm1586646pgj.90.2021.04.22.01.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:17:26 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: [PATCH v5 15/16] dt-bindings: of: Add restricted DMA pool
Date:   Thu, 22 Apr 2021 16:15:07 +0800
Message-Id: <20210422081508.3942748-16-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210422081508.3942748-1-tientzu@chromium.org>
References: <20210422081508.3942748-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce the new compatible string, restricted-dma-pool, for restricted
DMA. One can specify the address and length of the restricted DMA memory
region by restricted-dma-pool in the reserved-memory node.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index e8d3096d922c..fc9a12c2f679 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -51,6 +51,20 @@ compatible (optional) - standard definition
           used as a shared pool of DMA buffers for a set of devices. It can
           be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
+        - restricted-dma-pool: This indicates a region of memory meant to be
+          used as a pool of restricted DMA buffers for a set of devices. The
+          memory region would be the only region accessible to those devices.
+          When using this, the no-map and reusable properties must not be set,
+          so the operating system can create a virtual mapping that will be used
+          for synchronization. The main purpose for restricted DMA is to
+          mitigate the lack of DMA access control on systems without an IOMMU,
+          which could result in the DMA accessing the system memory at
+          unexpected times and/or unexpected addresses, possibly leading to data
+          leakage or corruption. The feature on its own provides a basic level
+          of protection against the DMA overwriting buffer contents at
+          unexpected times. However, to protect against general data leakage and
+          system memory corruption, the system needs to provide way to lock down
+          the memory access, e.g., MPU.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
@@ -120,6 +134,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 			compatible = "acme,multimedia-memory";
 			reg = <0x77000000 0x4000000>;
 		};
+
+		restricted_dma_mem_reserved: restricted_dma_mem_reserved {
+			compatible = "restricted-dma-pool";
+			reg = <0x50000000 0x400000>;
+		};
 	};
 
 	/* ... */
@@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 		memory-region = <&multimedia_reserved>;
 		/* ... */
 	};
+
+	pcie_device: pcie_device@0,0 {
+		memory-region = <&restricted_dma_mem_reserved>;
+		/* ... */
+	};
 };
-- 
2.31.1.368.gbe11c130af-goog

