Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10432A24C9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 07:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgKBG2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 01:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBG2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 01:28:01 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E6C0617A6;
        Sun,  1 Nov 2020 22:28:01 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id w25so13230539edx.2;
        Sun, 01 Nov 2020 22:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykkvRrLGzz7yMDDHouHR6O5hFBvln1COnvhZIJyck9Y=;
        b=PwmzWFKWGJJqk742eS4zmrsFiJPHCWdFEB21QLrd+Oz3IRHTPnzZyvy4PgYxoKHt4y
         9rE47Ya4+lUZKT8bmKLhlMygQq67IEs3yBvtfgATOxgiN7mDYpE7hNWLiGJgRUTsR3DM
         GWd0TnruemK3FgnMhNBjjkJ6tGENwhNmnrUhilf7CgD7WodryA6itasUaGHXkbL1I4sb
         7W4gIaP5e9U/asQ4ntjQj+Sg64523ON2Pa26p400Om6gMUYxF+4Jv7833t4J8WzH4HIX
         NtDnJhxQs25epoKu9VL07xZeufHrCWuBT8o1oYkwC8VlmhuqjddyUKUa7Q62Ja5i7tRy
         qPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykkvRrLGzz7yMDDHouHR6O5hFBvln1COnvhZIJyck9Y=;
        b=hD/xmlmdgZqNA2wSMdHLvKX1jIRo5J2XnoaagrkmaQ2Zkr59GsfIQuekhwwqCJphds
         l20Fzc41YxQa2Dj7JCn0GjiklBrcFRjTMA4e7LSuqfGrKdg4Z/zQ3cIFq1QZJzfOsrvP
         TzOqXCnYPeZMhWzfw5WF6KpNZLELmsg8PStiq5SAGiqKYPmr6hpZotPGEAeKHScmifc0
         7KrwrRPpS16T//AHEPyXNmpefE6bD4TGupNX6IC5aChTmbCvuastmVkvXQTZ+ND0g2Ca
         2dJTSv1T2KhhlkoVHUo0C7InmkJi2dkgpXTgcffnm1PApOeVnqDaeuDFRYh5fuxSTERs
         h3aw==
X-Gm-Message-State: AOAM5336STEBv3NTzx+VidwEeJCRQHl6gVfc+v8w/tmIEjwumLrzDFGA
        utm6fbghbCAAJEEsgu6aEJFzDFt3nO8BdfCI+js=
X-Google-Smtp-Source: ABdhPJyZBFlhUTtPi+C1pzaZxAVFw8V/x/K4iPT1u5TVfVsHBF/ZDnDBwr0WfymVVKxgiTbipmFz0xnnvPhfPVdtoZo=
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr15629682edt.13.1604298479700;
 Sun, 01 Nov 2020 22:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20201030223443.165783-1-sean.v.kelley@intel.com>
In-Reply-To: <20201030223443.165783-1-sean.v.kelley@intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Mon, 2 Nov 2020 14:27:48 +0800
Message-ID: <CAKF3qh3H6daTZtWLj=RjEFoaWazVCvQ=svGO2wGm84K7cnwv_g@mail.gmail.com>
Subject: Re: [PATCH] AER: aer_root_reset() non-native handling
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, Ashok Raj <ashok.raj@intel.com>,
        tony.luck@intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        qiuxu.zhuo@intel.com, linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 31, 2020 at 6:36 AM Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
> If an OS has not been granted AER control via _OSC, then
> the OS should not make changes to PCI_ERR_ROOT_COMMAND and
> PCI_ERR_ROOT_STATUS related registers. Per section 4.5.1 of
> the System Firmware Intermediary (SFI) _OSC and DPC Updates
> ECN [1], this bit also covers these aspects of the PCI
> Express Advanced Error Reporting. Further, the handling of
> clear/enable of PCI_ERROR_ROOT_COMMAND when wrapped around
> PCI_ERR_ROOT_STATUS should have no effect and be removed.
> Based on the above and earlier discussion [2], make the
> following changes:
>
> Add a check for the native case (i.e., AER control via _OSC)
> Re-order and remove some of the handling:
> - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
> - do reset
> - clear PCI_ERR_ROOT_STATUS
> - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>
> to this:
>
> - clear PCI_ERR_ROOT_STATUS
> - do reset
>
> The current "clear, reset, enable" order suggests that the reset
> might cause errors that we should ignore. But I am unable to find a
> reference and the clearing of PCI_ERR_ROOT_STATUS does not require them.
>
> [1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
>     2020, affecting PCI Firmware Specification, Rev. 3.2
>     https://members.pcisig.com/wg/PCI-SIG/document/14076
> [2] https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precision-5520/
>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..bbfb07842d89 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1361,23 +1361,14 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>         u32 reg32;
>         int rc;
>
> -
> -       /* Disable Root's interrupt in response to error messages */
> -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -       reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
There may be some reasons to disable interrupt first and then do resetting,
clear status and re-enable interrupt.
Perhaps to avoid error noise,  what would happen if the resetting
causes errors itself ?

Thanks,
Ethan

> +       if (pcie_aer_is_native(dev)) {
> +               /* Clear Root Error Status */
> +               pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +               pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +       }
>
>         rc = pci_bus_error_reset(dev);
> -       pci_info(dev, "Root Port link has been reset\n");
> -
> -       /* Clear Root Error Status */
> -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> -
> -       /* Enable Root Port's interrupt in response to error messages */
> -       pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -       reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -       pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +       pci_info(dev, "Root Port link has been reset (%d)\n", rc);
>
>         return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>  }
> --
> 2.29.2
>
