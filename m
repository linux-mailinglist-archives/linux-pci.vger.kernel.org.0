Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7896896ED
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjBCKfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 05:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjBCKfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 05:35:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA0DBF2
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 02:35:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q8so3503873wmo.5
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 02:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nK1fKLOt07t42zA/NX2wGsyiI7WBcYF7AOE3hneo4g=;
        b=lGlrN2dLHCqbVaz9YwNXyYBxz/D4lgr1w3rTIjvH6mHtVSex/oYRqVJZSvja++c7dX
         xV7x/9Jc6K4Kf2xqpfN+ic1eERM9X/cvt+VW6AmxHUN3Hqwec7sIAhgdWQWZzJN1Hhr3
         tN0RenMHGUwpg+Q3tyWOeQZjZP+z6Yi6TsDUfiZLjaOdSk87MK/BheMPucGXmc8Hpn0z
         My3v5YVkw3WFc4Rfmx3FQSCzuU9KqW427NArdeYqNIbRD3qp9fBE3rpkjbgn7hRlf0fl
         Mwt7JC9YMg9/Ca3s8zVtCPscyNEkz8t4F0cgEioLLX4v/bZgqrKtkyNOaHlnWNo3pI91
         dhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nK1fKLOt07t42zA/NX2wGsyiI7WBcYF7AOE3hneo4g=;
        b=zwz4Oqr3lnaaWe7ESsIjDLu1wAbDmQRBduUs0SeSbXwGxwIUk6CXE3BQ0+RbOCog3Z
         e6hool+cPMsUheaCAjSgsyR6UIz4cM2OanqCh+bGwmsvcNaYvLMkHx/9zA56Luue12RZ
         GDb9qoK0uQ/XEAGCdwANX8cNAV5bwriwv4UOp5dSHbl8DG3XEGNYsLZAFzi5XOh7uwQe
         /pxG6Ueent1ZdwyjOW98ESa8wuf7lszaIUOkzKbZe0PxkiYzOxBtcIjOLeKPbfLyG6V6
         o65iQQSEyLTc/VkAIFZU+mllY1YC6nypSEtTo8ILtLgqZYMSE0TbSQdqcmmWRWwdoE/L
         mdGw==
X-Gm-Message-State: AO0yUKXpTRsTE3AJCqFPKDF8ldVrNjpv+TI6U7v5Rbg8SN3Logs5SemB
        Vru8WXZhQF4PANc1EBLrWjP+TA==
X-Google-Smtp-Source: AK7set9RC8S35h+qhPzKZvtF5wjsR0eplkWa2WNr9zYS986q703SswD03oXnA4dKIZPQBnvNp8f3og==
X-Received: by 2002:a05:600c:cc3:b0:3dc:42d2:aeee with SMTP id fk3-20020a05600c0cc300b003dc42d2aeeemr9366732wmb.25.1675420530617;
        Fri, 03 Feb 2023 02:35:30 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x33-20020a05600c18a100b003dd7edcc960sm2112414wmp.45.2023.02.03.02.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:35:30 -0800 (PST)
Date:   Fri, 3 Feb 2023 12:35:28 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Message-ID: <Y9zjcKkknDQWEvjH@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-10-abel.vesa@linaro.org>
 <Y9zb2X4w0WfIto9n@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zb2X4w0WfIto9n@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23-02-03 11:03:05, Johan Hovold wrote:
> On Fri, Feb 03, 2023 at 10:18:04AM +0200, Abel Vesa wrote:
> > Add the SM8550 platform to the binding.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > 
> > This patchset relies on the following patchset:
> > https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> > 
> > The v6 of this patch is:
> > https://lore.kernel.org/all/20230202123902.3831491-10-abel.vesa@linaro.org/
> > 
> > Changes since v6:
> >  * none
> > 
> > Changes since v5:
> >  * added Krzysztof's R-b tag
> > 
> > Changes since v4:
> >  * dropped _serdes infix from ln_shrd table name and from every ln_shrd
> >    variable name
> >  * added hyphen between "no CSR" in both places
> >  * dropped has_ln_shrd_serdes_tbl
> >  * reordered qmp_pcie_offsets_v6_20 by struct members
> >  * added rollback for no-CSR reset in qmp_pcie_init fail path
> >  * moved ln_shrd offset calculation after port_b
> >  * dropped the minItems for interconnects
> >  * made iommu related properties global
> >  * renamed noc_aggr_4 back to noc_aggr
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
> >  * added "minItems: 1" to interconnects, since sm8550 pcie uses just one,
> >    same for interconnect-names
>  
> > +  enable-gpios:
> > +    description: GPIO controlled connection to ENABLE# signal
> > +    maxItems: 1
> 
> What is this gpio used for? Describing it as "ENABLE#" looks wrong as
> AFAIK it's not part of the PCIe interface.

Oups, that should've been dropped here as well, as I did in the dts/dtsi
patches.

> 
> There's also no driver support being adding for this gpio as part of
> this series and you don't use it for either controller on the MTP.
> 
> Are you relying on firmware to enable this one currently perhaps?
> 
> > +
> >    perst-gpios:
> >      description: GPIO controlled connection to PERST# signal
> >      maxItems: 1
> 
> Johan
