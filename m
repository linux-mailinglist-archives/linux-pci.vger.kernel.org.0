Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C027A1723
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfH2Kx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:53:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43952 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfH2Kx0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:53:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13so3531469edq.10
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9U83Wx+aV+BXrLCEnw6tHfbtPyYHXQQDbuakWJ5Yrs=;
        b=TPCBbnv0EtvQr7cah0D4UwXKcvUat2BCPYmS3BuVlIcr7/QSvvaHwzWYsJW9wEF2DC
         +1zsa6OPidohM27I18DWhuvVEd7rx8f+eMtVfBR4n9PR8w1nNdll7NfZ/DFoZ1lzrrsY
         ssxq/1FpJNoVR8XrXC/zAf+06Sv7KtRRNEOJBL05UZSRJY2NJ8dHxZ7llkPu/5Fyhm53
         7a6MSt6CMwd4u1rfOA1s9vwymBIRi8TzQyXPIAAdulAWYYKRfsjClppluBpCmmPWwxfz
         m2Yu7VUbOVRTqf54KpPE3S/OvPP8whwUHeAg2cAISE9ZC9Tg36TARwq5MnEmZBsx1wu9
         0LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9U83Wx+aV+BXrLCEnw6tHfbtPyYHXQQDbuakWJ5Yrs=;
        b=mqiisyYjhiTh32aolf4QgvDPF3lAxveAkOtlwf/pug9uQRXQpQLhb5vWVgGRBOvacE
         mp63zTMpnGfTMkstNn9/+qutYxX6GpQtguyPemzBp/Lc9snj4ajj+KuNMoYTFTyUD6UN
         3yIaL/fGoKDpBAIWSA8jO6nSgUz347GOV9+oQEr6bIWovS/yUSai2vBzyr0BhqKhGbAR
         75x3T6Suu92JOAqX/rhWjEGL1cjd14JqIyfhjle2m0OSkYO+kxgwdXz4vES6WQKcQI8n
         S+DxnH3jgxmXNDbQx/x5NlONyPBBAAQ308zhCLNeTMgXVRR9yFcSNENbhzdZ2F7IF58O
         bcEw==
X-Gm-Message-State: APjAAAVmFRTg4+j9Cp1Cc04WmBkgmAZVSEp1nQ8hAbaL+jNNygoxunuw
        WYTFzd4MqMFZVjxD/i1Kovw=
X-Google-Smtp-Source: APXvYqzIJWSVU4BK9v3d0RS9SmMIMLv59V+By0nhPla0CQsXbRwpvRBYdwsPcg1xgT5IKX02CbzYuQ==
X-Received: by 2002:a50:a5dd:: with SMTP id b29mr9142102edc.34.1567076005038;
        Thu, 29 Aug 2019 03:53:25 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id fj15sm329759ejb.78.2019.08.29.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:53:23 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/6] PCI: exynos: Propagate errors for optional PHYs
Date:   Thu, 29 Aug 2019 12:53:15 +0200
Message-Id: <20190829105319.14836-3-thierry.reding@gmail.com>
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

devm_of_phy_get() can fail for a number of reasons besides probe
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
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
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

