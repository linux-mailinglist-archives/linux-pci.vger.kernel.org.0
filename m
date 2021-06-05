Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F139CA5F
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFESBb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 14:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFESB0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 14:01:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BBBB61207;
        Sat,  5 Jun 2021 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622915977;
        bh=+m6ukrIPO4xJevQuRTPTFq75jUE+SME0F7kUAmTu+Ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UtZaAexyUu7F1ciFLDax6nONXSlyu8wH3AafvYl3SY617tO1DvGH9lmvBDzYcQxPG
         +HVjcnHYOVK4ZBwi4v9RLxY+Lvp65wyVw8PWHvM8ygS1L/HmU0MzEotWBxS2aI3QLL
         2lKbMLTd0fz7LxcUyJfgCgnkxZ8DjCcwrYRG8GLapL3nvC0IT+Txi7rwMUL6SYYcnK
         Vfcqu+bnPfDWoTp1A4a+kfgTKvWMEC9NEA2NRhLfXfLjHFEpL7oOUryX4z696DMAwD
         ZmpuXRaWtjh41YnSgGqPvi+o46DmWIg3vgnVfAUw4CCYdz+7jsLAtDHWwr+z7AbGss
         BPIawEF8/5JhQ==
Date:   Sat, 5 Jun 2021 12:59:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] vgaarb: Call vga_arb_device_init() after PCI enumeration
Message-ID: <20210605175936.GA2309279@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6MCGXiO3EcZV2BZi91AiUNsu2aZ=e9g4e2tcVVNOLbfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 05, 2021 at 10:02:05AM +0800, Huacai Chen wrote:
> On Sat, Jun 5, 2021 at 3:56 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jun 04, 2021 at 12:50:03PM +0800, Huacai Chen wrote:
> > > On Thu, Jun 3, 2021 at 2:31 AM Bjorn Helgaas <bhelgaas@google.com> wrote:

> > > > I think the simplest solution, which I suggested earlier [1],
> > > > would be to explicitly call vga_arbiter_add_pci_device()
> > > > directly from the PCI core when it enumerates a VGA device.
> > > > Then there's no initcall and no need for the
> > > > BUS_NOTIFY_ADD/DEL_DEVICE stuff.  vga_arbiter_add_pci_device()
> > > > could set the default VGA device when it is enumerated, and
> > > > change the default device if we enumerate a "better" one.  And
> > > > hotplug VGA devices would work automatically.
> > >
> > > Emm, It seems that your solution has some difficulties to remove
> > > the whole initcall(vga_arb_device_init): we call
> > > vga_arbiter_add_pci_device() in pci_bus_add_device(), the
> > > list_for_each_entry() loop can be moved to
> > > vga_arbiter_check_bridge_sharing(),
> > > vga_arb_select_default_device() can be renamed to
> > > vga_arb_update_default_device() and be called in
> > > vga_arbiter_add_pci_device(), but how to handle
> > > misc_register(&vga_arb_device)?
> >
> > Might need to keep vga_arb_device_init() as an initcall, but
> > remove everything from it except the misc_register().
>
> OK, let me try. But I think call  vga_arbiter_add_pci_device() in
> pci core is nearly the same as notifier.  Anyway, I will send a new
> patch later.

Notifiers are useful in some situations, for example, if a loadable
module needs to be called when a device is added or removed.

But when possible, I will always choose a direct call instead because
it's much less complicated.  The VGA arbiter cannot be a loadable
module, so I don't think there's any reason to use a notifier in this
case.

Bjorn
