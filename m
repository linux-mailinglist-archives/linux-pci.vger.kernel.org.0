Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F26A6EE9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCAO7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 09:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCAO7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 09:59:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3AE12BD7;
        Wed,  1 Mar 2023 06:59:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A6A4B81084;
        Wed,  1 Mar 2023 14:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0630BC433D2;
        Wed,  1 Mar 2023 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677682744;
        bh=Yqf9Ws2DwHgKm6RKTHWwgebUlFuviIC5Mpr3HYPHYMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rSsYKIdcxo70HEhgfKeS6SyvlL/FIrQc4GDqJf8RNHWp2+mWnEq0OVjMa/KjgGkJj
         VE4Pdz/5lZKXobmNg7Uk039lRQF3HJxeNHxrNndJpgDZYrBJfv4iK/9UQL7aoT/OtN
         UuUm6kCuUrcZO7E7ZOJ74vqbqacktSVKlk+u7mFZ0bLrNYKpejvLpNu735mNhnL6uN
         k+1NnbKB+LsnqVRruxNCAAoQUWGwU/MFvVkigPLmpk6Zb8Zxad6jbYrbXZMSBdIWAc
         GRNXS1H27eFK7fHbkQiSjDlQCG42bMd5iraaTIwQgvW6NLAMiYX3gO1KFEgoeahTIW
         m4QOgiw4EBGLw==
Received: by mail-ua1-f47.google.com with SMTP id x40so3894209uaf.2;
        Wed, 01 Mar 2023 06:59:03 -0800 (PST)
X-Gm-Message-State: AO0yUKVRICwfvj0Z/QusH+VD+WiuQjrJEH/DHyeNxnaWpXtQJWFOVunc
        Vxvd7ZPYpeCwbvBoAetvg5ehL2o8rUuEKrz6qg==
X-Google-Smtp-Source: AK7set9NsZVlDinXDgjj4dqHc+VM2sMCUP6iO8tYTToBCSoRpMdK6SGL9S8gxffoDxacEmes9w4Gxeg/JlPukGxzdw0=
X-Received: by 2002:ab0:4a97:0:b0:68d:6360:77b with SMTP id
 s23-20020ab04a97000000b0068d6360077bmr3878835uae.1.1677682742965; Wed, 01 Mar
 2023 06:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
 <20230224105906.16540-3-manivannan.sadhasivam@linaro.org> <20230227195535.GA749409-robh@kernel.org>
 <20230228082021.GB4839@thinkpad>
In-Reply-To: <20230228082021.GB4839@thinkpad>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Mar 2023 08:58:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXb1junhU+56ZcqHzAq8g0VN8BzQ2A1C9rB80pZDWJ-w@mail.gmail.com>
Message-ID: <CAL_JsqJXb1junhU+56ZcqHzAq8g0VN8BzQ2A1C9rB80pZDWJ-w@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] dt-bindings: PCI: qcom: Add iommu properties
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <Robin.Murphy@arm.com>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Robin

On Tue, Feb 28, 2023 at 2:20=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Feb 27, 2023 at 01:55:35PM -0600, Rob Herring wrote:
> > On Fri, Feb 24, 2023 at 04:28:55PM +0530, Manivannan Sadhasivam wrote:
> > > Most of the PCIe controllers require iommu support to function proper=
ly.
> > > So let's add them to the binding.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > ---
> > >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > index a3639920fcbb..f48d0792aa57 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > @@ -64,6 +64,11 @@ properties:
> > >
> > >    dma-coherent: true
> > >
> > > +  iommus:
> > > +    maxItems: 1
> > > +
> > > +  iommu-map: true
> > > +
> >
> > I think both properties together doesn't make sense unless the PCI host
> > itself does DMA in addition to PCI bus devices doing DMA.
> >
>
> How? With "iommus", we specify the SMR mask along with the starting SID a=
nd with
> iommu-map, the individual SID<->BDF mapping is specified. This has nothin=
g to
> do with host DMA capabilities.

I spoke with Robin offline and he agrees that having both is broken at
least in RC mode. He pointed out the issue is similar to this one on
Tegra[1].

Rob

[1] https://lore.kernel.org/all/AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P=
193MB2095.EURP193.PROD.OUTLOOK.COM/
