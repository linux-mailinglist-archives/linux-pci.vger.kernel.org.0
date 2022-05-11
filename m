Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5960F52350B
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244416AbiEKOJd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244419AbiEKOJb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 10:09:31 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037B69B78
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 07:09:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ef5380669cso22188637b3.9
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83Nv0MHRiwJG3Qt4wgTcx11zG/+pISY5yN6uuKlIn0Q=;
        b=kBcewzqBBvAfPquvl/sGPouMBUO+fHjmZ0vQl9khshvjjIB1XxMmZXwU0WzC5aAqV2
         sjp/OIIyT1zvaiYhawbSxJps6a6rz91drkgGurTkeDFiVA1UfCUMk7FBM8WQ+VjDBhlF
         Lq/1hG9mRdvTI6sW63ezJVlPMq96c4VBKftDYJjJyRT87lriIFKKvQpS8bfePV9dxXcy
         1Yeh5sIaX4/QPvbdkMSLfGdhhri2shmxQiARr++u6OukeqyHWihRBII+CRaS9cFVcRp4
         3ui3NeRn/Ji7F3zf4t7ie2o99FzoVUn+JO4iOPtHmyWraYU0Md+LE50AvrI5iNJIpEal
         9Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83Nv0MHRiwJG3Qt4wgTcx11zG/+pISY5yN6uuKlIn0Q=;
        b=lW5sc/6UTHfcle9kAcPwQ/5Ve/hN/xHgjGirCTMJt+VQ3cyIK5D93HoxWzzcPsp48c
         4FHgholIxGPwQmkphmLxH8tTTk4PVsBFdgGGKU+u1idDCY8BYfwwqgVHOKRT8rwrMuY0
         WQMzr0wd40M5gfSAr4Q2kMmqOAcjied8u2ayQkkDVSKSqyUOd+3io9gsK1M76BaV5ivN
         Q2XOGgxhRvJw5u/mo5l871vZyKTQ8JWaR2shHeZft65svWhArUOCF2ARRM3Nnjy5t9pU
         aDsVoS1Rl8tUdQLBxNkCrbFYAJ5WRp06LyjpFzYEqx+f9OJWOE+9STdAfVwO1ZnP/wK8
         Tuag==
X-Gm-Message-State: AOAM533MwKjNjXK8Iww43pdpHRutfXX4V95Akye0hgnk+CkORbLtHm6Z
        OZGrzAEpQURkRBk66uJ5rNaB27UNbREwBsurdcQpWg==
X-Google-Smtp-Source: ABdhPJxpj7VEhOJk81+QJ7sbXCb6T0VZeHbkdlPGDlNlc7ESj1A/mFHECqzvuvaiyTYwwHSJIZkushdwooT13fS70Zc=
X-Received: by 2002:a81:1d4e:0:b0:2f7:be8b:502e with SMTP id
 d75-20020a811d4e000000b002f7be8b502emr25537778ywd.278.1652278168274; Wed, 11
 May 2022 07:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
 <YnqXxNxFhf/odyka@robh.at.kernel.org> <CAA8EJpriMcP4uQ3fjyiCKY+uc82ctXe2VrjO1psPDcp-P++Nhw@mail.gmail.com>
 <Ynu1p1hzqHJNpSp3@lpieralisi> <CAA8EJpoQ0TkY9zVzhB00f9iYKquPauF2JeapSECaPp3=eXWjsw@mail.gmail.com>
 <YnvBgXsYYv72otXS@lpieralisi>
