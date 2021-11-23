Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9A45A69B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhKWPlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhKWPlV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB6BC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d24so39747781wra.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMu/QHi9PWMtTOr57k7Enm5+z/lmpZGy5PwjeKee51Q=;
        b=R3z6k5NZv38JhcPerXsLBKVEyJYDDfN7NQ7CNiJszXtm//OT1OWTmamSTEfbdP2CL1
         AWuBewuRunC+7OZH5Sfsx4Vxs1RBcXhq0bUc0MIL8a3w/8f4cTnne5yyDtbaR/tXUXtf
         e1E5ieCSznB/sGZop6EF0fMjgFRsAyNS9u+WAf4Y00Y2T1GvqEZhiT2Zb1ULZsPp8GI1
         H7a9ak05QY66p/93dp3bmTTHWQxLScG7v81eYbrgLmWvzRGWa5Efh07zga5XOwSwBPIy
         2ZCW3B+dgYYbJRNcJYkg4bfVd/9KgFl824n+09soNKX3EsJT6WsnLheoED7KFuuBD3LO
         z15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMu/QHi9PWMtTOr57k7Enm5+z/lmpZGy5PwjeKee51Q=;
        b=sL75ck58685GjJSNfA3l7QJRGsliBqjZBnK/7WC/Sts0RNb+OAbaAh5+vBblI29463
         3qNna0D2Gs4JX6D0EWUItAu+ZQZDeUwrgGvfbuhIdq5MgkY3z7XW8hDLI8azUE3ZKiKF
         9GzcILs4NxtQUHcehqBDyvyfzRJXvOqdjtR7zlPalM6Eh2a/Au6/4vVzODGQEC2vUPf9
         yWDIdb7xxGTDpmn3YVViqycKPYB60Wbm3it//g0cg88MCWWeuBTY+gGmQ1KwIvT0+zp1
         ipkHk5MsS/CjZC9wUEBqKBWt+UB7l+soIWETb3lb0QALNEHsGWCKQuM+vIGKi9Wha5Uy
         /LJw==
X-Gm-Message-State: AOAM531c+1zrtERNfpJMUGj1KcD8Fa3ehQi703ug38uv6/5uoXBCsFad
        ai+QZBwMP6knhxQDeJsNQ2zNw3LN3RxuHQ==
X-Google-Smtp-Source: ABdhPJzFQk3V6t6IbYbbXNTtioG8b58pt2DLr8SuigWDCsGkJEvYQWjcqGKP18T+PLHqbouNnzHNIA==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr8262314wrs.207.1637681891442;
        Tue, 23 Nov 2021 07:38:11 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:11 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/7] PCI: cadence: Prefer of_device_get_match_data() over of_match_device()
Date:   Tue, 23 Nov 2021 16:37:57 +0100
Message-Id: <bc48c9d579395bcf8d83121485954feb68934550.1637678104.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
References: <cover.1637678103.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cadence PCI controller driver only needs
"struct cdns_plat_pcie_of_data *" during probe(). Replace
of_match_device(), which returns "struct of_device_id *", with
of_device_get_match_data(), to get "struct cdns_plat_pcie_of_data *"
directly.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index a224afadbcc0..bac0541317c1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -45,7 +45,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
 	struct cdns_plat_pcie *cdns_plat_pcie;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
@@ -54,11 +53,10 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	bool is_rc;
 	int ret;
 
-	match = of_match_device(cdns_plat_pcie_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct cdns_plat_pcie_of_data *)match->data;
 	is_rc = data->is_rc;
 
 	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
-- 
2.25.1

