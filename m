Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A392B05E9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgKLNDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgKLNDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:03:30 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8FC0613D4
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so5425906wmb.5
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVbQfn+wW1FJTP9+IaoEjGKkOhoG1CH1YVgrdlNJ6Sw=;
        b=AJNFqP/ZKhk6objxUUtP+6tvikca2WaZ6jTYQcqn0yvFmq93hZ3lVQHYyK7f33pXgE
         LMPNyvQtw49zSsYAQyGirgOmAjeKMdajdiJVAvrB0xvcpLKnNUh1Z8ZszvxyGNv+yFWO
         jRyaMPOhhzNbE3/mz7+lXJ3IhlCs6H3xrg7kN1+ZuHmW+evNoDn1JYTAFeNTCQVfBP6C
         UDXzfEZDz9yBRbmmCKA8RPN03ITbdvYu314gLJxyyi+H6Vek4EQpQ+DnwUjWmEWZQ4P7
         ecl6SKlD8ae4yC6bXIaFUH6JgCSMUZFZyPJSzMPNHa1vLYEGIy0ojNDIzjqoS0ABNNt4
         JmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVbQfn+wW1FJTP9+IaoEjGKkOhoG1CH1YVgrdlNJ6Sw=;
        b=uJTEbRu/8HUvIfVQWYT1ZQWIVX02kosvJkwgMVN6al9JfYxrEx8183FwYnzRKnhOv4
         d+qqbYhSgT8zmeSCjd5+GzHqyNVDU1livg8Ohagj1ceWXVU4pHFxxgVrw4AAXtTqxc6r
         mKC0xOWrgiztamOm5XcY/nyH1ngkS0RidGUpZQD6mn5ZrzWP654IPUEoWPNjbWafCO/8
         9BA1xBNutP1O0xpy6JtTxckd0HIsUjYRZjZ5AfqF8EEtql4apz+/W5iK6GTXMoJ2pAvS
         1Y7/nqa9skPUFjdqxy1NucAB4PkfoCVxpH1VIcIrcy1Je+cH6iOX8jIQNpDBVyc/tFIj
         ldmg==
X-Gm-Message-State: AOAM530ObLGDfh+BAjtilhKYzxNlRzxgbkMnfCBHzXTWUWmQb+JQeyB1
        TTQAT7GaAUOPgDra+ZbEG+Kgfg==
X-Google-Smtp-Source: ABdhPJxsDYTMbvBnnj6uOORdu3x6BbabxcW+EJNp1tzj8KBQp5jtE8PRmp5+1detfGdDqBG6DaNgNA==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr10063043wmc.159.1605186207268;
        Thu, 12 Nov 2020 05:03:27 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:26 -0800 (PST)
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v8 8/9] PCI/ATS: Export PRI functions
Date:   Thu, 12 Nov 2020 13:55:20 +0100
Message-Id: <20201112125519.3987595-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 46bc7f31fb4d..e36d601015d9 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -191,6 +191,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -238,6 +239,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -317,6 +319,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -332,6 +335,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 
 /**
  * pci_pri_supported - Check if PRI is supported.
-- 
2.29.1

