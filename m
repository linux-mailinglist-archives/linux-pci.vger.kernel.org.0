Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7D21A46A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGIQKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 12:10:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40263 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 12:10:05 -0400
Received: by mail-io1-f66.google.com with SMTP id q8so2891053iow.7
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2020 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jV5Q2BcP9CMI/8a5AeORE3bGcjhTMGqCxpwCuMOewE=;
        b=nUrGk3aEJrqykrwilpxItOXbgYjChlZToRRDM8z5JK8c3suF7H3WKyueLd0cE+WOAy
         55KWEjfyWeJOWYJFVomfGoK1r0hdZo4CbFDxmCJoAlY2uG6SZs13nHjNrmDaVU63qcn1
         IRPHpzcVx9cPJda8tAqM4ll00wth8ublyQ+/WHRkD0rgBkZdZeNGXwdvkt6EKn4hhjuz
         4wIBaLgZnHUVdMk3lRF34iq76PZj/iG0auX5Wsr1T2XHlpBcY9tJbyIS/w1DPrNewcX8
         wFm1sjZW54yHAlFmeFB92ZROMD9gdvKkHeFrkjJPb3HVFKswrJgzSGP7Z1QamjTujjiA
         VycQ==
X-Gm-Message-State: AOAM532DYXQt83UZ918WvxgGIKJJhZoWecUgM1XLi7mfuFwWFXNcJVuo
        dZnWT50mJVjWIKz1HXTN8BBlb7e7/Q==
X-Google-Smtp-Source: ABdhPJxOxcxWHIXwKodn/2E2bz39ppKYVPjV0S5kIpCKTdM6mYDLe1vnSajLjkbX188DWocHGh/Qyw==
X-Received: by 2002:a05:6602:15ca:: with SMTP id f10mr43795236iow.52.1594311003988;
        Thu, 09 Jul 2020 09:10:03 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id t74sm2238925ild.6.2020.07.09.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 09:10:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: host-common: Fix driver remove NULL bridge->bus dereference
Date:   Thu,  9 Jul 2020 10:10:02 -0600
Message-Id: <20200709161002.439699-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 2d716c37b5ce ("PCI: host-common: Use struct
pci_host_bridge.windows list directly") moved platform_set_drvdata()
before pci_host_probe() which results in the bridge->bus pointer being
NULL. Let's change the drvdata to the bridge struct instead to fix this.

Fixes: 2d716c37b5ce ("PCI: host-common: Use struct pci_host_bridge.windows list directly")
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-host-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index f8f71d99e427..b76e55f495e4 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -83,7 +83,7 @@ int pci_host_common_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	platform_set_drvdata(pdev, bridge->bus);
+	platform_set_drvdata(pdev, bridge);
 
 	return pci_host_probe(bridge);
 }
@@ -91,11 +91,11 @@ EXPORT_SYMBOL_GPL(pci_host_common_probe);
 
 int pci_host_common_remove(struct platform_device *pdev)
 {
-	struct pci_bus *bus = platform_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 
 	pci_lock_rescan_remove();
-	pci_stop_root_bus(bus);
-	pci_remove_root_bus(bus);
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
 	pci_unlock_rescan_remove();
 
 	return 0;
-- 
2.25.1

