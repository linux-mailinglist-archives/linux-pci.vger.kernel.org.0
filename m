Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BFB1E19A5
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 04:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgEZCpU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 22:45:20 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:55860 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgEZCpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 22:45:20 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 22:45:19 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49WJ781tVwz9vKbK
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2020 02:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q3PIB1HQ_FQj for <linux-pci@vger.kernel.org>;
        Mon, 25 May 2020 21:38:44 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49WJ7808nKz9vKbG
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2020 21:38:43 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49WJ7808nKz9vKbG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49WJ7808nKz9vKbG
Received: by mail-il1-f198.google.com with SMTP id w16so16596097ilm.2
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2020 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T2pyZeWX2xec+ABdMSwYqLtzMRs3/3YjO1fw5oaVquU=;
        b=QrkWi+59wzuuP/esokdUKbXtJZTN1ik3pHrfAJIkMVshbZGSE1sx38s6j2J10klopp
         uBSwcdBVUFJ8WUhzv9aCl3BLWo9s3Ipr4ForP9F3PsMURdRbHQcztqiPOnAoydBCoh2n
         Zn9AoBvWL8M5A0Tgg1thLFT5Kfq6TVJhSw9i2NGNCIsggZ5GIu+8ZtR9BbXCdbScob/V
         1UY+QVUtuJbGM7lS929r9xyYBzD5zPjVzbRHRxxvxh8htzlm86KHw9S5PR/NzEVoMQ03
         i9zOoEHadZfe92uyr7JTC/CAh9rg7VKxP3yLXww1rfCmuH6O0Mf+dmHxXKnJLULBQWmM
         6S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2pyZeWX2xec+ABdMSwYqLtzMRs3/3YjO1fw5oaVquU=;
        b=adrC+R17ZVEwpVXvGDgUH+V3khvEoqkl6adfbQd3nRy7Ld5DuBzK4cH0KI4wH7Wo4v
         Uf6Kcr2QVOighi+94yYpBGFFqf0NI6FclrwenzpmtIs+XDTueTJzXRHyrr2IAEMi7vtl
         a84Bd1Nv/pM2ZHjPVmGNd+al8UuniHvAd4ZI7R7lzjbWpxh2d+EmgIFAOE/a9gl7po1m
         /u2mK1WdJpb1MjoNhvwRt2MnZYVzI5G6RP1GXl+TA0k92PFox48cEwBU+9LtOYVlL2t4
         /Crq7oKr7scQSmsjMRmzaHhVLAq3ZH6lLr9dNIniJ7+p2eHuHQeOtJ2yCSpHKjfjPoYO
         F08w==
X-Gm-Message-State: AOAM530hNwtP9PO0yxNcwD9WMxZvWOZ2ZCNmjJpOim3LDlIJg+YhWD83
        G6AVNX/jlvWBNr5+kyW14e0yOQY1zSLyQQ3LB28lfHgh5OP7M47V08aALTi0Cc1CDuEMWOYGVH3
        +CHA255nW8Z51KRVcbiyOma1i
X-Received: by 2002:a92:d2ca:: with SMTP id w10mr27598001ilg.141.1590460723484;
        Mon, 25 May 2020 19:38:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxUlisi2OBDfGcYZPt6a3J73pAP0NhbInGJihnQnLZHFBPNyxHuTnFkRnboV3hBIBHQBy0Zg==
X-Received: by 2002:a92:d2ca:: with SMTP id w10mr27597982ilg.141.1590460723159;
        Mon, 25 May 2020 19:38:43 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id f10sm10058337ilj.85.2020.05.25.19.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 19:38:42 -0700 (PDT)
From:   wu000273@umn.edu
To:     svarbanov@mm-sol.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, helgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] PCI: qcom: fix several error-hanlding problem.
Date:   Mon, 25 May 2020 21:38:35 -0500
Message-Id: <20200526023835.5468-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function qcom_pcie_probe(), there are several error-handling problem.
1. pm_runtime_put() should be called after pm_runtime_get_sync() failed,
because refcount will be increased even pm_runtime_get_sync() returns 
an error.
2. pm_runtime_disable() are called twice, after the call of phy_init() and
dw_pcie_host_init() failed.
Fix these problem by pm_runtime_put() after the call of call 
pm_runtime_get_sync() failed. Also removing the redundant 
pm_runtime_disable().

Fixes: 6e5da6f7d824 ("PCI: qcom: Fix error handling in runtime PM support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 138e1a2d21cc..10393ab607bf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1340,8 +1340,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		pm_runtime_disable(dev);
-		return ret;
+		goto err_pm_runtime_put;
 	}
 
 	pci->dev = dev;
@@ -1401,7 +1400,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = phy_init(pcie->phy);
 	if (ret) {
-		pm_runtime_disable(&pdev->dev);
 		goto err_pm_runtime_put;
 	}
 
@@ -1410,7 +1408,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
-		pm_runtime_disable(&pdev->dev);
 		goto err_pm_runtime_put;
 	}
 
-- 
2.17.1

