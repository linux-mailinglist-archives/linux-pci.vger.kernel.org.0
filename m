Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0056ADDBF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 12:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCGLml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 06:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjCGLlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 06:41:45 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF17D0B8
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 03:39:18 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536af432ee5so240477467b3.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 03:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678189150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2QEPXAzp21Sp6krYXcMnpxNWR2KzEzr6+4RDpVrUlI=;
        b=MZdIoa/638A2Xrr3aud37732QkFaaI23u93mUrKyx6hNqR+dj0TaQC+E8tBxYlg39i
         L/nH+SGtV7eGgg/PH796jVppU9Ei/QUJfz6q87mKD5GhxAxOoDPEgO/cZatjxymQzf37
         42vkTmcghIT1E1yUCpWhoKqAccG+KBBVheQz0Zfzfky2xjIOWnWNtgdtNSm8xyvhMhkK
         c81jL8WhZzIZytyFxESA5Rk4LOth1GYguzxCQNaJ84tL7NMeJWBTOJzoVEbunqIGtfH8
         XFURYFjvPIvO1pEdUE6hlmMg6Ibn2XB+FlNLycbR4iPAMi/LBU+Sc2jGQvrVRa1Z5UvN
         jewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2QEPXAzp21Sp6krYXcMnpxNWR2KzEzr6+4RDpVrUlI=;
        b=k6bPUqEVQ9M/qjqsHZEwRXWdYnWQbjdD0R9/UXEwGQBHkKZlFhXbnQ92aRHo4HJ0ZM
         dHLtyfC31yVDYZwn2cWZCHvocQ83nhHj8Unf1fklvJ6XKXg+dXz+Z5qo7HmFlp8J+1Ex
         Yun2WDwC5n4Yu5VgifUvR5TWNdUmeZaHrxWK27Yx4DeJ8Of3FJWFSTT6+a721gt6e1W6
         +GqB3LG5T3IxxiCf3tLH6FlrZW1/nyh9MW9eXb+84ZaHI0k1+jduKgKBhSnHK12xEu11
         hv5ziOIrbfUf82CHk3lvsgF3XV1W1ZX+BDvuDCVamdKwBps34wE/D0/IRF4njqGvwwAN
         0JDQ==
X-Gm-Message-State: AO0yUKUJe7rK8fYHNDf5Zj6idi++rBD8elGYRlvdJqQP3c4V4uzKuZ9l
        ofVhT7tKPfAAQl5QcYWuaQQte7LFL+WwfMGeHgOChA==
X-Google-Smtp-Source: AK7set+pIPRCkUCY1DQn3/UnCDXcMdFY3wcXRpn0sqH288ZQWy/jCdAUknswqsGd/FYMEDrTW7d8/OAqi9oBGUQj+6g=
X-Received: by 2002:a81:b243:0:b0:52e:d380:ab14 with SMTP id
 q64-20020a81b243000000b0052ed380ab14mr7473835ywh.3.1678189150311; Tue, 07 Mar
 2023 03:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-2-quic_devipriy@quicinc.com> <20230224082332.GA5443@thinkpad>
 <bd153038-4427-1f11-1941-5f13fec01cf7@quicinc.com> <20230228063358.GA4839@thinkpad>
 <9BD62D8E-4E14-4269-B72D-C83EF4D43040@linaro.org> <20230303174036.GB6782@thinkpad>
 <30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com>
