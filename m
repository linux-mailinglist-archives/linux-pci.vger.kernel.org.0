Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A46AE3D8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCGPFQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 10:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCGPEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 10:04:51 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6948984DD
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 06:57:04 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536bf92b55cso248410787b3.12
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678201024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3Cr5iHChPhVIM0IBEr0zNr4m47UpuB7ZQNBapGvsMA=;
        b=Sa7p7I6Iw0SkeAUDEM6Hi3s/b5m+Yr2N5xRDEwsu9mpEv9pSTSN3BYW/4q+YKYBaxS
         EPS1oVhC5aRhsxC73yzTe6WL6SngTSkoIZdCYU1E6l6mqj4vRrKKNoL9Opvd5TUgJdu+
         OaAn1wlB6oRoincbTu02uO5l0JC4uqGi5hHKkBQpbMzl4iwaddSdYxsMqiow9E2oMh7m
         Iv4IUaT9JtE9MorpZXVsuACbNecZ0TXkVlIQtFS1nBElteItPxnTe42RY0RKngls/hXG
         wgiakHo2+zhspHzUrS/hqXZ1yAZtYBn02MQn9ir0T5WLdP4qD/b4I+Co2KANzqrEkwsm
         XGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3Cr5iHChPhVIM0IBEr0zNr4m47UpuB7ZQNBapGvsMA=;
        b=Ez1DsdqYDfcIVMCM+tcJl48aZ1zxSnm9+HK450IICUlMnIPaMZKhh0kXMK9Fr3j9KU
         Rwgz/rdeltxLdA50a/3nmEZsPxl17ho/wlO0iC4xcsWnOXPpPtkXwtyUf7WbrFvxZ3hr
         unhviL16tz3NbKg1PdSVW5PzWa/cSVsHQ/jz4C/NHlxsLJLS3jvDBkw2/KbVy31t3jEZ
         +ChFDQYDOLd3I7cUI83IBdifBfjd8AZ34FKDkoA+Kh7rHByDPOdCxwK76+DOBzxzN87d
         eMmfEMry7cvAMdxonWa1Qg3D86IUm6su4Pc8Jh0lU4KaLENF2LzDGX2OafTTWz8qetUF
         tupA==
X-Gm-Message-State: AO0yUKU22s1vPtYBjIAPGMd4THNUh+9PKpWiGbq4Djc5ktd9H/0/v0j/
        rkS+64crbHy8mNy9As+G3BqqqN6XcmtlVcx9GOaXVQ==
X-Google-Smtp-Source: AK7set/9HMCrF+azKo6YywINpZcVolMmW90oCUx+HqMoViVjHmvmFqQ4kHcS4RJgKU3KMXxpJW9El5ge0160PPUTuUw=
X-Received: by 2002:a81:b71c:0:b0:536:7529:55b4 with SMTP id
 v28-20020a81b71c000000b00536752955b4mr9438563ywh.3.1678201023901; Tue, 07 Mar
 2023 06:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-2-quic_devipriy@quicinc.com> <20230224082332.GA5443@thinkpad>
 <bd153038-4427-1f11-1941-5f13fec01cf7@quicinc.com> <20230228063358.GA4839@thinkpad>
 <9BD62D8E-4E14-4269-B72D-C83EF4D43040@linaro.org> <20230303174036.GB6782@thinkpad>
 <30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com> <20230307125655.GC5599@thinkpad>
 <2afe8c7e-7e54-460f-7206-64a290beccfb@quicinc.com>
