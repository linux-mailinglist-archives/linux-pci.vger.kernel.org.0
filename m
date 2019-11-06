Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9878FF1A8F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKFP6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 10:58:30 -0500
Received: from foss.arm.com ([217.140.110.172]:42182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfKFP6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 10:58:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C04BA46A;
        Wed,  6 Nov 2019 07:58:29 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 511073F71A;
        Wed,  6 Nov 2019 07:58:28 -0800 (PST)
Date:   Wed, 6 Nov 2019 15:58:23 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        treding@nvidia.com, swarren@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: tegra: Enable Relaxed Ordering only for Tegra20
 & Tegra30
Message-ID: <20191106155823.GA23381@e121166-lin.cambridge.arm.com>
References: <20190704150428.4035-1-vidyas@nvidia.com>
 <20190704160948.GA28058@e121166-lin.cambridge.arm.com>
 <310ce6f7-9379-9857-ac7c-53118b80966b@nvidia.com>
 <20190705093859.GA17491@e121166-lin.cambridge.arm.com>
 <c3168cfd-69f5-b51b-6ec6-c64d447efe13@nvidia.com>
 <8456f10d-6ff6-f3f4-54ff-aca2e90a0c0b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8456f10d-6ff6-f3f4-54ff-aca2e90a0c0b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 10:50:28AM +0000, Jon Hunter wrote:
> Hi Lorenzo,
> 
> On 09/07/2019 12:02, Jon Hunter wrote:
> > On 05/07/2019 10:38, Lorenzo Pieralisi wrote:
> >> [+Greg]
> >>
> >> On Fri, Jul 05, 2019 at 09:57:25AM +0100, Jon Hunter wrote:
> >>> Hi Lorenzo,
> >>>
> >>> On 04/07/2019 17:09, Lorenzo Pieralisi wrote:
> >>>> On Thu, Jul 04, 2019 at 08:34:28PM +0530, Vidya Sagar wrote:
> >>>>> Currently Relaxed Ordering bit in the configuration space is enabled for
> >>>>> all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID and
> >>>>> Device-ID, but, as per the Technical Reference Manual of Tegra20 which is
> >>>>> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
> >>>>> in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
> >>>>> its root ports to avoid deadlock in hardware. The same is applicable for
> >>>>> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
> >>>>> but the same must not be extended to root ports of other Tegra SoCs or
> >>>>> other hosts as the same issue doesn't exist there.
> >>>>>
> >>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >>>>
> >>>> You forgot Thierry's ACK, I added it back but next time pay more
> >>>> attention please.
> >>>>
> >>>> You should link the versions through eg git send-email
> >>>> --in-reply-to=Message-Id so that it is easier to follow.
> >>>>
> >>>>> ---
> >>>>> V3:
> >>>>> * Modified commit message to make it more precise and explicit
> >>>>>
> >>>>> V2:
> >>>>> * Modified commit message to include reference to Tegra20 TRM document.
> >>>>>
> >>>>>  drivers/pci/controller/pci-tegra.c | 7 +++++--
> >>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>
> >>>> I applied it to pci/tegra after rewriting the whole commit log and
> >>>> adding a Fixes: tag that you or someone at Nvidia will follow up;
> >>>> I will check.
> >>>
> >>> I had a chat with Vidya last night to understand the issue, so now I
> >>> have a good understanding of the problem this has caused, which is very
> >>> unfortunate indeed!
> >>>
> >>> Vidya mentioned that you would like us to get this backported to stable
> >>> branches. Please correct me if I am wrong here. We can certainly do
> >>> that, but I do have concerns about doing so, for non-Tegra devices
> >>> inparticularly, given that this has been around for sometime now. Hence,
> >>> I was wondering if we should leave this soak in the mainline for at
> >>> least a kernel release cycle before doing so. I really don't want to
> >>> break stable for anyone. What are your thoughts on this?
> >>
> >> I looped in Greg to pick his brain, since it is unclear how we should
> >> apply the stable kernel rules on this specific patch. Basically, this
> >> technically is not a bug, it is just bad code that forces a feature on
> >> ALL kernels that compile the PCI Tegra Controller driver in the kernel.
> >> I would really really want to have this patch applied to all stable
> >> kernels but first as you said it is better to apply it to mainline and
> >> check it does not cause any issues on any other arch/platform then
> >> we can think about backporting it to stable kernels.
> >>
> >> I am not happy to force Relaxed Ordering on any PCIe device on
> >> any platform/arch compiling PCI Tegra controller in, so somehow
> >> we must rectify this situation, this is gross as I said before.
> > 
> > Yes understood. Let's plan to sync up on this once v5.3 is out and see
> > how the land lies. We have an internal issue filed to track this and so
> > we should not forget!
> 
> Please let us know if your preference it still to push this back to
> stable. I assume that there has been no fallout from this change.

No fallout reported to the best of my knowledge, yes we should go ahead
and push it to stable kernels, thanks for the reminder.

Cheers,
Lorenzo
