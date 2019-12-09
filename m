Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD3117131
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLIQLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 11:11:07 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44015 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIQLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 11:11:07 -0500
Received: by mail-il1-f195.google.com with SMTP id u16so13179012ilg.10;
        Mon, 09 Dec 2019 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=V1rQj2NYpyrjZuSj9vZCVjr8OoOEApgs5CD1MbhwecM=;
        b=URz2es964aBg/tgzcHlwyqPIOI4zN8TSjwiGZ8xcptQ5xFQKA1+8VK9Q+bSAiyZPkt
         74U96aFbCX1Vn0Im6NR7EzpsCgPqfqdODHuB33UHFQBfSpKJjtC9Tw9LcQVBqUIF3jGI
         gCk3Ts8CIo4T4VRYAdJIKKuyMZJ4adIq5PWx7YmpIBaCrurtNXC76eBlhMFs7I8Lv5+0
         YoeSBdX8JSuTVZQ6PIS0G3GjCmOFhCDRFvj93byVGJzXYHt4YJ52yyYOiF09c0tNpxhH
         Be3AA8H6Rnr+6dj7Ykd97lapmM4QO+fshpQWO0J07qmm+AOl4rgm7Cb+iWiZdx9tzWiF
         6Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=V1rQj2NYpyrjZuSj9vZCVjr8OoOEApgs5CD1MbhwecM=;
        b=W+ZPj6GxT/yyxj4qPK/rZO0wDOMr4OUvcfYPDNTZ+3jB7fmhLO9c25grq2NZ2g5lAo
         orJQ7HIvugR3RWoTqBLFfPiRUHUWb2gv9JkYHDnIWN9xf3Twxw5BjYKaDd1AZ/PLiKSA
         kdB3Gb/ZSHssZ3dtvhSj5mOez7LkkC148a/DZvs8kljKh/u9utu+AKH6Y5FYjcA2zEwH
         YtrS6f63AbJQv6HAFbjMIk4/uQkYqW73DDYZO8hGeklQWf0/7iAtKacXM6hDdykaM8So
         82Y2mzel2P9GYWcw90hcXOUnCk83/RtN1qdT0hBOiVi+6QXGOnZOyCwMUUOVpWNG6kiS
         HBiw==
X-Gm-Message-State: APjAAAXdWlM8NYEm8sGWr8OwsHjSOy49OT64AZUd6YrDNS3zXAwrFtDw
        Nb3c9dL1T/Beh/FFjs01AiPGDELGHjMMfbGPdis=
X-Google-Smtp-Source: APXvYqz0nWHT53HKk7dsGX4luv1vsXxIjyyy+6bEaibX3GI/XQkhJ3tLcZNkrwGMUE6JA9WhNqD08VhRtGUdBkigH/8=
X-Received: by 2002:a92:3b19:: with SMTP id i25mr28698139ila.85.1575907866282;
 Mon, 09 Dec 2019 08:11:06 -0800 (PST)
MIME-Version: 1.0
References: <PSXP216MB043824762539AFC40143D75880490@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB043824762539AFC40143D75880490@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 9 Dec 2019 10:10:55 -0600
Message-ID: <CABhMZUXOQXruHnZARVqe8cdkuhGXenMZ__7GhaJtDDsdBrcoyQ@mail.gmail.com>
Subject: Re: [[RFC PATCH v1] 0/1] Add pci=nobbn to ignore ACPI _BBN method to
 override host bridge bus window
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 9:02 PM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> Hi all,
>
> I want to be able to override the bus resource from ACPI, but nocrs does
> not do it. I am putting this out here to get a feel for the sentiment
> for doing something like this.

This should be cc'd to linus-pci and linux-acpi (added).  I only
noticed this message by accident.  And I don't see the patch at all.

> What is my motivation for doing this?
>
> I have a Gigabyte Z170X Designare motherboard which only gives resource
> [bus 00-7e]. I want the full [bus 00-ff] because I am trying to add as
> many Thunderbolt 3 ports with add-in cards as possible. Thunderbolt
> consumes bus numbers quickly. An Intel Ice Lake implementation (ideal)
> consumes 42 busses per port, but prior solutions consume 50 busses per
> port and have additional busses required for the NHI and USB
> controllers, as well as the bridges from the root port.
>
> Why not change nocrs to do this? Why the new kernel parameter?
>
> I imagine that on systems with multiple PCI root complexes, things will
> get hairy if we do this, if they are not placed on separate segments /
> domains by the firmware. I do not own such a beast, but from what I
> understand, the firmware normally places them on the same segment /
> domain with non-overlapping bus numbers. But we may still want to use
> nocrs for other reasons. I need to use nocrs to allow Linux to allocate
> vast amounts of MMIO and MMIO_PREF under the Thunderbolt root ports
> without the BIOS support for Thunderbolt. Hence, they should be kept
> separate.
>
> Why do this in general?
>
> The bus resource is still a resource which is specified from ACPI, just
> like those overridden by nocrs. Even if we do not use pci=nocrs to
> override it, it should be possible to override it, just as it is
> possible to override _CRS.

pci=nocrs is for working around defects in firmware or Linux.  The
firmware knows more about the platform than Linux, and in general we
have to trust it.  We probably should taint the kernel when we use it.

Any parameter like this should work the same on all ACPI systems,
including ia64 and arm64, and should probably also taint the kernel.

I can't see the patch itself, but I'm a little confused because we
normally get the bus number range from _CRS in acpi_pci_root_add() and
your patch doesn't appear to touch that.

> Nicholas Johnson (1):
>   PCI: Add pci=nobbn to ignore ACPI _BBN method to override host bridge
>     bus window
>
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++
>  arch/x86/include/asm/pci_x86.h                  |  1 +
>  arch/x86/pci/acpi.c                             | 11 +++++++++++
>  arch/x86/pci/common.c                           |  3 +++
>  4 files changed, 17 insertions(+)
>
> --
> 2.24.0
>
