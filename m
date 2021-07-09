Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6083C284F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGIRdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 13:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhGIRdA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 13:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5314B613C1;
        Fri,  9 Jul 2021 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625851816;
        bh=El1AElU8+plLBRYg2v7hgDZL2J2sRZUE9mbEQl3v7pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KraN0bSdfXIS2FAZcRzXxFfM6WvtSMQLKP2SCf/WTH1ewUHUMI7mgI3mLYeEp4/0v
         Z1OI2+wE1JF07wt6RoE3Gh6XgfLExpdfl5Knbk7mupAQjL8HyZgtmExwlnJMITRi20
         iuUIUgYb1cUFWZAcluEUNSozknE476a+q6pF97FSC+UaM/vcSfERYp1cPMIPoWiyvM
         H9s02rNCNs/dOs2MheyIFX2tCVc0Bm+tXVfbTToM+cTMgmnosScNi962SurTio6xCX
         HbhLazzl3wSVkHN9VhabEr74vFjnb8zC9YaEcFVZUO0CP02qSavlrGq8dSsNLzdynY
         Ygml3lhm1EIbQ==
Received: by pali.im (Postfix)
        id AFAE177D; Fri,  9 Jul 2021 19:30:13 +0200 (CEST)
Date:   Fri, 9 Jul 2021 19:30:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] mwifiex: pcie: add reset_d3cold quirk for Surface
 gen4+ devices
Message-ID: <20210709173013.vkavxrtz767vrmej@pali>
References: <20210709145831.6123-1-verdre@v0yd.nl>
 <20210709145831.6123-3-verdre@v0yd.nl>
 <20210709151800.7b2qqezlcicbgrqn@pali>
 <b1002254-97c6-d271-c385-4a5c9fe0c914@mailbox.org>
 <20210709161251.g4cvq3l4fnh4ve4r@pali>
 <d9158206-8ebe-c857-7533-47155a6464e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9158206-8ebe-c857-7533-47155a6464e1@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 09 July 2021 19:03:37 Maximilian Luz wrote:
> On 7/9/21 6:12 PM, Pali Rohár wrote:
> 
> [...]
> 
> > > > Hello! Now I'm thinking loudly about this patch. Why this kind of reset
> > > > is needed only for Surface devices? AFAIK these 88W8897 chips are same
> > > > in all cards. Chip itself implements PCIe interface (and also SDIO) so
> > > > for me looks very strange if this 88W8897 PCIe device needs DMI specific
> > > > quirks. I cannot believe that Microsoft got some special version of
> > > > these chips from Marvell which are different than version uses on cards
> > > > in mPCIe form factor.
> > > > 
> > > > And now when I'm reading comment below about PCIe bridge to which is
> > > > this 88W8897 PCIe chip connected, is not this rather an issue in that
> > > > PCIe bridge (instead of mwifiex/88W8897) or in ACPI firmware which
> > > > controls this bridge?
> > > > 
> > > > Or are having other people same issues on mPCIe form factor wifi cards
> > > > with 88W8897 chips and then this quirk should not DMI dependent?
> > > > 
> > > > Note that I'm seeing issues with reset and other things also on chip
> > > > 88W8997 when is connected to system via SDIO. These chips have both PCIe
> > > > and SDIO buses, it just depends which pins are used.
> > > > 
> > > 
> > > Hi and thanks for the quick reply! Honestly I've no idea, this is just the
> > > first method we found that allows for a proper reset of the chip. What I
> > > know is that some Surface devices need that ACPI DSM call (the one that was
> > > done in the commit I dropped in this version of the patchset) to reset the
> > > chip instead of this method.
> > > 
> > > Afaik other devices with this chip don't need this resetting method, at
> > > least Marvell employees couldn't reproduce the issues on their testing
> > > devices.
> > > 
> > > So would you suggest we just try to match for the pci chip 88W8897 instead?
> > 
> > Hello! Such suggestion makes sense when we know that it is 88W8897
> > issue. But if you got information that issue cannot be reproduced on
> > other 88W8897 cards then matching 88W8897 is not correct.
> > 
> >  From all this information looks like that it is problem in (Microsoft?)
> > PCIe bridge to which is card connected. Otherwise I do not reason how it
> > can be 88W8897 affected. Either it is reproducible on 88W8897 cards also
> > in other devices or issue is not on 88W8897 card.
> 
> I doubt that it's an issue with the PCIe bridge (itself at least). The
> same type of bridge is used for both dGPU and NVME SSD on my device (see
> lspci output below) and those work fine. Also if I'm seeing that right
> it's from the Intel CPU, so my guess is that a lot more people would
> have issues with that then.

