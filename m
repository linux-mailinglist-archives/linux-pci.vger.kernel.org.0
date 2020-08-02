Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7323577C
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHBO0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32920 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHBO0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id v4so27328631ljd.0;
        Sun, 02 Aug 2020 07:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vqz66jFdWkrqKdTPiLpnKqTLTv8a5tORVk+kvNATVNQ=;
        b=UxfOOTS+qGX9ZptYRtFnHWfRoFnuuPGc7opo+ehhRDIAVFcTwwIt+YKPENaTfxJKvA
         fdprMmY/CIqeJ4ERcPATfyCyFRhQA8ehEF5WQGbsWW1ULyN5rEjG4lLZKL2DC5MV7MiY
         /Qf87ZMl7B6APjnpHiHxndiBJrCP0DMthW3pFwDKj8rjlNkOhjlCRZEfz+oWu+bvPJa3
         xOFl2Hrn7g6pREIqFVfXueSx0TAM7uxPZMs5PERMn1nKvutTP0ozAmFXrIMG11sREOFe
         QghPX8j3YwSPza7BZ9pb32jNOMOzQyDQnvisddrJoCzpRE6zyHs4I9O9eOP240PrcKIU
         uhPQ==
X-Gm-Message-State: AOAM533ih2iZLQuF1OwiMqsHoIlvrSt6YxLH4jDywWM/nW5BnYfUjNIr
        xaewBho9whSWuOqe4h7EPoU=
X-Google-Smtp-Source: ABdhPJy4jSVIiW6PUqWFPiMQhKNWAsiM5j0yMAxbx3OUXIJ59hEmi0ME2i3lZ+iAJfoiqC9jsw91kA==
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr4003308ljj.341.1596378369981;
        Sun, 02 Aug 2020 07:26:09 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:09 -0700 (PDT)
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
Subject: [PATCH 04/10] PCI: altera: Remove dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:25:56 +0000
Message-Id: <20200802142601.1635926-5-kw@linux.com>
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

  drivers/pci/controller/pcie-altera.c:717:2-9: line 717 is redundant
  because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-altera.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 24cb1c331058..f6d73d282230 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -713,10 +713,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", pcie->irq);
+	if (pcie->irq < 0)
 		return pcie->irq;
-	}
 
 	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
 	return 0;
-- 
2.27.0

