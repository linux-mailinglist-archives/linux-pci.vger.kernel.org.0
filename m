Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695F039DE88
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFGOUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 10:20:38 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37382 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFGOUi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 10:20:38 -0400
Received: by mail-oi1-f178.google.com with SMTP id h9so18193489oih.4;
        Mon, 07 Jun 2021 07:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/W7QdJ0pNKu0G/Jpr2lieRQ3nvMKxgUynmwjevp+ExI=;
        b=B4K564OmTQ76uYv5bry7DEzBZCUHKhFWVHwfulEEsK/DZv8ZcJYVTEyJnaX6Co+xIs
         N7IcPngg5aoXaPQdCA5lA51Z68q2MAq6hRm63FQwxrwvv021V+1ELu9xBEj6m1ncTlDf
         aRuAfgSJ9u4Z+afA1Usq177eEVGGgkgm8T04LgjCJa14bM5YAzmVJnbC5ymiixWMVhpc
         BfeuPKsNDbzWkB0Q+qiOD20WhL11s5mCdVEP4eVAvQjw2hX56YuCY5VgUskYDifeh5ms
         PfKjOD511Ivo6x67kyFE+hn6Iaat4/LUcLGpKS8sN3Zg9a6u9sR6S6BXAxLr0qNC3IrP
         tsnw==
X-Gm-Message-State: AOAM533jP80N8T4TlkpqPGyoBWtna5c3t1iSP/rykbBr01cvJKj8r6zo
        h7P0R8vZSQuKxD7hBZMBAdtqGRbQoiqHFf8HZYY=
X-Google-Smtp-Source: ABdhPJzQcPXgwSWDIINee1uuV2GdJwUb+l9kfRCPT+VK2CGWo9I64V3iQzsV6dUCNEoDQwIhOvFNMFszxvyBDLFmK90=
X-Received: by 2002:aca:650d:: with SMTP id m13mr3373519oim.157.1623075526875;
 Mon, 07 Jun 2021 07:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210603205047.GA2135380@bjorn-Precision-5520>
 <20210604170938.GA2218177@bjorn-Precision-5520> <CAJZ5v0iDxpYxz3_8RrWSJkM7cf=xS298agXcULm3EqRC++GD2g@mail.gmail.com>
 <YL4pq0oJyZfSWeTV@suse.de>
In-Reply-To: <YL4pq0oJyZfSWeTV@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 16:18:35 +0200
Message-ID: <CAJZ5v0iR-iar8BGwM7QgFEkqeRkZ=qn1PrKW0yxrERjDViUjaA@mail.gmail.com>
Subject: Re: [PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
To:     Joerg Roedel <jroedel@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 7, 2021 at 4:14 PM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Mon, Jun 07, 2021 at 02:56:24PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Jun 4, 2021 at 7:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >  If either "pcie_ports_disabled" or Linux doesn't support everything in
> > > ACPI_PCIE_REQ_SUPPORT, we will never evaluate _OSC at all, so
> > > the platform won't know that Linux has OSC_PCI_SEGMENT_GROUPS_SUPPORT,
> > > OSC_PCI_HPX_TYPE_3_SUPPORT, OSC_PCI_EXT_CONFIG_SUPPORT, etc.
> >
> > Right.
>
> Thanks Bjorn and Rafael. So I think the important thing to do is to
> issue at least one _OSC call even when Linux is not trying to take
> control of anything.
>
> I look into a clean way to do this and get the kernel messages right.
> One thing to change is probably only calculating 'control' if
> !pcie_ports_disabled in negotiate_os_control().

Please also see
https://lore.kernel.org/linux-acpi/93d783c4-4468-023b-193e-3fc6eca35445@redhat.com/
for possible clashes etc.
