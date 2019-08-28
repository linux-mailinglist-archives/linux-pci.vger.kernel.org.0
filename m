Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344DC9FD88
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfH1IzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:55:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36643 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1IzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:55:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so1106015pgm.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZLhox3MGYU3vCPS8rU4RE1IvC0ssD0tDNzjTJYofQ/w=;
        b=In1ofVVkExdB/56av3bUTO7avmdkFk/Pqr0JvQXtiAgUAfC2H8Rx0juj7UBNDrFfF7
         mkpDwsuMPI+mgcWm4y66DB3z3GDqQXCk/goKJbknEzXrWSQnyL9lwR3wHQ79x7Q51a27
         GXz2PmbWzsZvywqAGjIKFzooojw8P1cChYuMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZLhox3MGYU3vCPS8rU4RE1IvC0ssD0tDNzjTJYofQ/w=;
        b=dUsYIP1eUpm3ORj3/CPQEtctnLsGSGyhTDcTD4zkJaraxsT8SjIDLgVs8DF6ifEo6A
         pBF4EBzk0a3Bea4EDc7kr5koTrmZYJYz6BgU+9uW6tKjMOhU2aKSCXexqqgpciVFCTj4
         cB9lzP5HL2/hxTvvCZvBE2MIDKgpZR7lUEj3uhVtYYU+Cd4B10OGtUQwY/YQ1um968Bi
         c5ypcamCmXn4nZbrDIukCM3ir+Wiubt1IiR9nVdedQJHyEuoSw6ogRzOC8g1q+8LwB/g
         SgH9eTa6CESHjkpYkTarpmCC/yTMI7VUiWlEBTG3r2lwmb3Mp0TBLN48WCBPEkOEJAZv
         Ymrg==
X-Gm-Message-State: APjAAAVceXHWnGUbvaqH3IKM6EqCObBr4pMJLXvpebmyPrsdLNxAeQOt
        +LfZ/2rXkmXCUfuNkiCL/6Z52SFAOQIziw==
X-Google-Smtp-Source: APXvYqytDZtQ/1TFhyJ4wMqNxJBsNjny0aOoAimJi3RhZ1BROAWcLL8bfzDNHGtwKRyViN7YtxaPaw==
X-Received: by 2002:a17:90a:fe0e:: with SMTP id ck14mr3113158pjb.78.1566982502193;
        Wed, 28 Aug 2019 01:55:02 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z189sm2431386pfb.137.2019.08.28.01.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 01:55:01 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/6] PAXB INTx support with proper model
Date:   Wed, 28 Aug 2019 14:24:42 +0530
Message-Id: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds PCIe legacy interrupt (INTx) support to the iProc
PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
INTB, INTC, INTD share the same interrupt line connected to the GIC
in the system. This is now modeled by using its own IRQ domain.

Also update all relevant devicetree files to adapt to the new model.

This patch set is based on Linux-5.2-rc4.

Changes from v1:
  - Addressed Rob, Lorenzo, Arnd's comments
    - Used child node for interrupt controller.
  - Addressed Andy Shevchenko's comments
    - Replaced while loop with do-while.

Ray Jui (6):
  dt-bindings: pci: Update iProc PCI binding for INTx support
  PCI: iproc: Add INTx support with better modeling
  arm: dts: Change PCIe INTx mapping for Cygnus
  arm: dts: Change PCIe INTx mapping for NSP
  arm: dts: Change PCIe INTx mapping for HR2
  arm64: dts: Change PCIe INTx mapping for NS2

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  48 ++++++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  30 ++++++-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  30 ++++++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  45 ++++++++--
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  28 +++++-
 drivers/pci/controller/pcie-iproc.c                | 100 ++++++++++++++++++++-
 drivers/pci/controller/pcie-iproc.h                |   6 ++
 7 files changed, 260 insertions(+), 27 deletions(-)

-- 
2.7.4

