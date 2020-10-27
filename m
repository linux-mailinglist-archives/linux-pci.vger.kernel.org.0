Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D25A29BF31
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 18:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815034AbgJ0RB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 13:01:29 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55220 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1814947AbgJ0RAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 13:00:47 -0400
Received: by mail-pj1-f66.google.com with SMTP id az3so1098084pjb.4
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uRYHj8fOzKIbgTatVNACe2Z7jBPsaQjBEafGCSz/uso=;
        b=v7jJxiAmFpQGPPE8QQ0mrCsoWYr7bSM/5I3m+sxKynoFaTaRvcpyHQGZCPGDrN5Nhy
         Sg1qqv2CfjIuTLDR7DamQT1BYojxLuqIgKS41hewgRY7hfB7hCKxfUOaf0GfpR/tlrhG
         CySBrlXznr3ESkkK3Aigi11FU2wJVG6fqOv/WbAc+uE8+Dv2N758mrVH0bBCX1uUkBgJ
         hw0YcCS561pUgUdNC7vHyq+ZP0JPoAHOn/Wvs9wgYZSp2PBIQQDPJE8cBcNG1/RSfKtY
         Vr3+JXrBVtdzNlo5lZUvjA1Y145E9glZYXc4s4iw6SaDmIVbbdUBaBKXfQdlWG+5t134
         9mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uRYHj8fOzKIbgTatVNACe2Z7jBPsaQjBEafGCSz/uso=;
        b=QWSzmz3UanMB/brx8j5sbjfes+jejHu4nmqg2a9a7pZj3VkjQXV09qkI9afZdYWjBd
         1Jnzrmasvt4oIWn7A/1KFUQmszkERIxjDMyartxsTn3IioJK2V65Nxx4Jn+Bi2ugCj+C
         0omYoQROyMIEnzCJVqGh+Swir97DFdk6rMkrwx2L/OD+cj4KS4wg914Yr9/UUEreiFK2
         0e8ktiwVXeiSEoRNJHnRRZ3izJocQcJEM0fhWZaQtpkVGH+ns+s14dp8jQVzM5fO4SSe
         Ox9lVxIkGaxTmYpod4CSDOoq/+GQS6u26lbbWhubeOBIXdmkAglXjBP4C8ciHxSxnPwF
         uKzg==
X-Gm-Message-State: AOAM532BN1r/odjSctsU2vpNdP/gczUgeTr8b/64hqimMRDuz1Cr32Tq
        OfoihZJdKRczxf/DTUmKJVAZ
X-Google-Smtp-Source: ABdhPJxwJxY0LrEFo/qNK6kR4+9FBQYel3/cegKB/Dhvb96lXQaJkrXXz9/VECIAyZNQKkvnTsdoXQ==
X-Received: by 2002:a17:90b:950:: with SMTP id dw16mr2736081pjb.200.1603818046747;
        Tue, 27 Oct 2020 10:00:46 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id x26sm2845206pfn.178.2020.10.27.10.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:00:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/5] Add PCIe support for SM8250 SoC
Date:   Tue, 27 Oct 2020 22:30:28 +0530
Message-Id: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series adds PCIe support for Qualcomm SM8250 SoC with relevant PHYs.
There are 3 PCIe instances on this SoC each with different PHYs. The PCIe
controller and PHYs are mostly comaptible with the ones found on SDM845
SoC, hence the old drivers are modified to add the support.

This series has been tested on RB5 board with QCA6391 chipset connected
onboard.

Thanks,
Mani

Changes in v5:

* Added Review tags from Rob
* Cleaned up the bdf to sid patch after discussing with Tony

Changes in v4:

* Fixed an issue with tx_tbl_sec in PHY driver

Changes in v3:

* Rebased on top of phy/next
* Renamed ops_sm8250 to ops_1_9_0 to maintain uniformity

Changes in v2:

* Fixed the PHY and PCIe bindings
* Introduced secondary table in PHY driver to abstract out the common configs.
* Used a more generic way of configuring BDF to SID mapping
* Dropped ATU change in favor of a patch spotted by Rob

Manivannan Sadhasivam (5):
  dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY bindings
  phy: qcom-qmp: Add SM8250 PCIe QMP PHYs
  dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
  PCI: qcom: Add SM8250 SoC support
  PCI: qcom: Add support for configuring BDF to SID mapping for SM8250

 .../devicetree/bindings/pci/qcom,pcie.txt     |   6 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |   6 +
 drivers/pci/controller/dwc/Kconfig            |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c        |  92 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 281 +++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  18 ++
 6 files changed, 398 insertions(+), 6 deletions(-)

-- 
2.17.1