In-Reply-To: <30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Mar 2023 13:38:59 +0200
Message-ID: <CAA8EJpohnJvFKMc5Ty4CQF65Gt1Kknqsf1B4mFZq4TvW7_dcnw@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: PCI: qcom: Add IPQ9574 specific compatible
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 7 Mar 2023 at 11:45, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 3/3/2023 11:10 PM, Manivannan Sadhasivam wrote:
> > On Fri, Mar 03, 2023 at 05:16:58PM +0200, Dmitry Baryshkov wrote:
> >> 28 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2023 =D0=B3. 08:33:58 GM=
T+02:00, Manivannan Sadhasivam <mani@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> >>> On Tue, Feb 28, 2023 at 10:56:53AM +0530, Devi Priya wrote:
> >>>>
> >>>>
> >>>> On 2/24/2023 1:53 PM, Manivannan Sadhasivam wrote:
> >>>>> On Tue, Feb 14, 2023 at 10:11:29PM +0530, Devi Priya wrote:
> >>>>>> Document the compatible for IPQ9574
> >>>>>>
> >>>> Hi Mani, Thanks for taking time to review the patch.
> >>>>>
> >>>>> You didn't mention about the "msi-parent" property that is being ad=
ded
> >>>>> by this patch
> >>>> Sure, will update the commit message in the next spin
> >>>>>
> >>>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >>>>>> ---
> >>>>>>    .../devicetree/bindings/pci/qcom,pcie.yaml    | 72 ++++++++++++=
++++++-
> >>>>>>    1 file changed, 70 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml =
b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>> index 872817d6d2bd..dabdf2684e2d 100644
> >>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>> @@ -26,6 +26,7 @@ properties:
> >>>>>>              - qcom,pcie-ipq8064-v2
> >>>>>>              - qcom,pcie-ipq8074
> >>>>>>              - qcom,pcie-ipq8074-gen3
> >>>>>> +          - qcom,pcie-ipq9574
> >>>>>>              - qcom,pcie-msm8996
> >>>>>>              - qcom,pcie-qcs404
> >>>>>>              - qcom,pcie-sa8540p
> >>>>>> @@ -44,11 +45,11 @@ properties:
> >>>>>>      reg:
> >>>>>>        minItems: 4
> >>>>>> -    maxItems: 5
> >>>>>> +    maxItems: 6
> >>>>>>      reg-names:
> >>>>>>        minItems: 4
> >>>>>> -    maxItems: 5
> >>>>>> +    maxItems: 6
> >>>>>>      interrupts:
> >>>>>>        minItems: 1
> >>>>>> @@ -105,6 +106,8 @@ properties:
> >>>>>>        items:
> >>>>>>          - const: pciephy
> >>>>>> +  msi-parent: true
> >>>>>> +
> >>>>>>      power-domains:
> >>>>>>        maxItems: 1
> >>>>>> @@ -173,6 +176,27 @@ allOf:
> >>>>>>                - const: parf # Qualcomm specific registers
> >>>>>>                - const: config # PCIe configuration space
> >>>>>> +  - if:
> >>>>>> +      properties:
> >>>>>> +        compatible:
> >>>>>> +          contains:
> >>>>>> +            enum:
> >>>>>> +              - qcom,pcie-ipq9574
> >>>>>> +    then:
> >>>>>> +      properties:
> >>>>>> +        reg:
> >>>>>> +          minItems: 5
> >>>>>> +          maxItems: 6
> >>>>>> +        reg-names:
> >>>>>> +          minItems: 5
> >>>>>> +          items:
> >>>>>> +            - const: dbi # DesignWare PCIe registers
> >>>>>> +            - const: elbi # External local bus interface register=
s
> >>>>>> +            - const: atu # ATU address space
> >>>>>> +            - const: parf # Qualcomm specific registers
> >>>>>> +            - const: config # PCIe configuration space
> >>>>>> +            - const: aggr_noc #PCIe aggr_noc
> >>>>>
> >>>>> Why do you need this region unlike other SoCs? Is the driver making=
 use of it?
> >>>> We have the aggr_noc region in ipq9574 to achieve higher throughput =
& to
> >>>> handle multiple PCIe instances. The driver uses it to rate adapt 1-l=
ane PCIe
> >>>> clocks. My bad, missed it. Will add the driver changes in V2.
> >>>
> >>> Hmm, this is something new. How can you achieve higher throughput wit=
h this
> >>> region? Can you explain more on how it is used?
> >>
> >> Based on the name of the region, it looks like it is an interconnect r=
egion.
> >>
> >
> > Well, we only have BCM based interconnects so far. That's why I was cur=
ious
> > about this region and its purpose.
> For connected PCIe slave devices that are running at frequency lesser
> than the ANOC frequency (342MHz), the rate adapter of ANOC needs to be
> configured
> >
> >> Devi, if this is the case, then you have to handle it through the inte=
rconnect driver, rather than poking directly into these registers.
> >
> > If that so, it doesn't need to be added in this series itself. I believ=
e that
> > without aggr_noc region, the PCIe controller can still function properl=
y with
> > reduced performance. But you can add the interconnect support later as =
a
> > separate series.
> Sure, okay. The ANOC runs at a fixed frequency of 342MHz and the
> interconnect clocks are not scaled. The aggr_noc register is just a
> magic register for configuring it's rate adapter to ensure no wait
> cycles are inserted.