In-Reply-To: <YnvBgXsYYv72otXS@lpieralisi>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 May 2022 17:09:17 +0300
Message-ID: <CAA8EJpocyeRHGAS7=cpqQc7DHCUO6j4RS4nrfdiptAwu=7wcFg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 May 2022 at 17:00, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, May 11, 2022 at 04:53:43PM +0300, Dmitry Baryshkov wrote:
> > On Wed, 11 May 2022 at 16:10, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Wed, May 11, 2022 at 01:13:28PM +0300, Dmitry Baryshkov wrote:
> > > > On Tue, 10 May 2022 at 19:50, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, May 06, 2022 at 06:20:59PM +0300, Dmitry Baryshkov wrote:
> > > > > > Convert pci/qcom,pcie schema to YAML description. The first patch
> > > > > > introduces several warnings which are fixed by the other patches in the
> > > > > > series.
> > > > > >
> > > > > > Note regarding the snps,dw-pcie compatibility. The Qualcomm PCIe
> > > > > > controller uses Synopsys PCIe IP core. However it is not just fused to
> > > > > > the address space. Accessing PCIe registers requires several clocks and
> > > > > > regulators to be powered up. Thus it can be assumed that the qcom,pcie
> > > > > > bindings are not fully compatible with the snps,dw-pcie schema.
> > > > > >
> > > > > > Changes since v5:
> > > > > >  - s/stance/stanza (pointed out by Bjorn Helgaas)
> > > > > >
> > > > > > Changes since v4:
> > > > > >  - Change subjects to follow convention (suggested by Bjorn Helgaas)
> > > > > >
> > > > > > Changes since v3:
> > > > > >  - Rebase on linux-next to include sm8150 patches
> > > > > >
> > > > > > Changes since v2 (still kudos to Krzyshtof):
> > > > > >  - Readded reg-names conversion patch
> > > > > >  - Mention wake-gpio update in the commit message
> > > > > >  - Remove extra quotes in the schema
> > > > > >
> > > > > > Changes since v1 (all kudos to Krzyshtof):
> > > > > >  - Dropped the reg-names patch. It will be handled separately
> > > > > >  - Squashed the snps,dw-pcie removal (from schema) into the first patch
> > > > > >  - Replaced deprecated perst-gpio and wake-gpio with perst-gpios and
> > > > > >    wake-gpios in the examples and in DT files
> > > > > >  - Moved common clocks/clock-names, resets/reset-names and power-domains
> > > > > >    properties to the top level of the schema, leaving only platform
> > > > > >    specifics in the conditional branches
> > > > > >  - Dropped iommu-map/iommu-map-mask for now
> > > > > >  - Added (missed) interrupt-cells, clocks, clock-names, resets,
> > > > > >    reset-names properties to the required list (resets/reset-names are
> > > > > >    removed in the next patch, as they are not used on msm8996)
> > > > > >  - Fixed IRQ flags in the examples
> > > > > >  - Merged apq8064/ipq8064 into the single condition statement
> > > > > >  - Added extra empty lines
> > > > > >
> > > > > > Dmitry Baryshkov (8):
> > > > > >   dt-bindings: PCI: qcom: Convert to YAML
> > > > > >   dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
> > > > > >   dt-bindings: PCI: qcom: Specify reg-names explicitly
> > > > > >   dt-bindings: PCI: qcom: Add schema for sc7280 chipset
> > > > > >   arm64: dts: qcom: stop using snps,dw-pcie falback
> > > > > >   arm: dts: qcom: stop using snps,dw-pcie falback
> > > > > >   arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
> > > > > >   arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
> > > > > >
> > > > > >  .../devicetree/bindings/pci/qcom,pcie.txt     | 398 ----------
> > > > > >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 714 ++++++++++++++++++
> > > > >
> > > > > What tree do these apply to because they don't apply to rc1. I'm
> > > > > assuming the PCI tree and Lorenzo should take them.
> > > >
> > > > The series depends on the patch in Lorenzo's tree (sm8150 bindings),
> > > > so I'd assume it would be natural to merge these patches through his
> > > > tree too.
> > >
> > > I can take the DT bindings but the dts updates I'd prefer if they
> > > went via platform trees. Is that OK ?
> >
> > Yes, that's fine with me. I think Bjorn has sent 5.19 pull request
> > already, I'll track them getting merged into 5.19 or 5.20.
>
> I assume you meant BjornA sent a PR with patches [5-8] in it,
> correct ?
>
> I will only pull the DT bindings, patches [1-4], please let me
> know if that's what you expect.

Yes and Yes.

>
> Lorenzo



-- 
With best wishes
Dmitry
