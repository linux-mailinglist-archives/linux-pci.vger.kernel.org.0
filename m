Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A556473BBF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 04:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhLND6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 22:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhLND6Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 22:58:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28634C061574;
        Mon, 13 Dec 2021 19:58:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso16226398pji.0;
        Mon, 13 Dec 2021 19:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6ywQ3A1KtqidaE+0D2HmIbIyiO+4BSqOAgoE1a7Uxg=;
        b=R6q0LxicKsjZ3X2yLcD6aJWSLBX+XL+BWdND6uDim3SkuB8UP+ieim1v5jU7HDqG8x
         1OYlsOMhw+KXkVOcIIv/sm/jhmPAjidAGk1xyQ2fCLyMKkkMQt7CIcWxFDMAFmyz6MMG
         kwkdDJlVW16m0qPV9yWr5PfYZ0rtb0Xa0Sy2/ARrAkHe8nF2o8UG6U/wc7zynR/a8C2M
         T1OfBD3S7mvyX6sgxrY+J4AkxrehuMlwC9vuh5A45aVLnZgOg4xokUwhTa1ejo6xBaIg
         WlLlejnS5DoqbvH3bLrDWlejrwyl6+SEAxqKWz28yARb+FcUhPXgcMHBD0Or8IfG0n6Z
         BeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6ywQ3A1KtqidaE+0D2HmIbIyiO+4BSqOAgoE1a7Uxg=;
        b=nBT8i+wS3x3e+1GHUX9K4DAyEt1MrlEH1UfPswt+R1N0gSUUkVztEsgLg+N4putho8
         XK+xysLcE91CT5AIaZbXnT/gY1YdRKJRKT7bS4juI/qY+lElnprsLMj1lUq9/DDMQP3k
         KACAUdQJ4gmTin9LIgjnzGBKtSe578Pwcg7bjqB6wWkDoW1c649NUy8LjWxXQV2sjUzq
         iqQUupReCKUsQ9cFNwJknNPlenF/ZPZREAojNZ6XcgIiECVJRNnhFEP/QoL7aAs8EpYD
         HRBzqxKV30WnuNPyld1nUP4SwS8anekBV4pbbRWLtBvZBiU9aGcHcvGn8nVbAzPOo0Jx
         ZzTg==
X-Gm-Message-State: AOAM531vKJfzxSabg6ljlSh90f7UXPv4YDSggGW4po4jI87U86nW2SjG
        NKYb2jgZINOqNI3/OrckCGzZ+CKAKk0=
X-Google-Smtp-Source: ABdhPJya0TmJCT1/MKdQBuruOhYF1jsCSR/E+N4Aph5YoIv4e/Hf5PidcKVXrJeUNgULf/NouGGptw==
X-Received: by 2002:a17:902:e88f:b0:141:f982:777 with SMTP id w15-20020a170902e88f00b00141f9820777mr2753159plg.68.1639454304336;
        Mon, 13 Dec 2021 19:58:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o17sm11430356pgb.42.2021.12.13.19.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:58:23 -0800 (PST)
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
Subject: [PATCH v6 0/6] Convert iProc PCIe binding to YAML
Date:   Mon, 13 Dec 2021 19:58:14 -0800
Message-Id: <20211214035820.2984289-1-f.fainelli@gmail.com>
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

Changes in v6:
- corrected dependencies section to quote property names between
  square brackets

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

