Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19115A98D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfF2IIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 04:08:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfF2IIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 04:08:36 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hh8PQ-0002GX-QA; Sat, 29 Jun 2019 10:08:32 +0200
Date:   Sat, 29 Jun 2019 10:08:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Megha Dey <megha.dey@linux.intel.com>
cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com
Subject: Re: [RFC V1 RESEND 5/6] PCI/MSI: Free MSI-X resources by group
In-Reply-To: <1561162778-12669-6-git-send-email-megha.dey@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906291002190.1802@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com> <1561162778-12669-6-git-send-email-megha.dey@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Megha,

On Fri, 21 Jun 2019, Megha Dey wrote:
> +static int free_msi_irqs_grp(struct pci_dev *dev, int group_id)
> +{

> +
> +	for_each_pci_msi_entry(entry, dev) {
> +		if (entry->group_id == group_id && entry->irq)
> +			for (i = 0; i < entry->nvec_used; i++)
> +				BUG_ON(irq_has_action(entry->irq + i));

BUG_ON is wrong here. This can and must be handled gracefully.

> +	}
> +
> +	pci_msi_teardown_msi_irqs_grp(dev, group_id);
> +
> +	list_for_each_entry_safe(entry, tmp, msi_list, list) {
> +		if (entry->group_id == group_id) {
> +			clear_bit(entry->msi_attrib.entry_nr, dev->entry);
> +			list_del(&entry->list);
> +			free_msi_entry(entry);
> +		}
> +	}
> +
> +	list_for_each_entry_safe(msix_sysfs_entry, tmp_msix, pci_msix, list) {
> +		if (msix_sysfs_entry->group_id == group_id) {

Again. Proper group management makes all of that just straight forward and
not yet another special case.

> +			msi_attrs = msix_sysfs_entry->msi_irq_group->attrs;
>  
> +static void pci_msix_shutdown_grp(struct pci_dev *dev, int group_id)
> +{
> +	struct msi_desc *entry;
> +	int grp_present = 0;
> +
> +	if (pci_dev_is_disconnected(dev)) {
> +		dev->msix_enabled = 0;

Huch? What's that? I can't figure out why this is needed and of course it
completely lacks a comment explaining this. 

> +		return;
> +	}
> +
> +	/* Return the device with MSI-X masked as initial states */
> +	for_each_pci_msi_entry(entry, dev) {
> +		if (entry->group_id == group_id) {
> +			/* Keep cached states to be restored */
> +			__pci_msix_desc_mask_irq(entry, 1);
> +			grp_present = 1;
> +		}
> +	}
> +
> +	if (!grp_present) {
> +		pci_err(dev, "Group to be disabled not present\n");
> +		return;

So you print an error and silently return

> +	}
> +}
> +
> +int pci_disable_msix_grp(struct pci_dev *dev, int group_id)
> +{
> +	int num_vecs;
> +
> +	if (!pci_msi_enable || !dev)
> +		return -EINVAL;
> +
> +	pci_msix_shutdown_grp(dev, group_id);
> +	num_vecs = free_msi_irqs_grp(dev, group_id);

just to call in another function which has to do the same group_id lookup
muck again.

> +
> +	return num_vecs;
> +}
> +EXPORT_SYMBOL(pci_disable_msix_grp);

Why is this exposed ?

Thanks,

	tglx
