Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7A226201
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgGTO0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jul 2020 10:26:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43874 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgGTO0K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jul 2020 10:26:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CDEF1A020A;
        Mon, 20 Jul 2020 16:26:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5ED471A020F;
        Mon, 20 Jul 2020 16:25:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 16F6540305;
        Mon, 20 Jul 2020 22:07:10 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net,
        amurray@thegoodpenguin.co.uk, treding@nvidia.com,
        vidyas@nvidia.com, hayashi.kunihiko@socionext.com,
        jonnyc@amazon.com, eswara.kota@linux.intel.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 as module by default
Date:   Mon, 20 Jul 2020 22:22:00 +0800
Message-Id: <1595254921-26050-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX7 reset driver now supports module build, it is no longer
enabled by default, need to select it explicitly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 39b3ac7..6c764bd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -921,6 +921,7 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_QCOM_PDC=y
+CONFIG_RESET_IMX7=m
 CONFIG_RESET_QCOM_AOSS=y
 CONFIG_RESET_QCOM_PDC=m
 CONFIG_RESET_TI_SCI=y
-- 
2.7.4

