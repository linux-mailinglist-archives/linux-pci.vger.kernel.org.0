Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD2352C06A
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbiERQuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbiERQuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 12:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D831FE1EB;
        Wed, 18 May 2022 09:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E2AC616EF;
        Wed, 18 May 2022 16:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6A9C385A5;
        Wed, 18 May 2022 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652892619;
        bh=EKfo8rCNyIy8YeDE1LpF8Seb9BHiYKO7eUMI8MfUgBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XaXPeOe1KI51PdJFOGclVzYI2pVIPi3mRdJtkiw+bz1rxLTBiJKOT5iCJwBDjQ7e4
         08/7S6ec+vl1O1EAzMjFu1QJFY9hHfeug3613KdpEXc5IGIUXa4hpwxO2jiUCTlx8j
         M5zS1Ij2juPbnLSZ3Gth+Exc4FG6TLVy39jYUfYgpNFWcz0RNFBRuJlG2PluOR4Gcq
         TzihJWT8NUSt5VXcm4U8ZQ4xLpHx1ecS8XBt7KGJzO8lI9Plc6VvFoQ36sqJRe/yEa
         T25CbOxQyCPcdPfD71VUvTc9ZcdTEqp1Kz+OGbeeqUsbOWq64z0plg8UtsCMxBclrI
         uBXOXHofb08hg==
Date:   Wed, 18 May 2022 11:50:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Axboe <axboe@fb.com>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
        quic_krichai@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Message-ID: <20220518165017.GA1145045@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518035211.GA4791@thinkpad>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 09:22:11AM +0530, Manivannan Sadhasivam wrote:
> On Tue, May 17, 2022 at 12:18:57PM -0500, Bjorn Helgaas wrote:
> > [+cc Prasad, Andy, Rob, Krzysztof, Rajat, Saheed, Rama, Stephen,
> > Dmitry, Kalle for connection to https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/]
> > 
> > Subject line convention for this file is "PCI: qcom:" (not "PCI: dwc:
> > qcom:").
> > 
> > Find this from "git log --oneline drivers/pci/controller/dwc/pcie-qcom.c".
> > 
> > On Tue, May 17, 2022 at 08:41:34PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, May 16, 2022 at 03:19:50PM -0500, Bjorn Helgaas wrote:
> > > > On Fri, May 13, 2022 at 04:30:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > For aggressive power saving on SC7280 SoCs, the power for the
> > > > > PCI devices will be taken off during system suspend. Hence,
> > > > > notify the same to the PCI device drivers using
> > > > > "suspend_poweroff" flag so that the drivers can prepare the PCI
> > > > > devices to handle the poweroff and recover them during resume.
> > > > 
> > > > No doubt "power ... will be taken off during system suspend" is
> > > > true, but this isn't very informative.  Is this a property of
> > > > SC7280?  A choice made by the SC7280 driver?  Why is this not
> > > > applicable to other systems?
> > > 
> > > The SC7280's RPMh firmware is cutting off the PCIe power domain
> > > during system suspend. And as I explained in previous patch, the RC
> > > driver itself may put the devices in D3cold conditionally on this
> > > platform. The reason is to save power as this chipset is being used
> > > in Chromebooks.
> > 
> > It looks like this should be squashed into the patch you mentioned:
> > https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/
> > 
> > If Prasad's patch is applied without this, devices will be powered
> > off, but nvme will not be prepared for it.  Apparently something would
> > be broken in that case?
> > 
> 
> Yes, but Prasad's patch is not yet reviewed so likely not get merged until
> further respins.

Ok.  Please work with Prasad to squash these as needed so there are no
regressions along the way.

> > Also, I think this patch should be reordered so the nvme driver is
> > prepared for suspend_poweroff before the qcom driver starts setting
> > it.  Otherwise there's a window where qcom sets suspend_poweroff and
> > powers off devices, but nvme doesn't know about it, and I assume
> > something will be broken in that case?
> 
> As per my understanding, patches in a series should not have build dependency
> but they may depend on each other for functionality.

Yes.  But if qcom starts powering off devices when nvme isn't
expecting it, it sounds like nvme will regress until the patch that
adds nvme support.  That temporary regression is what I want to avoid.

Bjorn