I have been hesitant at some point, but this looks more and more like
a special kind of interconnect. Please consider moving all the NoC
stuff into a separate driver implementing the ICC API.

>
> >
> > Thanks,
> > Mani
> >
> >>
> >>
> >>>
> >>> Thanks,
> >>> Mani
> >>>
> >>>>>
> >>>>> Thanks,
> >>>>> Mani
> >>>>>
> >>>>>> +
> >>>>>>      - if:
> >>>>>>          properties:
> >>>>>>            compatible:
> >>>>>> @@ -365,6 +389,39 @@ allOf:
> >>>>>>                - const: ahb # AHB Reset
> >>>>>>                - const: axi_m_sticky # AXI Master Sticky reset
> >>>>>> +  - if:
> >>>>>> +      properties:
> >>>>>> +        compatible:
> >>>>>> +          contains:
> >>>>>> +            enum:
> >>>>>> +              - qcom,pcie-ipq9574
> >>>>>> +    then:
> >>>>>> +      properties:
> >>>>>> +        clocks:
> >>>>>> +          minItems: 6
> >>>>>> +          maxItems: 6
> >>>>>> +        clock-names:
> >>>>>> +          items:
> >>>>>> +            - const: ahb  # AHB clock
> >>>>>> +            - const: aux  # Auxiliary clock
> >>>>>> +            - const: axi_m # AXI Master clock
> >>>>>> +            - const: axi_s # AXI Slave clock
> >>>>>> +            - const: axi_bridge # AXI bridge clock
> >>>>>> +            - const: rchng
> >>>>>> +        resets:
> >>>>>> +          minItems: 8
> >>>>>> +          maxItems: 8
> >>>>>> +        reset-names:
> >>>>>> +          items:
> >>>>>> +            - const: pipe # PIPE reset
> >>>>>> +            - const: sticky # Core Sticky reset
> >>>>>> +            - const: axi_s_sticky # AXI Slave Sticky reset
> >>>>>> +            - const: axi_s # AXI Slave reset
> >>>>>> +            - const: axi_m_sticky # AXI Master Sticky reset
> >>>>>> +            - const: axi_m # AXI Master reset
> >>>>>> +            - const: aux # AUX Reset
> >>>>>> +            - const: ahb # AHB Reset
> >>>>>> +
> >>>>>>      - if:
> >>>>>>          properties:
> >>>>>>            compatible:
> >>>>>> @@ -681,6 +738,16 @@ allOf:
> >>>>>>            - interconnects
> >>>>>>            - interconnect-names
> >>>>>> +  - if:
> >>>>>> +      properties:
> >>>>>> +        compatible:
> >>>>>> +          contains:
> >>>>>> +            enum:
> >>>>>> +              - qcom,pcie-ipq9574
> >>>>>> +    then:
> >>>>>> +      required:
> >>>>>> +        - msi-parent
> >>>>>> +
> >>>>>>      - if:
> >>>>>>          not:
> >>>>>>            properties:
> >>>>>> @@ -693,6 +760,7 @@ allOf:
> >>>>>>                    - qcom,pcie-ipq8064v2
> >>>>>>                    - qcom,pcie-ipq8074
> >>>>>>                    - qcom,pcie-ipq8074-gen3
> >>>>>> +                - qcom,pcie-ipq9574
> >>>>>>                    - qcom,pcie-qcs404
> >>>>>>        then:
> >>>>>>          required:
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>>
> >>>>>
> >>>> Thanks,
> >>>> Devi Priya
> >>>
> >>
> >
> Thanks,
> Devi Priya



--=20
With best wishes
Dmitry
