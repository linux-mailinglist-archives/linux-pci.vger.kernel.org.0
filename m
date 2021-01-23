Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D813011CC
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 01:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbhAWA7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 19:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAWA7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 19:59:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC5C06174A
        for <linux-pci@vger.kernel.org>; Fri, 22 Jan 2021 16:58:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a12so1911870lfb.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Jan 2021 16:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ncuFXAe0aPkuXVB4zgUHcV5LukUVjJ/gSSZpk8KyCI=;
        b=km2tWbeMu07V3WtG4MkaerY000XrF1c/1khie8U5LGAJq4i9YLUWErJpa8+wxGM14Z
         2kS+swimo5EGamCwbUavQ6W3uwTc3GHKtrkbOtrTY3vIAQarioZol61BOP2uHDl1fd9I
         vSrIgUzGFGPMZ/JnKnYIosb2nEHH8aXcz2kTZ/kGD1D7StUMVtuZg+GjISmnlyRJQX5k
         vKPPRitrqzuMlCAjKInAcr5BbP5oblw70NZ9oSPEYtdjCIYb8RsDTQTQmEqV5U9nt85d
         fbbOFVBVm5OQ8MMlF7ikN6D1xdk6qsZd7FNSE4D1jw23WmW/n9c71ZnJ0oDmevrAsRsZ
         FWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ncuFXAe0aPkuXVB4zgUHcV5LukUVjJ/gSSZpk8KyCI=;
        b=QWYmJnYzLlfBuLVsCR2BhupcTknkH2PoPldE94Yf/5hG1uxrSrvI88TrK5FB4wnVDP
         SIr1YJWv7P6VXUZcqk0tQWNPECaXS0pHPRSR2JGAnRU9LpNvtVU/XAQPOekEWILSlm+/
         EXJA6zF97NorgHZ2AQRNYXOEfQFS5V3iN7Y+M+sd72m6LJKyDnB/G74IQgAKA9Chtw7+
         cPDmWt2Nik+xOImY+mZ2uBAI/LVCYpFYhtvo6DKPQQkds3RwR4OSTxFFxVMDvwWhsS+d
         GZ3wWQ7s0Dh0FqeVz9B2XgSY28Z7v+vstpupSmLgenkbNDXzmndQjCcsvL4jhvF24RjM
         y+sQ==
X-Gm-Message-State: AOAM532bBf+lkym+q07vt9zN826EFLsn9+Ok4a4/GPN03QKt1fNaY+8n
        zEzYCIiXZw11ZZNXsZzQNWQYiZX8glE2yY3m
X-Google-Smtp-Source: ABdhPJyaX9bp4qTzntkpBvUSvMeB1jaukDVsvi/0+br9gJlDaENWGQTWr369J/ERnqX8fEWyqMBY9Q==
X-Received: by 2002:a05:6512:71:: with SMTP id i17mr1296590lfo.517.1611363520585;
        Fri, 22 Jan 2021 16:58:40 -0800 (PST)
Received: from umbar.lan ([188.162.64.145])
        by smtp.gmail.com with ESMTPSA id e10sm1138524ljn.79.2021.01.22.16.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 16:58:39 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: free of node in pci_scan_device's error path
Date:   Sat, 23 Jan 2021 03:58:38 +0300
Message-Id: <20210123005838.3623618-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the pci_scan_device() if pci_setup_device() fails for any reason, the
code will not release device's of_node by calling pci_release_of_node().
Fix that by calling the release function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..be51670572fa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2353,6 +2353,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	pci_set_of_node(dev);
 
 	if (pci_setup_device(dev)) {
+		pci_release_of_node(dev);
 		pci_bus_put(dev->bus);
 		kfree(dev);
 		return NULL;
-- 
2.29.2

