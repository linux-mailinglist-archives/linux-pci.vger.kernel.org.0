Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE4713007
	for <lists+linux-pci@lfdr.de>; Sat, 27 May 2023 00:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEZW07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 18:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEZW06 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 18:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8983;
        Fri, 26 May 2023 15:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A2365444;
        Fri, 26 May 2023 22:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9438C433EF;
        Fri, 26 May 2023 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685140016;
        bh=2N7vPBDGrZWXp0y+g3rhBd1SoUivmDef2YGjEGplLos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lx0veg/509C+VRVnYMjWKuUagvW1r22YeGjU+vkadwZuTaMGef33Ic3ipscIkU3zt
         nvO/p+oSZtcHaMm91wpLbNK2SRw4flzTGY7etDwQUAXWSJuz7hLkaFL+NNvqg65NUT
         hcTZv5mnWgDRDyGSmHzdxGZpAzpSEj4ReWgLOkWcHYtYQOwQ5+PCRG7fEAoN/SlKRB
         35Ui4ENXhDnW9U8ErSadwPqPjhAHUxOjDc3EH0KYKxkeBUk4Btt5IOU1nUh92zvjWY
         L0smsSVS/TWVoyzD28EKZ6C+s8Z29L5GyRx1m1MxC/9LQNIP62MjtzRensQYV0E+df
         8zcnoZrxP/68w==
Date:   Fri, 26 May 2023 17:26:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Janusz Dziedzic <janusz.dziedzic@tieto.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 9/9] wifi: ath10k: Use RMW accessors for changing
 LNKCTL
Message-ID: <ZHEyLR6FQE7h77wp@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a67bac-9b4c-1260-f7a-287f4c205dbb@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 26, 2023 at 02:48:44PM +0300, Ilpo J�rvinen wrote:
> On Thu, 25 May 2023, Ilpo J�rvinen wrote:
> > On Wed, 24 May 2023, Bjorn Helgaas wrote:
> > > On Wed, May 17, 2023 at 01:52:35PM +0300, Ilpo J�rvinen wrote:
> > > > Don't assume that only the driver would be accessing LNKCTL. ASPM
> > > > policy changes can trigger write to LNKCTL outside of driver's control.
> > > > 
> > > > Use RMW capability accessors which does proper locking to avoid losing
> > > > concurrent updates to the register value. On restore, clear the ASPMC
> > > > field properly.
> > > > 
> > > > Fixes: 76d870ed09ab ("ath10k: enable ASPM")
> > > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > > Signed-off-by: Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/net/wireless/ath/ath10k/pci.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> > > > index a7f44f6335fb..9275a672f90c 100644
> > > > --- a/drivers/net/wireless/ath/ath10k/pci.c
> > > > +++ b/drivers/net/wireless/ath/ath10k/pci.c
> > > > @@ -1963,8 +1963,9 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
> > > >  	ath10k_pci_irq_enable(ar);
> > > >  	ath10k_pci_rx_post(ar);
> > > >  
> > > > -	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> > > > -				   ar_pci->link_ctl);
> > > > +	pcie_capability_clear_and_set_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> > > > +					   PCI_EXP_LNKCTL_ASPMC,
> > > > +					   ar_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
> > > >  
> > > >  	return 0;
> > > >  }
> > > > @@ -2821,8 +2822,8 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
> > > >  
> > > >  	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> > > >  				  &ar_pci->link_ctl);
> > > > -	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> > > > -				   ar_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
> > > > +	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> > > > +				   PCI_EXP_LNKCTL_ASPMC);
> > > 
> > > These ath drivers all have the form:
> > > 
> > >   1) read LNKCTL
> > >   2) save LNKCTL value in ->link_ctl
> > >   3) write LNKCTL with "->link_ctl & ~PCI_EXP_LNKCTL_ASPMC"
> > >      to disable ASPM
> > >   4) write LNKCTL with ->link_ctl, presumably to re-enable ASPM
> > > 
> > > These patches close the hole between 1) and 3) where other LNKCTL
> > > updates could interfere, which is definitely a good thing.
> > > 
> > > But the hole between 1) and 4) is much bigger and still there.  Any
> > > update by the PCI core in that interval would be lost.
> > 
> > Any update to PCI_EXP_LNKCTL_ASPMC field in that interval is lost yes, the 
> > updates to _the other fields_ in LNKCTL are not lost.
> > 
> > I know this might result in drivers/pci/pcie/aspm.c disagreeing what
> > the state of the ASPM is (as shown under sysfs) compared with LNKCTL 
> > value but the cause can no longer be due racing RMW. Essentially, 4) is 
> > seen as an override to what core did if it changed ASPMC in between. 
> > Technically, something is still "lost" like you say but for a different 
> > reason than this series is trying to fix.
> > 
> > > Straw-man proposal:
> > > 
> > >   - Change pci_disable_link_state() so it ignores aspm_disabled and
> > >     always disables ASPM even if platform firmware hasn't granted
> > >     ownership.  Maybe this should warn and taint the kernel.
> > > 
> > >   - Change drivers to use pci_disable_link_state() instead of writing
> > >     LNKCTL directly.
> 
> Now that I took a deeper look into what pci_disable_link_state() and 
> pci_enable_link_state() do, I realized they're not really disable/enable 
> pair like I had assumed from their names. Disable adds to ->aspm_disable 
> and flags are never removed from that because enable does not touch 
> aspm_disable at all but has it's own flag variable. This asymmetry looks 
> intentional.

Yes, that's an annoying feature.  There's only one caller of
pci_enable_link_state(), so it may be possible to make this more
symmetric.

> So if ath drivers would do pci_disable_link_state() to realize 1)-3), 
> there is no way to undo it in 4). It looks as if ath drivers would 
> actually want to use pci_enable_link_state() with different state 
> parameters to realize what they want to do in 1)-4).

Yeah, that does sound like a problem.  I don't have any great ideas.

Bjorn
