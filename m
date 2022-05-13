Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46752626C
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380455AbiEMM5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356173AbiEMM5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 08:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FB980BF;
        Fri, 13 May 2022 05:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D51A61FDA;
        Fri, 13 May 2022 12:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD902C34100;
        Fri, 13 May 2022 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652446625;
        bh=OjdLv3FacygxH0mTynUJq34ZIADUEe0SWIdyZK7+nio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMFdH/VNfmO6dmjF/g6BRvqhxaPVL1P2VYKSWCKq/873xLXfZVZkh94/0bb62jUYo
         69Yn/M0gaZgjQlBulLsEvyc7oIOsVPPBa0crmZ89JIS6YW2X9HznGsYQTaUhRUuoWc
         P06vISrLfCcEiZqICmUAc5fY92HOXGQ6igDngjuFzRQ0Fx/M3fQTDz4dFKKXLKGbfu
         BI/eGNQVK0CTxmV+sZdp8jgiq77LEOlGPhqV3ma3l+wvaiClY2qor5RWN94RPtsGac
         ZE9ZX30eVvAgjpZHkd/8Q3PXaUF5h3kY8NG+wiAameeQYz35jEIgesszW4mhChXj6E
         +fFcg/0MH7FUw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npUqs-0002ju-OZ; Fri, 13 May 2022 14:57:02 +0200
Date:   Fri, 13 May 2022 14:57:02 +0200
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
Subject: Re: [PATCH v8 07/10] PCI: qcom: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <Yn5Vnnp7NynOl1DU@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <20220512104545.2204523-8-dmitry.baryshkov@linaro.org>
 <Yn5STCN4smibLubA@hovoldconsulting.com>
 <cf16d72a-33d5-07ca-3e6c-0fd87cb74c1a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf16d72a-33d5-07ca-3e6c-0fd87cb74c1a@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 03:48:09PM +0300, Dmitry Baryshkov wrote:
> On 13/05/2022 15:42, Johan Hovold wrote:

> > If all qcom platform that can support more than 32 MSI require multiple
> > IRQs, how about adding num_vectors to the config instead and set
> > pp->has_split_msi_irq when cfg->num_vectors is set (or unconditionally
> > if you remove the corresponding warning you just added to the dwc host
> > code)?
> > 
> > At least some sc8280xp seem to only support 128 MSI (using 4 IRQs).
> 
> Nice idea, let's do this.

If at all possible it would be even better to just infer it from the
devicetree to avoid having to describe things in two places, though.

Johan
