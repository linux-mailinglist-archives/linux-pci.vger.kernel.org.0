Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21DEA5DD4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 00:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfIBWe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 18:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfIBWe0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Sep 2019 18:34:26 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E3C20828;
        Mon,  2 Sep 2019 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567463665;
        bh=zxlvym5oukUFwGFmYoTL3hfULUu15glsaWNaltuAHQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2VF1hCrTx8UXbNVzbEJTQBDYiDTWB3w3Ox0RHaYOY5RRhQ5V/j+ozlBJxChYpApF4
         Drfuru1BaFWEKuzaJP2l2CTB/an/+V9HKHXtFLAO9tNDzoFWVL68on8utckiXIRLxr
         Ye/no9smui7FCfY4IYYzP824+yi2GfONsyQWSi2Y=
Date:   Mon, 2 Sep 2019 17:34:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI / PCI: fix acpi_pci_irq_enable() memory leak
Message-ID: <20190902223424.GJ7013@google.com>
References: <1566359059-4844-1-git-send-email-wenwen@cs.uga.edu>
 <CAJZ5v0gm3Mv0-6fVe+7v4Kd49xG6W=TXcxfTJthpe9o46n4EEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gm3Mv0-6fVe+7v4Kd49xG6W=TXcxfTJthpe9o46n4EEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 02, 2019 at 11:19:58PM +0200, Rafael J. Wysocki wrote:
> On Wed, Aug 21, 2019 at 5:44 AM Wenwen Wang <wenwen@cs.uga.edu> wrote:
> >
> > In acpi_pci_irq_enable(), 'entry' is allocated by kzalloc() in
> > acpi_pci_irq_check_entry() (invoked from acpi_pci_irq_lookup()). However,
> > it is not deallocated if acpi_pci_irq_valid() returns false, leading to a
> > memory leak. To fix this issue, free 'entry' before returning 0.
> >
> > Fixes: e237a5518425 ("x86/ACPI/PCI: Recognize that Interrupt Line 255 means
> > "not connected"")
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> 
> Bjorn, any more comments?

Nope, looks fine to me.

> > ---
> >  drivers/acpi/pci_irq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > index d2549ae..dea8a60 100644
> > --- a/drivers/acpi/pci_irq.c
> > +++ b/drivers/acpi/pci_irq.c
> > @@ -449,8 +449,10 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >                  * No IRQ known to the ACPI subsystem - maybe the BIOS /
> >                  * driver reported one, then use it. Exit in any case.
> >                  */
> > -               if (!acpi_pci_irq_valid(dev, pin))
> > +               if (!acpi_pci_irq_valid(dev, pin)) {
> > +                       kfree(entry);
> >                         return 0;
> > +               }
> >
> >                 if (acpi_isa_register_gsi(dev))
> >                         dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> > --
> > 2.7.4
> >
