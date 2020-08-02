Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0E235781
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHBO0P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHBO0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id q7so37011012ljm.1;
        Sun, 02 Aug 2020 07:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eygfm9r/GaNHVAKMUv8+SfoTHGAl/cjm4d2m8xjT5bc=;
        b=eSAVVT8Se1/eLAu3B/IhsAOSd1uL4wgqqJRwhWt9f3Dyd3dpaBwrC3+1OmcRe5NCwN
         /LvXVROYL5Bo0hA7tPXhlZq+ump5OkwvfbPzJ4myh1+HnaXeslsgi1TYdhELaodHIXKe
         7sKWT/xlOc1oh4CrBye1b37cc3bLWWxVlaaUQodQ9L5KqqDHBduHf4pPbHf/bC5TNArw
         ufhD60tT/DltI3HZ5+94LKa7cge/cGwlOnLs8Jrt9zFkDGPgYzv5lVIDj3cD/jDiFs1Q
         F6mMfsVQQkU5H+qtQiESj5mcd/96jVAhAFlJKa1CNwkj9JY1RAhK3lYfQRipdvE1cdYb
         oImA==
X-Gm-Message-State: AOAM533dVA0usFAolcWTdAmn77vOjDcuUMU4+XpeornmgwfaNcNrr9l0
        wp8omAQ8UmCQ26UBcCCXM1o=
X-Google-Smtp-Source: ABdhPJzSmhttbDUgORpKlM914FzAS2b2KYbghno6w3+rxNJphXxD2jUo/xd+iwrLQer40nK+OI29Pw==
X-Received: by 2002:a05:651c:31b:: with SMTP id a27mr5541281ljp.455.1596378371517;
        Sun, 02 Aug 2020 07:26:11 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:11 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        rfi@lists.rocketboards.org
Subject: [PATCH 05/10] PCI: host-generic: Remove dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:25:57 +0000
Message-Id: <20200802142601.1635926-6-kw@linux.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200802142601.1635926-1-kw@linux.com>
References: <20200802142601.1635926-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

This change is as per suggestion from Coccinelle:

  drivers/pci/controller/pcie-tango.c:277:2-9: line 277 is redundant
  because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-tango.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index 8f640c70f936..d093a8ce4bb1 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -273,10 +273,8 @@ static int tango_pcie_probe(struct platform_device *pdev)
 		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
 
 	virq = platform_get_irq(pdev, 1);
-	if (virq < 0) {
-		dev_err(dev, "Failed to map IRQ\n");
+	if (virq < 0)
 		return virq;
-	}
 
 	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
 	if (!irq_dom) {
-- 
2.27.0

