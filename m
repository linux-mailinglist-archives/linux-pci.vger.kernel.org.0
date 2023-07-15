Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49842754A26
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jul 2023 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGOQly (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jul 2023 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQly (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jul 2023 12:41:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2416E43;
        Sat, 15 Jul 2023 09:41:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so5230379e87.1;
        Sat, 15 Jul 2023 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689439310; x=1692031310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJZmv5LWPFBrnU1SP5+j9d7fRiuwoaq7jD4jtonKRtw=;
        b=iCIy6/2xWlFotoaznovCtMSKLDBn9w2DSWAJairSvoTSvJMgYXuWcQPiY7JFJUJ1Y0
         bVh4nfX7ppAzHtXXcsUs9Ipqyr5p/1Ne5ZboeqsWeir5EEQP71b8idEhnp/5E/rs9Pdn
         W2xetDFErIwImuaAeJqAVpTjnohuuvW/IHNskX8NQQhrtEv7F3Xc6eNulZWlmCtAYpKm
         bX9H6l4l2Z1yd0800LKzBc8FYZTsMMof+8ixNRgb3aFFO/H7+lrt59gWea/RcLnv+DZU
         QfoTm6IwNGrynBIYQKAdJdgiDgp7mSVvMmRNILv0pBQRkCnX2MD9xHXj0ViHGv4KdQKR
         T1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689439310; x=1692031310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJZmv5LWPFBrnU1SP5+j9d7fRiuwoaq7jD4jtonKRtw=;
        b=HJV3R8Cqrh8ejK8DI2D6xz4KEHmtxeg582OOpPpIhpQpBIBjNxgjDtNSUDST1P59au
         KMS/FrUYk6clevzlOCaWgOxTf2+nX+YINqVke6jcIhJklzoWuL8MwYZXze8yO7lDDQhw
         nSg3MbpqrRQk5NBBRSOgkUhMIZVg09IKtaHEcks65ZYBQM8/83m21Ysd0O+M4smzAP60
         0ePhTbDkV1memyw3ayfdwIPjprltg4catD+2xj804jytc64Ou32nGJ9KSLXTAAXdMtx9
         xSn/6jHVeWV8n6Psf4g5tJncxVaPyD3oXlC7PtqjvPC5MBjHU94IopK6F7HLaT7iEBK3
         0UFw==
X-Gm-Message-State: ABy/qLZ9CXCNzIdPmrAtHbH8ihUE++7+hKJhXMblImsYUhNAUepKtKxJ
        2RDMgSZ9fsEP+0+NkyJJPLxDntg5Ouc=
X-Google-Smtp-Source: APBJJlFV7G+xp0KqqJOwrgI8UakITThWfeoIPbEy3hvxMMlI+G1u2Iso0GtCVrvvHvpkGXh2wdchEQ==
X-Received: by 2002:a05:6512:3e0f:b0:4f8:6b98:f4dd with SMTP id i15-20020a0565123e0f00b004f86b98f4ddmr2009693lfv.32.1689439309823;
        Sat, 15 Jul 2023 09:41:49 -0700 (PDT)
Received: from mobilestation ([85.249.20.164])
        by smtp.gmail.com with ESMTPSA id x7-20020ac259c7000000b004f84b36a24fsm1945590lfn.51.2023.07.15.09.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:41:49 -0700 (PDT)
Date:   Sat, 15 Jul 2023 19:41:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
Message-ID: <3xzo36ek3w4twi4dx7olcms75kd7wvriasovxx7ugufzqlvh2o@7xqvci57mtyl>
References: <20230713171851.73052-1-sebastian.reichel@collabora.com>
 <20230713171851.73052-2-sebastian.reichel@collabora.com>
 <mikpjlkg65ubb75jrcrbiomzq6npte5iheuoexgrtu4kqej5do@qbwcbcgorg3k>
 <20230714224444.oymtxdzugkxrgu2q@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714224444.oymtxdzugkxrgu2q@mercury.elektranox.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 15, 2023 at 12:44:44AM +0200, Sebastian Reichel wrote:
> Hi Serge,
> 
> On Fri, Jul 14, 2023 at 08:25:52PM +0300, Serge Semin wrote:
> > On Thu, Jul 13, 2023 at 07:18:49PM +0200, Sebastian Reichel wrote:
> > > The RK356x (and RK3588) have 5 ganged interrupts. For example the
> > > "legacy" interrupt combines "inta/intb/intc/intd" with a register
> > > providing the details.
> > > 
> > > Currently the binding is not specifying these interrupts resulting
> > > in a bunch of errors for all rk356x boards using PCIe.
> > > 
> > > Fix this by specifying the interrupts and add them to the example
> > > to prevent regressions.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  .../bindings/pci/rockchip-dw-pcie.yaml        | 18 +++++
> > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 76 ++++++++++++++++++-
> > >  2 files changed, 93 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > index a4f61ced5e88..aad53c7d8485 100644
> > > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > @@ -60,6 +60,17 @@ properties:
> > >        - const: aux
> > >        - const: pipe
> > >  
> > > +  interrupts:
> > > +    maxItems: 5
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: sys
> > > +      - const: pmc
> > > +      - const: msg
> > > +      - const: legacy
> > > +      - const: err
> > > +
> > >    msi-map: true
> > >  
> > >    num-lanes: true
> > > @@ -108,6 +119,7 @@ unevaluatedProperties: false
> > >  
> > >  examples:
> > >    - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >  
> > >      bus {
> > >          #address-cells = <2>;
> > > @@ -127,6 +139,12 @@ examples:
> > >                            "aclk_dbi", "pclk",
> > >                            "aux";
> > >              device_type = "pci";
> > > +            interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> > >              linux,pci-domain = <2>;
> > >              max-link-speed = <2>;
> > >              msi-map = <0x2000 &its 0x2000 0x1000>;
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > index 1a83f0f65f19..973bf8f2730d 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > @@ -193,9 +193,83 @@ properties:
> > >            oneOf:
> > >              - description: See native "app" IRQ for details
> > >                enum: [ intr ]
> > > +        - description:
> > > +            Combined legacy interrupt, which is used to signal the following
> > > +            interrupts
> > > +              * inta
> > > +              * intb
> > > +              * intc
> > > +              * intd
> > > +          const: legacy
> > > +        - description:
> > > +            Combined system interrupt, which is used to signal the following
> > > +            interrupts
> > > +              * phy_link_up
> > > +              * dll_link_up
> > > +              * link_req_rst_not
> > > +              * hp_pme
> > > +              * hp
> > > +              * hp_msi
> > > +              * link_auto_bw
> > > +              * link_auto_bw_msi
> > > +              * bw_mgt
> > > +              * bw_mgt_msi
> > > +              * edma_wr
> > > +              * edma_rd
> > > +              * dpa_sub_upd
> > > +              * rbar_update
> > > +              * link_eq_req
> > > +              * ep_elbi_app
> > > +          const: sys
> > > +        - description:
> > > +            Combined PM interrupt, which is used to signal the following
> > > +            interrupts
> > > +              * linkst_in_l1sub
> > > +              * linkst_in_l1
> > > +              * linkst_in_l2
> > > +              * linkst_in_l0s
> > > +              * linkst_out_l1sub
> > > +              * linkst_out_l1
> > > +              * linkst_out_l2
> > > +              * linkst_out_l0s
> > > +              * pm_dstate_update
> > > +          const: pmc
> > > +        - description:
> > > +            Combined message interrupt, which is used to signal the following
> > > +            interrupts
> > > +              * ven_msg
> > > +              * unlock_msg
> > > +              * ltr_msg
> > > +              * cfg_pme
> > > +              * cfg_pme_msi
> > > +              * pm_pme
> > > +              * pm_to_ack
> > > +              * pm_turnoff
> > 
> > > +              * obff_idle
> > > +              * obff_obff
> > > +              * obff_cpu_active
> > 
> > These are marked is "inputs" (from the DW PCIe controller point of
> > view) in the HW manual. Are you sure they are supposed to generate any
> > IRQ? Based on the DW PCIe HW-manual they are supposed to be set by the
> > _application_ (a.k.a your driver or vendor-specific RTL block) as a
> > request to the DW PCIe controller to emit an OBFF message. There is a
> > signal marked as "output" and named as "app_obff_msg_grant" which most
> > likely is relevant here.
> 
> I do not have the Synopsys HW manual, but RK3588 TRM has these:
> 
> obff_idle_int - controller received an 'IDLE' OBFF message.
> obff_obff_int - controller received an 'OBFF' OBFF message.
> obff_cpu_active_int - controller received an 'CPU Active' OBFF message.

I failed to find any signal indicating the OBFF messages reception.
There is only the explicitly described SII OBFF Message Generation
Signals. Anyway it's not that important. It might be some
Rockchip-specific RTL block detecting incoming OBFF messages.

> 
> > > +          const: msg
> > > +        - description:
> > > +            Combined error interrupt, which is used to signal the following
> > > +            interrupts
> > > +              * aer_rc_err
> > > +              * aer_rc_err_msi
> > > +              * rx_cpl_timeout
> > > +              * tx_cpl_timeout
> > > +              * cor_err_sent
> > > +              * nf_err_sent
> > > +              * f_err_sent
> > > +              * cor_err_rx
> > > +              * nf_err_rx
> > > +              * f_err_rx
> > > +              * radm_qoverflow
> > > +          const: err
> > 
> > The most of the signals you cited in the description properties are a
> > part of the so called "System Information Interface" defined in the DW
> > PCIe databook. Here is what the doc says regarding these signals:
> > 
> > "The SII exchanges various system-related information between the
> > controller and your application. Most of the SII signals are provided
> > for flexibility. Your application is not required to use all of the
> > SII signals. Your application logic is expected to drive and monitor
> > the signals that it needs to function correctly. SII inputs that your
> > application does not require, must be driven to 0."
> > 
> > Amongst tons of various informational signals available in the
> > framework of SII, there is "SII: Interrupt Signals" which are normally
> > utilized by the vendor-specific controller implementations and which
> > are defined as generic in this DT-bindings. (MSI IRQ signal is defined
> > separately from SII as "MSI Interface Signals".)
> > 
> > What is normally expected is that all the generic SII IRQs are
> > supplied as the separate signals meanwhile the rest of the SII signals
> > are combined in an additional line named like "app".
> > 
> > In your case we find an intermix of the SII generic IRQs and some SII
> > signals (though some of the names listed in your descriptions don't
> > match to what is defined in the DW PCIe HW manual). So what you said
> > in v1:
> > 
> > On Thu, Jul 13, 2023 at 7:47PM +0200, Sebastian Reichel wrote:
> > > I suppose "sys", "pmc", "msg" and "err" all fit for "app", since
> > > they are vendor specific with the extra layer? But obviously I
> > > cannot specify "app" more than once."
> > 
> > is mainly correct. For instance, the most of the generic SII interrupt
> > signals are combined in your "sys" IRQ, like "hp", "bw_au", "bw_mg",
> > "dma", "l_eq"; your "pmc" and "msg" IRQs are a set of the SII signals
> > not listed in the "SII Interrupt Signals" list; the "err" IRQ has the
> > "aer" generic SII Interrupt, but the rest of the signals are common SII
> > signals.
> > 
> > I am not fully certain of what to do in this case. Some possible options:
> > 
> > 1. Keep the names defined as is, add them to the list of generic IRQ
> > names, describe them as "Combined IRQ signals" but with no specific
> > signals listed and with some generic meaningful description.
> > Alternatively create a separate sub-schema in the generic
> > "interrupt-names" property constraints in the same way as it's done
> > for the "vendor-specific IRQ names" and do the same with the names
> > descriptions. In anyway move your detailed descriptions to the
> > Rockchip DW PCIe DT-schema. In this case we imply that your names
> > could be re-used for some other device bindings.
> > 
> > 2. Keep the names defined as is, add them to the list of
> > "vendor-specific IRQ names" sub-schema in the "interrupt-names"
> > property, describe each of them as "Combined IRQ signals" but with no
> > specific signals listed and with some generic meaningful description.
> > Move your detailed descriptions to the Rockchip DW PCIe DT-schema.
> > 
> > 3. Add "app_" prefix to all your IRQs (except "legacy") and convert
> > the generic "app" IRQ name constraint to accepting a pattern like
> > '^app(_.*)?$' or similar. Move your detailed descriptions to the
> > Rockchip DW PCIe DT-schema.
> > 
> > 4. Add Rockchip-specific prefix to the names (except "legacy"), add
> > all of them (for instance as a pattern-like schema) to the
> > vendor-specific IRQ names part of the "interrupt-names" items list
> > with a description referring to the Rockchip DT-bindings. Move your
> > detailed descriptions to the Rockchip DW PCIe DT-schema.
> > 
> > Doubtfully the categorization chosen by the Rockchip HW designers is
> > fully universal so the names could be utilized for other devices. Thus
> > IMO the options 2-4 might be more preferable over 1.
> > 
> > In anyway the detailed descriptions with the listed lines should be
> > in the Rockchip DW PCIe DT-bindings since they are definitely
> > vendor-specific.
> > 
> > Regarding the "legacy" name used as a combined "int(a|b|c|d)" IRQ.
> > Alas we can't change it. So it's either option 1 or 2. 
> > 
> > What do you think? Rob, Krzysztof, any better idea?
> 

> Adding extra description to the interrupt-names list in the Rockchip
> specific binding file does not work:
> 
> Additional properties are not allowed ('description' was unexpected)
> 
> But I suppose we are fine without them. People working on Rockchip
> will easily find them in the TRM.

You can add them to the "interrupts" property describing each array
entry in accordance with the "interrupt-names" items.

> 
> After looking at it again, my suggestion is to do the following
> replacement in the Rockchip specific binding:
> 
> allOf:
>   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> 
> with
> 
> allOf:
>   - $ref: /schemas/pci/pci-bus.yaml#
>   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#

I was hoping to avoid that. The snps,dw-pcie-common.yaml schema was
intended to describe the common parts of the DW PCIe Root Port and
End-point DT-bindings and not being used directly. The original idea
behind all the created DW PCIe RP/EP bindings was to bring some order
to the already over-diverged resources naming hell. In case of the
Rockchip PCIe controller we've got only the peculiar interrupt
signals. The rest of the resources comply fine with the generic schema
and it's pretty much hard do decide what solution to select to keep
all the resources described and to use the generic DW PCIe Root Port
DT-bindings.  It would be pity to fallback to using the
snps,dw-pcie-common.yaml schema just because of the interrupt names.

amlogic,axg-pcie.yaml schema already slipped in behind my back (and
BTW contains a bug in the "select" property which makes it not being
selected for the Amlogic PCIe nodes evaluation at all). Since I am not
the driver maintainer that will likely happen again over and over. Sigh...

Anyways if no better solution comes up from Rob or Krzysztof and they
didn't approve any option suggested by me above I guess your
suggestion might be selected then.

> 
> Then the generic binding can stay as is. The Rockchip binding does
> not use the "snps,dw-pcie" fallback compatible.

And it's a correct way to do since the fallback compatible is not that
useful. In this particular case it's just useless seeing there is a
low-level platform driver for the Rockchip PCIe host controller.

> 
> > >      allOf:
> > >        - contains:
> > > -          const: msi
> > > +          enum:
> > > +            - msi
> > > +            - msg
> > 
> > Based on the above the "msg" interrupt doesn't get to be required.
> > Rob, is it possible to have a constraint which would require either
> > the "msi" IRQ name or the "msi-map" DT-property or both?
> 
> I played around a little bit and found this solution: Remove the
> above allOf and instead add this to the allOf at the root level:
> 
> allOf:
>   - if:
>       not:
>         required:
>           - msi-map
>     then:
>       properties:
>         interrupt-names:
>          contains:
>             const: msi
> 
> That might be sensible to do in the generic binding even when
> Rockchip is no longer using it. The Rockchip binding has msi-map
> in its required list, so it's fine without this.

Right. Don't know how come this solution didn't cross my mind that
evening. Anyway indeed it would be useful to have it in the generic DW
PCIe Root Port DT-schema irrespective from the Rockchip PCIe host
controller DT-schema implementation.

-Serge(y)

> 
> Greetings,
> 
> -- Sebastian
> 
> > 
> > -Serge(y)
> > 
> > >  
> > >  additionalProperties: true
> > >  
> > > -- 
> > > 2.40.1
> > > 
> > 
> > -- 
> > To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.


