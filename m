Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A593542DA6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiFHKax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiFHK3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 06:29:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C65BDA1F
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:22:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q1so22204952ljb.5
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbKSfBNHMsB6gPQL/2rq+lhYEHklPNuzgxkaV0yDgno=;
        b=C8zmcSh8kYU52OoswL7DTEeRYlTehP7/3y+AfdFoA++vcRkdZcfFCNg6ZOfrnQp3ZI
         13+Y95T8Bh7U8yGWDvaMo+v2+1AFp1mfEgHkL5HNsHrPn5gu9BfNEkbrLw1vV8MicHna
         Zlqo3Arg8IucLqkr4Vv3HWcPri8OD8bPfZv593RWgOw9VfAaHUalCbOMGor2jrgVapyj
         Q7jxcVTFPPP8MkSbRilMYU0LlI0yfERdKBCOOvserLLoeTTQ6LeoN64O0/4pm9XYzQop
         DFBN4y651eeQ2f2Z20Ku4iS/3mihSqezWUJzJC5yCHIFkvsTpxrv4Dhes/Wwib+Fd+1E
         ZLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbKSfBNHMsB6gPQL/2rq+lhYEHklPNuzgxkaV0yDgno=;
        b=XrNojiiBlUP2Z7gst9BAA2NVYdif+3W6rfqR90JmO/OLdt2WdE2J/qAvs7+F4nQkcp
         aFMurL4yh5zk5QZZfwXYDr+zGHCi7OpmjCqDWDV41lttFbELKxcYlmRQKbUyjbLTE7EZ
         SlOTdqqYp6bZH53njtCwVLgmZ6poTtBu6AI03zT1GVmgbXq6LKd74Fe9Gt0ZMaeP0xiQ
         yfIiAzUe+4W+/XU4+UtHD1XasJmq1VhniRPzAQvTbqyGln59qiMtsmd9Vuv1l4Fzl1Eh
         UlakOwjCavFGescBRsF0Vw2OfxBK2bZWQ/Ach9oZi6OtnCt+7ExhrDm+gaGt2IwMJktm
         racw==
X-Gm-Message-State: AOAM5336urdE7OvlTgd64AG1yF905cl2b88x8eMdp5rwtNwzIY2XlyDR
        m7KS7BZ3mhtR0DWKB8s/J1EHFw==
X-Google-Smtp-Source: ABdhPJxcZzw3ShwMGJ6nR/dJ/fZjPdi5oqIicOs2LJhVAjvyxGcfnWH1a52O7RJlK1W83DrQE1jAdw==
X-Received: by 2002:a2e:87c9:0:b0:255:7e94:d93b with SMTP id v9-20020a2e87c9000000b002557e94d93bmr14386532ljj.396.1654683730706;
        Wed, 08 Jun 2022 03:22:10 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b00478fe3327aasm3642934lfd.217.2022.06.08.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:22:09 -0700 (PDT)
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
Subject: [PATCH v14 0/7] PCI: dwc: Fix higher MSI vectors handling
Date:   Wed,  8 Jun 2022 13:22:01 +0300
Message-Id: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
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
[2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/

Dmitry Baryshkov (7):
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: split MSI IRQ parsing/allocation to a separate function
  PCI: dwc: Handle MSIs routed to multiple GIC interrupts
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts
  PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8
    endpoints"

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  53 +++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 161 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 10 files changed, 185 insertions(+), 54 deletions(-)

-- 
2.35.1

