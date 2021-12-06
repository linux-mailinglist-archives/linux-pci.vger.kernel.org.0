Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECC46A4F1
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 19:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbhLFS4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 13:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbhLFS4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 13:56:15 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2590CC061746;
        Mon,  6 Dec 2021 10:52:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g19so11023167pfb.8;
        Mon, 06 Dec 2021 10:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Qa7MjIYGVQpWiCqHFjWcTV+J2/Hu0PKJOfB6Hd0D3Q=;
        b=AUeJx8ofDmZpvsP1SYYvUcXgeWM2kCypJAZI72ITYveeAKnI+BEdhyCNHHw4wS/WT8
         +U0rwxeRZCiUXn0hbM/9YtnTcZwZOXCdUqDw4Fg8jkxRHp+ZqY0DL7g1Iy5wUkaLr+hW
         MBGAm1ahWZn1k7emFAuE736YcjO922VHTFcwKwSnBwbIr1GCJQXnPpPxuijv0yzCPOB5
         v9fDwVN531oRUNMJgZkoVGwkzmzJMLKJQVAi9U1FIOXS2NL0p43pekGN1L28kbi9q8jU
         ICqWsChcRPChxYZ2nw3Zlnoxn1txE5s0uQ6soqje72DjFoDYjx+7kDDHsH0B4MATjyv8
         9GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Qa7MjIYGVQpWiCqHFjWcTV+J2/Hu0PKJOfB6Hd0D3Q=;
        b=szodvc7WruxvIoXqTHsVqyGV4CBioay/8Q75obKOE1T7DwaWA1JFSQbqYJQW3Ipztk
         xSPWU52egVptUjs+x+sITnonVZEdjiaSr1qmoLnu5rpuKwsi4xxcM8MPDmjZLeAzE9EK
         f79cLP5KNnDcjVfWeiumOeJSkcfbY0pQ/4ath7LFri30+dGPT4d9s7QrrrKltv/rR8An
         RGwhGeuFzxmCygPstB0tVBxVi974H1RDb2wixeJZteIUnr79D8NMFA3aNuxrXYLsp30B
         uGFV3aIvGsS995nmsYFxVxlQkgQfwNV69JSljaw/YNfdNwypHeZQCLyC4YEb2hQDuiEe
         6sTA==
X-Gm-Message-State: AOAM533oYW6xdku3c+iVYa+rZuEuk9UlZ5babU4OHDYutDmS4fqq0UCd
        yL7/ojzXE7gD3rBwP2oBY6xZIRMMbIg=
X-Google-Smtp-Source: ABdhPJzCJi1Qp6CulNzfKNnb8tfwGft75nGwuIOHxHJ+31/NmA0nacnf1eQfTKl5VPd/dnMkwY9aYw==
X-Received: by 2002:a63:8141:: with SMTP id t62mr19919599pgd.5.1638816765256;
        Mon, 06 Dec 2021 10:52:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u22sm14323432pfk.148.2021.12.06.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:52:44 -0800 (PST)
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
Subject: [PATCH v2 0/5] Convert iProc PCIe binding to YAML
Date:   Mon,  6 Dec 2021 10:52:37 -0800
Message-Id: <20211206185242.2098683-1-f.fainelli@gmail.com>
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

Changes in v2:

- document msi sub-node compatible string

Florian Fainelli (5):
  ARM: dts: Cygnus: Fixed iProc PCIe controller properties
  ARM: dts: HR2: Fixed iProc PCIe controller properties
  ARM: dts: NSP: Fixed iProc PCIe controller properties
  arm64: dts: ns2: Add missing interrupt-controller property
  dt-bindings: pci: Convert iProc PCIe to YAML

 .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
 .../bindings/pci/brcm,iproc-pcie.yaml         | 179 ++++++++++++++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi             |  14 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                |   6 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                |   9 +-
 .../boot/dts/broadcom/northstar2/ns2.dtsi     |   2 +
 6 files changed, 199 insertions(+), 144 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml

-- 
2.25.1

