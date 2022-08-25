Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67A35A0E6C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiHYKuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 06:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241060AbiHYKut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 06:50:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25679AA4F7
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x24so953921lji.9
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=10qWqNWwct0k03IB/GKclWJkUQlncNZrJzbA4LyiZJo=;
        b=Rstp6Iplj0RUiP/cB/ximuaHD1evEKfdPdHQkicXj3MPSbqhrBRv2D7etIgt3YPnnR
         6YHOnOchsQi3PcKsSeUwC0pO3BNNdfY6YlqxXCwtVpVKtnPZPjN/pNfylmTQAoeUah8o
         KsYu2aXULW/3JEvcWYNXmEtuzKNLQ39AdSFcPZvOshEn8bzmvcHb/HRENy1f/+fxWLoj
         kDM0NNDn/FSXlKpsE7+Um8oHkROoEotPCO1u3boahatoQ8sLLAcxDE6bhoK9sACuEOuD
         sRiMnyMPdxCOFNgDgoyZfvJ/69juFN8OrxNxLdjbljPxCLnS5Tklqar4hoIYsEx6+fUY
         J2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=10qWqNWwct0k03IB/GKclWJkUQlncNZrJzbA4LyiZJo=;
        b=YaC2tlczcV3hmuY7AkQKtP2hjPwZNnZmJVjiQiZB1+pH4fVtuq/aTFEESt4de/aFlL
         QdG3juVr21VSPnOnsOl1Vgb4OsqmHur/pV+gJljVaCLeRFsppCmqfgKiayifBEH3GpdA
         zlMbd9s1ueGG6L6IAxq0djD/prdzDFmu7dXkTTLlLAOsTmsVG0umMIhDiCMaISv0QLNV
         5ww+CbsH1rHxk3p7EkZO8qfXJaF6Dpm3smbJnIy5KSB8AMC1dQx2t1EBfILOMaCJvNU+
         NfxFmGzSz2MCXVBHj+Qenv76b55TOna/s2CVV2YSrIJmZ9Per5qg4aYfKiksiQEzDYq5
         Xxlg==
X-Gm-Message-State: ACgBeo1M7/0SzEizk7xQL1TTNx9ZZN3ZdJAsp2wSd5ebA330egVn+E9q
        UJe8Ajba0CoWi5vvg+Ik1cAsgA==
X-Google-Smtp-Source: AA6agR6/3sRBbr7+OueBdJ0egxRoqKNqNFMwj7yOhEJNlfmxYJEbkyeM29cHOZvlUABzy3PXyDWOxA==
X-Received: by 2002:a05:651c:1025:b0:261:c071:c473 with SMTP id w5-20020a05651c102500b00261c071c473mr926266ljm.71.1661424646349;
        Thu, 25 Aug 2022 03:50:46 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u14-20020ac258ce000000b00492f49037dfsm429609lfo.152.2022.08.25.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:50:45 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v2 0/6] PCI: qcom: Support using the same PHY for both RC and EP
Date:   Thu, 25 Aug 2022 13:50:38 +0300
Message-Id: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Programming of QMP PCIe PHYs slightly differs between RC and EP modes.

Currently both qcom and qcom-ep PCIe controllers setup the PHY in the
default mode, making it impossible to select at runtime whether the PHY
should be running in RC or in EP modes. Usually this is not an issue,
since for most devices only the RC mode is used. Some devices (SDX55)
currently support only the EP mode without supporting the RC mode (at
this moment).

Nevertheless some of the Qualcomm platforms (e.g. the aforementioned
SDX55) would still benefit from being able to switch between RC and EP
depending on the driver being used. While it is possible to use
different compat strings for the PHY depending on the mode, it seems
like an incorrect approach, since the PHY doesn't differ between
usecases. It's the PCIe controller, who should decide how to configure
the PHY.

This patch series implements the ability to select between RC and EP
modes, by allowing the PCIe QMP PHY driver to switch between
programming tables.

Note, there is no direct dependency between PCIe and PHY parts of these
series, so these patches can be merged into respective subsystem trees
separately.

Changes since v1:
- Split the if(table) removal to the separate patch
- Expanded commit messages and comments to provide additional details
- Fixed build error on pcie-qcom.c
- Added support for EP mode on sm8450 to demonstrate the usage of this
  patchset

Changes since RFC:
- Fixed the compilation of PCIe EP driver,
- Changed pri/sec names to primary and secondary,
- Added comments regarding usage of secondary_rc/_ep fields.

Dmitry Baryshkov (6):
  phy: qcom-qmp-pcie: drop if (table) conditions
  phy: qcom-qmp-pcie: split register tables into primary and secondary
    part
  phy: qcom-qmp-pcie: support separate tables for EP mode
  PCI: qcom: Setup PHY to work in RC mode
  PCI: qcom-ep: Setup PHY to work in EP mode
  phy: qcom-qmp-pcie: Support SM8450 PCIe1 PHY in EP mode

 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +
 drivers/pci/controller/dwc/pcie-qcom.c        |   4 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 261 ++++++++++++------
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |   1 +
 4 files changed, 188 insertions(+), 82 deletions(-)

-- 
2.35.1

