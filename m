Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1069331D47
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 04:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhCIDCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 22:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhCIDBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 22:01:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C0C06175F
        for <linux-pci@vger.kernel.org>; Mon,  8 Mar 2021 19:01:37 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n10so7781084pgl.10
        for <linux-pci@vger.kernel.org>; Mon, 08 Mar 2021 19:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Oax13Ycnamx9wpLhQGKhXcDOzjUXN2vJc4TQ71GNsU=;
        b=gU4WUzJlwjKAVJ+7f5U3W7EoMep8jE8tU3N4kRRikpr9TVxYr+2pwRsF7I4ndPwa16
         1Mz0eXNDtbWKFnBh/FIgV4P6wP2WB6h94iNTbY/OnKONp7yyqNp7TW8WMly3z71VJpAI
         uAILr9IwVVVHXM2qELYdt5Xg2o/ST7i9/aNsYip1s7UvrmCq8mwZxoLlREtl/4lqr9aC
         fqmEKAsRoMPENgnbQrR6eaTDW4pj+h2Xe4cZuw5Jp5+HyCEhtZegQJvigJ6FbDbWPFa8
         z510+9woum7443Wl2SJOHM4wiB+AapECLkiFExhs3t5znpsptVSxyWo+P0kSNA8bsK/9
         o9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Oax13Ycnamx9wpLhQGKhXcDOzjUXN2vJc4TQ71GNsU=;
        b=Op97bajQIUW+/AW84mGirisFB7yYpPlm95zT5YPTU3vmq++LeMDMW6gXz2lmTHCuOt
         g/mfntJ6k/YRCROLxsDjXxqXq3e743FKDX06Qrus8C41IdSrbS6KGnd5Gn5104c/SBrM
         4YqNQ6tUYWHuFh2b6oBA7MR7Xv8ijAQZenIYsyAD7E7IMx1IuuKhmem9IkTHROCqD5PK
         Ak010Yv276o0MYTr7moQ8vrk6puacrwsxMBjU3YMDv6Uk8VXEUNzSFEvxxtx1TS+ItAU
         sYJIEqbEjsaG3DIrXHKubvawJU1iyrSQTtm9m4dhzxclsrsRZvyW/HxIpOYpEvqiCMp8
         XeXg==
X-Gm-Message-State: AOAM532PHpojtMg5MQtjIV6Dd/Mil3h+5COZqxbZhTN/zz6J+Y0f3caa
        OPuN7O8JcIcv5WbSgYZERxP/zA==
X-Google-Smtp-Source: ABdhPJynv1TkKneRotBRZI8yhqktf8YsZeI40s4m68ksFSB8eHzgb/WqgWbRHq0gOKDfgjeCaW56nQ==
X-Received: by 2002:a62:7ecc:0:b029:1ee:f61b:a63f with SMTP id z195-20020a627ecc0000b02901eef61ba63fmr23596993pfc.57.1615258896884;
        Mon, 08 Mar 2021 19:01:36 -0800 (PST)
Received: from localhost.localdomain ([240e:362:435:6a00:e593:6e0:bfb4:a65f])
        by smtp.gmail.com with ESMTPSA id y24sm3162782pfn.213.2021.03.08.19.01.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 19:01:36 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        kw@linux.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 3/3] PCI: Set dma-can-stall for HiSilicon chips
Date:   Tue,  9 Mar 2021 11:00:37 +0800
Message-Id: <1615258837-12189-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org>
References: <1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices can support SVA via
SMMU stall feature, by setting dma-can-stall for ACPI platforms.

Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 873d27f..b866cdf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1827,10 +1827,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
 
 static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 {
+	struct property_entry properties[] = {
+		PROPERTY_ENTRY_BOOL("dma-can-stall"),
+		{},
+	};
+
 	if (pdev->revision != 0x21 && pdev->revision != 0x30)
 		return;
 
 	pdev->pasid_no_tlp = 1;
+
+	/*
+	 * Set the dma-can-stall property on ACPI platforms. Device tree
+	 * can set it directly.
+	 */
+	if (!pdev->dev.of_node &&
+	    device_add_properties(&pdev->dev, properties))
+		pci_warn(pdev, "could not add stall property");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
-- 
2.9.5

