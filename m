Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048E67CCCA
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjAZNxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 08:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjAZNxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 08:53:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1791A5B94;
        Thu, 26 Jan 2023 05:52:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y19so1926179edc.2;
        Thu, 26 Jan 2023 05:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4Up5XfBWF4wg+xg2q3Fh3iyg/w/TGxjAj9syTghA+E=;
        b=pMrED9HNKx+1axCuqflfcTCvirmhpDISklTl5je2GxqER7TVq2i+r/Xuea2HgcjMXC
         Yizb8ZOx4ifXVdLSH8UT5zXXMzt2/SrzjE++YehELClmaZ99zRHoGLp6PP6Teljo9Zlc
         OqhUM9KbpoxiDAyFM6TpkZ3WS8CzMLHEHW1rdZO7AiW2a1B06Qys5GR4t4vWstmKTrN5
         /b/hgQ0/0ZHKo4BncvXU4bd/+oTZg9vX7Ph6ZAoLnGJDZxnNLPZaaXI1hxIO9wjQNjtX
         OTr3YBDuDb0zOXB9oFhTWvnUYtghcN8D5cEizHVwGHFUvHJ8QsJ6kXzwezthW4BRPtvD
         MFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4Up5XfBWF4wg+xg2q3Fh3iyg/w/TGxjAj9syTghA+E=;
        b=O142yC6u59qihIRPzcnLprqPrw2YG/ugmCyaW8ZAGK8Wl3E+Y4k9nlzHUeqFo/TQBW
         TX3oigJSEv3G8t5E8Ny0ok2HpA1qQfOpY2VLqv21+ULoNImm+9ZDLOmGRxt3335mdt35
         Kp7w09eAzJXucx5M7bbxFbfk8pDOgyvBrMGeKHmFxjqIuXlzEqzxyY82OaT23fnxymmx
         SsjdJYUgClDdIpymN+ttsSZBWoAnjeYnshOU7I01toBGgidCzWLs4h0vuGoIxjiY3A/z
         GQK6En0GGbfPj/dSGDnUZhZscdmA1aRYUKtnBxCBqBEFJ2f2Ii0Qrp8lJPhtpi8ZgG7V
         Zcag==
X-Gm-Message-State: AFqh2krOxtu3l0sCzBLUz393Qf9aA/9cnPWuvK3WUTVbxgx5/gfvX7Fm
        qmAKCP5qoWiw1nLcj8s0/q8=
X-Google-Smtp-Source: AMrXdXtwZrTuC4jFb2Q+J2Foddd4TAtc+LwgUKY+rLhGzQxs5qGFLf8gt6fItOd0sT2Qn4cv6iqp1A==
X-Received: by 2002:a05:6402:3214:b0:49d:bc8c:c3eb with SMTP id g20-20020a056402321400b0049dbc8cc3ebmr44360890eda.15.1674741165477;
        Thu, 26 Jan 2023 05:52:45 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id t15-20020a508d4f000000b004a0e2fe619esm591611edt.39.2023.01.26.05.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:52:45 -0800 (PST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 7/8] PCI: rockchip: Fixed legacy IRQ generation for endpoint
Date:   Thu, 26 Jan 2023 14:50:47 +0100
Message-Id: <20230126135049.708524-8-rick.wertenbroek@gmail.com>
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

Added generation of legacy IRQ (INTx) for the RK3399 SoC PCIe EP core.
The generation of the legacy interrupt was validated with the PCIe EP
test driver. Generation of IRQ through the core is documented in the
TRM and is done through the PCIE_CLIENT_LEGACY_INT_CTRL register of
the core.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 32 ++++++-----------------
 drivers/pci/controller/pcie-rockchip.h    |  6 +++++
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index a682a941d..a58c9d56b 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -333,15 +333,6 @@ static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
 	u32 status;
 	u8 msg_code;
 
-	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
-		     ep->irq_pci_fn != fn)) {
-		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
-					     AXI_WRAPPER_NOR_MSG,
-					     ep->irq_phys_addr, 0, 0);
-		ep->irq_pci_addr = ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR;
-		ep->irq_pci_fn = fn;
-	}
-
 	intx &= 3;
 	if (is_asserted) {
 		ep->irq_pending |= BIT(intx);
@@ -351,22 +342,15 @@ static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
 		msg_code = ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA + intx;
 	}
 
-	status = rockchip_pcie_read(rockchip,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
-	status &= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-
-	if ((status != 0) ^ (ep->irq_pending != 0)) {
-		status ^= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-		rockchip_pcie_write(rockchip, status,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
+	if (is_asserted) {
+		rockchip_pcie_write(&ep->rockchip,
+			PCIE_CLIENT_INT_IN_ASSERT | PCIE_CLIENT_INT_PEND_ST_PEND,
+			PCIE_CLIENT_LEGACY_INT_CTRL);
+	} else {
+		rockchip_pcie_write(&ep->rockchip,
+			PCIE_CLIENT_INT_IN_DEASSERT | PCIE_CLIENT_INT_PEND_ST_NORMAL,
+			PCIE_CLIENT_LEGACY_INT_CTRL);
 	}
-
-	offset =
-	   ROCKCHIP_PCIE_MSG_ROUTING(ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX) |
-	   ROCKCHIP_PCIE_MSG_CODE(msg_code) | ROCKCHIP_PCIE_MSG_NO_DATA;
-	writel(0, ep->irq_cpu_addr + offset);
 }
 
 static int rockchip_pcie_ep_send_legacy_irq(struct rockchip_pcie_ep *ep, u8 fn,
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 72e427a0f..e90c2a2b8 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -39,6 +39,12 @@
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
 #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
 #define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
+#define PCIE_CLIENT_LEGACY_INT_CTRL		(PCIE_CLIENT_BASE + 0x0c)
+#define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
+#define   PCIE_CLIENT_INT_IN_DEASSERT	HIWORD_UPDATE(0x0002, 0)
+#define   PCIE_CLIENT_INT_PEND_ST_PEND	HIWORD_UPDATE_BIT(0x0001)
+#define   PCIE_CLIENT_INT_PEND_ST_NORMAL	HIWORD_UPDATE(0x0001, 0)
+#define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
 #define   PCIE_CLIENT_PHY_ST			BIT(12)
 #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
-- 
2.25.1

