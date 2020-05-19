Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3893A1DA2A7
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgESUer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 16:34:47 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:34972 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbgESUeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 16:34:46 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 401C530D572;
        Tue, 19 May 2020 13:33:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 401C530D572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920403;
        bh=rNRnouKnK+Ae0pg/6JjkalMRTC0D35K2HBe9M42/z1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2cL0q+vodOE+5iYetrNwfr5+HGbUInmCgy3qAW1ns0TV4d24foa5iXeth7/y3xkD
         T0aY1UAugPBaKbbxbtiJxYDSiKerLkBNlSZXpGAykB8lBYoZPbrudCcZrlkUGmXTmq
         XjaIpjnUJcA4e/lBoH68jhf7G2rmq0hBqVJJaDe4=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 9244D140069;
        Tue, 19 May 2020 13:34:44 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/15] PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
Date:   Tue, 19 May 2020 16:33:59 -0400
Message-Id: <20200519203419.12369-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Have PCIE_BRCMSTB depend on ARCH_BRCMSTB.  Also set the
default value to ARCH_BRCMSTB.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/pci/controller/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 91bfdb784829..c0f3d4d10047 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -244,9 +244,10 @@ config VMD
 
 config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	default ARCH_BRCMSTB
 	help
 	  Say Y here to enable PCIe host controller support for
 	  Broadcom STB based SoCs, like the Raspberry Pi 4.
-- 
2.17.1

