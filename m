Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC7AADE1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 23:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfIEVfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 17:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730485AbfIEVfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 17:35:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1536F206BB;
        Thu,  5 Sep 2019 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567719311;
        bh=v2fQCvGYm46BeRXfxC+1ZlpNLHHP4uol+ATDKOQNCzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZO6/FWDAr38eGqj49jBGMpzmVP61WBxI+2QqvGqfd1IZqmcbyuuPO3gsILOUyU/DE
         FOxbRK9SK/QY4HLGrd8IXExDR0WGslMq8R9/1Vi9Cuk1loxrhC5qznfOTeBk1D6tSe
         229BNm14HnaqpvX2AAkpQQyWPHbMEcG5zkSQmfTg=
Date:   Thu, 5 Sep 2019 16:35:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
Message-ID: <20190905213509.GI103977@google.com>
References: <20190827134756.10807-2-kai.heng.feng@canonical.com>
 <20190828180128.1732-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828180128.1732-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 29, 2019 at 02:01:28AM +0800, Kai-Heng Feng wrote:
> It's a common practice to let dGPU unbound and use PCI platform power
> management to disable its power through _OFF method of power resource,
> which is listed by _PR3.
> When the dGPU comes with an HDA function, the HDA won't be suspended if
> the dGPU is unbound, so the power resource can't be turned off.

I'm not involved in applying this patch, but from the peanut gallery:

  - The above looks like it might be two paragraphs missing a blank
    line between?  Or maybe it's one paragraph that needs to be
    rewrapped?

  - I can't parse the first sentence.  I guess "dGPU" and "HDA" are
    hardware devices, but I don't know what "unbound" means.  Is that
    something to do with a driver being bound to the dGPU?  Or is it
    some connection between the dGPU and the HDA?

  - "PCI platform power management" is still confusing -- I think we
    either have "PCI power management" that uses the PCI PM Capability
    (i.e., writing PCI_PM_CTRL as in pci_raw_set_power_state()) OR we
    have "platform power management" that uses some other method,
    typically ACPI.  Since you refer to _OFF and _PR3, I guess you're
    referring to platform power management here.

  - "It's common practice to let dGPU unbound" -- does that refer to
    some programming technique common in drivers, or some user-level
    thing like unloading a driver, or ...?  My guess is it probably
    means "unbind the driver from the dGPU" but I still don't know
    what makes it common practice.

This probably all makes perfect sense to the graphics cognoscenti, but
for the rest of us there are a lot of dots here that are not
connected.

> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime-suspended once GPU is
> bound, to keep APU's HDA working.
> 
> However, HDA on dGPU isn't that useful if dGPU is unbound. So let's
> relax the runtime suspend requirement for dGPU's HDA function, to save
> lots of power.
> 
> BugLink: https://bugs.launchpad.net/bugs/1840835
> Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers”)
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Change wording.
> - Rebase to Tiwai's branch.
> 
>  sound/pci/hda/hda_intel.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 91e71be42fa4..c3654d22795a 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1284,7 +1284,11 @@ static void init_vga_switcheroo(struct azx *chip)
>  		dev_info(chip->card->dev,
>  			 "Handle vga_switcheroo audio client\n");
>  		hda->use_vga_switcheroo = 1;
> -		chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
> +
> +		/* cleared in either gpu_bound op or codec probe, or when its
> +		 * root port has _PR3 (i.e. dGPU).
> +		 */
> +		chip->bus.keep_power = !pci_pr3_present(p);
>  		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>  		pci_dev_put(p);
>  	}
> -- 
> 2.17.1
> 
