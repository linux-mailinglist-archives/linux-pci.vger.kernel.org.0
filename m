Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDA68FB47
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBHXmh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 18:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBHXmg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 18:42:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FB1C313;
        Wed,  8 Feb 2023 15:42:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 472A1CE1F64;
        Wed,  8 Feb 2023 23:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF5C433D2;
        Wed,  8 Feb 2023 23:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675899751;
        bh=kxMWpiwcyGm0XyH0bz/DSKSpNTrSPDj2xGILb6fnXwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YeQFLQNAxzdewClJI3G/5GBaTBU4gn8kPG0OtMmK4cSCMkdwbZfhHTmbReO74CVoB
         YOrHMAQalHgcwN/pK/nEWtyScMdkCsWYGkJ7QYup6J+rHghQRBWQvTiR/KOZ2DogMt
         PbEVyC0NSKTJCPGaFPQqFhzfqHN2xTQB7y8IsdLVnucUTUe7DEODDSgjOWs1Ue+JhB
         I1BOMevBMvRpkWVjjGdiKVnsbuN+OMM3W93mk1SdoNwqb+4WXpCiJB+l4wdTgAS6oL
         Ip54lii2SvO4KsQsmwTT99w9+V2PnmbDofLEiGytn/GWvyTan8PXeoSb2THXw45nT1
         RC+nIOSGKx/nA==
Date:   Wed, 8 Feb 2023 17:42:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
        enriquezmark36@gmail.com, tasev.stefanoska@skynet.be,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI/ASPM: Skip L1SS save/restore if not already
 enabled
Message-ID: <20230208234229.GA2496794@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120091540.3305-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 02:45:40PM +0530, Vidya Sagar wrote:
> Skip save and restore of ASPM L1 Sub-States specific registers if they
> are not already enabled in the system. This is to avoid issues observed
> on certain platforms during restoration process, particularly when
> restoring the L1SS registers contents.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v2:
> * Address review comments from Kai-Heng Feng and Rafael
> 
>  drivers/pci/pcie/aspm.c | 17 ++++++++++++++++-
>  include/linux/pci.h     |  1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..bd2a922081bd 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -761,11 +761,23 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>  {
>  	struct pci_cap_saved_state *save_state;
>  	u16 l1ss = dev->l1ss;
> -	u32 *cap;
> +	u32 *cap, val;
>  
>  	if (!l1ss)
>  		return;
>  
> +	/*
> +	 * Skip save and restore of L1 Sub-States registers if they are not
> +	 * already enabled in the system
> +	 */
> +	pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
> +	if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
> +		dev->skip_l1ss_restore = true;
> +		return;
> +	}

I think this fix is still problematic.  PCIe r6.0, sec 5.5.4, requires
that

  If setting either or both of the enable bits for ASPM L1 PM
  Substates, both ports must be configured as described in this
  section while ASPM L1 is disabled.

The current Linux code does not observe this because ASPM L1 is
enabled by PCI_EXP_LNKCTL (in the PCIe Capability Link Control
register), while ASPM L1 PM Substate configuration is in PCI_L1SS_CTL1
(in the L1 PM Substates Capability), and these two things are not
integrated:

  pci_restore_state
    pci_restore_aspm_l1ss_state
      aspm_program_l1ss
        pci_write_config_dword(PCI_L1SS_CTL1, ctl1)         # L1SS restore
    pci_restore_pcie_state
      pcie_capability_write_word(PCI_EXP_LNKCTL, cap[i++])  # L1 restore

So I suspect the problem is that we're writing PCI_L1SS_CTL1 while
ASPM L1 is enabled, and the device gets confused somehow.

I think it would be better change this restore flow to follow that
spec requirement instead of skipping the save/restore like this.

I hesitate to even include the patch below because it's clearly not a
real fix, but if the system does resume and we see this message, it
would be a good clue that this is what's happening.

Bjorn

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53a1fa306e1e..c8349b1f982f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -779,7 +779,7 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
 	u32 *cap, ctl1, ctl2;
-	u16 l1ss = dev->l1ss;
+	u16 ctl, l1ss = dev->l1ss;
 
 	if (!l1ss)
 		return;
@@ -788,6 +788,13 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
 	if (!save_state)
 		return;
 
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &ctl);
+	if (ctl & PCI_EXP_LNKCTL_ASPM_L1) {
+		pci_info(dev, "ASPM: can't restore L1SS while L1 enabled (%#06x)\n",
+			 ctl);
+		return;
+	}
+
 	cap = (u32 *)&save_state->cap.data[0];
 	ctl2 = *cap++;
 	ctl1 = *cap;
