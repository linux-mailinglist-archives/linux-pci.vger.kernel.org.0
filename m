Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5285C3E48D3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhHIP1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 11:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235778AbhHIP1f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 11:27:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5921610A4;
        Mon,  9 Aug 2021 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628522834;
        bh=1yD6V5YYEokX5B0rQ6t8LnnMturN0d6B+H9Rzr2ePkc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GOAYeokh8GrdF7C/AvDAIIKSptbh2HpqYejVxyWVx6bBa+5d2MH29qaQQH8DAB+/W
         sKwbrZ9SytvKO2XEd6pFS8+H6UdjZ+ZCfew23EBRnaOXX7uPgU8VG4fHSSsfFG2hn3
         maxfaSjCkoOlcEz5NnNJEVkQKDT7Wz03fbIpAKxpixXxm7plLo7RcrSZi6bdLuEMf7
         GntCEm1BjPVireUD2v6rM3ELqOLHFqtISAhJdBuJ/PdyjMvTcWcBHcDcLqWT/rY3PN
         CG3zq5w8eIEChtrO24oj3N8N5ZTmpgBNdwyFU/h9vw0UAox8KYpJsdbcDdjlZ7txd/
         ny4hWuh04vMlA==
Received: by mail-ej1-f45.google.com with SMTP id c25so15796728ejb.3;
        Mon, 09 Aug 2021 08:27:14 -0700 (PDT)
X-Gm-Message-State: AOAM530y8G085LhkUXyDNR7y4fq8uIKAhKE+y8f4sGmQyG8YGzJ1C3VV
        xUqEaeoMF1O3l2Gn10WQAg5J/7uIG9Pk5UFJZA==
X-Google-Smtp-Source: ABdhPJwNSzt5P0dsLVvJ9d/PPbBsKhqS8CaRCWNvJwEWmLp/8/EgBK3DkDbdiNvt5XWcWpYYkYD8eTiEnnf+pIKALIE=
X-Received: by 2002:a17:906:fa92:: with SMTP id lt18mr4028759ejb.359.1628522833303;
 Mon, 09 Aug 2021 08:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210806221256.GA1891371@bjorn-Precision-5520> <5f4f484b-9eef-2722-405d-a7ff6259aa0f@arm.com>
In-Reply-To: <5f4f484b-9eef-2722-405d-a7ff6259aa0f@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Aug 2021 09:27:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=ipGBOsMUaCDvAETX5DQ2tCunNSAtFs6VZybOW7Xrdg@mail.gmail.com>
Message-ID: <CAL_JsqL=ipGBOsMUaCDvAETX5DQ2tCunNSAtFs6VZybOW7Xrdg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 6, 2021 at 6:35 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
> Thanks for looking at this.
>
> On 8/6/21 5:12 PM, Bjorn Helgaas wrote:
> > In subject, this or similar would match history:
> >
> >    PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
> >
> > On Thu, Aug 05, 2021 at 04:12:00PM -0500, Jeremy Linton wrote:
> >> Now that we have a bcm2711 quirk, we need to be able to
> >> detect it when the MCFG is missing. Use a namespace
> >> property as an alternative to the MCFG OEM.
> >
> > Rewrap to use ~75 columns.
> >
> > Mention the DT namespace property here.
> >
> >> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >> ---
> >>   drivers/acpi/pci_mcfg.c | 14 ++++++++++++++
> >>   1 file changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> >> index 53cab975f612..7d77fc72c2a4 100644
> >> --- a/drivers/acpi/pci_mcfg.c
> >> +++ b/drivers/acpi/pci_mcfg.c
> >> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
> >>      ALTRA_ECAM_QUIRK(1, 13),
> >>      ALTRA_ECAM_QUIRK(1, 14),
> >>      ALTRA_ECAM_QUIRK(1, 15),
> >> +
> >> +    { "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
> >> +      DEFINE_RES_MEM(0xFD500000, 0xA000) },
> >>   };
> >>
> >>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> >> @@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
> >>      u16 segment = root->segment;
> >>      struct resource *bus_range = &root->secondary;
> >>      struct mcfg_fixup *f;
> >> +    const char *soc;
> >>      int i;
> >>
> >> +    /*
> >> +     * This could be a machine with a PCI/SMC conduit,
> >> +     * which means it doens't have MCFG. Get the machineid from
> >> +     * the namespace definition instead.
> >
> > s/SMC/SMCCC/ ?  Cover letter uses SMCCC (not sure it's relevant anyway)
> > s/doens't/doesn't/
> >
> > Rewrap comment to use ~80 columns.
> >
> > Seems pretty reasonable that a platform without standard ECAM might
> > not have MCFG, since MCFG basically implies ECAM.
>
>
> Sure, on all the above comments.
>
> >
> > Is "linux,pcie-quirk" the right property to look for?  It doesn't
> > sound very generic, and it doesn't sound like anything related to
> > ECAM.  Is it new?  I don't see it in the tree yet.  Should it be in
> > Documentation/devicetree/bindings/pci/pci.txt so we don't get a
> > different property name for every new platform?

No, it should not be in pci.txt. Nothing to do with DT and I don't
review ACPI bindings (someone should) if I can help it.

> Yes, I made it up. Someone else commented about the "linux," partially
> because it should be "linux-" to conform with
> https://github.com/UEFI/DSD-Guide. But also in the same context of it
> being linux specific.  I think that guide is where it should end up,
> rather than the devicetree bindings.
>
> I guess we can request addition to the uefi- but that seems like a
> mistake this is really (hopefully?) a Linux specific properly as other
> OS's will simply use the SMC. I think we could request another prefix if
> we come up with a good one and think it belongs in that guide.

It's only Linux specific until it's not.

What happens when there's a second PCIe quirk here? Say what the quirk
is (and not in terms of Linux policy).

Don't you know the device here and can imply all this (like implying
off of 'compatible' in DT)? Adding properties to address issues
creates compatibility issues. Maybe not an issue in this case if the
firmware is not stable, but not a good practice to be in.

Rob
