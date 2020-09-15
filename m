Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7D26AEC1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 22:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgIOUhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 16:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgIOUgq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 16:36:46 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDFA20809;
        Tue, 15 Sep 2020 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600202205;
        bh=hR+9QjiQFWyN2W2Y/im5/MlPYRdRGdyGzHGLrBYVxBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JE3/C4Chwu15czXYlspesWnGolV8kaWR0831erUbBU6KMwFGI9HEcSxwrT2fEchX/
         aH7DsB03ZoxxNTB6AFhAicVG8k2Qq+3lSHOjCNiowrOwZSFwpCSePmmJqh7CqYm/GG
         QNRk344P7vVfAx95w7iafmfFd66O5gfB5yqe2rV0=
Date:   Tue, 15 Sep 2020 15:36:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Qiao <mqiao@juniper.net>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Debjit Ghosh <dghosh@juniper.net>,
        Santhanakrishnan Balraj <sbalraj@juniper.net>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 1/3] PCI: Add quirks for Juniper FPGAs to set class code
Message-ID: <20200915203643.GA1426328@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200915151103.7086-1-mqiao@juniper.net>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 08:11:01AM -0700, Ming Qiao wrote:
> Some of the Juniper FPGAs do not report correct PCI class ID, which
> would confuse kernel APIs accessing the specific class of devices.
> Change them to PCI_CLASS_SYSTEM_OTHER << 8.

Please include a note about the consequence of the incorrect class ID,
i.e., what happens without this quirk?  Does the system panic?  Does
some device not work correctly?  If so, which, and what does the
problem look like to a user?

"Confusing kernel APIs" is pretty general and won't help a user who is
seeing a problem to find this patch.

> Also introduce Juniper vendor ID to be used in the quirks.
>     
> Signed-off-by: Debjit Ghosh <dghosh@juniper.net>
> Signed-off-by: Santhanakrishnan Balraj <sbalraj@juniper.net>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Signed-off-by: Ming Qiao <mqiao@juniper.net>
> ---
>  drivers/pci/quirks.c    | 25 +++++++++++++++++++++++++
>  include/linux/pci_ids.h |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2a589b6..61344d2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5632,3 +5632,28 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +/*
> + * PCI class reported by some Juniper FPGAs is not correct.
> + * Change it to SYSTEM.
> + */
> +static void quirk_jnx_fpga(struct pci_dev *dev)
> +{
> +	if (!dmi_match(DMI_BOARD_VENDOR, "Juniper Networks Inc."))
> +		return;

Why is the DMI_BOARD_VENDOR relevant to this quirk?  This check seems
to mean that the class code is programmable by the BIOS, and all
BIOSes program it correctly *except* the Juniper BIOS.

If this is just a silicon defect in the chips, you shouldn't need to
check the DMI_BOARD_VENDOR.

> +	dev->class = PCI_CLASS_SYSTEM_OTHER << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0004, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006A, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006B, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006C, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x006E, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0079, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0083, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0071, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A7, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A8, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A9, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00AA, quirk_jnx_fpga);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x0505, quirk_jnx_fpga);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1ab1e24..bfbf8f1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1859,6 +1859,8 @@
>  #define PCI_VENDOR_ID_ESDGMBH		0x12fe
>  #define PCI_DEVICE_ID_ESDGMBH_CPCIASIO4 0x0111
>  
> +#define PCI_VENDOR_ID_JUNIPER		0X1304

Please use "0x1304" (lower-case 'x') like the rest of the file.

>  #define PCI_VENDOR_ID_CB		0x1307	/* Measurement Computing */
>  
>  #define PCI_VENDOR_ID_SIIG		0x131f
> -- 
> 2.10.0
> 
