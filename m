Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159C67C8B9C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjJMQi3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJMQi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 12:38:28 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59495
        for <linux-pci@vger.kernel.org>; Fri, 13 Oct 2023 09:38:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7af20c488so27575267b3.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Oct 2023 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697215105; x=1697819905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y62C42hqOldBla5nOPJaFzuEZ48dSgIXLJ1wjt3nmfg=;
        b=hiX5qt8Om7aIOlXShaWA/uFgbGLsgrOrS0YgTXtH4uupp/JMUbRTFPlZsoc6uTeK9y
         2SUp6Wh9R2OJB97TR7w34YO2q+FNUhJhoh9SQ4/hw9o2GyXY4WNtkZJrWlPdGgtTv4zG
         mRiIJ2H5iA/3QSkifXk55KaHR4+6TjdXUQImyKnrIoO6psCfHR6k9O2V6uyE+erFydbs
         t4ps4GnHjxwSlR2yJ0jRYpQ6QwtTIWG12VcTLmTdwzAOMuHMrSHNcYj3ywTPf1df4nJ3
         QFraTwARMRfNTF6mo5jBeADVpuZJq5474UKhGwEJEsY3Zn+IabZIc+BvFCnKnBKKBOi2
         2Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697215105; x=1697819905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y62C42hqOldBla5nOPJaFzuEZ48dSgIXLJ1wjt3nmfg=;
        b=mSoykmeS2nvbnua9kE/5hKrK1L1ire3EG9j2mkDGo13QStUjUfHIaeM45w74OfGhS+
         UrHlHEp5J7dfEaFNnputjoU4Nv2eGP9Z5s3AU31TsRGGyTpS3XKu8++gaqFNsUTyJB18
         noFpztnijz70IeH33tmCx05HCovSVNrx4sH5BI+MlqyPi01a7XPbiSBx9N10dppJyJLd
         ePR1KPQvF7SePgbKSbktzqVwl2gsUAjyYcl3LbUnVs1946vdlixBXtQ8TyYJPQhmawFp
         yo2tpmWUoBscTubgMTNL1sxAwwsT1A4rGKAX0rQKtF6aWJJB/F7JNq1dGW8FSa/+pVea
         wjWA==
X-Gm-Message-State: AOJu0YwizBu56gBwGDzns2dVPI7aBFMzipSxhQAu1qhGBz8TyhLpSgEj
        WSRYwW7Nn1kj4eDH7cOGeljIRR6fJQ+5tywujTlgdA==
X-Google-Smtp-Source: AGHT+IGNSo+78yX/NsWCFtkVnlt0MXoHA1iGSKh5UHymJ8V2IoNpgMBwBsPLUuvZ85t7hTyy9e6zlHX6+UtYGK0YhjI=
X-Received: by 2002:a0d:eb0e:0:b0:5a8:1654:4b6f with SMTP id
 u14-20020a0deb0e000000b005a816544b6fmr3585459ywe.17.1697215105287; Fri, 13
 Oct 2023 09:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-2-git-send-email-quic_msarkar@quicinc.com>
 <20230921183850.GA762694-robh@kernel.org> <28bf111f-b965-4d38-884b-bc3a0b68a6cc@quicinc.com>
 <8effa7e5-a223-081b-75b8-7b94400d42e6@quicinc.com> <CAA8EJpp+3_A-9YXF1yOKdFweVKqrpTxvxKoJcUH6qiDHfCQ-dQ@mail.gmail.com>
 <31e6aab6-73f9-a421-9dfa-292d9d0e9649@quicinc.com>