From information below it seems to be related to surprise removal.
Therefore is surprise removal working without issue for dGPU or NVME
SSD? Not all PCIe bridges support surprise removal...

> 
> I don't know about the hardware side, so it might be possible that it's
> an issue with integrating both bridge and wifi chip, in which case it's
> still probably best handled via DMI quirks unless we know more.
> 
> Also as Tsuchiya mentioned in his original submission, on Windows the
> device is reset via this D3cold method. I've only skimmed that
> errata.inf file mentioned, but I think this is what he's referring to:
> 
>   Controls whether ACPIDeviceEnableD3ColdOnSurpriseRemoval rule will be
>   evaluated or not on a given platform. Currently
>   ACPIDeviceEnableD3ColdOnSurpriseRemoval rule only needs to be
>   evaluated on Surface platforms which contain the Marvell WiFi
>   controller which depends on device going through D3Cold as part of
>   surprise-removal.
> 
> and
> 
>   Starting with Windows releases *after* Blue, ACPI will not put
>   surprise-removed devices into D3Cold automatically. Some known
>   scenarios (viz. WiFi reset/recovery) rely on the device cycling
>   through D3Cold on surprise-removal. This hack allows surprise-removed
>   devices to be put into D3Cold (if supported by the stack).
> 
> So, as far as I can tell, the chip doesn't like to be surprise-removed
> (which seems to happen during reset) and then needs to be power-cycled,
> which I think is likely due to some issue with firmware state.

Thanks for information. This really does not look like PCIe bridge
specific if bridge itself can handle surprise-removed devices. lspci can
tell us if bridge supports it or not (see below).

> So the quirk on Windows seems very Surface specific.
> 
> There also seem a bunch of revisions of these chips around, for example
> my SB2 is affected by a bug that we've tied to the specific hardware
> revision which causes some issues with host-sleep (IIRC chip switches
> rapidly between wake and sleep states without any external influence,
> which is not how it should behave and how it does behave on a later
> hardware revision).

Interesting... This looks like the issue can be in 88W8897 chip and
needs some special conditions to trigger? And Surface is triggering it
always?

> > > Then we'd probably have to check if there are any laptops where multiple
> > > devices are connected to the pci bridge as Amey suggested in a review
> > > before.
> > 
> > Well, I do not know... But if this is issue with PCIe bridge then
> > similar issue could be observed also for other PCIe devices with this
> > PCIe bridge. But question is if there are other laptops with this PCIe
> > bridge. And also it can be a problem in ACPI firmware on those Surface
> > devices, which implements some PCIe bridge functionality. So it is
> > possible that issue is with PCIe bridge, not in HW, but in SW/firmware
> > part which can be Microsoft specific... So too many questions to which
> > we do not know answers.
> > 
> > Could you provide output of 'lspci -nn -vv' and 'lspci -tvnn' on
> > affected machines? If you have already sent it in some previous email,
> > just send a link. At least I'm not able to find it right now and output
> > may contain something useful...
> 
> From my Surface Book 2 (with the same issue):
> 
>  - lspci -tvnn: https://paste.ubuntu.com/p/mm3YpcZJ8N/
>  - lspci -vv -nn: https://paste.ubuntu.com/p/dctTDP738N/

Could you re-run lspci under root account? There are missing important
parts like "Capabilities: <access denied>" where is information if
bridge supports surprise removal or not.

> Regards,
> Max
