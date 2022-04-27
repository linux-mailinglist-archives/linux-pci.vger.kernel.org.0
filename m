Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB54C51171E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiD0MUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiD0MUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 08:20:09 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9CD4F469
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 05:16:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v1so2384503ljv.3
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6aOLiTbTHPpwC6/N693jQaBYx382sO4NTvihp2ISpY=;
        b=um/EGhHwrSYrco330Ra74BaYCYhGUywRCR+/wKFWfV08uq92q3YvAKNtEChhrqDc+d
         Nn3tT4srhrKWUBYXNV+jDJbtTI7bDbg2DjvTbJGxC5HuSN+KoSqlbeu/kCqYZdPowUXc
         cyEgCsjtFE/YWIsRk4hp6j7qiyAfO+8ToQjnHUGRLWs/wZ7IsbQN9goHljvwgU5G3n4Y
         WlLr9+vtfm3CpnUsCWKfx8k/3z67qj0GNuXi0Qd169CN9ZlAdCfko7apEH42sVmPH96F
         mw+IljZgrKF/vF/b05WT0jz/O+qKcYPIokVhh5zLejYwTQ61OIi0JtLv3s4dDbe7bAe2
         N9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6aOLiTbTHPpwC6/N693jQaBYx382sO4NTvihp2ISpY=;
        b=a7tDRxA7qA9bsOgOGO7/DIhNh+hp8ubpLt69nAaQ4Aq28PdTEc/FXs5lBjJ5eFT0XQ
         byezuWojklLaOdl0J2bLeOlNCv6hjOt+SYKmbBSQo35U+oQSZi+2Zm4xJxk4ZKDRGfEd
         xOXQX126Q77vMBtslynwUTFMSslpiy6/NNW3W4mjl3K8I2XMaz1tlGooolwW8E0IisVd
         j1IeSJxpxgHxMrOp9TSvSsqR7YLlNq/vwmIdC0yop3EzYVBtV18bfw1TUPtyqBE/LeOb
         aa+REqPttVyzd0UtyBRRfWKNJCoGXJ+yKhNLAEJwNtm7LfzEyxjoJvO/rO/Hj/fv9YmY
         srVA==
X-Gm-Message-State: AOAM533dKQ4uDJoBT7f9y0+HLS6GC7H3q7MT2dpVjbH2hm0yw0QVRuAF
        7AlG9dU6x5b6XqLzURrakt5n6A==
X-Google-Smtp-Source: ABdhPJzeF8/5ARTNhRbUnCJXx+mnzG0w3JO37uiTWrbSLzgPUy84U6expwdcxlyOweEzDpcTrqikeg==
X-Received: by 2002:a2e:bf1a:0:b0:249:3a3b:e90e with SMTP id c26-20020a2ebf1a000000b002493a3be90emr18605212ljr.317.1651061816116;
        Wed, 27 Apr 2022 05:16:56 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y1-20020a0565123f0100b0044584339e5dsm2043388lfa.190.2022.04.27.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:16:55 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/5] PCI: qcom: Fix higher MSI vectors handling
Date:   Wed, 27 Apr 2022 15:16:48 +0300
Message-Id: <20220427121653.3158569-1-dmitry.baryshkov@linaro.org>
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

I have replied with my Tested-by to the patch at [2], which has landed
in the linux-next as the commit 8ae0117418f3 ("PCI: qcom:
Add support for handling MSIs from 8 endpoints"). However lately I
noticed that during the tests I still had 'pcie_pme=nomsi', so the
device was not forced to use higher MSI vectors.

After removing this option I noticed that hight MSI vectors are not
delivered on tested platforms. After additional research I stumbled upon
a patch in msm-4.14 ([1]), which describes that each group of MSI
vectors is mapped to the separate interrupt. Implement corresponding
mapping.

Patchseries dependecies: [2] (landed in pci-next) and [3] (for the
schema change).

Changes since v2:
 - Fix and rephrase commit message for patch 2.

Changes since v1:
 - Split a huge patch into three patches as suggested by Bjorn Helgaas
 - snps,dw-pcie removal is now part of [3]

[1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
[2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
[3] https://lore.kernel.org/linux-arm-msm/20220422211002.2012070-1-dmitry.baryshkov@linaro.org/

Dmitry Baryshkov (5):
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: Teach dwc core to parse additional MSI interrupts
  PCI: qcom: Handle MSI IRQs properly
  dt-bindings: pci/qcom,pcie: support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 12 ++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 11 +++-
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 53 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
 10 files changed, 69 insertions(+), 21 deletions(-)

-- 
2.35.1

