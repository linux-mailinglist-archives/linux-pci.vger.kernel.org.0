Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB666FC7CB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfKNNfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 08:35:03 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42970 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNNfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2019 08:35:03 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so6768578ioa.9
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2019 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDMYH8wyhFJnrn+Ox/2VWjvOZYIwEyWGWTeXD5Vgcdk=;
        b=alUJk1RQQwuxGMqaBmhWEA3xWwlf84pGl1oPk1UGnp6sNptml0YSuwSmzfOdaLngvm
         xT9yXTbdpD+5Mmjq9qfgd99SR2Xd9/WKlXVb753/XZB0eLbp2ilzQ814E9RshkDMNePK
         XVYZek9gQ9r5icYTst/3MYqvE102Us7C4+IP6PJpztGtYwAJOGfsJDgi99h4zC/qIsbr
         T7Qkg6ApEJYiJWj7uZVKnz9hfA0NmYN8bzQjkZ4m0zdVL6MqJABjrdaZVHGtXo9p0avt
         9jGDrUjuTVG5fke8UncntagtKL8gq+ZiCqhWBaSriK+N1Z8d7MCKtLzOjZ1Q1dflbKV6
         wXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDMYH8wyhFJnrn+Ox/2VWjvOZYIwEyWGWTeXD5Vgcdk=;
        b=F3cDOVrP7plXXOaGoEOAjTqe3XihGYPFvRL2uchoI2e5ETRvVqb58fXPL0s2aPzqCJ
         bHkAM59dWL/OL4Dvhq95a2fxpGEWGeZTJreI5mHIsNzzCEywADTXSY8LnpDFeM0La9Q8
         G24N5xYS3NfR5zyr0WB+EfC7taKN4hnJco6fN2HYW4ByCtQR8Gaso+6IPXK6hdzRBaxE
         hA0LcwuTJuZUeAY0DKnSmCuN7Wd1rzO9Si5WYMucMpDk43c9w38k0C52CC5oqaqDX9ra
         eKHwILSMOvbXALJuVzAlXfPNUnw/MJsAir1TDXEoltWtOXZUbVFdeuN5kP/AEsBH3krc
         CxSQ==
X-Gm-Message-State: APjAAAWYdeAh1B7t3GxKogJbCpMdO1a/7h9LdLLfDbgUPM2bXARnJnyy
        1Zs+8qTXjqYMl8H6ddc3SenSSV6KzRXuJ/9Ogx8=
X-Google-Smtp-Source: APXvYqw8JmfGbQA+DhukuQdd5C2QtFkiE5/ehse5+R9TvBZT5tIQ4lki5Zbxe09l6ZD+NsFNDDvvJnvONkdK/MFQECE=
X-Received: by 2002:a02:730d:: with SMTP id y13mr7613282jab.124.1573738501850;
 Thu, 14 Nov 2019 05:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20191113094035.22394-1-oohall@gmail.com> <20191113143143.GA54971@google.com>
In-Reply-To: <20191113143143.GA54971@google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 15 Nov 2019 00:34:50 +1100
Message-ID: <CAOSf1CHzBJjxOd0f-CZcGPDW6S5GXMvw+6VmzBADJWeP2y1WAQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Disable native PCIe port management
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci@vger.kernel.org,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 14, 2019 at 1:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> This is fine, but it feels like sort of a blunt instrument.  Is there
> any practical way to clear pci_host_bridge.native_pcie_hotplug (and
> native_aer if appropriate) for the PHBs in question? That would also
> prevent pciehp from binding.

It is a large hammer, but I don't see a better way to handle it for
the moment. I had another look and my initial assessment was wrong in
that it's the portbus driver which claims the MSI rather than pciehp
itself. The MSI in the PCIe capability is shared between hotplug
events, PMEs, and BW notifications so to make the portbus concept work
the portbus driver needs to own the interrupt. Basicly, pnv_php and
portbus are fundamentally at odds with each other and can't be used
concurrently.

I also think there's some latent issues with the interaction of DPC
and EEH since they operate off the same set of error messages. We
haven't run into any problems yet, but I think that's largely because
we haven't shipped any systems with DPC enabled. In any case, I'd
prefer we disabled portbus until we've fully unpacked what's going on
there.

> We might someday pull portdrv into the PCI core directly instead of as
> a separate driver, and I'm thinking that might be easier if we have
> more specific indications of what the core shouldn't use.

It's not intended to be a permanent change. In the long term I want to
move everything except the initialisation and reset of the PHB out of
firmware and into the kernel so we can use more of the native PCIe
management features.
