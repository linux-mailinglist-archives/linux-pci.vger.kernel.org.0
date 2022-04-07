Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4004F8517
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiDGQnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiDGQnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 12:43:37 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C3195D97;
        Thu,  7 Apr 2022 09:41:36 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id l36so10513989ybj.12;
        Thu, 07 Apr 2022 09:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ag3ZPrDaG7eymU9bbXcPlL6ed5F1nvkJ2snTyLrGnXs=;
        b=CukGAeIT43xM17pCPytcQyhT370asJLMKxD1G9ALDllv6I6Rd669Do8qgvq+QygIuN
         Hxo7ghI6dKZzSAph4osOml+Wkf70N5bCpgBxvb43p7jVL0stg4RR6wTTe3SLwNoICBEG
         n5LRZ9uD+Na4ElubNJPiax/so7/1vNezIAuqTzQZPNGbmDK5cjt0tCkr0+k8ARP0YUFV
         TYpB4U37Oj2Wha7PWbWQttTJjENuA/LbIg2UMA4xk1J7a7xWW/AgWCR3m+UAyOd/m2IA
         /zVyQBo/Pfqt817qd6YERWrN7a7SuvCwp/e56OWnsAuSC45dezzMOBkJKkiVjc53exMA
         95xQ==
X-Gm-Message-State: AOAM533p5tXleLMDRy7XioiEVmArbS7PDQyeJpc4hiICWo6pOtwtdqL1
        9OgbfOvCauo8vajNcfs6TArNBnrAor1U7SfVcEc=
X-Google-Smtp-Source: ABdhPJwWQD4BFr0N61om2oTZkMiWX4Rr2YEQ3mpLAc2fGixxeUMxNh9UrphFjXkRcH94v9AOqW3Qm14l5jYbhkvU+LY=
X-Received: by 2002:a25:8409:0:b0:63c:bea7:30af with SMTP id
 u9-20020a258409000000b0063cbea730afmr9874223ybk.633.1649349695694; Thu, 07
 Apr 2022 09:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220407131602.14727-1-yangyicong@hisilicon.com> <20220407154257.GA235990@bhelgaas>
In-Reply-To: <20220407154257.GA235990@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Apr 2022 18:41:24 +0200
Message-ID: <CAJZ5v0gWzDsh8VWY+EzO6WxyO6Fe1GcRzVfABVOaO0ywJegLwA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Decouple the negotiation of ASPM and other PCIe services
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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

On Thu, Apr 7, 2022 at 5:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael]
>
> On Thu, Apr 07, 2022 at 09:16:02PM +0800, Yicong Yang wrote:
> > Currently we regard ASPM as a necessary PCIe service and if it's disabled
> > by pcie_aspm=off we cannot enable other services like AER and hotplug.
> > However the ASPM is just one of the PCIe services and other services
> > mentioned no dependency on this. So this patch decouples the negotiation
> > of ASPM and other PCIe services, then we can make use of other services
> > in the absence of ASPM.
>
> Why do you want to boot with "pcie_aspm=off"?  If we have to use a
> PCI-related parameter to boot, something is already wrong, so if
> there's a problem that requires ASPM to be disabled, we should fix
> that first.
>
> If there's a known hardware or firmware issue with ASPM, we should
> quirk it so users don't have to discover this parameter.
>
> > Aaron Sierra tried to fix this originally:
> > https://lore.kernel.org/linux-pci/20190702201318.GC128603@google.com/
>
> Yes.  My question from that review is still open:
>
>   But Rafael added ACPI_PCIE_REQ_SUPPORT with 415e12b23792 ("PCI/ACPI:
>   Request _OSC control once for each root bridge (v3)") [1], apparently
>   related to a bug [2].  I assume there was some reason for requiring
>   all those things together, so I'd really like his comments.

Well, it was quite a few years ago.

>   [1] https://git.kernel.org/linus/415e12b23792
>   [2] https://bugzilla.kernel.org/show_bug.cgi?id=20232
>
> Rafael clearly said in [1] that we need to:
>
>   ... check if all of the requisite _OSC support bits are set before
>   calling acpi_pci_osc_control_set() for a given root complex.

IIRC, the idea was to avoid requesting native control of anything PCIe
if those bits were not set in the mask, because otherwise we wouldn't
be able to get PME and native hotplug control which were not
configurable at that time.  [PME is still not configurable and
potentially related to hotplug, because they may use the same MSI IRQ
in principle, but the native hotplug is configurable now anyway.]

> We would still need to explain why Rafael thought all these _OSC
> support bits were required, but now they're not.
>
> _OSC does not negotiate directly for control of ASPM (though of course
> it *does* negotiate for control of the PCIe Capability, which contains
> the ASPM control bits), but the PCI Firmware spec, r3.3, sec 4.5.3, has
> this comment in a sample _OSC implementation:
>
>   // Only allow native hot plug control if the OS supports:
>   // * ASPM
>   // * Clock PM
>   // * MSI/MSI-X
>
> which matches the current ACPI_PCIE_REQ_SUPPORT.
>
> So I think I would approach this by reworking the _OSC negotiation so
> we always advertise "OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT"
> if CONFIG_PCIEASPM=y.

That'd be reasonable IMO.

> Advertising support for ASPM doesn't mean Linux has to actually
> *enable* it, so we could make a different mechanism to prevent use of
> ASPM if we have a device or platform quirk or we're booting with
> "pcie_aspm=off".

Right.

Note that if we don't request the native control of a PCIe feature,
this basically gives the BIOS a licence to scribble on the related
device registers and some of the features are not independent, so we
may need to advertise support for two features in order to get control
of just one of them.
