Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1F86A9DBA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 18:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCCRbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCCRbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 12:31:47 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAA35A6C7
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 09:31:45 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f16so3083602ljq.10
        for <linux-pci@vger.kernel.org>; Fri, 03 Mar 2023 09:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lulx79GyAFA+P6dFOCo5Azji9mlKR6wcVUynCnl38KE=;
        b=JITNzhiSKTtjoAwF8+7ZzK3BFkI2QL7n7qvc8NL4tf2TdDiB42bCjsYe/izBt4P+9P
         lczExnj88Gk6EJnFrpd+rDJqpJLXZrFWJejHE/41SNNpPSOPSMY/t+ka4b5SsJVrPLHS
         yP8QlZ4A7u0QnpLqepfRRA6oRNAfFlMSLg9RFndTA4G2xf3m6mlZCv7MgAmlGP0c8oWl
         i8wFp/FD38t10Lcua1M5QYwo/GKeCH7BrCeFC0Qg6KOLMCMSWiBQE04bFJRqxsde4oFG
         7xr+53mwxla2EbiKtNRjabsAbACLLZZ8qk5BGu7Xf1wCkEqYOCB87CCuHWnFs7PFvCvc
         ilNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lulx79GyAFA+P6dFOCo5Azji9mlKR6wcVUynCnl38KE=;
        b=Tdta55exI/UnFTg1eMiHHtYKmp4hRXxJUAtKPRPMTzT4LBD9DnGbGIxrNrdSQL58l7
         wX38HEKiCsM6cq5L9/aPYIGk5t+aew+/UB21XSkBvoDHzAFXnPoqu5uHXU7az/5g+8qU
         z10GlcyASQRPHx14gn902BXQbyZSwzolV7c+mQxgrB1XcDxQPCeRv6TVndbcG9+M7XMs
         bnb/BDHiqgGE+0QWUBSRl9W02GaRm1U1Nb3X7DG2yhhEf43bDWoSgbFIVyWEPMo8ofil
         bqCLv+T5a2vPHQTm0hG+cjvdUfY8zWPPZD+heg14eodAAy6HkmI3nU95QszPQeY97zO4
         IVNg==
X-Gm-Message-State: AO0yUKVJewQM2d1QnDiobQ8kijTOdM4YrpqiSzl1vOOjxgoVQn09ECt2
        iClZEAY4Jg/120lkKWzgL7LUsA==
X-Google-Smtp-Source: AK7set+TY6SCuyHzL+clUmus/vGmZ+jVnXAk/MpTCOHfN+mCHX0WkFtQ6gXt+GN97vVUzr2U7gu7/g==
X-Received: by 2002:a2e:b019:0:b0:295:a3a9:a3e4 with SMTP id y25-20020a2eb019000000b00295a3a9a3e4mr848742ljk.45.1677864703905;
        Fri, 03 Mar 2023 09:31:43 -0800 (PST)
Received: from [127.0.0.1] (85-76-129-102-nat.elisa-mobile.fi. [85.76.129.102])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e6a08000000b0029571d2226bsm402252ljc.11.2023.03.03.09.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:31:43 -0800 (PST)
Date:   Fri, 03 Mar 2023 17:16:58 +0200
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Devi Priya <quic_devipriy@quicinc.com>
CC:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/7=5D_dt-bindings=3A_PCI=3A_q?= =?US-ASCII?Q?com=3A_Add_IPQ9574_specific_compatible?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230228063358.GA4839@thinkpad>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com> <20230214164135.17039-2-quic_devipriy@quicinc.com> <20230224082332.GA5443@thinkpad> <bd153038-4427-1f11-1941-5f13fec01cf7@quicinc.com> <20230228063358.GA4839@thinkpad>
Message-ID: <9BD62D8E-4E14-4269-B72D-C83EF4D43040@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

28 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2023 =D0=B3=2E 08:33:58 GMT+0=
2:00, Manivannan Sadhasivam <mani@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>On Tue, Feb 28, 2023 at 10:56:53AM +0530, Devi Priya wrote:
>>=20
>>=20
>> On 2/24/2023 1:53 PM, Manivannan Sadhasivam wrote:
>> > On Tue, Feb 14, 2023 at 10:11:29PM +0530, Devi Priya wrote:
>> > > Document the compatible for IPQ9574
>> > >=20
>> Hi Mani, Thanks for taking time to review the patch=2E
>> >=20
>> > You didn't mention about the "msi-parent" property that is being adde=
d
>> > by this patch
>> Sure, will update the commit message in the next spin
>> >=20
>> > > Signed-off-by: Devi Priya <quic_devipriy@quicinc=2Ecom>
>> > > ---
>> > >   =2E=2E=2E/devicetree/bindings/pci/qcom,pcie=2Eyaml    | 72 ++++++=
++++++++++++-
>> > >   1 file changed, 70 insertions(+), 2 deletions(-)
>> > >=20
>> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml=
 b/Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml
