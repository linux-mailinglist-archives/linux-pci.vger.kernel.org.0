Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36828A171E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfH2KxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:53:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43948 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfH2KxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:53:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13so3531370edq.10
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CrKI9MhQzT9WqpEbXKyv6DhjyLfjSiz4qRQN1f/whw=;
        b=DgTNRg87AQs/Ut2ARsvMwMQBNk7BXUVzcYL46IiYCDqUP/CeYWME6luaR3oDragNfK
         toUZVDuX453YpYlJ8isTdax4cJbJ8bcjJJjt48fQ7i/WyQAo83gdrg8+v80XAC2qi0ZS
         6srgHUKllQ0m7K214wVdDQCyw8VN9/BOl6Z52PN8+nvsyCJeZV7Z4qNScHdtQBwjHCUX
         m+ddGqTXKHXK7h9s/eVE+mAFYpA4fE0lxAiajY0rLhbmzmVnnaM9QB1xF7mStxI1oBO1
         j0yM96oSboyFcVp3L38Of0+c0TtAEgjvfEuVlMx7jU61UoRStU2SuSpAD9xWB9W6kdg0
         OBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CrKI9MhQzT9WqpEbXKyv6DhjyLfjSiz4qRQN1f/whw=;
        b=TqO5wERAoFCunQhD8u1trN622aKE/TExDPDxdHwi3E3nWn3OXtAk+qwejok8EcfNxq
         msXb7YC6DYAo8PshIoXdzaS+4XjPA88uCVwQyNp8051F1xFTiJWSFbEdiomJBW2BXycp
         4Lyx85Wdo1qh5KKAv/vxFD8Wu4pVg8v2NYkDP0MdGiKw5yCPJypGdoHA97BEDS4GvqHM
         lkPc1iDnvwea2E4SHVItY11h2DL/82GJch0zGjncamFWIzHGK3fhiQqfBMZ6nXFCWODP
         nIsiwkQLcE7Sf7oSv47LW5l912IQF/HypCqtOZELyAySduXlynPBhzQuGmN/OfUVo4zt
         Pxog==
X-Gm-Message-State: APjAAAVYYZh17MmH/3W+SsRgcmCTCZjmvWOBn7cE13I6uXzBeQpt0HhS
        2lKiqLuF/TWtFxYx2LFcPsQ=
X-Google-Smtp-Source: APXvYqyx/qJcgDZlIemQldwVnqLbbL+15wOWsgThaZHYnBCzryHVbown85YrmhjWLdJrNRbBMIx74w==
X-Received: by 2002:a17:906:3518:: with SMTP id r24mr7473430eja.133.1567076002754;
        Thu, 29 Aug 2019 03:53:22 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id j2sm331094ejj.34.2019.08.29.03.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:53:21 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 1/6] PCI: rockchip: Propagate errors for optional regulators
Date:   Thu, 29 Aug 2019 12:53:14 +0200
Message-Id: <20190829105319.14836-2-thierry.reding@gmail.com>
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

regulator_get_optional() can fail for a number of reasons besides probe
deferral. It can for example return -ENOMEM if it runs out of memory as
it tries to allocate data structures. Propagating only -EPROBE_DEFER is
problematic because it results in these legitimately fatal errors being
treated as "regulator not specified in DT".

What we really want is to ignore the optional regulators only if they
have not been specified in DT. regulator_get_optional() returns -ENODEV
in this case, so that's the special case that we need to handle. So we
propagate all errors, except -ENODEV, so that real failures will still
cause the driver to fail probe.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 8d20f1793a61..ef8e677ce9d1 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -608,29 +608,29 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 
 	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
 	if (IS_ERR(rockchip->vpcie12v)) {
-		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie12v);
 		dev_info(dev, "no vpcie12v regulator found\n");
 	}
 
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(rockchip->vpcie3v3)) {
-		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie3v3);
 		dev_info(dev, "no vpcie3v3 regulator found\n");
 	}
 
 	rockchip->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
 	if (IS_ERR(rockchip->vpcie1v8)) {
-		if (PTR_ERR(rockchip->vpcie1v8) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie1v8) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie1v8);
 		dev_info(dev, "no vpcie1v8 regulator found\n");
 	}
 
 	rockchip->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
 	if (IS_ERR(rockchip->vpcie0v9)) {
-		if (PTR_ERR(rockchip->vpcie0v9) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(rockchip->vpcie0v9) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie0v9);
 		dev_info(dev, "no vpcie0v9 regulator found\n");
 	}
 
-- 
2.22.0

