Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D355B16AEED
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBXSY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:56 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34611 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgBXSYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:55 -0500
Received: by mail-wm1-f50.google.com with SMTP id s144so466963wme.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0VWA2fvKY7B7aVEb87RbBlKKCbdscLm7wXe7hq9l+o=;
        b=jrea57vRdBhgNK56CGB6FBQaFESTfknRHc96QQ82B0wBh5E8nOIvvqoDp88g21NJms
         vCtpWf4eZMeIPhoNOEnzXNGWUU/L/DIOMIpzlQ/DLRoBlZsRMavpixederXLjWbnWC7P
         VgrsbfWlv0djfGH1aSceYJMSD+h2AEC2octSj5r/52HuAkGcmwSLGFyNX2/RJNR0SEXo
         hjZ4qCxHZra5C4YTiCc/afuFkROLgPCt3wD/HTSI54xo9RGvqdw0v21iw6isZfklwJdL
         qB7285DeYxybLPJvLl7Ham/dtFKMQ20giHlQ9T+3SZtHeP+2yGyfOLAugLIBycvdgB68
         fVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0VWA2fvKY7B7aVEb87RbBlKKCbdscLm7wXe7hq9l+o=;
        b=Q7bDDzW0HUDVtJ81MdLi1K9+F16TyKaPMRMyZ1Kyvqc7PPq8ZCxh7lAox477rYmuMM
         doU0GzAOhnq1WzyA9OUuJ4DhVFYntmi+0GJ1VlK0NVfTnHNq6nZ5+b4sE7Wd19L27OSY
         aAK6SZ5j+eXN9izHj9xhtb/Ivn+0vaKtjr5UDIQWD8ybN3yHtS/N0eGakgfnaX/EX/AI
         gt/dvtftZKJFKnog4Kc2owSLUaDl4xITn4iMdzh1rSZ5E8HfARm1PHVt/sTVzBZnwqkf
         juPmQk7WUBt09W/Cw89XRcdSCXwIX+NPn1XlOEJCch+clfOyFVMywbfn7oUTsq9li3yT
         lbng==
X-Gm-Message-State: APjAAAWp//sd0PreHHJzFNw2tTmF+GmGqDu/LCZ3oqrq2fQE/QeMjSCN
        n7ThUV3hV6EK+og47MgFwAlsKg==
X-Google-Smtp-Source: APXvYqzxdf7GnXuxJz22KdsBgghNsJTC0LtjcF0NB8OgJIKAqhQeqkdamrZEnO7kob3vSOk3XbOcTw==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr292389wml.47.1582568694023;
        Mon, 24 Feb 2020 10:24:54 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:53 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 22/26] dt-bindings: document stall property for IOMMU masters
Date:   Mon, 24 Feb 2020 19:23:57 +0100
Message-Id: <20200224182401.353359-23-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/iommu/iommu.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 3c36334e4f94..26ba9e530f13 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -92,6 +92,24 @@ Optional properties:
   tagging DMA transactions with an address space identifier. By default,
   this is 0, which means that the device only has one address space.
 
+- dma-can-stall: When present, the master can wait for a transaction to
+  complete for an indefinite amount of time. Upon translation fault some
+  IOMMUs, instead of aborting the translation immediately, may first
+  notify the driver and keep the transaction in flight. This allows the OS
+  to inspect the fault and, for example, make physical pages resident
+  before updating the mappings and completing the transaction. Such IOMMU
+  accepts a limited number of simultaneous stalled transactions before
+  having to either put back-pressure on the master, or abort new faulting
+  transactions.
+
+  Firmware has to opt-in stalling, because most buses and masters don't
+  support it. In particular it isn't compatible with PCI, where
+  transactions have to complete before a time limit. More generally it
+  won't work in systems and masters that haven't been designed for
+  stalling. For example the OS, in order to handle a stalled transaction,
+  may attempt to retrieve pages from secondary storage in a stalled
+  domain, leading to a deadlock.
+
 
 Notes:
 ======
-- 
2.25.0

