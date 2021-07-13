Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6EE3C68B1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 04:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhGMC6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 22:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhGMC6G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 22:58:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A42C0613E9
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:55:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso544181pjc.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NV7/yF1O74iLBNvfkEg1IJxU/cGFxdoh71Qlx0oT7BE=;
        b=X1tpyci5/JZOAmQTWbvBRYGBKEjFQa32Z1GqbGitkfjZeFm876Exs6I6EzAKr71u3w
         7A9W7fEISdzeCnFUA7EXPX2f2ZINeOySZDLRvaKm+msueXuac1pcHE0yCEYkHdn/Q+u9
         XPQOuuCK/mXYFAMLbRThjEglWjjjn/veXffM1hAeQ7Myg4JAp8DQ8yGuAFvUe/8zRnwC
         cgWFn9DCscrhh6W9gvvTsOsqomEWb9cp5z2xGkleXXCdCcmjpGUJbr0x1Hcs2bLscaEu
         rkfTxxtxIen4is6h0zUIsi07BI76kwtYf5+slg8lhXo3r8Ddal7PC18bVHKezcHFkf0G
         HIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NV7/yF1O74iLBNvfkEg1IJxU/cGFxdoh71Qlx0oT7BE=;
        b=H2VjSE9ICJYHwEf77+RaOI2OTQDpnXP8mHD/X8AQniAqLVeQsQWuBkowYRE4sj84p3
         KC3YVdoGKD2oNXUAp9GHTMMqeyBs7ijStypSpeCsHffN/e759fV3QhvlHsmTJxHyH5t2
         jCXic2bVywnSuADL4jJYdlNpFeD0CSwTn3GSE3C4L1jnaoDcfDCw8lZYjsM5qq751Upz
         o9lmP3Y5Nk5nErQE6n+YwCd+kPsVoxiUryjoqcrn7UyQHpm7Gr4A4JqK9GFSIpfKNwTO
         xstGQxS4crLksrmrjggrUbAaFpNpcceJh5ChrbiM0t17W0YTqYJwshemvPlTvYOYCqTo
         wjJQ==
X-Gm-Message-State: AOAM531uMeFx0cg2j6CWUIrDVv0pGBQGx+DDx5z+vL9HUByl8MAn5seC
        o52i7pDrxpu6r/UfrtJaJdQkJA==
X-Google-Smtp-Source: ABdhPJzmqN/Pby+dpGrUe+mBl1BHg3jXyAwyBRe/KcDBUjVoqsrBBm1K9pblrBcWEzCwkNNuMcLFtQ==
X-Received: by 2002:a17:902:d213:b029:127:9520:7649 with SMTP id t19-20020a170902d213b029012795207649mr1741094ply.10.1626144916660;
        Mon, 12 Jul 2021 19:55:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.134])
        by smtp.gmail.com with ESMTPSA id r14sm19303344pgm.28.2021.07.12.19.55.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jul 2021 19:55:16 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 3/3] PCI: Set dma-can-stall for HiSilicon chips
Date:   Tue, 13 Jul 2021 10:54:36 +0800
Message-Id: <1626144876-11352-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
References: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices can support SVA via
SMMU stall feature, by setting dma-can-stall for ACPI platforms.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5d46ac6..03b0f98 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1823,10 +1823,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
 
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

