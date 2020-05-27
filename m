Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1001E5089
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgE0Vbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 17:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0Vbj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 17:31:39 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F92A2078C;
        Wed, 27 May 2020 21:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590615098;
        bh=ODFlY6KQgpoTYU1ZnScrTHYby+sOsr1ta5nn0XOdqew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iA07Bxp1yIyJyDem28voLJHTwMkhDrHkIoC5+mipPLYfeVVJtO1KYlMEIjmEAqdJh
         rPKYeoFnB6QJLXI4+uX9yY8ynfBmHq0/TCM4GqEj5tc1ivfRvS+DrLMlmLdxgO5zpH
         ZPGVPZ9wnaIL24bbNXVv8U6ksKye2S8Rx+3hZVpU=
Date:   Wed, 27 May 2020 16:31:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kevin Buettner <kevinb@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Message-ID: <20200527213136.GA265655@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524003529.598434ff@f31-4.lan>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex D, Christian -- do you guys have any contacts or insight
into why we suddenly have three new AMD devices that advertise FLR
support but it doesn't work?  Are we doing something wrong in Linux,
or are these devices defective?

https://lore.kernel.org/r/20200524003529.598434ff@f31-4.lan
  AMD Starship USB 3.0 host controller
https://lore.kernel.org/r/CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com
  AMD Matisse HD Audio & USB 3.0 host controller
]

On Sun, May 24, 2020 at 12:35:29AM -0700, Kevin Buettner wrote:
> This commit adds an entry to the quirk_no_flr table for the AMD
> Starship USB 3.0 host controller.
> 
> Tested on a Micro-Star International Co., Ltd. MS-7C59/Creator TRX40
> motherboard with an AMD Ryzen Threadripper 3970X.
> 
> Without this patch, when attempting to assign (pass through) an AMD
> Starship USB 3.0 host controller to a guest OS, the system becomes
> increasingly unresponsive over the course of several minutes,
> eventually requiring a hard reset.
> 
> Shortly after attempting to start the guest, I see these messages:
> 
> May 23 22:59:46 mesquite kernel: vfio-pci 0000:05:00.3: not ready 1023ms after FLR; waiting
> May 23 22:59:48 mesquite kernel: vfio-pci 0000:05:00.3: not ready 2047ms after FLR; waiting
> May 23 22:59:51 mesquite kernel: vfio-pci 0000:05:00.3: not ready 4095ms after FLR; waiting
> May 23 22:59:56 mesquite kernel: vfio-pci 0000:05:00.3: not ready 8191ms after FLR; waiting
> 
> And then eventually:
> 
> May 23 23:01:00 mesquite kernel: vfio-pci 0000:05:00.3: not ready 65535ms after FLR; giving up
> May 23 23:01:05 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
> May 23 23:01:06 mesquite kernel: perf: interrupt took too long (642744 > 2500), lowering kernel.perf_event_max_sample_rate to 1000
> May 23 23:01:07 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 82.270 msecs
> May 23 23:01:08 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 680.608 msecs
> May 23 23:01:08 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler) took too long to run: 100.952 msecs
> ...
>  kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]
> May 23 23:01:25 mesquite kernel: watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]
> 
> The above log snippets were obtained using the aforementioned hardware
> running Fedora 32 w/ kernel package kernel-5.6.13-300.fc32.x86_64.  My
> fix was applied to a local copy of the F32 kernel package, then
> rebuilt, etc.
> 
> With this patch in place, the host kernel doesn't exhibit these
> problems.  The guest OS (also Fedora 32) starts up and works as
> expected with the passed-through USB host controller.
> 
> Signed-off-by: Kevin Buettner <kevinb@redhat.com>

Applied to pci/virtualization for v5.8, thanks!

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 43a0c2ce635e..b1db58d00d2b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5133,6 +5133,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   * FLR may cause the following to devices to hang:
>   *
>   * AMD Starship/Matisse HD Audio Controller 0x1487
> + * AMD Starship USB 3.0 Host Controller 0x148c
>   * AMD Matisse USB 3.0 Host Controller 0x149c
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
> @@ -5143,6 +5144,7 @@ static void quirk_no_flr(struct pci_dev *dev)
>  	dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> 
