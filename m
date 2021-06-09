Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839963A0ABC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 05:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhFIDk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 23:40:26 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:42728 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbhFIDkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 23:40:25 -0400
Received: by mail-pj1-f41.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so567377pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 20:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zXMN5ll7TqYL0aplhePUX2gZ+E/gbqQqmdmCua20NM=;
        b=UZyWz51Rvms6N+ygB3kUxZtGt095CvNlartmipzWktYJkX6mhk2UUYkFSIt3/zA/54
         rBtSPHOfB3zEgZpzeHHFpHUwQ6ymdsyMzMlXyDv9xJzwa4yTID9WTr1bj8wFcc9p2ujO
         MoCIEC28IQg1q/tLpq2rfmJTSBAhoka7P+hEEfLb0F00cegQaoxPsr2DWXE+YWYvs2R/
         xNFZME+bxCcb3psEc3YuUpt12MNhcFxHOE0r2PG03NTBb0OA3QkcI7wgR/Ig8PeEaSJo
         Q7u7nNhSeWXckY3D8p/emX5k0sNEaGinWv+7i2bC3rkK2rc38wMCWbHQPZxFqEvSj7BX
         xopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6zXMN5ll7TqYL0aplhePUX2gZ+E/gbqQqmdmCua20NM=;
        b=Yv/XJp6MU7oXr+kV63LLr2y0nE88VsKY0EJVawRSKQP4t6ktL1LOW8IR4EVRQ3AUru
         gDvu4NS7GdqQEKhWHY89Jh6KPkuqipHu5QqyrN1CgtQpxPDeszLeRhsUa694Av0Mxcq8
         gYwcfqrVLj9+dq8qRRSxsjgMcuIKImn5UMi3461nIfykXnyGeySObMZr0RrctG++b2ey
         MxXR6WtQYy0SmAX+vDE37r9CPcvf/bWeGxE5zo3X/FuBQIpGtQ9997bz1uPC8ugnTuAz
         ykWcQLvlrUHDug1E6/Jo/K83MqIF55QFjXJSFUi+Fu9vRU+9PZgzfhSOQWdqg26Ktbs1
         PswA==
X-Gm-Message-State: AOAM5303ehbuMDHJop2D2c3rPWx4el4yQhFhAf7OK4KavKHfwMtTHqui
        enr4ujIkbIfQNCbInMyhTvdyJw==
X-Google-Smtp-Source: ABdhPJxBIQALUt+JU3tbbDF+75RfxEJQGypdU7Til5HLLfgC9LGuKID8h9Yzu36B9UQoUZd+dNbHFw==
X-Received: by 2002:a17:902:9042:b029:10f:c864:6090 with SMTP id w2-20020a1709029042b029010fc8646090mr3393800plz.39.1623209836798;
        Tue, 08 Jun 2021 20:37:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.135])
        by smtp.gmail.com with ESMTPSA id t24sm3473904pji.56.2021.06.08.20.37.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:37:16 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 3/3] PCI: Set dma-can-stall for HiSilicon chips
Date:   Wed,  9 Jun 2021 11:36:41 +0800
Message-Id: <1623209801-1709-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
References: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices can support SVA via
SMMU stall feature, by setting dma-can-stall for ACPI platforms.

Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/162314710744.3707892.6632600736379822229.b4-ty@kernel.org/

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9331113..c1643ce 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1822,10 +1822,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
 
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
2.7.4

