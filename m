Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0967301F96
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 00:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbhAXX3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 18:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbhAXX3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jan 2021 18:29:13 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96EDC061573
        for <linux-pci@vger.kernel.org>; Sun, 24 Jan 2021 15:28:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so13105019ljo.13
        for <linux-pci@vger.kernel.org>; Sun, 24 Jan 2021 15:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruMNViRIcar6u3gv3qlcn2+tM7+wPe4+R71bK+/E4Bw=;
        b=nuCceln9+2omIg5vzCu5ivFi29qZx1Tj1rOmvcgMke+i9Ftzw+R2z325fhMsrR5d5I
         Nx7htn3a4/ZXovjULRzA4R2T2jU+ozq1jQm02nGy3sZoVpGSputYuJlhOwAVFWMiANwY
         +IXa29lhxH7PyMuXRzaHLgpdVdWTxpItP3dP0NOJCEHyOyffA8lqGnsVnjcGYunIP+nm
         sGwPnIJrWXMyP4qIn+XMaC0e9l5L0oQKd88aVakUGob+iP4rv9AwhdR+qgLK4VLkf4vX
         BxXYktgtbT6PURS7DydG10tc5Ha1Ls1SW/B6dR0hFNcW3y56oqek/vSJdlN4mkOoNE2E
         TAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruMNViRIcar6u3gv3qlcn2+tM7+wPe4+R71bK+/E4Bw=;
        b=c0R/V8ozmqTMtQZtg0A49qpzFGOb28b2PPuPlf9tHgh+hy61OV6/gv7k2keEnabbk1
         3oDWs7yOdhqEj+qJgvQW9eTKfAGN0/6Jwrhvy53sap8SYfnc3aDdwNov/YD9dkJ+rY9p
         ckiK2PFBiX/TS5RBpw0JDCnfeq0R2/n6vaSkq0C1HITMUC63Ya3eI7JxWM4AZINsb/qh
         7uOEM5yIWoqXFHRXXMgwmwoKph9UFWV50VVHSIwMU5+y/z8yMpkvnu4MsYsS6/twV2rh
         9NG8Bhifv8+H9p7Qgwdy8zqN9+/n0q3KK0srZIfl4Ye9vK/Q/geShnIWm+1WLn4o7zle
         SxKA==
X-Gm-Message-State: AOAM532qwfBSL7abhTZXHwB82B0BOQq5CGvF2a/9lZr+9M1scL+LnKtR
        Q5Yd6EwAeC8UIH92RUGTYc3LvA==
X-Google-Smtp-Source: ABdhPJxfzn7VB5v37cFuLT8Sqbfe6RCqd3rA1LGL+yj7pDKraEAYOTjo4IcWA9IcDrHnvx/PF9353A==
X-Received: by 2002:a2e:98ca:: with SMTP id s10mr2373266ljj.283.1611530911112;
        Sun, 24 Jan 2021 15:28:31 -0800 (PST)
Received: from umbar.lan ([188.162.64.188])
        by smtp.gmail.com with ESMTPSA id y3sm1715065ljy.98.2021.01.24.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 15:28:30 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: free of node in pci_scan_device's error path
Date:   Mon, 25 Jan 2021 02:28:26 +0300
Message-Id: <20210124232826.1879-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the pci_scan_device() if pci_setup_device() fails for any reason, the
code will not release device's of_node by calling pci_release_of_node().
Fix that by calling the release function.

Fixes: 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

Changes since v1:
 - Changed the order of Fixes and S-o-B tags.

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

