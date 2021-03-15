Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A733C73D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhCOT6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 15:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233828AbhCOT6K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 15:58:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7271E64EB9;
        Mon, 15 Mar 2021 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615838289;
        bh=5zzvi1tBQA3+VE5Dazrz3QA09vEWmVFXyrYB+PNEe+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjKN2G1tuATT2qCgstRDpDM6BDVUnFN+VzbpTSRlqf7MdoknP7Yg4mycU+iGDu+AA
         6u/1HxpD/gHCCxGwNYCFwCD16JKrAcxyAkETJtjS7gxo0YGGQSi7mNBaONQJNz0Fow
         iwGtyJW0it+fLpxaG70j+Lsu04uxJaq2/Gb70TZSVpFBfWqgclbMV3T2nd37VVGxPH
         8uV2+tiR3MJHXL3q4qXieqDql6dOQjT7sRLx95HA1oiTIh1wN94UFFfr8s5c7B6YfG
         rFOOBDrJbmKYl8lUEanP1JRvy+bV2l9N1/xP7ymSBNdRyBDXdoSu8NgZR7U0sWnc4s
         3qcPoNJdrlpiw==
Received: by pali.im (Postfix)
        id BA09E82E; Mon, 15 Mar 2021 20:58:06 +0100 (CET)
Date:   Mon, 15 Mar 2021 20:58:06 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20210315195806.iqdt5wvvkvpmnep7@pali>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali>
 <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com>
 <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali>
 <877dr3lpok.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dr3lpok.fsf@toke.dk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 02 November 2020 16:54:35 Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > On Saturday 31 October 2020 13:49:49 Toke Høiland-Jørgensen wrote:
> >> "™֟☻̭҇ Ѽ ҉ ®" <vtolkm@googlemail.com> writes:
> >> 
> >> > On 30/10/2020 15:23, Pali Rohár wrote:
> >> >> On Friday 30 October 2020 14:02:22 Toke Høiland-Jørgensen wrote:
> >> >>> Pali Rohár <pali@kernel.org> writes:
> >> >>>> My experience with that WLE900VX card, aardvark driver and aspm code:
> >> >>>>
> >> >>>> Link training in GEN2 mode for this card succeed only once after reset.
> >> >>>> Repeated link retraining fails and it fails even when aardvark is
> >> >>>> reconfigured to GEN1 mode. Reset via PERST# signal is required to have
> >> >>>> working link training.
> >> >>>>
> >> >>>> What I did in aardvark driver: Set mode to GEN2, do link training. If
> >> >>>> success read "negotiated link speed" from "Link Control Status Register"
> >> >>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
> >> >>>> retrain link again (for WLE900VX now it would be at GEN1). After that
> >> >>>> card is stable and all future retraining (e.g. from aspm.c) also passes.
> >> >>>>
> >> >>>> If I do not change aardvark mode from GEN2 to GEN1 the second link
> >> >>>> training fails. And if I change mode to GEN1 after this failed link
> >> >>>> training then nothing happen, link training do not success.
> >> >>>>
> >> >>>> So just speculation now... In current setup initialization of card does
> >> >>>> one link training at GEN2. Then aspm.c is called which is doing second
> >> >>>> link retraining at GEN2. And if it fails then below patch issue third
> >> >>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as aardvark
> >> >>>> then second link retraining must be at GEN1 (not GEN2) to workaround
> >> >>>> this issue.
> >> >>>>
> >> >>>> Bjorn, Toke: what about trying to hack aspm.c code to never do link
> >> >>>> retraining at GEN2 speed? And always force GEN1 speed prior link
> >> >>>> training?
> >> >>> Sounds like a plan. I poked around in aspm.c and must confess to being a
> >> >>> bit lost in the soup of registers ;)
> >> >>>
> >> >>> So if one of you can cook up a patch, that would be most helpful!
> >> >> I modified Bjorn's patch, explicitly set tls to 1 and added debug info
> >> >> about cls (current link speed, that what is used by aardvark). It is
> >> >> untested, I just tried to compile it.
> >> >>
> >> >> Can try it?
> >> >>
> >> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >> >> index 253c30cc1967..f934c0b52f41 100644
> >> >> --- a/drivers/pci/pcie/aspm.c
> >> >> +++ b/drivers/pci/pcie/aspm.c
> >> >> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> >> >>   	unsigned long end_jiffies;
> >> >>   	u16 reg16;
> >> >>   
> >> >> +	u32 lnkcap2;
> >> >> +	u16 lnksta, lnkctl2, cls, tls;
> >> >> +
> >> >> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
> >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
> >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
> >> >> +	cls = lnksta & PCI_EXP_LNKSTA_CLS;
> >> >> +	tls = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> >> >> +
> >> >> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x lnkctl2 %#06x tls %#03x\n",
> >> >> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
> >> >> +		lnksta, cls,
> >> >> +		lnkctl2, tls);
> >> >> +
> >> >> +	tls = 1;
> >> >> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
> >> >> +					PCI_EXP_LNKCTL2_TLS, tls);
> >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
> >> >> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
> >> >> +		lnkctl2, tls);
> >> >> +
> >> >>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> >> >>   	reg16 |= PCI_EXP_LNKCTL_RL;
> >> >>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> >> >> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> >> >>   			break;
> >> >>   		msleep(1);
> >> >>   	} while (time_before(jiffies, end_jiffies));
> >> >> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
> >> >> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
> >> >>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
> >> >>   }
> >> >>   
> >> >
> >> > Still exhibiting the BAR update error, run tested with next--20201030
> >> 
> >> Yup, same for me :(

I'm answering my own question. This code does not work on Omnia because
A38x pci-mvebu.c driver is using emulator for PCIe root bridge and it
does not implement PCI_EXP_LNKCTL2 and PCI_EXP_LNKCTL2 registers. So
code for forcing link speed has no effect on Omnia...

> > So then it is different issue and not similar to aardvark one.

... and therefore it can be still same issue which I have debugged on
aardvark.

> > Anyway, was ASPM working on some previous kernel version? Or was it
> > always broken on Turris Omnia?
> 
> I tried bisecting and couldn't find a commit that worked. And OpenWrt by
> default builds with ASPM off, so my best guess is that it was always
> broken.

I see and it makes sense that it does not work in any version.

> However, the two other PCI slots *do* work with ASPM on, as long as
> they're both occupied when booting. If I only have one card installed
> apart from the dodge WLE900, both of them fail...
> 
> > And has somebody other Armada 385 device with mPCIe slots to test if
> > ASPM is working? Or any other 32bit Marvell Armada SOC?
> >
> > I would like to know if this is issue only on Turris Omnia or also on
> > other Armada 385 SOC device or even on any other device which uses
> > pci-mvebu.c driver.
> 
> See above: It does partly work on my Omnia. Is it possible to define a
> quirk to just disable it on a per-slot basis for the WLE900 card? Maybe
> just doing that and calling it a day would be enough...
> 
> -Toke
> 

Toke, can you try to put this WLE900 card into some x86 computer and
check if this card works? With ASPM enabled and also with ASPM disabled?
Or into any other device which does not have Marvell PCIe controller?

I need to know if problem is with this WLE900 card or with Marvell's
PCIe controllers. And based on it I can prepare quirk / hook for either
WLE900 card or for Marvell PCIe drivers (or both, based on how it is
broken).


PS for all: Please do not put fancy unicode characters into email From:
header as such email would be marked as spam and automatically filtered.
