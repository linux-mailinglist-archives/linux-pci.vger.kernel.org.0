Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCEF1349A3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgAHRpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 12:45:03 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38385 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHRpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 12:45:03 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so4130640ioj.5;
        Wed, 08 Jan 2020 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hyJ1DuoNTvMLECij7nJ1OuGNCS8kZHJfhmP/ffNYNo=;
        b=CHWNNR+eRdSuev8lOSlzlfo0DqL0/14B/lQMMIXS8/wk98dXoJpY8XgCHzeWjHT5iY
         tVsjpxXn0AUANrnGOetRgdK7Popro7hl/DCKpNkkMc10uAd3MzxQTKxS1dFu41GPwYw+
         ne2lWuZEtEbY1U/jxD83f9t86+TanI8htugq7A5ST9feiRyLuL10XukaOqVO4hCchwRa
         ekW5yXKAVeeglSkAin8PvxqUhRCm3/jyc6x/t/3PLsKRNXDybdIcrGYXpWNjT53NxePz
         oLTWoiNn3gocDh7HyJWE2SnhR4+3n8MJyVwc8NDQXaTN7h0R6qs1IuCfwtAY5/JVBawM
         15ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hyJ1DuoNTvMLECij7nJ1OuGNCS8kZHJfhmP/ffNYNo=;
        b=CTOXxR9ls66crwtAN91KlZlP8Bw+pC7mEW3TB3co515FPs6vfdCVsqSx9cFQtboxWT
         vrgmc3Ms1RcvE6I0NrCUunSYL9rsfpEZ49bCLZqZxp7QBDjAGDSGbSUBV3AKyH6m6lg4
         KNm9mOlOC87eIhEJBJfZQWq1SPkL/Naa+JNEltFtVjrWMXA1/C6mJHs6NIj3gBGpLhbp
         DRBvVLBg/8wwCiv9gtRnWvBR1jQz8BJZ7NQe/OK9y19ZV9hT4pSBa2mukki9SwVyTNuu
         gh21txvLlwzRCV4WPjxxx3SALV9Y5xtrjZAhBv8OtLbOCD6oAkpBZ2cfwizMtritHt5v
         XqGg==
X-Gm-Message-State: APjAAAUiA3OwlUuSQnx9IYeQAVPZV0r6j6lomQluR6vu9UGf5/A08OaW
        0l0O2pgfg4f7Em/n5XCJ9xc8yy+EpiCfezyPM9o=
X-Google-Smtp-Source: APXvYqwdYoScam5JjtndbUpnijDwNfOgvcdpE+6bCGzbFM8VdqjmP4MaatuGDnWxG42J3U8AieJXYw3Z4SMHKfxRdog=
X-Received: by 2002:a6b:7117:: with SMTP id q23mr4093934iog.153.1578505502409;
 Wed, 08 Jan 2020 09:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20200104225052.27275-1-deepa.kernel@gmail.com>
 <20200106135455.GA104407@google.com> <CABeXuvownNp7ngp38vHzCgQfLA-tnH7FFT5pQQeHF3tLizmxcg@mail.gmail.com>
In-Reply-To: <CABeXuvownNp7ngp38vHzCgQfLA-tnH7FFT5pQQeHF3tLizmxcg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 8 Jan 2020 09:44:50 -0800
Message-ID: <CABeXuvrJ-zZsw03BB+d-823xUc5xcQVHX8otJ=9_ESs6HUF7Zw@mail.gmail.com>
Subject: Re: [PATCH] pci: Warn if BME cannot be turned off during kexec
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 6, 2020 at 11:38 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Mon, Jan 6, 2020 at 5:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > Hi Deepa,
> >
> > Thanks for the patches.  Since these two patches touch the same piece
> > of code in pci_device_shutdown(), they conflict with each other.  I
> > could resolve this myself, but maybe you could make them a series that
> > applies cleanly together?
>
> Sure, will make this a series.
>
> > Can you also please edit the subject lines so they match the
> > convention (use "git log --oneline drivers/pci/pci-driver.c" to see
> > it).
>
> Will do.
>
> > On Sat, Jan 04, 2020 at 02:50:52PM -0800, Deepa Dinamani wrote:
> > > BME not being off is a security risk, so for whatever
> > > reason if we cannot disable it, print a warning.
> >
> > "BME" is not a common term in drivers/pci; can you use "Bus Master
> > Enable" (to match the PCIe spec) or "PCI_COMMAND_MASTER" (to match the
> > Linux code)?
>
> Will do.
>
> > Can you also explain why this is a security risk?  It looks like we
> > disable bus mastering if the device is in D0-D3hot.  If the device is
> > in D3cold, it's powered off, so we can't read/write config space.  But
> > if it's in D3cold, the device is powered off, so it can't be a bus
> > master either, so why would we warn about it?
>
> I was mainly concerned about the PCI_UNKNOWN state here. Maybe we can
> add a specific check for the unknown state if that is preferable.

I did some more testing. You are right, these messages are printed
more often than I had remembered.

For some more context on what I am trying to do: I recently merged
another patch that disable iommu unconditionally at kexec:
https://lkml.org/lkml/2019/11/10/146
And, if we do not have IOMMU on and BME is on then we have no way of
controlling memory accesses from devices. This is why I wanted these
warning messages printed. Alternatively, it might just be enough to
warn if we cannot turn off BME on root ports rather than all the
devices. Does this seem like a better compromise?

-Deepa
