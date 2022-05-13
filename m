Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B55265AD
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiEMPL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381775AbiEMPLX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 11:11:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222FD26575;
        Fri, 13 May 2022 08:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92133B83084;
        Fri, 13 May 2022 15:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C5EC34100;
        Fri, 13 May 2022 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652454678;
        bh=MtrIpPhPFkqz1LD3YnBuRqxM5Mj4y3HqU7Se/OhQo6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hzc7PXj34yRNaj3fPoDHetgbkm9CQnXISkhFD2dRMEuR8m3loTO45ZYzmv5/L0AOO
         3lEq7qYGIihBruhERN8+gssWFnbQRmx2Pl5wJmEEb2qMaXoK+FNCXKYcDEFx7EFVBT
         K2uhBYBBvHazgAhQsGSFiBNfdvu39GZO/5LU3F9GMnSTPTNY7hrYQXWiTSaHe7Gc7O
         otBinfCz1bwjLe8gjrSM53jNfpsFf7xS006iwtZVj4KN10V/CEyfZ7p+eb8z7REwKx
         qncfftcnbnWJ5ZiL1yt8yodLLFOL4A/vlmSsOazojzJDf7VEo+AALaDIpcDKniheRB
         3MB/Yx/KUSOxA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npWwk-0003Y3-JG; Fri, 13 May 2022 17:11:15 +0200
Date:   Fri, 13 May 2022 17:11:14 +0200
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
Message-ID: <Yn51EsPE8Ulqvbva@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <Yn4dvpgezdrKmSro@hovoldconsulting.com>
 <CAA8EJppzx5nkyk3gCcgFd2G_QewU0Z6q6DAKb-Lyj9yZyMo_AA@mail.gmail.com>
 <Yn4ms7dKIzeAqt7A@hovoldconsulting.com>
 <CAA8EJppt4kiG45j62W-Z7Ech8WLNnkPYiVv7T0AK-+Dxtc_KDQ@mail.gmail.com>
 <Yn5UqtxmNGWerTdT@hovoldconsulting.com>
 <8f13d1e4-eaca-a8ef-510a-6b2e039612d6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f13d1e4-eaca-a8ef-510a-6b2e039612d6@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 04:50:11PM +0300, Dmitry Baryshkov wrote:
> On 13/05/2022 15:52, Johan Hovold wrote:
> > On Fri, May 13, 2022 at 01:10:44PM +0300, Dmitry Baryshkov wrote:
> >> On Fri, 13 May 2022 at 12:36, Johan Hovold <johan@kernel.org> wrote:

> > Are you able to confirm that all sc8280xp systems have only four msi
> > IRQs?
> 
> Unfortunately no. I don't have access to the sc8280xp docs. Let's see if 
> BjornA can confirm this.

I just talked to Bjorn and he said they should be the same for all
sc8280xp, but of course there are complications like some of the
controllers actually having more than 4 interrupts (even if they may not
be usable).

Probably best to describe this in DT.
 
> > This seems like another case of using the kernel as a DT validator by
> > describing things in two places and making sure that they match.
> 
> Yep, this seems like a bad habit of mine: to distrust the DT.
> 
> > 
> > I assume the number of vectors will always be a multiple of the numbers
> > of msi IRQs. Right? Then we don't need to encode this number for every
> > supported platform in the corresponding PCIe driver even if we end up
> > describing it in the binding.
> 
> But it was your suggestion!

Heh. But with the caveat that I'd still prefer this to come from DT if
possible. :)

> Let's drop the warning then, parse what was passed by the DT and just 
> print the total amount of MSI IRQs.

Perfect, thanks!

Johan
