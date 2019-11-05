Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74CF026E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbfKEQPO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 11:15:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33317 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390096AbfKEQPN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 11:15:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so18135641ote.0;
        Tue, 05 Nov 2019 08:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT4en3y5QgVMI33vOLDv0psnHaObzkIn5HyOngHG/js=;
        b=ouyYXgW0jAZ+w+GC+edAT/Y/kTMiX8B3uANXn3hmFczhKezYkKk1td11RLnBg3WK8T
         Hueu/SPlvr/2B95A9yIGW1E3tGNg4bYoTz4zmCDTcl1oY/AVQZPQmgMWkyNwB8OfoPWV
         IdwbJSRl9veKpgtU2EvsAikkqqPqEJtNhRu52Eof1P6D5zWj9w9WcCtnCO/ApzKRkOnD
         NhctdXW4XI6M1tFol2sBxXaf5lnFqMpkir9TiyjX5PidpFiAysHj0v7Gzr0b2AEbjis0
         G0WSP1LllxbIVHIkd5UtJa1RhesXM0Qg15KjATdrboEFpK7psIzIV7+aNiIULFqh9lnW
         AgoQ==
X-Gm-Message-State: APjAAAWoCP1nF9LNMk9UgbaQT8RBlu3hNPuIjoHNTYTyrNJ0ohOqp2EO
        44SFqzG/P4J5NDO8Nb1x/2JEkDlaXglw314UEKc=
X-Google-Smtp-Source: APXvYqxPByCUHFEGufCUJNmU7TyKG4nMDGVEUpuw3GX3YTjqrQQnhSLG7mBe9+fFh64RFCNxxpPec86rL+o++PouL0s=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr12462593oth.118.1572970512569;
 Tue, 05 Nov 2019 08:15:12 -0800 (PST)
MIME-Version: 1.0
References: <2771503.n70vfTtcVb@kreacher> <1769241.yKxyosiRnQ@kreacher> <20191105160943.GA19190@infradead.org>
In-Reply-To: <20191105160943.GA19190@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Nov 2019 17:15:01 +0100
Message-ID: <CAJZ5v0gd84S3MBjTMJfs8NZu92QcdFAin4WEwVqWVzXrrC1vrw@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: PM: Fold __pci_complete_power_transition() into
 its caller
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 5, 2019 at 5:09 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 05, 2019 at 11:32:02AM +0100, Rafael J. Wysocki wrote:
> >       if (state > PCI_D3cold)
> > @@ -1132,10 +1112,12 @@ int pci_set_power_state(struct pci_dev *
> >       error = pci_raw_set_power_state(dev, state > PCI_D3hot ?
> >                                       PCI_D3hot : state);
> >
> > -     if (!__pci_complete_power_transition(dev, state))
> > -             error = 0;
> > +     ret = pci_platform_power_transition(dev, state);
> > +     /* Powering off a bridge may power off the whole hierarchy */
> > +     if (!ret && state == PCI_D3cold)
> > +             pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
> >
> > -     return error;
> > +     return ret ? error : 0;
>
> Total nitpick, but why not:
>
>         if (pci_platform_power_transition(dev, state))
>                 return error;
>
>         /* Powering off a bridge may power off the whole hierarchy */
>         if (state == PCI_D3cold)
>                 pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
>         return 0;

Yes, that looks better, thanks!

I'll send an update of this patch.
