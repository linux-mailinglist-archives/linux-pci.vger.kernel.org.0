Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7505234E3
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiEKOAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiEKOAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 10:00:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3502248E40;
        Wed, 11 May 2022 07:00:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F40D2ED1;
        Wed, 11 May 2022 07:00:39 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAD333F66F;
        Wed, 11 May 2022 07:00:37 -0700 (PDT)
Date:   Wed, 11 May 2022 15:00:33 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
Message-ID: <YnvBgXsYYv72otXS@lpieralisi>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
 <YnqXxNxFhf/odyka@robh.at.kernel.org>
 <CAA8EJpriMcP4uQ3fjyiCKY+uc82ctXe2VrjO1psPDcp-P++Nhw@mail.gmail.com>
 <Ynu1p1hzqHJNpSp3@lpieralisi>
 <CAA8EJpoQ0TkY9zVzhB00f9iYKquPauF2JeapSECaPp3=eXWjsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoQ0TkY9zVzhB00f9iYKquPauF2JeapSECaPp3=eXWjsw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 04:53:43PM +0300, Dmitry Baryshkov wrote:
> On Wed, 11 May 2022 at 16:10, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, May 11, 2022 at 01:13:28PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 10 May 2022 at 19:50, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, May 06, 2022 at 06:20:59PM +0300, Dmitry Baryshkov wrote:
> > > > > Convert pci/qcom,pcie schema to YAML description. The first patch
> > > > > introduces several warnings which are fixed by the other patches in the
> > > > > series.
> > > > >
> > > > > Note regarding the snps,dw-pcie compatibility. The Qualcomm PCIe
> > > > > controller uses Synopsys PCIe IP core. However it is not just fused to
> > > > > the address space. Accessing PCIe registers requires several clocks and
> > > > > regulators to be powered up. Thus it can be assumed that the qcom,pcie
> > > > > bindings are not fully compatible with the snps,dw-pcie schema.
> > > > >
> > > > > Changes since v5:
> > > > >  - s/stance/stanza (pointed out by Bjorn Helgaas)
> > > > >
> > > > > Changes since v4:
> > > > >  - Change subjects to follow convention (suggested by Bjorn Helgaas)
> > > > >
> > > > > Changes since v3:
> > > > >  - Rebase on linux-next to include sm8150 patches
> > > > >
> > > > > Changes since v2 (still kudos to Krzyshtof):
> > > > >  - Readded reg-names conversion patch
> > > > >  - Mention wake-gpio update in the commit message
> > > > >  - Remove extra quotes in the schema
> > > > >
> > > > > Changes since v1 (all kudos to Krzyshtof):
> > > > >  - Dropped the reg-names patch. It will be handled separately
> > > > >  - Squashed the snps,dw-pcie removal (from schema) into the first patch
> > > > >  - Replaced deprecated perst-gpio and wake-gpio with perst-gpios and
> > > > >    wake-gpios in the examples and in DT files
> > > > >  - Moved common clocks/clock-names, resets/reset-names and power-domains
> > > > >    properties to the top level of the schema, leaving only platform
> > > > >    specifics in the conditional branches
> > > > >  - Dropped iommu-map/iommu-map-mask for now
> > > > >  - Added (missed) interrupt-cells, clocks, clock-names, resets,
> > > > >    reset-names properties to the required list (resets/reset-names are
> > > > >    removed in the next patch, as they are not used on msm8996)
> > > > >  - Fixed IRQ flags in the examples
> > > > >  - Merged apq8064/ipq8064 into the single condition statement
> > > > >  - Added extra empty lines
> > > > >
> > > > > Dmitry Baryshkov (8):
> > > > >   dt-bindings: PCI: qcom: Convert to YAML
> > > > >   dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
> > > > >   dt-bindings: PCI: qcom: Specify reg-names explicitly
> > > > >   dt-bindings: PCI: qcom: Add schema for sc7280 chipset
> > > > >   arm64: dts: qcom: stop using snps,dw-pcie falback
> > > > >   arm: dts: qcom: stop using snps,dw-pcie falback
> > > > >   arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
> > > > >   arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
> > > > >
> > > > >  .../devicetree/bindings/pci/qcom,pcie.txt     | 398 ----------
> > > > >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 714 ++++++++++++++++++
> > > >
> > > > What tree do these apply to because they don't apply to rc1. I'm
> > > > assuming the PCI tree and Lorenzo should take them.
> > >
> > > The series depends on the patch in Lorenzo's tree (sm8150 bindings),
> > > so I'd assume it would be natural to merge these patches through his
> > > tree too.
> >
> > I can take the DT bindings but the dts updates I'd prefer if they
> > went via platform trees. Is that OK ?
> 
> Yes, that's fine with me. I think Bjorn has sent 5.19 pull request
> already, I'll track them getting merged into 5.19 or 5.20.

I assume you meant BjornA sent a PR with patches [5-8] in it,
correct ?

I will only pull the DT bindings, patches [1-4], please let me
know if that's what you expect.

Lorenzo
