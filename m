Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B376B0A3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjHAKPm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 1 Aug 2023 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjHAKPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 06:15:35 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F71116;
        Tue,  1 Aug 2023 03:15:34 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56c9f7830c2so253339eaf.0;
        Tue, 01 Aug 2023 03:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884933; x=1691489733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzHqdne2BG4kkp0BowEqbgS/OCqX4nVAVPjcUk7pJCQ=;
        b=JngEa0dYtiQ3aTir9VTHkpqjydq7rG0xu31Sx1psjZwkCRCGaBOG8NmWiMlQ5D4+Yc
         HH/fO/wNbqg1Z3tNxZ1D1lxvS7bX4RoPRq+LDcYuHx8v718LNdKmOasTe1kTY9ZGp7UZ
         fzeBVrgWKaUFgvnznxzHZFTraR9sD+YGVRbszLActOHxm0qnumkY+nuRCuGlMbMmgIS7
         u8ng3fNaYTre0tJZ7IHbDI1fyXT9TFNIi/A6tZizVqstFFL0T+UcnnTZKpgXmUcQq8fL
         7sw/u68rDix3dOzex0FxkGWXjxmoh4t4zwJlf2/m4QMRAVqX6ZtAG/SJsMdTmeU+9op6
         NPDw==
X-Gm-Message-State: ABy/qLauZv9repnJDDVEHRneXnBNjR8MJtmHioIWTbpThCnZZgY7uh8x
        ZzoImiThTtEpn2SSFbszW+F33BEM+oXKZAVd6do=
X-Google-Smtp-Source: APBJJlGjwZAJQKYHp20dvvuuPFokbdWXCEPK+M3phnsNgqTP5NAAlRdRJ+viLK+HU5lNlTQhqIU8h0svb2P1aPtiM60=
X-Received: by 2002:a05:6820:1686:b0:56c:5e21:c730 with SMTP id
 bc6-20020a056820168600b0056c5e21c730mr8254193oob.1.1690884933362; Tue, 01 Aug
 2023 03:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230711221427.GA250962@bhelgaas> <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com> <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com> <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
In-Reply-To: <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 12:15:20 +0200
Message-ID: <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 1, 2023 at 5:25 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/14/23 19:46, Limonciello, Mario wrote:
> >
> > On 7/14/2023 2:17 PM, Rafael J. Wysocki wrote:
> >>>> Generally speaking, pci_bridge_d3_possible() is there to prevent
> >>>> bridges (and PCIe ports in particular) from being put into D3hot/cold
> >>>> if there are reasons to believe that it may not work.
> >>>> acpi_pci_bridge_d3() is part of that.
> >>>>
> >>>> Even if it returns 'true', the _SxD/_SxW check should still be applied
> >>>> via pci_target_state() to determine whether or not the firmware allows
> >>>> this particular bridge to go into D3hot/cold.  So arguably, the _SxW
> >>>> check in acpi_pci_bridge_d3() should not be necessary and if it makes
> >>>> any functional difference, there is a bug somewhere else.
> >>> But only if it was power manageable would the _SxD/_SxW check be
> >>> applied.  This issue is around the branch of pci_target_state() where
> >>> it's not power manageable and so it uses PME or it falls back to D3hot.
> >> Well, this looks like a spec interpretation difference.
> >>
> >> We thought that _SxD/_SxW would only be relevant for devices with ACPI
> >> PM support, but the firmware people seem to think that those objects
> >> are also relevant for PCI devices that don't have ACPI PM support
> >> (because those devices are still power-manageable via PMCSR).  If
> >> Windows agrees with that viewpoint, we'll need to adjust, but not
> >> through adding _SxW checks in random places.
> > I think that depends upon how you want to handle the lack of _S0W.
> >
> > On these problematic devices there is no _S0W under the PCIe
> > root port.  As I said; Windows puts them into D0 in this case though.
> >
> > So acpi_dev_power_state_for_wake should return ACPI_STATE_UNKNOWN.
> >
> > Can you suggest where you think adding a acpi_dev_power_state_for_wake()
> > does make sense?
> >
> > Two areas that I think would work would be in: pci_pm_suspend_noirq()
> > (to avoid calling pci_prepare_to_sleep)
> >
> > or
> >
> > directly in pci_prepare_to_sleep() to check that value in lieu of
> > pci_target_state().
> >
>
> Rafael,
>
> Did you have any more thoughts on this?

Reportedly, if there are no ACPI power management objects associated
with a Root Port, Windows will always leave it in D0.

In that case, acpi_pci_bridge_d3() will return false unless the
HotPlugSupportInD3 property is present AFAICS, so the ACPI code will
not allow the port to be put into D3hot.

Consequently, platform_pci_bridge_d3() will return false and the only
thing that may allow the port to go into D0 is the dmi_get_bios_year()
check at the end of pci_bridge_d3_possible().

However, that was added, because there are Intel platforms on which
Root Ports need to be programmed into D3hot on suspend (which allows
the whole platform to reduce power significantly) and there are no
ACPI device power management objects associated with them (Mika should
know the gory details related to this).  It looks like under Windows
the additional power reduction would not be possible on those systems,
but that would be a problem, wouldn't it?

So it looks like there are some systems on which programming Root
Ports into D3hot is needed to achieve additional power reduction of
the platform and there are systems on which programming Root Ports
into D3hot breaks things and there are no ACPI power management
objects associated with these Root Ports in both cases.

The only way to make progress that I can think about right now is to
limit the dmi_get_bios_year() check at the end of
pci_bridge_d3_possible() to Intel platforms.
