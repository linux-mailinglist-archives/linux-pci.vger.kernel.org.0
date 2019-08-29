Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69960A1727
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfH2Kxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:53:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36342 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfH2Kxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:53:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id g24so3584495edu.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObPUGXaeMQTZHC5rRNant5HT8Wtg0VFfd8Aoph2s9Qs=;
        b=WB2L5GrcmTSUB4RE6Q1seT7kW7N8Zojp5t4Bee1J6E8h3m1rXp11rrLHE3Mn5fZsXx
         JLDcZJPcGXbqPi7mT1alZiusFe1MpNWrOdiRGyGQuK4E92VA9cbR4ssUrI1g+pxoeLfs
         DnhraV051aa43X+92bapbpOiLQ4yvCsKBp9rRZb+hvpIOqSFOylqGfhb5NEhNfN4CaKX
         NAha8z6LbefNBw9F7sxkJsF/1vFk3JkcEfm5pI47VA4fyLwmESIDIVV+jXJOMYqOKsuC
         AvtehZoLE6kuS7ElTIjzWM0VPyQIzMj33IE5uVvONNaDCoME56QmlyP9PFMaKG3YEVd+
         iHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObPUGXaeMQTZHC5rRNant5HT8Wtg0VFfd8Aoph2s9Qs=;
        b=phH1GbF3J3VA13mcdqFZNS6g4xYXR8SlFXkr93VHrYJRgKkf2qDcdSFlqlm+kTwPQf
         yji+zI0Y7p/PhAX5HwPQhOA2OimbGZiDpurNYKxAHo6Lec8bDhmAV+oYvhwO4SBhravk
         r73IQEdu2+xN63bLaOV86xO/d6j+39STTN4VsaeuUaONPMGfZjLTQoE7ClZfbA/oovNy
         +Z45OUGnETOHQb0afUSSLkrvFnIEAHYlYMdcMnYoZ0kd5fPJ9xIViF1nf6HC11s4YC92
         1eePRuUoA2PUymR82zjHnFDjlmBO8ACX2z+0qc7IpmfYJMiG6q77dyTpswrJVzyWY9tH
         vd/w==
X-Gm-Message-State: APjAAAUzas/6ZHaCWyrVASdh0OKvbZzeytK7t9T5mLTaXGRBeZXMNq/s
        EJMdFPPBtV2Gs90zwc4ZCQoI6gkt
X-Google-Smtp-Source: APXvYqw3lE9siz+dSNWer9gb2ctybKgOQYARhAwiZw1vGGCEC/9JRHqTtJm5DeV5K91Pt5SDhOcTwQ==
X-Received: by 2002:a05:6402:785:: with SMTP id d5mr8915763edy.210.1567076012295;
        Thu, 29 Aug 2019 03:53:32 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id q10sm328918ejt.54.2019.08.29.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:53:31 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 6/6] PCI: iproc: Propagate errors for optional PHYs
Date:   Thu, 29 Aug 2019 12:53:19 +0200
Message-Id: <20190829105319.14836-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829105319.14836-1-thierry.reding@gmail.com>
References: <20190829105319.14836-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

devm_phy_get() can fail for a number of reasons besides probe deferral.
It can for example return -ENOMEM if it runs out of memory as it tries
to allocate devres structures. Propagating only -EPROBE_DEFER is
problematic because it results in these legitimately fatal errors being
treated as "PHY not specified in DT".

What we really want is to ignore the optional PHYs only if they have not
been specified in DT. devm_phy_optional_get() is a function that exactly
does what's required here, so use that instead.

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/pcie-iproc-platform.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 5a3550b6bb29..9ee6200a66f4 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -93,12 +93,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	pcie->need_ib_cfg = of_property_read_bool(np, "dma-ranges");
 
 	/* PHY use is optional */
-	pcie->phy = devm_phy_get(dev, "pcie-phy");
-	if (IS_ERR(pcie->phy)) {
-		if (PTR_ERR(pcie->phy) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		pcie->phy = NULL;
-	}
+	pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
+	if (IS_ERR(pcie->phy))
+		return PTR_ERR(pcie->phy);
 
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
 						    &iobase);
-- 
2.22.0

