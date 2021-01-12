Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450CD2F288E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 07:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbhALGvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 01:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389829AbhALGvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 01:51:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67DC061575
        for <linux-pci@vger.kernel.org>; Mon, 11 Jan 2021 22:50:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c13so801816pfi.12
        for <linux-pci@vger.kernel.org>; Mon, 11 Jan 2021 22:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0LpfnVqBhlTSQc8coWf/BWdwkFkHOaWAvkHfo4IkRxg=;
        b=ZWfhGNoYLjyL44s6mcZku7VmXFzPU/vGYDrtL7nkAQdQZIYF4mc75ZJ0jVb5EZZX6w
         JqwwzmQZTjJq6lGXhkzlucVN268z0iEP1kFfCLltlYy7ec165ZlbpjT+eUDZYrCNcb1k
         65NpCwY1M+73pQ1ovUwnN0RFxCDpvjGy84BkvTYM2klBpQNV8Kk5eEAOxaRJZ9OUawo8
         WxjgQ+24a8KO0Fo0zDHR8lTJHSoz+WBhbuB8x8lI04d0Ii2mmIRBWCg70W6KaeP+KaI2
         iQQnoYF/Opvq+Z5qrM4xykgNxa5WG+AhuJxxyDq0QVdc4AAStJS7VmTJVJCnRUxa+sGP
         1hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0LpfnVqBhlTSQc8coWf/BWdwkFkHOaWAvkHfo4IkRxg=;
        b=bXlnEP1T0FWFJw9IW4euk7KYhbP41nwzJ5Gh5NqYSkMmTPXaOKE8pxN8rBWU5WCz4r
         kVxugBjQkW5fJ7bd7pKHrxLkgN2gypSbHC4fUSLNC+Yz1550ezLldwyrYrbDpYhmHiyg
         e5IWYkGw20WJAvdIRqZ2DqgPxhhf2EzijoBsh08A87sj5jL600JslpEn7sjD2CfklDKh
         w/wJo9BlbQA2rGE16wRkoLn1noCNh+gcubipjiEuLx2D7L3qXPqfD4qOTptpHR0ROxYx
         CIUZMthGDyKWCHsVhMfvSYqOGxGcuY5qt0lIhmL9/deQJN+Tsqeqxa/8RY+TqF54l1I0
         utPw==
X-Gm-Message-State: AOAM531M48DNQk+gHO2TA4ACRe3tJRD3Ix1tu/3jaT7tJvjjYmXuJQOI
        X6SDOcjiWmFZx2k/pi5N9P39sg==
X-Google-Smtp-Source: ABdhPJybNSD8Wu3FkdO87FGU8ikSSbFKabIlzum60C2GKv/47RjJDNCYTwCrDfa5KUsnTdtdfJkhbw==
X-Received: by 2002:a62:aa08:0:b029:1a9:bd0e:260b with SMTP id e8-20020a62aa080000b02901a9bd0e260bmr3481475pff.74.1610434241133;
        Mon, 11 Jan 2021 22:50:41 -0800 (PST)
Received: from localhost.localdomain ([240e:362:4bf:e00:19ba:7333:19c1:ecbe])
        by smtp.gmail.com with ESMTPSA id a5sm2109876pgl.41.2021.01.11.22.50.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 22:50:40 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] PCI: Add a quirk to enable SVA for HiSilicon chip
Date:   Tue, 12 Jan 2021 14:49:52 +0800
Message-Id: <1610434192-27995-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20201217203806.GA20785@bjorn-Precision-5520>
References: <20201217203806.GA20785@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices can not support tlp
and have to enable SMMU stall mode to use the SVA feature.

Add a quirk to set dma-can-stall property and enable tlp for these devices.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/

drivers/pci/quirks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e..a27f327 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1825,6 +1825,31 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
 
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
 
+static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
+{
+	struct property_entry properties[] = {
+		PROPERTY_ENTRY_BOOL("dma-can-stall"),
+		{},
+	};
+
+	if ((pdev->revision != 0x21) && (pdev->revision != 0x30))
+		return;
+
+	pdev->eetlp_prefix_path = 1;
+
+	/* Device-tree can set the stall property */
+	if (!pdev->dev.of_node &&
+	    device_add_properties(&pdev->dev, properties))
+		pci_warn(pdev, "could not add stall property");
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
+
 /*
  * It's possible for the MSI to get corrupted if SHPC and ACPI are used
  * together on certain PXH-based systems.
-- 
2.7.4

