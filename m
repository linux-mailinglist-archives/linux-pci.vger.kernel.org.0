Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8526AD32
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgIOTMc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 15:12:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46630 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgIOTLD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 15:11:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so4280448otm.13;
        Tue, 15 Sep 2020 12:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2OPX6Jv3wcciNIio8f8x5TwqcQAAkt3nwkZUuR7d58=;
        b=Cf01lpoCXyANxJBYYzCslLOfEWllyF+5TzFBNV+NLs3PeUXiEbDdj287oX6IK07omw
         4w79DNxtOiWiuQIDe1hXdiuNsuYB7miFAxYFsEaWl2WC7JeObizbZHVo13uIh6SI5RGx
         Ca1odItF7b6B/+yPYGNNpiyT6Hi28239olGgOw5tB3svmiEBBXMT0pJzm6LoRXr0vU6b
         Vlvb0tIfJr6ayE7n6yaNrQGx+BWbGxpCh4rjXSvbhKNkhL9J8OsdB3ZxxoJQ98okL+Uy
         0mgjLt9xLPFKXjr0nhenaauzz39XzleQ2ChmXxuK2fVvryyJqJLxT9L+O+2mA4uOG0B1
         HAYw==
X-Gm-Message-State: AOAM530xIfFw855kuaYm7shYAq6aQOIrJVr+KlxSbB41CPIizKZ3xNq7
        x29JMJqglmVkQGj3dZpB4o8v55HGCaMlZlbK8LY=
X-Google-Smtp-Source: ABdhPJz1JhIRVtWf0NEjJBqdrSH0g/D7+QczdoXZkIgFGBIFeIxXRwKN0WkLqrnCZOjxiaNGkE0xLX0hR4Ftsp1hYTY=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr14029175otj.262.1600197062231;
 Tue, 15 Sep 2020 12:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0goduHVhXdOjDu6WBnD8eBYzRWAD1PO8KjabpyiHuJ1qw@mail.gmail.com>
 <20200915181751.GA1408867@bjorn-Precision-5520>
In-Reply-To: <20200915181751.GA1408867@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Sep 2020 21:10:50 +0200
Message-ID: <CAJZ5v0gt4pK3g0o2pj2NjTar7JhXzO0g_b7gWOD97_dQb4OMWg@mail.gmail.com>
Subject: Re: [PATCH v15 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 8:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 15, 2020 at 07:31:50PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Sep 14, 2020 at 2:34 PM Shiju Jose <shiju.jose@huawei.com> wrote:
> > >
> > > Hello,
> > >
> > > Can you help to merge this series?
> >
> > Do you want this series to go in through the ACPI tree?
>
> It crosses ACPI and vendor-specific PCI, but the bulk of the changes
> are in PCI.  I gave some comments on the design and acked the PCI part
> from my point of view.  I envisioned Lorenzo merging it since he takes
> care of drivers/pci/controller/*, but either that (given your ack for
> the ACPI part) or ACPI would be OK with me.

Well, please feel free to add an ACK from me to this then.

Cheers!

> > > > drivers/acpi/apei/ghes.c                 |  63 +++++
> > > > drivers/pci/controller/Kconfig           |   7 +
> > > > drivers/pci/controller/Makefile          |   1 +
> > > > drivers/pci/controller/pcie-hisi-error.c | 327 +++++++++++++++++++++++
> > > > include/acpi/ghes.h                      |  18 ++
> > > > 5 files changed, 416 insertions(+)
> > > > create mode 100644 drivers/pci/controller/pcie-hisi-error.c
