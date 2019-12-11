Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7151A119FC6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 01:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfLKAJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 19:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfLKAJf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 19:09:35 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27015206D9;
        Wed, 11 Dec 2019 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576022974;
        bh=qEHIoLuedXqsVTSU6OyFX22i8JLpQUFxE029keZcpZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hb3fitBB2ovfRLMOKZw/bTjTlcdtBAh84dfDYhl78MGbfVEr938Jh5LZnbS1bYeLT
         M6iKaI6e658ky66EQBVziaV6W546JR+bBaCNrz0rAwfzMzIHZz/RTA4vQgRTqQYveX
         YomgKQMv3eXqFpyUlb33kfyAY/k7qUYfbJ5k3y8c=
Date:   Tue, 10 Dec 2019 18:09:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
Message-ID: <20191211000932.GA178707@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115135842.119621-1-wei.liu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
> CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> in.  Removing the ifdef will allow us to build the driver as a module.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Alternatively, we can change the condition to:
> 
>   #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
> .
> 
> I chose to remove the ifdef because that's what other quirks looked like
> in this file.
> ---
>  drivers/pci/quirks.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..cd0e7c18e717 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2381,7 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>  			 PCI_DEVICE_ID_TIGON3_5719,
>  			 quirk_brcm_5719_limit_mrrs);
>  
> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
>  static void quirk_paxc_bridge(struct pci_dev *pdev)
>  {
>  	/*
> @@ -2405,7 +2404,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> -#endif

Is there a reason this quirk can't be moved to
drivers/pci/controller/pcie-iproc-platform.c?  That would make it much
less subtle because it would be compiled if and only if the driver
itself is compiled.

If it needs to be here in quirks.c, please include a note about the
reason.

>  /*
>   * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
> -- 
> 2.24.0
> 
