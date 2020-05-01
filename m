Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4E1C17BF
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgEAO3B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 10:29:01 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46990 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728847AbgEAO3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 10:29:01 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id EAFED30C03A;
        Fri,  1 May 2020 07:28:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com EAFED30C03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588343328;
        bh=rPYr+LF7pS8SyrSELzQjIjwMYDFHNwszBVewRgxsgnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTt6H5GaLjXRQr6QSlEQ42BQwZ9Xbp1YDRx1g+04Sju7pH/2uEDPYUUgkQUtREwsq
         P/xml6jwpuTtN9q6lqtL+UTxq/x1JKug0JpXHMbf8aV9D7QIUGWVK6/dXhjyJizD55
         OSz6XEJYvnAQiyCSL3DlZ/b31Ij7RzA1UWsDgmmk=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id B8D9814008B;
        Fri,  1 May 2020 07:28:57 -0700 (PDT)
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
Subject: [PATCH v2 3/4] dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
Date:   Fri,  1 May 2020 10:28:29 -0400
Message-Id: <20200501142831.35174-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501142831.35174-1-james.quinlan@broadcom.com>
References: <20200501142831.35174-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

For various reasons, one may want to disable the ASPM L0s
capability.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 77d3e81a437b..084e4cf68b95 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -56,6 +56,10 @@ properties:
     description: Indicates usage of spread-spectrum clocking.
     type: boolean
 
+  aspm-no-l0s:
+    description: Disables ASPM L0s capability.
+    type: boolean
+
 required:
   - reg
   - dma-ranges
-- 
2.17.1

