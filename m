Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD44140A1A6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 01:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhIMXnN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 19:43:13 -0400
Received: from mail.i8u.org ([75.148.87.25]:49875 "EHLO chris.i8u.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236079AbhIMXnM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 19:43:12 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 19:43:12 EDT
Received: by chris.i8u.org (Postfix, from userid 1000)
        id DDF6916C958B; Mon, 13 Sep 2021 16:32:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by chris.i8u.org (Postfix) with ESMTP id DD63E16C92D2;
        Mon, 13 Sep 2021 16:32:39 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:32:39 -0700 (PDT)
From:   Hisashi T Fujinaka <htodd@twofifty.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        todd.fujinaka@intel.com
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
In-Reply-To: <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
Message-ID: <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com> <20210913141818.GA27911@codemonkey.org.uk> <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com> <20210913201519.GA15726@codemonkey.org.uk> <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk> <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 Sep 2021, Heiner Kallweit wrote:

> On 13.09.2021 22:32, Dave Jones wrote:
>
> + Jesse and Tony as Intel NIC maintainers
>
>> On Mon, Sep 13, 2021 at 10:22:57PM +0200, Heiner Kallweit wrote:
>>
>> >> This didn't help I'm afraid :(
>> >> It changed the VPD warning, but that's about it...
>> >>
>> >> [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
>> >> [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
>> >> [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
>> >>
>> > With this patch there's no VPD access to this device any longer. So this can't be
>> > the root cause. Do you have any other PCI device that has VPD capability?
>> > -> Capabilities: [...] Vital Product Data
>>
>>
>> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
>>         Subsystem: Device 1dcf:030a
>> 	...
>> 	        Capabilities: [e0] Vital Product Data
>>                 Unknown small resource type 06, will not decode more.
>>
>
> When searching I found the same symptom of invalid VPD data for 82599EB.
> Do these adapters have non-VPD data in VPD address space? Or is the actual
> VPD data at another offset than 0? I know that few Chelsio devices have
> such a non-standard VPD structure.
>
>>
>> I'll add that to the quirk list and see if that helps.
>>
>> 	Dave
>>
> Heiner

Sorry to reply from my personal account. If I did it from my work
account I'd be top-posting because of Outlook and that goes over like a
lead balloon.

Anyway, can you send us a dump of your eeprom using ethtool -e? You can
either send it via a bug on e1000.sourceforge.net or try sending it to
todd.fujinaka@intel.com

The other thing is I'm wondering is what the subvendor device ID you
have is referring to because it's not in the pci database. Some ODMs
like getting creative with what they put in the NVM.

Todd Fujinaka (todd.fujinaka@intel.com)
