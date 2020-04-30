Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23AC1BFECA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgD3Okp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728294AbgD3Okp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E914C08E934
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so7649697wma.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qbDs4Y7WviMOr0GSY4nlY77EsYqapJLb3Db4qcN97M=;
        b=t+4aT9+cYprXrpA/0QMDQLTv35ltZRsIzsJhL6WzRIlkGwHMzV+TsilZsqBdYO9os+
         LEmbI9poZBOZzYV00yYcZ2MTRGrHanuT7mbSIOQBDmN22wolY/5LERCWxTie3xScd5i+
         mfXPYaSrV/1gc4GJ4hkv337jnn0KZarzUW+GAESnsUgwH5AStIsuGwjPrCaZW9BXvAda
         ze1VdbzDZPXGJXDAcZRAe+Vz+LRVXXtQ68AFPgXXtAqojny8CzAUyLGsI4qjUN9mU9b9
         QuzOYgjkRq/kGh890dDfQT+uQE4XjhOzPT2Qd7+Ro83BK/yAfy1ITFBBF/jLhKZ5c5sA
         0KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qbDs4Y7WviMOr0GSY4nlY77EsYqapJLb3Db4qcN97M=;
        b=jJN7NnHTtuLrxlex3dbets5TewZPn2Wflj0wSuWhavXvJtJqmrEQisPFtXWxChoff5
         95uHBkjUmDjLInpytgJ18A8G1ia8iKfrZIAAuAp+UXeMJekPd5uX0JvdN4MmCpjbrty1
         IGJOU7VqEndiybO8HwL8hPuPyXXtyNiPB11lS2sL8MqWYyYOHdGofCJuIWkoKiYdPhj7
         dhnDjSmtfFP7cjVQXyLow8h/e/78gSruBahpC/xpIJ1c8hrDWm3Jz0JkdLJIp/vZsx7E
         qY4wb/PIvLwpOF0bgDACG/70mJWATPaz0twvhRfVeOET5JN7H8s0vyc+WML8eYf235LF
         X4Og==
X-Gm-Message-State: AGi0PuaTralJnrky/aSqIyLCMcdWFukPIjYbpMkbQ/mMlZFzohCuatUw
        Jn+kWciDJkmmstXvYXxf7lzGLQ==
X-Google-Smtp-Source: APiQypIZMn/sX8HP3LNRMIS2Wr5t5ivHYBY9IZ/xvKKh7rTp8GxPMClKn6Q3u2r37yB03vTCOANl8Q==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr3255113wmi.72.1588257643793;
        Thu, 30 Apr 2020 07:40:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:43 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 21/25] dt-bindings: document stall property for IOMMU masters
Date:   Thu, 30 Apr 2020 16:34:20 +0200
Message-Id: <20200430143424.2787566-22-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
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
2.26.2

