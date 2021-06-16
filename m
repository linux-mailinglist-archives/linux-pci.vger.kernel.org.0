Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29D83A9221
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFPGZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 02:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhFPGZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 02:25:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22316C06175F
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 23:23:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a127so1321571pfa.10
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 23:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GymVnULBeJ03m5EPo7c7VEX7DSqoBwMT6L2fMWoeeEc=;
        b=U3eun+ENVyocWxLJj29G6RCpfONi9/U6hPEIyZyKw371lsv5ZvHOuZIFA51JbRET1+
         Op95gA7j695YxlxlvZL3RhiG4sat3KCnGzJWEyj6V60Tnw5upJgOTBhRDMBdHFtlUqmv
         mWPc8X3tmbnhBe3Nq+XG0xr87l9VopnL/TOas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GymVnULBeJ03m5EPo7c7VEX7DSqoBwMT6L2fMWoeeEc=;
        b=tdwCYtZDFx9XUiW28EY8BJOAuGy3zpkspWLrWcaEFsyaX3qbJTli5ln2d8K/MRy3As
         racW1dPOKDLPeg9AkTvH0svhc4j7pEGtDP+5mFQTGu+b0sUJo+Dqs9EXSgYgYl8c5juB
         yZJrYD+YLp8KJisWLYNCdG9OujmpFAe8U1RDa0M/wB95bK647p8PiukqThK1rDaKMia2
         pdz2RxPiUTjKvnIpgSKMBp1xG1SI6hTZU0juOtz1YeVwQrr9cX9Mjvmh1t881xZD56DB
         IliAnkh8STYr0fpHtJ/+Y+5LurxS27AuX+SGaj1zEIZg3+SLOp1uuRGgLdQmPtDvtNvp
         Mt6A==
X-Gm-Message-State: AOAM532YyOvvZcz3N/TBUVXjATz3LWMPtzuo58Y9cJCX/mSyQLDcMmyx
        hfA3nilUt3qfwuCzRGlLgeuxEg==
X-Google-Smtp-Source: ABdhPJzos0AE316eqwE5bukVSiSBXorK5IVepm+pS66FYVRIq/CQ/YuE4vEFUrrRi3iREp0s0X/Ddw==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr3484297pgc.45.1623824623702;
        Tue, 15 Jun 2021 23:23:43 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3d52:f252:7393:1992])
        by smtp.gmail.com with UTF8SMTPSA id s37sm1040984pfg.90.2021.06.15.23.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 23:23:43 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v12 11/12] dt-bindings: of: Add restricted DMA pool
Date:   Wed, 16 Jun 2021 14:21:56 +0800
Message-Id: <20210616062157.953777-12-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616062157.953777-1-tientzu@chromium.org>
References: <20210616062157.953777-1-tientzu@chromium.org>
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
 .../reserved-memory/reserved-memory.txt       | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index e8d3096d922c..46804f24df05 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -51,6 +51,23 @@ compatible (optional) - standard definition
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
+          the memory access, e.g., MPU. Note that since coherent allocation
+          needs remapping, one must set up another device coherent pool by
+          shared-dma-pool and use dma_alloc_from_dev_coherent instead for atomic
+          coherent allocation.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
     - Indicates the operating system must not create a virtual mapping
@@ -85,10 +102,11 @@ memory-region-names (optional) - a list of names, one for each corresponding
 
 Example
 -------
-This example defines 3 contiguous regions are defined for Linux kernel:
+This example defines 4 contiguous regions for Linux kernel:
 one default of all device drivers (named linux,cma@72000000 and 64MiB in size),
-one dedicated to the framebuffer device (named framebuffer@78000000, 8MiB), and
-one for multimedia processing (named multimedia-memory@77000000, 64MiB).
+one dedicated to the framebuffer device (named framebuffer@78000000, 8MiB),
+one for multimedia processing (named multimedia-memory@77000000, 64MiB), and
+one for restricted dma pool (named restricted_dma_reserved@0x50000000, 64MiB).
 
 / {
 	#address-cells = <1>;
@@ -120,6 +138,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 			compatible = "acme,multimedia-memory";
 			reg = <0x77000000 0x4000000>;
 		};
+
+		restricted_dma_reserved: restricted_dma_reserved {
+			compatible = "restricted-dma-pool";
+			reg = <0x50000000 0x4000000>;
+		};
 	};
 
 	/* ... */
@@ -138,4 +161,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 		memory-region = <&multimedia_reserved>;
 		/* ... */
 	};
+
+	pcie_device: pcie_device@0,0 {
+		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
+		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
+		memory-region = <&restricted_dma_mem_reserved>;
+		/* ... */
+	};
 };
-- 
2.32.0.272.g935e593368-goog

