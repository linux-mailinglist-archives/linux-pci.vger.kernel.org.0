Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0DC51BB88
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbiEEJQN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbiEEJQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:16:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76CF4BFCB
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:12:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p12so6438072lfs.5
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1hwYduATVUubw2CTq7bwUW/+zl1UNQFZMTQJfdzfD8=;
        b=rDZ8LaSQczTzmEbvuyNUR+frFk3QOyPyeHzEyIBiBEeUQM65kLu+xaa9XvoJGQH5Pj
         ktQ+zb2Xb3aGJwqPkGz0HgEuIHkwIcFRr57n57xb2hWlan/V28NikkNNwGSs6NXYrbwx
         VojhtAxygKv+HJabKYQebUefUQyMRvh9Fu7gyeBM0Dgk4cL3bVcdGwgOvvUPuFCOfONH
         F0AgqLcYuic/jtju1lu/MEUcEqAmN6omyYjlmclbUyJmYjk/2AZO/Ela0RfdlyjShw/q
         g69iUy9lL1cYOW6NyTvaOrTMP/Hh0RM9L4SkLzN4OU941fcY7AYmU8bDIPrmoA257Cd1
         MqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1hwYduATVUubw2CTq7bwUW/+zl1UNQFZMTQJfdzfD8=;
        b=xONwS9wvD+wARFmXqd0vJRjX2TjM4Y524z6yjXvFbv3t6RGuGzV5HTMRwua2yQ50Rx
         vUqW35EPw4mZZk1gu7I6PuOdLhc+VjPy2h+i3s1afuvZLMlYM21S2dRYwya7M8sB3hGZ
         Ixp/jRWAikI6lUvahEhhHePgYLPqv5EUxvV8p4K5nyqWgS9Sc+ugD7zbeFlXeQdaQdIb
         1/2x5pM2P027+/oVMiE7pqNNHmflAa82D4Y440qDUEW/w4U3idluPrTGfmXqamJutQaM
         MXNOHUisImJ6OvUVHZpTPIqnOtMMntKwioifMxAsLajtSaQmwbE5XgOVsByDmOgwbh61
         /0Fg==
X-Gm-Message-State: AOAM532/giwzpPD4LYx8krgHZChpzsNBo1b5TTYf+ovAfxQDlOV7WZVS
        WLno0vGvyZr/m0QsszLsgk/1NQ==
X-Google-Smtp-Source: ABdhPJwKgRtBVYmKYoxZTC/t1AwJfvkW+LeL/foLByDBu2EVqW7+E0dsE5xcXjAggS+UChNV6i4nvA==
X-Received: by 2002:a05:6512:2312:b0:472:5de2:ddf0 with SMTP id o18-20020a056512231200b004725de2ddf0mr14067245lfu.134.1651741952054;
        Thu, 05 May 2022 02:12:32 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2593a000000b0047255d211e8sm133564lfi.279.2022.05.05.02.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:12:31 -0700 (PDT)
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
Subject: [PATCH v6 0/7] PCI: qcom: Fix higher MSI vectors handling
Date:   Thu,  5 May 2022 12:12:24 +0300
Message-Id: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
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

I have replied with my Tested-by to the patch at [2], which has landed
in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
Add support for handling MSIs from 8 endpoints"). However lately I
noticed that during the tests I still had 'pcie_pme=nomsi', so the
device was not forced to use higher MSI vectors.

After removing this option I noticed that hight MSI vectors are not
delivered on tested platforms. After additional research I stumbled upon
a patch in msm-4.14 ([1]), which describes that each group of MSI
vectors is mapped to the separate interrupt. Implement corresponding
mapping.

Since we can not expect that other platforms will use multi-IRQ scheme
for MSI mapping (e.g. iMX and Tegra map all 256 MSI interrupts to single
IRQ), it's support is implemented directly in pcie-qcom rather than in
the core driver.

The first patch in the series is a revert of  [2] (landed in pci-next).
Either both patches should be applied or both should be dropped.

Patchseries dependecies:[3] (for the schema change).

Changes since v5:
 - Fixed commit subject and in-comment code according to Bjorn's
   suggestion,
 - Changed variable idx to i to follow dw_handle_msi_irq() style.

Changes since v4:
 - Fix the minItems/maxItems properties in the YAML schema.

Changes since v3:
 - Reimplement MSI handling scheme in the Qualcomm host controller
   driver.

Changes since v2:
 - Fix and rephrase commit message for patch 2.

Changes since v1:
 - Split a huge patch into three patches as suggested by Bjorn Helgaas
 - snps,dw-pcie removal is now part of [3]

[1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
[2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
[3] https://lore.kernel.org/linux-arm-msm/20220422211002.2012070-1-dmitry.baryshkov@linaro.org/

Dmitry Baryshkov (7):
  PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8
    endpoints"
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Add msi_host_deinit callback
  PCI: dwc: Export several functions useful for MSI implentations
  PCI: qcom: Handle MSIs routed to multiple GIC interrupts
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  45 +++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  11 +-
 .../pci/controller/dwc/pcie-designware-host.c |  72 +++++----
 drivers/pci/controller/dwc/pcie-designware.h  |  12 ++
 drivers/pci/controller/dwc/pcie-qcom.c        | 138 +++++++++++++++++-
 5 files changed, 246 insertions(+), 32 deletions(-)

-- 
2.35.1

