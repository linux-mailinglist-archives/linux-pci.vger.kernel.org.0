Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD56479758
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 23:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhLQWtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 17:49:22 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38475 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLQWtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 17:49:22 -0500
Received: by mail-wr1-f50.google.com with SMTP id e5so6712362wrc.5
        for <linux-pci@vger.kernel.org>; Fri, 17 Dec 2021 14:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+zwBYz2rStMxuQvVIe3HNcHUxCoOwjQ5fC3olK8tdk=;
        b=Fk7U5ttOjCtjvtsINB4LKm9Xcdrwwpm3KCTHiKqeHUOz1qfAu9lJ6ognohnp2Lg61X
         S1D2WWGQQI63/nTwMZV5/OEmo6jmsAQxHPhq7upl96W1UTUwpPdqOJjliUq8WFSPTsIu
         gJJNdBWkD1lN6ifqoqLCyEam476LCfPva97aKNvt8pK0hNVgNafP2nvJ/D1ae63cRaJI
         mOzJLcbY7a9YMU6m6tV1OT/X6Mr5OJssfouOyrRu6YEby5ANj09zGIbHHttgDoYNnS8p
         BgJRINIY6O7FpO6S+lOFgbkpzU1chBpmVjR/DUL+mjNzADT/LpGA54bqkormutCE0HHz
         p8mQ==
X-Gm-Message-State: AOAM532+MJW/p7gxwFTt08UFeeYjv7R3glUIOBpzU19f4C0kufxtd367
        vLTjlDr+UoWa7zwuzsojjWo=
X-Google-Smtp-Source: ABdhPJxKy0HV0a9AsU/fGx2Q/C6TL4x5d0TUT3FFrhyQ6o2wPEvYhURsnQQ2NbkAnNlRkEQj/IJyzw==
X-Received: by 2002:adf:c182:: with SMTP id x2mr4171130wre.646.1639781360821;
        Fri, 17 Dec 2021 14:49:20 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c7sm10186096wrq.81.2021.12.17.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:49:20 -0800 (PST)
Date:   Fri, 17 Dec 2021 23:49:19 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] 527139d738d7 ("PCI/sysfs: Convert "rom" to static
 attribute")
Message-ID: <Yb0T79vFgeRcA2OU@rocinante>
References: <YbxqIyrkv3GhZVxx@intel.com>
 <20211217172928.GA900484@bhelgaas>
 <YbzMyDm+5PCer8Fj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbzMyDm+5PCer8Fj@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ville,

Thank you for letting us know, and sincere apologies for troubles!

[...]
> > > The pci sysfs "rom" file has disappeared for VGA devices.
> > > Looks to be a regression from commit 527139d738d7 ("PCI/sysfs:
> > > Convert "rom" to static attribute").
> > > 
> > > Some kind of ordering issue between the sysfs file creation 
> > > vs. pci_fixup_video() perhaps?
> > 
> > Can you attach your complete "lspci -vv" output?  Also, which is the
> > default device?  I think there's a "boot_vga" sysfs file that shows
> > this.  "find /sys -name boot_vga | xargs grep ."
> 
> All I have is Intel iGPUs so it's always 00:02.0. 
> 
> $ cat /sys/bus/pci/devices/0000\:00\:02.0/boot_vga 
> 1
> $ cat /sys/bus/pci/devices/0000\:00\:02.0/rom
> cat: '/sys/bus/pci/devices/0000:00:02.0/rom': No such file or directory
> 
> I've attached the full lspci from my IVB laptop, but the problem
> happens on every machine (with an iGPU at least).
> 
> I presume with a discrete GPU it might not happen since they
> actually have a real ROM.

Admittedly, the automated testing I was running before the patch was released
didn't catch this.  I primarily focused on trying to catch the race condition
related to the ROM attribute creation.

I need to look into how to properly address this problem as if we were to
revert the ROM attribute changes, then we would introduce the race condition
we've had back.

Again, apologies for troubles this caused!

	Krzysztof
