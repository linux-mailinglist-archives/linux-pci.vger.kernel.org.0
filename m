Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7676209F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 19:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGYRwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGYRwm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 13:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CF2122
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690307507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ht71+ytnrpXSHx2moGem4zAvWEqI+p9KhmtDtZeMjAg=;
        b=YarrbDZjrAnB1oc5u0x0YNImnV4vkV3Etu+yGGiJJQWCOOd67SNLlUIb0D1Zcr66Di18g+
        9nYq5hYbv6vnu0GdNRSRbOwQR2sL9q7DnGZJ3N+5F7UU+6jE4u9J24n130JR5Q/qIr8WsY
        met8KaskBW7oC534mTnTX9QJw4gQ98c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-xilYFKYaP_uSv4ZhyRZECw-1; Tue, 25 Jul 2023 13:51:46 -0400
X-MC-Unique: xilYFKYaP_uSv4ZhyRZECw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-403a4cdbfa2so66522451cf.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 10:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307505; x=1690912305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht71+ytnrpXSHx2moGem4zAvWEqI+p9KhmtDtZeMjAg=;
        b=aAX76YUM6DruidzoXd7kOZdM96khS8FCirk194ic6IFBrMQgqtsfA1CokDVaLae2uD
         bxsAKJww7iNXd7lfOGVpEUQN2u7FKTS3FJFQRBzoG83YxcIS2+FopjYXmCCpGNf7JEO0
         sCO6uQyDpVGBnFBqc7N5oF/MjCcmaL5jFIJe0r/Y76pJm/cGMt052EOacJzQmRkzsmKl
         13MPyUebyziHchkyTlEHdtNdRfCiZOOouSnxx6wAFnBdeEBhWIXwuwjG6KLveBtuI7cQ
         kM5NYoMmxEvEt7DDxaPrzi1mM/ecW02ymGadzOEHH9Cqs25LmKPP2Ekj6uNx+Q0KQfaX
         roAw==
X-Gm-Message-State: ABy/qLajrykRyVRSAGLc1yqQznReZlLZF5mtxvyIco8L33Sei65K7Wn6
        kNfRPQryTXjfvqwLxAxXJooSUm99U+gJDFPhhhKjpvy7/zyBT8kyF+JArxF/PVgd2mRboC9N9f2
        zcNkTgX/PeBX3EhJ02aJ7
X-Received: by 2002:a05:622a:1488:b0:403:cd14:8f with SMTP id t8-20020a05622a148800b00403cd14008fmr3326831qtx.57.1690307505557;
        Tue, 25 Jul 2023 10:51:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGSa0nCWmMbPWJbZR6wFN48R9hc4qEYNSaYYTSwy4C5YEFIRwnrCb6WaT328GKqxkr0FeDhCQ==
X-Received: by 2002:a05:622a:1488:b0:403:cd14:8f with SMTP id t8-20020a05622a148800b00403cd14008fmr3326816qtx.57.1690307505290;
        Tue, 25 Jul 2023 10:51:45 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id ff20-20020a05622a4d9400b00403f1a7be90sm4221230qtb.88.2023.07.25.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:51:44 -0700 (PDT)
Date:   Tue, 25 Jul 2023 12:51:42 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe
 PHY
Message-ID: <y7tuvgc7r4o6jhe7hhyqxaksalld4zn5ou53ywdkwfrp2y773v@z3nvbgd2i6lz>
References: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
 <1689311319-22054-3-git-send-email-quic_msarkar@quicinc.com>
 <132e9514-7eb9-8915-6130-5bf656c1aaac@linaro.org>
 <ca51b1dc-5805-5b01-01e0-a7dff535cb6c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca51b1dc-5805-5b01-01e0-a7dff535cb6c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:33:20PM +0530, Mrinmay Sarkar wrote:
