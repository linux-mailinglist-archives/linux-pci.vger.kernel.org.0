Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F111EEFDE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgFEDX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 23:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFEDX0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 23:23:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124DBC08C5C0;
        Thu,  4 Jun 2020 20:23:23 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j8so8727413iog.13;
        Thu, 04 Jun 2020 20:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=liGwaubP6mRdOHGTrmXeXAs4GL+KhvggzrIcxZzyx0s=;
        b=BsECjqK/peoemX1wSKgJWtYnYAwXEFm3muWD8NLgko+6QYL8xjksliOJm54JMZ2qq9
         iuJDTR4sFH2cIsTu/toCDJpvHQ1JRzzbloU7G3Ne8r1uRgTQ5TcwDMKPwjp9M0nfBiv7
         mJu75OQe0m1Epn/xL78C/zwsVAHPMVGDDqy+UcJzyahDNgbiWiMWrMbNvGMiaGC8Rl1y
         Xrqy98jXFQVy/d3Rk4Kk9qzcJjQ26Y3fSqAiqFjGUj5oln6jgWiS1J7zHSHrSMKNcjUd
         DBxjZ6GhvEIMT1w/t95w3j4K2AfZY6SbXPmGsVYpRz3o+RO6KnsXmSda17GAqdW9U0TQ
         y7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=liGwaubP6mRdOHGTrmXeXAs4GL+KhvggzrIcxZzyx0s=;
        b=TRDpcQgE4CZagH/SD+oZ/67FsJRbiPBWFkqK0OXAmXfGg/z0c+rPm9Wr2zwAhANDNQ
         UvxAXV22WRBQoTJKAJLVYUlpAsAwyp9DxKT+k8Vy2DSIc9d5iaRXHQLPoCRH0l+fk0Fv
         GxXgJ+3kGG+mI/TkIzRRfLDDTIma35EHieNoLFzrW8rjGY2aYJQ6GkmY9VaVfNnj/VLL
         ETTxhAyNVA5z/ue+133IZBRTHiOhXEcFbHCvAF5e+1U7L7zWpwd/iAT/Hli3VOI4FttZ
         YrvzKotigM3NYpIPl5Um6gzsjZ/jm8TNZV4lDaKn2OKceSd9lyYBSNBz1jB865Wml80R
         IovQ==
X-Gm-Message-State: AOAM532upp7g+NIkdw7kzzqngwKZ4IL+KVcLTb89KnyV3ot56I8Vyy/x
        2Eif4HSgyV5QVKuWn4z7WlY=
X-Google-Smtp-Source: ABdhPJyOP4IZmR82ZM345ctXo67aV+7jNU5IS3XlCDu55+aWNLOqM3cD5hOm3ggE4dnuAOCV+l3B/g==
X-Received: by 2002:a02:2581:: with SMTP id g123mr6733130jag.35.1591327402381;
        Thu, 04 Jun 2020 20:23:22 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id 13sm2315880ilg.24.2020.06.04.20.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:23:21 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] PCI: rcar: handle the failure case of pm_runtime_get_sync
Date:   Thu,  4 Jun 2020 22:23:15 -0500
Message-Id: <20200605032315.39071-1-navid.emamdoost@gmail.com>
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
 drivers/pci/controller/pcie-rcar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 759c6542c5c8..6b4181c0710e 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1137,7 +1137,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
 		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
-		goto err_pm_disable;
+		goto err_pm_put;
 	}
 
 	err = rcar_pcie_get_resources(pcie);
@@ -1208,8 +1208,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put(dev);
-
-err_pm_disable:
 	pm_runtime_disable(dev);
 	pci_free_resource_list(&pcie->resources);
 
-- 
2.17.1

