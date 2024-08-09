Return-Path: <linux-pci+bounces-11566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1494D820
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 22:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1DF1F23469
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95D13E02A;
	Fri,  9 Aug 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRfAdA9f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099E41C79;
	Fri,  9 Aug 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235784; cv=none; b=EkdYYk3gqjLQkg8zhNPZvMd5hMgrhRzHRmk/7upJW7jWA7xYyYt37R1/+F9r1U/Rr386YEIfHLWT0S2sMdZk0TngVgUMPlFH2xYmkkt+8aoIGaBVu0mnGgQMe1vldPCs3G4L+AxyQRHRI0F8D7RSgFtxUxOT1FcYtnrvB8PQVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235784; c=relaxed/simple;
	bh=gvFcEXP1ZfFTAGD9WjamLKCJD24rNneCFSQb6KTy1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dn5Q2upG5eP1XptWtz+65xX75/sNv84LvNu7bzKI85VEFbZNMWkcsBlw9in1coYWjHkeZKFJg/M+Cx456PGrliNGDprAEmgYhDIjK+6wW3+SdWCxa+6PCDxp8X+Dl6qQTQykxb8/i+VTw+nVAybRztqOl6YUYIQtrNFDEgW2TUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRfAdA9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BE1C32782;
	Fri,  9 Aug 2024 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723235783;
	bh=gvFcEXP1ZfFTAGD9WjamLKCJD24rNneCFSQb6KTy1jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NRfAdA9fnGwiTrl+Mjmf0ZHQagjMOOsDrednmlEoVw++Jd0NrR9M04/v7AY5dFrbw
	 2qLzqSLkUvhJE2kHLL1xdHjecnl90Lvt/AQ+g5Iwf3SRQrEbp9KB7+jArMYDscJWLk
	 3rdUzNylJdfj8EzyvIbof6rCeksJJNrw0u3fjETq/bkwl0wgfN0dx97DTZlzBXocFv
	 /BR2u+xFWBupyo6Q8RDW9dTLkG7fWUHJlMXYuDbKlRpiEajku8SdxcEBg5dURbHUqR
	 g2D7CSA4gYm/z5/JoYYz236rhqDmClw7dIWlI2uI6G38rt+heH9mLqWwzE43eoQFfH
	 5gKUbyqOc3A8g==
Date: Fri, 9 Aug 2024 15:36:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/1] PCI: Wait for Link before restoring Downstream Buses
Message-ID: <20240809203621.GA214516@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808121708.2523-1-ilpo.jarvinen@linux.intel.com>

On Thu, Aug 08, 2024 at 03:17:07PM +0300, Ilpo Järvinen wrote:
> __pci_reset_bus() calls pci_bridge_secondary_bus_reset() to perform the
> reset and also waits for the Secondary Bus to become again accessible.
> __pci_reset_bus() then calls pci_bus_restore_locked() that restores the
> PCI devices connected to the bus, and if necessary, recursively restores
> also the subordinate buses and their devices.
> 
> The logic in pci_bus_restore_locked() does not take into account that
> after restoring a device on one level, there might be another Link
> Downstream that can only start to come up after restore has been
> performed for its Downstream Port device. That is, the Link may
> require additional wait until it becomes accessible.
> 
> Similarly, pci_slot_restore_locked() lacks wait.
> 
> Amend pci_bus_restore_locked() and pci_slot_restore_locked() to wait
> for the Secondary Bus before recursively performing the restore of that
> bus.
> 
> Fixes: 090a3c5322e9 ("PCI: Add pci_reset_slot() and pci_reset_bus()")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Seems reasonable to me, applied to pci/reset for v6.12, thanks!

> ---
> 
> NOTE TO MAINTAINER: I've not seen anything to actually trigger this issue
> but only realized this problem exist while looking into the other issues
> related to bus reset/restore. The fix regardless seems to make sense so
> sending it out.
> 
>  drivers/pci/pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e3a49f66982d..98c7b732998a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5671,8 +5671,10 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		pci_dev_restore(dev);
> -		if (dev->subordinate)
> +		if (dev->subordinate) {
> +			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
>  			pci_bus_restore_locked(dev->subordinate);
> +		}
>  	}
>  }
>  
> @@ -5706,8 +5708,10 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
>  		pci_dev_restore(dev);
> -		if (dev->subordinate)
> +		if (dev->subordinate) {
> +			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
>  			pci_bus_restore_locked(dev->subordinate);
> +		}
>  	}
>  }
>  
> -- 
> 2.39.2
> 

