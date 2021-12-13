Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB09F473577
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 21:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbhLMUAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 15:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbhLMUAM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 15:00:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0940C06173F;
        Mon, 13 Dec 2021 12:00:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v23so12624382pjr.5;
        Mon, 13 Dec 2021 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRs7BTLOPGBvw4/QXdtwYkk5fJi9H2qobC8xHjwW8Ow=;
        b=lq/6tS9HOCtO/og5GqpVOumb/0brxKrhnClhEpm4czkANPDojhQr7tG3cu3/jwPRwM
         ZtV6CxgNm0QLYv/7m7jse8VJuFbhUz12ctshsoT2NeazEho091/ewXoIuytB4lGoa1DB
         h6AYe2qwep0NV49rfVvWQVPLVfTfvNSUDTy1wrhIkPwXmYi+joCureVuv8GmepFZWLC6
         PLzRWcbADxOqudAXk66BAPEs83o9cKZR1pZt7DVoJ6XbMMGidFN1IY+czqKvoyBOWlB0
         EbWnsEM0MPwpdYhhMJC6t3L4B3IbLliehtJmDup0TbPZ4xq4shU5ctwPtKcMZbnAY7/6
         EJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRs7BTLOPGBvw4/QXdtwYkk5fJi9H2qobC8xHjwW8Ow=;
        b=DWNph5Wr/HyJOGrEJSbLPgYqOufWfJ4eK8EGZre4sSdoAI5KaAkiM5nkZ1kc1N0Wpe
         nWwqxc6mXD0hI5pIVEhhts/S7stKiyNvAQ+SFg9zcV/vanRSxLuajkgE78vO4sYC3jLD
         /MMWnDP/0gXr8FXPH+/g0wlYBfzzkVGIevRAAyRefieHguruOA46HhVFPLGdxigS/t8i
         dcshefqTm6yqYXaD/PwnW/4Pbo6xjJNSo+Tg3IZues0rH3AcqdOd0YertidH6qYWMrlp
         ESI+mcDFL0s6+8zswbdrX/CrK773DddrVkHTuN1Sa9dKYpRbkfYB2h6vH5pI0eV2swww
         w/Hw==
X-Gm-Message-State: AOAM531YIb1C/QgObZHJPzQDqJ+o8NLyvzz80GwXmn1SVjefOAl27k8Q
        YrfFX72MWaWAqJhjp9GeqsN865XfsUM=
X-Google-Smtp-Source: ABdhPJylX6kAbzCeZaxhKJ4pawxZdRmdHJLdpx74Rnx4Tfn08yjWw9ghmfEkpacWAqn6n5Gwj7EE4A==
X-Received: by 2002:a17:90a:ea09:: with SMTP id w9mr395870pjy.46.1639425610937;
        Mon, 13 Dec 2021 12:00:10 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z14sm13926195pfh.60.2021.12.13.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:00:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/6] Convert iProc PCIe binding to YAML
Date:   Mon, 13 Dec 2021 11:02:15 -0800
Message-Id: <20211213190221.355678-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series converts the iProc PCIe binding to YAML. Given there
is a majority of DTS changes, it would make sense for me to pull this
via the Broadcom ARM SoC git tree.

Thanks!

Changes in v5:

- Listed 'bus-ranges', '#address-cells', '#size-cells' and 'device_type'
  as evaluated
- fixed first patch to drop reference to 'interrupt-controller'

Changes in v4:

- none, sent by mistake

Changes in v3:

- converted Cygnus PCIe PHY binding
- removed interrupt-controller from being a mandatory property

Changes in v2:

- document msi sub-node compatible string

Florian Fainelli (6):
  ARM: dts: Cygnus: Fixed iProc PCIe controller properties
  ARM: dts: Cygnus: Update PCIe PHY node unit name(s)
  ARM: dts: HR2: Fixed iProc PCIe MSI sub-node
  ARM: dts: NSP: Fixed iProc PCIe MSI sub-node
  dt-bindings: phy: Convert Cygnus PCIe PHY to YAML
  dt-bindings: pci: Convert iProc PCIe to YAML

 .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
 .../bindings/pci/brcm,iproc-pcie.yaml         | 184 ++++++++++++++++++
 .../bindings/phy/brcm,cygnus-pcie-phy.txt     |  47 -----
 .../bindings/phy/brcm,cygnus-pcie-phy.yaml    |  76 ++++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi             |  18 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                |   4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                |   6 +-
 7 files changed, 274 insertions(+), 194 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml

-- 
2.25.1

