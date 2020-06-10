Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBA1F5EE0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 01:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFJXrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 19:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgFJXrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 19:47:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFEC03E96F
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 16:47:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z206so2477403lfc.6
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXDVJ01oPr7+DVOG48ZzBnv0DUZ50rfZMiH97fPmSsY=;
        b=SPFSCgiL1AquGxkTFcoWT8rBLkkuxrQI3VD0O4eTSCQPxHTaNuEIjvgc1S/5qAWrWQ
         HvXYwBFxiSLpvBDxLTDhtnFIoFhaQ9ab1FT8IH9P4C5gQWZQ1mD8xj8grVg61arzhiUH
         Ayw/ZfLpN3h2bCT287+R1+hQnMN2hKZljE7U7c7ZTW9FK+MD1cCK/R8w+GKXs+dKxCHX
         n22xK4HTDzFEk5DIRzcOEafYadSjZWt44sB9Wc0GKEtfZ9BURf2Gc0gGKI7QKCkf2sqN
         ianhbGVgtJ9qzuw7lWIxfK9r5l9+g4bXLBnqacYitBm+ACJQaRcULBtnA9eX2v3M7j2Q
         43gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXDVJ01oPr7+DVOG48ZzBnv0DUZ50rfZMiH97fPmSsY=;
        b=SFHNPZBYoVqvCQYcdL4BvI3lTFIu5edM5uHvp+WiIDBqCel+poh9dQT6hasFtS7xpJ
         ZcAPm/44IQKJIb6Hjk9slgfUBz1CXcgZtIJDFNVlvsMfsNM1aYeHSadW6OjVeSE/mNF3
         j5wztxCHtJq92bZlzVjqPiQoMM7EPjyKswh4ZaaDP4Qw11VlgD7J2ukyb3P9cW7C7c4S
         zuT5KcWW8c/OFVNx4WzqlAM/yVhEXzbA5Zn4L9+5ttfjw7soZg+0qxMvDrS+OI6JcNyF
         XT52A/4DOFC5HhitQfwZlzkZElgDKI8mOAA/Ca4bRuaCnT/dYYt9Cd+Qx0MXpdI+g5yl
         ci4g==
X-Gm-Message-State: AOAM533N5OovdqxXuumI2ByRRzOk2OkPRTDDNSzG8F9KhCf68uu/2xGY
        uDITAlf3BTtZsHjWOoZye+hiktWOZ6N1PglYMk98BA==
X-Google-Smtp-Source: ABdhPJz++I8H5Iwp+DbYjJ8eR5SVWoSY/jHYsbqRWRtXpWSRT9ZTED7WdpFa9h+U0oo/gsd5dGRT1YgzEQEAF9kQ97w=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr2898514lfn.21.1591832833994;
 Wed, 10 Jun 2020 16:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6G3ycsXxuNiihOXiwwAum8=5aOFOshhFa7cEF__+c-v1A@mail.gmail.com>
 <20200610230119.GA1528268@bjorn-Precision-5520>
In-Reply-To: <20200610230119.GA1528268@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 10 Jun 2020 16:46:37 -0700
Message-ID: <CACK8Z6G1dKzSCABvu_Sh1NV81GM0fBZ7HXNBY0jGvgj0FkiQRw@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 4:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 09, 2020 at 05:30:13PM -0700, Rajat Jain wrote:
> > On Tue, Jun 9, 2020 at 5:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> > > > Thanks for sending out the summary, I was about to send it out but got lazy.
> > > > ...
>
> > > > The one thing that still needs more thought is how about the
> > > > "pcieport" driver that enumerates the PCI bridges. I'm unsure if it
> > > > needs to be whitelisted for further enumeration downstream. What do
> > > > you think?
> > >
> > > The pcieport driver is required for AER, PCIe native hotplug, PME,
> > > etc., and it cannot be a module, so the whitelist wouldn't apply to
> > > it.
> >
> > Not that I see the need, but slight clarification needed just to make
> > sure I understand it clearly:
> >
> > Since pcieport driver is statically compiled in, AER, pciehp, PME, DPC
> > etc will always be enabled for devices plugged in during boot. But I
> > can still choose to choose to allow or deny for devices added *after
> > boot* using the whitelist, right?
>
> Yes, I think so.  However, if pcieport doesn't claim hot-added devices
> like a dock, I don't think hotplug of PCI things downstream from the
> dock will work, e.g., if there are Thunderbolt switches in a monitor
> or something.

Yes, understood, thanks.

>
> > Also, denying pcieport driver for hot-added PCIe bridges only disables
> > these pcieport services on those bridges, but device enumeration
> > further downstream those bridges is not an issue?
>
> Right.  Devices without pcieport would not be able to report hotplug
> events, so we wouldn't notice hot-adds or -removes involving those
> devices.

Understood.

Thanks,

Rajat
