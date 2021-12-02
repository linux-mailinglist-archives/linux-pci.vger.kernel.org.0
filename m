Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A1466DCA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 00:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359276AbhLBXgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 18:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358237AbhLBXgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 18:36:18 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128AC06174A;
        Thu,  2 Dec 2021 15:32:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b13so849828plg.2;
        Thu, 02 Dec 2021 15:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyZZXm+sZmPd75E/vSAEhJ0vzhxAH+A8lUCHMAK0xy4=;
        b=eRDLPYSP7mhJosSyHDqk0N6vvbVuUZldeGkvJEfWUeiZLfwYyjMSq7ck9mVKL7FvVH
         pODp0Y5MHVmyvu4xPTqk3tE3SQjoOHUD07/EMmYaUXrmZ3A6jpIssLWFS0UQuoExFucK
         DJTc8QYz4bAPn7s5mlND//hTKmqAmtAlCwL+Sm+K5MZrITgMNiewWO2rI4Vc7xc48tjf
         E4uyljD7Nrc4MGHd4viMOXp5PXdUDWqLtMajLtJsgTjOSbUmDqc4SNT+e18+VdoOGv0X
         2cBgP70ooDrF4i3F/gpCCHczO15gUoYGmRPAmCoiBqT/tmyUdF8ulKnXXkHcavEoGLtn
         J5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyZZXm+sZmPd75E/vSAEhJ0vzhxAH+A8lUCHMAK0xy4=;
        b=tg3if/ILPR0Ymz2Hs4ybwoITm3hUyzGgYWo6wYdjfXAeMmfCQxTzoSc3VihIdgphAP
         HBELfRdOqxkKqRPpElzwF8O/UfXviq7RGCf0CjarJjTK1OLLw9CRwr+/tKWUk3blvQmf
         KppSEI3NwfG12soryG4NQaN7nODBryRN47oCLJESbEZ6kkxesJtw4vhJhQwmB2RBMfzJ
         w6Z26kxmCW04P41wPcKmUkhMoc8MW2RhXdRjFm80moleZKjsMDg7dtBErA2FoxkkfXxV
         TK7OPYJk5yMj6jg6VC8hPJKZXbVHA2vA9sDzfX6IfrRh3CHKP0dplj5uaW5fhmCi3mWG
         wBQQ==
X-Gm-Message-State: AOAM53191/o+wo5+6pySzEZ+F5jPmYyoM8Gcx9dWDr7zoSsIFrj2ySxl
        mlwQxYCW2yjvPkDionKi69RRHsI8x8Y=
X-Google-Smtp-Source: ABdhPJzk4ijSJIjUfwTmegj3V2uablnWLmsw4UZsT3qXB7VLMO6Uuc/xnrYencaXw3ZpWxwaosZrRA==
X-Received: by 2002:a17:90a:ea09:: with SMTP id w9mr9520766pjy.46.1638487974592;
        Thu, 02 Dec 2021 15:32:54 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j1sm809118pfe.158.2021.12.02.15.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:32:54 -0800 (PST)
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
Subject: [PATCH 0/5] Convert iProc PCIe binding to YAML
Date:   Thu,  2 Dec 2021 15:32:43 -0800
Message-Id: <20211202233248.1190797-1-f.fainelli@gmail.com>
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

Florian Fainelli (5):
  ARM: dts: Cygnus: Fixed iProc PCIe controller properties
  ARM: dts: HR2: Fixed iProc PCIe controller properties
  ARM: dts: NSP: Fixed iProc PCIe controller properties
  arm64: dts: ns2: Add missing interrupt-controller property
  dt-bindings: pci: Convert iProc PCIe to YAML

 .../bindings/pci/brcm,iproc-pcie.txt          | 133 --------------
 .../bindings/pci/brcm,iproc-pcie.yaml         | 172 ++++++++++++++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi             |  14 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                |   6 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                |   9 +-
 .../boot/dts/broadcom/northstar2/ns2.dtsi     |   2 +
 6 files changed, 192 insertions(+), 144 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml

-- 
2.25.1

