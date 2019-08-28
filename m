Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C9A0777
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1Qgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 12:36:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41153 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfH1Qgq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 12:36:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id w5so705704edl.8
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QAm45dwRpgNZHPTIYO73+t7h3+jOQOBkntawCm9BvA=;
        b=iWol2RYS8jelw/ICPnbRo6g4y1QvZ9vX5gnal01GMaax0C78rCWmNvVTL8JovKVrXh
         WBqy71YyUGdv5KtCoEbSuISoUgVKyey8RMZJ8ZijJ4AdzNczE50g2XKsR8oy7ZJ0m9F+
         0L/puxcLNFVR9s1v2WeJPPKPIaL/nN0fptSJnL6UJ7NVBE4czdYZrj8lszW4HufyST8W
         +qbCEuJ0gi1PMps0OUbhhLXwnsHdw68U3Qq7c88iMlPLjS0OYJYhyLQie81scPx88e8l
         t5qEVihqGh1hSg106+BzjEN3MjAP/pxJGVS3TSYP9ooATjRDmgpHLMEczfsCwanp1Uh/
         8HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QAm45dwRpgNZHPTIYO73+t7h3+jOQOBkntawCm9BvA=;
        b=g0JXIeeH3McOV5E/stJUBIV9I2CfSN4Nt2FMgL8ypRixjJC7jKSRe30452C9/MCRR8
         pgnlAXBra2YJDCfYUG09BeQt8UBwLm9ebU+jPLY3/I266NMF7qQPZT+yjJFIJfLBlVB2
         rUnaSFJoPT44pOLun0AL41hBVwa2d+AZ/yHlsxL6FPXdGNF/VTBl2G8kQOB1Z+eThn+G
         327c91SXmM0itIcbjXFo/cAir+5uEJXMJ72o8kIkAgznJ4Mu8hto2hlHIUwLUBK3+ecX
         KCGamHWTDUDFuQ9AK4r9HMD8jR1LZafGja/QeMEAh/4gZlJg6249h/pRbckb4FGvWIDg
         +5vg==
X-Gm-Message-State: APjAAAWa19B3wkirA30OwnDihWPwRm1SVa80SfvEn6/2P2oxkPHnKjBC
        oFW/zTkWVWmRjt4n2rDiEGiRBcvB
X-Google-Smtp-Source: APXvYqwkyUVT0wctKrL5oM5DbaEwHtvxTCTiOdry6IqfPIChLG6u1LAAF4L+9nIrBJ6UYwFsgM4J5A==
X-Received: by 2002:a50:89b4:: with SMTP id g49mr5026146edg.39.1567010204583;
        Wed, 28 Aug 2019 09:36:44 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id l6sm548646edr.56.2019.08.28.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 09:36:42 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 3/5] PCI: armada8x: Properly handle optional PHYs
Date:   Wed, 28 Aug 2019 18:36:34 +0200
Message-Id: <20190828163636.12967-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828163636.12967-1-thierry.reding@gmail.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

devm_of_phy_get_by_index() can fail for a number of resides besides
probe deferral. It can for example return -ENOMEM if it runs out of
memory as it tries to allocate devres structures. Propagating only
-EPROBE_DEFER is problematic because it results in these legitimately
fatal errors being treated as "PHY not specified in DT".

What we really want is to ignore the optional PHYs only if they have not
been specified in DT. devm_of_phy_get_by_index() returns -ENODEV in this
case, so that's the special case that we need to handle. So we propagate
all errors, except -ENODEV, so that real failures will still cause the
driver to fail probe.

Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 3d55dc78d999..49596547e8c2 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -118,11 +118,10 @@ static int armada8k_pcie_setup_phys(struct armada8k_pcie *pcie)
 
 	for (i = 0; i < ARMADA8K_PCIE_MAX_LANES; i++) {
 		pcie->phy[i] = devm_of_phy_get_by_index(dev, node, i);
-		if (IS_ERR(pcie->phy[i]) &&
-		    (PTR_ERR(pcie->phy[i]) == -EPROBE_DEFER))
-			return PTR_ERR(pcie->phy[i]);
-
 		if (IS_ERR(pcie->phy[i])) {
+			if (PTR_ERR(pcie->phy[i]) != -ENODEV)
+				return PTR_ERR(pcie->phy[i]);
+
 			pcie->phy[i] = NULL;
 			continue;
 		}
-- 
2.22.0

