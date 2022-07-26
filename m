Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15045581B17
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiGZUeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiGZUeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 16:34:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB44C11168
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 13:34:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q7so2291571ljp.13
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LBgfLrjfrDzFKMd04kVmm9cQnQP6aRPvjjtNa3eyuWY=;
        b=IPrAYfeo0Ayz6XdL7LQp+CxK6bh+AlcqHl+DTv//M50yF8BB6VfDiGJZMgiWyGapX9
         qEVmhIHwdOfE5sIMZ1BFcmtmkYJwuLoTN+ZA9oahViyotPsNBT3Ark6muE3ohERSZe/Y
         LSEfuY0Gd1SuPoaJ/u7enrEEVMtKjRX+6fNnDJ6RX8qPsXq6ApSGEKslh9skY0Mo2uh0
         7FxwLuXmoZ8B7HWjALpmXN4fv0/wh9KGUF8BxZgZCLZYzfm7oSFia6GLN4g+FJiVGsBd
         Tyhy1jEm/P6bYaGZnrEZjxWkGoaxjjmkyuAt3A39wvIOe8WI6XbyakNbCBQ3iR82LieH
         vpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LBgfLrjfrDzFKMd04kVmm9cQnQP6aRPvjjtNa3eyuWY=;
        b=D5szh/w+9GWTOu1H56/mA2pqonDtd33ZO3GpmIOvfY2Zb7dI++d1ek0XUBVCsJcqyi
         egeJ4Zb/ewDqXRT0Fg7sI1/l8wvX3JPaby+3Wz+LTVG10JUKyS/FCeyQVETqwEaUM3qj
         a+AYCs8wt1z6x07L4flO8IQCofAadUzPG9oUDf+yKbeg70lMhhsITYUNbVPsh95+ymDT
         oldBzzFKMe+pZ4yqjl4nClbDP2boJxNsktjsrMMQFLMC0B8ZxJdiCIE13hxPJQWm2G3m
         B5BRj8e6CwrdfeTVxYzMSfq5N77QvoWsgGwKhdIcn/u1duX8zqfiQajFQlCnkyLAEzd9
         aP3A==
X-Gm-Message-State: AJIora/tGOKvGKlyl4eZ8mcw6MaLhFbd8MWDGf+Pqc3TCW6Xgut8Jkl0
        oF3UteAcTjvZbP8BvUWUhK7h6A==
X-Google-Smtp-Source: AGRyM1uf8Wk/0bZLrZKza6HRO1fAvjkNQdRTIc6YaIrx7QPGXWmmDIMLIPP6vWcZwr9draHq70JcWQ==
X-Received: by 2002:a2e:9942:0:b0:25e:887:3fc7 with SMTP id r2-20020a2e9942000000b0025e08873fc7mr3615481ljj.303.1658867643212;
        Tue, 26 Jul 2022 13:34:03 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o14-20020ac24e8e000000b0048a8899db0fsm1468548lfr.7.2022.07.26.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:34:02 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: [PATCH v1 0/4] PCI: qcom: Support using the same PHY for both RC and EP
Date:   Tue, 26 Jul 2022 23:33:57 +0300
Message-Id: <20220726203401.595934-1-dmitry.baryshkov@linaro.org>
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

Note, there is no direct dependency between PCIe and PHY parts of these
series, so these patches can be merged into respective subsystem trees
separately.

Changes since RFC:
- Fixed the compilation of PCIe EP driver,
- Changed pri/sec names to primary and secondary,
- Added comments regarding usage of secondary_rc/_ep fields.

Dmitry Baryshkov (4):
  phy: qcom-qmp-pcie: split register tables into primary and secondary
    part
  phy: qcom-qmp-pcie: support separate tables for EP mode
  PCI: qcom: Setup PHY to work in RC mode
  PCI: qcom-ep: Setup PHY to work in EP mode

 drivers/pci/controller/dwc/pcie-qcom-ep.c |   4 +
 drivers/pci/controller/dwc/pcie-qcom.c    |   4 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 169 +++++++++++++---------
 3 files changed, 109 insertions(+), 68 deletions(-)

-- 
2.35.1

