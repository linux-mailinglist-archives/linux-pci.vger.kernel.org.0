Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F845728443
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjFHPxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 11:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjFHPxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 11:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2290130C5;
        Thu,  8 Jun 2023 08:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2F863B42;
        Thu,  8 Jun 2023 15:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE0C433B3;
        Thu,  8 Jun 2023 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239543;
        bh=pvqAWOidulMrPd+J15Ghz1umBwgZDI2SWqUvZUVOmdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzURvocvwx/FG1djyynryjJj1UjdpQXT8bYFCTpNH6tqSn+W6ROhno1Jd4JAitQC1
         SNbzfAJZo51jSLF0A/4Hn9+li7qdHrerTT+JbZLy+YZAKbWKKFS83BJqye48TNulez
         dhL5p8XlFXthcfEbodU7E/9xE08WPLfInRaWUdS67hPlsem8hhBvBoYNjkC7cEewv8
         8TZuByC8jJcNUHL+AlL9DDrUbJL7EoDP+zZkic6OK7J97Og+Y6TxYayboKaffSKSjr
         9OI6F3RfoNi33ByxlM9ePoB8muq9FXJKRg1uV9dBlURM4GadYqjbe7up6l+trfEmmL
         BcGfoJ5SCEsbg==
Date:   Thu, 8 Jun 2023 21:22:14 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Message-ID: <20230608155214.GA8632@thinkpad>
References: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
 <1686154687-29356-2-git-send-email-quic_krichai@quicinc.com>
 <20230608152759.GA2721945-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608152759.GA2721945-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 09:27:59AM -0600, Rob Herring wrote:
> On Wed, Jun 07, 2023 at 09:48:05PM +0530, Krishna chaitanya chundru wrote:
> > Add the "pcie-mem" interconnect path to the bindings.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > index b3c22eb..6fc5440 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > @@ -70,6 +70,13 @@ properties:
> >      description: GPIO used as WAKE# output signal
> >      maxItems: 1
> >  
> > +  interconnects:
> > +    maxItems: 1
> > +
> > +  interconnect-names:
> > +    items:
> > +      - const: pcie-mem
> > +
> >    resets:
> >      maxItems: 1
> >  
> > @@ -97,6 +104,8 @@ required:
> >    - interrupts
> >    - interrupt-names
> >    - reset-gpios
> > +  - interconnects
> > +  - interconnect-names
> 
> You can't add required properties. That's an ABI break. Up to the 
> platform whether that's acceptible, but you have to explain all this in 
> the commmit msg.
> 

Some platforms may not boot if a device driver doesn't initialize the
interconnect path. Mostly it is all handled by the bootloader but we have
starting to see cases where bootloader simply ignores them.

So I'd say that these need to be made required (should've been from the start
but I take the blame). And yes, this info should be part of the commit message.

- Mani

> >    - resets
> >    - reset-names
> >    - power-domains
> > -- 
> > 2.7.4
> > 

-- 
மணிவண்ணன் சதாசிவம்
