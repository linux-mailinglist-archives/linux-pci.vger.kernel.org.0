Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79F73398DE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 22:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhCLVJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 16:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235126AbhCLVJT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 16:09:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA06264EF2;
        Fri, 12 Mar 2021 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615583359;
        bh=2N2ztC788SQbCuYFCkp/J92j6XWqG+f7aPQnOJz6HRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kYCX8BFCWc0ElvYGsar6D0FWraDj7ShI/F7iOE2Fibe1ZawhE9OKCO3pWvVf952ls
         HDWgBXW2knX459ELgJ8G04RcsviPo/bzvOQJo5Y0VtyzCS0Q1wFHU5QR5o9azg8oXj
         J+OuKE68FD/FhYoSZoTmj/9ECqBjPbPxfh/O0sq/3WCFNSCSMHaM4TwJpb324Ab7aS
         V6+nU0Za7SiThxxECORekb04lVcQv7WrG/9S63k9ihrfSIwDl90atM7y4gDzrkYzN7
         cAz4t4wY13XDSnzFPX93qkS7Zo1y/ej+8cCzNI6j+qTYegGuHB1wB286O/Q2odX738
         ihtdL9+VXVnJQ==
Date:   Fri, 12 Mar 2021 15:09:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Antti =?iso-8859-1?Q?J=E4rvinen?= <antti.jarvinen@gmail.com>
Cc:     kw@linux.com, alex.williamson@redhat.com, bhelgaas@google.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH v3] PCI: Add quirk for preventing bus reset on TI C667X
Message-ID: <20210312210917.GA2290948@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308142130.13835-1-antti.jarvinen@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 08, 2021 at 02:21:30PM +0000, Antti Järvinen wrote:
> Some TI KeyStone C667X devices do no support bus/hot reset. Its PCIESS
> automatically disables LTSSM when secondary bus reset is received and
> device stops working. Prevent bus reset by adding quirk_no_bus_reset to
> the device. With this change device can be assigned to VMs with VFIO,
> but it will leak state between VMs.

s/do no/do/not/ (also in the comment below)

Does the user get any indication of this leaking state?  I looked
through drivers/vfio and drivers/pci, but I haven't found anything
yet.

We *could* log something in quirk_no_bus_reset(), but that would just
be noise for people who don't pass the device through to a VM.  So
maybe it would be nicer if we logged something when we actually *do*
pass it through to a VM.

> Reference: https://e2e.ti.com/support/processors/f/791/t/954382
> Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>
> ---
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..d9201ad1ca39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3578,6 +3578,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Some TI keystone C667X devices do no support bus/hot reset.
> + * Its PCIESS automatically disables LTSSM when secondary bus reset is
> + * received and device stops working. Prevent bus reset by adding
> + * quirk_no_bus_reset to the device. With this change device can be
> + * assigned to VMs with VFIO, but it will leak state between VMs.
> + * Reference https://e2e.ti.com/support/processors/f/791/t/954382
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> -- 
> 2.17.1
> 
