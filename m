Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0893D39DD10
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFGM63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 08:58:29 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38543 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhFGM61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 08:58:27 -0400
Received: by mail-ot1-f54.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so2977319otk.5;
        Mon, 07 Jun 2021 05:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DkD40e1ud2+Lz0j9WJ/X3IfNp4wJD7XrnysEWFbAiw=;
        b=gIQscirmBhtRIZJzNZEw0DsdLolrtsOY1fvd2Juwsj+vm1A5vTd4Te2WMZSrr33prS
         hgO8hw2SgU0Z+uhfjp9xOqJCbDWZR6My3s9w/QLJbBrIZAw/BEp2Dy5yoO6QcGpCZLM9
         gPsjCQgZEF8vJ4Z3WvXr8EMc9TPPXYzbdAy1q9eh1FTs0XaK70osuaHvbQx5oI8sm1J0
         Dv8zKsbrzDLTrmu1K1Q0YQjz9i4grxZ3O5Yzv1nuCck/fFPfjddYFGObW9OzZwepUPTq
         YQ9jerME8zD/eG+J92rNpkTX6qL7Yc0sIvHruDrOPEUGmjKd6JE8olfEO8ijQPBO3iGO
         esfQ==
X-Gm-Message-State: AOAM5330KOPYSC3faTD2DFKh/RMjeUthuHq/MJxfZAB+P9SCxPqgDbgK
        c5XVL+1Iv0qiZDG+kDCk1oW/67i/+wnn6l1XmhE=
X-Google-Smtp-Source: ABdhPJwE9Lrt+4ka8G8lR7rGMbn/DVUAEq32u4i2XbXDqLWhuOCbBO4k7oPfPNtyW93en1oGmqPhiMq18xNrgXJxURo=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr10418092otq.321.1623070596029;
 Mon, 07 Jun 2021 05:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210603205047.GA2135380@bjorn-Precision-5520> <20210604170938.GA2218177@bjorn-Precision-5520>
In-Reply-To: <20210604170938.GA2218177@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:56:24 +0200
Message-ID: <CAJZ5v0iDxpYxz3_8RrWSJkM7cf=xS298agXcULm3EqRC++GD2g@mail.gmail.com>
Subject: Re: [PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 4, 2021 at 7:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jun 03, 2021 at 03:50:47PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 03, 2021 at 02:48:14PM +0200, Joerg Roedel wrote:
> > > From: Joerg Roedel <jroedel@suse.de>
> > > ...
>
> > > -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
> > > +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32
> > > +                                       *mask, u32 req, u32 support)
> > >  {
> > >     struct acpi_pci_root *root;
> > >     acpi_status status;
> > > @@ -370,7 +361,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
> > >
> > >     /* Need to check the available controls bits before requesting them. */
> > >     while (*mask) {
> > > -           status = acpi_pci_query_osc(root, root->osc_support_set, mask);
> > > +           status = acpi_pci_query_osc(root, support, mask);
> > >             if (ACPI_FAILURE(status))
> > >                     return status;
> > >             if (ctrl == *mask)
> > > @@ -433,18 +424,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> > >             support |= OSC_PCI_EDR_SUPPORT;
> > >
> > >     decode_osc_support(root, "OS supports", support);
> > > -   status = acpi_pci_osc_support(root, support);
> > > -   if (ACPI_FAILURE(status)) {
> > > -           *no_aspm = 1;
> > > -
> > > -           /* _OSC is optional for PCI host bridges */
> > > -           if ((status == AE_NOT_FOUND) && !is_pcie)
> > > -                   return;
> > > -
> > > -           dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> > > -                    acpi_format_exception(status));
> > > -           return;
> > > -   }
> > >
> > >     if (pcie_ports_disabled) {
> > >             dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> >
> > Also not related to this patch, but it seems pointless to compute and
> > decode "support" above when we're not going to use _OSC at all.  I
> > think the "pcie_ports_disabled" test should be the very first thing in
> > this function (I'm assuming the "pcie_ports=compat" command line
> > argument *should* apply even on x86_apple_machine, which it doesn't
> > today).
>
> I think I was wrong about this.  Even when "pcie_ports_disabled", the
> current code *does* evaluate "_OSC(Query, SUPPORT=x, CONTROL=0)",
> i.e., it tells the platform what Linux supports, but doesn't request
> control of anything.
>
> I think the platform may rely on this knowledge of what the OS
> supports.  For example, if we tell the platform that Linux has
> OSC_PCI_EXT_CONFIG_SUPPORT, that may change the behavior of ASL that
> accesses config space.
>
> So I don't think it's safe to move this test to the beginning of the
> function as I proposed.
>
> For the same reason, I'm not sure that it's safe to remove
> acpi_pci_osc_support() as in this patch.

No, it isn't AFAICS.

[I was about to comment on this, but you were faster.]

>  If either "pcie_ports_disabled" or Linux doesn't support everything in
> ACPI_PCIE_REQ_SUPPORT, we will never evaluate _OSC at all, so
> the platform won't know that Linux has OSC_PCI_SEGMENT_GROUPS_SUPPORT,
> OSC_PCI_HPX_TYPE_3_SUPPORT, OSC_PCI_EXT_CONFIG_SUPPORT, etc.

Right.
