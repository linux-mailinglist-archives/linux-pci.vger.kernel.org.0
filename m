Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5584960E6F7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiJZSGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiJZSGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 14:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D488D7F09E;
        Wed, 26 Oct 2022 11:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F365362021;
        Wed, 26 Oct 2022 18:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574DFC433D7;
        Wed, 26 Oct 2022 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666807596;
        bh=4Ry1Q5d6VyYAtwqcwyBOrq8sXSXZowB76ukzb0eQauQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aYfe0l10vOzLOKwtzGxRtnK/bnVCFwWe/CV2hAFounytVYrYMTC8Smp8+jb1l0P4N
         0UdseidqXwfExPCM8v6YsgUNfot0ea93RKZTR8dY51jVJMYFHPTbS4FlJZB1/a5q6B
         zCkIgpSP8KVhWH8xxi4oaZudn/TzvN/nyoV0M/6UJQxPpRI9QQJNI4zVrBIQa+lNQt
         CA9Wrmj1Dl5BOjYeza4X4wMnbF+2v6XrnV5YIfFs4cGuGkYKbUilA1/9CjQKGSWXrc
         1keJviFCiQUpRVx+kdis6hduztoUsI6KRFMjviEZw0NQRI3nEYnHJ06nnhrcbWy8l1
         0EAq5whCZcc3A==
Received: by mail-lj1-f173.google.com with SMTP id r22so23318328ljn.10;
        Wed, 26 Oct 2022 11:06:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf1PUvnMMt0lQkmknSR0FK/kVxrKqVVkONcl6V0wsDgLW5S1hgT8
        sYPCjbFCmgND5RG1gVblQpUo/Alq25pxbWVQmA==
X-Google-Smtp-Source: AMsMyM4OtSf0SXpZ/2/chydSuOw3yWBSqWG5PGwSneAnm63+SLB/BA62e3JN0Yg7Yu70L2blrKQ3BwvY0ioWHEoJ+Kg=
X-Received: by 2002:a05:651c:1590:b0:26e:1cb:1fc3 with SMTP id
 h16-20020a05651c159000b0026e01cb1fc3mr16082989ljq.221.1666807594355; Wed, 26
 Oct 2022 11:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas> <20220914062411.GD16459@workstation>
 <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
 <20220915145241.GE4550@workstation> <CAL_JsqJ-qrveNrF2n4jY3yXw4eXqa1Q0-ffX3yssJYmC_xZgRQ@mail.gmail.com>
 <96dd0b76-00b6-4f18-640a-7540fab13ea7@nvidia.com>
In-Reply-To: <96dd0b76-00b6-4f18-640a-7540fab13ea7@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Oct 2022 13:06:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKOxDteJasZqP9+Q-TE_rGOpiU13aN-R+4SjhSFXLeuog@mail.gmail.com>
Message-ID: <CAL_JsqKOxDteJasZqP9+Q-TE_rGOpiU13aN-R+4SjhSFXLeuog@mail.gmail.com>
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event logging
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 10, 2022 at 1:02 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 10/4/2022 6:23 PM, Rob Herring wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Sep 15, 2022 at 9:52 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> >>
> >> On Thu, Sep 15, 2022 at 09:16:27AM -0500, Rob Herring wrote:
> >>> On Wed, Sep 14, 2022 at 1:24 AM Manivannan Sadhasivam
> >>> <manivannan.sadhasivam@linaro.org> wrote:
> >>>>
> >>>> On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
> >>>>> On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
> >>>>>> On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> >>>>>>> On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> >>>>>>>> Some of the platforms (like Tegra194 and Tegra234) have open slots and
> >>>>>>>> not having an endpoint connected to the slot is not an error.
> >>>>>>>> So, changing the macro from dev_err to dev_info to log the event.
> >>>>>>>
> >>>>>>> But the link up not happening is an actual error and -ETIMEDOUT is being
> >>>>>>> returned. So I don't think the log severity should be changed.
> >>>>>>
> >>>>>> Yes it is an error in the sense it is a timeout, but reporting an error
> >>>>>> because nothing is attached to a PCI slot seems a bit noisy. Please note
> >>>>>> that a similar change was made by the following commit and it also seems
> >>>>>> appropriate here ...
> >>>>>>
> >>>>>> commit 4b16a8227907118e011fb396022da671a52b2272
> >>>>>> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >>>>>> Date:   Tue Jun 18 23:32:06 2019 +0530
> >>>>>>
> >>>>>>      PCI: tegra: Change link retry log level to debug
> >>>>>>
> >>>>>>
> >>>>>> BTW, we check for error messages in the dmesg output and this is a new error
> >>>>>> seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
> >>>>>> error, but in this case it seem more appropriate to make this a info or
> >>>>>> debug level print.
> >>>>>
> >>>>> Can you tell whether there's a device present, e.g., via Slot Status
> >>>>> Presence Detect?  If there's nothing in the slot, I don't know why we
> >>>>> would print anything at all.  If a card is present but there's no
> >>>>> link, that's probably worthy of dev_info() or even dev_err().
> >>>>>
> >>>>
> >>>> I don't think all form factors allow for the PRSNT pin to be wired up,
> >>>> so we cannot know if the device is actually present in the slot or not all
> >>>> the time. Maybe we should do if the form factor supports it?
> >>>>
> >>>>> I guess if you can tell the slot is empty, there's no point in even
> >>>>> trying to start the link, so you could avoid both the message and the
> >>>>> timeout by not even calling dw_pcie_wait_for_link().
> >>>>
> >>>> Right. There is an overhead of waiting for ~1ms during boot.
> >>>
> >>> Async probe should mitigate that, right? Saravana is working toward
> >>> making that the default instead of opt in, but you could opt in now.
> >>>
> >>
> >> No. The delay is due to the DWC core waiting for link up that depends on
> >> the PCIe device to be present on the slot.
> >
> > Yes, I understand that already.
> >
> >> The driver probe order
> >> doesn't apply here.
> >
> > I'm not talking about probe order, but rather async probe enabling
> > parallel probing. If waiting for the link happens asynchronously, then
> > other probes can happen in parallel and you won't see the delay (until
> > you run out of cores or all the other probes are faster).
>
> Are you suggesting to break the existing probe of DWC based PCIe
> platform drivers into two i.e. sync part that handles the sequence up
> until link up and the async part that starts after link is up (or after
> LIKUP_TIMEOUT if link doesn't come up).

No, just make the driver opt-in to async probe. It's 1 flag to set for
the driver. Then the delay in your probe is not blocking other probes
and the whole probe for the driver happens in parallel. Then the delay
is only an issue if it is longer than all the other things
initializing during boot or if you are on a single core system.
Neither is likely true.

Rob
