Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA88B18B3B5
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 13:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgCSMsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 08:48:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36809 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSMsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 08:48:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id s1so1517345lfd.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2020 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClZxlMhKdTHfajskxZDRWXcL3ALgK+kLArLrTOCwgyw=;
        b=M/71xg2N4jYJ2rI7E2oJ6vVQN2VbgmjAhziH1DJKvHak/gbDELAL2mO55GZLOCp67S
         9gvkRaVfvjs6x0IVR4w6bKeGeVVH65N+M66tTsGukJHmWlFFsXpIWU39O5hnNTvCHIbW
         iOAdFjQUGMnx/pCC3hysWQ6Eby/an59wWRPQ1ZX0NBj8/Am7JDVgvVsZol7c7RNamEBH
         RPwr5tdHz7EmC0Fr0bvs3GNrJai9FdZjhurFiuOYR/WP/paWWYN8CZK6+dM+pVS5bLcM
         tdQj9ZooVU48jG4ofvosZyzbfCijpc2McmOnq9hVR2uxT5Ye1NC2HtNkoYMJYnv+Tbak
         xOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClZxlMhKdTHfajskxZDRWXcL3ALgK+kLArLrTOCwgyw=;
        b=IToKYHk4hHqDABOzEKi/j/x07g/7tPqCRa/izwax2QBj1S7Glu7/t4xh7LUubE6Pj8
         +Fyg5973n1GJU678If2J/m4eXhTlAyOW0QDkYlUAZrYGiJ2G/Ky84yWVQiSJXv53Qx7/
         lC6WBoDoxFkQDC1DrtKUXM+HikTSriqhaPRgl4Nhf0KTCC5ipuXwIQlwh3LxO+8b5GIJ
         nv4lviMgB2oBfXN82+Dvj9Zc2pjW5NbvlqnfMiNPxZF7Znrq45Gps88FjqhnnWoYeYqx
         uMyTW8FLUVld0GlNh6QdL2tHhlUhlocHcgb0eAiaEJzk5UkR7cSHAZ98AlErrQA01BaC
         bYEw==
X-Gm-Message-State: ANhLgQ2Xq6s3qSvS+0gBE1tsl8giUbc+VorIfIabi5XbNeSKbrlz4xSW
        PGWu/8KVZSvzQtmqwLuJ1vcCfg==
X-Google-Smtp-Source: ADFU+vvCG0ZDxkEsR+Dm6t8GAGvD8YGco8T5g9cjSFQQ1PsZ5IYBPAfflyfv1aRsgr3ArEoxIGDpzA==
X-Received: by 2002:ac2:5587:: with SMTP id v7mr2105554lfg.198.1584622126779;
        Thu, 19 Mar 2020 05:48:46 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id r18sm1578017lji.16.2020.03.19.05.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 05:48:46 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] PCI: dwc: fix ERROR: modpost: dw_pcie_ep_*.o undefined
Date:   Thu, 19 Mar 2020 13:48:32 +0100
Message-Id: <20200319124832.15165-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When building the PCIE_TEGRA194 as a module the common parts are
build-in.  That leads us to the following modpost error:

ERROR: modpost: "dw_pcie_ep_init" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
make[2]: *** [../scripts/Makefile.modpost:94: __modpost] Error 1
make[1]: *** [/linux/Makefile:1298: modules] Error 2
make: *** [Makefile:180: sub-make] Error 2
make: Target 'modules' not remade because of errors.

Rework to EXPORT_SYMBOL_GPL for those functions.

Fixes: 5b645b7fade9 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 4233c4321373..1cdcbd102ce8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -18,6 +18,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 
 	pci_epc_linkup(epc);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
 
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 {
@@ -25,6 +26,7 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 
 	pci_epc_init_notify(epc);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
 
 static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
 				   int flags)
@@ -535,6 +537,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
@@ -629,3 +632,4 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	return dw_pcie_ep_init_complete(ep);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
-- 
2.20.1

