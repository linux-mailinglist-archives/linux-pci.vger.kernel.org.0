Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94A6A0779
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfH1Qgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 12:36:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45973 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfH1Qgv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 12:36:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so675456eda.12
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmCn7C0sRpOCWgYfI3KtN2oHKFZs45dKwXRqZzCSl9s=;
        b=T2HUOvzjxuJj6Tq8jF+DxOjzEePhRRtX9NGwpDgDfxMBsFFXTRxOEmx5orPLpIhUyB
         76qB2i/n00AEFTE66IeO+ppig4B7/tVTP5HPejafpegR3mveGVvmvjlIUNnKHgTV0LVy
         4AoqwArr8AGg1nWmjhjzvdAKYMhDB3fhOw+38LsPEHw+rlH0OYnfP0iHgMC8JnBjfAAx
         jERJl7eBVTaRyxmbriZXjNinV4SlY5qMSOqEf2FGKIPsj+Rszlm7Os+1w3md/Op23fjY
         LpQNmTEfeAYccrbVdRhzmc3+vLoYGXeXp8T3rQCsUNN5HOA5F4/xNGTRZcHByAv5ofPw
         9wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmCn7C0sRpOCWgYfI3KtN2oHKFZs45dKwXRqZzCSl9s=;
        b=mPpkUGheVecGhikbzpJts7bpODZLVPZjnwIjbn4NfWYf3JoOVyrP4yMvfYB6+68ROv
         CkYCFZHQdoy9CmAZ5y50RKpP8PiXRgyvej2FL2tAUzzWl6QcGlTJe98NXG6j66z5aDes
         yT09bCNw2qUUoUGu6XsL/xr30ZAxIcnD5hbbX7e6NQiNunzgT5grYKY5jRWfVLH5VuqK
         VnPG91CgHMcpHuPuXrPgIhxiSuMjSaJUrR/GmSLnhXp6UtBCHlX2LWfyl2exWpVaPtc6
         ThHUu7snJecJNA4sRWz57qPpc3orDUXsxwlDMlrb1d3ND48ULktw602lsqydCo7/SYyT
         4aEQ==
X-Gm-Message-State: APjAAAX4yVFfWL56BaItwcd8PwQ8RRdCzk03BzKzKPUfKPtTV4zX2vhZ
        Cwf1j+xjCAJuuVtOW1mvhC0=
X-Google-Smtp-Source: APXvYqzIf/XzwZtwNInsuJj1oavENaEWpR+UcoyCyExiTc1SnDuw/QyRfNS5Azoz94f0BkC55Ba91w==
X-Received: by 2002:a50:f419:: with SMTP id r25mr5014817edm.57.1567010209371;
        Wed, 28 Aug 2019 09:36:49 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id nn19sm449978ejb.12.2019.08.28.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 09:36:48 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Date:   Wed, 28 Aug 2019 18:36:36 +0200
Message-Id: <20190828163636.12967-5-thierry.reding@gmail.com>
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

devm_phy_get() can fail for a number of resides besides probe deferral.
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

