Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FF10F671
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 05:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfLCE5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 23:57:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40842 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLCE5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2019 23:57:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so1956574wrn.7
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2019 20:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pbRW1viad/GHjUmf3l7SOTRxkxISCKNgTFW5qUzFG18=;
        b=WLmdWgtocCq7SfivDEJxGQ0qYWEVC1FNP6Ngu0ZWhp++etMTGHgs+n3xeIFW14fTiV
         yhMj5yJWWCPDS2EsRAWEKGXN55BwurbaZnbUTdFro30TSZBmm596DFT99kyC5Rb5b2Zp
         hE6zmZw+W99FOnPwPVSHB2AwA5Hq6AacNcqZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pbRW1viad/GHjUmf3l7SOTRxkxISCKNgTFW5qUzFG18=;
        b=FOaElXNdBWwMB5IAJXce0iMU2Fdca2L755XN4mKPeqOmphRXVcLQxVXIAy+DZy/Avi
         9XyYxXalcq6uxQL2VX4CqbIyphZ1RgnAm/y3ghVEiFoTtFMxcWvDG90MAE7hdjis9xIU
         pKSHB6AbnasaP+PZQm7vsUVSIsXJIUJLUZXuOPWvI0mAaq4oyWN1RZDerMqAH9Ofe92f
         ApSPO14nUQ3di0lwlji8u5XFpowbXnhoU5/QWfD1Y47H8EdouKyj7FRC3RFEpx9V2lfS
         6O3+vwLKa1VqOrZ2VLCrj2NnIi5ciH6sDrgHoOwI8GBlEyZjKS6AM5sw/jHhu0EEth5V
         8Rbw==
X-Gm-Message-State: APjAAAUY0ntvL4pNpQOYQ6nSoPcPZFKyeSfsQDKTnCZ1+He7MKK76gb/
        ZQj4ZFBCkvF9HCeY5coqMpvXXg==
X-Google-Smtp-Source: APXvYqyUrHD9fDQwouHUkuIiwPBscZSDLCvUsyiXCIoV/4MEv6faKFnYd8o4XCGdWtnIMoM9UkEcaw==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr2679212wrv.376.1575349049792;
        Mon, 02 Dec 2019 20:57:29 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm1667807wmk.26.2019.12.02.20.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 20:57:29 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/6] PAXB INTx support with proper model
Date:   Tue,  3 Dec 2019 10:27:00 +0530
Message-Id: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
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

This patch set is based on Linux-5.4.

Changes from v2:
  - Addressed Lorenzo's comments
    - Corrected INTx to PIN mapping.

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

