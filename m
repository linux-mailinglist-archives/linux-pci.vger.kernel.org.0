Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E661C9BF0
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEGUQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:16:04 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47526 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728514AbgEGUQD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:16:03 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 30BCA30C05B;
        Thu,  7 May 2020 13:15:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 30BCA30C05B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588882526;
        bh=g/m+KV/xnyKsi5NusBrB40iCFxt3VudgtyX3DALG/2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3S1T8BwOhppDarKsWr1V84L93e8Hn9U5Fw5QdmtVJ8XeP3I2ZIikX5RWPHS7OBxJ
         gMWzurRrGlHhx1tKLM7HmO7+cT5JESXv4QbbFZZyZzu6MD+ZCQf5Nd70xA5ulggdNf
         hCpg1HyALP0lvXPK2aUnPfG0JeC+tkcsgOShkmCE=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 8B05114008D;
        Thu,  7 May 2020 13:16:00 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/4] dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
Date:   Thu,  7 May 2020 16:15:42 -0400
Message-Id: <20200507201544.43432-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507201544.43432-1-james.quinlan@broadcom.com>
References: <20200507201544.43432-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

For various reasons, one may want to disable the ASPM L0s
capability.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 77d3e81a437b..8680a0f86c5a 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -56,6 +56,8 @@ properties:
     description: Indicates usage of spread-spectrum clocking.
     type: boolean
 
+  aspm-no-l0s: true
+
 required:
   - reg
   - dma-ranges
-- 
2.17.1

