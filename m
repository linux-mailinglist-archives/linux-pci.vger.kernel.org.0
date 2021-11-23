Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72A145A6A5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhKWPl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbhKWPl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A6C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b12so39677367wrh.4
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbTUI0GBeMJqhJyEjn6fX7cQKzakHTR15Y4khfoksos=;
        b=VqQV+qWVR+Q4Pvzdkl5iCebHY88aHYq11Nwl0puCC3sejM9E72FWvD9AtWxpeYSVL6
         vVMm+nTHgcM1qDOYsfU6xrjQl01bBsFDYQWxm/gHstzVekkCL1wuI5Oxf2/YmwSozb6A
         TCg3CIKAotxOepeaSc0xqJBHA2IySlENPxfnGQp6owv2t7SQN9Es8K42kurTt5j00IhV
         ZfqQLfJeb++ClJPhIxge1CtHYg4nDjT9JG0qf0vwtcahzOwBLc3ZFUKe57Ng8JbMCurI
         Fra4xZ4EK/Gbh9bWhL1Kg27k7bxQuevvcNP2RwoGA75wB0L3njb8PMDkAj0OTYF09EBx
         kYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbTUI0GBeMJqhJyEjn6fX7cQKzakHTR15Y4khfoksos=;
        b=jrslAIV+J0WkJ8cTZhwt2lM5Y5GcOXZlz0yTkMH4EaYnT5n0tmFHgOr73SdKBad49A
         VkfY6MepOQcSY8iam5SPZrx/uaNfLddFVlVHjgcC3PVT9F6VUlLk5Yfkdf0dGg5oOAl5
         JGyx6gX7SFYSJvomemzXXnpwDBClkEc5BxJq/cAX5+jCTVDnXpwUuH5U4+q9OGa6ZUwr
         bSGVNVJc0GPwhhRzt6jxDuXSU21Rt6lGKYkzG8OunHVB3csGEXs47AqbD8o+wIYkaNrk
         dEPVrDzv8vY/0C9B2hzbsMdTYBYoCI8s6gbbu1Yoh8DzZwsYUMZAs6Qn6b9bD8/hag4M
         ocug==
X-Gm-Message-State: AOAM533grmg/nquV5BVXud/vmhS5jJoyOue5E1TU271EaY/7u5hyhBnv
        w8jg+bHBd9LdMsfGkaJUm0M=
X-Google-Smtp-Source: ABdhPJyEdSUeztI1NDWdDmtoJEGBgDlA4N+Ou9ncSqp3amw6UCBwvBjaYGsjMKqL5itIV8hkvg3xWw==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr8314853wru.227.1637681928175;
        Tue, 23 Nov 2021 07:38:48 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id g5sm18281696wri.45.2021.11.23.07.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:47 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 4/4] PCI: j721e: Remove device * in struct
Date:   Tue, 23 Nov 2021 16:38:38 +0100
Message-Id: <f8e7429b6ff1518e27ddc322f481c30ed071eb5b.1637533108.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637533108.git.ffclaire1224@gmail.com>
References: <cover.1637533108.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove "device *dev" in struct j721e_pcie because it refers struct
cdns_pcie, which contains a "device *dev" already.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 0aa1c184bd42..04040cb220e8 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -51,7 +51,6 @@ enum link_status {
 #define MAX_LANES			2
 
 struct j721e_pcie {
-	struct device		*dev;
 	struct clk		*refclk;
 	u32			mode;
 	u32			num_lanes;
@@ -99,7 +98,7 @@ static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
 static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 {
 	struct j721e_pcie *pcie = priv;
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
@@ -165,7 +164,7 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 			       unsigned int offset)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	u32 mask = J721E_MODE_RC;
 	u32 mode = pcie->mode;
 	u32 val = 0;
@@ -184,7 +183,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *np = dev->of_node;
 	int link_speed;
 	u32 val = 0;
@@ -205,7 +204,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	u32 lanes = pcie->num_lanes;
 	u32 val = 0;
 	int ret;
@@ -220,7 +219,7 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	unsigned int offset = 0;
@@ -377,7 +376,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pcie->dev = dev;
 	pcie->mode = mode;
 	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
 
-- 
2.25.1

