Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B321FC04C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFPUzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 16:55:49 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:33826 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbgFPUzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2020 16:55:49 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 4D28330D88D;
        Tue, 16 Jun 2020 13:55:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 4D28330D88D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1592340948;
        bh=3OXvA8PCBEsIpA3nCB4c0nzrfCkD8JiWghv65L3ox8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ViUF8mzWpCVaY9qidj/hQmhK3bwcJK1jWitrwWgTDGlgsXQomrYhnyxsUFODUA5wT
         unMHuxQEISgpY/v4ZgYkFwkPVNDwWd68GNq/aig5NTmFIdKVjWH3iXspafrgodghNI
         727FL3C3/pFk9qRScIhfoyOXoeCay0LYYxSI1+U4=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id E3EC114008B;
        Tue, 16 Jun 2020 13:55:46 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 01/12] PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
Date:   Tue, 16 Jun 2020 16:55:08 -0400
Message-Id: <20200616205533.3513-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616205533.3513-1-james.quinlan@broadcom.com>
References: <20200616205533.3513-1-james.quinlan@broadcom.com>
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

