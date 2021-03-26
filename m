Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6C34AB98
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhCZPfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 11:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhCZPer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 11:34:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 151DB619FC;
        Fri, 26 Mar 2021 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616772887;
        bh=mVf/Y9grvuij0pYC1c/t4rakt4mmSPGNv+fH3PoHblI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKRMOcLr/jWF3fA77tNtyqDS7KpUz39l9kXdaOeyM26YPymsL4EhdK/AS21hgSBbK
         ZO52LwxKQCJhDl2mOuM74yPKP/AnvQMW8nhT7OfdIOXakHMg9s3Sk20kNo0f/wwWIq
         Eto+Uh4R5sKO419s7/bikCUsQSlFFnAOm4+zF2PJeeUw8DF7VoEsmtPMMF2N7p1n6h
         PWVZXloyyhlFLNUuUMP1ulmO8O8FEb6AKoWnHN5Q//hDaRkXpEgsh8LE9FTV3kVzET
         T+6cLVwpNTP9NrnHMS6neqJLjKZCkN+bXmNCKzoqSOmxvEiQYObChLgzG9MfHT1Z6w
         gpGlyILctFzHg==
Received: by pali.im (Postfix)
        id 783A9842; Fri, 26 Mar 2021 16:34:44 +0100 (CET)
Date:   Fri, 26 Mar 2021 16:34:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20210326153444.cdccc3e2axqxzejy@pali>
References: <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com>
 <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali>
 <877dr3lpok.fsf@toke.dk>
 <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali>
 <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali>
 <874kgyc4yg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kgyc4yg.fsf@toke.dk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 26 March 2021 16:25:27 Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > On Friday 19 March 2021 00:16:29 Pali Rohár wrote:
