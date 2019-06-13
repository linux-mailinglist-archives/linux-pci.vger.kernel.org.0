Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9456244CD3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFMUDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfFMUDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 16:03:47 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CFA12147A;
        Thu, 13 Jun 2019 20:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560456226;
        bh=p5KoBKCSXKCER3NA/4mUu7NC8BUpmkP2g1h1duOC4iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HX6QcmPg0m8/a1afpgx+O4qLwDTCBlPrS8R5qnYM3UWrFWizgndJK35Qzz5NOf8/3
         zj6Ae1FnVbocjTVOCSqxZh+QcyFrc17WK076PBXyghd3uhty8I/WoiMW4aIUagHitn
         0xIVUcBtCaDvu+K2SFmue+UQJzGNS3s+0zQebiGI=
Date:   Thu, 13 Jun 2019 15:03:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, Lukas Wunner <lukas@wunner.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Martin =?utf-8?B?TG9wYXTDocWZ?= <lopin@dataplex.cz>,
        zigarrre@gmail.com
Subject: Re: [PATCH] PCI: Expose hidden NVIDIA HDA controllers
Message-ID: <20190613200344.GI13533@google.com>
References: <20190613063514.15317-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613063514.15317-1-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Martin, zigarrre]

On Thu, Jun 13, 2019 at 02:35:14PM +0800, Daniel Drake wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> The integrated HDA controller on Nvidia GPUs can be hidden with a bit in
> the GPU's config space. Information about this scheme was provided by
> NVIDIA on their forums.
> 
> Many laptops now ship with this device hidden, meaning that Linux users
> of affected platforms (where the HDMI connector comes off the NVIDIA GPU)
> cannot use HDMI audio functionality.
> 
> Avoid this issue by exposing the HDMI audio device on device enumeration
> and resume.
> 
> The GPU and HDA controller are two functions of the same PCI device
> (VGA class device on function 0 and audio device on function 1).
> The multifunction flag in the GPU's Header Type register is cleared when
> the HDA controller is hidden and set if it's exposed, so reread the flag
> after exposing the HDA.

Is it possible that this works on Windows but not Linux because they
handle ACPI hotplug slightly differently?

Martin did some nice debug [1] and found that _DSM, _PS0, and _PS3
functions write the config bit at 0x488.  The dmesg log [2] from
zigarrre seems to show that _OSC failed (which I *think* means we
won't use pciehp) and that there's a slot registered by acpiphp.

Maybe this works on Windows via an ACPI hotplug event that runs AML to
flip the 0x488 bit and rescans the bus?  That would make more sense to
me than the idea that the Nvidia driver does it.  I could imagine the
driver flipping the bit, but the bus rescan seems like it would be out
of the driver's purview.

The dmesg log also shows some _DSM warnings; are these correlated with
cable plug/unplug?  Is there some acpiphp debug we can turn on to get
more visibility into hotplug events and how we handle them?

[1] https://bugs.freedesktop.org/show_bug.cgi?id=75985#c32
[2] https://bugs.freedesktop.org/attachment.cgi?id=128640

> According to Ilia Mirkin, the HDA controller is only present from MCP89
> onward, so do not touch config space on older GPUs.
> 
> This quirk is limited to NVIDIA PCI devices with the VGA Controller
> device class. This is expected to correspond to product configurations
> where the NVIDIA GPU has connectors attached. Other products where the
> device class is 3D Controller are expected to correspond to configurations
> where the NVIDIA GPU is dedicated (dGPU) and has no connectors.
> 
> It's sensible to avoid exposing the HDA controller on dGPU setups,
> especially because we've seen cases where the PCI BARs are not set
> up correctly by the platform in this case, causing Linux to log
> errors if the device is visible. This assumption of device class
> accurately corresponding to product configuration is true for 6 of 6
> laptops recently checked at the Endless lab, and there are also signs of
> agreement checking the data from 74 previously tested products, however
> Ilia Mirkin comments that he's seen cases where it is not true. Anyway, it
> looks like this quirk should fix audio support for the majority of
> affected users.
> 
> This commit takes inspiration from an earlier patch by Daniel Drake.
> 
> Link: https://devtalk.nvidia.com/default/topic/1024022
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=75985
> Cc: Aaron Plattner <aplattner@nvidia.com>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Maik Freudenberg <hhfeuer@gmx.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/pci/quirks.c    | 28 ++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> Submitting Lukas's patch from over a year ago.
> 
> It got held up before on patch dependencies (which are now all merged)
> and also the concern around the device class assumption not being true
> in all cases. However, there hasn't been any progress towards finding a
> better approach, and we don't have any logs to hand from the cases where
> this isn't true, so I think we should go with this approach which will
> work in the (vast?) majority of cases.
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0f16acc323c6..52046b517e2e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4971,6 +4971,34 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  
> +/*
> + * Many laptop BIOSes hide the integrated HDA controller on NVIDIA GPUs
> + * via a special bit. This prevents Linux from seeing and using it.
> + * Unhide it here.
> + * https://devtalk.nvidia.com/default/topic/1024022
> + */
> +static void quirk_nvidia_hda(struct pci_dev *gpu)
> +{
> +	u8 hdr_type;
> +	u32 val;
> +
> +	/* there was no integrated HDA controller before MCP89 */
> +	if (gpu->device < PCI_DEVICE_ID_NVIDIA_GEFORCE_320M)
> +		return;
> +
> +	/* bit 25 at offset 0x488 hides or exposes the HDA controller */
> +	pci_read_config_dword(gpu, 0x488, &val);
> +	pci_write_config_dword(gpu, 0x488, val | BIT(25));
> +
> +	/* the GPU becomes a multifunction device when the HDA is exposed */
> +	pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
> +	gpu->multifunction = !!(hdr_type & BIT(7));
> +}
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
> +DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
> +
>  /*
>   * Some IDT switches incorrectly flag an ACS Source Validation error on
>   * completions for config read requests even though PCIe r4.0, sec
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..66898463b81f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1336,6 +1336,7 @@
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS    0x0752
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE       0x0759
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS     0x07D8
> +#define PCI_DEVICE_ID_NVIDIA_GEFORCE_320M           0x08A0
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA	    0x0D85
>  
> -- 
> 2.20.1
> 
