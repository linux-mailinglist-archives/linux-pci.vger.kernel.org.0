Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197F9453CB2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhKPX3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 18:29:18 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38640 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhKPX3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 18:29:18 -0500
Received: by mail-ed1-f51.google.com with SMTP id m20so2178653edc.5;
        Tue, 16 Nov 2021 15:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nbWCNLbjUMnvi186S+MdyqIKhmDSGLuAJAqgoanh8sA=;
        b=0pJuPur/zXVOFU7uQa3rSnaV4UmD4eIXCt8v8L0JUabNyYvuaxYBPGofe6gr8638OM
         aaT0aVNEFJOnojnzNikzMlUtFbYrHqWzJmHr2NKh9FDrxFxp1EwObPK/ya78ONIMBi9f
         SvQ9qPDgQqdWPJflUnIyA/4h77xhMZel7yhxGz0AiibQN57WFY2ofvBoZbuJyeEEKHfi
         md08hp80cywVhdIku2nT7MygLI8vxIGrgWTh4kXfD/tbawF/CJ5DXS2c16OUIT37Grjc
         gyJKmoTzb/hYltGHt98j3kzOYxoUz0hdBD/3jFZJEOcAcq7xmm0vkloa1cOGtXMGtA8T
         m/iQ==
X-Gm-Message-State: AOAM531WjKbTz9MXuVggOewFyI7JY1C1TR+zpDFIN/opqqigY+24e3du
        LcVKsapX2dZ2h2F+IVJiWgI=
X-Google-Smtp-Source: ABdhPJzpr2kNRSRO/A86nAwNJl4pN44/OY6tgMFiJmIP2NHwLDerIx1t16OWbKiZ8T2/xT8Bk3yFAw==
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr14994733ejc.375.1637105179498;
        Tue, 16 Nov 2021 15:26:19 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id sh33sm9165253ejc.56.2021.11.16.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:26:19 -0800 (PST)
Date:   Wed, 17 Nov 2021 00:26:18 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Yuji Nakao <contact@yujinakao.com>, linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Message-ID: <YZQ+GhRR+CPbQ5dX@rocinante>
References: <87h7ccw9qc.fsf@yujinakao.com>
 <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Arnd, Bjorn, Marc and Sasha for visibility]

Hello Damien and Yuji,

[...]
> > I'm using Arch Linux on MacBook Air 2010. I updated `linux` package[1]
> > from v5.14.16 to v5.15.2 the other day, and the boot process stalled
> > with the following message.
> > 
> > ```shell
> > :: running early hook [udev]
> > Starting version 249.6-3-arch
> > :: running hook [udev]
> > :: Triggering uevents...
> > Waiting 10 seconds for device /dev/sda3 ...
> > ERROR: device '/dev/sda3' not found. Skipping fsck.
> > :: mounting '/dev/sda' on real root
> > mount: /new_root: no filesystem type specified.
> > You are now being dropped into an emergency shell.
> > sh: can't access tty; job control turned off
> > [rootfs ]#
> > ```
> > 
> > In the emergency shell there's no `sda` devices when I type `$ ls
> > /dev/`. By downgrading the kernel, boot process works properly.
> > 
> > See also Arch Linux bug tracker[2]. There are similar reports on
> > Apple devices.
> > 
> > `dmesg` output in the emergency shell is attached. I guess this issue is
> > related to libata, so CCed to Damien Le Moal.
> 
> I think that this problem is due to recent PCI subsystem changes which broke Mac
> support. The problem show up as the interrupts not being delivered, which in
> turn result in the kernel assuming that the drive is not working (see the
> timeout error messages in your dmesg output). Hence your boot drive detection
> fails and no rootfs to mount.
> 
> Adding linux-pci list.
> 
> 
> 
> > 
> > Regards.
> > 
> > [1] https://archlinux.org/packages/core/x86_64/linux/
> > [2] https://bugs.archlinux.org/task/72734

The error in the dmesg output (see [2] where the log file is attached)
looks similar to the problem reported a week or so ago, as per:

  https://lore.kernel.org/linux-pci/ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de/

The problematic commits where reverted by Bjorn and the Pull Request that
did it was accepted, as per:

  https://lore.kernel.org/linux-pci/20211111195040.GA1345641@bhelgaas/

Thus, this would made its way into 5.16-rc1, I suppose.  We might have to
back-port this to the stable and long-term kernels.

Yuji, could you, if you have some time to spare, try the 5.16-rc1 to see if
this have gotten better on your system?

	Krzysztof
