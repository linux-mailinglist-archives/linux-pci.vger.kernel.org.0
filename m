Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70814532F11
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiEXQfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiEXQfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 12:35:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC3B5DD19;
        Tue, 24 May 2022 09:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B34B8B8172E;
        Tue, 24 May 2022 16:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF225C34113;
        Tue, 24 May 2022 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653410143;
        bh=7/CXSpGFetqZ4K6+jyYYWqzkzTNkmovMcnAT+IEJp3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kOPC/JlisBhQTK5OLXuCEZI8htrS8JzZKBU0BOx++mHa6e9Qwi7ztkP3BWa6UvTKJ
         KwCM5neBp94iprroRaL5xchAd8UKbs4Sb3Y8zGf9jpVhqt2CFA4r85bRKbud91XKbR
         TcuwYHqHB6nuMfTJ9ENxhcudOrj4jp991/c2FpmemJH4uvWl1CYfaBKqNVEevdd65B
         8yHxlnYA0KoeZ0ZOJ5LKjoI+zsKMCCbc7cng79gGHRgJR1yCToHejfN3876XNgZ1Fc
         VxJeN/G7z35z2FWR3ZD89NiuKS/KG15I5WZdQZ7qDDqjAau9hK0oO0AOw8597TXGro
         iCyvOEd1OMopw==
Date:   Tue, 24 May 2022 11:35:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 0/8] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <20220524163540.GA252985@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpomokT1whO+6UMSoqSxWdexDc7yWF3ZVK=CJveBGZntXQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 07:17:42PM +0300, Dmitry Baryshkov wrote:
> On Tue, 24 May 2022 at 17:53, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, May 23, 2022 at 09:18:28PM +0300, Dmitry Baryshkov wrote:
> > > I have replied with my Tested-by to the patch at [2], which has landed
> > > in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> > > Add support for handling MSIs from 8 endpoints"). However lately I
> > > noticed that during the tests I still had 'pcie_pme=nomsi', so the
> > > device was not forced to use higher MSI vectors.
> > >
> > > After removing this option I noticed that hight MSI vectors are not
> > > delivered on tested platforms. After additional research I stumbled upon
> > > a patch in msm-4.14 ([1]), which describes that each group of MSI
> > > vectors is mapped to the separate interrupt. Implement corresponding
> > > mapping.
> > >
> > > The first patch in the series is a revert of  [2] (landed in pci-next).
> > > Either both patches should be applied or both should be dropped.
> >
> > 20f1bfb8dd62 is currently on Lorenzo's pci/qcom branch:
> >
> >   $ git log --oneline remotes/lorenzo/pci/qcom
> >   bddedfeb1315 dt-bindings: PCI: qcom: Add schema for sc7280 chipset
> >   a6f2d6b1b349 dt-bindings: PCI: qcom: Specify reg-names explicitly
> >   81dab110d351 dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
> >   5383d16f0607 dt-bindings: PCI: qcom: Convert to YAML
> >   3ae93c5a9718 PCI: qcom: Fix unbalanced PHY init on probe errors
> >   b986db29edbb PCI: qcom: Fix runtime PM imbalance on probe errors
> >   dcd9011f591a PCI: qcom: Fix pipe clock imbalance
> >   3007ba831ccd PCI: qcom: Add SM8150 SoC support
> >   f52d2a0f0d32 dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
> >   20f1bfb8dd62 PCI: qcom: Add support for handling MSIs from 8 endpoints
> >   312310928417 Linux 5.18-rc1
> >
> > Is it safe for me to just drop that single patch before sending the
> > pull request for v5.19?  Then target the rest of this series for
> > v5.20?
> 
> Yes and yes.

Great, thank you!  I have dropped that one from my "next" branch.
