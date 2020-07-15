Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D64B220F71
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgGOOfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 10:35:38 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:44946 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728123AbgGOOfi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 10:35:38 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 0434A30C03E;
        Wed, 15 Jul 2020 07:35:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 0434A30C03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1594823726;
        bh=3OXvA8PCBEsIpA3nCB4c0nzrfCkD8JiWghv65L3ox8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUlgVGEnX8/1ntu+mr+Pcd/i9W3UxFVr1RH034FyypNlcZK09CVVfZ+BgvzFZosEp
         +3rvvomx9sVLPAVAkeRY3+orcjNIwHi6ifGoByVOzEQTdQB5I9jU2csuI2usXlaA9n
         tmXhmrG6nU+x4jxTOcrOL/eMuCjVISXES9fTMSwU=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 0D014140069;
        Wed, 15 Jul 2020 07:35:35 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 01/12] PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
Date:   Wed, 15 Jul 2020 10:35:04 -0400
Message-Id: <20200715143530.9702-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715143530.9702-1-james.quinlan@broadcom.com>
References: <20200715143530.9702-1-james.quinlan@broadcom.com>
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
index adddf21fa381..c165328d5fbb 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -262,9 +262,10 @@ config VMD
 
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

