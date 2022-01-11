Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5648B268
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbiAKQja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 11:39:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51574 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350118AbiAKQjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 11:39:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98CA9B81C01;
        Tue, 11 Jan 2022 16:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122E2C36AED;
        Tue, 11 Jan 2022 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641919158;
        bh=61fwir8FuBBwmudkd+4p2vr90sj5PqTwWrjg0ksTNFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=csBTAvxDTIiFkWxJ3vMmI/hhMNYLTn+pstEdKPJi88HdA6GNINC1GroXdvxNkV5s1
         nNvyh2N/p9alJAE+5+0EOkbj3YzF9TCepFnlP5LYwwrCRCAFYwM3aT6NcPzKPFOriI
         DBqEhao8yX+kmB6uHyO01h7yotaQSr8EqBQPas44oZ0YSizo+BJ7ErZjc4YBtLRiNr
         1Yf895Pr6qPu0m2019accFl5LqbBmmFFMqkYx5uSC8T26I4q/XB2s7YBh/cRuDs6Vx
         29II0iBLahpOMyo1BQqBc2/eLpfH20N6ynIQhSd6cEB9iX8ZIMHN6GAA8e9olIRH7g
         qujsL/ds73Vyg==
Date:   Tue, 11 Jan 2022 10:39:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kw@linux.com,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatxjain@gmail.com
Subject: Re: [PATCH] pci: Make DWORD accesses while saving / restoring LTR
 state
Message-ID: <20220111163916.GA148556@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222012105.3438916-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 21, 2021 at 05:21:05PM -0800, Rajat Jain wrote:
> Some devices have an errata such that they only support DWORD accesses
> to some registers.
> 
> For e.g. this Bayhub O2 device ([VID:DID] = [0x1217:0x8621]) only
> supports DWORD accesses to LTR latency registers and L1 PM substates
> control registers:
> https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf
> 
> Since L1 PM substate control registers are DWORD sized, and hence their
> access in the kernel is already DWORD sized, so we don't need to do
> anything for them.
> 
> However, the LTR registers being WORD sized, are in need of a solution.
> This patch converts the WORD sized accesses to these registers, into
> DWORD sized accesses, while saving and restoring them.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Applied to pci/enumeration for v5.17, thanks, Rajat!

The app note suggests that this erratum only affects the registers at
0x234, 0x248, and 0x24c, i.e., the LTR snoop registers and the L1 SS
control registers.

Can you confirm that is true?  Byte and word accesses to other parts
of config space work correctly?

I *assume* the other parts work correctly, because if byte and word
accesses were broken, all sorts of things would not work, like
PCI_COMMAND, PCI_STATUS, searching the capability list, etc.

Bjorn

> ---
>  drivers/pci/pci.c       | 24 ++++++++++++++++--------
>  drivers/pci/pcie/aspm.c |  1 +
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3d2fb394986a..efa8cd16827f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1556,7 +1556,7 @@ static void pci_save_ltr_state(struct pci_dev *dev)
>  {
>  	int ltr;
>  	struct pci_cap_saved_state *save_state;
> -	u16 *cap;
> +	u32 *cap;
>  
>  	if (!pci_is_pcie(dev))
>  		return;
> @@ -1571,25 +1571,33 @@ static void pci_save_ltr_state(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	cap = (u16 *)&save_state->cap.data[0];
> -	pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap++);
> -	pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, cap++);
> +	/*
> +	 * We deliberately do a dword access to save both PCI_LTR_MAX_SNOOP_LAT
> +	 * and PCI_LTR_MAX_NOSNOOP_LAT together since some devices only support
> +	 * dword accesses to these registers.
> +	 */
> +	cap = &save_state->cap.data[0];
> +	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
>  }
>  
>  static void pci_restore_ltr_state(struct pci_dev *dev)
>  {
>  	struct pci_cap_saved_state *save_state;
>  	int ltr;
> -	u16 *cap;
> +	u32 *cap;
>  
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
>  	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
>  	if (!save_state || !ltr)
>  		return;
>  
> -	cap = (u16 *)&save_state->cap.data[0];
> -	pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++);
> -	pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
> +	/*
> +	 * We deliberately do a dword access to restore both
> +	 * PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT together since
> +	 * some devices only support dword accesses to these registers.
> +	 */
> +	cap = &save_state->cap.data[0];
> +	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
>  }
>  
>  /**
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 52c74682601a..083f47a7b69b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -496,6 +496,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	encode_l12_threshold(l1_2_threshold, &scale, &value);
>  	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>  
> +	/* Always make DWORD sized accesses to these registers */
>  	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
>  	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, &pctl2);
>  	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
> -- 
> 2.34.1.307.g9b7440fafd-goog
> 
