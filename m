Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45208A0775
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1Qgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 12:36:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40922 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfH1Qgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 12:36:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id h8so719706edv.7
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RsKnTqZhiTnUNPCrQwtT99WQodGr2SwrsXfj7oMbBZo=;
        b=kBdBg7p1h/Iic/OopZYem59dY9R8T1EQCnI3GIiIiMs+iCE6wi4freEngg7BO14F95
         QWlGJvu6lz8doDCNxDDD6XvM8A3yuEuLMY0i5Csabmyxv5YFDb6UskoCS/GphZrpKVDr
         a3Weio0pzD9YBMePTyiUIdOU5H9SGM/SWAkvVmuthkATL9hVYlKx0EGLgmPzzsHEVKl6
         6b9lwahRebXEvTup/g6ssgBmaljLggxALrjWwClEmXOUvrS6CcNVWxZG+jRlUT/phnmr
         qa5t40ctNs1QQvTfuDRdWciY03KTYmSoLU/SaBw0MCPqEuIYkLvUxayclSeXTVxkWxmc
         /drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RsKnTqZhiTnUNPCrQwtT99WQodGr2SwrsXfj7oMbBZo=;
        b=XKF83jU48+hXq6fi2kRi3cKYvw/n3tZl/uyPflikPSaf8dqVPQxZDWK2I89altOjK7
         dBC7VtNjf1V7lb1hAJPDy5fyvpPB7QErUOut19cvcEgEbfBUii/gKO+sXua13RvejM2Q
         0jD3vaNdaH1o74dFu/E9TuV4jhtUjYIYh8ttpoixIoC70qt+6rPEReR5FyljEWupjEps
         bU2uPZmBClAC30gMYumEDYSpVnX1F9+b+LsfL3o/z/c/CwmJPd5Cy6uJ8GRQC09iU8OI
         sMCaTAjTNSeCN5DFb+jIv3ov156yLJxwK6HEZaApnrAQx48j8TVQC1Zf01X/U3opALz4
         fWmA==
X-Gm-Message-State: APjAAAU1oxUTPvVaXeiqJb1N4o0JHo7n2cJm/Y9PMyBTq9jMntxjuUTM
        b2gdcf6CZowu5oYrp6WO0Bs=
X-Google-Smtp-Source: APXvYqxlLlMuoJcGHsVLpw6kO5euhv8jxFKJv08Am5RitAHTN6IJ32sBDym4YIp+kMafUNlOCzzaSQ==
X-Received: by 2002:a17:906:3187:: with SMTP id 7mr232363ejy.238.1567010199277;
        Wed, 28 Aug 2019 09:36:39 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id w14sm545880edf.7.2019.08.28.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 09:36:37 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] PCI: exynos: Properly handle optional PHYs
Date:   Wed, 28 Aug 2019 18:36:32 +0200
Message-Id: <20190828163636.12967-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

devm_of_phy_get() can fail for a number of resides besides probe
deferral. It can for example return -ENOMEM if it runs out of memory as
it tries to allocate devres structures. Propagating only -EPROBE_DEFER
is problematic because it results in these legitimately fatal errors
being treated as "PHY not specified in DT".

What we really want is to ignore the optional PHYs only if they have not
been specified in DT. devm_of_phy_get() returns -ENODEV in this case, so
that's the special case that we need to handle. So we propagate all
errors, except -ENODEV, so that real failures will still cause the
driver to fail probe.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index cee5f2f590e2..14a6ba4067fb 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -465,7 +465,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 
 	ep->phy = devm_of_phy_get(dev, np, NULL);
 	if (IS_ERR(ep->phy)) {
-		if (PTR_ERR(ep->phy) == -EPROBE_DEFER)
+		if (PTR_ERR(ep->phy) != -ENODEV)
 			return PTR_ERR(ep->phy);
 
 		ep->phy = NULL;
-- 
2.22.0

