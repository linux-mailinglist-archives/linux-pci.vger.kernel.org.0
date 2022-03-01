Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E654C84EB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 08:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiCAH0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 02:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiCAH0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 02:26:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EDF7A9A2
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:25:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ay5so9947067plb.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fq9+hKXE2B25/q7SGHJTgmlpE5pNGMn67wmPQ/2AfFA=;
        b=gw+AgpqERSMLyvVAkktbZBdBQAxCpln9+7y5E4lCT6UDIE8RSSZw3sHef0pgS+cDcP
         0CSs/PdWEOtNhMq+K42nTRPmww08VKf9MHYaOwy7QRMoo5/yAZry4qWzXkJWuf86v9Fa
         ZJPTuWFy5R4R0DZeqlZKsIAztbRIHQOgdOnTofkoNFQ7XQvrsW7xRPYnx5R72vMROM/B
         oYE4pAxMVK1aCdg9OYq+zGOS9qXSQ429BqHYAbDf12OeRrwscs0AxHrzehBFOejwaDse
         2xzfkpQf6u8PIIv5EYYaSi8iHkVBRzlwItd49jGo5CNE+HJEbiWgFC8J/HhCHU/T/kmo
         XMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fq9+hKXE2B25/q7SGHJTgmlpE5pNGMn67wmPQ/2AfFA=;
        b=jFTO+GpRk1FkPeFHC2py9UDTkFOAEiZ4yNR9yMIAOusYs6qeO+vK5Om/bGh7aUPd4S
         b0DcSDDpex8g8KvV5m8z52NipBX0iOGhYUXyql4lO7Ne59GJYHq9/UQ0nsDrC0mpFseC
         FhYbLA+/JgAJ3lUDxRyQoK40ze0epOuHRBycTf2+JbrllLofHjiefftrfXaq/W598dzb
         Wm3EHyMLluY8R64GMxyWfdOQjOQx5Z0+7uxeQi0kQlhnb/DZJnIMGsEQiwFzrvyy4OuE
         LogbCO2c3bVNli1KYOUNvzrQhNtJdHZ0F6GZQm/uUpyrLCaldAqwsn+OdwWjEiNh82im
         NxWA==
X-Gm-Message-State: AOAM531kiYR25U6wOWd2CQVaDW2we/XLy9/K7SX35j/RRDbHmnwOeu8h
        JDHv4j4aL0U3peRPmv9YhkCU9amcunc54w==
X-Google-Smtp-Source: ABdhPJyQpoHq58XxxDiH1vNEtJGyB3ROg2E9nRNb6DbulnTpMJjY+JTpp9jWTnRHJzb8qLKPuHtgwQ==
X-Received: by 2002:a17:90a:9306:b0:1bc:9256:5477 with SMTP id p6-20020a17090a930600b001bc92565477mr20937679pjo.170.1646119529474;
        Mon, 28 Feb 2022 23:25:29 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm15680445pfh.153.2022.02.28.23.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:25:29 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 0/7] Add PCIe support for SM8150 SoC
Date:   Tue,  1 Mar 2022 12:55:04 +0530
Message-Id: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v1:
-----------------
- v1 can be found here: https://lore.kernel.org/linux-arm-msm/20220223192946.473172-1-bhupesh.sharma@linaro.org/T/
- Collected ACKs on [PATCH 1/7], [PATCH 2/7] and [PATCH 4/7] from Rob
  and Dmitry.
- Broke down another separately sent out PATCH (see [1]), into a 3 patches (one each for emac, pci
  and ufs gdsc defines) - one of which is carried as [PATCH 3/7]
  in this series, which fixes a compilation error.
  The rest of the gdsc defines have been sent out as separate patch(es).
[1]. https://patchwork.kernel.org/project/netdevbpf/patch/20220126221725.710167-4-bhupesh.sharma@linaro.org/
- Rob's bot reported a number of 'dtbs_check' errors with the v1 series,
  which are been fixed with a separate series now (see [2]), to ease the
  review of this series.
[2]. https://lore.kernel.org/linux-arm-msm/20220228123019.382037-1-bhupesh.sharma@linaro.org/T/


This series adds PCIe support for Qualcomm SM8150 SoC with relevant PHYs.
There are 2 PCIe instances on this SoC each with different PHYs. The PCIe
controller and PHYs are mostly compatible with the ones found on SM8250
SoC, hence the old drivers are modified to add the support.

This series has been tested on SA8155p ADP board with QCA6696 chipset connected
onboard.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>

Bhupesh Sharma (7):
  dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
  dt-bindings: phy: qcom,qmp: Add SM8150 PCIe PHY bindings
  clk: qcom: gcc: Add PCIE_0_GDSC and PCIE_1_GDSC for SM8150
  phy: qcom-qmp: Add SM8150 PCIe QMP PHYs
  PCI: qcom: Add SM8150 SoC support
  arm64: dts: qcom: sm8150: Add pcie nodes for SM8150
  arm64: dts: qcom: sa8155: Enable pcie nodes

 .../devicetree/bindings/pci/qcom,pcie.txt     |   5 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |   4 +
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      |  42 +++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 243 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  16 ++
 drivers/phy/qualcomm/phy-qcom-qmp.c           |  90 +++++++
 include/dt-bindings/clock/qcom,gcc-sm8150.h   |   2 +
 7 files changed, 400 insertions(+), 2 deletions(-)

-- 
2.35.1

