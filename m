Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8C29DA04
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 00:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJ1XKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 19:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbgJ1XJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 19:09:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB91BC0613CF;
        Wed, 28 Oct 2020 16:09:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w25so1256509edx.2;
        Wed, 28 Oct 2020 16:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YoJO1zoQ5E1C2GRnvBh7fUEKY8vwjJF0oG7GALEVY0=;
        b=oRtUjZ5CnjY/48rMe/NEbC0601bsZl2A3wiNu2a5e7ToPMOCvBJ6ZgV5Nnj7FjF9ca
         o91eqOwvIAhK62mVawC1oOOoQ4WHz+UhbGDXqoxTP3dKTGZagY1UmjHfbadg7kneq9fV
         HL2B/sCLF5RILV/VLiEmSBX5KpXtdacWuJTmacD+IBENgjwhr7D5LuwxrLLvRuxX9I5k
         UxuI7nDGj2nYhNk3Kf5zWcefDTPC7WfKYbJQfJmbHk5PAuz2TyLMJVz97870kZPH/Ku4
         TMthHDKuEIBysoI6ERyDlabriQPvblnUKUZ8gGPC+WuwBZDD9eXlRuLzyUZT9HsD5siV
         qTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YoJO1zoQ5E1C2GRnvBh7fUEKY8vwjJF0oG7GALEVY0=;
        b=O2AaW5kBHtM/3FzY+CUq89YG6QNsiuRHNayoZDTQAPieCBo+TxV/Q0/WnoMwS6b5W7
         YxEtNNqQ77nGi6nQRvNDsP8i/mRiSyEe4ZNi13WziCKtXGHsRUXIQEnYvZ3YbmsGJvFY
         owOjbLrFszyl8oCpeLsEJUppc8NKyQeKxnv9t/umiogNZY/5HIIoyAEsAMPaIym7NFjA
         mMkG2FV0vXNC9iOjRicUqxgkZILoy8H8S9VDb9VDpFUiXGMUIivczwueC0pfwQYh6gV9
         ia8cwkj+I35GxcH5TkzpzI0P6xQUjk1YvcliGq1TyIoDrZWP+acCySzT/KP55Ju+rTkA
         gX+w==
X-Gm-Message-State: AOAM532FVUGLBQ4UPQBTWoh4jJbMHYxciM8qVfIOw9WkbSCZbHDeg59z
        zRZ/bFSsdN9Vb5qnIc/gC7t53gOlKMHvVOZkm/UEyKbB
X-Google-Smtp-Source: ABdhPJz/XdXPZQG2al+e93iYeU7FlDTVMkVZqwrN8THHCzKQKJGNYLdlNSwY15TF9tKU+QJldfXC1xAqf9a/oTiS6Q4=
X-Received: by 2002:aa7:cd42:: with SMTP id v2mr5902125edw.151.1603863789273;
 Tue, 27 Oct 2020 22:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com> <3cb6923f879b64a80df3670facdee327bcc39a4c.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3cb6923f879b64a80df3670facdee327bcc39a4c.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 28 Oct 2020 13:42:57 +0800
Message-ID: <CAKF3qh0WccKyNa9hGK7g+F9eZ_jE9UK-WqUb1EOrz+_Hz2ceAg@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] PCI/DPC: Move AER/DPC dependency checks out of
 DPC driver
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, knsathya@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 11:12 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Currently, AER and DPC Capabilities dependency checks is
> distributed between DPC and portdrv service drivers. So move
> them out of DPC driver.
>
> Also, since services & PCIE_PORT_SERVICE_AER check already
> ensures AER native ownership, no need to add additional
> pcie_aer_is_native() check.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/dpc.c          | 4 ----
>  drivers/pci/pcie/portdrv_core.c | 1 +
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 21f77420632b..a8b922044447 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -283,14 +283,10 @@ void pci_dpc_init(struct pci_dev *pdev)
>  static int dpc_probe(struct pcie_device *dev)
>  {
>         struct pci_dev *pdev = dev->port;
> -       struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
>         struct device *device = &dev->device;
>         int status;
>         u16 ctl, cap;
>
> -       if (!pcie_aer_is_native(pdev) && !host->native_dpc)
> -               return -ENOTSUPP;
> -
>         status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>                                            dpc_handler, IRQF_SHARED,
>                                            "pcie-dpc", pdev);
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e257a2ca3595..ffa1d9fc458e 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -252,6 +252,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>          * permission to use AER.
>          */
>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> +           host->native_dpc &&
What hell the logic is here ?
>             (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
>                 services |= PCIE_PORT_SERVICE_DPC;
>
> --
> 2.17.1
>
