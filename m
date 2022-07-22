Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8E57E515
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiGVRJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiGVRJz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 13:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4952ED7F;
        Fri, 22 Jul 2022 10:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE3E862248;
        Fri, 22 Jul 2022 17:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14512C341C6;
        Fri, 22 Jul 2022 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658509793;
        bh=UUbRBKWVeGHZHwMFqZyWvsxxy4PW3iiMORZIF9kp2cI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p8thjEVXTZwEzGsVr63Ac2fnmfQlC34kxdpSQA372tE05zA/99ujdjQQtTTVoYtbs
         F0o2JrZPKFL78JiPNCoN319cKCXVV0sbDYBKpVeZu0LvlPWBezLIX8Ymn+PgohP3at
         tSsrFZ+OHJXCdWh5f1dW18IDAt2EVvQ3h70VNbKP20Vhgh51n8gqTm3mGmvnsTC7qx
         35oF3jigP2sL8nbNYrqBg7fJhspuHzIxZVuVNqsba44wiovCPaPUJ0JDWpPRsjZgEr
         NZk6aDgGR8vzwPFO9MEXebUVwGrCLRUKoKXJ4a30BK6sERvdA5lsVavJzxMAgcmd98
         xNihxoauENJeg==
Date:   Fri, 22 Jul 2022 12:09:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v17 0/6] PCI: dwc: Fix higher MSI vectors handling
Message-ID: <20220722170951.GA1907863@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 04:47:27PM +0300, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not
> delivered on tested platforms. After additional research I stumbled upon
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt. Implement corresponding
> mapping.
> 
> Changes since v16:
>  - Fix a typo in the dt schema (noticed and fixed by Johan).
> 
> Changes since v15:
>  - Rebased on top of linux-next to take care of the conflict with the
>    comit 27235cd867cf ("PCI: dwc: Fix MSI msi_msg DMA mapping").
> 
> Changes since v14:
>  - Fixed the dtschema warnings in qcom,pcie.yaml (reported by Rob
>    Herring)
> 
> Changes since v13:
>  - Changed msiX from pointer to the char array (reported by Johan).
> 
> Changes since v12:
>  - Dropped split_msi_names array in favour of generating the msi_name on
>    the fly (Rob),
>  - Dropped separate split MSI ISR as requested by Rob,
>  - Many small syntax & spelling changes as suggested by Johan and Rob,
>  - Moved a revert to be a last patch, as it is now a reminder to
>    Lorenzo,
>  - Renamed series to name dwc rather than qcom, as the are no more
>    actual changes to the qcom PCIe driver (Johan thanks for all
>    suggestions for making the code to work as is).
> 
> Changes since v11 (suggested by Johan):
>  - Added back reporting errors for the "msi0" interrupt,
>  - Stopped overriding num_vectors field if it is less than the amount of
>    MSI vectors deduced from interrupt list,
>  - Added a warning (and an override) if the host specifies more MSI
>    vectors than available,
>  - Moved has_split_msi_irq variable to the patch where it is used.
> 
> Changes since v10:
>  - Remove has_split_msi_irqs flag. Trust DT and use split MSI IRQs if
>    they are described in the DT. This removes the need for the
>    pcie-qcom.c changes (everything is handled by the core (suggested by
>    Johan).
>  - Rebased on top of Lorenzo's DWC branch
> 
> Changes since v9:
>  - Relax requirements and stop validating the DT. If the has_split_msi
>    was specified, parse as many msiN irqs as specified in DT. If there
>    are none, fallback to the single "msi" IRQ.
> 
> Changes since v8:
>  - Fix typos noted by Bjorn Helgaas
>  - Add missing links to the patch 1 (revert)
>  - Fix sm8250 interrupt-names (Johan)
>  - Specify num_vectors in qcom configuration data (Johan)
>  - Rework parsing of MSI IRQs (Johan)
> 
> Changes since v7:
>  - Move code back to the dwc core driver (as required by Rob),
>  - Change dt schema to require either a single "msi" interrupt or an
>    array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
>    part of the array (the DT should specify the exact amount of MSI IRQs
>    allowing fallback to a single "msi" IRQ),
>  - Fix in the DWC init code for the dma_mapping_error() return value.
> 
> Changes since v6:
>  - Fix indentation of the arguments as requested by Stanimir
> 
> Changes since v5:
>  - Fixed commit subject and in-comment code according to Bjorn's
>    suggestion,
>  - Changed variable idx to i to follow dw_handle_msi_irq() style.
> 
> Changes since v4:
>  - Fix the minItems/maxItems properties in the YAML schema.
> 
> Changes since v3:
>  - Reimplement MSI handling scheme in the Qualcomm host controller
>    driver.
> 
> Changes since v2:
>  - Fix and rephrase commit message for patch 2.
> 
> Changes since v1:
>  - Split a huge patch into three patches as suggested by Bjorn Helgaas
>  - snps,dw-pcie removal is now part of [3]
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
> [2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
> 
> 
> Dmitry Baryshkov (6):
>   PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
>   PCI: dwc: Convert msi_irq to the array
>   PCI: dwc: split MSI IRQ parsing/allocation to a separate function
>   PCI: dwc: Handle MSIs routed to multiple GIC interrupts
>   dt-bindings: PCI: qcom: Support additional MSI interrupts

I applied the above to pci/ctrl/dwc for v5.20, thanks!

I reordered "split MSI stuff to separate function" before "convert to
array" to reduce the complexity first before adding more.

I also dropped the "irq" temporary in "Convert msi_irq to the array",
not because I necessary object to it, but because it's not strictly
related to converting to an array.  Previously we might have left
pp->msi_irq containing an error code (< 0), but the same situation
after the patch would leave pp->msi_irq[0] == 0.

I left the arch/arm64/boot/dts/qcom/sm8250.dtsi change below out
on the assumption it will go via arm-soc.

>   arm64: dts: qcom: sm8250: provide additional MSI interrupts
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  51 +++++-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 164 +++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
>  9 files changed, 185 insertions(+), 54 deletions(-)
> 
> -- 
> 2.35.1
> 
