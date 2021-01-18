Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7702F9BAA
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 10:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbhARJAz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 04:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbhARJAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 04:00:47 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA47EC061575
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 01:00:05 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n10so10505556pgl.10
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 01:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3k3cvWBqp3yfYjIh9TJOU/QTWyWiEbyVzrpJg7eUzFk=;
        b=CypnN4xXqqoPD6fZ6ZyEzVUe/XB55DNBfsbqbpVUg7suOG9R0D1GgU0PPjbhuk4z+i
         yvdUR/YRlZt6mEZUrmlcK97ibeugaABW/PBO/QKVptkEZ+bfDSujj50M4BLk5EpMOi9f
         fphxUjOQHUKrmgzIWX/o/8ycF03Y07NjjpI/KOZZAlRCHbtm43XCJgs2sP7OxYjDdt6+
         eFVfU9D8hMJa0SrscBOvFAug6O72cC1kKliGP9o+DHdVIS5zpD9KJYx5XggX1qBzJ0ww
         gOxzjqWqw0f4aPiGagE/ZxLd2QXEZ4A31H3uuGcR506u2rbN+GSEuApcALTIW60JoknW
         cZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3k3cvWBqp3yfYjIh9TJOU/QTWyWiEbyVzrpJg7eUzFk=;
        b=D6ScNjU+mup3Ua+Gd7lv+wiseGY/Jh29OOkBsE/u4xteDhg0mTw9P+YvpPU3XHnMsR
         eLqPxAqMZcuV1g74MAsJoHK6DcFETZhCJZcbvnJbceDhs9a8GCnkj4gxAXsgHt1fq3AK
         nqX8Z4a8ll0f/SNr9yrOsce1wKnzQdGG0hk2iOSHDy9lWm6jHBHeCFL7LqZsH7FlbVY4
         5osq2uFJ37IGnQt3/rPNIqORkafbHxa37pZnGLsl+N+PeDpTc5PChRHBjsIDmwjaGL3N
         pjrROdZkmS6tLb/q9GjA17AaD3zeeiVGYDHz7U0mtybnK6Csykdv+8nyiNuWlhrZnqLT
         53sg==
X-Gm-Message-State: AOAM531oSBdWaUtpjvWZDWkK3EDoMs+xNdbQJzi2O9CFcqDTw6Qm3we3
        KhyRXUlBG7SuAj3iv/phigQdGQ==
X-Google-Smtp-Source: ABdhPJwRerby7DfvrEpSpJUgKZScBXCGa+EReKk5cv1b0njhy5SmH32VK+27Czea/1J1ebXTIkorrw==
X-Received: by 2002:a63:5805:: with SMTP id m5mr25120923pgb.352.1610960405257;
        Mon, 18 Jan 2021 01:00:05 -0800 (PST)
Received: from localhost.localdomain ([240e:362:42c:4800:8459:4fa0:20cc:1141])
        by smtp.gmail.com with ESMTPSA id c23sm16087162pgc.72.2021.01.18.00.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 01:00:04 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 3/3] PCI: set dma-can-stall for HiSilicon chip
Date:   Mon, 18 Jan 2021 16:58:36 +0800
Message-Id: <1610960316-28935-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
References: <1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org>
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
Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/

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
2.7.4

