Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865133DEABA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhHCKTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhHCKTy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 06:19:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2359C06175F;
        Tue,  3 Aug 2021 03:19:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t3so21004354plg.9;
        Tue, 03 Aug 2021 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7RnLTo1duVJvP6tLxEr595jWac0+5GeUDVvQVHcqHw=;
        b=KN2u/kABvY84pUcpffrlhIsxuY9/C2uY0va5yFYWn8ZEaIlxEsthJuMbC1UqYbB7Xc
         VNXPHviFqwdNehgCxm+QGOr6oCUokHZ0vBNefe/wHKqBAcnmynU/jjcPGPYprTyyvNX9
         R946PjvD07V7wJSe3TaSuI1xDrVcXN6uz+O18WpueokEERDC8+Fu3d5rXQFscSPVUJHZ
         AWgXBC5gPiv9rvYDAVF1lsE7Vj3H4ofW3kA2wQ1U7FK/VrIlU0+881x1SYzRLllPT3iD
         3MTHMqOXRLYYUTeOrsy7trTExcSE41XxZObua8dACBw6GZ5vpb6Z2w3pc5saeVDAv4Ry
         ElrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7RnLTo1duVJvP6tLxEr595jWac0+5GeUDVvQVHcqHw=;
        b=JcB5k6BrWZ6+Cpd86JgNwwDwM9zW6MMIzCrT9s2XxUGSH3Ggjoe3OEtfIDV4p/xYsq
         lAaVlSyA2m8GyQvcNWJXuFTePQffRgoeDkVY9QejDH9aZU5uDC6a6lYIapfyMponNayd
         3VA3KescwPezg7zU1ZaBkpMtGLE9aizrMm8IvjcbZtsbrkf7U1GyIX8E0f0DO5kazaAn
         temPzMgPU8jK3rXm7UWJmROHw6gEaMMCfN75diEG382PyXZ89XrJrfnBgL9Sos++rlVj
         U3BWX/zIwk6CSO0yeTJzedghacdVAAPP637455s8vlUOVf2ge24JFseHjHiz6RbiZ+M/
         /AXw==
X-Gm-Message-State: AOAM5307WuOKj5IzRz4W65gzkg3qC7SUsiKf6bYeehqts3jsUcF/AoTZ
        Jx1+r74H90f5A1xS5R7R2CS4NxC7fUb8ov3HBxo=
X-Google-Smtp-Source: ABdhPJy+rTe0WWJKWfgUD5NiYTKWFd0/T4ONqgUvyaBzg+FYi56KGtPJ6MVhY0FmVEPN0Rl5CYM4YFGCT6tTE7pzhFk=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr21285120pfi.7.1627985982087; Tue, 03
 Aug 2021 03:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210730205355.26504-1-andriy.shevchenko@linux.intel.com> <20210802231643.GA1474171@bjorn-Precision-5520>
In-Reply-To: <20210802231643.GA1474171@bjorn-Precision-5520>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Aug 2021 13:19:05 +0300
Message-ID: <CAHp75VeKvBqi=vhkq0Vqv76t3qKzWmy_v_ZmeL4mbPztmcGb7g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/PCI: Introduce pcibios_is_irq_managed() helper
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 3, 2021 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jul 30, 2021 at 11:53:55PM +0300, Andy Shevchenko wrote:

...

> > -     if (!pin || !dev->irq_managed || dev->irq <= 0)
> > +     if (!pin || !pcibios_irq_is_managed(dev))
>
> This file may be compiled for x86, arm64, and ia64, but it looks like
> you only defined pcibios_irq_is_managed() for x86.

Ah, right. Ignore this patch.
Thanks for the review!

-- 
With Best Regards,
Andy Shevchenko
