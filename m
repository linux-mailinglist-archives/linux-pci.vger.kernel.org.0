Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C0E6C75
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 07:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfJ1GdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 02:33:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38654 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbfJ1GdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 02:33:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id t26so3048336qtr.5
        for <linux-pci@vger.kernel.org>; Sun, 27 Oct 2019 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBkTGYoh/dOHNRRQTZGhwrY47goGSYR9X3f3Vf7/wZ0=;
        b=QkosWSF+r3d5jg2253fy6vTFba9J4jp+Ph5Iv28eSEiQlmjM1xSzxuvthU95MvasWE
         lIDZEjoryrs9wRTdgRo6pGVUj0KN1wBPBz2wgc59FqasJsItT8LKCAG6mdPu3Pss0XL8
         +CQliuHjFrU936KorGh4C32aHd+mFWnYPn31InjSDPJx3gnKwQMUUTt6HOPmKfZv/8Ge
         DlH3qrIAT0QYev+pUHo+atX54N29gx3/buN381rP9xGJRuXnQL3KyQv3YKaqsxQBV0nD
         FCK5VQz0sL+AN2M4giWyd5+2DYyPVThmWOlW1W9FMWJiXgJ3qo9raJHDocIqzm1Bv8W3
         //bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBkTGYoh/dOHNRRQTZGhwrY47goGSYR9X3f3Vf7/wZ0=;
        b=FG7BjqFOGu2zw9K1+9b4uBJE9Ryeica5WYq89IByuUXgVw7aKQwcmwEGzj5usaxnUD
         0Qy59Yu85UCKeRqrIsbA/NJ7ohi8zPjJx48x0b0yBW0wDRIPuEvv1rw/vqnp3jkOJRfC
         mDOLOLmZNfIMz09HbE2XATfjp54DAx8YR3GueqzpdVm5JuQNPS1ded/0UTPOZ78KAhHX
         3eAPlGrQ90QAh2zBdnvXdSc5Tfi42zaSCAeErh/GpImA/h40PwBWL99DtTaKWwwtKbvb
         7WzXD75DWZCREuKz1NnvlFwsDGkGUlUtKe9QYcbryqxzQEyot+p6sHw0EIu+SnEZHhaz
         lsBw==
X-Gm-Message-State: APjAAAUrDOC5Elj6MPTREV0aMuV+de1kvdigPRu8ft1aLSpBrPTlpaX1
        EHf0CSKqrIJ0oGsyHV9Dk+/nI/i7Q9sllSx5sUxkLWZiZ+Q=
X-Google-Smtp-Source: APXvYqzPor6wJQL+hzLzCj6MGVuYSQods0VnQsSXp4V2tO4HqC8rbMhZixpIuLpQRZpbscdmohaKliWvUq29L/2fg3c=
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr15549995qtp.391.1572244388347;
 Sun, 27 Oct 2019 23:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47HgAi-86ni5WHhZT1-sEd7oJEZUiG6KNU66qpmRCfaXw@mail.gmail.com>
 <20191025162814.GA130180@google.com>
In-Reply-To: <20191025162814.GA130180@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 28 Oct 2019 14:32:57 +0800
Message-ID: <CAD8Lp44f9EQS93VkYUfnZYPjHMpOVCPuGoKD+dZ+=+tfyZHU5w@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 26, 2019 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > pci_pm_resume_noirq
> > - pci_pm_default_resume_early
> > -- pci_raw_set_power_state(D0)
> >
> > At this point, pci_dev_wait() reads PCI_COMMAND to be 0x100403 (32-bit
> > read) - so no wait.
>
> Just thinking out loud here: This is before writing PCI_PM_CTRL. The

It's not - it's after writing PCI_PM_CTRL, but before reading it back.

> device should be in D3hot and 0x100403 is PCI_COMMAND_IO |
> PCI_COMMAND_MEMORY | PCI_COMMAND_INTX_DISABLE (and
> PCI_STATUS_CAP_LIST), which mostly matches your lspci (it's missing
> PCI_COMMAND_MASTER, but maybe that got turned off during suspend).
> It's a little strange that PCI_COMMAND_IO is set because 03:00.3 has
> no I/O BARs, but maybe that was set by BIOS at boot-time.

I also checked PCI_COMMAND before writing PCI_PM_CTRL, it's the same
value 0x403.
Immediately after writing PCI_PM_CTRL, it holds the same value.
10ms later (after pci_dev_d3_sleep()), it holds the same value.
Another 10ms later, it has value 0.

> > pci_raw_set_power_state writes to PM_CTRL and then reads it back
> > with value 0x3.
>
> When you write D0 to PCI_PM_CTRL the device does a soft reset, so
> pci_raw_set_power_state() delays before the next access.
>
> When you read PCI_PM_CTRL again, I think you *should* get either
> 0x0000 (indicating that the device is in D0) or 0xffff (if the read
> failed with a Config Request Retry Status (CRS) because the device
> wasn't ready yet).

PCI_PM_CTRL stats with value 0x103.
Then 0 is written and pci_dev_d3_sleep() delays 10ms.
At this point it has value 0x3.
After an additional 10ms delay, it has value 0.

> I can't explain why you would read 0x0003 (not 0xffff) from
> PCI_PM_CTRL.
>
> What happens if you do a dword read from PCI_VENDOR_ID here (after the
> delay but before pci_dev_wait() or reading PCI_PM_CTRL)?

Vendor ID remains 0x1022 at all points.

> You might also try changing pci_enable_crs() to disable
> PCI_EXP_RTCTL_CRSSVE instead of enabling it to see if that makes any
> difference.  CRS SV has kind of a checkered history and I'm a little
> dubious about whether it buys us anything.

I stubbed out that register write which would have otherwise applied
to 8 PCI devices (but not the XHCI controllers), it still fails in the
same way unless the delay is increased.

> > >   xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
> >
> > At the point of return from pci_pm_resume_noirq, an extra check I
> > added shows that PCI_COMMAND has value 0x403 (16-bit read).
>
> If PCI_COMMAND is non-zero at that point, I think something's wrong.
> It should be zero by the time pci_raw_set_power_state() reads
> PCI_PM_CTRL after the D3 delay.  By that time, we assume the reset has
> happened and the device is in D0uninitialized and fully accessible.

It looks like we can detect that the reset has failed (or more
precisely, not quite completed) by reading PCI_COMMAND (value not yet
0) or PCI_PM_CTRL (doesn't yet indicate D0 state, we already log a
warning for this case).

From that angle, another workaround possibility is to catch that case
and then retry the PCI_PM_CTRL write and delay once more.

Daniel
