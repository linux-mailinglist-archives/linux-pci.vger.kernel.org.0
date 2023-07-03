Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6DD7457DF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGCI7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGCI7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 04:59:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE6A93;
        Mon,  3 Jul 2023 01:59:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9926623e367so483818766b.0;
        Mon, 03 Jul 2023 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688374770; x=1690966770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gIU+W3KyfXyLBg7kXWXihpWayTsoJV4YZPC0K6yLsJA=;
        b=JUWUA2aOc9Dgh4V5Q7UhO675h2MALJ5NW9MdQo101rjli8W6OLSSe1OswnGwmKyxrB
         NHAUqn0UPLG4yGtZMWH7AeC8CxBMCMXdg6abYWBNi1BfS5zfu3f6898+i89v95xWw6kp
         GvEUWvuhCV1ZkHG39MFp0vYwtTJL6f+XzqaRfT0A4yfCYG2gv4hqb6YxgSbaPiHijGpv
         L7RL9qE6EPs2sbXSVEPx8EXype00i4baQGWNbw5zRK7QmYI3Mx97966lUGfTL9jcQprI
         83RZ8yj/3MfV3dBGnVVyK91IqrR4m9MmA5Unj1F+ggj93CCca5I2pwNTCWBSJ93JOR2M
         JJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688374770; x=1690966770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIU+W3KyfXyLBg7kXWXihpWayTsoJV4YZPC0K6yLsJA=;
        b=GidgQh0KTJli3io8XdX2Od9gHHbjHy69ZrAuG/Sn2wYkBWAPp2jaNScOXI/C/k8Lv+
         vTaQHOHzRpCZ+U8u2TdH2LH5A1EYfQ/FeIBDzdDc82JnrPcfQZ1b8vNaCxVn+Aowo5Y3
         t2du327NUHpB49VkB7RpxCwUseTOreA3NKp9JqfLNkmj6yatC0/z5ckzYJqZ5ZdlgZy0
         4ZCBRgfGu7LdBI5zLMVHUlTLoaUrVD9S4jhzOtVA6bQUkg0ccB2WYDRIlI8BuZp+vNYI
         4Q9wP9fwR6/U+Pkv6Y5VF6tO/ZFnltBpy7ZhPHD8KGKWG3OiNKgB3juWQ0S2alhR4wVO
         7wHA==
X-Gm-Message-State: ABy/qLbFkwIjzZbfWC5SKV6Epx+/Lqf8sFikmG1+2KGp0Sl1WHKZQTBd
        /tb5NrKPBCBcmJ1jSaGUxPU=
X-Google-Smtp-Source: APBJJlEtZ35iuRiAJo32s6RRkTkvahBjWT1OeGN/+dzdJFyZKgH0GZC7TK0lOAP/xxPXzDnniK+bYw==
X-Received: by 2002:a17:906:5a94:b0:96f:c0b0:f137 with SMTP id l20-20020a1709065a9400b0096fc0b0f137mr6850646ejq.16.1688374770463;
        Mon, 03 Jul 2023 01:59:30 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id gx23-20020a170906f1d700b00992dcae806bsm4501159ejb.5.2023.07.03.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:59:29 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     dlemoal@kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
Date:   Mon,  3 Jul 2023 10:58:45 +0200
Message-Id: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
This would result in the upper 32 bits being unintentionally zeroed and
MSIs getting mapped to incorrect PCI addresses if the address had any
of the upper bits set.

Replace 32-bit mask by appropriate 64-bit mask.

Fixes: dc73ed0f1b8b ("PCI: rockchip: Fix window mapping and address translation for endpoint")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pci/8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain/
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pcie-rockchip.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index fe0333778fd9..627d08b34827 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -158,7 +158,9 @@
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
 
-#define PCIE_ADDR_MASK			0xffffff00
+#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
+#define MIN_AXI_ADDR_BITS_PASSED		8
+#define PCIE_ADDR_MASK			GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
@@ -185,8 +187,6 @@
 #define AXI_WRAPPER_TYPE1_CFG			0xb
 #define AXI_WRAPPER_NOR_MSG			0xc
 
-#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
-#define MIN_AXI_ADDR_BITS_PASSED		8
 #define PCIE_RC_SEND_PME_OFF			0x11960
 #define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \
-- 
2.25.1

