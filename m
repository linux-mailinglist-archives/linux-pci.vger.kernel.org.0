Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E496F23578A
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHBO0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36598 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHBO0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id t23so13489867ljc.3;
        Sun, 02 Aug 2020 07:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KctYFubeJoKLzzl613htWFeciTcF38lRZu1u0/Rl6M8=;
        b=WMnX3StBXk0A385Fs91TCvyVYNkZBXgGHm3Od9KmxYf6SImLlbA3zbi8k+iWtgaLpF
         F6JkHHltSjl7Q/0W8jQGPY7eZrUplR2GNtr/W8vBTcLELFTsWXFYRvowzPTkYJxkiYdr
         7Yt2Yw+1PpN4EEkR013Xid8sryO0OkI0WieVuIhMnYII2jKGMr9AWKogXNZ3cYpH85tV
         TBE/tjb6g9EWStYD6SFeGWEfqqoY0RDdn8kPnRphmRBd4dMKr0G9Z7sm9LsUIyjxJM0z
         EBG6E0JWi7I77uaN/qp+Ar8orj0U7woAd2Duh709EAaIujC7X3kFuD5zsYt3hZ1Jxb/Y
         SQiQ==
X-Gm-Message-State: AOAM531xcjEKPvz/7g0JDDguwgjj87kq6M8Kb6J56n0PLC6QeXZtZD/v
        erxxFvLJcLxfzPiaD2gL+Oo=
X-Google-Smtp-Source: ABdhPJzMcdshNqp2FVaeIW1qGszgg8tWQnvrwe+GCIZdRiYp+tWne0ejZ4gesGSqeO7GvTac2I4drw==
X-Received: by 2002:a2e:9e89:: with SMTP id f9mr5229933ljk.212.1596378376233;
        Sun, 02 Aug 2020 07:26:16 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:15 -0700 (PDT)
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
Subject: [PATCH 08/10] PCI: xgene-msi: Remove dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:26:00 +0000
Message-Id: <20200802142601.1635926-9-kw@linux.com>
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

  drivers/pci/controller/pci-xgene-msi.c:481:3-10: line 481 is redundant
  because platform_get_irq() already prints an error

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-xgene-msi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index f4c02da84e59..02271c6d17a1 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -478,8 +478,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
 		virt_msir = platform_get_irq(pdev, irq_index);
 		if (virt_msir < 0) {
-			dev_err(&pdev->dev, "Cannot translate IRQ index %d\n",
-				irq_index);
 			rc = virt_msir;
 			goto error;
 		}
-- 
2.27.0

