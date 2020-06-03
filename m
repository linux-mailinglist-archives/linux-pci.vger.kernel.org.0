Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B531ED070
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgFCNC6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 09:02:58 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:43364 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCNC6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 09:02:58 -0400
Received: by mail-oo1-f65.google.com with SMTP id n31so469973ooi.10;
        Wed, 03 Jun 2020 06:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Mgb0bCS0D1TFUs0ldCAQwabBK02pyl5CuAq3gJlc7I=;
        b=G/BIJ3W53sbghH2/1giuTVp/NpTZIkymFxQ8LaZ0Z53zQN0esaEZIbDU9hhS0nfZxc
         a8KbPa/LAPhvjq05z/v6dUcYXYbuKFkSJsIP0S8K/a2UoSIVyMtRL3sIcTQYlRUHIyB8
         2buX1bGvHF0OZInRK8zq4Mz6qnee6YmnlyOYWTCOrpEAQvGvQ0ceb0swNXu26/oBhOx7
         YEXPZN3ajFm4dK46HMyG7B6jcUDWXhsbjOgNyJfrV8+XsZJFgYLIqc0JyVJVIdTMwgp6
         GYuO710MMYzyg6Hjp7y6QvzPzQFckRB5iILEFAXr8SkiIWqowZFOe5VDRsgGSJgaWuCv
         IM2Q==
X-Gm-Message-State: AOAM532u7JzA8u5gl9mgmEyqM1VoIiMGuBvP3vD9MDFGH5muu9kE5GCK
        kdYMzUYcxnTJrltnxrXA9/PKPGFXfyqMgdcwI0s=
X-Google-Smtp-Source: ABdhPJz7PwkIgrWSTShbyCivu11k9OLdwtH9zC/b20aXoZ8zSD6d75mkvWHqNpR987AduozdoL0GChfEELjYXCGcCvI=
X-Received: by 2002:a4a:96f1:: with SMTP id t46mr24087828ooi.75.1591189375636;
 Wed, 03 Jun 2020 06:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200602223618.GA845676@bjorn-Precision-5520> <B2282A82-EEA4-40F8-B7F5-1D7AE7E3B573@intel.com>
 <faaf2c47-6039-74fb-e5d2-91a5b3705459@kernel.org> <03d2a6ca-78de-2d39-5428-2949c2017099@hisilicon.com>
In-Reply-To: <03d2a6ca-78de-2d39-5428-2949c2017099@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 15:02:41 +0200
Message-ID: <CAJZ5v0hxwcbembJGDRdf_nBRaTzcO73L1YJ2TT3BYxaihV6orA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PCI: Remove ASPM text from _OSC failure message
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 3, 2020 at 2:15 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> Previously the _OSC failed message is rather confusing, as if we
> forcibly enable ASPM by set pcie_aspm=force, we'll get the message
> below, which doesn't the reflect the real status.
>
>   acpi PNP0A08:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
>
> Reword the _OSC failure message and remove the ASPM text to make
> it clear. As if _OSC failed we're not supposed to take over any
> PCIe features including ASPM. After the Patch it'll look like:
>
>   acpi PNP0A08:02: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)
>
> No functional change intended.
>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>

This is a Bjorn's patch to which you have added a changelog and posted
as yours.  It is not OK to do things like that.

> ---
>  drivers/acpi/pci_root.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ac8ad6c..8dd7f14 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -454,9 +454,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>   if ((status == AE_NOT_FOUND) && !is_pcie)
>   return;
>
> - dev_info(&device->dev, "_OSC failed (%s)%s\n",
> - acpi_format_exception(status),
> - pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
> + dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> + acpi_format_exception(status));
>   return;
>   }
>
> @@ -517,7 +516,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>   } else {
>   decode_osc_control(root, "OS requested", requested);
>   decode_osc_control(root, "platform willing to grant", control);
> - dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> + dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
>   acpi_format_exception(status));
>
>   /*
> --
> 2.8.1
>
> .
>
