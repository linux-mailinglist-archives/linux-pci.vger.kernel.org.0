Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFC4CAFBF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiCBUbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243383AbiCBUbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:31:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81651CE90B
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 12:30:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b8so2805531pjb.4
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6sWy4/TaV/KEk/+p6c6dVcypbRzCQ7sFtzJvPWQsaOI=;
        b=KkDF9fD1aWCQdGpFKtwwZbjnDIO8irQgmjEl86HZtZdrvvngBzTN4etG/0Ri6EF8W6
         gMjaGwx6mPFE5tvqtCqNgypumEuw2QZAD1N1642E59+v5ByGHPhGH9lJ2zM90ouUK6cP
         mk2zIxUhix+67Y2g2+1ne7sR8OZKJouX1rkVUKxSjKCsMdF82c3fkR6/9Zh7LfOzsQnX
         DbNCC0SJOO7393Hbq8y+A1jATFLitQBiF6Qx6DQlGrEWo6fOf3wE2u/d4ao1OHl9bLR6
         pQNuJIuZNbiUsmX5wNg4bIx7V17TyPm2TZ/aXgoUYSGzHg6dio+V6cOGs3i8dqWocvz/
         VCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6sWy4/TaV/KEk/+p6c6dVcypbRzCQ7sFtzJvPWQsaOI=;
        b=oTI1zNmZTbZDjupuyt0xzVNHE7gVarkqKVQstEuVL8A7ho528P1RSGRTBOsSK5KolO
         /+9e8J+/cUDh/6fBtqEtpFIGW3BRAk28BCTxuAV6ZZ4zB9KDVFSsHd+Q7poJnhit4TyM
         BuM+aioEfuGdPyR7TiYxKT/aRXtYLQt47bvHmyOVK704g0wZYbV+tvJNPe1bYAxRaFXe
         6VgJTkmNJpw0r3uJu+T0OS/ZaBvlLQI5aWccD7DKc7uI1R7KT3rcQvm56MCfSHwFKa2D
         r7k7JS+psf6FlmUdkYX4RCwYuMQKo7Uy7UdPAEopo1xOu4ppFUKFJFo2dniJQ2L0NMZS
         3euA==
X-Gm-Message-State: AOAM530PsqniJORpnYlX742L7/Hc/2w1fGwqVxPExr78Ayr4esW2PUSb
        u+RYENgTuXdGImiEo/vC90MOUA==
X-Google-Smtp-Source: ABdhPJwTwrT5eJMRvTA9IudLJVLqPucmAFpRbgQ3mbKPzWCx3jJcKSGaUJR72m8GCOdOi3JHdtzcYw==
X-Received: by 2002:a17:90a:d90b:b0:1bc:4ec7:d867 with SMTP id c11-20020a17090ad90b00b001bc4ec7d867mr1596549pjv.226.1646253056940;
        Wed, 02 Mar 2022 12:30:56 -0800 (PST)
Received: from localhost.localdomain ([182.64.85.91])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm5963410pjq.17.2022.03.02.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:30:56 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 0/7] Add PCIe support for SM8150 SoC
Date:   Thu,  3 Mar 2022 02:00:38 +0530
Message-Id: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
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

Changes since v2:
-----------------
- v2 can be found here: https://lore.kernel.org/linux-arm-msm/20220301072511.117818-1-bhupesh.sharma@linaro.org/T/
- Fixed review comments from Dmitry and Bjorn.
- Modified [PATCH 3/7] from v1 to include gdsc driver structs and
  support code for PCIe0 and PCIe1 (in addition to defines for the
  same).

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
  clk: qcom: gcc: Add PCIe0 and PCIe1 GDSC for SM8150
  phy: qcom-qmp: Add SM8150 PCIe QMP PHYs
  PCI: qcom: Add SM8150 SoC support
  arm64: dts: qcom: sm8150: Add PCIe nodes
  arm64: dts: qcom: sa8155: Enable PCIe nodes

 .../devicetree/bindings/pci/qcom,pcie.txt     |   5 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |   4 +
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      |  42 +++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 243 ++++++++++++++++++
 drivers/clk/qcom/gcc-sm8150.c                 |  20 ++
 drivers/pci/controller/dwc/pcie-qcom.c        |   8 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           |  90 +++++++
 include/dt-bindings/clock/qcom,gcc-sm8150.h   |   2 +
 8 files changed, 412 insertions(+), 2 deletions(-)

-- 
2.35.1

