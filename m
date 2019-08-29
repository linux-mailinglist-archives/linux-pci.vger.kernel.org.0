Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83594A1725
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfH2Kxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 06:53:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42791 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfH2Kx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 06:53:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id m44so3538553edd.9
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g75H9RnPVD+oDePSadmENs2ts1AD7BPbSlroHbXgt0U=;
        b=MzdQXSayVWhJxTWNSXMnv5SJhh7z0p7v3S1mO6Jt1LsCg9fa9QM22/PSdrP8slBQHh
         2HLDbT9iC5VsObzD8GCyLuMjTlcTl4OjEOnnSXkueanIHNnf320HwBf/SvJ83sSTHQVc
         CPV/kkl5FgNg35JJM6zBPTY3+9zkxPBtEiVDE+MWg+baUavJIvd+Rx3BJ8mk58D3FAFC
         fmo2jVM8Nxq828z6NtGSPYkcl34DzzB+i3q/47GKr98440PVih6HhSj92WWZCFCcrNC5
         xlfrCB/TD28Jr2HP2T/Ua4eqq4/aRzUxRYVqx6iAdRp8tsxje/wCZHDh8uqT289AmSFQ
         ySbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g75H9RnPVD+oDePSadmENs2ts1AD7BPbSlroHbXgt0U=;
        b=F1jKOpTjrZIuGLvrbYeha8O7RntTahGJiYNsBo11JS5RqmVZaNeeqU+6oO4VY20tZ3
         tG1AwAI7iLjdGxW4gQqMubh/IRGR6GXXoWorIpQQ5LyR9/Sq7OncgOddmgUr6Seo4Hd2
         egEOdymkvrktzuXCSNdgtopvtR6UAcC1B9u9XT/BUJ9IoSwZrh5CvRAvmxoPX8ymxa6q
         BG0jHbdSz+7zYFtKClwSgjqN9Il+oHueVJUOilWr8dQL0AoTMYiNkcFeMMDMl40RGffZ
         wMj6TPJjbC9o5fNisdoy6doo2/6oMp3Z5ZRaqNf9ngcIQj0LPUbNacEEDpfTRrleJv10
         zTUg==
X-Gm-Message-State: APjAAAXYK/+fhB82nrS87c1aaPtnUZh/EkNyoxsfEwg3ztAdN3D8e+2f
        1qavTBgChuZ/bHADS28NBns=
X-Google-Smtp-Source: APXvYqyK2Wjn3+k4B99F4fjh31BFPB7esUAdaCDhTvsr/3jXzXxCmjTq/KHMLgjy0ozsjfu5ufX1eQ==
X-Received: by 2002:a50:ed08:: with SMTP id j8mr2513340eds.3.1567076006809;
        Thu, 29 Aug 2019 03:53:26 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id y30sm373302edi.95.2019.08.29.03.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:53:25 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 3/6] PCI: imx6: Propagate errors for optional regulators
Date:   Thu, 29 Aug 2019 12:53:16 +0200
Message-Id: <20190829105319.14836-4-thierry.reding@gmail.com>
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

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de
Cc: linux-imx@nxp.com
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8b8efa3063f5..acfbd34032a8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1174,8 +1174,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx6_pcie->vpcie)) {
-		if (PTR_ERR(imx6_pcie->vpcie) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
+			return PTR_ERR(imx6_pcie->vpcie);
 		imx6_pcie->vpcie = NULL;
 	}
 
-- 
2.22.0

