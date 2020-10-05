Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E842832D7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEJND (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgJEJND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 05:13:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91675C0613A7
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 02:13:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q123so6452706pfb.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ogtuZFvmTG1HNJ4mpeUW7o3oDnuWDjMGFWxAfAyP1zo=;
        b=pXBuoTsPuRad3vIUhnovelwcdfQU07Dv8Z+Qy++jDhwhdR0Emie8AuwmaT7EjATyD5
         LWJXWDJX4zrMY4bLBJicioD/na0mCDYuq2dpjz78gJTkkhbAnc0A/SVV0NzAk4fqDYcQ
         IYDhyezYAoB09Vfd5DndUUTKk+Oq4RxVgefyh+Xt3yYV5l8DzssfHTFxlg/8Ads2xP0d
         PmUwHzb9HLUSGWdfcXu3hEhFqWRPHxTcgvkj69O9mERUIjTKu/ntyJjo5YyncEcHfMa8
         T+t+XDrm5I3Rr72jXjfdcF/VGNw6ZH4eVTCOWu/sy14AoLNStskyKOGtqeqaT7HJc2eS
         O31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ogtuZFvmTG1HNJ4mpeUW7o3oDnuWDjMGFWxAfAyP1zo=;
        b=VANTfgTmi0lsJMxlEpF2iz2t/C6Lx3b7zYCigEtefC/kBs7TuxHDUS+7AqqXq9AOPU
         SRjawv8RlfX/psqw3NRfA5Mw6WE83N27qzmuuus1LZfX+lBNe/81K9OmkM4v6jZldPt9
         aCkgZPiqcvsnr/vqq1Mqpb6GZBPNwceiE+FPx6o2Kpd4cc2ynvhJBQhZQRo1Y9yvXqXE
         0QNUNr2GN2Sndr6VreTtnOqhwI3wNWOD4vBSzYpKn2LONBdK7+k6K5PvGkY4uWJVsVNv
         hXrxvFdFSFu6ZnnDeLsypCVRL3TEZHW+9MGJYS0OsDvo0eWEumeXhzQiHotFC6OmIjlo
         5Dxg==
X-Gm-Message-State: AOAM532Ts5Uhul1l28d6RcQI51Q2lkPOIiQoQVBSi5ta+3CW6foZ8mN+
        0ww8tJFuSHU0DWb4sewHFon1
X-Google-Smtp-Source: ABdhPJxgjUAEMEy8du3ikSCR/tZO6938wCs3TDv/a9TCwUvzczACrPF5VLwM6m/cCdU0KV26Uh//bA==
X-Received: by 2002:a63:c40a:: with SMTP id h10mr9314528pgd.210.1601889182847;
        Mon, 05 Oct 2020 02:13:02 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id c7sm11255028pfj.84.2020.10.05.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:13:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/5] Add PCIe support for SM8250 SoC
Date:   Mon,  5 Oct 2020 14:42:31 +0530
Message-Id: <20201005091236.31770-1-manivannan.sadhasivam@linaro.org>
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

