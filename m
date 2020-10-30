Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215CF2A040F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3LXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 07:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgJ3LXf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 07:23:35 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D179620756;
        Fri, 30 Oct 2020 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604057014;
        bh=TPItI+XystJrNhT4Y1Xi7gpWVKsIbu7ThHLHReTIDtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAvAhxq6mQb551XZ4m0ZXBa1mStimf3abK9EAOZiOSfpVnaeHcNcgXsGdLA0mtGke
         JzO4zgjmt2gzTh0VC5wQ9JWZwhhDtvCPx8Zp+9mjOGbF6e7zsIsILmbCsYsK2zipcQ
         pFoxxZWWVl1yUpn68XgMcz9wrKGvM92vNw7yVXKM=
Received: by pali.im (Postfix)
        id 5EA4886D; Fri, 30 Oct 2020 12:23:31 +0100 (CET)
Date:   Fri, 30 Oct 2020 12:23:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     vtolkm@gmail.com,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201030112331.meqg6lvultyn6v54@pali>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201028231626.GA344207@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 28 October 2020 18:16:26 Bjorn Helgaas wrote:
> [+cc Pali, Marek, Thomas, Jason]
> 
> On Wed, Oct 28, 2020 at 04:40:00PM +0000, ™֟☻̭҇ Ѽ ҉ ® wrote:
> > On 28/10/2020 16:08, Toke Høiland-Jørgensen wrote:
> > > Bjorn Helgaas <helgaas@kernel.org> writes:
> > > > On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke Høiland-Jørgensen wrote:
> > > > > Toke Høiland-Jørgensen <toke@redhat.com> writes:
> > > > > > Bjorn Helgaas <helgaas@kernel.org> writes:
> > > > > > 
> > > > > > > [+cc vtolkm]
> > > > > > > 
> > > > > > > On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke Høiland-Jørgensen wrote:
> > > > > > > > Hi everyone
> > > > > > > > 
> > > > > > > > I'm trying to get a mainline kernel to run on my Turris Omnia, and am
> > > > > > > > having some trouble getting the PCI bus to work correctly. Specifically,
> > > > > > > > I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), with
> > > > > > > > the resource request fix[0] applied on top.
> > > > > > > > 
> > > > > > > > The kernel boots fine, and the patch in [0] makes the PCI devices show
> > > > > > > > up. But I'm still getting initialisation errors like these:
> > > > > > > > 
> > > > > > > > [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 != 0xffffffff)
> > > > > > > > [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> > > > > > > > [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 != 0xffffffff)
> > > > > > > > [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> > > > > > > > 
> > > > > > > > and the WiFi drivers fail to initialise with what appears to me to be
> > > > > > > > errors related to the bus rather than to the drivers themselves:
> > > > > > > > 
> > > > > > > > [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver
> > > > > > > > [    3.517049] ath: phy0: Unable to initialize hardware; initialization status: -95
> > > > > > > > [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
> > > > > > > > [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
> > > > > > > > [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=134
> > > > > > > > [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
> > > > > > > > [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> > > > > > > > [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> > > > > > > > [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> > > > > > > > 
> > > > > > > > lspci looks OK, though:
> > > > > > > > 
> > > > > > > > # lspci
> > > > > > > > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> > > > > > > > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> > > > > > > > 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> > > > > > > > 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)
> > > > > > > > 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter (rev ff)
> > > > > > > > 
> > > > > > > > Does anyone have any clue what could be going on here? Is this a bug, or
> > > > > > > > did I miss something in my config or other initialisation? I've tried
> > > > > > > > with both the stock u-boot distributed with the board, and with an
> > > > > > > > upstream u-boot from latest master; doesn't seem to make any different.
> > > > > > > Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
> > > > > > > report at https://bugzilla.kernel.org/show_bug.cgi?id=209833 but I
> > > > > > > don't think we have a fix yet.
> > > > > > Yes! Turning that off does indeed help! Thanks a bunch :)
> > > > > > 
> > > > > > You mention that bisecting this would be helpful - I can try that
> > > > > > tomorrow; any idea when this was last working?
> > > > > OK, so I tried to bisect this, but, erm, I couldn't find a working
> > > > > revision to start from? I went all the way back to 4.10 (which is the
> > > > > first version to include the device tree file for the Omnia), and even
> > > > > on that, the wireless cards were failing to initialise with ASPM
> > > > > enabled...
> > > > I have no personal experience with this device; all I know is that the
> > > > bugzilla suggests that it worked in v5.4, which isn't much help.
> > > > 
> > > > Possibly the apparent regression was really a .config change, i.e.,
> > > > CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and it
> > > > "worked" but got enabled later and it started failing?
> > > Yeah, I suspect so. The OpenWrt config disables CONFIG_PCIEASPM by
> > > default and only turns it on for specific targets. So I guess that it's
> > > most likely that this has never worked...
> > > 
> > > > Maybe the debug patch below would be worth trying to see if it makes
> > > > any difference?  If it *does* help, try omitting the first hunk to see
> > > > if we just need to apply the quirk_enable_clear_retrain_link() quirk.
> > > Tried, doesn't help...
> > > 
> > > -Toke
> > 
> > Found this patch
> > 
> > https://github.com/openwrt/openwrt/blob/7c0496f29bed87326f1bf591ca25ace82373cfc7/target/linux/mvebu/patches-5.4/405-PCI-aardvark-Improve-link-training.patch
> > 
> > that mentions the Compex WLE900VX card, which reading the lspci verbose
> > output from the bugtracker seems to the device being troubled.
> 
> Interesting.  Indeed, the Compex WLE900VX card seems to have the
> Qualcomm Atheros QCA9880 on it, and it looks like Toke's system has
> the same device in it.
> 
> The patch you mention (https://git.kernel.org/linus/43fc679ced18) is
> for aardvark, so of course doesn't help mvebu.
> 
> PCIe hardware is supposed to automatically negotiate the highest link
> speed supported by both ends.  But software *is* allowed to set an
> upper limit (the Target Link Speed in Link Control 2).  If we initiate
> a retrain and the link doesn't come back up, I wonder if we should try
> to help the hardware out by using Target Link Speed to limit to a
> lower speed and attempting another retrain, something like this hacky
> patch: (please collect the dmesg log if you try this)

My experience with that WLE900VX card, aardvark driver and aspm code:

Link training in GEN2 mode for this card succeed only once after reset.
Repeated link retraining fails and it fails even when aardvark is
reconfigured to GEN1 mode. Reset via PERST# signal is required to have
working link training.

What I did in aardvark driver: Set mode to GEN2, do link training. If
success read "negotiated link speed" from "Link Control Status Register"
(for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
retrain link again (for WLE900VX now it would be at GEN1). After that
card is stable and all future retraining (e.g. from aspm.c) also passes.

If I do not change aardvark mode from GEN2 to GEN1 the second link
training fails. And if I change mode to GEN1 after this failed link
training then nothing happen, link training do not success.

So just speculation now... In current setup initialization of card does
one link training at GEN2. Then aspm.c is called which is doing second
link retraining at GEN2. And if it fails then below patch issue third
link retraining at GEN1. If A38x/pci-mvebu has same problem as aardvark
then second link retraining must be at GEN1 (not GEN2) to workaround
this issue.

Bjorn, Toke: what about trying to hack aspm.c code to never do link
retraining at GEN2 speed? And always force GEN1 speed prior link
training?

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index ac0557a305af..fb6e13532a2c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -192,12 +192,42 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
>  
> +#define PCI_EXP_LNKCAP2_SLS	0x000000fe
> +
> +static int decrease_tls(struct pci_dev *pdev)
> +{
> +	u32 lnkcap2;
> +	u16 lnkctl2, tls;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP2, &lnkcap2);
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL2, &lnkctl2);
> +	tls = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> +
> +	pci_info(pdev, "lnkcap2 %#010x sls %#04x lnkctl2 %#06x tls %#03x\n",
> +		 lnkcap2, (lnkcap2 & PCI_EXP_LNKCAP2_SLS) >> 1,
> +		 lnkctl2, tls);
> +
> +	if (tls < 2)
> +		return -EINVAL;
> +
> +	tls--;
> +	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL2,
> +					   PCI_EXP_LNKCTL2_TLS, tls);
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL2, &lnkctl2);
> +	pci_info(pdev, "lnkctl2 %#010x new tls %#03x\n",
> +		 lnkctl2, tls);
> +
> +	return 0;
> +}
> +
>  static bool pcie_retrain_link(struct pcie_link_state *link)
>  {
>  	struct pci_dev *parent = link->pdev;
>  	unsigned long end_jiffies;
>  	u16 reg16;
>  
> +top:
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>  	reg16 |= PCI_EXP_LNKCTL_RL;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> @@ -216,10 +246,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
>  	do {
>  		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
>  		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> -			break;
> +			return true;	/* success */
>  		msleep(1);
>  	} while (time_before(jiffies, end_jiffies));
> -	return !(reg16 & PCI_EXP_LNKSTA_LT);
> +
> +	if (decrease_tls(parent))
> +		return false;	/* can't decrease any more */
> +
> +	goto top;
>  }
>  
>  /*
