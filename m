Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29660F3D4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiJ0JjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiJ0JjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 05:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0EB786CE;
        Thu, 27 Oct 2022 02:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EAE0B8255A;
        Thu, 27 Oct 2022 09:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032D4C433D6;
        Thu, 27 Oct 2022 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666863549;
        bh=v+g7pRKxDyhhfF+WuOK6H0OrXUtvUEoGhM5OK8fa3kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jq+V9llT5CXJFTjov0+0v9i74yYRTIbvZFh9oFHComZQkdc0qVMQO5YL8t4qaiNkU
         mPOXvS4Sl+AvQimGl+u0/jVpQCAgqciwPlMr+Z0fwXhYtZtwdutDJ/S753AUyyw3eo
         rr9XaXTe85cufXENy7927rR8JvLoCLsakXnbGGC/LlrauGMXI+Dl8Rsz1ygy162Ewt
         SqRRkwDOVe/bzqfA522oCTwBUKaCG+ekCMtr8vV1SNueB9MGgr1so1oDjroDaY1r6C
         UsFhb42pIYzNJSkk6TsVF1Zn0nTnVtII0/uH1QORF07Qvj4cDklndDd0I8Loamm6is
         IWHC+UdDR4kbA==
Date:   Thu, 27 Oct 2022 11:39:02 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
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
Message-ID: <Y1pRtoLdWsDONsok@lpieralisi>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

I read this as "trying to bring the link up is mandatory because
we can't detect an empty slot, therefore ~1ms delay during boot
is unavoidable" and on that Rob's suggestion applies.

Just to understand where this thread is going. The suggestion
above does not change the aim of this patch, that seems reasonable
to me and it makes sense even if/when what Rob is suggesting is
implemented.

Is that correct ?

Thanks,
Lorenzo
