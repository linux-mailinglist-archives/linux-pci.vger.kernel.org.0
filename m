Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9CF23AF46
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgHCVCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33153 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHCVCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:22 -0400
Received: by mail-io1-f65.google.com with SMTP id g14so2509436iom.0;
        Mon, 03 Aug 2020 14:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEN9vVsE3mU2Nyqo3uVsRwOE6mBebuJzlr8xG6a6d4M=;
        b=gvlZ85rNLI4mgSE7YxG4Q0KiemuST2J48lyVHCiY+PD/HkVNhJJeVF9iNU9j+8IQmA
         m7RZlm8jqvU/xvqtd9qXD3jCxIEGFPXJ215cUFJZfmk7q85O+SWGeLcYhRozUKOQB20E
         3lypsIO/PIMIq6wFTTqsMH8smaBVIeAccdeOcp1p34QjkYuYMDjxMW/QhzyQ/aFpV+zs
         BcIdQWmrsFL08Tj8HKJ5T9IntAeb0VAgtM72j92rAc0ek4lZBlfUIR4zVOJT0xudrgrI
         ggu+PN1ng44B7cXiAICRF/sdUdyK8LwW5IllpxmaZ/yMl3XwfymoyW80U2tB3qWjQViJ
         6Fow==
X-Gm-Message-State: AOAM532rDbMpmjaGbpD+D13MkBENq9zkSYqmBgywDILaw+rD5kp1SKuA
        HVVY1x77VoWi1WEwiT7ong==
X-Google-Smtp-Source: ABdhPJzc5blExyVY0xBSjialU7rbyHIo6WdVKug3iv8C/bQYaB+qRckTphLyP0HPoPp/7SDACilwzg==
X-Received: by 2002:a02:a584:: with SMTP id b4mr1758886jam.68.1596488541762;
        Mon, 03 Aug 2020 14:02:21 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 23/27] PCI: dwc/meson: Drop unnecessary RC config space initialization
Date:   Mon,  3 Aug 2020 15:01:12 -0600
Message-Id: <20200803210116.3132633-24-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The common Designware init already initializes the RC PCI_COMMAND, BAR0
and BAR1 registers.

The only difference here is the common code sets SERR. If clearing SERR
is what's desired, then the Meson driver should do that instead.

Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index cbde683d107f..d1cfc65f0a69 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -34,15 +34,6 @@
 #define NUM_OF_LANES_X1			BIT(8)
 #define DIRECT_SPEED_CHANGE		BIT(17)
 
-#define TYPE1_HDR_OFFSET		0x0
-#define PCIE_STATUS_COMMAND		(TYPE1_HDR_OFFSET + 0x04)
-#define PCI_IO_EN			BIT(0)
-#define PCI_MEM_SPACE_EN		BIT(1)
-#define PCI_BUS_MASTER_EN		BIT(2)
-
-#define PCIE_BASE_ADDR0			(TYPE1_HDR_OFFSET + 0x10)
-#define PCIE_BASE_ADDR1			(TYPE1_HDR_OFFSET + 0x14)
-
 #define PCIE_CAP_OFFSET			0x70
 #define PCIE_DEV_CTRL_DEV_STUS		(PCIE_CAP_OFFSET + 0x08)
 #define PCIE_CAP_MAX_PAYLOAD_MASK	GENMASK(7, 5)
@@ -303,9 +294,6 @@ static void meson_pcie_init_dw(struct meson_pcie *mp)
 	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
 	val |= NUM_OF_LANES_X1 | DIRECT_SPEED_CHANGE;
 	meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
-
-	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR0);
-	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR1);
 }
 
 static int meson_size_to_payload(struct meson_pcie *mp, int size)
@@ -353,13 +341,6 @@ static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
 }
 
-static inline void meson_enable_memory_space(struct meson_pcie *mp)
-{
-	/* Set the RC Bus Master, Memory Space and I/O Space enables */
-	meson_elb_writel(mp, PCI_IO_EN | PCI_MEM_SPACE_EN | PCI_BUS_MASTER_EN,
-			 PCIE_STATUS_COMMAND);
-}
-
 static int meson_pcie_establish_link(struct meson_pcie *mp)
 {
 	struct dw_pcie *pci = &mp->pci;
@@ -370,7 +351,6 @@ static int meson_pcie_establish_link(struct meson_pcie *mp)
 	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
 
 	dw_pcie_setup_rc(pp);
-	meson_enable_memory_space(mp);
 
 	meson_pcie_assert_reset(mp);
 
-- 
2.25.1

