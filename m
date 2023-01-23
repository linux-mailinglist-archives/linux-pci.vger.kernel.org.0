Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B084B67796D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjAWKoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjAWKon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:44:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A623338
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:44:40 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso10250950wmc.4
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PRs0X+3aZkUyAyZNInl6XM4TEd14eiJLS0plPeBy28=;
        b=K88Go0c9RwpYrCjd8bPLO6/yvB177d2ERGGqVyjrBtJ9Opnop6J7vSn8s/U2vk6XVn
         DKQRsPLphOjXmo+4O6Xf6J/AwvIM8Hw+9mrA0s4gXs8L/Cu8icK2ei4FJgqP0QHd2lwm
         OXna9tNDOkThjGrHlLYolglciahMV3QqY6i33rWAugKCUJYjfgOU4JIyKwnpXXmiDBgL
         Ex7Cw/DFsPEVJ3IoTrJPpq5+ceTj/wUEOf5HA5jM4U4/Nl7q2TK3XLM5fyTumzMQD7nH
         dnh7Wk8vrbvt4os3AlADxQHlUjrTD74altfFZCn+98LHTlUKNv/cV14Hc6LuvyOR2ouH
         Fp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PRs0X+3aZkUyAyZNInl6XM4TEd14eiJLS0plPeBy28=;
        b=17S/e+xpvimeUKp1laVCxHhO4svwCDFwuDmzWIyOU0jne4BpTZ1Cz8g4cwqepyuOWM
         A6Skur8QC5pcWUj3PLgUo7b46+A+XIisIWVLu+DGKJNdodd4ZWZNmj3w0+Gw+mZXEDdD
         QAIUD7AwVcNs9sAlfbuzAcqU8odtaVf+xzLfhFMF//QYWumMYrG4ybC7SJ8JIZVvqflT
         lV0WMaXuxtvGlHk/QcGaHM9YpHKhdiwd4qgEh6hp9duMPSpSSGjD4eu/xcRK5R4Pp4Oz
         diJDYVzxmWCdbxh/SNgJbYttxVVflGPE7Ux4oEQzo6Ca8mgfAErEa3TUEJJe16cHeqXe
         /PUQ==
X-Gm-Message-State: AFqh2kpnSA9GqScqXVS3qL++BJLANwe5ydfxPr52yvoo7FHx4AIO6+oV
        fxyNSGEEKjS+ZUcOJW6NsFJs2w==
X-Google-Smtp-Source: AMrXdXtYXhgiuVMLRok6DEndR280kFs7XZ1T15tjO8fChaM2EuvZ84f0IK3TKrrf3jQLDOppc2V2uw==
X-Received: by 2002:a05:600c:24ce:b0:3da:18c5:e48b with SMTP id 14-20020a05600c24ce00b003da18c5e48bmr31515548wmu.18.1674470678999;
        Mon, 23 Jan 2023 02:44:38 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6d49000000b002bc8130cca7sm34107744wri.23.2023.01.23.02.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:44:38 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:44:36 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Message-ID: <Y85lFD3m5pdpNtdR@linaro.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-10-abel.vesa@linaro.org>
 <7af21247-a44e-cb46-7461-204fa6b4fcab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af21247-a44e-cb46-7461-204fa6b4fcab@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23-01-22 15:10:59, Krzysztof Kozlowski wrote:
> On 19/01/2023 15:04, Abel Vesa wrote:
> > Add the SM8550 platform to the binding.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > 
> > The v3 of this patchset is:
> > https://lore.kernel.org/all/20230119112453.3393911-1-abel.vesa@linaro.org/
> > 
> > Changes since v3:
> >  * renamed noc_aggr to noc_aggr_4, as found in the driver
> > 
> > Changes since v2:
> >  * dropped the pipe from clock-names
> >  * removed the pcie instance number from aggre clock-names comment
> >  * renamed aggre clock-names to noc_aggr
> >  * dropped the _pcie infix from cnoc_pcie_sf_axi
> >  * renamed pcie_1_link_down_reset to simply link_down
> >  * added enable-gpios back, since pcie1 node will use it
> > 
> > Changes since v1:
> >  * Switched to single compatible for both PCIes (qcom,pcie-sm8550)
> >  * dropped enable-gpios property
> >  * dropped interconnects related properties, the power-domains
> >  * properties
> >    and resets related properties the sm8550 specific allOf:if:then
> >  * dropped pipe_mux, phy_pipe and ref clocks from the sm8550 specific
> >    allOf:if:then clock-names array and decreased the minItems and
> >    maxItems for clocks property accordingly
> >  * added "minItems: 1" to interconnects, since sm8550 pcie uses just
> >  * one,
> >    same for interconnect-names
> > 
> > 
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index a5859bb3dc28..58f926666332 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -34,6 +34,7 @@ properties:
> >        - qcom,pcie-sm8250
> >        - qcom,pcie-sm8450-pcie0
> >        - qcom,pcie-sm8450-pcie1
> > +      - qcom,pcie-sm8550
> >        - qcom,pcie-ipq6018
> >  
> >    reg:
> > @@ -65,9 +66,11 @@ properties:
> >    dma-coherent: true
> >  
> >    interconnects:
> > +    minItems: 1
> >      maxItems: 2
> >  
> 
> I don't see my concerns from v3 answered.

Check the dates for v4 and your reply to v3.

v4 was sent a day before you sent your v3 comments. :)

> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.

Will address your comments in next version.

> 
> Thank you.
> 
> Best regards,
> Krzysztof
> 