In-Reply-To: <2afe8c7e-7e54-460f-7206-64a290beccfb@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Mar 2023 16:56:53 +0200
Message-ID: <CAA8EJpo-_PXhBnKWD-TWEqY8+uAEjbRsrhJ7XO1PTcYV-MHV9Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: PCI: qcom: Add IPQ9574 specific compatible
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 7 Mar 2023 at 16:40, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 3/7/2023 6:26 PM, Manivannan Sadhasivam wrote:
> > On Tue, Mar 07, 2023 at 03:15:08PM +0530, Devi Priya wrote:
> >>
> >>
> >> On 3/3/2023 11:10 PM, Manivannan Sadhasivam wrote:
> >>> On Fri, Mar 03, 2023 at 05:16:58PM +0200, Dmitry Baryshkov wrote:
> >>>> 28 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2023 =D0=B3. 08:33:58 =
GMT+02:00, Manivannan Sadhasivam <mani@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> >>>>> On Tue, Feb 28, 2023 at 10:56:53AM +0530, Devi Priya wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2/24/2023 1:53 PM, Manivannan Sadhasivam wrote:
> >>>>>>> On Tue, Feb 14, 2023 at 10:11:29PM +0530, Devi Priya wrote:
> >>>>>>>> Document the compatible for IPQ9574
> >>>>>>>>
> >>>>>> Hi Mani, Thanks for taking time to review the patch.
> >>>>>>>
> >>>>>>> You didn't mention about the "msi-parent" property that is being =
added
> >>>>>>> by this patch
> >>>>>> Sure, will update the commit message in the next spin
> >>>>>>>
> >>>>>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>     .../devicetree/bindings/pci/qcom,pcie.yaml    | 72 +++++++++=
+++++++++-
> >>>>>>>>     1 file changed, 70 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yam=
l b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>>>> index 872817d6d2bd..dabdf2684e2d 100644
> >>>>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >>>>>>>> @@ -26,6 +26,7 @@ properties:
> >>>>>>>>               - qcom,pcie-ipq8064-v2
> >>>>>>>>               - qcom,pcie-ipq8074
> >>>>>>>>               - qcom,pcie-ipq8074-gen3
> >>>>>>>> +          - qcom,pcie-ipq9574
> >>>>>>>>               - qcom,pcie-msm8996
> >>>>>>>>               - qcom,pcie-qcs404
> >>>>>>>>               - qcom,pcie-sa8540p
> >>>>>>>> @@ -44,11 +45,11 @@ properties:
> >>>>>>>>       reg:
> >>>>>>>>         minItems: 4
> >>>>>>>> -    maxItems: 5
> >>>>>>>> +    maxItems: 6
> >>>>>>>>       reg-names:
> >>>>>>>>         minItems: 4
> >>>>>>>> -    maxItems: 5
> >>>>>>>> +    maxItems: 6
> >>>>>>>>       interrupts:
> >>>>>>>>         minItems: 1
> >>>>>>>> @@ -105,6 +106,8 @@ properties:
> >>>>>>>>         items:
> >>>>>>>>           - const: pciephy
> >>>>>>>> +  msi-parent: true
> >>>>>>>> +
> >>>>>>>>       power-domains:
> >>>>>>>>         maxItems: 1
> >>>>>>>> @@ -173,6 +176,27 @@ allOf:
> >>>>>>>>                 - const: parf # Qualcomm specific registers
> >>>>>>>>                 - const: config # PCIe configuration space
> >>>>>>>> +  - if:
> >>>>>>>> +      properties:
> >>>>>>>> +        compatible:
> >>>>>>>> +          contains:
> >>>>>>>> +            enum:
> >>>>>>>> +              - qcom,pcie-ipq9574
> >>>>>>>> +    then:
> >>>>>>>> +      properties:
> >>>>>>>> +        reg:
> >>>>>>>> +          minItems: 5
> >>>>>>>> +          maxItems: 6
> >>>>>>>> +        reg-names:
> >>>>>>>> +          minItems: 5
> >>>>>>>> +          items:
> >>>>>>>> +            - const: dbi # DesignWare PCIe registers
> >>>>>>>> +            - const: elbi # External local bus interface regist=
ers
> >>>>>>>> +            - const: atu # ATU address space
> >>>>>>>> +            - const: parf # Qualcomm specific registers
> >>>>>>>> +            - const: config # PCIe configuration space
> >>>>>>>> +            - const: aggr_noc #PCIe aggr_noc
> >>>>>>>
> >>>>>>> Why do you need this region unlike other SoCs? Is the driver maki=
ng use of it?
> >>>>>> We have the aggr_noc region in ipq9574 to achieve higher throughpu=
t & to
> >>>>>> handle multiple PCIe instances. The driver uses it to rate adapt 1=
-lane PCIe
> >>>>>> clocks. My bad, missed it. Will add the driver changes in V2.
> >>>>>
> >>>>> Hmm, this is something new. How can you achieve higher throughput w=
ith this
> >>>>> region? Can you explain more on how it is used?
> >>>>
> >>>> Based on the name of the region, it looks like it is an interconnect=
 region.
> >>>>
> >>>
> >>> Well, we only have BCM based interconnects so far. That's why I was c=
urious
> >>> about this region and its purpose.
> >> For connected PCIe slave devices that are running at frequency lesser
> >> than the ANOC frequency (342MHz), the rate adapter of ANOC needs to be
> >> configured
> >>>
> >>>> Devi, if this is the case, then you have to handle it through the in=
terconnect driver, rather than poking directly into these registers.
> >>>
> >>> If that so, it doesn't need to be added in this series itself. I beli=
eve that
> >>> without aggr_noc region, the PCIe controller can still function prope=
rly with
> >>> reduced performance. But you can add the interconnect support later a=
s a
> >>> separate series.
> >> Sure, okay. The ANOC runs at a fixed frequency of 342MHz and the
> >> interconnect clocks are not scaled. The aggr_noc register is just a ma=
gic
> >> register for configuring it's rate adapter to ensure no wait cycles ar=
e
> >> inserted.
> >>
> >
> > If the purpose of the aggr_noc region is to configure the interconnect =
clock,
> > then it should be modeled as an interconnect driver.
> Can we use 'syscon' here, as we are not scaling the interconnect
> frequency and this is just a single register write for setting
> the rate adapter?

It should be done outside of the PCIe driver.
It is not "just a single register". It is also setting the anoc/snoc
clocks for USB. And maybe something else, which we haven't seen at
this moment. You are still setting up the NoC, even if the icc
frequency is not scaled.

--=20
With best wishes
Dmitry
