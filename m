Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6645A6A0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhKWPl2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbhKWPl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2293EC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso2212976wmh.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkoKp/ZvjPVk5Z9+yOVdTSDtiH+0HB41JUhvuN2nIYQ=;
        b=VoIUS0MvsbnDKyiQWADq/97OPFhnhuORr68hhKIGt+0ngZmylLgUZVpym2dD5JscFL
         daJpZhKT9eqEQpv8tfy1QEwpaXXklN/F4iozOK66zKk7UAJXWK7XU8xi99dP/SVcJd8E
         BIvfBYFzT6+x9tcl7c+FkmIMe7ia8sWO76BJ12EHcC9qcQ3yRkvwubSrxcxGg5ENuwT1
         S6foJ4OBkNumu4wO0KY9w8l3DkG7SgpYF1oqiGpHXysJrwMjhxQn658vyQxQkjUz/vwn
         AhxdL2rKf7CP5pqAORC3K2FWwpXGqBBKIaqFF6niiVOR1UDBrVpgFLouXkLepN2MBfNl
         mGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkoKp/ZvjPVk5Z9+yOVdTSDtiH+0HB41JUhvuN2nIYQ=;
        b=NsPhBddSWSbDHueGqFIq7v0B+HvT+plTW2dqUkfc1meNZ9me75Q4C8PsUnmH3uYvrh
         ZDL26s1SYpT63Xmha+dAPtdSI5rDMBSSelPD0HmBY1/3/x8qqus2kZJrDwXbLujsMsvd
         eHz4fLODK0YB40HGYhWHQqtdlDm4qVkHax5Vj6Uwv0i/n7OpCUG6Wob5f3z6FVMXAC3N
         Z6t0pZ6CMLWHrk5S0aP3Cc8wTdUYB3axr+IhSV+jh06ez6TDqrT8ctBPvnGe+TdBfG8q
         xyewaBgEWclGtxRDiqFKJ2mgVle87NQVtzT/3kIqitmkrBOxSc4BO7M6hVfB1prtnG9/
         2tRA==
X-Gm-Message-State: AOAM5321Z6kZAxO2N0DkGqPiD3g/qzLsZynJjKjVstsUup/q9CE38sEV
        4+tQ8e+6BYJRwIE//oxc0+hLHrKdEY5vYw==
X-Google-Smtp-Source: ABdhPJx8RHEptXnKdVU5F54DGIx8IX93CoeCAAQ70U/KwUXDJeT4dPycXcEyoCA8GHUfosqG7TPxvg==
X-Received: by 2002:a05:600c:17c3:: with SMTP id y3mr4042208wmo.136.1637681898693;
        Tue, 23 Nov 2021 07:38:18 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:18 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 7/7] PCI: dwc: Prefer of_device_get_match_data() over of_device_device()
Date:   Tue, 23 Nov 2021 16:38:02 +0100
Message-Id: <ad99112fe7cbe4f508a860b6a75264afa5d504fb.1637678104.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
References: <cover.1637678103.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dw_plat PCI controller driver only needs
"struct dw_plat_pcie_of_data *" during probe(). Replace of_match_device(),
which returns "struct of_device_id *", with of_device_get_match_data(), to
get "struct dw_plat_pcie_of_data *" directly.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 8851eb161a0e..0c5de87d3cc6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -122,15 +122,13 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	struct dw_plat_pcie *dw_plat_pcie;
 	struct dw_pcie *pci;
 	int ret;
-	const struct of_device_id *match;
 	const struct dw_plat_pcie_of_data *data;
 	enum dw_pcie_device_mode mode;
 
-	match = of_match_device(dw_plat_pcie_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct dw_plat_pcie_of_data *)match->data;
 	mode = (enum dw_pcie_device_mode)data->mode;
 
 	dw_plat_pcie = devm_kzalloc(dev, sizeof(*dw_plat_pcie), GFP_KERNEL);
-- 
2.25.1

