Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A356957E8D2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 23:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGVVVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiGVVVc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 17:21:32 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41241B5572
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 14:21:31 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id t7so4340694qvz.6
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2022 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9Vzxx5v99I/2uVB7XCMkoV6aMYHPOvD5RUO8z15wzU=;
        b=lR6NK8Ah2cilOHDJvUZ/y1mb22sBlwQ1Nqho3sFE6z/xlXVMv7SXPsW5CixxT73ZM+
         y6I1gseU5JYE+tJCJGwzQRJoEbrsAIPAK/N9YjL42ANeb6KaDRH0qusw2k1g9blUZCeB
         njmaEaQ26+DqtvBDI1pP4C4xdmmXIPqrBt9tCeWwFPH406WVovAFHIPkIEPK3O9j4qsu
         5LxfFQI00faWD9NZI/pqmGL226bqVPuQanOFFn89YODL/YvJzMV8dCzzFcpyK+qrSmzg
         khmnUzOZNL/nh9JwuGaDvaeimF3Wq5QySrjXq0OVLIOjHYmnGMTGKJ3lxSRP7LwXbfay
         ZE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9Vzxx5v99I/2uVB7XCMkoV6aMYHPOvD5RUO8z15wzU=;
        b=DIZP6n7dZZqI9u+4zly+uEf+dqI3V7H3LJUHJcMnqI178EF/YUnCN1JQoJBCHZF2rR
         oDHA+cKnNAXjrEBqw3uWS5h/naDk835NiIfkdhtKSEqEQs7Y+9ouh59txaed/WONMY8P
         gPo6m/6Ps/9UHZR8p7/2KVVgO5eVRZEfRXIDfEVMhGfxzOxJSvR2L/R+OgEeWEYYv+XN
         CqdM2ZWBVgfq0E+PsEcWdGm9oep/pFkJiqMuJplfmfvU0FROPl/uhE4A9oNgahVagHaU
         Wf2zqhB9Ai/s/G2wMwDlyxB0OLH6bqaKygjkv41yE0BbheiXaAonHAeCLn3ueozv3hvG
         ngYw==
X-Gm-Message-State: AJIora9s7RA6xzPSbSHAO/eWhu5GUb6MCGF7lXahTieTbFVtJ0aBs4eq
        V17yMRDuLzL4tymxuP1a33bg0HzVYEqFZqkjfE11yQ==
X-Google-Smtp-Source: AGRyM1viSdBqg0Jcsq2oFQ047hRX8TptJOR4jLg6DGGWMRn1MYGgK0gq68VMO562KnfkldAdlVhE+2lbY6lZEZQehxI=
X-Received: by 2002:ad4:5761:0:b0:473:7861:69d1 with SMTP id
 r1-20020ad45761000000b00473786169d1mr1829891qvx.73.1658524890330; Fri, 22 Jul
 2022 14:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org> <20220722170951.GA1907863@bhelgaas>
