Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0673E1C17BC
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgEAO26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 10:28:58 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46968 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728847AbgEAO25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 10:28:57 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 27C8D30C04D;
        Fri,  1 May 2020 07:28:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 27C8D30C04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588343325;
        bh=NlVUUM9KahGsmT3Raq1ilVBpQ7Ut/ynsWNkUXLyeHQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLgApfOyvDYysgvOk1/uaXf+khXWAQ17X6wyvxQMk1a/1bplXt6ZnsSW6/95ZHqwI
         Dx5Ae7aGR1KasfU4NmQnHSBc/5Kwu6qBsKWk5JPd9h7AA8iKb33Ap+atQW2r4QecSs
         gyoh2ECZBSranKDeurjeh+PPfjDnonmzxP1kLhjs=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id C0DED140069;
        Fri,  1 May 2020 07:28:54 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/4] PCI: brcmstb: Fix window register offset from 4 to 8
Date:   Fri,  1 May 2020 10:28:28 -0400
Message-Id: <20200501142831.35174-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501142831.35174-1-james.quinlan@broadcom.com>
References: <20200501142831.35174-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

The outbound memory window registers were being referenced
with an incorrect stride offset.  This probably wasn't noticed
previously as there was likely only one such window employed.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 454917ee9241..5b0dec5971b8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -54,11 +54,11 @@
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
 #define PCIE_MEM_WIN0_LO(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
 #define PCIE_MEM_WIN0_HI(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
 
 #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
 #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
-- 
2.17.1

