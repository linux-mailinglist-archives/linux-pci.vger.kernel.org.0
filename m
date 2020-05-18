Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6F1D7E21
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgERQRd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgERQRc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 12:17:32 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA30620674;
        Mon, 18 May 2020 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589818652;
        bh=XB/B+9zvgTsxmyJTw4E10L0fguAxY0K2vJdLZLrdDg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rI+OCKABY1RtM5Iapf5PUmsHElocmd3D7XE6AalocUBvr6f6moPi9b0Xu9lPOxNKz
         eQbS7kd2LrvrQREDuaZJzlQfq8lhSoMmMEz0QbpQMLz8ZRDOJR2mhQM16W7BD7/I6X
         WkAZ5B6VlAdWyPT+HAyNv7N9Lp8ipTdMc1PcFA+Y=
Date:   Mon, 18 May 2020 11:17:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marcos Scriven <marcos@scriven.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Matisse HD Audio and USB
 Controllers
Message-ID: <20200518161730.GA933080@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Sat, May 16, 2020 at 02:37:23PM +0100, Marcos Scriven wrote:
> This patch fixes an FLR bug on the following two devices:
> 
> AMD Matisse HD Audio Controller 0x1487
> AMD Matisse USB 3.0 Host Controller 0x149c
> 
> As there was already such a quirk for an Intel network device, I have
> renamed that method and updated the comments, trying to make it
> clearer what the specific original devices that were affected are
> (based on the commit message this was original done:
> https://git.thm.de/mhnn55/eco32-linux-ba/commit/f65fd1aa4f9881d5540192d11f7b8ed2fec936db).
> 
> I have ordered them by hex product ID.
> 
> I have verified this works on a X570 I AORUS PRO WIFI (rev. 1.0) motherboard.

If we avoid FLR, is there another method used to reset these devices
between attachments to different VMs?  Does the lack of FLR mean we
can leak information between VMs?

Would additional delay after the FLR work around this, e.g., something
like 51ba09452d11 ("PCI: Delay after FLR of Intel DC P3700 NVMe")?

> From 651176ab164ae51e37d5bb86f5948da558744930 Mon Sep 17 00:00:00 2001
> From: Marcos Scriven <marcos@scriven.org>
> Date: Sat, 16 May 2020 14:23:26 +0100
> Subject: [PATCH] PCI: Avoid FLR for:
> 
>     AMD Matisse HD Audio Controller 0x1487
>     AMD Matisse USB 3.0 Host Controller 0x149c
> 
> These devices advertise a Function Level Reset (FLR) capability, but hang
> when an FLR is triggered.
> 
> To reproduce the problem, attach the device to a VM, then detach and try to
> attach again.
> 
> Add a quirk to prevent the use of FLR on these devices.
> 
> Signed-off-by: Marcos Scriven <marcos@scriven.org>
> ---
>  drivers/pci/quirks.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 28c9a2409c50..ff310f0cac22 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5129,13 +5129,23 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> 
> -/* FLR may cause some 82579 devices to hang */
> -static void quirk_intel_no_flr(struct pci_dev *dev)
> +/*
> + * FLR may cause the following to devices to hang:
> + *
> + * AMD Starship/Matisse HD Audio Controller 0x1487
> + * AMD Matisse USB 3.0 Host Controller 0x149c
> + * Intel 82579LM Gigabit Ethernet Controller 0x1502
> + * Intel 82579V Gigabit Ethernet Controller 0x1503
> + *
> + */
> +static void quirk_no_flr(struct pci_dev *dev)
>  {
>      dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
>  }
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> 
>  static void quirk_no_ext_tags(struct pci_dev *pdev)
>  {
> --
> 2.25.1