In-Reply-To: <20220722170951.GA1907863@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Jul 2022 00:21:19 +0300
Message-ID: <CAA8EJpqGj5MaJrM58ovh+av1nvbKPQjBajnaJRyB8kKZYqeJjQ@mail.gmail.com>
Subject: Re: [PATCH v17 0/6] PCI: dwc: Fix higher MSI vectors handling
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Jul 2022 at 20:09, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jul 07, 2022 at 04:47:27PM +0300, Dmitry Baryshkov wrote:
> > I have replied with my Tested-by to the patch at [2], which has landed
> > in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> > Add support for handling MSIs from 8 endpoints"). However lately I
> > noticed that during the tests I still had 'pcie_pme=nomsi', so the
> > device was not forced to use higher MSI vectors.
> >
> > After removing this option I noticed that hight MSI vectors are not
> > delivered on tested platforms. After additional research I stumbled upon
> > a patch in msm-4.14 ([1]), which describes that each group of MSI
> > vectors is mapped to the separate interrupt. Implement corresponding
> > mapping.
> >
> > Changes since v16:
> >  - Fix a typo in the dt schema (noticed and fixed by Johan).
> >
> > Changes since v15:
> >  - Rebased on top of linux-next to take care of the conflict with the
> >    comit 27235cd867cf ("PCI: dwc: Fix MSI msi_msg DMA mapping").
> >
> > Changes since v14:
> >  - Fixed the dtschema warnings in qcom,pcie.yaml (reported by Rob
> >    Herring)
> >
> > Changes since v13:
> >  - Changed msiX from pointer to the char array (reported by Johan).
> >
> > Changes since v12:
> >  - Dropped split_msi_names array in favour of generating the msi_name on
> >    the fly (Rob),
> >  - Dropped separate split MSI ISR as requested by Rob,
> >  - Many small syntax & spelling changes as suggested by Johan and Rob,
> >  - Moved a revert to be a last patch, as it is now a reminder to
> >    Lorenzo,
> >  - Renamed series to name dwc rather than qcom, as the are no more
> >    actual changes to the qcom PCIe driver (Johan thanks for all
> >    suggestions for making the code to work as is).
> >
> > Changes since v11 (suggested by Johan):
> >  - Added back reporting errors for the "msi0" interrupt,
> >  - Stopped overriding num_vectors field if it is less than the amount of
> >    MSI vectors deduced from interrupt list,
> >  - Added a warning (and an override) if the host specifies more MSI
> >    vectors than available,
> >  - Moved has_split_msi_irq variable to the patch where it is used.
> >
> > Changes since v10:
> >  - Remove has_split_msi_irqs flag. Trust DT and use split MSI IRQs if
> >    they are described in the DT. This removes the need for the
> >    pcie-qcom.c changes (everything is handled by the core (suggested by
> >    Johan).
> >  - Rebased on top of Lorenzo's DWC branch
> >
> > Changes since v9:
> >  - Relax requirements and stop validating the DT. If the has_split_msi
> >    was specified, parse as many msiN irqs as specified in DT. If there
> >    are none, fallback to the single "msi" IRQ.
> >
> > Changes since v8:
> >  - Fix typos noted by Bjorn Helgaas
> >  - Add missing links to the patch 1 (revert)
> >  - Fix sm8250 interrupt-names (Johan)
> >  - Specify num_vectors in qcom configuration data (Johan)
> >  - Rework parsing of MSI IRQs (Johan)
> >
> > Changes since v7:
> >  - Move code back to the dwc core driver (as required by Rob),
> >  - Change dt schema to require either a single "msi" interrupt or an
> >    array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
> >    part of the array (the DT should specify the exact amount of MSI IRQs
> >    allowing fallback to a single "msi" IRQ),
> >  - Fix in the DWC init code for the dma_mapping_error() return value.
> >
> > Changes since v6:
> >  - Fix indentation of the arguments as requested by Stanimir
> >
> > Changes since v5:
> >  - Fixed commit subject and in-comment code according to Bjorn's
> >    suggestion,
> >  - Changed variable idx to i to follow dw_handle_msi_irq() style.
> >
> > Changes since v4:
> >  - Fix the minItems/maxItems properties in the YAML schema.
> >
> > Changes since v3:
> >  - Reimplement MSI handling scheme in the Qualcomm host controller
> >    driver.
> >
> > Changes since v2:
> >  - Fix and rephrase commit message for patch 2.
> >
> > Changes since v1:
> >  - Split a huge patch into three patches as suggested by Bjorn Helgaas
> >  - snps,dw-pcie removal is now part of [3]
> >
> > [1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
> > [2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
> >
> >
> > Dmitry Baryshkov (6):
> >   PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
> >   PCI: dwc: Convert msi_irq to the array
> >   PCI: dwc: split MSI IRQ parsing/allocation to a separate function
> >   PCI: dwc: Handle MSIs routed to multiple GIC interrupts
> >   dt-bindings: PCI: qcom: Support additional MSI interrupts
>
> I applied the above to pci/ctrl/dwc for v5.20, thanks!
>
> I reordered "split MSI stuff to separate function" before "convert to
> array" to reduce the complexity first before adding more.
>
> I also dropped the "irq" temporary in "Convert msi_irq to the array",
> not because I necessary object to it, but because it's not strictly
> related to converting to an array.  Previously we might have left
> pp->msi_irq containing an error code (< 0), but the same situation
> after the patch would leave pp->msi_irq[0] == 0.

Ack, thank you. I do not have strong preference, so let it be so.

>
> I left the arch/arm64/boot/dts/qcom/sm8250.dtsi change below out
> on the assumption it will go via arm-soc.

Yes. Thanks a lot!

>
> >   arm64: dts: qcom: sm8250: provide additional MSI interrupts
> >
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    |  51 +++++-
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
> >  drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
> >  .../pci/controller/dwc/pcie-designware-host.c | 164 +++++++++++++-----
> >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
> >  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
> >  drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
> >  9 files changed, 185 insertions(+), 54 deletions(-)
> >
> > --
> > 2.35.1
> >



-- 
With best wishes
Dmitry
