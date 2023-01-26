Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7DB67CCC1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 14:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAZNxD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 08:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjAZNwv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 08:52:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BCB561B2;
        Thu, 26 Jan 2023 05:52:37 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m12so1911526edq.5;
        Thu, 26 Jan 2023 05:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM5Y0kazrqAopyAd14Bg1D8C86SLWnGba3pwWureGTo=;
        b=qfPFLRS+a5cbguePUixRS979CRQ5NY7AVPXDzmN02A76rymCD1Sf/wEC5SDE3e7Spm
         XNBqCtXGmmPI1eZKPsBuLjWztNmxqM23awGKKM3J3sNvWWfBUkO2ISF/L/8tpZztNWe6
         qqbpNYC46Me2h85qbAtEUaX1MQYC+k4eA219ccrBJftptBQgJtdEXRS4cH8YPwiQvnoR
         lFVLG9vywJxOq7sW+7mUBf/yQHxSCom938Zi79of7CHFvzlzQ9QvxaNiqlP5T2/XtoTc
         u48DlO4MoWDAWWaJK/Jx1o8sZc3V9NWqhb4Gux/9U/HB9YTdMZCdAheJR7dOC0CYQlKA
         aefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM5Y0kazrqAopyAd14Bg1D8C86SLWnGba3pwWureGTo=;
        b=1/OyZ2nbocrbGa/tTJFUuGXZ4x84EukJ4DC7XY9znMlwpsTw7wF38S2jlUjcHlt4f8
         s0k43C7MLRbu4ZtwzQBK4JEeP+1G3IT4aRefZsNNtqo1XVkKq/PvSapicWt5VrhvezE3
         R/c/mx/zvGf5M2l480/sYOowIRRpg5AOnaag9byjPbJxshcjm+PKk8ilA7WptyKprFEX
         RdLLIRr7KNRifbmlqhdHLSFrp474Ez/vMn7bDCCEPIOPj9CB0kBxUfo+mdeDPgK1wyeO
         AQNnt6OtdFtiBxO66OdFEJPg7Twi6xYNpyMrXTq/ASZwSVHFZ64mbITdcO19PkmXQ/0Z
         ypFg==
X-Gm-Message-State: AFqh2kp+tBJpItsjFDACiUv2vjOYJvfVE5na2+V+Gksl6boezagAWxQ5
        eMgiN+Xt1cgxTVRUkT24Q0Q=
X-Google-Smtp-Source: AMrXdXuPlhOj7jDAVrt6QwPTrMne4wS7HKyWLhiCIc/EINEVuGxnCL9kGwTs0CiJ4lUZ8PQOtkZcpg==
X-Received: by 2002:a05:6402:141:b0:46f:a6ea:202 with SMTP id s1-20020a056402014100b0046fa6ea0202mr38900619edu.37.1674741155772;
        Thu, 26 Jan 2023 05:52:35 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id t15-20020a508d4f000000b004a0e2fe619esm591611edt.39.2023.01.26.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:52:35 -0800 (PST)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, wenrui.li@rock-chips.com,
        rick.wertenbroek@heig-vd.ch,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 4/8] PCI: rockchip: Added poll and timeout to wait for PHY PLLs to be locked
Date:   Thu, 26 Jan 2023 14:50:44 +0100
Message-Id: <20230126135049.708524-5-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Rockchip PCIe controller did not wait until the PHY PLLs were locked.
This could cause hangs. Now the PHY PLLs status is checked through a side
channel bit with a poll and timeout. If the PHY PLLs cannot lock an error
is generated. This is documented in the TRM section 17.5.8.1 PCIe
Initalization Sequence.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 16 ++++++++++++++++
 drivers/pci/controller/pcie-rockchip.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 990a00e08..5f2e2dd5d 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -153,6 +154,12 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
 
+#define rockchip_pcie_read_addr(addr) rockchip_pcie_read(rockchip, addr)
+/* 100 ms max wait time for PHY PLLs to lock */
+#define RK_PHY_PLL_LOCK_TIMEOUT_US 100000
+/* Sleep should be less than 20ms */
+#define RK_PHY_PLL_LOCK_SLEEP_US 1000
+
 int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
@@ -254,6 +261,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
+	err = readx_poll_timeout(rockchip_pcie_read_addr, PCIE_CLIENT_SIDE_BAND_STATUS,
+		regs, !(regs & PCIE_CLIENT_PHY_ST), RK_PHY_PLL_LOCK_SLEEP_US,
+		RK_PHY_PLL_LOCK_TIMEOUT_US);
+
+	if (err) {
+		dev_err(dev, "PHY PLLs could not lock, %d\n", err);
+		goto err_power_off_phy;
+	}
+
 	/*
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 51a123e5c..f3a5ff1cf 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -38,6 +38,8 @@
 #define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
 #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
+#define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
+#define   PCIE_CLIENT_PHY_ST			BIT(12)
 #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
 #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
-- 
2.25.1