> 
> On 7/17/2023 12:55 PM, Krzysztof Kozlowski wrote:
> > On 14/07/2023 07:08, Mrinmay Sarkar wrote:
> > > Add devicetree YAML binding for Qualcomm QMP PCIe PHY
> > > for SA8775p platform.
> > > 
> > > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > > ---
> > >   .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml      | 19 ++++++++++++++++++-
> > >   1 file changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > index a0407fc..ca55ed9 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> > > @@ -16,6 +16,8 @@ description:
> > >   properties:
> > >     compatible:
> > >       enum:
> > > +      - qcom,sa8775p-qmp-gen4x2-pcie-phy
> > > +      - qcom,sa8775p-qmp-gen4x4-pcie-phy
> > >         - qcom,sc8280xp-qmp-gen3x1-pcie-phy
> > >         - qcom,sc8280xp-qmp-gen3x2-pcie-phy
> > >         - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> > > @@ -30,7 +32,7 @@ properties:
> > >     clocks:
> > >       minItems: 5
> > > -    maxItems: 6
> > > +    maxItems: 7
> > >     clock-names:
> > >       minItems: 5
> > > @@ -41,6 +43,7 @@ properties:
> > >         - const: rchng
> > >         - const: pipe
> > >         - const: pipediv2
> > > +      - const: phy_aux
> > >     power-domains:
> > >       maxItems: 1
> > > @@ -141,6 +144,20 @@ allOf:
> > >           compatible:
> > >             contains:
> > >               enum:
> > > +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> > > +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 7
> > > +        clock-names:
> > > +          minItems: 7
> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > This probably works but is not obvious and easy to read. You have here
> > if:then:else: block, so else applies to your variant. Change all these
> > if clauses for clocks into separate clauses per matching variant
> > (if:then: ... if:then:... if:then:...)

As far as I can tell, this actually doesn't work :(

> > 
> > Best regards,
> > Krzysztof
> 
> My Bad here, This patch already applied we will take care this in next patch
> set.
> 
> Thanks,
> Mrinmay
> 

Mrinmay, do you plan on spinning what Krzysztof suggested? I grabbed
linux-next today and ran into this (looks like clocks, clock-names in
binding is broken and looks like we're either missing the required
power-domain in the dts or it isn't actually required):

    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % git diff
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1 DT_SCHEMA_FILES=phy/qcom,sc8280xp-qmp-pcie-phy.yaml qcom/sa8775p-ride.dtb
      UPD     include/config/kernel.release
      LINT    Documentation/devicetree/bindings
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
    /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml: ignoring, error parsing file
      DTC_CHK arch/arm64/boot/dts/qcom/sa8775p-ride.dtb
    /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c04000: 'power-domains' is a required property
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
    /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c04000: clocks: [[31, 66], [31, 68], [31, 94], [31, 72], [31, 74], [31, 77], [31, 70]] is too long
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
    /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c04000: clock-names: ['aux', 'cfg_ahb', 'ref', 'rchng', 'pipe', 'pipediv2', 'phy_aux'] is too long
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
    /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c14000: 'power-domains' is a required property
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
    /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c14000: clocks: [[31, 80], [31, 82], [31, 94], [31, 86], [31, 88], [31, 91], [31, 84]] is too long
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
    /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c14000: clock-names: ['aux', 'cfg_ahb', 'ref', 'rchng', 'pipe', 'pipediv2', 'phy_aux'] is too long
        from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1    7.65s user 0.52s system 99% cpu 8.231 total
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % 
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % 
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % 
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % # Total hack just to show our issues in current binding
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % git diff
    diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
    index ca55ed9d74ac..5476cf2422da 100644
    --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
    +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
    @@ -87,7 +87,6 @@ required:
       - reg
       - clocks
       - clock-names
    -  - power-domains
       - resets
       - reset-names
       - vdda-phy-supply
    @@ -132,12 +131,6 @@ allOf:
               maxItems: 5
             clock-names:
               maxItems: 5
    -    else:
    -      properties:
    -        clocks:
    -          minItems: 6
    -        clock-names:
    -          minItems: 6
     
       - if:
           properties:
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1 DT_SCHEMA_FILES=phy/qcom,sc8280xp-qmp-pcie-phy.yaml qcom/sa8775p-ride.dtb
      UPD     include/config/kernel.release
      LINT    Documentation/devicetree/bindings
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
    /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml: ignoring, error parsing file
      DTC_CHK arch/arm64/boot/dts/qcom/sa8775p-ride.dtb
    ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1    7.58s user 0.87s system 98% cpu 8.618 total
    (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % 


Thanks,
Andrew

