Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB82E551730
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiFTLUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiFTLUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 07:20:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192613EA9
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f39so1100437lfv.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BdBjPKb2OMlMXymj3k/aG9aHRMG/e+cldYNLP6jxtI4=;
        b=QQWbt983c0Z7ocu6x4vSbwKfaEaMSvkxU69k/odXCGhEBILqTpZyK7vEDa20SwDVuy
         XWuNkCp4HonlYw0l3jmj+X2vLVaJfrZXM8yCz9RyGQrldzDOtQsPkJgZD1iP/i3pYrai
         gn63sTs4ZCsulUjvybCAShi1NzkvATA2AQ0/Hq3bFsm8ANky0wKjxe6y5KlGIlqoaBRn
         ik/s8Tl59MSUa5DLq9xgEGyfWESd92rRHFy1Xt1wlfs5MCEfFchbBKWAWihwy6+jB1dd
         FTvN8iPxFXBORP7TfvNgCagzqJGbGPOyNnJ3BqbzRv9WHRNUyLkORP5dFA5kG0aF5r6b
         gvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BdBjPKb2OMlMXymj3k/aG9aHRMG/e+cldYNLP6jxtI4=;
        b=G59xbaQB0MziDFxG9oKxEPgX+wAHtqPQKeuyh318GneUgA9WQ9Dsk8SmHyw1JSO9/s
         cJ/MFaudkUL1eWbbslRe22gJZTsdGd5PFuM45uhH9I5MfVajp/UHOzubTFGi6srQrJQd
         IP4rmA8w8xjQf3tUcHZnJLVuNOTLujgi2aBqkb3bWT/r5cqkSowR0IS4cRhMJYp8Dtx8
         zGw7cQHM/ET/yKCS66ggvu7v8bkbLgSZg+7V6w+Nny8IZe8kaKbgNY5f+UdGWfhsxYca
         Tvc2CWWBAsrQ/dXjNYqT9R1qb4KdRmIpamncmTSWOilxIeKWmmx9AcLlLM6/U7GphQws
         w0mg==
X-Gm-Message-State: AJIora9wDjgtpVTXp0XW+OP9dpQkBP/uewpkkm+HZqNfAIDpH2BAwKDS
        qrS1G8jok94xxzKFbHDXznfwhQ==
X-Google-Smtp-Source: AGRyM1tgq0D+2mOvczZzl2V6C6hUw3/abf6zYQZy6kBwUD/TlnN2ZaLixb86avgWj9UYRFpjqWIGRQ==
X-Received: by 2002:a05:6512:401d:b0:47f:654d:e48d with SMTP id br29-20020a056512401d00b0047f654de48dmr5396084lfb.359.1655724016569;
        Mon, 20 Jun 2022 04:20:16 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b00478f5d3de95sm1727270lfr.120.2022.06.20.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:20:15 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v15 0/7] PCI: dwc: Fix higher MSI vectors handling
Date:   Mon, 20 Jun 2022 14:20:08 +0300
Message-Id: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

The last patch in the series is a revert of  [2] (landed in pci-next).
Bjorn Helgaas has removed the offending patch from his 5.19 pull
request, but the revert is still a part of this patch series as a
reminder to Lorenzo to drop the patch from his pci/qcom branch.

Changes since v14:
 - Fixed the dtschema warnings in qcom,pcie.yaml (reported by Rob
   Herring)

Changes since v13:
 - Changed msiX from pointer to the char array (reported by Johan).

Changes since v12:
 - Dropped split_msi_names array in favour of generating the msi_name on
   the fly (Rob),
 - Dropped separate split MSI ISR as requested by Rob,
 - Many small syntax & spelling changes as suggested by Johan and Rob,
 - Moved a revert to be a last patch, as it is now a reminder to
   Lorenzo,
 - Renamed series to name dwc rather than qcom, as the are no more
   actual changes to the qcom PCIe driver (Johan thanks for all
   suggestions for making the code to work as is).

Changes since v11 (suggested by Johan):
 - Added back reporting errors for the "msi0" interrupt,
 - Stopped overriding num_vectors field if it is less than the amount of
   MSI vectors deduced from interrupt list,
 - Added a warning (and an override) if the host specifies more MSI
   vectors than available,
 - Moved has_split_msi_irq variable to the patch where it is used.

Changes since v10:
 - Remove has_split_msi_irqs flag. Trust DT and use split MSI IRQs if
   they are described in the DT. This removes the need for the
   pcie-qcom.c changes (everything is handled by the core (suggested by
   Johan).
 - Rebased on top of Lorenzo's DWC branch

Changes since v9:
 - Relax requirements and stop validating the DT. If the has_split_msi
   was specified, parse as many msiN irqs as specified in DT. If there
   are none, fallback to the single "msi" IRQ.

Changes since v8:
 - Fix typos noted by Bjorn Helgaas
 - Add missing links to the patch 1 (revert)
 - Fix sm8250 interrupt-names (Johan)
 - Specify num_vectors in qcom configuration data (Johan)
 - Rework parsing of MSI IRQs (Johan)

Changes since v7:
 - Move code back to the dwc core driver (as required by Rob),
 - Change dt schema to require either a single "msi" interrupt or an
   array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
   part of the array (the DT should specify the exact amount of MSI IRQs
   allowing fallback to a single "msi" IRQ),
 - Fix in the DWC init code for the dma_mapping_error() return value.

Changes since v6:
 - Fix indentation of the arguments as requested by Stanimir

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
[2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/`

Dmitry Baryshkov (7):
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: split MSI IRQ parsing/allocation to a separate function
  PCI: dwc: Handle MSIs routed to multiple GIC interrupts
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts
  PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8
    endpoints"

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  51 +++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 161 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 10 files changed, 183 insertions(+), 54 deletions(-)

-- 
2.35.1

