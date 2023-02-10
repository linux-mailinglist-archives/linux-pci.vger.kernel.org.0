Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628B8691545
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 01:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBJASw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 19:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBJASv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 19:18:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F375EBE1;
        Thu,  9 Feb 2023 16:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C1E3B8237C;
        Fri, 10 Feb 2023 00:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8D3C433EF;
        Fri, 10 Feb 2023 00:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675988326;
        bh=swlVp1NnJftmoY6ijYOEUVS1jlagKsrzASBERDaImfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dBF6UhksqgpWe5umxdWjAjwioM1a/zldCDqaLuwcVDKIGhqOVuQB8aZ8Q17nFax7d
         ZdMTt4P1CiWee8pBFbp4CKwXkezYE18SKoFrrnkQrk/XvwcAfIf6dZEu30QX5F4x8R
         R+wa4r3u/CQ/Y6AWy+XnG+nrLtWe8y21bJjUPjK241TxNPyzgll1ECSERuk/ZWL3fF
         PLxQudhJCaGFWDbjXWVJlMCkwsnLoZ1OwsYHYn/H5bXGkvzLedqk4uGVh/IiwCavGb
         tWvGFslRJ/TYVORMj56j+/SbQyVZg/Onk3oeR0cuu6Xl6noYTrv6oMlA7qxl7P0+wK
         uOITQADl+ZK1g==
Date:   Thu, 9 Feb 2023 18:18:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
        enriquezmark36@gmail.com, tasev.stefanoska@skynet.be,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Thomas Witt <kernel@witt.link>
Subject: Re: [PATCH V2] PCI/ASPM: Skip L1SS save/restore if not already
 enabled
Message-ID: <20230210001845.GA2630328@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208234229.GA2496794@bhelgaas>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas]

On Wed, Feb 08, 2023 at 05:42:29PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 20, 2023 at 02:45:40PM +0530, Vidya Sagar wrote:
> > Skip save and restore of ASPM L1 Sub-States specific registers if they
> > are not already enabled in the system. This is to avoid issues observed
> > on certain platforms during restoration process, particularly when
> > restoring the L1SS registers contents.
> > 
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> > v2:
> > * Address review comments from Kai-Heng Feng and Rafael
> > 
> >  drivers/pci/pcie/aspm.c | 17 ++++++++++++++++-
> >  include/linux/pci.h     |  1 +
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 53a1fa306e1e..bd2a922081bd 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -761,11 +761,23 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> >  {
> >  	struct pci_cap_saved_state *save_state;
> >  	u16 l1ss = dev->l1ss;
> > -	u32 *cap;
> > +	u32 *cap, val;
> >  
> >  	if (!l1ss)
> >  		return;
> >  
> > +	/*
> > +	 * Skip save and restore of L1 Sub-States registers if they are not
> > +	 * already enabled in the system
> > +	 */
> > +	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
> > +	if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
> > +		dev->skip_l1ss_restore = true;
> > +		return;
> > +	}
> 
> I think this fix is still problematic.  PCIe r6.0, sec 5.5.4, requires
> that
> 
>   If setting either or both of the enable bits for ASPM L1 PM
>   Substates, both ports must be configured as described in this
>   section while ASPM L1 is disabled.
> 
> The current Linux code does not observe this because ASPM L1 is
> enabled by PCI_EXP_LNKCTL (in the PCIe Capability Link Control
> register), while ASPM L1 PM Substate configuration is in PCI_L1SS_CTL1
> (in the L1 PM Substates Capability), and these two things are not
> integrated:
> 
>   pci_restore_state
>     pci_restore_aspm_l1ss_state
>       aspm_program_l1ss
>         pci_write_config_dword(PCI_L1SS_CTL1, ctl1)         # L1SS restore
>     pci_restore_pcie_state
>       pcie_capability_write_word(PCI_EXP_LNKCTL, cap[i++])  # L1 restore
> 
> So I suspect the problem is that we're writing PCI_L1SS_CTL1 while
> ASPM L1 is enabled, and the device gets confused somehow.
> 
> I think it would be better change this restore flow to follow that
> spec requirement instead of skipping the save/restore like this.

A revert of 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability
for suspend/resume") has been in linux-next starting with Feb 6.

I originally reverted 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM
Substates Control Register programming") because it broke
suspend/resume differently [1].

I had to revert 4ff116d0d5fd at the same time because 5e85eba6f50d
added aspm_program_l1ss(), which was used by 4ff116d0d5fd.

I don't think Tasev or Mark have directly tested reverting
4ff116d0d5fd to see if it resolves the problem *they* are seeing.  But
that would be good to know so I can update the commit logs.

Bjorn

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216877
