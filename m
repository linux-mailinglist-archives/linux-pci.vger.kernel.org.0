Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B61433412
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 12:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhJSLBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 07:01:43 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:40539 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhJSLBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 07:01:40 -0400
Received: by mail-oo1-f47.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so867017ooh.7;
        Tue, 19 Oct 2021 03:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rB3WXW5Ly9nsEO4krnqGBalVpdpkoDadBf+vIxcOOSg=;
        b=3HS9o0gDheSM49xhkC5i4bUBBMcqK2WN8hXq4/kAzKtwbvpSbXr9XSR2vqelW0olSL
         SKWVuuCF8jg5KJCUtfC8u6fK367OcZSAntY+o86/ppJ8cn07bzYPOG8t7CdsV3qGGVdr
         /IqdTS12+oeo6dBV0x+cDPkZ9Tq5aBHEwL8/kv2l7h2paTsyQueiPRBP0vBA8FJb4oIr
         nQ9pyQyYDOm8lEWtiKsgIHgPwInSeRDYW6loVBORdvTExmdiqVrVGABsg9uOxJkAsktS
         /MRz3JuVDKBc/TMI8uGF485m005Xxj0oE1tprCD6MobjIhod6o3pDJR2fNZQ3+VYw6yp
         k4og==
X-Gm-Message-State: AOAM531o9AIjgZpI5o9lhBc68XL5K6v+K9L+OyrkCSw+pCw8YDf2TNzO
        n0sv2hvFcE1X6CxxOfHCpuLHD94Q7OOlXWSnxmu9MOap
X-Google-Smtp-Source: ABdhPJw1l1Z/gDFkRNI+kJ8UJaIjgSPtqc6rUcoEaB8xL3gI57XMaDvB6i7leEP2YX4KcH9/KUSqG83cXyU7r8EOPOM=
X-Received: by 2002:a4a:e1fd:: with SMTP id u29mr4251102ood.0.1634641167969;
 Tue, 19 Oct 2021 03:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <21226252.EfDdHjke4D@kreacher> <8835496.CDJkKcVGEf@kreacher> <5521425.DvuYhMxLoT@kailua>
In-Reply-To: <5521425.DvuYhMxLoT@kailua>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 12:59:11 +0200
Message-ID: <CAJZ5v0gt4wGOzRrV+4pT0vbpxwCgBh9x04h-dzTQgSEss6u=0g@mail.gmail.com>
Subject: Re: [EXT] [PATCH v1 2/2][RFT] ACPI: PM: Check states of power
 resources during initialization
To:     "Andreas K. Huettel" <andreas.huettel@ur.de>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 18, 2021 at 12:41 PM Andreas K. Huettel
<andreas.huettel@ur.de> wrote:
>
> Am Freitag, 15. Oktober 2021, 19:14:10 CEST schrieb Rafael J. Wysocki:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > To avoid situations in which the actual states of certain ACPI power
> > resources are not known just because they have never been referenced
> > by any device configuration objects, check the initial states of all
> > power resources as soon as they are found in the ACPI namespace (and
> > fall back to turning them on if the state check fails).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Andreas, please test this patch (on top of the [1/2]) and let me know
> > if it works for you.
> >
>
> I see no negative impact (actually, no impact at all) of the second
> additional patch. The network card is again working fine now.
>
> Boot logs (unpatched, with one patch, with both patches) at
> https://dev.gentoo.org/~dilfridge/igb/  (the 5.14.12* files).

Thanks!
