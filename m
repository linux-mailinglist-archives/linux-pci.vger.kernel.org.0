Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E172D77FE9A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 21:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352866AbjHQThf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 17 Aug 2023 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354546AbjHQThS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 15:37:18 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761093581;
        Thu, 17 Aug 2023 12:37:17 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-56d0deeca09so34939eaf.0;
        Thu, 17 Aug 2023 12:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692301037; x=1692905837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rWDK3YMFLz6jEoVukuJVCuQ3K6Kw4XYAriV51DzVM0=;
        b=U6qqCpEsyocOqxGP6CQBUBbY/XOwQQ4HQWJjTk53Fqr4zYEceQJ8hGQV3jJsmrf4J7
         Z2lgtqJzeNVk9QDhVvU7dCaOmKr3hrMe03eOZr5QPKI72dWWyF1m8gFBifhhAbQ/jLMG
         YynYm0LWrshb+HtuQ6Le7BNhZ3TQmHZbgpzKaBhA8a6AAZErd9DrRa0y+G2x0YCuRHpY
         JGRpU5mb6Q/gAxbZToV7AGmcRtoJ7Je7nqV9sqA29gSvJUxGnDPi+DSfaTgk/Amy2S+v
         G4EROOwC0eXMCyAz924sXcSkR8M7d53RVQlPSNjjD2pEVqk1KVWuM5dVFGJDlw/o3Ys4
         LGdw==
X-Gm-Message-State: AOJu0YwiO3yb6h2JZ3TmqBYmbC4c6I06ekkdoaJ9FTsu7+wuq96Odk6z
        D8q9XWIkBJ4QUyTxiyeVd1nT2yIXLArtEJ+3BK8=
X-Google-Smtp-Source: AGHT+IHmW3nJhT/diJGz89oLuTF0WvSNRwLAjIX0NdtbMfjM7FWvb6c9VBzAHAGTWQOiP8zOlORtYGC3KFctm15QVSY=
X-Received: by 2002:a4a:e0cd:0:b0:56e:72e0:9c5f with SMTP id
 e13-20020a4ae0cd000000b0056e72e09c5fmr741165oot.1.1692301036711; Thu, 17 Aug
 2023 12:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230817192537.GA322922@bhelgaas> <beb88d67-9437-4d7a-b1b0-a763583df17e@amd.com>
In-Reply-To: <beb88d67-9437-4d7a-b1b0-a763583df17e@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 21:37:05 +0200
Message-ID: <CAJZ5v0hTJzBkTD64bHmREGymjn2oWPt8y=6bb6WVJm39Jr+ouw@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for
 PCI devices
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 9:30 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/17/2023 2:25 PM, Bjorn Helgaas wrote:
> > On Wed, Aug 16, 2023 at 03:41:43PM -0500, Mario Limonciello wrote:
> >> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
> >> storing a value to the `bridge_d3` variable in the `struct pci_dev`
> >> structure.
> >> ...
> >
> >> +static void lpi_check_pci_dev(struct lpi_constraints *entry, struct pci_dev *pdev)
> >> +{
> >> +    pci_power_t target = entry->enabled ? entry->min_dstate : PCI_D0;
> >> +
> >> +    if (pdev->current_state == target)
> >> +            return;
> >> +
> >> +    /* constraint of ACPI D3hot means PCI D3hot _or_ D3cold */
> >> +    if (target == ACPI_STATE_D3_HOT &&
> >
> > ACPI_STATE_D3_HOT is not a valid pci_power_t value.
>
> Based on this, kernel robot sparse complaints and your comments on v11's
> last patch I am going to split off to another function that returns the
> pci_power_t state based upon the situation and better comment the reason
> for the D0 when not enabled.
>
> >
> >> +        (pdev->current_state == PCI_D3hot ||
> >> +         pdev->current_state == PCI_D3cold))
> >> +            return;
> >> +
> >> +    if (pm_debug_messages_on)
> >> +            acpi_handle_info(entry->handle,
> >> +                             "LPI: PCI device in %s, not in %s\n",
> >> +                             acpi_power_state_string(pdev->current_state),
> >> +                             acpi_power_state_string(target));
> >> +
> >> +    /* don't try with things that PCI core hasn't touched */
> >> +    if (pdev->current_state == PCI_UNKNOWN) {
> >> +            entry->handle = NULL;
> >> +            return;
> >> +    }
> >> +
> >> +    pci_set_power_state(pdev, target);
> >
> > It doesn't seem logical for a "check_constraints()" function that
> > takes no parameters and returns nothing to actively set the PCI power
> > state.
> >
> > lpi_check_constraints() returns nothing, and from the fact that it was
> > previously only called when "pm_debug_messages_on", I infer that it
> > should have no side effects.
> >
> > IMHO "lpi_check_constraints" is not a great name because "check"
> > doesn't suggest anything specific about what it does.
> > "dump_constraints()" -- fine.  "log_unmet_constraints()" -- fine
> > (seems like the original intention of 726fb6b4f2a8 ("ACPI / PM: Check
> > low power idle constraints for debug only"), which added it.
> >
>
> Great feedback, thanks.  I'm thinking to instead change it to:
>
> lpi_enforce_constraints()

Don't even try to go this way, please.

Originally, the LPI constraints are there to indicate to Windows
whether or not it should attempt to enter Connected/Modern Standby.

Because Linux doesn't do Modern Standby, it doesn't use the LPI
constraints the way Windows does and it really shouldn't do that.

I think that the exercise here is to use the information from the
constraints list as an indication whether or not a given PCI Root Port
is supposed to be put into D3hot/cold on suspend-to-idle and this has
nothing to do with enforcement.
