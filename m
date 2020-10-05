Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4CC283347
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJEJcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJEJcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 05:32:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1CCC0613A8
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 02:32:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q123so6486584pfb.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0zAid+VxEsz8vtp+uJxovGmHzMtv2wRGVFkfLdfbU1Q=;
        b=PcBLA498LeRvaTGIBzkV64iVTCJQx7OCN4RKNpTee9gjUFg5ZSM64clSN10xiM4NOc
         MZJnyX/uvUgCOHmVjNgJBLWm22nTIrA52taQFxcz2wLFq9RBxBlG4k/MbQ22vS30Ajzf
         T/lXO/mJrHYRyk7Z/pkZXOsIeFQti6PHgwSu92ShVfq552/F6F45CMEX4SEknxMMIkA5
         NO0kB69uN2LQD6Tza+0AKNFkP0HHX0pTF2/Rp6QOC3qd6Vnp/xtARu8keiujcdO/GUZU
         iR/AFcwvW41osT7wwBRSjAztqQow+4sC8zSlr5wJPYY0TiPT+7LEIAUJsQ9R3hmLSNBD
         tkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0zAid+VxEsz8vtp+uJxovGmHzMtv2wRGVFkfLdfbU1Q=;
        b=Q+KDquT+Pn+iTdLZeDgjS0Bhcjj1pInjDVy1aFCB7ofXcWpLE2qUI0TaX/5jNCQ2HR
         7gFHu4tIDlrn1Nm1mm/d6h5idbTthiKy8yjKC7AWbnSQrVvFwMxV4zxrgQgQpjncQfAM
         j5DnzCePq5jpniQn43lZmZMwL/fGK5j76YA65dbazw6uB7J/iKop5O/EQbJeO4QjcrQm
         vH4Q7Mfjy0do7lmNFp4erb61pAeDv5iEz9LOZUcZFqGghs7b8eEOm7cP8P6pYsAEIcRp
         pOaGiz6vEpLx2Ur9eFwEbafycSPz2/26f0M7QDv2ZMIpz0wOAWZaXOyUMDhwLIKCBXhS
         LIQA==
X-Gm-Message-State: AOAM531vomVlnjIrq6n8C98lIMNjs8nLybPxnCuzNqJ22/tgBH/fDmHx
        OvVV7mkb+7QxLBcvaX9p04e+
X-Google-Smtp-Source: ABdhPJy0JtgvXtPUVJh8q6juYpe7DPzOfgi7TL75tbFcGuiRx+AyRpmUpUBKh4bkR4aiwFMlOQVDNQ==
X-Received: by 2002:a65:4987:: with SMTP id r7mr13638261pgs.228.1601890336156;
        Mon, 05 Oct 2020 02:32:16 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 124sm11298894pfd.132.2020.10.05.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:32:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/5] Add PCIe support for SM8250 SoC
Date:   Mon,  5 Oct 2020 15:01:47 +0530
Message-Id: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series adds PCIe support for Qualcomm SM8250 SoC with relevant PHYs.
There are 3 PCIe instances on this SoC each with different PHYs. The PCIe
controller and PHYs are mostly comaptible with the ones found on SDM845
SoC, hence the old drivers are modified to add the support.

This series has been tested on RB5 board with QCA6390 chipset connected
onboard.

NOTE: This series functionally depends on the following patch:
https://lore.kernel.org/linux-arm-kernel/1599814203-14441-3-git-send-email-hayashi.kunihiko@socionext.com/

I've dropped a similar patch in v2.

Thanks,
Mani

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
 drivers/pci/controller/dwc/pcie-qcom.c        | 149 ++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 281 +++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  18 ++
 6 files changed, 455 insertions(+), 6 deletions(-)

-- 
2.17.1

