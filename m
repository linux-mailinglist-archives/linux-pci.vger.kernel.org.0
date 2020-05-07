Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4521C9BE8
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEGUPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:15:54 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47414 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbgEGUPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:15:53 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 6E42630C02B;
        Thu,  7 May 2020 13:15:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 6E42630C02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588882517;
        bh=TFgm1HP6J/q3gMqUn7S3GA3dics4xRiCfyXx7FSOh7w=;
        h=From:To:Cc:Subject:Date:From;
        b=ka147P+U1Ln/MosxtJ9bxvNQLe8/NzuQU3513/ol9qMJnIKxuoFj2eu7oeZ0LoPf9
         aaTGepYe5XOLtq1C3Z6XeGMhVvl/4ORa4Ly1WPE23eRdLYkysFNDWrdx8acQ3t02NR
         yPPPqFRRyWEpELxA3N4VHXOjBhtVbCUap8lxajvI=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 7F4BD140069;
        Thu,  7 May 2020 13:15:51 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/4] PCI: brcmstb: Some minor fixes/features
Date:   Thu,  7 May 2020 16:15:39 -0400
Message-Id: <20200507201544.43432-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v3 -- A change was submitted to [1] to make 'aspm-no-l0s' a general
      property for PCIe devices.  As such, the STB PCIe YAML  file
      merely notes that it may be used.

v2 -- Dropped commit concerning CRS.
   -- Chanded new prop 'brcm,aspm-en-l0s' to 'aspm-no-l0s'.
   -- Capitalize first letter in commit subject line; spelling.

v1 -- original

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/pci/pci-bus.yaml

Jim Quinlan (4):
  PCI: brcmstb: Don't clk_put() a managed clock
  PCI: brcmstb: Fix window register offset from 4 to 8
  dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
  PCI: brcmstb: Disable L0s component of ASPM if requested

 .../bindings/pci/brcm,stb-pcie.yaml           |  2 ++
 drivers/pci/controller/pcie-brcmstb.c         | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.17.1

