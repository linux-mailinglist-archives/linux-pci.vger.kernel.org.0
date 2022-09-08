Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779E75B1DE0
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiIHNFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiIHNFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 09:05:16 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7F80F62;
        Thu,  8 Sep 2022 06:05:11 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f131so10724645ybf.7;
        Thu, 08 Sep 2022 06:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dKQHw3cShiawbp5azVRw7MLA3EmHUTNcOsfnUo5TI1A=;
        b=MrrSwIjQwKZ2u+/yepICYkbLSDOMFjgwXLQNUwzQDOPRNkNAm72X+yGZ8r0wjJ8T1U
         O6GJg9iYxBr+y91Enf6qMnIx2Qo88kSwBN/ykGNSCLcFgYNvX1EC3bMxMsGVLKljQQ/m
         CRQYKqBiEgVzwPrTD59T3ZIXz7zya2kGtjROV8ga/gqm4wLJTKvoqbkePZO6H2UY6v/f
         7m7/nBjU0yarNcbjY65FznyaDWdwqX5W/Nt4EpTLslYIsm0q+tDF8+PVDtefmI4Ee4SV
         bz3fFC5c2O4RIEabOgfuSU3oE7iRpN6W/izpEJB6U3M8I0kMZB6gzYXe5f6vze+Z0WbF
         ogkQ==
X-Gm-Message-State: ACgBeo11tk5Gmq6tO/9mSR9Cp+fKi0sUadcAXThMH+7sJOTZ5ibs/4Uj
        fauKJAECcUC5ufflMGmdUnPW7qBIphZgG9URMZs=
X-Google-Smtp-Source: AA6agR7ou+ItJtnU73fnRGUngBp598ZcFFZFZ43LMueFbIG8QUCr5m6kkwg5LOMd0mz94UQkVUD8W8W/pDoaNwYz0cI=
X-Received: by 2002:a25:ec09:0:b0:6ad:804f:5463 with SMTP id
 j9-20020a25ec09000000b006ad804f5463mr5109866ybh.622.1662642310060; Thu, 08
 Sep 2022 06:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220831081603.3415-1-rrichter@amd.com> <20220831081603.3415-7-rrichter@amd.com>
In-Reply-To: <20220831081603.3415-7-rrichter@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Sep 2022 15:04:51 +0200
Message-ID: <CAJZ5v0gQqyFZHxe9fLX9WrMGBYhdna7Cpnx6bwTPFffy_koE5Q@mail.gmail.com>
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 10:17 AM Robert Richter <rrichter@amd.com> wrote:
>
> A lookup of a host bridge's corresponding acpi device (struct
> acpi_device) is not possible, for example:
>
>         adev = ACPI_COMPANION(&host_bridge->dev);

Hmm.

x86 has this code in pcibios_root_bridge_prepare():

    if (!bridge->dev.parent) {
        struct pci_sysdata *sd = bridge->bus->sysdata;
        ACPI_COMPANION_SET(&bridge->dev, sd->companion);
    }

which should set the ACPI companion for the host bridge.

Moreover, on my x86 desktop /sys/devices/pci0000\:00/ (which is the
host bridge AFAICS) has

firmware_node -> ../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00

so clearly the ACPI companion is there.

Are we talking about ARM64 here?

> This could be useful to find a host bridge's fwnode handle and to
> determine and call additional host bridge ACPI parameters and methods
> such as HID/CID or _UID.
>
> Make this work by linking the host bridge to its ACPI fw node.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/pci_root.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d57cf8454b93..846c979e4c29 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1083,6 +1083,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>                 goto out_release_info;
>
>         host_bridge = to_pci_host_bridge(bus->bridge);
> +       host_bridge->dev.fwnode = acpi_fwnode_handle(device);

So this would be replacing the existing mechanism on x86, right?

>         if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
>                 host_bridge->native_pcie_hotplug = 0;
>         if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> --
