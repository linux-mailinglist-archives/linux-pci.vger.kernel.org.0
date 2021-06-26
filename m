Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4F3B4D3B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhFZGxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 02:53:13 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40233 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZGxN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 02:53:13 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DF8ED100B095C;
        Sat, 26 Jun 2021 08:50:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A102C4389E8; Sat, 26 Jun 2021 08:50:49 +0200 (CEST)
Date:   Sat, 26 Jun 2021 08:50:49 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210626065049.GA19767@wunner.de>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
 <20210620073804.GA13118@wunner.de>
 <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 03:38:41PM -0500, stuart hayes wrote:
> I have a system that is failing to recover after an EDR event with (or
> without...) this patch.  It looks like the problem is similar to what this
> patch is trying to fix, except that on my system, the hotplug port is
> downstream of the root port that has DPC, so the "link down" event on it is
> not being ignored.  So the hotplug code disables the slot (which contains an
> NVMe device on this system) while the nvme driver is trying to use it, which
> results in a failed recovery and another EDR event, and the kernel ends up
> with the DPC trigger status bit set in the root port, so everything
> downstream is gone.
> 
> I added the hack below so the hotplug code will ignore the "link down"
> events on the ports downstream of the root port during DPC recovery, and it
> recovers no problem.  (I'm not proposing this as a correct fix.)

Please help me understand what's causing the Link Down event in the
first place:

With DPC, the hardware (only) disables the link on the port containing the
error.  Since that's the Root Port above the hotplug port in your case,
the link between the hotplug port and the NVMe drive should remain up.

Since your patch sets the PCI_DPC_RECOVERING flag during invocation
of the dev->driver->err_handler->slot_reset() hook, I assume that's
what's causing the Link Down.  However pcie_portdrv_slot_reset()
only restores and saves PCI config space, I don't think that's
causing a Link Down?

Is maybe nvme_slot_reset() causing the Link Down on the parent hotplug port?

Thanks,

Lukas

> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index b576aa890c76..dfd983c3c5bf 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -119,8 +132,10 @@ static int report_slot_reset(struct pci_dev *dev, void
> *data)
>  		!dev->driver->err_handler->slot_reset)
>  		goto out;
> 
> +	set_bit(PCI_DPC_RECOVERING, &dev->priv_flags);
>  	err_handler = dev->driver->err_handler;
>  	vote = err_handler->slot_reset(dev);
> +	clear_bit(PCI_DPC_RECOVERING, &dev->priv_flags);
>  	*result = merge_result(*result, vote);
>  out:
>  	device_unlock(&dev->dev);
