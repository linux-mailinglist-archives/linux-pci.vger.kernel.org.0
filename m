Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2E2B05E2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 14:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgKLNDe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 08:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKLNDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:03:23 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16990C061A04
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so5888560wrw.10
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tid3zbIJRKyj0Bgjxj2sf+RSwZO5YPfaeHYqLr0g5iY=;
        b=oJG4X6CI7enblSZUp3EgWunBFmyQv6mCwtptSww+yPpxypkzQpLOkXizEPseu9wI2t
         2uZpYfOj9eUqkc5Mc5tlt3K7jx+TWvIflBQqX1SEYsvTIjIegzyCiXcmEFzhPjxvoA47
         6Dq4ROrha3r07LiOgqCfR01hIVv7++Ib5t5K0yXdpav8K1LR8Zat1PWjsoKfQ809OKnH
         1k5v7fX1Ma0DDtnaTPNqdNu6iefW98IR6j56uIkzclVoD8+TGJgwKYfDHt4NXx+25cGn
         SRyX77nEr1L/nTzdOO1Yo2Myq9+BofVGSodnPeoKBdMbtEUWw45R7NEYQRJNFh3Men13
         MQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tid3zbIJRKyj0Bgjxj2sf+RSwZO5YPfaeHYqLr0g5iY=;
        b=GGbLv8xK9OslpoQZv7b6YvNfziDdOunpHHo+yPyUS2VDxhbIGVX2ca15EpaSCHzlds
         8ZdZRjChB52jKLmX7xADPXOWEp7dF8i0p608xS7pnvqXHyH1MqvhVlxcIXUs7yAMjNS4
         iDrSgUGRvz55x0K5trf5+OYsasZYBhn+DCBikep4eDF67KifmWu62jgW5Lo2qg56z8eb
         p74tr8Yd/RBv2aWJU3L1gXkiWH3ZTt0+RDRaZZeYkTJcTnzKZX4FnDAyli8abjGEMY5y
         X2czQXmZprPVcKSd4ZpfglFK2X3OhmUNw/0NRIIv8cvQz4skq/KjOKonUCZJBK9jC4Lw
         jD7A==
X-Gm-Message-State: AOAM532qVbePFOna7hcnnNBuPYpomZVpBWy7pueb4dyMbA7VJf5DXMbM
        dyyR8769pNI5iurUNLGHm77vaA==
X-Google-Smtp-Source: ABdhPJww5aqw0Dh36h3mNuuwHJd8ZSSnPISNulq6oQQhTrIxG8XhHZa3Ym6AO5qFBMZHmbjVR9mCBw==
X-Received: by 2002:adf:df88:: with SMTP id z8mr35234477wrl.113.1605186198680;
        Thu, 12 Nov 2020 05:03:18 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:17 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 3/9] dt-bindings: document stall property for IOMMU masters
Date:   Thu, 12 Nov 2020 13:55:15 +0100
Message-Id: <20201112125519.3987595-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.29.1

