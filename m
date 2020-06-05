Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5391F01B0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 23:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFEV2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 17:28:08 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:38326 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728277AbgFEV1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2020 17:27:17 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id BBFA930D73A;
        Fri,  5 Jun 2020 14:27:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com BBFA930D73A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1591392436;
        bh=+RISK9H7pt+O7/u9I4TR8f6+UZgf0oc463SOKeQOuXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aILdbmpKpuwz/9LJ7W+UdmEWfrwEm3HkiDP8FA22VoNX1DpsL1vhi7vYffWNighqv
         ROQzj5+AackXPde7N6ltsVpwJpSzANg02J0LjsVpIZM0lIuOO69RBEXiq8ZHzhh7EX
         /DlzpGF4HAkBhKlF51FwCZoayJufgHIJGNB5xWno=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 68B2E14008C;
        Fri,  5 Jun 2020 14:27:15 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/12] PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
Date:   Fri,  5 Jun 2020 17:26:41 -0400
Message-Id: <20200605212706.7361-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605212706.7361-1-james.quinlan@broadcom.com>
References: <20200605212706.7361-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Have PCIE_BRCMSTB depend on ARCH_BRCMSTB.  Also set the default value to
ARCH_BRCMSTB.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

