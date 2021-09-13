Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF5240987A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbhIMQNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 12:13:30 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37622 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbhIMQNa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 12:13:30 -0400
Received: by mail-ot1-f43.google.com with SMTP id i3-20020a056830210300b0051af5666070so14033489otc.4;
        Mon, 13 Sep 2021 09:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iy17siULBUCrxqk6rYwdXsHfKX1tLqgQIZ1fMrLHGuE=;
        b=lxhbqgsAqeF4+p6M+m+OPUtIHdcsWau2fVZWciM73wEdZcr8Mdj1EO1CyZldB0hS7U
         yIL6CJci0jxdwQFypqbs7/8zyfjsYJqJ791+JN2S9XR46ephHAdvevh8tpMi8aJbcZDF
         aUSWIV0TOJPKLDxkpXFLu8qAN3RAr1ZP79Iox624DrQPmPVQf76kTkOSNW4qz2yGi+g5
         dfgAlQw3cNhvCUtNQkgR67O1QaaKB1bJPW0LDq1vAGzGkPGol4k4HiqRJURBVRTANMdN
         7CYgt1S5OZmIz+6a1UoX5O+JRJUsFf00wkY40+PRP/bmjvNSS+oOC7UphqZZebg021SH
         xarQ==
X-Gm-Message-State: AOAM531SZLbtzkwgXo56SuqEaWqT+HrGn35bbjt/r1lLNQ6qe0EqlVnp
        /l2iO64CcWRoHt2JSwD2t+CB5Tg8BAfH4hLRVnE=
X-Google-Smtp-Source: ABdhPJyzy1gv4uHNCOt/N4YjLvqkL6bUSLtCw1mbHgDLvA+w27AsuD5majS0JTZdRDoKIGoAddUwuwPZfNW4hzFkdjM=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr10246317otk.86.1631549534058;
 Mon, 13 Sep 2021 09:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210826071557.29239-1-jeremy.linton@arm.com> <20210826071557.29239-4-jeremy.linton@arm.com>
In-Reply-To: <20210826071557.29239-4-jeremy.linton@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Sep 2021 18:12:03 +0200
Message-ID: <CAJZ5v0hJUKNzGKKj5ufACPE7hDLknBQyjdV-YXjB3HB6JGL6qA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        nsaenz@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 9:16 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Now that there is a bcm2711 quirk, it needs to be enabled when the
> MCFG is missing. Use an ACPI namespace _DSD property
> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/pci_mcfg.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..04c517418365 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>         ALTRA_ECAM_QUIRK(1, 13),
>         ALTRA_ECAM_QUIRK(1, 14),
>         ALTRA_ECAM_QUIRK(1, 15),
> +
> +       { "bc2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
> +         DEFINE_RES_MEM(0xFD500000, 0xA000) },
>  };
>
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> @@ -198,8 +201,22 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>         u16 segment = root->segment;
>         struct resource *bus_range = &root->secondary;
>         struct mcfg_fixup *f;
> +       const char *soc;
>         int i;
>
> +       /*
> +        * This may be a machine with a PCI/SMC conduit, which means it doesn't
> +        * have an MCFG. Use an ACPI namespace definition instead.
> +        */
> +       if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
> +                                        "linux-ecam-quirk-id", &soc)) {
> +               if (strlen(soc) != ACPI_OEM_ID_SIZE)
> +                       dev_err(&root->device->dev, "ECAM quirk should be %d characters\n",
> +                               ACPI_OEM_ID_SIZE);
> +               else
> +                       memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
> +       }
> +
>         for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>                 if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>                         if (f->cfgres.start)
> --
> 2.31.1
>
