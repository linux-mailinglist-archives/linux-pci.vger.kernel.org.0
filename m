Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651EF481E12
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbhL3Q24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Dec 2021 11:28:56 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:38755 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhL3Q24 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Dec 2021 11:28:56 -0500
Received: by mail-qt1-f180.google.com with SMTP id 8so22141378qtx.5;
        Thu, 30 Dec 2021 08:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=594xPajnx1lQ2Gq+QQhoW7EPw32DH5yt64jS4MfoP8Q=;
        b=X2DgoHHdh4uWuiFTWgrYzyNYwpnnEoDiNVX7kC76tHs6Dyzx+zbHgKiGhTBZQqJimX
         RIHQKKg80/i58M1Bsy4qnywxdl3tt1IKptd7DKTg3R1ITqXEuhWgvOYT8fMg5kU9EFeg
         nrgK37chFklaFOITZayQRISMhv+//q8grxKGZdGu4ji9H47HjB9HVb1HTZ7nj9/8esDq
         49yaW5lgBXd2VbE4iiJRAyiAIXVoTxVsNaNvsRdPo7THApo4gbo9dorMMfayICulQWZL
         5Dnd0HI+CsTk7xEYiwi1HK3EaON5O7taH00B27vSgxUwwFGLcFm1tUEcQOTFSZwrHcH5
         flsQ==
X-Gm-Message-State: AOAM530NT5q8QQrqSqUDcJL1Iz1po1hLvkx/3J2gvcSzwjdirqnkWFwq
        /7DWQoYEXw6ysjaGYY+Bs0OY3U4b56xWKE3Nk5Jf7FSJ
X-Google-Smtp-Source: ABdhPJx1pG/geFzyTx2rrs7JE51T0xN/ij5gLcEYrADz0jW4p2FFp+l9lNnuSXYW2NeaAY/EUHQlXZnmTcqzKqbNpe8=
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr26831737qta.305.1640881725489;
 Thu, 30 Dec 2021 08:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20211223022856.27822-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20211223022856.27822-1-yang.lee@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:28:34 +0100
Message-ID: <CAJZ5v0h4u6+4N5ZBSu6CRKn4GCBPgPHC_5-crzULozhzCTCh6w@mail.gmail.com>
Subject: Re: [PATCH -next] PCI/ACPI: Fix acpi_pci_osc_control_set() kernel-doc comment
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 23, 2021 at 3:29 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Add the description of @support and remove @req in
> acpi_pci_osc_control_set() kernel-doc comment to remove warnings found
> by running scripts/kernel-doc, which is caused by using 'make W=1'.
>
> drivers/acpi/pci_root.c:337: warning: Excess function parameter 'req'
> description in 'acpi_pci_osc_control_set'
> drivers/acpi/pci_root.c:337: warning: Function parameter or member
> 'support' not described in 'acpi_pci_osc_control_set'
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 6bc779ee05d4 ("PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/acpi/pci_root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 41a8fef06534..084916604f3c 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>   * acpi_pci_osc_control_set - Request control of PCI root _OSC features.
>   * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
>   * @mask: Mask of _OSC bits to request control of, place to store control mask.
> - * @req: Mask of _OSC bits the control of is essential to the caller.
> + * @support: _OSC supported capability.
>   *
>   * Run _OSC query for @mask and if that is successful, compare the returned
>   * mask of control bits with @req.  If all of the @req bits are set in the
> --

Applied as 5.17 material, thanks!
