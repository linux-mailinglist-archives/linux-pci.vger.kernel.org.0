Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318DD470B5E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 21:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhLJUIf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhLJUId (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:08:33 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFCC061746;
        Fri, 10 Dec 2021 12:04:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n26so9408770pff.3;
        Fri, 10 Dec 2021 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FydrOOQOOcnzDJtZqIEi6eoMAfUsUzqcE+yK9v/ssrU=;
        b=ZfcSyXRSoJ/ebGBB2GpV9x53/9p06Ho9/TIgYcXnPkc30BOdCFuul4CCC0OZkZgmSL
         KPWRTbaFWOvCfoohDwtuVlMvAv+7m7+Zbx3qT4pLquWYH22Q5UQYcgt5hRsygqwgKxBc
         u7T1sdxTigW1Rbxub9rgSZOahfR4z6GK0m+BF7jbAryiCo5Hi5wJCt1/7SPrXaJu4n+C
         4RVvjM91JJafEptAtHZXLCT3CqmCkDMNgjtbC4u8OLwZluLoFsefYA+RF+6JCAWpcxSo
         68gjoXo48DkMuAFfXxDhgHCq264LvntYz5giq6rLkDrncBvIgKCVY29NvLugAo8mcyeX
         1d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FydrOOQOOcnzDJtZqIEi6eoMAfUsUzqcE+yK9v/ssrU=;
        b=fzm9QjvWjbccbySRkHJ+jLARjMe4tZ8JICWoKB+d6YvM57wPlg/M0cq3NEceu4VxeX
         C1hovBWlmC/PFowHvZ+QDBvUdc1lv/YDt0Taz+iEXGuafZ4PAYpZ7lKIdOJKzSc6O5PJ
         AyQpjS0xVPoiqIRd/Ix1vWBByVki29uQkDhAiIr3Lv1vPNIWGsP/drT6NHMS9a1Vrvll
         0mcrucG7S5Rf3kcYUB9Th2ywYqQ1n58WUscULv1cdVYWXyl5XRMWMgyuVf/sqJoicFsf
         nvvz3psbCz/OrfKR2HEbwtNJaqsfLK8N9nQZBcNFpz2EdcBm6tHXiH/DBAe22dGn/UHo
         drrQ==
X-Gm-Message-State: AOAM530aKZIFNoHOao7Gc8/lmfvP9ZHAZkGnfdoUmDEmQkHXZx9i72O8
        PHvNQ0JfADlbP+rk2XNaxV1moE+k5zo=
X-Google-Smtp-Source: ABdhPJwIihkQ1Gv64cIMOXcuI2FInT+9kC2sojBlJJjeqhNRx5JZNkhMuVGmj4krWjYg1ey3vNsaOw==
X-Received: by 2002:a63:5624:: with SMTP id k36mr40954710pgb.503.1639166696904;
        Fri, 10 Dec 2021 12:04:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g13sm3474463pjc.39.2021.12.10.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:04:56 -0800 (PST)
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
Subject: [PATCH v4 0/6] Convert iProc PCIe binding to YAML
Date:   Fri, 10 Dec 2021 12:04:45 -0800
Message-Id: <20211210200451.3849106-1-f.fainelli@gmail.com>
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

Changes in v4:

- Listed 'bus-ranges', '#address-cells', '#size-cells' and 'device_type'
  as evaluated
- fixed first patch to drop reference to 'interrupt-controller'

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
 .../bindings/pci/brcm,iproc-pcie.yaml         | 176 ++++++++++++++++++
 .../bindings/phy/brcm,cygnus-pcie-phy.txt     |  47 -----
 .../bindings/phy/brcm,cygnus-pcie-phy.yaml    |  76 ++++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi             |  18 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                |   4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                |   6 +-
 7 files changed, 266 insertions(+), 194 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml

-- 
2.25.1

