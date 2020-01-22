Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91571145AD5
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 18:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVR2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 12:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgAVR2S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 12:28:18 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518C52465A;
        Wed, 22 Jan 2020 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579714097;
        bh=v45//aLOIelbSIblxH0H5quiYA4SDipsGzDyo26vKWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uuEbZODdAfY2orhNAv1udC3ffIXt2OSXDhzucSgEDrIEVsOGW2ar5/mExXmBvtcl9
         FCJF7HS3xS/Sn4RXa7YOCvDqgFudCy37FqmpT22JikWhkUfQAJn6iBdsqRFj1uUnoI
         iu+HjBt5BNh2H9K+uhzxkTq76DJmq91hPN7+DJA8=
Date:   Wed, 22 Jan 2020 11:28:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
Message-ID: <20200122172816.GA139285@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, Marc, Christoph, Rajat]

On Thu, Jan 16, 2020 at 01:31:28PM -0800, Evan Green wrote:
> __pci_write_msi_msg() updates three registers in the device: address
> high, address low, and data. On x86 systems, address low contains
> CPU targeting info, and data contains the vector. The order of writes
> is address, then data.
> 
> This is problematic if an interrupt comes in after address has
> been written, but before data is updated, and the SMP affinity of
> the interrupt is changing. In this case, the interrupt targets the
> wrong vector on the new CPU.
> 
> This case is pretty easy to stumble into using xhci and CPU hotplugging.
> Create a script that targets interrupts at a set of cores and then
> offlines those cores. Put some stress on USB, and then watch xhci lose
> an interrupt and die.
> 
> Avoid this by disabling MSIs during the update.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> 
> Bjorn,
> I was unsure whether disabling MSIs temporarily is actually an okay
> thing to do. I considered using the mask bit, but got the impression
> that not all devices support the mask bit. Let me know if this going to
> cause problems or there's a better way. I can include the repro
> script I used to cause mayhem if needed.

I suspect this *is* a problem because I think disabling MSI doesn't
disable interrupts; it just means the device will interrupt using INTx
instead of MSI.  And the driver is probably not prepared to handle
INTx.

PCIe r5.0, sec 7.7.1.2, seems relevant: "If MSI and MSI-X are both
disabled, the Function requests servicing using INTx interrupts (if
supported)."

Maybe the IRQ guys have ideas about how to solve this?

> ---
>  drivers/pci/msi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6b43a5455c7af..97856ef862d68 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -328,7 +328,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  		u16 msgctl;
>  
>  		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> -		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
> +		msgctl &= ~(PCI_MSI_FLAGS_QSIZE | PCI_MSI_FLAGS_ENABLE);
>  		msgctl |= entry->msi_attrib.multiple << 4;
>  		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
>  
> @@ -343,6 +343,9 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
>  					      msg->data);
>  		}
> +
> +		msgctl |= PCI_MSI_FLAGS_ENABLE;
> +		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
>  	}
>  
>  skip:
> -- 
> 2.24.1
> 
