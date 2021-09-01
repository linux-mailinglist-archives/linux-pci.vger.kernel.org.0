Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F83FE2AB
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbhIAS6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 14:58:40 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:44951 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbhIAS6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 14:58:38 -0400
Received: by mail-oo1-f52.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so171731ooa.11;
        Wed, 01 Sep 2021 11:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+PNUTSWqBbaBfo3qwjMsoSO44JJuAnEOVIXtMGQP58=;
        b=TxsR0nETceZMNk36pFZudSFb1N02EAmwrmU909wBbXenmLcPRHVuxEX/swtAP/Fiz2
         emJhN4EZPpD5T/eXJPgoUzibswrzRjJSrVwnUFlzVh2jZ7By6+mXe+otvheEDcr1RsM6
         6WOTY2V2vbSBogCzZ1M5Po4/iZP7058BjhEcrc5VrBurQ+2QuRKwClNl+FyZvuynurSq
         wXcybuSO67dtPK144y+lFvket7eWrEbx4MLgFnZKLZTgtYel0cE8b0J8743FkyQJ/O6v
         VpkUke/Fg7IsQow77BWxTPuH7KADmDPlpSy/yHhO6bq0NzenqpO/aFr10CG74s9vTJgd
         lXHA==
X-Gm-Message-State: AOAM531ZA5ODESdXjd5WM/U3peXBX5Gxs1Az40emj15HtT6WTSDPsyS8
        4vgP0EwGSyuhZCk89b3q1hzZlPP1oJkdDkjgFi4=
X-Google-Smtp-Source: ABdhPJzrQF9/WvqKcyAXfuIv7Fw7ze3rREhPQSsr9CVoAnNSeHlQ5hurGIPkKaCcTXLHyx3/H5EVE812INBvGe/hP54=
X-Received: by 2002:a4a:ca83:: with SMTP id x3mr726601ooq.2.1630522661306;
 Wed, 01 Sep 2021 11:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210824122054.29481-1-joro@8bytes.org> <20210824122054.29481-4-joro@8bytes.org>
In-Reply-To: <20210824122054.29481-4-joro@8bytes.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 20:57:30 +0200
Message-ID: <CAJZ5v0gPRcv-jmRU8JmQiXy_+Kb7augKvKWxiGHz3K9VqqS2Yg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Move _OSC query checks to separate function
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 24, 2021 at 2:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Move the checks about whether the _OSC controls are requested from the
> firmware to a separate function.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/pci_root.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ed4e6b55e9bc..f12e512bcddc 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -449,6 +449,24 @@ static u32 calculate_control(void)
>         return control;
>  }
>
> +static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
> +{
> +       struct acpi_device *device = root->device;
> +
> +       if (pcie_ports_disabled) {
> +               dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> +               return false;
> +       }
> +
> +       if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> +               decode_osc_support(root, "not requesting OS control; OS requires",
> +                                  ACPI_PCIE_REQ_SUPPORT);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                                  bool is_pcie)
>  {
> @@ -485,16 +503,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                 return;
>         }
>
> -       if (pcie_ports_disabled) {
> -               dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> +       if (!os_control_query_checks(root, support))
>                 return;
> -       }
> -
> -       if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> -               decode_osc_support(root, "not requesting OS control; OS requires",
> -                                  ACPI_PCIE_REQ_SUPPORT);
> -               return;
> -       }
>
>         requested = control = calculate_control();
>
> --
> 2.32.0
>
