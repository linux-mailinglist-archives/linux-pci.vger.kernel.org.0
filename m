Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF68515C8A6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 17:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgBMQwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 11:52:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41284 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBMQwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 11:52:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so7566269wrw.8
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJuZlZp89pOsXq+0VjXQ9jH+YMeD48viPFbAUV42/7c=;
        b=am+o3vVNolOAaASmrjBUw9hY20zh4HtDIeCV6yutj5xzyXVGB72Y16IHxHQIChWN4K
         RwEtBXyPJzyBdLrUiuDB9WebfVID313RPtxibqDBWL2qI4fEdVhWvQdYBtq8iutE2Txo
         w88Wt4/3NYU97+1x1rVFsDxgWkSkf5Y5U5yAYg/nOTIQTDbrGTepdUcz0DlVUZ3/K36x
         9H8N+uDIR/4lAvu+ulNTEYXWpYhtxoIrTTyYBvEDAkg3aGBagLnZaGfdsHrcMOkeYCLH
         gUkMaS0Nl4Eix25KyyEsKtyXrPM+71nsvKDJsWYCA2NZQ4m0FRLUlADHZ2WFOr3VOT/B
         q1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJuZlZp89pOsXq+0VjXQ9jH+YMeD48viPFbAUV42/7c=;
        b=j3aRcEGoIS8gSd8F1MpYZdAaYTAOwuBTk2iE5hEfASetLdS6GfLVsLCkxvUVPXP69g
         CHF6v7ygXq6iLtVXuq2r1fwLhdCoaOud5yvijUmTAH6QkeDGvqmkGhEBn+Ck+gojFxzH
         xtD7O/7Q0tNFlwKaLiVNUZYY8HuDxwsYdmyptON1EyooFscc9uY/M6eSaXB6FPpe2ck0
         mo0CkWKVgomB9+TN4xuFp2Wbkx2sBNLBPjywp7FxpDRGRfNz9E70wpNW5DhRk0TIiPiu
         IfHDQE8OqmZ5fRkYzu5oUtf/3BzaFUlHPaS7SQVKNHu/0kqDfWdOqJ/azHBxeTWZe223
         1pNg==
X-Gm-Message-State: APjAAAWUslhShtpjJ4W4axZItynws9CN1sMkZ+/IBLLQJKpBbijDS4gF
        IebIHZAdlQqivBa8KtVPeCtZWQ==
X-Google-Smtp-Source: APXvYqyRdKXRvNXU931mCSFJbrbPQ+3L84wtnv9cjPTz5Ed5dcoIv/1s7/DTUZ9TwVfpeh22DgxFBg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr21737194wro.279.1581612727305;
        Thu, 13 Feb 2020 08:52:07 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:06 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 03/11] PCI: OF: Check whether the host bridge supports ATS
Date:   Thu, 13 Feb 2020 17:50:41 +0100
Message-Id: <20200213165049.508908-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Copy the ats-supported flag into the pci_host_bridge structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/controller/pci-host-common.c | 1 +
 drivers/pci/of.c                         | 9 +++++++++
 include/linux/of_pci.h                   | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 250a3fc80ec6..a6ac927be291 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -92,6 +92,7 @@ int pci_host_common_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	of_pci_host_check_ats(bridge);
 	platform_set_drvdata(pdev, bridge->bus);
 	return 0;
 }
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 81ceeaa6f1d5..4b8a877f1e9f 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -576,6 +576,15 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
 
+void of_pci_host_check_ats(struct pci_host_bridge *bridge)
+{
+	struct device_node *np = bridge->bus->dev.of_node;
+
+	if (!np)
+		return;
+
+	bridge->ats_supported = of_property_read_bool(np, "ats-supported");
+}
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71f..2d0af410438c 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -7,12 +7,14 @@
 
 struct pci_dev;
 struct device_node;
+struct pci_host_bridge;
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 void of_pci_check_probe_only(void);
+void of_pci_host_check_ats(struct pci_host_bridge *bridge);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -26,6 +28,7 @@ static inline int of_pci_get_devfn(struct device_node *np)
 }
 
 static inline void of_pci_check_probe_only(void) { }
+static inline void of_pci_host_check_ats(struct pci_host_bridge *bridge) { }
 #endif
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
-- 
2.25.0

