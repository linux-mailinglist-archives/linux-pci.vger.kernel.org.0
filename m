Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE9136A38
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgAJJuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 04:50:11 -0500
Received: from mail1.perex.cz ([77.48.224.245]:48334 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgAJJuL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 04:50:11 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 04:50:09 EST
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 477EEA003F;
        Fri, 10 Jan 2020 10:43:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 477EEA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1578649413; bh=PWmIHEghTU1BU+I0q/9CNp37xpdRYOruF+56lY2aRWM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=veb+mi8NwaztLeFbSWAPaOm6BXPvetTynnMLIo9EGfHpV+sge99LmtWNxl/R+B9iO
         B7gTZ1be1tuUbY95XA8gP1L2eRsEnQhkQNYQVLyuRx9dNxmDFBrtbj0QQhhAHUCyWl
         jiJe+NRGULxb1NHmf3aSgqzrKErbm2GY+2rs3maM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri, 10 Jan 2020 10:43:27 +0100 (CET)
Subject: Re: [alsa-devel] [PATCH v6 2/2] ALSA: hda: Allow HDA to be runtime
 suspended when dGPU is not bound to a driver
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        tiwai@suse.com
Cc:     linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20191018073848.14590-1-kai.heng.feng@canonical.com>
 <20191018073848.14590-2-kai.heng.feng@canonical.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <10e35320-b7a8-0bcf-92d1-61aa5c057f58@perex.cz>
Date:   Fri, 10 Jan 2020 10:43:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191018073848.14590-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dne 18. 10. 19 v 9:38 Kai-Heng Feng napsal(a):
> Nvidia proprietary driver doesn't support runtime power management, so
> when a user only wants to use the integrated GPU, it's a common practice
> to let dGPU not to bind any driver, and let its upstream port to be
> runtime suspended. At the end of runtime suspension the port uses
> platform power management to disable power through _OFF method of power
> resource, which is listed by _PR3.
> 
> After commit b516ea586d71 ("PCI: Enable NVIDIA HDA controllers"), when
> the dGPU comes with an HDA function, the HDA won't be suspended if the
> dGPU is unbound, so the power resource can't be turned off by its
> upstream port driver.
> 
> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime suspended once GPU is
> bound, to keep APU's HDA working.
> 
> However, HDA on dGPU isn't that useful if dGPU is not bound to any
> driver.  So let's relax the runtime suspend requirement for dGPU's HDA
> function, to disable the power source to save lots of power.

This patch breaks the HDMI audio detection at least on some platforms (Lenovo 
P50 for example) with nouveau and the proprietary nvidia driver. Those laptops 
have the external HDMI/DP ports connected to dGPU instead the iGPU. The ACPI 
PR3 is set.

The runtime PM off fixes this problem:

echo on > /sys/bus/pci/devices/0000\:01\:00.1/power/control

But I don't think that it's the best solution. My proposal is to create a pr3 
check blacklist to keep power for the HDMI audio for those machines. Also we 
may add a new module parameter for snd-hda-intel to control this. Other ideas?

					Jaroslav


> BugLink: https://bugs.launchpad.net/bugs/1840835
> Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v5, v6:
> - No change.
> v4:
> - Find upstream port, it's callee's responsibility now.
> v3:
> - Make changelog more clear.
> v2:
> - Change wording.
> - Rebase to Tiwai's branch.
>   sound/pci/hda/hda_intel.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 240f4ca76391..e63b871343e5 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1280,11 +1280,17 @@ static void init_vga_switcheroo(struct azx *chip)
>   {
>   	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
>   	struct pci_dev *p = get_bound_vga(chip->pci);
> +	struct pci_dev *parent;
>   	if (p) {
>   		dev_info(chip->card->dev,
>   			 "Handle vga_switcheroo audio client\n");
>   		hda->use_vga_switcheroo = 1;
> -		chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
> +
> +		/* cleared in either gpu_bound op or codec probe, or when its
> +		 * upstream port has _PR3 (i.e. dGPU).
> +		 */
> +		parent = pci_upstream_bridge(p);
> +		chip->bus.keep_power = parent ? !pci_pr3_present(parent) : 1;
>   		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>   		pci_dev_put(p);
>   	}
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
