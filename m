Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7191407C72
	for <lists+linux-pci@lfdr.de>; Sun, 12 Sep 2021 10:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhILIrD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Sep 2021 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhILIrD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Sep 2021 04:47:03 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165CCC061574
        for <linux-pci@vger.kernel.org>; Sun, 12 Sep 2021 01:45:49 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 38A9A300002A0;
        Sun, 12 Sep 2021 10:45:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 28BD927254C; Sun, 12 Sep 2021 10:45:47 +0200 (CEST)
Date:   Sun, 12 Sep 2021 10:45:47 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jon Derrick <jonathan.derrick@linux.dev>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a
 x4x4 SSD
Message-ID: <20210912084547.GA26678@wunner.de>
References: <20210830155628.130054-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830155628.130054-1-jonathan.derrick@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:
> When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
> ports both support hotplugging on each respective x4 device, a slot
> management system for the SSD requires both x4 slots to have power
> removed via sysfs (echo 0 > slot/N/power), from the OS before it can
> safely turn-off physical power for the whole x8 device. The implications
> are that slot status will display powered off and link inactive statuses
> for the x4 devices where the devices are actually powered until both
> ports have powered off.

Just to get a better understanding, does the P5608 have an internal
PCIe switch with hotplug capability on the Downstream Ports or
does it plug into two separate PCIe slots?  I recall previous patches
mentioned a CEM interposer?  (An lspci listing might be helpful.)


> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -225,6 +225,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  {
>  	int present, link_active;
> +	struct pci_dev *pdev = ctrl->pcie->port;

Nit: Reverse christmas tree.


> @@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		cancel_delayed_work(&ctrl->button_work);
>  		fallthrough;
>  	case OFF_STATE:
> +		if (pdev->shared_pcc_and_link_slot &&
> +		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
> +			mutex_unlock(&ctrl->state_lock);
> +			break;
> +		}
> +

I think you also need to add...

			pdev->shared_pcc_and_link_slot = false;

... here to reset the shared_pcc_and_link_slot attribute in case the
next card plugged into the slot doesn't have the quirk.

(This can't be done in pciehp_unconfigure_device() because the attribute
is queried *after* the slot has been brought down.)


> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5750,3 +5750,37 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE

It's possible to put the quirk at the bottom of pciehp_ctrl.c and
thus avoid the need for the #ifdef here.  (We've got another
pciehp-specific quirk at the bottom of pciehp_hpc.c.)

Otherwise LGTM.

Thanks,

Lukas
