Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1D04A7F4E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiBCGaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 01:30:16 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:40810 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiBCGaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 01:30:15 -0500
Received: by mail-ej1-f52.google.com with SMTP id p15so5210283ejc.7;
        Wed, 02 Feb 2022 22:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIJreCKz/SJbcBKjXLSiF43XHyFyKZFV5R89niE6+hI=;
        b=Lrws37/tRvKP2+lJGCm7cDDhXJYNtz3RDpbJUKUh9ZEDums425U7wgC2gUD5NZ06Pq
         J8HLoh9+Vb2QGgESxb57nk3f8pHMJBdD+Ooy5NpinpyrtwTaIXOQRV2rI6gnAMcmdkPQ
         zSxXxA2JOSxYQ7JYv/4RLcewwFQt68g49ESWAOfuso0ZyyleHZ8o3pEizp2A2t7issid
         x7s9le3XpuLpwdzaZUCnuW6a02JXFUVljg0rm4z4+SEjWXyWsf6+lvrrXl+LGgkfCInP
         3hR+49CfnYhJmt9vbAW3P0Gl5KzmsPxsP/ioDE3zT/i4eVuuXUbfT/KJC2xMreKGiAKc
         OtXw==
X-Gm-Message-State: AOAM531Ar/Xb5MhH0+NKMZW+3GJYAWzvdmIWeDFx7e7LFCvl8BDJn9bN
        v9r2KR7FdOA92LOjrZjrCfH44IKhAxgRxhquKI0=
X-Google-Smtp-Source: ABdhPJwXyFRsg8MRvg08wpBt6nQoKnqrilsYine7HfCVT0qvjcRqOAddgQyU3xbLTY4CuzcCTGJJKmHfiljbVj8cEtY=
X-Received: by 2002:a17:907:da6:: with SMTP id go38mr20120525ejc.124.1643869814413;
 Wed, 02 Feb 2022 22:30:14 -0800 (PST)
MIME-Version: 1.0
References: <CAGwJgaMDJH-rhsc9+_vj1vjj6XLigvqVYLdu-6TgrDNxGpTubA@mail.gmail.com>
 <20220202224239.GA49678@bhelgaas>
In-Reply-To: <20220202224239.GA49678@bhelgaas>
From:   Brent Spillner <spillner@acm.org>
Date:   Thu, 3 Feb 2022 06:29:48 +0000
Message-ID: <CAGwJgaNcWA9bP4LjJRSefUhQ0eUM5xYWz8MMg7NjXgHB3+jMCQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/PCI: Improve log message when IRQ cannot be identified
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 2, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> If your system has ACPI, I think "pci=biosirq" and "acpi=noirq" are at
> best distractions from finding the real problem.

...except when the cause is indeed buggy ACPI firmware, which is
presumably the only reason these options exist in the first place.

> This path has to do with ancient x86 and BIOS history, which I know
> very little about.  If I were going to do something about these
> messages, here's what I would do.  Maybe it's too aggressive; I dunno.

Well, it wouldn't require future maintenance when supported command
line options change, which is how we got the stale warnings in the
current code. I'm just not sure who it helps: the vast majority of
users with no IRQ discovery problems never see these messages so they
have no reason to care how concise they are, and they won't be getting
recommendations to try risky kernel parameters for no good reason.
Those who do hit a problem get fewer hints about how to proceed; some
might file a bug report if they can't figure it out, but others will
probably prematurely assume that their hardware "isn't supported" and
give up. Those who dig through the code and kernel_parameters.txt to
find these alternatives even without the hints are probably the ones
who would have written the best bug reports, but they don't get any
specific encouragement to do so, and might never report anything when
they do find a workaround. And I have to wonder how many PCI IRQ bug
reports would get a first response like "Hmm, that should never
happen--- trying booting with pci=biosirq and report whether that
changes anything." Even when it doesn't help, as it often won't, you
have both a data point and encouragement to file the bug report for
further investigation.

Again, this is a minor issue, and I'm not emotionally attached to any
particular solution. Your approach solves the immediate problem of
inappropriate recommendations, and if the code looked like that
already I wouldn't have proposed this patch in the first place. I just
think that if the goal is to get useful bug reports, then providing a
little bit of advice (similar to, but updated from, the current
biosirq suggestion) is more constructive than going for the tersest
possible printk, and I'm sure that log messages will be seen by more
of the potentially affected users than equivalent comments in the code
would be.
