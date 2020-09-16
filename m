Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F626C35F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIPNoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgIPNcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 09:32:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96575C014D6C
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 06:20:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jw11so1535800pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tdOFUZh3LY5QuHGnOCX8BttL0CjvetqcKHFgt32bNC8=;
        b=kDeOGHzo6ODa94vjhKjernayhpGqi6FSvbuGB7wrUZzSHldsXMPnTScMhpe6RHf/Ur
         EV0eCx9jn2zVRvmx9FvD6B1n/e7VV99+DZxtOA1dtRTrFalnMWDDrorI6vzT+67TPyi1
         aSuOd9dsEXmuIq+93YPAqWE87V5euz28b23JOL7A69AjEYMPb/9wlfQcBJRTQ3h8smSr
         jbjaY6XcstN6ZhjSzNAYhc7HeKeB43MPw/cj+heXa0dTaJm9S7UaTAmU2nNpptZwA5KS
         iym0vwUvjz/IhoH93a/XkTa5II5GG71PmnhgKpxEq4cVVRrI7iMpLq/eW6A0N3S6r+ka
         hX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tdOFUZh3LY5QuHGnOCX8BttL0CjvetqcKHFgt32bNC8=;
        b=UU0FA3m/EPOa4qdqTeSaZFUAzQyR39ZoCHONjIaabvSxQDZiy/8O9yZI02Q4BECvdR
         8acXyAwZBtZWKa6jyg5144dzKIsaTWAuNKIbcJv9wJfs2zXnhuRVAy0mEte4Kp5tQgVa
         WlF+JE0Cs2aXxTHGoVQ1CBILUE2aXEm46hOEV5lxLRKpfztJ54tn6Sc90nd7mW/mhFp8
         K8cOcpQPLYt7dcNgJmRcpfOckGpoa36jiFvy4ZO72P+CCYnzwHuhkrsep1uAMGitJsp4
         Qqoi4LNOK6EnyVZ60/oWlcD8S3Iu5De9CAQnJ+39MjHhhxqR+J1HQHnSxFeKE3kr8HVf
         aFfQ==
X-Gm-Message-State: AOAM532ss7BubSM2sLNEAQzBCVI+l5oG34niU34At0NoZkOrI9/Vi8f1
        VzQbcuJsFGCN836hl7bzVnUm
X-Google-Smtp-Source: ABdhPJyQiaAIah4+UzyR8HWiFAgzNuGj44Kivt85wD300DAf5M8dYhJwGxHEE8pWE6wo0kHuV4qWaA==
X-Received: by 2002:a17:90b:3905:: with SMTP id ob5mr3849182pjb.61.1600262421090;
        Wed, 16 Sep 2020 06:20:21 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e123sm17615726pfh.167.2020.09.16.06.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:20:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add PCIe support for SM8250 SoC
Date:   Wed, 16 Sep 2020 18:49:55 +0530
Message-Id: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
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

Note: The dts patches will be submitted later once driver bits got applied!

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: phy: qcom,qmp: Document SM8250 PCIe PHY bindings
  phy: qualcomm: phy-qcom-qmp: Add PCIe PHY support for SM8250 SoC
  dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
  pci: controller: dwc: qcom: Add PCIe support for SM8250 SoC
  pci: controller: dwc: qcom: Harcode PCIe config SID

 .../devicetree/bindings/pci/qcom,pcie.txt     |   5 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |   5 +
 drivers/pci/controller/dwc/pcie-qcom.c        |  11 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 297 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  18 ++
 5 files changed, 334 insertions(+), 2 deletions(-)

-- 
2.17.1

