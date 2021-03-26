Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4733E34AF3B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 20:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhCZTTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 15:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCZTT2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 15:19:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A4C0613AA;
        Fri, 26 Mar 2021 12:19:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dm8so7553466edb.2;
        Fri, 26 Mar 2021 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/9AAleVmFAMrayfO8gflHwlnHawghg4IbNPiAHidSA=;
        b=BwBmdNMkYjWREZoEW6Qw+pyNmX+4hg+o4WGSPNdGSW0EzAqFPTHSTsEsjj+uuTuzoZ
         5GWuW3AMy3aGoyG+U1a+mB0O1ZSyw7GI3HDnng82EBqU73XwuYOqadvIiPZBKwkbjoaA
         7BLqBrRFOGP4VxorPBbLEy3xdhHIM8wNz+BX8oEumvLEYmgK1MlzLAuwHSGi7wbIlG2i
         2Od8/TXTQKRJ1Naazh+NjXkNBzog88Y7LyYyBif3ZOfFidCd0YfdSow5cxYaxcfLTkhF
         Q3K/KarVpbSVzhqtC9aZd/28a/xGLfBjgGvjfLGl768qDvf6gB2/p4oL6VQlvuEdpcKd
         xfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/9AAleVmFAMrayfO8gflHwlnHawghg4IbNPiAHidSA=;
        b=Ll3TIIyb3+cTyav5N+duey019cLReQSZgDRfCrRUCxlnXbiWgSstwEvZbC5MqyD+z8
         tsjNeQ40N5RiIjeU6m1Wvs38hTiHgW7lYS1j7gfSgXzka4otkWe23j5tq3p9ycq8VO+/
         VE19FqtSUM9LN2m4yHvUYniJLNnkFHN5n/e5ch68VygZNbFtP1N8x6Kq65uzK0wZiiv4
         2JHmY2D41nscMhBDjMp9vIyOhum8jCmWuMl3ua48BUJ5ZxTBpRPF10PCgm/OzU5qkJ+g
         Y0duvPmPY2zI0z+qisBzXjguS8iL2WaJJlDpuAHlDnleH2eQDUkU59LgVOnu/N8TaKwb
         F5jg==
X-Gm-Message-State: AOAM532GdcVjVFbNmJeYUvpdXKrNwHJ/xJbkjgkj56QjJ+MWB4d0lCC8
        04KtsG67ghUOutl6hvpT8Q7lWWaxYYk=
X-Google-Smtp-Source: ABdhPJy4mPNuOgXTUv0iVfS8Og7f8FyOegkBueCSwmhMt50Ur/q5IXlXsgTOR5ipG8s3Cw+/IbYTWg==
X-Received: by 2002:aa7:da04:: with SMTP id r4mr16990098eds.343.1616786366594;
        Fri, 26 Mar 2021 12:19:26 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c19sm4739373edu.20.2021.03.26.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:19:26 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/6] PCI: brcmstb: Check return value of clk_prepare_enable()
Date:   Fri, 26 Mar 2021 15:19:04 -0400
Message-Id: <20210326191906.43567-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326191906.43567-1-jim2101024@gmail.com>
References: <20210326191906.43567-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The check was missing on PCIe resume.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: 8195b7417018 ("PCI: brcmstb: Add suspend and resume pm_ops")
---
 drivers/pci/controller/pcie-brcmstb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 2d9288399014..f6d9d785b301 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1396,7 +1396,9 @@ static int brcm_pcie_resume(struct device *dev)
 	int ret;
 
 	base = pcie->base;
-	clk_prepare_enable(pcie->clk);
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
 
 	ret = brcm_set_regulators(pcie, TURN_ON);
 	if (ret)
@@ -1535,7 +1537,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	ret = brcm_pcie_get_regulators(pcie);
 	if (ret) {
-		dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
+		pcie->num_supplies = 0;
+		if (ret != -EPROBE_DEFER)
+			dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
 		goto fail;
 	}
 
-- 
2.17.1

