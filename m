Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148FA1155CB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFQww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 11:52:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42567 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfLFQww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2019 11:52:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id a10so7009093qko.9
        for <linux-pci@vger.kernel.org>; Fri, 06 Dec 2019 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtsbFZa/cny9NoExEQf4jRhMsYnQbDA/XTm5+qKBbhA=;
        b=iTlFM7ZLVRnRv7sIyhMtrRRxNXyA5/sNrs6seRVsldWQ/4Ixzy3mSVXarJsPvY1FcV
         px3LMsh9VfGO09maj/1BYsgM3lPsvXDv87xBgHBLM3m0Vv3mLSP7Xy/SwTQUQ45OMtJl
         tKAlHKi4tbtQ+BICwjP23lfnL5/7am03+WZDcPbjv7ha0uc3apVrBSxFssLvfgfXViTo
         y0yeirbQSvB4w4iI/zu5StnWWEkc5EAZj4w72TLTLqPyGCGKCdIh5bRBPWrreKTTltRL
         Hd7rar7yao2DHmCEuq3qY3mp1KZn9rLC1bdqagu77WA0biVk+t5o3BcD4o2jU4TVBYqY
         3H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtsbFZa/cny9NoExEQf4jRhMsYnQbDA/XTm5+qKBbhA=;
        b=j4XgsbUkjgxpIt8Zn276ZnTedgd42XpOXYTWOOlOkMQeJek35V8YJksQna1Dxgz0VA
         ZZcSraKu48si9k9RUffwGir4gV5/VdoMaIxEUG20jYamK8pA5Va4SjtLwQlPSLe2QyxW
         h+IkcLRjW0qVDimDz5jD8qJ5zlGBm8j256qUBRFQFMGzcyp3daKYeJvZ1cTdApCI3DvD
         c4jrZiMQffFI6TDY23NlmSJQyO9wHVeZFxFNgSw5QdCWAdCKf8GqkvrneYA5M1984yD5
         tB+mwhX3WpcrrWxcC5uLmkbHS6/lUEwE7+0a6CSrBmS5BMvPRMVBNpCEga3wg9kQn0JA
         xjmQ==
X-Gm-Message-State: APjAAAXV0TNuuothDO3hsHDA+tCg0yvxLUJYpYfjrIhfYbA6d4a05PLS
        /wSfgpEg7N603GDi1cqss2IrlIS6yO7y95rqFOMbNQ==
X-Google-Smtp-Source: APXvYqzNOWgNIzSN8qPFuJrVSu468JyjyIi06dNobdqrnYcAkskwBDU4PFXEapf5a/pT30m71MxgQlMsCtKwMHn6dek=
X-Received: by 2002:a37:9f82:: with SMTP id i124mr13345509qke.427.1575651170559;
 Fri, 06 Dec 2019 08:52:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2oMhJDxkU8TpFon4vzBiL5WrYv-zQNtYW8xbqaQLh2eS7bbg@mail.gmail.com>
 <20191206150837.GA98601@google.com> <CAJ2oMhJqsSftJtSDt2fsjqhLT0qQDZkdgQUc4pusuy6TvCnSVA@mail.gmail.com>
In-Reply-To: <CAJ2oMhJqsSftJtSDt2fsjqhLT0qQDZkdgQUc4pusuy6TvCnSVA@mail.gmail.com>
From:   Ranran <ranshalit@gmail.com>
Date:   Fri, 6 Dec 2019 18:52:40 +0200
Message-ID: <CAJ2oMhJQOS-2GuXKGAdBQBXN55=af+xpmWW5+MUgkyMLG_0Q0w@mail.gmail.com>
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 6, 2019 at 6:48 PM Ranran <ranshalit@gmail.com> wrote:
>
> On Fri, Dec 6, 2019 at 5:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Dec 06, 2019 at 08:09:48AM +0200, Ranran wrote:
> > > On Fri, Nov 29, 2019 at 8:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Fri, Nov 29, 2019 at 06:10:51PM +0200, Ranran wrote:
> > > > > On Fri, Nov 29, 2019 at 4:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=205701
> >
> > > I have tried to upgrade to latest kernel 5.4 (elrepo in centos), but
> > > with this processor/board (system x3650, Xeon), it get hang during
> > > kernel boot, without any error in dmesg, just keeps waiting for
> > > nothing for couple of minutes and than drops to dracut.
> >
> > - I don't think you ever said exactly what the original failure mode
> >   was.  You said DMA from an FPGA failed.  What is the specific
> >   device?  How do you know the DMA fails?
> >
>
> Hi,
> FPGA is Intel's Arria 10 device.
> We know that DMA fails because on using signaltap/probing the DMA
> transaction from FPGA to CPU's RAM we see that it stall, i.e. keep
> waiting for the access to finish.
> We don't observe any error in dmesg.
>

Two more notes about this:
1. We know that on same computer (Intel's Xeon, system x3650) the FPGA
can do the transaction without any issues.
2. Using the exact same test module in older compute/cpu (Intel's
DUO), we observe no issues in the dma transaction from FPGA.
The DMA transaction is always from FPGA to CPU's RAM.


>
> > - Re your v5.4 kernel testing, dracut is a user-space distro thing, so
> >   it sounds like your hang is some sort of installation problem that I
> >   can't really help you with.  Maybe there are troubleshooting hints
> >   at https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html.
>
> I know, that's quite frustrating. I tried to disable features using
> kernel arguments noacpi, noapic, but it still freeze somewhere without
> giving any error,
>
> >   You may also be able to just drop a v5.4 kernel on your v4.18
> >   system, at least for testing purposes.
> >
> What does it mean to drop 5.4 kernel on 4.18 kernel ?
>
>
> > - Your comment #3 in bugzilla is a link to a Google Doc containing a
> >   test module.  In the future, please attach things as plain text
> >   attachments directly to the bugzilla.  There's an "Add attachment"
> >   link immediately before the "Description" comment in bugzilla.  I
> >   did it for you this time.
> >
> > - It looks like your test_module.c is a kernel module, and frankly
> >   it's a mess.  Global variables that should be per-device, unused
> >   variables (dma_get_mask() called for no reason), confused usage
> >   (e.g., using both pci_dev_s and pPciDev), whitespace that appears
> >   random, etc.  I suggest starting with Documentation/PCI/pci.rst and,
> >   at least for this debugging effort, making it a self-contained
> >   driver instead of splitting things between a kernel module and
> >   user-space.
> >
>
> I've attached latest kernel module, which I hope will make it more
> clear, I will try to make it a standalone test next time I'm in lab.
>
> > - Your comment #4 is a link to a Google Doc containing lspci output.
> >   I attached it to bugzilla directly for you.
> >
> > - You apparently didn't run lspci as root ("sudo lspci -vv"), so it
> >   is missing a lot of information.
> >
> > - Your lspci doesn't match either of the dmesg logs.  Please make sure
> >   all your logs are from the same machine in the same configuration.
> >   For example, the first devices found by the kernel (from both
> >   comments #1 and #2) are:
> >
> >     pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
> >     pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
> >     pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
> >     pci 0000:00:02.2: [8086:3c06] type 01 class 0x060400
> >     ...
> >
> >   But the lspci doesn't include 00:01.0, 00:02.0, or 00:02.2.  It
> >   shows:
> >
> >     00:00.0 Host bridge: Intel Corporation Device 2020 (rev 04)
> >     00:04.0 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
> >     00:04.1 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
> >     00:04.2 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
> >     ...
>
>  I will do it in lab tomorrow. Thanks.
