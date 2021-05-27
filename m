Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12483938EB
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 01:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhE0XI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 19:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233785AbhE0XI6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 19:08:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAEE6613D4;
        Thu, 27 May 2021 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622156845;
        bh=FJVFCV2BVexF7kU9ZsvcUCC/p+ZnJc+60umJjHl2NzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mu+WvH57NV5HSik4JdRRtfHkisWDV3Fdc7ZPczXQrAXUQRbYGQ4v0ukxr2cV6x+0y
         u3dbvndOwTgyIXWD6km0S9vJbJsb6rD7GZAJq30d+VvvXRz22B8G0HKVTzgBaD717M
         3CA3Tn6e1DYQFsFQWLQwK4zj5kznkgVkVOW1tkd9/QXcfALDbm8boQnNSpZ5k7ACZM
         MHkqH4e3nncZIUwfOyUl1b5VcHO0sLBWO4qH6z7tJUXZEjboPV2tWy8xOGrWptLvDX
         g354bDShMk7nqVKXEO/80rfBfFSV6/1xb0Y7j/hZV361n5r2uOWnjc2jlX++I69s/s
         9o82bR+aw6FYQ==
Date:   Thu, 27 May 2021 18:07:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Antti =?iso-8859-1?Q?J=E4rvinen?= <antti.jarvinen@gmail.com>
Cc:     alex.williamson@redhat.com, bhelgaas@google.com, kishon@ti.com,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH v4] PCI: Add quirk for preventing bus reset on TI C667X
Message-ID: <20210527230723.GA1441318@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315102606.17153-1-antti.jarvinen@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 15, 2021 at 10:26:06AM +0000, Antti Järvinen wrote:
> Some TI KeyStone C667X devices do not support bus/hot reset. Its PCIESS
> automatically disables LTSSM when secondary bus reset is received and
> device stops working. Prevent bus reset by adding quirk_no_bus_reset to
> the device. With this change device can be assigned to VMs with VFIO,
> but it will leak state between VMs.
> 
> Reference: https://e2e.ti.com/support/processors/f/791/t/954382
> Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>

Applied to pci/virtualization for v5.14 with subject

  PCI: Mark TI C667X to avoid bus reset

Thanks!

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
