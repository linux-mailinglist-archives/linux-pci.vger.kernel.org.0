Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097C4474E40
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhLNW6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhLNW6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:58:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EACC06173E
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:58:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf39so27559868lfb.8
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ElhjSQRkBAVirJx6rQQ9wOPmR/xdLQ5Y4DtXvBrY/A=;
        b=IP/SqCET/cIDz5W/tkTOoRj//JrcmN0RGsWN5l+Ru0RjNNGNm6ClYB9vI2+EGEZHzo
         Yld3FVUuv6trAPU46mrts0q3WibtZansba+FfL44V2ESZjScqHEFz7M8rQN2txxULIOc
         9u6JUrF6UZt7vrrJXn9Ndrfw4IY2PtfXwMyBQnivXoAN7/I5YjV8a4mZIaWXkEPCllrb
         EquvQ/ZhfcBIdAdKjJ5BeYcwVoY+9CBxcjwMD5wGP4E5gdQ8PQYXDAX7tDi38kEX9xGs
         nfRwb9N7gZcz0x785KK9DYFOPc+XEGfAtttIccE6n7IL/m0CUg91CtQPucJuvzonhkL+
         +7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ElhjSQRkBAVirJx6rQQ9wOPmR/xdLQ5Y4DtXvBrY/A=;
        b=mKStXiLZ0iH+w1xY1mJyYq2Q5LZU3CifBRuLC+N0n5bYB1a+oNVp/JAXQGYdilwQWe
         jR0mSsKelXH3QhB9S6A4zoWjeUzPzFuGY7nmza7X7neJZH2Iz7AYnOjkMpAu0ZNojtti
         G/4JEcikf1/mhaBn9r+uFfbKI2LcaWfsQgWN6zvREWLawHdTvOJQ8GTnnY7GhRULRPBg
         gJgkxWc4qOoeOwa2QDIBRygW+KRbkN3E2aVZpK1wFyFAUfQuBCJMNVG8kqrUJQilRVpj
         KFkXMlggc24DDHgBDld21+3HVx5J7tVBmZbYoFthaK1ZXjhAuYgBBdA0oPcnEd0zyktl
         y5bA==
X-Gm-Message-State: AOAM531utYBcEspY5stmvi53H6+e9uLEKGQH4hWK0eUZO+K6HZZcPpIe
        iWgoxwkkEKcTX8Zkz3QxOpk5+w==
X-Google-Smtp-Source: ABdhPJx0SgvSJtbcVOQeXt6YA544j26Avfy58G+7BFNLy9a2hL9JByO623Fq0Qfn+4yZMNVbtkM17Q==
X-Received: by 2002:a05:6512:11e5:: with SMTP id p5mr7001672lfs.537.1639522732735;
        Tue, 14 Dec 2021 14:58:52 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t10sm45115lja.105.2021.12.14.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:58:52 -0800 (PST)
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
Subject: [PATCH v4 00/10] qcom: add support for PCIe0 on SM8450 platform
Date:   Wed, 15 Dec 2021 01:58:36 +0300
Message-Id: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
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

Changes since v3:
 - Fix pcie gpios to follow defined schema as noted by Rob
 - Fix commit message according to Bjorn's suggestions

Changes since v2:
 - Remove unnecessary comment in struct qcom_pcie_cfg

Changes since v1:
 - Fix capitalization/wording of PCI patch subjects
 - Add missing gen3x1 specification to PHY table names

----------------------------------------------------------------
Dmitry Baryshkov (10):
      dt-bindings: pci: qcom: Document PCIe bindings for SM8450
      dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
      phy: qcom-qmp: Add SM8450 PCIe0 PHY support
      PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
      PCI: qcom: Add ddrss_sf_tbu flag
      PCI: qcom: Add SM8450 PCIe support
      arm64: dts: qcom: sm8450: add PCIe0 PHY node
      arm64: dts: qcom: sm8450: add PCIe0 RC device
      arm64: dts: qcom: sm8450-qrd: enable PCIe0 PHY device
      arm64: dts: qcom: sm8450-qrd: enable PCIe0 host

 .../devicetree/bindings/pci/qcom,pcie.txt          |  21 ++-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts            |  14 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 143 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |  88 ++++++++-----
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 125 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  33 +++++
 7 files changed, 388 insertions(+), 38 deletions(-)


