Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2E51570E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiD2VqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbiD2VqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 17:46:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07107893F
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so16226850lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rfsZT6dTxDkMWDAw8DCDFhRyK+INRY0WxLhshoifq4U=;
        b=YStOtLBTj8uJz30nwyjlpZHJaT4M85B890bYSiMZiODlzWPzUDqtj9UaBfk2gwdgVG
         THgvu9jHdJmNCrNCE9Qxinjk34gRXkAaRGNNLzqb6hSVBKSsn6sVQ8a9Dy/IV6IxmfSM
         DtTIgM8nwTzktM/XGxo3kJsqDefd4uoDPcP5CuVLbW5VfznfUXgy13e6FKiE8Jt6iHpg
         jFDlkL/P4pLST2wPCnE0mMPLbyytcri6kv+OjNGqd7hXhex0LSqaN1tyNzPd8VRVt0Sd
         5BwVkb+p5/yscEZBFvzR20ZhIiMPQ1lAy6r/NzhaM9rkzUj/JpQRqftbPGheCi8JVsOf
         GAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rfsZT6dTxDkMWDAw8DCDFhRyK+INRY0WxLhshoifq4U=;
        b=JU75XOx0fSIbnEj0J5xqPI3842JooT1IKEqcsAgqhPssCHvOyeGj63TISqlnEKm5qf
         FM3g6ohySVXGBJ3NBE7OfsmkR/JChz6HAjkSoeWYankgCo4ES8aRx7H+ExELzOQ36P66
         nf8A9QSmbgErg9YhXVK6lQrMIGUpD08JU9tZBoBIcPor90/eGWDp1Xj1ldAf0ky/XOaJ
         btexPc2wzbkaiSi3Pw5YaGhJwrptFtbASpA1N8FODkl9SQofYjxKjpAsIzbizjETkAVi
         Z/QYe5LIjm5Te+w82qknS1zVEY1U9DKyDvbW1kNWG03q54T/gyAMtpoSqWcnF2W+h3CE
         Mjgw==
X-Gm-Message-State: AOAM531vDY28b0uw8evm2LFu4IHdziC16RGoRjrVjNS2UWqEGQQ19uF+
        6rlGLXxobPr2/DsgBXmn1wP/zQ==
X-Google-Smtp-Source: ABdhPJziFccC0MXMwUO0tViXcnZioUSJzQZ7JY0Zr3/oBNZQbAMOYmANJbOf9zvNC8M7gjZDl915HA==
X-Received: by 2002:a05:6512:324f:b0:472:31e:7b38 with SMTP id c15-20020a056512324f00b00472031e7b38mr858786lfr.625.1651268571362;
        Fri, 29 Apr 2022 14:42:51 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b0047255d211f6sm30520lfc.293.2022.04.29.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:42:50 -0700 (PDT)
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
Subject: [PATCH v5 0/7] PCI: qcom: Fix higher MSI vectors handling
Date:   Sat, 30 Apr 2022 00:42:43 +0300
Message-Id: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
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
in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
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

Since we can not expect that other platforms will use multi-IRQ scheme
for MSI mapping (e.g. iMX and Tegra map all 256 MSI interrupts to single
IRQ), it's support is implemented directly in pcie-qcom rather than in
the core driver.

Changes since v4:
 - Fix the minItems/maxItems properties in the YAML schema

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
  PCI: qcom: Handle MSI IRQs properly
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

