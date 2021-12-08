Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59F146CBDD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 05:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbhLHEIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 23:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhLHEIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 23:08:09 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BAC061574;
        Tue,  7 Dec 2021 20:04:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id m15so925839pgu.11;
        Tue, 07 Dec 2021 20:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+4foB9Snx+7Wc8gy79BrJ5tLXa0M/2G0lBJCca6mpg=;
        b=YwnHlwx5dzbD03wHga5cXyH9975PF0Wk0Q4LpumgS0NmzHBCBIBn7kCEOrmZuiO49E
         yyNeWXxGhw19lkLzdAfRTYPj2u2qxRqF5wyIAZd5qWbRR+IJVVFbJf3uqbNBKI88ClLZ
         LVeoLJaV/jcm0o2FW1hO5PYpXbrWJh9KVOmdwJdBfPvYp2vIuTKrMS40al6wc189fGFr
         41U8ak5srv3ydB6wggN/skZWoqy5xcycByvi35xGqSMHyWH3hdAAD6Ptdnv3/hZenHt9
         KOgjy1p7W75NMKOyc6549GzXYV4lYNbnGAmD+V7OQrPeP39EY+fpwa7oKZdE4MQS1jOt
         UyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k+4foB9Snx+7Wc8gy79BrJ5tLXa0M/2G0lBJCca6mpg=;
        b=KQzYkwpyVRV/Il/8zXUcTRkW1me/PiC/YklLgbXyBg5dOk65nR15UIdj3Jg8Ga8N3x
         cFBh9I72FnOtk8+0rYn+3HS0+yW9+5jon/7bYjCTUi2Ue01hB7Su4n8k4b+HMxz6+6Wi
         ffPb4llWa+lSd0+R7ZxHxda+4sOhMeXSb54mlxlGPezddoHL0TvM2RJbZpNbkCSkxDw8
         SBwq1xC+vg/Io30BaDnXyAPXS82R/kFFDPUa9pazUcH5d3j4VTuF+q+7QwPb0Hx9RTJA
         i/s5g6J62Iau2ZvgymAUnGDKhFJxbfsvZvPihC9fZT99D7uP6sdgKzD5DfjfkASDii/G
         6BCQ==
X-Gm-Message-State: AOAM530CiRoJgUXkNyCnAJNJOg7Ab7by9zApuRB6L+D1aUv78Ik4nmHB
        FH30VK6fUUHzAKZgJlQPUkaHLny4WCU=
X-Google-Smtp-Source: ABdhPJxjEqtWq9KEXXCZIY192QMeINMcARC4YRQC2vOI6RWoNb/eTuD+/QLXl3nN62F9kMkB/nxayg==
X-Received: by 2002:a65:5889:: with SMTP id d9mr26983095pgu.43.1638936276974;
        Tue, 07 Dec 2021 20:04:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18sm1320684pfl.201.2021.12.07.20.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:04:36 -0800 (PST)
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
Subject: [PATCH v3 0/6] Convert iProc PCIe binding to YAML
Date:   Tue,  7 Dec 2021 20:04:26 -0800
Message-Id: <20211208040432.3658355-1-f.fainelli@gmail.com>
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
 arch/arm/boot/dts/bcm-cygnus.dtsi             |  19 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                |   4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                |   6 +-
 7 files changed, 267 insertions(+), 194 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml

-- 
2.25.1

