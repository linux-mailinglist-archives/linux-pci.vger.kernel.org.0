Return-Path: <linux-pci+bounces-8883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACF90BBC2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 22:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507F5281C41
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 20:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C9191467;
	Mon, 17 Jun 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQj5xiWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D2190485;
	Mon, 17 Jun 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654988; cv=none; b=Hc50Kndl0KlS6uv20KYeGGJABAfwHTHx3bbTxZEPRsZ5jtqOBLUomowIkQBOOrQESGSPBvUpysjEBk1rnAjIUnvCCWFV5DBFGnlhbOEeUYWU7QXoLYgbbiRMa0067qhwwy6Ci6ZkkextKl4P7xfN/h1Qjb781/0tNlMEAnipsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654988; c=relaxed/simple;
	bh=BZ1SlfBgPY598miLffrlWG/dkQ0QQqL1lVBACSpQRuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f61w9BJvywCOUNiSFLhN6jML9VDa57gN0bbSXscuvt+6dapfwYO4WtcFOi78oG+4VGcg63RM0C+Y4f9SHKXBqL+0ikMKNkS0xoa7iuWYK+nUoPMdrrr7YC0aUsei29vF/GcPhLnK9Fm+hWUIHXGqpklZeKmrvEFfrmDPmDJyljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQj5xiWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7CBC2BD10;
	Mon, 17 Jun 2024 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718654987;
	bh=BZ1SlfBgPY598miLffrlWG/dkQ0QQqL1lVBACSpQRuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EQj5xiWJcwxH0KcdSiNDZ4sJIELvwhF2upFakE/1qNRM30lTec3S5XDon5SkgVlrX
	 e+kJjgDqaSbANZt1vgcJ+KrPalh0sMAMdVd2hEmlxhZXx6t9I8wErQsYLN2t/nAu0J
	 W1f5KTMeh73jvJxGBnKhL7zNjNyaGPU4/K6SQccJD5KLMbIrmnTdvRhIPis76tJRSF
	 696JMtIDDGicPl+Hb5VkIHQcVd1t0oCLYfssDCDmFv2KhkCL/zb59H/rHJRRNa5k4q
	 LCjrqSJIp8rQm/fkoYl0raqIkJw54c5MDYmCiLLYl1vPH+NgsJ5F3OPDR4XHQFBAs8
	 giStyWhg24+tw==
Date: Mon, 17 Jun 2024 15:09:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Bowman Terry <terry.bowman@amd.com>,
	Hagan Billy <billy.hagan@amd.com>,
	Simon Guinot <simon.guinot@seagate.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
Message-ID: <20240617200945.GA1224924@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516204748.204992-1-Smita.KoralahalliChannabasappa@amd.com>

On Thu, May 16, 2024 at 08:47:48PM +0000, Smita Koralahalli wrote:
> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove
> event.
> 
> The hot-remove event could result in target link speed reduction if LBMS
> is set, due to a delay in Presence Detect State Change (PDSC) happening
> after a Data Link Layer State Change event (DLLSC).
> 
> In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
> PDSC can sometimes be too late and the slot could have already been
> powered down just by a DLLSC event. And the delayed PDSC could falsely be
> interpreted as an interrupt raised to turn the slot on. This false process
> of powering the slot on, without a link forces the kernel to retrain the
> link if LBMS is set, to a lower speed to restablish the link thereby
> bringing down the link speeds [2].

Not sure we need PDSC and DLLSC details to justify clearing LBMS if it
has no meaning for an empty slot?

> According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
> be set for an unconnected link and if set, it serves the purpose of
> indicating that there is actually a device down an inactive link.

I see that r6.2 added an implementation note about DLLSC, but I'm not
a hardware person and can't follow the implication about a device
present down an inactive link.

I guess it must be related to the fact that LBMS indicates either
completion of link retraining or a change in link speed or width
(which would imply presence of a downstream device).  But in both
cases I assume the link would be active.

But IIUC LBMS is set by hardware but never cleared by hardware, so if
we remove a device and power off the slot, it doesn't seem like LBMS
could be telling us anything useful (what could we do in response to
LBMS when the slot is empty?), so it makes sense to me to clear it.

It seems like pciehp_unconfigure_device() does sort of PCI core and
driver-related things and possibly could be something shared by all
hotplug drivers, while remove_board() does things more specific to the
hotplug model (pciehp, shpchp, etc).

From that perspective, clearing LBMS might fit better in
remove_board().  In that case, I wonder whether it should be done
after turning off slot power?  This patch clears is *before* turning
off the power, so I wonder if hardware could possibly set it again
before the poweroff?

> However, hardware could have already set LBMS when the device was
> connected to the port i.e when the state was DL_Up or DL_Active. Some
> hardwares would have even attempted retrain going into recovery mode,
> just before transitioning to DL_Down.
> 
> Thus the set LBMS is never cleared and might force software to cause link
> speed drops when there is no link [2].
> 
> Dmesg before:
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
> 	pcieport 0000:20:01.1: retraining failed
> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
> 
> Dmesg after:
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link

I'm a little confused about the problem being solved here.  Obviously
the message is extraneous.  I guess the slot is empty, so retraining
is meaningless and will always fail.  Maybe avoiding it avoids a
delay?  Is the benefit that we get rid of the message and a delay?

> [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
>     https://members.pcisig.com/wg/PCI-SIG/document/20590
> [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")

Lukas asked about this; did you confirm that it is related?  Asking
because the Fixes tag may cause this to be backported along with
a89c82249c37.

> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> Link to v1:
> https://lore.kernel.org/all/20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com/
> 
> v2:
> 	Cleared LBMS unconditionally. (Ilpo)
> 	Added Fixes Tag. (Lukas)
> ---
>  drivers/pci/hotplug/pciehp_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index ad12515a4a12..dae73a8932ef 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -134,4 +134,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>  	}
>  
>  	pci_unlock_rescan_remove();
> +
> +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> +				   PCI_EXP_LNKSTA_LBMS);
>  }
> -- 
> 2.17.1
> 

