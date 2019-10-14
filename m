Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9FD644E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbfJNNpj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 09:45:39 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:39878 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbfJNNpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 09:45:38 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iK0fG-0001Nm-P1; Mon, 14 Oct 2019 15:45:34 +0200
To:     Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3] PCI: aardvark: Use LTSSM state to build link  training flag
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Oct 2019 14:45:34 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Ellie Reeves <ellierevves@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20191014130627.GA1426@voidbox>
References: <20190522213351.21366-3-repk@triplefau.lt>
 <20190930154017.GF42880@e119886-lin.cambridge.arm.com>
 <20190930165230.GA12568@voidbox>
 <20191001080546.GI42880@e119886-lin.cambridge.arm.com>
 <20191013113415.3c653526@why>
 <20191014100129.GA18832@e121166-lin.cambridge.arm.com>
 <20191014130627.GA1426@voidbox>
Message-ID: <eda65141ee1006fe3a93a9989867dc31@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: repk@triplefau.lt, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, ellierevves@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Remi,

On 2019-10-14 14:06, Remi Pommarel wrote:
> Hi Lorenzo, Marc,
>
> On Mon, Oct 14, 2019 at 11:01:29AM +0100, Lorenzo Pieralisi wrote:
>> On Sun, Oct 13, 2019 at 11:34:15AM +0100, Marc Zyngier wrote:
>> > On Tue, 1 Oct 2019 09:05:46 +0100
>> > Andrew Murray <andrew.murray@arm.com> wrote:
>> >
>> > Hi Lorenzo,
>> >
>> > > On Mon, Sep 30, 2019 at 06:52:30PM +0200, Remi Pommarel wrote:
>> > > > On Mon, Sep 30, 2019 at 04:40:18PM +0100, Andrew Murray wrote:
>> > > > > On Wed, May 22, 2019 at 11:33:51PM +0200, Remi Pommarel 
>> wrote:
>> > > > > > Aardvark's PCI_EXP_LNKSTA_LT flag in its link status 
>> register is not
>> > > > > > implemented and does not reflect the actual link training 
>> state (the
>> > > > > > flag is always set to 0). In order to support link 
>> re-training feature
>> > > > > > this flag has to be emulated. The Link Training and Status 
>> State
>> > > > > > Machine (LTSSM) flag in Aardvark LMI config register could 
>> be used as
>> > > > > > a link training indicator. Indeed if the LTSSM is in L0 or 
>> upper state
>> > > > > > then link training has completed (see [1]).
>> > > > > >
>> > > > > > Unfortunately because after asking a link retraining it 
>> takes a while
>> > > > > > for the LTSSM state to become less than 0x10 (due to L0s 
>> to recovery
>> > > > > > state transition delays), LTSSM can still be in L0 while 
>> link training
>> > > > > > has not finished yet. So this waits for link to be in 
>> recovery or lesser
>> > > > > > state before returning after asking for a link retrain.
>> > > > > >
>> > > > > > [1] "PCI Express Base Specification", REV. 4.0
>> > > > > >     PCI Express, February 19 2014, Table 4-14
>> > > > > >
>> > > > > > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>> > > > > > ---
>> > > > > > Changes since v1:
>> > > > > >   - Rename retraining flag field
>> > > > > >   - Fix DEVCTL register writing
>> > > > > >
>> > > > > > Changes since v2:
>> > > > > >   - Rewrite patch logic so it is more legible
>> > > > > >
>> > > > > > Please note that I will unlikely be able to answer any 
>> comments from May
>> > > > > > 24th to June 10th.
>> > > > > > ---
>> > > > > >  drivers/pci/controller/pci-aardvark.c | 29 
>> ++++++++++++++++++++++++++-
>> > > > > >  1 file changed, 28 insertions(+), 1 deletion(-)
>> > > > > >
>> > > > > > diff --git a/drivers/pci/controller/pci-aardvark.c 
>> b/drivers/pci/controller/pci-aardvark.c
>> > > > > > index 134e0306ff00..8803083b2174 100644
>> > > > > > --- a/drivers/pci/controller/pci-aardvark.c
>> > > > > > +++ b/drivers/pci/controller/pci-aardvark.c
>> > > > > > @@ -180,6 +180,8 @@
>> > > > > >  #define LINK_WAIT_MAX_RETRIES		10
>> > > > > >  #define LINK_WAIT_USLEEP_MIN		90000
>> > > > > >  #define LINK_WAIT_USLEEP_MAX		100000
>> > > > > > +#define RETRAIN_WAIT_MAX_RETRIES	10
>> > > > > > +#define RETRAIN_WAIT_USLEEP_US		2000
>> > > > > >
>> > > > > >  #define MSI_IRQ_NUM			32
>> > > > > >
>> > > > > > @@ -239,6 +241,17 @@ static int 
>> advk_pcie_wait_for_link(struct advk_pcie *pcie)
>> > > > > >  	return -ETIMEDOUT;
>> > > > > >  }
>> > > > > >
>> > > > > > +static void advk_pcie_wait_for_retrain(struct advk_pcie 
>> *pcie)
>> > > > > > +{
>> > > > > > +	size_t retries;
>> > > > > > +
>> > > > > > +	for (retries = 0; retries < RETRAIN_WAIT_MAX_RETRIES; 
>> ++retries) {
>> > > > > > +		if (!advk_pcie_link_up(pcie))
>> > > > > > +			break;
>> > > > > > +		udelay(RETRAIN_WAIT_USLEEP_US);
>> > > > > > +	}
>> > > > > > +}
>> > > > > > +
>> > > > > >  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>> > > > > >  {
>> > > > > >  	u32 reg;
>> > > > > > @@ -426,11 +439,20 @@ 
>> advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
>> > > > > >  		return PCI_BRIDGE_EMUL_HANDLED;
>> > > > > >  	}
>> > > > > >
>> > > > > > +	case PCI_EXP_LNKCTL: {
>> > > > > > +		/* u32 contains both PCI_EXP_LNKCTL and PCI_EXP_LNKSTA 
>> */
>> > > > > > +		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) 
>> &
>> > > > > > +			~(PCI_EXP_LNKSTA_LT << 16);
>> > > > >
>> > > > > The commit message says "the flag is always set to 0" - 
>> therefore I guess
>> > > > > you don't *need* to mask out the LT bit here? I assume this 
>> is just
>> > > > > belt-and-braces but thought I'd check incase I've 
>> misunderstood or if your
>> > > > > commit message is inaccurate.
>> > > > >
>> > > > > In any case masking out the bit (or adding a comment) makes 
>> this code more
>> > > > > readable as the reader doesn't need to know what the 
>> hardware does with this
>> > > > > bit.
>> > > >
>> > > > Actually vendor eventually responded that the bit was 
>> reserved, but
>> > > > during my tests it remains to 0.
>> > > >
>> > > > So yes I am masking this out mainly for belt-and-braces and 
>> legibility.
>> > >
>> > > Thanks for the clarification.
>> > >
>> > > >
>> > > > > > +		if (!advk_pcie_link_up(pcie))
>> > > > > > +			val |= (PCI_EXP_LNKSTA_LT << 16);
>> > > > > > +		*value = val;
>> > > > > > +		return PCI_BRIDGE_EMUL_HANDLED;
>> > > > > > +	}
>> > > > > > +
>> > > > > >  	case PCI_CAP_LIST_ID:
>> > > > > >  	case PCI_EXP_DEVCAP:
>> > > > > >  	case PCI_EXP_DEVCTL:
>> > > > > >  	case PCI_EXP_LNKCAP:
>> > > > > > -	case PCI_EXP_LNKCTL:
>> > > > > >  		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
>> > > > > >  		return PCI_BRIDGE_EMUL_HANDLED;
>> > > > > >  	default:
>> > > > > > @@ -447,8 +469,13 @@ 
>> advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>> > > > > >
>> > > > > >  	switch (reg) {
>> > > > > >  	case PCI_EXP_DEVCTL:
>> > > > > > +		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
>> > > > > > +		break;
>> > > > >
>> > > > > Why is this here?
>> > > > >
>> > > >
>> > > > Before PCI_EXP_DEVCTL and PCI_EXP_LNKCTL were doing the same 
>> thing, but
>> > > > as now PCI_EXP_LNKCTL does extra things (i.e. wait for link to
>> > > > successfully retrain), they do have different behaviours.
>> > > >
>> > > > So this is here so PCI_EXP_DEVCTL keeps its old behaviour and 
>> do not
>> > > > wait for link retrain in case an unrelated (PCI_EXP_LNKCTL_RL) 
>> bit is
>> > > > set.
>> > >
>> > > Oh yes, of course!
>> > >
>> > > Thanks and:
>> > >
>> > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>> >
>> > Is there any hope for this workaround to make it into 5.4?
>> >
>> > My EspressoBin (which is blessed with this joke of a PCIe 
>> controller)
>> > is pretty much a doorstop without it and dies with a SError early 
>> at
>> > boot.
>> >
>> > FWIW:
>> >
>> > Tested-by: Marc Zyngier <maz@kernel.org>
>>
>> Hi Marc,
>>
>> First thing I will have to mark it as a Fixes: (if Remi can provide
>> me with a tag that'd be great), usually we send fixes at -rc* for
>> patches that fix code that went in the current (eg 5.4) material,
>> I will ask Bjorn to see if we can send this in one of the upcoming
>> -rc* even if it fixes older code.
>
> Sure, I think this could be considered a fix for the following commit 
> :
> Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI
> bridge config space")
>
> Moreover, Marc, I am also a bit supprised that you did not have to 
> use
> [1] to even be able to boot.

No, I don't have that one, and yet the system boots fine (although PCI
doesn't get much use on this box). I guess I'm lucky...

> Also if you want to be completely immune to this kind of SError (that
> could theoretically happen if the link goes down for other reasons 
> than
> being retrained) you would have to use mainline ATF along with [2]. 
> But
> the chances to hit that are low (could only happen in case of link
> errors).

Now you've got me worried. Can you point me to that ATF patch? I'm 
quite
curious as to how you recover from an SError on a v8.0 CPU given that 
it
has no syndrome information and may as well signal "CPU on fire!"...

Thanks,

         M.

>
> [1] [v3] PCI: aardvark: Use LTSSM state to build link training flag
>     https://patchwork.ozlabs.org/patch/1115864/
> [2] [v3] PCI: aardvark: Don't rely on jiffies while holding spinlock
>     https://patchwork.ozlabs.org/patch/1168349/

-- 
Jazz is not dead. It just smells funny...
