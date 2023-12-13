Return-Path: <linux-pci+bounces-841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968F810B73
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 08:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A91C20442
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8285618E27;
	Wed, 13 Dec 2023 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o7KlIn0S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF1C14F;
	Wed, 13 Dec 2023 07:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9ADC433C7;
	Wed, 13 Dec 2023 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702452390;
	bh=76OJVqmnozrsnIZlwxGqTR/mpG0Abmmm32RAtiZ6W+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7KlIn0S1Hpqs8X1x8ZQp5yK2Q09F2mVnQ56btuzJyny0Gewb2PB8TvdDEDW9BYYZ
	 iGbx/j27UdO53hdQnvB2R4g3yV2Cbc50kAb64IwIOok0MYUsO0JjS8+xn1QmQCQ/Cf
	 E85+4GrJzX66OeaX2QlF3E/9FcBnQk2dFgMGF3PI=
Date: Wed, 13 Dec 2023 08:26:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, mika.westerberg@linux.intel.com,
	boris.ostrovsky@oracle.com, joe.jin@oracle.com,
	stable@vger.kernel.org, Fiona Ebner <f.ebner@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
Message-ID: <2023121321-politely-creamer-fbad@gregkh>
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213003614.1648343-3-imammedo@redhat.com>

On Wed, Dec 13, 2023 at 01:36:14AM +0100, Igor Mammedov wrote:
> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> bridge reconfiguration in case of single HBA hotplug.
> However in virt environment it's possible to pause machine hotplug several
> HBAs and let machine run. That can hit the same race when 2nd hotplugged
> HBA will start re-configuring bridge.
> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> devices within single hotplug event.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 6b11609927d6..30bca2086b24 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -37,6 +37,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  
>  #include "../pci.h"
>  #include "acpiphp.h"
> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  {
>  	struct acpiphp_slot *slot;
> +        int nr_hp_slots = 0;
>  
>  	/* Bail out if the bridge is going away. */
>  	if (bridge->is_going_away)
> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  
>  			/* configure all functions */
>  			if (slot->flags != SLOT_ENABLED) {
> +				if (nr_hp_slots)
> +					msleep(1000);
> +
> +                                ++nr_hp_slots;
>  				enable_slot(slot, true);
>  			}
>  		} else {
> -- 
> 2.39.3
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

