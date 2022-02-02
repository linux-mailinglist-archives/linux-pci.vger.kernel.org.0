Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1E4A7ADD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 23:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiBBWN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 17:13:59 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35702 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbiBBWN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 17:13:58 -0500
Received: by mail-ed1-f53.google.com with SMTP id n10so1469857edv.2;
        Wed, 02 Feb 2022 14:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmnDmQf66DH3CNM0bY8f9WVPerP1qpI40besy/UvpWo=;
        b=dV3JnRGElqsWL3vgvc6SQhgYZt2dcYGS6U8oAoKK5lm16rPvip1LucV+53issUYwVb
         ls7r98XEbfQ5n0dmh7p3eqB+tfWI4ZFFr85i/hzPXF9vFG27tH3Brz9sVQYBOfHN1dR0
         6XPoN5HCJ7TGiy5HHRHJgojEoysgGNZNdjcrSFDmbgtJpAxykDbhQ8Ss5I1/rwvz1gvk
         0B/gNRpaHxGVVblNTuASoFdr1W19v9DW1UYRGr4x6S/cogv2O9oTcZKxFSvVb8JerWCB
         6tVSwOLTjNxHqHdcPZ9ocONKN6pkYqq+FdzTb8kCTGH863CJLPNmiw16EYnmTOkSMci5
         sBRQ==
X-Gm-Message-State: AOAM530ZKoWjrM5BYuJCs1ETgAJlTY55sqDMsZaQ8qG55XFVe4SzMJ1l
        9v0+FlOPf/nXvfixKMnHnJwogxCxnRL9Hd0aH0w=
X-Google-Smtp-Source: ABdhPJz6ymePlowgMgmrCCEtYmPG7Lq4azqzrAqA88lII7rMFgMkLwiT/dIr0oeAZrbkCA4oiSX0PitsTZK6e2j5cdk=
X-Received: by 2002:a05:6402:1c1e:: with SMTP id ck30mr32791950edb.266.1643840037562;
 Wed, 02 Feb 2022 14:13:57 -0800 (PST)
MIME-Version: 1.0
References: <YfiBfdAf9uHYTf4T@jupiter.dyndns.org> <20220202181318.GA26584@bhelgaas>
In-Reply-To: <20220202181318.GA26584@bhelgaas>
From:   Brent Spillner <spillner@acm.org>
Date:   Wed, 2 Feb 2022 22:13:31 +0000
Message-ID: <CAGwJgaMDJH-rhsc9+_vj1vjj6XLigvqVYLdu-6TgrDNxGpTubA@mail.gmail.com>
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

On Wed, Feb 2, 2022 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> IIUC pirq_enable_irq() is only used for non-ACPI, non-DT, non-Xen,
> non-Intel MID systems, so this is a real legacy path.
>
> I don't think it's really worth cluttering an error case in a path
> that should be rarely used in the first place.

I figured if people are getting this message, then they either have
broken hardware or are debugging something, and if the message is
trying to be useful then it can't hurt to mention other things that
might help. If the pirq path has become buggy or unsupportable in
modern kernels then it probably ought to be removed altogether; if it
still works, however rarely it might be needed these days, then it's
perhaps worth mentioning to those who might occasionally have a use
for it.

> Are you seeing a problem where you're getting the wrong error message
> today?  Can we just fix that problem instead so no kernel parameter is
> needed in the first place?

I was trying to isolate intermittent ACPI errors and tried booting
with acpi=noirq, as seemingly the closest modern equivalent to the
acpi=ht that had solved, or at least half-split, similar issues for me
in the past. With noirq, a different PCIe device stopped working (MPT
Fusion driver not picking up any responses to doorbell interrupts),
and while reviewing dmesg I noticed that the PCI error messages were
suggesting a kernel option that wasn't appropriate for my x86_64
architecture. In an ideal world with no hardware or driver problems
these log messages should never even happen, but in the real world of
troubleshooting and debugging I think they can be useful, and if
they're going to be reported they might as well be correct.

Obviously, this is a very minor bug, affecting only logs rather than
behavior, and I'm sure there are more pressing things to worry about.
On the other hand, it also seems like a very easy and low-risk fix
that leaves the kernel in a slightly better state for future users and
developers. At any rate, the current state of the PCI code (a)
generates a message that recommends specific kernel parameters, (b)
does so even on builds for which those parameters are inappropriate,
(c) doesn't say anything to encourage bug reports, and (d) doesn't
warn about the risks of noirq, which could cause other problems to be
misattributed. So even though the alternate messages I drafted may not
be perfect, and might need to be tuned in the future based on patterns
in whatever bug reports come in, I'm still confident that they're an
improvement (and I'm open to further suggestions).
