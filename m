Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417A21ED067
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCM75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 08:59:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44176 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCM75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 08:59:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id x202so1677933oix.11;
        Wed, 03 Jun 2020 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Avu73/RJTh7C6Zmn+PcLBAe4m5stgzWhjrslzFHSP0=;
        b=jLBYOsarKhBG1YjFV/TG4X7FBYzGobFAle04Iem7aVuYJlfmKA0OkBRc4fD85sefgA
         xynxspEy2ns7UCdY92TQQavM3S7mE6TraiUakHygcVd9HiZOkZNfAm8YSta9gVM8eEXB
         JuR+YCcTsh9yhzCc4TLVWO3refpFZCeT21eMXgbcJbSxUUnM3GqZjkF2J81JzS1+psTY
         Insobt2yKwoU9oouR6WQAmL9hO7thnsDclQDoGCIj8otP3kb6FVmdtAjDZFpwY6svsrj
         Gt80x2HrKuMJ7dhhzANdDLxydvvfIlPxBXRUHCvizSFuL5Uw5Equ/20c55fn9LfRe52l
         05kg==
X-Gm-Message-State: AOAM530F2VPVFjkOVSMFj5paXRcurRKAY34cTyiG4VDERpyLyFhJ1Puv
        9kFcyKLrbo9UZLFQ04OlE/SxYoJCceN1C7T90dE=
X-Google-Smtp-Source: ABdhPJyJxV8ci7Gy/UVsoeIn0CieAgfklfLjvV2MpzQ0tBaMdkhQIJdMlqCuRQORLGmugftLli0nlNv4Wp4+0GUfdek=
X-Received: by 2002:aca:eb56:: with SMTP id j83mr6404375oih.110.1591189195627;
 Wed, 03 Jun 2020 05:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <dd5ba708-18a9-fd42-8cf1-af32ef367d5e@kernel.org> <20200602223618.GA845676@bjorn-Precision-5520>
In-Reply-To: <20200602223618.GA845676@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 14:59:41 +0200
Message-ID: <CAJZ5v0ixNmH_h5OFQrH4HV0E2ie_=PsN0vj7wBBjASTH51Esuw@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
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

On Wed, Jun 3, 2020 at 12:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 02, 2020 at 01:50:37PM -0400, Sinan Kaya wrote:
> > Bjorn,
> >
> > On 6/1/2020 9:57 PM, Yicong Yang wrote:
> > > well, Sinan's words make sense to me. But I'm still confused that, the message
> > > says we're "disabling ASPM" but ASPM maybe enabled if we designate
> > > pcie_aspm=force as I mentioned in the commit message. Will it be possible if
> > > we replace "disabling" to "disabled" or we can do something else to make
> > > the message reflect the real status of ASPM?
> >
> > What do you think?
>
> ASPM is a mess in general, and the whole "no_aspm" dance for delaying
> setting of aspm_disabled is ... well, it's confusing at best.
>
> These "_OSC failed" messages are confusing to users as well.  They
> lead to bug reports against Linux (when it's usually a BIOS problem)
> and users booting with "pcie_aspm=force" (which is a poor user
> experience and potentially dangerous since the platform hasn't granted
> us control of the PCIe Capability).
>
> And it's not even specific to ASPM; when _OSC fails, we don't take
> over *any* PCIe features.  At least, we're not *supposed* to -- I
> don't think we're very careful about random things in the PCIe
> capability.
>
> What if we just removed the ASPM text from the message completely,
> e.g., something like this:
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 800a3d26d24b..49fdb07061b1 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -453,9 +453,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                 if ((status == AE_NOT_FOUND) && !is_pcie)
>                         return;
>
> -               dev_info(&device->dev, "_OSC failed (%s)%s\n",
> -                        acpi_format_exception(status),
> -                        pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
> +               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> +                        acpi_format_exception(status));
>                 return;
>         }
>
> @@ -516,7 +515,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>         } else {
>                 decode_osc_control(root, "OS requested", requested);
>                 decode_osc_control(root, "platform willing to grant", control);
> -               dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> +               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
>                         acpi_format_exception(status));
>
>                 /*

Looks good to me.

Cheers!
