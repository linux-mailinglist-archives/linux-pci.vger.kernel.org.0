Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433025E8E44
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiIXQDK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiIXQDJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 12:03:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E602B386BA
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i26so4600614lfp.11
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BucyVOTsY93CmgDyVGjJvCDbPEfzNq863eBEEbR0ty8=;
        b=P8iGfXM7V6D4PZU/Rq9v2t6Wz7Ww4eUzr8f2CGVtC9TxKUOKUDT0Qn+cOXuqKmmfht
         n/zW35BOL37tMg2mkRNgSHnoWHB/v6CbmVIsH81Cg9+Qt8yku2hzWapyVUu4qaMphlTo
         x64l7DrN1M8ceHYp4ObS2L297GC4gsAYl13Efa4otrwxpb+t8LL4jYCoQBcJiXKJKd5y
         G5z98gu7LMcENPuHjkqEUITbkQpJVKm/T2nnJAPi3qjVQzmobadAxUR/Ib+via5ROYM7
         gEp8Vb7eoiBi06IEePKCIntawSR7cSTO97DBWesQ4aKyMUziLCwIIXQHO4MNcxDigBIr
         mFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BucyVOTsY93CmgDyVGjJvCDbPEfzNq863eBEEbR0ty8=;
        b=K9vtFx6+Uh7TJAYuQVHEJfb4mKTAk/0czCVjckMg0ZqsrtInfeQDjBwdBFosmCpa9K
         +b4+wfBLeiu1pyLLAIAiyBiDSLZDIaafXho9koaCRLnNaE8bbUwM1bEpfjwA/QnTM1ON
         FzYKzKmN7AiMzIN/ZA8YCAaCe6YyCOnLnOaOK6gB3PibTLmPvwU4vDJzifZDcq4/2rGW
         K42LIqP2xf4AnLkTKJCx6HFf+XTb72HCkDJ06JdA7g9kOVdt1fVC3fa9QDc1N9MfKLy5
         MYsMpzpT7tjQlrBj/x/ePlQc01ySqXTgyCY8n/CkdAhauEn4rBSbFAhZ7Nlnn8016L0X
         u+vQ==
X-Gm-Message-State: ACrzQf1xWlIz6obpKjHmG4WJyFTTi0CpPcigwANSKqFdKqckq6R9ESta
        TKUV6YNw9/dZLWxRJZtSpM7/TA==
X-Google-Smtp-Source: AMsMyM5+juhEb5OjwTdEs+P0qVZDQxw0PADVmXoMvEDJQAeFTGQ7aObsoWWWg7512TTP4B/tU9YgMA==
X-Received: by 2002:a05:6512:3f8b:b0:492:d1ed:5587 with SMTP id x11-20020a0565123f8b00b00492d1ed5587mr5801675lfa.355.1664035384150;
        Sat, 24 Sep 2022 09:03:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([95.161.222.31])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm1928015lfq.207.2022.09.24.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:03:03 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v4 0/6] PCI: qcom: Support using the same PHY for both RC and EP
Date:   Sat, 24 Sep 2022 19:02:56 +0300
Message-Id: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

This patchseries depends on the header from the pre-6.1 phy/next. Thus
after the 6.1 the PCIe patches can be applied independently of the PHY
part.

Changes since v3:
- Rebased on top of phy/next to pick in newly defined
  PHY_MODE_PCIE_RC/EP.
- Renamed 'main' to 'common' and 'secondary' to 'extra' to reflect the
  intention of the split (the 'common' tables and the 'extra for the ...
  mode' tables).
- Merged the 'pointer' patch into first and second patches to make them
  more obvious.

Changes since v2:
- Added PHY_SUBMODE_PCIE_RC/EP defines (Vinod),
- Changed `primary' table name to `main', added extra comments
  describing that `secondary' are the additional tables, not required in
  most of the cases (following the suggestion by Johan to rename
  `primary' table),
- Changed secondary tables into the pointers to stop wasting extra
  memory (Vinod),
- Split several functions for programming the PHY using these tables.

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
  phy: qcom-qmp-pcie: split register tables into common and extra parts
  phy: qcom-qmp-pcie: split PHY programming to separate functions
  phy: qcom-qmp-pcie: support separate tables for EP mode
  phy: qcom-qmp-pcie: Support SM8450 PCIe1 PHY in EP mode
  PCI: qcom: Setup PHY to work in RC mode
  PCI: qcom-ep: Setup PHY to work in EP mode

 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   5 +
 drivers/pci/controller/dwc/pcie-qcom.c        |   5 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 298 +++++++++++++-----
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |   1 +
 4 files changed, 229 insertions(+), 80 deletions(-)

-- 
2.35.1

