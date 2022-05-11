Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED06C523083
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 12:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiEKKOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbiEKKOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 06:14:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D1C22B3BE
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 03:13:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso15008297b3.5
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbS9CVLx3YERW8E3AnIjefuENgrYBnFy3iLpPYRS1dE=;
        b=aZN6cRaNHqHH/Tfe1y8ta5XgMovAikD3irJpErfW8NqP3QAup9QUt917tGuJ1TGBFH
         vD51ULlUtdB/+hTgybWL1sztV5VmGthR+Sw+1uT1mHLgQlOxwOZVouqMLjPKb9JJoWxv
         MPJAEBIklP2ahcsQjrKfvdc80Kr8OVrRRvh9Ye+37G3uzNs7fuY+aCHM1vGDVrXQltD3
         5FV2GxVOFMqzOux86aNE4Dvb7U0JdtevMkteY3/4Fosus97inclmtsYWQICzbwUWw7r0
         TiQjzGjZsZ0FjXaS1YlA3SrjcC01d1gkwbeCvoVaICtGcRpx3KAnLNChjUU7mor1DMD7
         93fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbS9CVLx3YERW8E3AnIjefuENgrYBnFy3iLpPYRS1dE=;
        b=jKtU+T1zoyfretC88BM03ZeMeJu+h4BpMYty/ZMsmscef6ULCXHmZu1PQvA+Dhko0Y
         FO0rnLyZ2n8KbuQap5ESOtIKMGulpy5bksBE7bFLGx8vmO0eQqwehiy9RDcSCdLXbVWH
         Aqvdc/A1uGzguBG8YmI5zHgcpoBxwZ9QJIJLK6JyaPSOIj9teuh2hJjOuk1wXViKXy53
         kZJKq70NPUxKZNquV4HIOhYIPl3Cm4/PWtoc6P+mvunRC/bB0wtEtZErtx+vC2vefy0/
         CZu/5BVG8/sRLH2T/oBMD0afljOPEO8JVtjJ3kwZu5aw+6oBVNVfgoED8ZLy1ui86hy/
         ssjw==
X-Gm-Message-State: AOAM532PpxLzg8JpQs5Jg2CkWUhzu16DnbjfqC5q0gSzhew+5pmps5mK
        4+NJDwHkkOwe1vIb0xbZ35ecMiM5ctg21dVGuac0kA==
X-Google-Smtp-Source: ABdhPJw8o6138qy85Ja2D7d3jz1pg7TDpg0MtrPBdgGEPf6HMr12sOpTpfIueSQxq026AyyT8WC+qMovxe/YjVRJNYU=
X-Received: by 2002:a0d:db8f:0:b0:2fb:958c:594f with SMTP id
 d137-20020a0ddb8f000000b002fb958c594fmr3143624ywe.490.1652264019542; Wed, 11
 May 2022 03:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org> <YnqXxNxFhf/odyka@robh.at.kernel.org>
In-Reply-To: <YnqXxNxFhf/odyka@robh.at.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 May 2022 13:13:28 +0300
Message-ID: <CAA8EJpriMcP4uQ3fjyiCKY+uc82ctXe2VrjO1psPDcp-P++Nhw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 May 2022 at 19:50, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, May 06, 2022 at 06:20:59PM +0300, Dmitry Baryshkov wrote:
> > Convert pci/qcom,pcie schema to YAML description. The first patch
> > introduces several warnings which are fixed by the other patches in the
> > series.
> >
> > Note regarding the snps,dw-pcie compatibility. The Qualcomm PCIe
> > controller uses Synopsys PCIe IP core. However it is not just fused to
> > the address space. Accessing PCIe registers requires several clocks and
> > regulators to be powered up. Thus it can be assumed that the qcom,pcie
> > bindings are not fully compatible with the snps,dw-pcie schema.
> >
> > Changes since v5:
> >  - s/stance/stanza (pointed out by Bjorn Helgaas)
> >
> > Changes since v4:
> >  - Change subjects to follow convention (suggested by Bjorn Helgaas)
> >
> > Changes since v3:
> >  - Rebase on linux-next to include sm8150 patches
> >
> > Changes since v2 (still kudos to Krzyshtof):
> >  - Readded reg-names conversion patch
> >  - Mention wake-gpio update in the commit message
> >  - Remove extra quotes in the schema
> >
> > Changes since v1 (all kudos to Krzyshtof):
> >  - Dropped the reg-names patch. It will be handled separately
> >  - Squashed the snps,dw-pcie removal (from schema) into the first patch
> >  - Replaced deprecated perst-gpio and wake-gpio with perst-gpios and
> >    wake-gpios in the examples and in DT files
> >  - Moved common clocks/clock-names, resets/reset-names and power-domains
> >    properties to the top level of the schema, leaving only platform
> >    specifics in the conditional branches
> >  - Dropped iommu-map/iommu-map-mask for now
> >  - Added (missed) interrupt-cells, clocks, clock-names, resets,
> >    reset-names properties to the required list (resets/reset-names are
> >    removed in the next patch, as they are not used on msm8996)
> >  - Fixed IRQ flags in the examples
> >  - Merged apq8064/ipq8064 into the single condition statement
> >  - Added extra empty lines
> >
> > Dmitry Baryshkov (8):
> >   dt-bindings: PCI: qcom: Convert to YAML
> >   dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
> >   dt-bindings: PCI: qcom: Specify reg-names explicitly
> >   dt-bindings: PCI: qcom: Add schema for sc7280 chipset
> >   arm64: dts: qcom: stop using snps,dw-pcie falback
> >   arm: dts: qcom: stop using snps,dw-pcie falback
> >   arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
> >   arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
> >
> >  .../devicetree/bindings/pci/qcom,pcie.txt     | 398 ----------
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 714 ++++++++++++++++++
>
> What tree do these apply to because they don't apply to rc1. I'm
> assuming the PCI tree and Lorenzo should take them.

The series depends on the patch in Lorenzo's tree (sm8150 bindings),
so I'd assume it would be natural to merge these patches through his
tree too.


-- 
With best wishes
Dmitry
