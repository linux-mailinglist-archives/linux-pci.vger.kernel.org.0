Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486AF1EEFCA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 05:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFEDQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 23:16:50 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1459C08C5C0;
        Thu,  4 Jun 2020 20:16:50 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a13so8204641ilh.3;
        Thu, 04 Jun 2020 20:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=chV31ycehDJwKWvi2TUm71ZO2UoOzk/sCVlPTSAKh+Y=;
        b=hGyNvAiyrRakFvypaW3hcRrfbbrE73Bnclr0/BczpM5/voZg6UPeIooElcVX75r9wj
         ww3XgfVfEVEvGwpN1KVwfzn86RHkstCgvGEOIppTJlqcL4iKh162ulPtSwChHd8xiiwD
         Dp3aGVK4LyoSiuMN0n2vPv8vuRMI/5c4D+PivtofE/+Vu40ci1o7Hzp52JQv5N2onp35
         4F82b6sb6Ohr6Af7xTF3CAuxDjB9wg9AnKMWLiePQ3xDJlFuMMVccbga+vqDW90uRJ7A
         sNpm7Hzbcz5IH10NjaYQWrBZFWUBWY6aZcJbMo7OpdsIJuHN4b0RIZlbG/HJioRSGTGp
         3J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=chV31ycehDJwKWvi2TUm71ZO2UoOzk/sCVlPTSAKh+Y=;
        b=E5doxDmBET2ow/4LWQ42cLv3WobAg15PkTT4QNn3BTjoO2vJLhqVQIIjz25gn8XtTy
         0lGQwNW8Z1As3yzz/F0XuCWV5eD4gVP4mJkiiXG1l3q7sQRf/9o2rQxsqyBzZXHCk/Ev
         Q7wfD9cspQ0dQzAnVCN6joDAGMkvv4nqxEWxpkcabmE4j1BnITYlkqNZ5Q1EePueFVh7
         wPn6ahbZxAC6IW+WoCGbaiUrpeNSZnitr5i4QLRiFmN1sT0NLo6vkO85cuWTD+0IvnSi
         y9JaEy1W2dQ3XjK4qCCkZhqEET7LkQUSofq5auinnDt0Vkl2YfwMy2a9Sw2vasAL9YWi
         TXww==
X-Gm-Message-State: AOAM532SbM6Amt1Pik7pNayugLT282Fy+jcuiexVqsYMs1UVFan4dE7/
        wOAHQ7x/ozsU2i6k9t/XH5Q=
X-Google-Smtp-Source: ABdhPJwcVEyQGMTVOwh+hQCVPGhz/Cp+CoHkMMWqrzfyPDLv7YCMU5LzL3uEABVB19cerT9NdulxlA==
X-Received: by 2002:a92:db01:: with SMTP id b1mr6950593iln.233.1591327010053;
        Thu, 04 Jun 2020 20:16:50 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id t189sm771642iod.16.2020.06.04.20.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:16:49 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] PCI: qcom: handle pm_runtime_get_sync failure case
Date:   Thu,  4 Jun 2020 22:16:43 -0500
Message-Id: <20200605031643.18171-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 138e1a2d21cc..48c434e6e915 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1339,10 +1339,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_disable(dev);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_pm_runtime_put;
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-- 
2.17.1

