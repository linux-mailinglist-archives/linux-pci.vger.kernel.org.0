Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C935820DD73
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgF2Syq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 14:54:46 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60456 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgF2Syp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 066552010E3;
        Mon, 29 Jun 2020 17:17:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 36E3A2001CD;
        Mon, 29 Jun 2020 17:17:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E20BC402EE;
        Mon, 29 Jun 2020 23:17:03 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net, treding@nvidia.com,
        gustavo.pimentel@synopsys.com, amurray@thegoodpenguin.co.uk,
        vidyas@nvidia.com, xiaowei.bao@nxp.com, jonnyc@amazon.com,
        hayashi.kunihiko@socionext.com, eswara.kota@linux.intel.com,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 as module by default
Date:   Mon, 29 Jun 2020 23:05:28 +0800
Message-Id: <1593443129-18766-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
References: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX7 reset driver now supports module build, it is no longer
enabled by default, need to select it explicitly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- use module build by default.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 35f037f..454a1f2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -909,6 +909,7 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_QCOM_PDC=y
+CONFIG_RESET_IMX7=m
 CONFIG_RESET_QCOM_AOSS=y
 CONFIG_RESET_QCOM_PDC=m
 CONFIG_RESET_TI_SCI=y
-- 
2.7.4

