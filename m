Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5877FE89
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbjHQTcj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 17 Aug 2023 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354464AbjHQTcI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 15:32:08 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063B125;
        Thu, 17 Aug 2023 12:32:06 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56d75fb64a6so37963eaf.0;
        Thu, 17 Aug 2023 12:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692300725; x=1692905525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmMDMTsMjIFc7FLz6ZcKtmrd1RlOQlQCjiqjWAljti4=;
        b=UR9k57Jxa29Rub9lq/Y5DS3NOsmJ4f3UH4MwbnwSO3/ALgTgbs8yFB5ntTjR+Y26fq
         afXFYxkoFUWGAd1YGhFnsbJnIuGCtxdrpqtixtuNkVPV0OyXbZZa+Ces567RaHYMsNYl
         ppxHZSTLGIVIt65YnXcQakMh5jsi624ypn3H/sg9ND/tRVTkupghSWsIMrdcLkhOvQpm
         EI4JmF159KEYxz1aG3z4n30fLgGgYNrz9SN5krL1AcjQIkN2tF4jyIJ+8T3E+GFgos3P
         V1v3e8ADYzaH0CvsCDEajxUXFivWMDDECvUZiuM/3g+qz8TDdiRYRwhHLwZ9YLCQ65Te
         dGSA==
X-Gm-Message-State: AOJu0YxeZTVT4HvfQkmUJuE7sfaXxJ1GLOTlRFSa8uyA/D8cngumVVMT
        rnvhKV+nfF5HqN7fvVs8bpgDVwz89w33RjIO3iVG2vMo
X-Google-Smtp-Source: AGHT+IEwJM7JZDHhGpyJ+BKW/oXbHbm7DPZYPepSa17wbZGfLCxLyq2OUk+VEnwr9RRDbuoRelK8brrN9BEMyA62m/0=
X-Received: by 2002:a4a:e706:0:b0:566:951e:140c with SMTP id
 y6-20020a4ae706000000b00566951e140cmr731584oou.1.1692300725301; Thu, 17 Aug
 2023 12:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230816204143.66281-10-mario.limonciello@amd.com> <20230817192537.GA322922@bhelgaas>
In-Reply-To: <20230817192537.GA322922@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 21:31:54 +0200
Message-ID: <CAJZ5v0juq2AsqxBAGN4oOsQp7-73+TP67Ppjz2DWq-pVEAxTrA@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for
 PCI devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 9:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Aug 16, 2023 at 03:41:43PM -0500, Mario Limonciello wrote:
> > Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
> > storing a value to the `bridge_d3` variable in the `struct pci_dev`
> > structure.
> > ...
>
> > +static void lpi_check_pci_dev(struct lpi_constraints *entry, struct pci_dev *pdev)
> > +{
> > +     pci_power_t target = entry->enabled ? entry->min_dstate : PCI_D0;
> > +
> > +     if (pdev->current_state == target)
> > +             return;
> > +
> > +     /* constraint of ACPI D3hot means PCI D3hot _or_ D3cold */
> > +     if (target == ACPI_STATE_D3_HOT &&
>
> ACPI_STATE_D3_HOT is not a valid pci_power_t value.
>
> > +         (pdev->current_state == PCI_D3hot ||
> > +          pdev->current_state == PCI_D3cold))
> > +             return;
> > +
> > +     if (pm_debug_messages_on)
> > +             acpi_handle_info(entry->handle,
> > +                              "LPI: PCI device in %s, not in %s\n",
> > +                              acpi_power_state_string(pdev->current_state),
> > +                              acpi_power_state_string(target));
> > +
> > +     /* don't try with things that PCI core hasn't touched */
> > +     if (pdev->current_state == PCI_UNKNOWN) {
> > +             entry->handle = NULL;
> > +             return;
> > +     }
> > +
> > +     pci_set_power_state(pdev, target);
>
> It doesn't seem logical for a "check_constraints()" function that
> takes no parameters and returns nothing to actively set the PCI power
> state.
>
> lpi_check_constraints() returns nothing, and from the fact that it was
> previously only called when "pm_debug_messages_on", I infer that it
> should have no side effects.

That's correct, it is not expected to have side effects.

> IMHO "lpi_check_constraints" is not a great name because "check"
> doesn't suggest anything specific about what it does.
> "dump_constraints()" -- fine.  "log_unmet_constraints()" -- fine
> (seems like the original intention of 726fb6b4f2a8 ("ACPI / PM: Check
> low power idle constraints for debug only"), which added it.

It seems that we are entering bikeshedding territory here ...
