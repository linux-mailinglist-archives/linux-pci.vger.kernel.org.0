Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15FF5B9DC0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiIOOxC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIOOxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 10:53:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2117974DF6;
        Thu, 15 Sep 2022 07:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D849B81EC0;
        Thu, 15 Sep 2022 14:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44004C433D6;
        Thu, 15 Sep 2022 14:52:50 +0000 (UTC)
Date:   Thu, 15 Sep 2022 20:22:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <treding@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220915145241.GE4550@workstation>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 15, 2022 at 09:16:27AM -0500, Rob Herring wrote:
> On Wed, Sep 14, 2022 at 1:24 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
> > > > On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> > > > > On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> > > > > > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > > > > > not having an endpoint connected to the slot is not an error.
> > > > > > So, changing the macro from dev_err to dev_info to log the event.
> > > > >
> > > > > But the link up not happening is an actual error and -ETIMEDOUT is being
> > > > > returned. So I don't think the log severity should be changed.
> > > >
> > > > Yes it is an error in the sense it is a timeout, but reporting an error
> > > > because nothing is attached to a PCI slot seems a bit noisy. Please note
> > > > that a similar change was made by the following commit and it also seems
> > > > appropriate here ...
> > > >
> > > > commit 4b16a8227907118e011fb396022da671a52b2272
> > > > Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > Date:   Tue Jun 18 23:32:06 2019 +0530
> > > >
> > > >     PCI: tegra: Change link retry log level to debug
> > > >
> > > >
> > > > BTW, we check for error messages in the dmesg output and this is a new error
> > > > seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
> > > > error, but in this case it seem more appropriate to make this a info or
> > > > debug level print.
> > >
> > > Can you tell whether there's a device present, e.g., via Slot Status
> > > Presence Detect?  If there's nothing in the slot, I don't know why we
> > > would print anything at all.  If a card is present but there's no
> > > link, that's probably worthy of dev_info() or even dev_err().
> > >
> >
> > I don't think all form factors allow for the PRSNT pin to be wired up,
> > so we cannot know if the device is actually present in the slot or not all
> > the time. Maybe we should do if the form factor supports it?
> >
> > > I guess if you can tell the slot is empty, there's no point in even
> > > trying to start the link, so you could avoid both the message and the
> > > timeout by not even calling dw_pcie_wait_for_link().
> >
> > Right. There is an overhead of waiting for ~1ms during boot.
> 
> Async probe should mitigate that, right? Saravana is working toward
> making that the default instead of opt in, but you could opt in now.
> 

No. The delay is due to the DWC core waiting for link up that depends on
the PCIe device to be present on the slot. The driver probe order
doesn't apply here.

Thanks,
Mani

> Rob
