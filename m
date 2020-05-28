Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B81E5E90
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 13:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbgE1LmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 07:42:25 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36776 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbgE1LmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 07:42:24 -0400
Received: by mail-oo1-f66.google.com with SMTP id 18so917748ooy.3;
        Thu, 28 May 2020 04:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nY9Gt3iZipKBlqZgOSR97jgJqUKPR4PYBCZrqkRD0Pc=;
        b=JzsFST+jErypp1LcyKrkMqwK2FA07sE74xqXLiSkLmCsZWR6tN0H4LXznJNgjHugB/
         +uKwggk8Bi+cCv4BIs+kQc9qyLrZezCoZLTcf/+ATZsveKBTUAdp1Y+bhtUMo9gtEBez
         LQhMKntvtbSP101g2+vVqHWDjzDyKF3HL5DjWiMpfTDyn5+hg7zJS1mLrlburLgRqbDv
         5Wr5Md3BmrKpEuioLxLC8erJ+9wc+LyA14XThSO3o5150Kg/Z+1UfuMzjo69cuUot5uD
         nXSPC/NbSp9XQrFLkxOhlpbmcKtaqzNSdJCOV5f0wdhoM3+HApgj4rHRL0dDsQKiLs9E
         HfJA==
X-Gm-Message-State: AOAM530xE9jiTjEbYjF4UzRMdMEMuG/Z3ouK3y1zGJsJXqOulT57Mzsk
        RiFzw2w+vTSWwBQ8hyDAii9AEy52Lyy7nP8wdx4=
X-Google-Smtp-Source: ABdhPJzCOOgSLNbe3FHx2kCPFngkCbw8PjNF5b6OpmqSKFrub/Fk3eVTdV8/ZRvazaCaBO22RP7sIbATlLWeAXMMtZk=
X-Received: by 2002:a4a:e0d1:: with SMTP id e17mr2124959oot.1.1590666143690;
 Thu, 28 May 2020 04:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <1590655125-23949-1-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1590655125-23949-1-git-send-email-yangyicong@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 May 2020 13:42:10 +0200
Message-ID: <CAJZ5v0g9O5r7tpLMN7SJu+KZEeEcdeTKeQ=hEo5r+VJzc6g08Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 28, 2020 at 10:39 AM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> Previously we'll print wrong ASPM status if _OSC method return
> failed. For example, if ASPM is enabled by setting pcie_aspm=force,
> we get message below:
>
>     acpi PNP0A08:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
>
> Fix it and print correct ASPM status when _OSC failed.
>
> Fixes: 1ad61b612b95 ("PCI/ACPI: Correct error message for ASPM disabling")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/acpi/pci_root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ac8ad6c..5140b26 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -456,7 +456,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>
>                 dev_info(&device->dev, "_OSC failed (%s)%s\n",
>                          acpi_format_exception(status),
> -                        pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
> +                        pcie_aspm_support_enabled() ? "" : "; disabling ASPM");
>                 return;
>         }
>
> --

Applied as 5.8 material under the "ACPI: PCI: Fix the ASPM part of the
_OSC failure message" subject and with a different changelog.

Thanks!
