Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C564466505
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 15:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358529AbhLBOV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 09:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhLBOU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 09:20:59 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13984C061757
        for <linux-pci@vger.kernel.org>; Thu,  2 Dec 2021 06:17:33 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id p8so41606455ljo.5
        for <linux-pci@vger.kernel.org>; Thu, 02 Dec 2021 06:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ToWnpfe61IfHA5YsWaVruIWs7PR7FCG4QDVMRFV5+CU=;
        b=nnYQtkhZySQHRL4T+FQKZ4NzmaMhSowa7e6+EGktIsJASm5I4lWiCnyRmfuTT6Aqu8
         u4zDxiz25IHQNEYgJkpV9j6MRBJhqdbOcZxRyxmete/m73Dgatol+7rNdHjqyn3NeK+B
         mXHfaz/TQJtL5TgnlhQmqn2Qw1JT3ZSDBdZOsQ3Tnnlh+bGiFHgfghX2CliezhdbUwLW
         HtaeGvjQJDGSr/X8XutiD81dG0cLUkqmLrSLnFc4lHalfY3xtHrzXz3CPon+pSAE3BEq
         Wd1mEGsU0cxwiw2v9ZwgHiCL6IbMUXhWwulYMLS2uIRrnpADeQNTMbUfTlUydersDNJR
         /RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ToWnpfe61IfHA5YsWaVruIWs7PR7FCG4QDVMRFV5+CU=;
        b=xM5l4g9Vnb/bNnlPVCEWCiSlhzmDuSt0ag5HKkOXOEhlePtY/z+N3dyVquDKnHtm+p
         QKjKFnz2iuI/8qe3766BTgQHJ9HeL3+X+5yiKdYSwVaj+X8ln1GO0B+hxo8eKqVEki7m
         SjJ4e+g96qFlGsKOsqxf6ho734HOEwbaaMp6IQSu3W9dscDXRQBxB0JSY4mOVcLSZc9m
         wyebao+P7syMVTbrDNbbRZWx4etMhCSUQ6e3n8FvXK5Fosl7jrzhinbq3F7zbh+mTUsA
         P/2zD7sbjTY4zIrO7SWYNLt8yU6Pg/a7fgHe8LvW/s+cuvLJGD0vu/UvWT9wQBiKsu6l
         DkuQ==
X-Gm-Message-State: AOAM532I6GeS3H/eIA2qzYd94DTStBh7aAGzxyAPv+7h3eE2zKSwbGg8
        QDihAk0QG8kw9FLW4aXiH8wt2g==
X-Google-Smtp-Source: ABdhPJxy4zvG2aNJz1OXzlcJN1fIbwVtfb4nGd30eSQHXVFnpukbgqtGwDb+qnS2pQmTGh0Zet+5rg==
X-Received: by 2002:a2e:a314:: with SMTP id l20mr12664682lje.86.1638454651352;
        Thu, 02 Dec 2021 06:17:31 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m15sm362487lfg.165.2021.12.02.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:17:30 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v1 00/10] qcom: add support for PCIe0 on SM8450 platform
Date:   Thu,  2 Dec 2021 17:17:16 +0300
Message-Id: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two different PCIe controllers and PHYs on SM8450, one having
one lane and another with two lanes. This set of patches adds support
for the first PCIe phy and controller only, support for the second PCIe
part will come later.

----------------------------------------------------------------
Dmitry Baryshkov (10):
      dt-bindings: pci: qcom: Document PCIe bindings for SM8450
      dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
      phy: qcom-qmp: Add SM8450 PCIe0 PHY support
      PCI: qcom: do not duplicate qcom_pcie_cfg fields in qcom_pcie struct
      PCI: qcom: add flag to enable use of ddrss_sf_tbu clock
      PCI: qcom: add support for SM8450 PCIe controllers
      arm64: dts: qcom: sm8450: add PCIe0 PHY node
      arm64: dts: qcom: sm8450: add PCIe0 root device
      arm64: dts: qcom: sm8450-qrd: enable PCIe0 PHY device
      arm64: dts: qcom: sm8450-qrd: enable PCIe0 host

 .../devicetree/bindings/pci/qcom,pcie.txt          |  21 ++-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts            |  14 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 143 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |  93 +++++++++-----
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 125 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  33 +++++
 7 files changed, 397 insertions(+), 34 deletions(-)

