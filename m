Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3103B392E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhFXW3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 18:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232873AbhFXW3b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 18:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06FA561375;
        Thu, 24 Jun 2021 22:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624573632;
        bh=jYt5kfZFIc6erlp5/8lvnkSBPgbQ6DNhQvJQ28jGNJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kd7vizbDFBauhateivIkhyAS7AStROoZqtwp9gkAiGOj8di81tHkRcunYn1wtYuzh
         XqDNQnlAa6wyt8vcP0gpp4vSvvPoiorZ3mYKq1glVKQTciW2RU4mkeEVekVbFaOHIB
         VjdFIvkfmN+SdxOIvmvQuRrVx9Ykkyd83yivSCXPPcFix1t9pNrj3RteUBRnffiri7
         95Te6fuY3YMGppRmo5jReHWcsh2ckNXzdzlZ4k5XDnf/BTS3iA+RPHMXX++5NHalIs
         ivePIe8pYmt4NkbgX4Og9rw+vsbuYJuIdhoMCwuJbjQ80f+wYwrP9Q5oUXx9ejJtlj
         dAfODsxjJ6Rhg==
Received: by pali.im (Postfix)
        id B87C88A3; Fri, 25 Jun 2021 00:27:11 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Remi Pommarel" <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 5/5] PCI: aardvark: Implement workaround for PCIe Completion Timeout
Date:   Fri, 25 Jun 2021 00:26:21 +0200
Message-Id: <20210624222621.4776-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624222621.4776-1-pali@kernel.org>
References: <20210624222621.4776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
document describes in erratum 3.12 PCIe Completion Timeout (Ref #: 251),
that PCIe IP does not support a strong-ordered model for inbound posted vs.
outbound completion.

As a workaround for this erratum, DIS_ORD_CHK flag in Debug Mux Control
register must be set. It disables the ordering check in the core between
Completions and Posted requests received from the link.

It was reported that enabling this workaround fixes instability issues and
"Unhandled fault" errors when using 60 GHz WiFi 802.11ad card with Qualcomm
QCA6335 chip under significant load which were caused by interrupt status
stuck in the outbound CMPLT queue traced back to this erratum.

This workaround fixes also kernel panic triggered after some minutes of
usage 5 GHz WiFi 802.11ax card with Mediatek MT7915 chip:

    Internal error: synchronous external abort: 96000210 [#1] SMP
    Kernel panic - not syncing: Fatal exception in interrupt

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
Patch was originally written by Thomas and is already for a long time part
of Marvell SDK. I have just re-written/re-applied it on top of mainline
kernel and also wrote a new updated commit message.

Please note that this patch is questionable as Bjorn has some objections
and nobody, including Marvell, was not able to explain erratum nor what
is workaround exactly doing. Documentation about this topic is basically
missing.

We just know that it fixes real kernel crashes when using WiFi cards.
---
 drivers/pci/controller/pci-aardvark.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 9ff68abd8d1e..231f4469d87e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -167,6 +167,8 @@
 #define     LTSSM_L0				0x10
 #define     RC_BAR_CONFIG			0x300
 #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
+#define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
+#define     DIS_ORD_CHK				BIT(30)
 
 /* PCIe core controller registers */
 #define CTRL_CORE_BASE_ADDR			0x18000
@@ -450,6 +452,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
+	/* Disable ordering checks, workaround for erratum 3.12 "PCIe completion timeout" */
+	reg = advk_readl(pcie, DEBUG_MUX_CTRL_REG);
+	reg |= DIS_ORD_CHK;
+	advk_writel(pcie, reg, DEBUG_MUX_CTRL_REG);
+
 	/* Set lane X1 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~LANE_CNT_MSK;
-- 
2.20.1

