Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7092126CD7C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIPU7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgIPQag (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02D6206E6;
        Wed, 16 Sep 2020 12:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600259387;
        bh=mAhcdMnqXGa3OUhEa0SjPZLOVorOJ1GvtFTOatg1nS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tr2bRmrDKeAhAzYJ35RkeXqyHCY3nIrUgdVYS5IZ8HjGu1yHhXyzr6ufRvmUAxmsv
         W8tzbp/COwbKNso/t3qhxSp9HV8Gk78jdikfXbwW7j6nhM05QniwpjmDr8pjzU63QM
         jSAKd4WLJ+PfL5gUQ4r9f2HRzbIFraBaDr/ayvWg=
Date:   Wed, 16 Sep 2020 14:30:20 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "rui_feng@realsil.com.cn" <rui_feng@realsil.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "puranjay12@gmail.com" <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vailbhavgupta40@gmail.com" <vailbhavgupta40@gmail.com>
Subject: Re: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix
 driving parameter
Message-ID: <20200916123020.GA2796266@kroah.com>
References: <4a677365e7a64699b16ae0b25eca1041@realtek.com>
 <20200915152811.GA1383952@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200915152811.GA1383952@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 10:28:11AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 15, 2020 at 08:24:50AM +0000, 吳昊澄 Ricky wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > Sent: Friday, September 11, 2020 10:56 PM
> > > To: 吳昊澄 Ricky
> > > Cc: arnd@arndb.de; gregkh@linuxfoundation.org; bhelgaas@google.com;
> > > ulf.hansson@linaro.org; rui_feng@realsil.com.cn; linux-kernel@vger.kernel.org;
> > > puranjay12@gmail.com; linux-pci@vger.kernel.org;
> > > vailbhavgupta40@gamail.com
> > > Subject: Re: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix driving
> > > parameter
> > > 
> > > On Fri, Sep 11, 2020 at 08:18:22AM +0000, 吳昊澄 Ricky wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > > > Sent: Thursday, September 10, 2020 1:44 AM
> > > > > To: 吳昊澄 Ricky
> > > > > Cc: arnd@arndb.de; gregkh@linuxfoundation.org; bhelgaas@google.com;
> > > > > ulf.hansson@linaro.org; rui_feng@realsil.com.cn;
> > > linux-kernel@vger.kernel.org;
> > > > > puranjay12@gmail.com; linux-pci@vger.kernel.org;
> > > > > vailbhavgupta40@gamail.com
> > > > > Subject: Re: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix
> > > driving
> > > > > parameter
> > > > >
> > > > > On Wed, Sep 09, 2020 at 07:10:19AM +0000, 吳昊澄 Ricky wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > > > > > Sent: Wednesday, September 09, 2020 6:29 AM
> > > > > > > To: 吳昊澄 Ricky
> > > > > > > Cc: arnd@arndb.de; gregkh@linuxfoundation.org;
> > > bhelgaas@google.com;
> > > > > > > ulf.hansson@linaro.org; rui_feng@realsil.com.cn;
> > > > > linux-kernel@vger.kernel.org;
> > > > > > > puranjay12@gmail.com; linux-pci@vger.kernel.org;
> > > > > > > vailbhavgupta40@gamail.com
> > > > > > > Subject: Re: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix
> > > > > driving
> > > > > > > parameter
> > > > > > >
> > > > > > > On Mon, Sep 07, 2020 at 06:07:31PM +0800, ricky_wu@realtek.com
> > > wrote:
> > > > > > > > From: Ricky Wu <ricky_wu@realtek.com>
> > > > > > > >
> > > > > > > > v4:
> > > > > > > > split power down flow and power saving function to two patch
> > > > > > > >
> > > > > > > > v5:
> > > > > > > > fix up modified change under the --- line
> > > > > > >
> > > > > > > Hehe, this came out *above* the "---" line :)
> > > > > > >
> > > > > > > > Add rts522a L1 sub-state support
> > > > > > > > Save more power on rts5227 rts5249 rts525a rts5260
> > > > > > > > Fix rts5260 driving parameter
> > > > > > > >
> > > > > > > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > > > > > > ---
> > > > > > > >  drivers/misc/cardreader/rts5227.c  | 112 +++++++++++++++++++++-
> > > > > > > >  drivers/misc/cardreader/rts5249.c  | 145
> > > > > > > ++++++++++++++++++++++++++++-
> > > > > > > >  drivers/misc/cardreader/rts5260.c  |  28 +++---
> > > > > > > >  drivers/misc/cardreader/rtsx_pcr.h |  17 ++++
> > > > > > > >  4 files changed, 283 insertions(+), 19 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/misc/cardreader/rts5227.c
> > > > > > > b/drivers/misc/cardreader/rts5227.c
> > > > > > > > index 747391e3fb5d..8859011672cb 100644
> > > > > > > > --- a/drivers/misc/cardreader/rts5227.c
> > > > > > > > +++ b/drivers/misc/cardreader/rts5227.c
> > > > > > > > @@ -72,15 +72,80 @@ static void
> > > rts5227_fetch_vendor_settings(struct
> > > > > > > rtsx_pcr *pcr)
> > > > > > > >
> > > > > > > >  	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
> > > > > > > >  	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> > > > > > > > +	if (rtsx_check_mmc_support(reg))
> > > > > > > > +		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
> > > > > > > >  	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
> > > > > > > >  	if (rtsx_reg_check_reverse_socket(reg))
> > > > > > > >  		pcr->flags |= PCR_REVERSE_SOCKET;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void rts5227_init_from_cfg(struct rtsx_pcr *pcr)
> > > > > > > > +{
> > > > > > > > +	struct pci_dev *pdev = pcr->pci;
> > > > > > > > +	int l1ss;
> > > > > > > > +	u32 lval;
> > > > > > > > +	struct rtsx_cr_option *option = &pcr->option;
> > > > > > > > +
> > > > > > > > +	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
> > > > > > > > +	if (!l1ss)
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
> > > > > > >
> > > > > > > This looks a little problematic.  PCI_L1SS_CTL1 is an architected
> > > > > > > register in the ASPM L1 PM Substates capability, and its value may
> > > > > > > change at runtime because drivers/pci/pcie/aspm.c manages it.
> > > > > > >
> > > > > > > It looks like the code below does device-specific configuration based
> > > > > > > on the current PCI_L1SS_CTL1 value.  But what happens if aspm.c
> > > > > > > changes PCI_L1SS_CTL1 later?
> > > > > >
> > > > > > We are going to make sure and set the best configuration on the
> > > > > > current time, if host change the capability later, it doesn't affect
> > > > > > function, only affect a little power saving
> > > > >
> > > > > Why don't you unconditionally do the following?
> > > > >
> > > > >   rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
> > > > >   rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
> > > > >   rtsx_set_dev_flag(pcr, PM_L1_1_EN);
> > > > >   rtsx_set_dev_flag(pcr, PM_L1_2_EN);
> > > >
> > > > Our power saving function have 2 different flow L1 and L1substate,
> > > > so we need to check it for which flow we are going to
> > > > Detail to see below reply
> > > >
> > > > > Let's assume the generic code in aspm.c has cleared all these bits:
> > > > >
> > > > >   PCI_L1SS_CTL1_ASPM_L1_1
> > > > >   PCI_L1SS_CTL1_ASPM_L1_2
> > > > >   PCI_L1SS_CTL1_PCIPM_L1_1
> > > > >   PCI_L1SS_CTL1_PCIPM_L1_2
> > > > >
> > > > > in the L1 PM Substates capability.
> > > > >
> > > > > I think you are saying that if you *also* clear ASPM_L1_1_EN,
> > > > > ASPM_L1_2_EN, PM_L1_1_EN, and PM_L1_2_EN in your device-specific
> > > > > registers, it uses less power than if you set those device-specific
> > > > > bits.  Right?
> > > > >
> > > > > And moreover, I think you're saying that if aspm.c subsequently *sets*
> > > > > some of those bits in the L1 PM Substates capability, those substates
> > > > > *work* even though the device-specific ASPM_L1_1_EN, ASPM_L1_2_EN,
> > > > > PM_L1_1_EN, and PM_L1_2_EN bits are not set.  Right?
> > > > >
> > > > > I do not feel good about this as a general strategy.  I think we
> > > > > should program the device so the behavior is completely predictable,
> > > > > regardless of the generic enable bits happened to be set at
> > > > > probe-time.
> > > > >
> > > > > The current approach means that if we enable L1 substates after the
> > > > > driver probe, the device is configured differently than if we enabled
> > > > > L1 substates before probe.  That's not a reliable way to operate it.
> > > >
> > > > Talk about our power saving function
> > > > a) basic L1 power saving
> > > > b) advance L1 power saving
> > > > c) advance L1 substate power saving
> > > 
> > > I have no idea what the difference between "basic L1 power saving" and
> > > "advance L1 power saving" is, so I assume those are device-specific
> > > things.  If not, please use the same terminology as the PCIe spec.
> > > 
> > > > at initial, we check pci port support L1 subs or not, if not we are
> > > > going to b) otherwise going to c).
> > > 
> > > You're not checking whether the port *supports* L1 substates.  You
> > > would look at PCI_L1SS_CAP to learn that.  You're looking at
> > > PCI_L1SS_CTL1, which tells you whether L1 substates are *enabled*.
> > > 
> > > > Assume aspm.c change bit of L1 PM Substates capability after our
> > > > driver probe, we are going to a)
> > > >
> > > > So far we did not see any platform change L1 PM Substates capability
> > > > after our driver probe.
> > > 
> > > You should expect that aspm.c will change bits in the L1 PM *control*
> > > register (PCI_L1SS_CTL1) after probe.
> > > 
> > > You might not actually see it change, depending on how you tested, but
> > > you cannot rely on PCI_L1SS_CTL1 being constant.  It may change based
> > > on power/performance tradeoffs, e.g., whether the system is plugged
> > > into AC power, whether it's idle, etc.
> > > 
> > 
> > Our ASPM function is a HW solution follow the PCIe SPEC. don’t worry
> > about crash the system If HOST change our device config space
> > setting at run time our HW will do the corresponding things which
> > follows the SPEC.  At initial time we set these parameter just good
> > for more power saving
> 
> OK.  It would be better if your hardware would notice the
> PCI_L1SS_CTL1 change and set its own device-specific power-saving
> parameters.  The drivers would be simpler, and the device behavior
> would be more consistent.
> 
> Drivers *writing* to standard PCI config things (64-byte config header
> or Capabilities like PCIe, PM, ASPM, L1 Substates) is a definite
> problem because the PCI core owns those and writes from drivers need
> to be mediated somehow.  AFAICT your drivers don't write to these
> things.
> 
> Drivers *reading* these things (as your drivers do) shouldn't cause
> problems, but it does violate the interface abstractions that the PCI
> core should provide.

So is it ok to take this patch now, or does it need to be changed any?

thanks,

greg k-h
