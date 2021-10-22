Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF2437BBE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhJVRTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 13:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhJVRTs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 13:19:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B090A60F50;
        Fri, 22 Oct 2021 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634923051;
        bh=RpFlMfOJp/0Mp6DhHY6au1mFbQ65CRVgtR4u4j+Vg5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ72y0i+3ERGzBHoOgMjnMxHufbMt7V9Xkz+wyYL6ghV6EDdTxG6x/RB0ZVR4nAC1
         +W5D8m+CzrQAw95QCYKm5oJ0Z6mNUtSo9Y4g9CuhESZq7/f7Yf8m6DBkHz3nZIHgJL
         Hz6WgARl+JRDxKmAo9akXZqoC/JD80/icyXfhyqzmlZS71MIl61Uk8A6lKdS2ioYlz
         E1uXO/pUNCs4QELv6O1Jf8No9bxI/1XvzK5k0fpniTloeH9kxrCEoB95NfZrwbe+DH
         DIo9uiYekssmwMiVnfkoW6pYtkXEC2g6ShK6oP6kne76JS+4jikyZRsE3LaJlbnK3v
         S9gT89Ba8KQLQ==
Received: by pali.im (Postfix)
        id 5B33F7F6; Fri, 22 Oct 2021 19:17:28 +0200 (CEST)
Date:   Fri, 22 Oct 2021 19:17:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
Message-ID: <20211022171728.vlxb3sfebfpgijmp@pali>
References: <20211005153209.GA1083986@bhelgaas>
 <d4b34193-31e5-2f95-6365-b58239c0dabb@arm.com>
 <20211005194301.enb5jddzdgczcolx@pali>
 <694bb355-3b5e-9801-3772-ff784b49a603@arm.com>
 <6be712f8-c794-aa55-8679-5ddb5a16bcef@gmail.com>
 <f648bc89-f08b-e806-45f9-5a1b61686e19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f648bc89-f08b-e806-45f9-5a1b61686e19@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 22 October 2021 10:04:36 Florian Fainelli wrote:
> On 10/5/21 7:07 PM, Florian Fainelli wrote:
> > 
> > 
> > On 10/5/2021 3:25 PM, Jeremy Linton wrote:
> >> Hi,
> >>
> >> On 10/5/21 2:43 PM, Pali Rohár wrote:
> >>> Hello!
> >>>
> >>> On Tuesday 05 October 2021 10:57:18 Jeremy Linton wrote:
> >>>> Hi,
> >>>>
> >>>> On 10/5/21 10:32 AM, Bjorn Helgaas wrote:
> >>>>> On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
> >>>>>> Additionally, some basic bus/device filtering exist to avoid sending
> >>>>>> config transactions to invalid devices on the RP's primary or
> >>>>>> secondary bus. A basic link check is also made to assure that
> >>>>>> something is operational on the secondary side before probing the
> >>>>>> remainder of the config space. If either of these constraints are
> >>>>>> violated and a config operation is lost in the ether because an EP
> >>>>>> doesn't respond an unrecoverable SERROR is raised.
> >>>>>
> >>>>> It's not "lost"; I assume the root port raises an error because it
> >>>>> can't send a transaction over a link that is down.
> >>>>
> >>>> The problem is AFAIK because the root port doesn't do that.
> >>>
> >>> Interesting! Does it mean that PCIe Root Complex / Host Bridge (which I
> >>> guess contains also logic for Root Port) does not signal transaction
> >>> failure for config requests? Or it is just your opinion? Because I'm
> >>> dealing with similar issues and I'm trying to find a way how to detect
> >>> if some PCIe IP signal transaction error via AXI SLVERR response OR it
> >>> just does not send any response back. So if you know some way how to
> >>> check which one it is, I would like to know it too.
> >>
> >> This is my _opinion_ based on what I've heard of some other IP
> >> integration issues, and what i've seen poking at this one from the
> >> perspective of a SW guy rather than a HW guy. So, basically worthless.
> >> But, you should consider that most of these cores/interconnects aren't
> >> aware of PCIe completion semantics so its the root ports
> >> responsibility to say, gracefully translate a non-posted write that
> >> doesn't have a completion for the interconnects its attached to,
> >> rather than tripping something generic like a SLVERR.
> >>
> >> Anyway, for this I would poke around the pile of exception registers,
> >> with your specific processors manual handy because a lot of them are
> >> implementation defined.
> > 
> > I should be able to get you an answer in the new few days whether
> > configuration space requests also generate an error towards the ARM CPU,
> > since memory space requests most definitively do.
> 
> Did not get an answer from the design team, but going through our bug
> tracker, there were evidences of configuration space accesses also
> generating external aborts:
> 
> [    8.988237] Unhandled fault: synchronous external abort (0x96000210) at 0xffffff8009539004
> [    9.026698] PC is at pci_generic_config_read32+0x30/0xb0

So this is error caused by reading from config space.

Can you check if also writing to config space can trigger some crash? If
yes, I would like to know if write would be also synchronous or rather
asynchronous abort.