In-Reply-To: <31e6aab6-73f9-a421-9dfa-292d9d0e9649@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 13 Oct 2023 19:38:13 +0300
Message-ID: <CAA8EJprSxKXjZTH8tCHGvw4zBp_H-DunS9v9kvp=aFRNd55OhA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Rob Herring <robh@kernel.org>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 13 Oct 2023 at 15:55, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
>
> On 10/11/2023 5:13 PM, Dmitry Baryshkov wrote:
> > On Wed, 11 Oct 2023 at 14:14, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
> >>
> >> On 10/6/2023 4:24 PM, Shazad Hussain wrote:
> >>>
> >>> On 9/22/2023 12:08 AM, Rob Herring wrote:
> >>>> On Wed, Sep 20, 2023 at 07:25:08PM +0530, Mrinmay Sarkar wrote:
> >>>>> Add devicetree bindings support for SA8775P SoC.
> >>>>> Define reg and interrupt per platform.
> >>>>>
> >>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> >>>>> ---
> >>>>>    .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 130
> >>>>> +++++++++++++++++----
> >>>>>    1 file changed, 108 insertions(+), 22 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >>>>> b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >>>>> index a223ce0..e860e8f 100644
> >>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >>>>> @@ -13,6 +13,7 @@ properties:
> >>>>>      compatible:
> >>>>>        oneOf:
> >>>>>          - enum:
> >>>>> +          - qcom,sa8775p-pcie-ep
> >>>>>              - qcom,sdx55-pcie-ep
> >>>>>              - qcom,sm8450-pcie-ep
> >>>>>          - items:
> >>>>> @@ -20,29 +21,19 @@ properties:
> >>>>>              - const: qcom,sdx55-pcie-ep
> >>>>>        reg:
> >>>>> -    items:
> >>>>> -      - description: Qualcomm-specific PARF configuration registers
> >>>>> -      - description: DesignWare PCIe registers
> >>>>> -      - description: External local bus interface registers
> >>>>> -      - description: Address Translation Unit (ATU) registers
> >>>>> -      - description: Memory region used to map remote RC address space
> >>>>> -      - description: BAR memory region
> >>>>> +    minItems: 6
> >>>>> +    maxItems: 7
> >>>>>        reg-names:
> >>>>> -    items:
> >>>>> -      - const: parf
> >>>>> -      - const: dbi
> >>>>> -      - const: elbi
> >>>>> -      - const: atu
> >>>>> -      - const: addr_space
> >>>>> -      - const: mmio
> >>>>> +    minItems: 6
> >>>>> +    maxItems: 7
> >>>> Don't move these into if/then schemas. Then we are duplicating the
> >>>> names, and there is no reason to keep them aligned for new compatibles.
> >>>>
> >>>> Rob
> >>> Hi Rob,
> >>> As we have one extra reg property (dma) required for sa8775p-pcie-ep,
> >>> isn't it expected to be moved in if/then as per number of regs
> >>> required. Anyways we would have duplication of some properties for new
> >>> compatibles where the member numbers differs for a property.
> >>>
> >>> Are you suggesting to add the extra reg property (dma) in the existing
> >>> reg and reg-names list, and add minItems/maxItems for all compatibles
> >>> present in this file ?
> > This is what we have been doing in other cases: if the list is an
> > extension of the current list, there is no need to duplicate it. One
> > can use min/maxItems instead.
> Hi Dmitry
>
> we have tried using min/maxItems rather than duplicating but somehow
> catch up with some warnings in dt_bindings check
>
> //local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
> pcie-ep@1c00000: reg: [[29360128, 12288], [1073741824, 3869],
> [1073745696, 200], [1073745920, 4096], [1073750016, 4096], [29372416,
> 12288]] is too short//
> //        from schema $id:
> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
> ///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
> pcie-ep@1c00000: reg-names: ['parf', 'dbi', 'elbi', 'atu', 'addr_space',
> 'mmio'] is too short//
> //        from schema $id:

missing min/maxItems for reg and reg-names

> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
> ///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
> pcie-ep@1c00000: interrupts: [[0, 140, 4], [0, 145, 4]] is too short//
> //        from schema $id:
> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
> ///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
> pcie-ep@1c00000: interrupt-names: ['global', 'doorbell'] is too short//
> //        from schema $id:
> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//

incorrect min/maxItems for interrupts.

> //local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
> pcie-ep@1c00000: interrupt-names: ['global', 'doorbell'] is too short/
>
> added the patch in attachment.
>
> --Mrinmay
>
> >>> -Shazad
> >> Here we have defined reg and interrupt per platform as clocks is defined.
> >>
> >> -Mrinmay
> >>
> >



-- 
With best wishes
Dmitry
