Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE7530764B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 13:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhA1Mnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 07:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhA1Mnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 07:43:35 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D50C061573
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 04:42:55 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id a7so5000256qkb.13
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 04:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cZ6auSWQclxHTQyq4IlNveO6XFgtSiU8a/UK323tTQ=;
        b=HIdD9W29wyRFIytMvMywTSghw/65k+1HvC9W2GW1/ksG+EV50ksDig0o8j02usdXG7
         L4QuAASqBAMJRWqa1SGDO/Syftyxk7MO6wXpj9+e8BOHeNTde1d3Y/JVNtO/xJAG10X+
         JujPPRXwnZyrER1JttUXNidRVjqNNI+Vp7YTZzPwcmMv+ftdhO3JUclAISrfmoVRofj/
         Ce7MxLQpivzjkaTEkx/2TBpxlz5jZWU8r5G1ihh87ezv9b5EySqJG9AefqyQ8nKU+PMc
         PuCDMj7Psc4ZsRgxDG+rMAlQluoMd15fPpGdMZzvBCfoa4IoDKN139HuFdambxBzOjko
         gAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cZ6auSWQclxHTQyq4IlNveO6XFgtSiU8a/UK323tTQ=;
        b=WBLCEQLyC9RChC4RIbkxYqPp+09vfuiYbHY5VeBRBxLcWiLFO2k33K1CxhwvPUWpDs
         3FHe8WgyJYbFQ7i6Nf6+haU5J67SkUypa+AYtarujlbHWHB6FT+MpwRjanvcN6msOTPL
         Emctcn0nus81dFKzUE5+STH77NundWDLetK6wgz7jkc67E/IFsosVFeFEsTl3KQikMzV
         IQcjl+JOW4wD+Y+X17+QDAkyCBQXk5o/2ndLF4Z/JE5fki1urL0412746fBUBXmPtUMf
         Fc8EKcwaV1VOVKtKxs2CVUtu/66bxUtA6+6LFE0OpmkiVNbuOOiTwl20HXric05BPi5A
         wZXg==
X-Gm-Message-State: AOAM5316Ut4l79iDQ4VN51V+g8Qrc/O4n0YL7wFda2tjANiAvPlx2jvj
        22PhDW/3juvRNAShzHyfsCi+QYZf5lkI4j9OKzc=
X-Google-Smtp-Source: ABdhPJzWq+aGOHTTctpW7r2apIzvvYSMogR0Rh2Uz7SGxtslNYEQeuXw/WqInU/L1fDynJLyGpVQa2ApH9rhMFeJ/wo=
X-Received: by 2002:a05:620a:52f:: with SMTP id h15mr15148757qkh.380.1611837774373;
 Thu, 28 Jan 2021 04:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20201024205548.1837770-1-ian.kumlien@gmail.com> <20210112204202.GA1489918@bjorn-Precision-5520>
In-Reply-To: <20210112204202.GA1489918@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 28 Jan 2021 13:41:57 +0100
Message-ID: <CAA85sZuANe2+-c38LezjeMAjNve9Cj_zamSBe5mTiB+HXX0fdw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry about the late reply, been trying to figure out what goes wrong
since this email...

And yes, I think you're right - the fact that it fixed my system was
basically too good to be true =)

On Tue, Jan 12, 2021 at 9:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> My guess is the real problem is the Switch is advertising incorrect
> exit latencies.  If the Switch advertised "<64us" exit latency for its
> Upstream Port, we'd compute "64us exit latency + 1us Switch delay =
> 65us", which is more than either 03:00.0 or 04:00.0 can tolerate, so
> we would disable L1 on that upstream Link.
>
> Working around this would require some sort of quirk to override the
> values read from the Switch, which is a little messy.  Here's what I'm
> thinking (not asking you to do this; just trying to think of an
> approach):

The question is if it's the device or if it's the bridge...

Ie, if the device can't quite handle it or if the bridge/switch/port
advertises the wrong latency
I have a friend with a similar motherboard and he has the same latency
values - but his kernel doesn't apply ASPM

I also want to check L0s since it seems to be enabled...

>   - Configure common clock earlier, in pci_configure_device(), because
>     this changes the "read-only" L1 exit latencies in Link
>     Capabilities.
>
>   - Cache Link Capabilities in the pci_dev.
>
>   - Add a quirk to override the cached values for the Switch based on
>     Vendor/Device ID and probably DMI motherboard/BIOS info.

I can't say and I actually think it depends on the actual culprit
which we haven't quite identified yet...

> Bjorn
