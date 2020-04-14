Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F041A86DE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbgDNRFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391574AbgDNREt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC893C061A0F
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so15238616wrc.8
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ftC8/er1w4cYUOvkGIk6/FxjhZRdex8XjZifggKsOVc=;
        b=F8zREYkzXEOjBIICh52aRBSsx0KYydBsiSeX1vLg3BjO4xVUHlOuGYyrqsAzk0um9g
         3hU3Mthe396hmS7rS6NIcIUl8Y8KnOQtGN0ORHag7JZrgh3uEV356dXEM4xwqqY8Pwze
         ZgNtKerpX4ZsyYd6DLVCLnyGotM1ATwYAczIh0xraXRquNJjV3GlWXMKOjri7lBsWJKF
         9GslApQWbeYRl93+vN13YZV/onxTemXTIrjfGUFMghYYcHdVO5B/9YbOhJhgVpL2U8MP
         LFuuUzzxRxcGmg4CxBLLzH1v25WazSQ9EmXw0gGw5UejA1+P+S/9YYiR3yZFbn2OR5Ms
         1UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftC8/er1w4cYUOvkGIk6/FxjhZRdex8XjZifggKsOVc=;
        b=i/vdIbZMCBVLIBWtDlfAnQJUu6VdfRHuTD6cP5FjLBn+hNLGC5uSZtMOLSlQZD4+IY
         okF/gWMINcAwCrrd9GxFH60SRUmySHvw/z8k4Wo0yeMlEYB1FDDHsQV/tYVBOLYXR+7W
         lfF8FeQ1s75xZXqm5SAOTRPRBJIufKY4cHLdKQnZ1zwZ8T5Yd17OJEZXc37izg5A6+OA
         F+LESQyn22zfp2/7UwLqiDAtssIUMJBB9RxXNGHgOPmKbcgznkeg+EAVEnprDvnd5koM
         rafajajTkzof8/yfpKctrtV335FmU1wb+FViWNSVU2YcQfKJt8A5OXq29yCU49w2TojA
         7VvQ==
X-Gm-Message-State: AGi0PuZbEuBogj3pClOGSJuE/Z0PbSbF1zHwOSFR+usNJ/S3TjeivJuv
        SeFNZV9RU6hre83yvyQzDnZWsg==
X-Google-Smtp-Source: APiQypIujMWDDt9womD2KtF8tCtmfig9Jpg4Oo+YzImaXPUr4DRwtpc2ABhB4671zuBVFTAOKxmNLQ==
X-Received: by 2002:a5d:568f:: with SMTP id f15mr23573543wrv.48.1586883887656;
        Tue, 14 Apr 2020 10:04:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:47 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 21/25] dt-bindings: document stall property for IOMMU masters
Date:   Tue, 14 Apr 2020 19:02:49 +0200
Message-Id: <20200414170252.714402-22-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/iommu/iommu.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 3c36334e4f942..26ba9e530f138 100644
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
2.26.0

