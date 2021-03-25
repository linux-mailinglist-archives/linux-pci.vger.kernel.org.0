Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968FA349813
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 18:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYRcN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 13:32:13 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:41740 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhCYRcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 13:32:05 -0400
Received: by mail-oo1-f43.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so668049ooq.8;
        Thu, 25 Mar 2021 10:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xuZBu7t355xp5A0ktaMTNGylazSc/RGyM1j62jiftE=;
        b=pJSlCUTHnQ6W016mIT2oYm8duCDWqc0116ILIOJ0TdQXJojzozLTIu1BrUfHb3qRBY
         w/C4DMFn7RiSyHh4I5jt+YG5gpE7Yg6SDSOpGWXR1KqXxlcYIW32XdN+HKV7xFACT7eG
         IlkJ2nPdHbhPQiglNGwl18k33tBOI1FO0awdfM/t1wQd80b6U+snSEfAgNeIgL6sEeYn
         FFms4htepA6o3PhhCpxx+K5EmDD8gjl48sme8D/Flp4u+wWSJw3g/gmoyxk9BMiq4F5z
         Yslg5pRWzLUd6VUJ4VWKHAjkuuO4P9HkeRhatf2WW5tHUZeV8ZbGSXNUhet9izzSXwEg
         DRiA==
X-Gm-Message-State: AOAM533QensUMhFGZxMAFOAHkKksb+h0WAX0WPriYG3HUZMAu12b/p85
        Z4H+Zxp06cv8z43fWnwSChtGsGEzJYWM1+iUedorvlNc
X-Google-Smtp-Source: ABdhPJx4nz68EC0k6lTCaykEFi9YP/IHHGwiCHBP/DK98UGXv5oxC7ePNuC3vhMeunrfsBXd7mCTsf+IhUEUaAJy3PY=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr8076036oou.44.1616693525251;
 Thu, 25 Mar 2021 10:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210325075144.180030-1-wangxiongfeng2@huawei.com> <20210325075144.180030-2-wangxiongfeng2@huawei.com>
In-Reply-To: <20210325075144.180030-2-wangxiongfeng2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Mar 2021 18:31:54 +0100
Message-ID: <CAJZ5v0gUOxz7hk42MM4U_vbiTAf2Jgk3WKfWcz9LdHskdiuySg@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: acpi_pcihp: Correct acpi_pci_check_ejectable()
 function name in the header
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, ruscur@russell.cc,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 8:50 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/pci/hotplug/acpi_pcihp.c:167: warning: expecting prototype for acpi_pcihp_check_ejectable(). Prototype was for acpi_pci_check_ejectable() instead
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/pci/hotplug/acpi_pcihp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
> index 2750a64cecd3..4fedebf2f8c1 100644
> --- a/drivers/pci/hotplug/acpi_pcihp.c
> +++ b/drivers/pci/hotplug/acpi_pcihp.c
> @@ -157,7 +157,7 @@ static int pcihp_is_ejectable(acpi_handle handle)
>  }
>
>  /**
> - * acpi_pcihp_check_ejectable - check if handle is ejectable ACPI PCI slot
> + * acpi_pci_check_ejectable - check if handle is ejectable ACPI PCI slot

Again, this is about fixing a kerneldoc comment, so please change the
subject to reflect that more precisely.

This applies to all of the patches in the series AFAICS.

>   * @pbus: the PCI bus of the PCI slot corresponding to 'handle'
>   * @handle: ACPI handle to check
>   *
> --
> 2.20.1
>
