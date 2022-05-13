Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9704252625A
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379412AbiEMMxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbiEMMxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 08:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19205DBD0;
        Fri, 13 May 2022 05:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F3361FD1;
        Fri, 13 May 2022 12:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E614EC34100;
        Fri, 13 May 2022 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652446382;
        bh=3J5WfttXP189VhL7W2bFZTgwaX7YWuMqm/AXgNh6OKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIX8zCDJlYbaFgnIytTsr/7IoCN6fFAsRSCrFkOi+HYmoX7h3Hsy67otFWD2hWT+/
         AiMidg6z2gU0oZjLbtRL1iM2PwzDuVhGW04258sYhjw+7ztB1QnQsFUNPMIz0yloL1
         YUkBdnv6pSCQiben9eykA4y+U9vgy6R0nOQs9z1Fxu2ydbgvtOnaycqPUGtP1Lgzcz
         cXJtuSkv91zSIW0WvtqsrtZTnYC5/l2qJbPOOmQHk+AjBzlXlCbDv7VTabEeh3xMHH
         /EzAB1lQW/8nHgmqL4oMR2CVAXcQZ9XDZ9r3hz5fjH3ep1Do7ruBWMh1G/Q4ibbOsS
         3BPy2O8uyCGkQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npUmw-0002iH-3O; Fri, 13 May 2022 14:52:58 +0200
Date:   Fri, 13 May 2022 14:52:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 00/10] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <Yn5UqtxmNGWerTdT@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <Yn4dvpgezdrKmSro@hovoldconsulting.com>
 <CAA8EJppzx5nkyk3gCcgFd2G_QewU0Z6q6DAKb-Lyj9yZyMo_AA@mail.gmail.com>
 <Yn4ms7dKIzeAqt7A@hovoldconsulting.com>
 <CAA8EJppt4kiG45j62W-Z7Ech8WLNnkPYiVv7T0AK-+Dxtc_KDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppt4kiG45j62W-Z7Ech8WLNnkPYiVv7T0AK-+Dxtc_KDQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 01:10:44PM +0300, Dmitry Baryshkov wrote:
> On Fri, 13 May 2022 at 12:36, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, May 13, 2022 at 12:28:40PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, 13 May 2022 at 11:58, Johan Hovold <johan@kernel.org> wrote:

> > But you also added
> >
> > +        - properties:
> > +            interrupts:
> > +              minItems: 8
> > +            interrupt-names:
> > +              minItems: 8
> > +              items:
> > +                - const: msi0
> > +                - const: msi1
> > +                - const: msi2
> > +                - const: msi3
> > +                - const: msi4
> > +                - const: msi5
> > +                - const: msi6
> > +                - const: msi7
> >
> > which means that I can no longer describe the four interrupts in DT.
> >
> > I didn't check the implementation, but it seems you should derive the
> > number of MSIs based on the devicetree as I guess you did in v7.
> 
> It is a conditional, so you can add another conditional for the
> sc8280xp platform describing just 4 interrupts. And as you don't have
> legacy DTS, you can completely omit the backwards compatible clause in
> your case.
> So, something like:
>  - if:
>    properties:
>       contains:
>          enum:
>             - qcom,pcie-sc8280xp
>   then:
>     properties:
>        interrupts:
>           minItems: 4
>           maxItems: 4
>        interrupt-names:
>            items:
>               - const: msi0
>               - const: msi1
>               - const: msi2
>               - const: msi3

Ok, so the driver code still handles it, thanks.

Are you able to confirm that all sc8280xp systems have only four msi
IRQs?

This seems like another case of using the kernel as a DT validator by
describing things in two places and making sure that they match.

I assume the number of vectors will always be a multiple of the numbers
of msi IRQs. Right? Then we don't need to encode this number for every
supported platform in the corresponding PCIe driver even if we end up
describing it in the binding.

Johan
