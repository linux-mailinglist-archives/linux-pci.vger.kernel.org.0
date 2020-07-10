Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B88421ABE9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 02:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGJAOI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 20:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGJAOI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 20:14:08 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2EE52065F;
        Fri, 10 Jul 2020 00:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594340048;
        bh=1Q5ejM91y+rZdlPiC9UJgo7wuGqE1YmvLc2GRbXroko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2a1Son6W+Y/jnNfWf/6l+CVIii/kSqwRfl7ye9cOmeJxHyIkrxFAKYiE+Kbt3PD6d
         E+d1KyZ02ruY1rVQjHcKdPW8+RrhIKlIUcKaH85ObpDYyAI+tK7DIf9zThvjJM8pPn
         X9oQEEgT+CVubZkBJGaw6L7zIIzaVuByKHmwCqbM=
Date:   Thu, 9 Jul 2020 19:14:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/11 RFC] PCI: pciehp: Make "Power On" the default
Message-ID: <20200710001406.GA30420@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706093121.9731-6-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 11:31:15AM +0200, Saheed Olayemi Bolarinwa wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> The default case of the switch statement is redundant since 
> PCI_EXP_SLTCTL_PCC is only a single bit. pcie_capability_read_word()
> currently causes "On" value to be set if it fails. Patch 11/11
> changes the behaviour of pcie_capability_read_word() so on falure the
> "Off" value will be set.

s/falure/failure/

Split this into two patches.  The removal of the default case should
be in its own patch to make it trivial to review.

> Make the function set status to "Power On" by default and only set to
> Set "Power Off" only if pcie_capability_read_word() is successful and
> (slot_ctrl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_OFF. 
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 0b691e37fd04..78f806a9c6f1 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -399,22 +399,16 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 slot_ctrl;
> +	int ret;
>  
> -	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> +	*status = 1;	/* On */
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
>  
> -	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
> -	case PCI_EXP_SLTCTL_PWR_ON:
> -		*status = 1;	/* On */
> -		break;
> -	case PCI_EXP_SLTCTL_PWR_OFF:
> +	if (!ret &&
> +	    ((slot_ctrl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_OFF))
>  		*status = 0;	/* Off */
> -		break;
> -	default:
> -		*status = 0xFF;
> -		break;
> -	}
>  }
>  
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
> -- 
> 2.18.2
> 