> >> On Thursday 18 March 2021 23:43:58 Toke Høiland-Jørgensen wrote:
> >> > Pali Rohár <pali@kernel.org> writes:
> >> > 
> >> > > On Monday 15 March 2021 20:58:06 Pali Rohár wrote:
> >> > >> On Monday 02 November 2020 16:54:35 Toke Høiland-Jørgensen wrote:
> >> > >> > Pali Rohár <pali@kernel.org> writes:
> >> > >> > 
> >> > >> > > On Saturday 31 October 2020 13:49:49 Toke Høiland-Jørgensen wrote:
> >> > >> > >> "™֟☻̭҇ Ѽ ҉ ®" <vtolkm@googlemail.com> writes:
> >> > >> > >> 
> >> > >> > >> > On 30/10/2020 15:23, Pali Rohár wrote:
> >> > >> > >> >> On Friday 30 October 2020 14:02:22 Toke Høiland-Jørgensen wrote:
> >> > >> > >> >>> Pali Rohár <pali@kernel.org> writes:
> >> > >> > >> >>>> My experience with that WLE900VX card, aardvark driver and aspm code:
> >> > >> > >> >>>>
> >> > >> > >> >>>> Link training in GEN2 mode for this card succeed only once after reset.
> >> > >> > >> >>>> Repeated link retraining fails and it fails even when aardvark is
> >> > >> > >> >>>> reconfigured to GEN1 mode. Reset via PERST# signal is required to have
> >> > >> > >> >>>> working link training.
> >> > >> > >> >>>>
> >> > >> > >> >>>> What I did in aardvark driver: Set mode to GEN2, do link training. If
> >> > >> > >> >>>> success read "negotiated link speed" from "Link Control Status Register"
> >> > >> > >> >>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
> >> > >> > >> >>>> retrain link again (for WLE900VX now it would be at GEN1). After that
> >> > >> > >> >>>> card is stable and all future retraining (e.g. from aspm.c) also passes.
> >> > >> > >> >>>>
> >> > >> > >> >>>> If I do not change aardvark mode from GEN2 to GEN1 the second link
> >> > >> > >> >>>> training fails. And if I change mode to GEN1 after this failed link
> >> > >> > >> >>>> training then nothing happen, link training do not success.
> >> > >> > >> >>>>
> >> > >> > >> >>>> So just speculation now... In current setup initialization of card does
> >> > >> > >> >>>> one link training at GEN2. Then aspm.c is called which is doing second
> >> > >> > >> >>>> link retraining at GEN2. And if it fails then below patch issue third
> >> > >> > >> >>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as aardvark
> >> > >> > >> >>>> then second link retraining must be at GEN1 (not GEN2) to workaround
> >> > >> > >> >>>> this issue.
> >> > >> > >> >>>>
> >> > >> > >> >>>> Bjorn, Toke: what about trying to hack aspm.c code to never do link
> >> > >> > >> >>>> retraining at GEN2 speed? And always force GEN1 speed prior link
> >> > >> > >> >>>> training?
> >> > >> > >> >>> Sounds like a plan. I poked around in aspm.c and must confess to being a
> >> > >> > >> >>> bit lost in the soup of registers ;)
> >> > >> > >> >>>
> >> > >> > >> >>> So if one of you can cook up a patch, that would be most helpful!
> >> > >> > >> >> I modified Bjorn's patch, explicitly set tls to 1 and added debug info
> >> > >> > >> >> about cls (current link speed, that what is used by aardvark). It is
> >> > >> > >> >> untested, I just tried to compile it.
> >> > >> > >> >>
> >> > >> > >> >> Can try it?
> >> > >> > >> >>
> >> > >> > >> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >> > >> > >> >> index 253c30cc1967..f934c0b52f41 100644
> >> > >> > >> >> --- a/drivers/pci/pcie/aspm.c
> >> > >> > >> >> +++ b/drivers/pci/pcie/aspm.c
> >> > >> > >> >> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> >> > >> > >> >>   	unsigned long end_jiffies;
> >> > >> > >> >>   	u16 reg16;
> >> > >> > >> >>   
> >> > >> > >> >> +	u32 lnkcap2;
> >> > >> > >> >> +	u16 lnksta, lnkctl2, cls, tls;
> >> > >> > >> >> +
> >> > >> > >> >> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
> >> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
> >> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
> >> > >> > >> >> +	cls = lnksta & PCI_EXP_LNKSTA_CLS;
> >> > >> > >> >> +	tls = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> >> > >> > >> >> +
> >> > >> > >> >> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x lnkctl2 %#06x tls %#03x\n",
> >> > >> > >> >> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
> >> > >> > >> >> +		lnksta, cls,
> >> > >> > >> >> +		lnkctl2, tls);
> >> > >> > >> >> +
> >> > >> > >> >> +	tls = 1;
> >> > >> > >> >> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
> >> > >> > >> >> +					PCI_EXP_LNKCTL2_TLS, tls);
> >> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
> >> > >> > >> >> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
> >> > >> > >> >> +		lnkctl2, tls);
> >> > >> > >> >> +
> >> > >> > >> >>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> >> > >> > >> >>   	reg16 |= PCI_EXP_LNKCTL_RL;
> >> > >> > >> >>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> >> > >> > >> >> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
> >> > >> > >> >>   			break;
> >> > >> > >> >>   		msleep(1);
> >> > >> > >> >>   	} while (time_before(jiffies, end_jiffies));
> >> > >> > >> >> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
> >> > >> > >> >> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
> >> > >> > >> >>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
> >> > >> > >> >>   }
> >> > >> > >> >>   
> >> > >> > >> >
> >> > >> > >> > Still exhibiting the BAR update error, run tested with next--20201030
> >> > >> > >> 
> >> > >> > >> Yup, same for me :(
> >> > >> 
> >> > >> I'm answering my own question. This code does not work on Omnia because
> >> > >> A38x pci-mvebu.c driver is using emulator for PCIe root bridge and it
> >> > >> does not implement PCI_EXP_LNKCTL2 and PCI_EXP_LNKCTL2 registers. So
> >> > >> code for forcing link speed has no effect on Omnia...
> >> > >
> >> > > Toke, on A38x PCIe controller it is possible to access PCI_EXP_LNKCTL2
> >> > > register. Just access is not exported via emulated root bridge.
> >> > >
> >> > > Documentation for this PCIe controller is public, so anybody can look at
> >> > > register description. See page 571, A.7 PCI Express 2.0 Port 0 Registers
> >> > >
> >> > > http://web.archive.org/web/20200420191927/https://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-38x-functional-specifications-2015-11.pdf
> >> > >
> >> > > In drivers/pci/controller/pci-mvebu.c you can set a new value for this
> >> > > register via function call:
> >> > >
> >> > >     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
> >> > >
> >> > > So, could you try to set PCI_EXP_LNKCTL2_TLS bits to gen1 in some hw
> >> > > init function, e.g. mvebu_pcie_setup_hw()?
> >> > >
> >> > >     u32 val = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
> >> > >     val &= ~PCI_EXP_LNKCTL2_TLS;
> >> > >     val |= PCI_EXP_LNKCTL2_TLS_2_5GT;
> >> > >     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
> >> > 
> >> > I pasted this into the top of mvebu_pcie_setup_hw(), and that indeed
> >> > seems to fix things so that all three PCIE devices work even with ASPM
> >> > turned on! :)
> >> 
> >> Perfect! Now I'm sure that it is same issue as in aardvark driver.
> >> 
> >> I will prepare patches for both pci-aardvark.c and pci-mvebu.c to export
> >> PCI_EXP_LNKCTL2 register via emulated bridge. And so aspm.c code would
> >> be able to use Bjorn or my patch which I have sent last year.
> >> 
> >> Question reminds, if this is issue with QCA wifi chip on that Compex
> >> card or it is issue with PCIe controllers, now on A38x and A3720 SoC.
> >> Note that both A38x and A3720 platforms are from Marvell, but they have
> >> different PCIe controllers (so it does not mean that both must have same
> >> hw bugs).
> >
> > Seems that this is really issue in QCA98xx chips. I have send patch
> > which adds quirk for these wifi chips:
> >
> > https://lore.kernel.org/linux-pci/20210326124326.21163-1-pali@kernel.org/
> 
> I tried applying that, and while it does fix the ath10k card, it seems
> to break the ath9k card in the slot next to it.

Ehm, what? Patch which I have sent today to mailing list calls quirk
code only for PCI device id used by QCA98xx cards. For all other cards
it is noop.

Can you send PCI device id of your ath9k card (lspci -nn)? Because all
my tested ath9k cards have different PCI device id.

> When booting with the
> patch applied, I get this in dmesg:
> 
> [    3.556599] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver

Can you send whole dmesg log? So I can see which new err/info lines are
printed.

> Could there be some kind of data corruption in play here making the
> driver think the chip revision is wrong, or something like that? If I
> boot the same kernel without the patch applied, the ath9k initialisation
> works fine, but obviously the ath10k is then still broken...

There is something really strange.

Can you add debug log into pcie_change_tls_to_gen1() function to check
for which card is this function called?

Are you testing this new patch with or without changes to
mvebu_pcie_setup_hw() function?
