Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59260F3C60
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 00:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKGX74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 18:59:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34237 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKGX74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 18:59:56 -0500
Received: by mail-io1-f67.google.com with SMTP id q83so4369814iod.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2019 15:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Wl8N9CZlB2xlpKHMXK6nBkiP4gpcI53AmfhmdY7Ye0=;
        b=qJ6+3nX2A0cxXp5ywWmFmELron2FyoN3FDc1ffUYMSP1vQyxNNpAwPSnIE5uLNzHPq
         yyTkSrkV4O5kQntMue3g7+nconlzJcFJaaHJJvfJhYiZk1qUc6eQ7eSGlcWwJjDZxSRI
         7S/mzRsyDqgZuUtoTd4Nl/Yt1BDw/i2DmXmPOTsRh50NUe/3/3QtgZHdZFheYVUikA7M
         N+9OqwsvL5vJn14W36FB7KmRrDoQ5hyXXvKRhWwjTE1IpQ+HN47iJQHz64V389iY1Cde
         pazLb/um+PtgdVcge3dhBcECyUDnNWvzK6hGd+wFsEi3EaLHfwIrCnq7ZBaYeiJrTqA1
         C3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Wl8N9CZlB2xlpKHMXK6nBkiP4gpcI53AmfhmdY7Ye0=;
        b=COzfNkEhbgLbR6a0rvUkUuD1zjdmxyFdjobwjdUj7LNGScrSI1A8XEVxDkFiGllp26
         JPzmOEL3hXWXKd6D7Aaw446tzDUAhqu4tPGbSgApUNAzBI8KiHHCyu50u/C6nBJ0+22g
         7Rm2riQRX4XjFZsHF1ADCgi+zQsJLBxQZWoHqSCkJfHfUZYM1wlF39hxXw8mXzr0MxOa
         5cKfjwJeB8zLROudY831bX93OqYqcJl1v5nsthoY8tWkXji8j92hs10Rid0bXTfh4kTt
         MXgU0ER5WJaR2O6fQpTkVY3b/X8qM+GAT9wRDyf21zVH3Cgqz95uTFqRih7Sgv59mkvs
         r/2A==
X-Gm-Message-State: APjAAAVPpHCtt13674IzINOAI4N9OphcfarSxbZj8xCbnoldJwJaLrIa
        kRlpyJtdq/YCu8ZMaKxs4xz8MH56Cxlt5m2w5Q3prw==
X-Google-Smtp-Source: APXvYqwdhyG4PRd2KuyuhMDVRxc8TrIjKm0QEGmFDeLDmPvQFWLzeehD5bVsnZtjSW2ZuPfUI6UWw5ZPpD3feEOMNM8=
X-Received: by 2002:a5e:8202:: with SMTP id l2mr6723828iom.207.1573171195298;
 Thu, 07 Nov 2019 15:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20191025202004.GA147688@google.com> <1ade6a9f-9532-c400-9bb0-4e68ed5752ce@linux.intel.com>
 <CAOesGMhdAUKj9f0=sVwH7kffr=P-LqWWqKxKK3N3e0MpcjLExw@mail.gmail.com> <43b431b6-f544-f9f0-d6f3-f383d7b882b9@linux.intel.com>
In-Reply-To: <43b431b6-f544-f9f0-d6f3-f383d7b882b9@linux.intel.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 7 Nov 2019 15:59:43 -0800
Message-ID: <CAOesGMi2hnEhZvvcWg44LzjAr44LhzQ58s=u=THpfn=RRLLA7w@mail.gmail.com>
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 7, 2019 at 2:07 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 11/7/19 12:09 PM, Olof Johansson wrote:
> > On Thu, Nov 7, 2019 at 12:02 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >> Hi,
> >>
> >> On 10/25/19 1:20 PM, Bjorn Helgaas wrote:
> >>> On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
> >>>> In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
> >>>> the behavior was changed such that native (kernel) handling of DPC
> >>>> got tied to whether the kernel also handled AER. While this is what
> >>>> the standard recommends, there are BIOSes out there that lack the DPC
> >>>> handling since it was never required in the past.
> >>> Some systems do not grant OS control of AER via _OSC.  I guess the
> >>> problem is that on those systems, the OS DPC driver used to work, but
> >>> after eed85ff4c0da7, it does not.  Right?
> >> I need some clarification on this issue. Do you mean in these systems,
> >> firmware expects OS to handle DPC and AER, but it does not let OS know
> >> about it via _OSC ?
> > The OS and BIOS both assumed behavior as before eed85ff4c0da7 -- AER
> > handled by firmware but DPC handled by kernel.
> >
> > I.e. a classic case of "Sure, the spec says this, but in reality
> > implementations relied on actual behavior", and someone had a
> > regression and need a way to restore previous behavior.
>
> Got it. I don't know whether its good to add hacks to support products
> that does not follow spec.
> But, do you think it would be useful to add some kind of warning message
> when this option is
> enabled ? May be it could be useful in debugging.

It's not a "hack", it is fixing a regression in behavior because of
changed assumptions by the kernel.

We're pretty clear as a kernel community: We don't regress our users.
So, in cases like these, we need to make sure we allow people to use
their hardware the same way they used it with an older kernel.

A printk() to indicate that this mode is enabled could be useful, if
nothing else to make sure that the pre-eed85ff4c0da7 behavior is
enabled without having to grep /proc/cmdline.


-Olof