>> > > index 872817d6d2bd=2E=2Edabdf2684e2d 100644
>> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml
>> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml
>> > > @@ -26,6 +26,7 @@ properties:
>> > >             - qcom,pcie-ipq8064-v2
>> > >             - qcom,pcie-ipq8074
>> > >             - qcom,pcie-ipq8074-gen3
>> > > +          - qcom,pcie-ipq9574
>> > >             - qcom,pcie-msm8996
>> > >             - qcom,pcie-qcs404
>> > >             - qcom,pcie-sa8540p
>> > > @@ -44,11 +45,11 @@ properties:
>> > >     reg:
>> > >       minItems: 4
>> > > -    maxItems: 5
>> > > +    maxItems: 6
>> > >     reg-names:
>> > >       minItems: 4
>> > > -    maxItems: 5
>> > > +    maxItems: 6
>> > >     interrupts:
>> > >       minItems: 1
>> > > @@ -105,6 +106,8 @@ properties:
>> > >       items:
>> > >         - const: pciephy
>> > > +  msi-parent: true
>> > > +
>> > >     power-domains:
>> > >       maxItems: 1
>> > > @@ -173,6 +176,27 @@ allOf:
>> > >               - const: parf # Qualcomm specific registers
>> > >               - const: config # PCIe configuration space
>> > > +  - if:
>> > > +      properties:
>> > > +        compatible:
>> > > +          contains:
>> > > +            enum:
>> > > +              - qcom,pcie-ipq9574
>> > > +    then:
>> > > +      properties:
>> > > +        reg:
>> > > +          minItems: 5
>> > > +          maxItems: 6
>> > > +        reg-names:
>> > > +          minItems: 5
>> > > +          items:
>> > > +            - const: dbi # DesignWare PCIe registers
>> > > +            - const: elbi # External local bus interface registers
>> > > +            - const: atu # ATU address space
>> > > +            - const: parf # Qualcomm specific registers
>> > > +            - const: config # PCIe configuration space
>> > > +            - const: aggr_noc #PCIe aggr_noc
>> >=20
>> > Why do you need this region unlike other SoCs? Is the driver making u=
se of it?
>> We have the aggr_noc region in ipq9574 to achieve higher throughput & t=
o
>> handle multiple PCIe instances=2E The driver uses it to rate adapt 1-la=
ne PCIe
>> clocks=2E My bad, missed it=2E Will add the driver changes in V2=2E
>
>Hmm, this is something new=2E How can you achieve higher throughput with =
this
>region? Can you explain more on how it is used?

Based on the name of the region, it looks like it is an interconnect regio=
n=2E=20

Devi, if this is the case, then you have to handle it through the intercon=
nect driver, rather than poking directly into these registers=2E


>
>Thanks,
>Mani
>
>> >=20
>> > Thanks,
>> > Mani
>> >=20
>> > > +
>> > >     - if:
>> > >         properties:
>> > >           compatible:
>> > > @@ -365,6 +389,39 @@ allOf:
>> > >               - const: ahb # AHB Reset
>> > >               - const: axi_m_sticky # AXI Master Sticky reset
>> > > +  - if:
>> > > +      properties:
>> > > +        compatible:
>> > > +          contains:
>> > > +            enum:
>> > > +              - qcom,pcie-ipq9574
>> > > +    then:
>> > > +      properties:
>> > > +        clocks:
>> > > +          minItems: 6
>> > > +          maxItems: 6
>> > > +        clock-names:
>> > > +          items:
>> > > +            - const: ahb  # AHB clock
>> > > +            - const: aux  # Auxiliary clock
>> > > +            - const: axi_m # AXI Master clock
>> > > +            - const: axi_s # AXI Slave clock
>> > > +            - const: axi_bridge # AXI bridge clock
>> > > +            - const: rchng
>> > > +        resets:
>> > > +          minItems: 8
>> > > +          maxItems: 8
>> > > +        reset-names:
>> > > +          items:
>> > > +            - const: pipe # PIPE reset
>> > > +            - const: sticky # Core Sticky reset
>> > > +            - const: axi_s_sticky # AXI Slave Sticky reset
>> > > +            - const: axi_s # AXI Slave reset
>> > > +            - const: axi_m_sticky # AXI Master Sticky reset
>> > > +            - const: axi_m # AXI Master reset
>> > > +            - const: aux # AUX Reset
>> > > +            - const: ahb # AHB Reset
>> > > +
>> > >     - if:
>> > >         properties:
>> > >           compatible:
>> > > @@ -681,6 +738,16 @@ allOf:
>> > >           - interconnects
>> > >           - interconnect-names
>> > > +  - if:
>> > > +      properties:
>> > > +        compatible:
>> > > +          contains:
>> > > +            enum:
>> > > +              - qcom,pcie-ipq9574
>> > > +    then:
>> > > +      required:
>> > > +        - msi-parent
>> > > +
>> > >     - if:
>> > >         not:
>> > >           properties:
>> > > @@ -693,6 +760,7 @@ allOf:
>> > >                   - qcom,pcie-ipq8064v2
>> > >                   - qcom,pcie-ipq8074
>> > >                   - qcom,pcie-ipq8074-gen3
>> > > +                - qcom,pcie-ipq9574
>> > >                   - qcom,pcie-qcs404
>> > >       then:
>> > >         required:
>> > > --=20
>> > > 2=2E17=2E1
>> > >=20
>> >=20
>> Thanks,
>> Devi Priya
>

