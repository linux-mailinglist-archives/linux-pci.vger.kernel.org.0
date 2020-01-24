Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8C414759E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgAXAaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 19:30:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43202 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgAXAaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 19:30:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so414428ljm.10
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2020 16:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e385S31i/qGwjac6oNxoCBIhYZUY/kvlHUmU1b+MVcM=;
        b=ksrlogmefFSt4bVtJHfwxg17cwfPMKbdgjKSJjtnd/7zYUbNsEmAyaFqmpdZLkIUzY
         5cmhzlPUNOTDcIvKH7a6XnntCxM+xCOWn6OnDdqvweyoNgyGE03hzTH2cCDAmBs/DT3L
         ZWZBgKsM/Fxp2ZTUJlzOjFr7Q45pXVCJbP4+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e385S31i/qGwjac6oNxoCBIhYZUY/kvlHUmU1b+MVcM=;
        b=PAdUag7Caa8mkA70JvOS7wKKcybsBwjtFLg7NR+mgYxbD53Oxt3se7jddQT5zmVtC6
         xB1XuJMxeu/lWiF70y0FHc9XeF9D23mI1iSwm5r1S50AJTnoXVqtYFad+UtLPlGqe3BG
         h6FdYYMRT+FtITWEgeexHtq0kghQbdURO9WN9okSM1IdjBwlj/lNfcbrMyZyQr9LgCGS
         jNYVCJi7a8MmHXqZ0QtgSM2FXjIBYkMQ7YtbxzT6d6tYbfg4IzbGDDCqrL0PwCAQwJS2
         iH1zYF8wZmXArWEgBolXdLQ9lTu/eGHmQ6Ob/kpNipXgHEdCdkVH8AKkkf0YGaz7mj8X
         VT9A==
X-Gm-Message-State: APjAAAWD0Dv7FaLAuGQTmbYIKWPPmXbMv8+3UlXXlw0en5NCnQZstT+X
        54YgIb5FATn1zK1KAdntGTO0cma4YMk=
X-Google-Smtp-Source: APXvYqzi1l/cTnU+Y1PImA7IGiC3pzoCdR+NjIXlQLKb+TMBgi70b6Qcqybb9/J5vc4I3BeE/Evy+Q==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr580455ljj.157.1579825812519;
        Thu, 23 Jan 2020 16:30:12 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v5sm2073772ljk.67.2020.01.23.16.30.11
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 16:30:11 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id b15so68125lfc.4
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2020 16:30:11 -0800 (PST)
X-Received: by 2002:ac2:489b:: with SMTP id x27mr191071lfc.130.1579825810814;
 Thu, 23 Jan 2020 16:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com> <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
In-Reply-To: <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Jan 2020 16:29:34 -0800
X-Gmail-Original-Message-ID: <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
Message-ID: <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 23, 2020 at 2:59 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Thu, Jan 23, 2020 at 12:59 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Thu, Jan 23, 2020 at 10:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Evan,
> > >
> > > Thomas Gleixner <tglx@linutronix.de> writes:
> > > > This is not yet debugged fully and as this is happening on MSI-X I'm not
> > > > really convinced yet that your 'torn write' theory holds.
> > >
> > > can you please apply the debug patch below and run your test. When the
> > > failure happens, stop the tracer and collect the trace.
> > >
> > > Another question. Did you ever try to change the affinity of that
> > > interrupt without hotplug rapidly while the device makes traffic? If
> > > not, it would be interesting whether this leads to a failure as well.
> >
> > Thanks for the patch. Looks pretty familiar :)
> > I ran into issues where trace_printks on offlined cores seem to
> > disappear. I even made sure the cores were back online when I
> > collected the trace. So your logs might not be useful. Known issue
> > with the tracer?
> >
> > I figured I'd share my own debug chicken scratch, in case you could
> > glean anything from it. The LOG entries print out timestamps (divide
> > by 1000000) that you can match up back to earlier in the log (ie so
> > the last XHCI MSI change occurred at 74.032501, the last interrupt
> > came in at 74.032405). Forgive the mess.
> >
> > I also tried changing the affinity rapidly without CPU hotplug, but
> > didn't see the issue, at least not in the few minutes I waited
> > (normally repros easily within 1 minute). An interesting datapoint.
>
> One additional datapoint. The intel guys suggested enabling
> CONFIG_IRQ_REMAP, which does seem to eliminate the issue for me. I'm
> still hoping there's a smaller fix so I don't have to add all that in.

I did another experiment that I think lends credibility to my torn MSI
hypothesis. I have the following change:

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 1f69b12d5bb86..0336d23f9ba9a 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1798,6 +1798,7 @@ void (*machine_check_vector)(struct pt_regs *,
long error_code) =

 dotraplinkage void do_mce(struct pt_regs *regs, long error_code)
 {
+printk("EVAN MACHINE CHECK HC died");
        machine_check_vector(regs, error_code);
 }

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 23a363fd4c59c..31f683da857e3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -315,6 +315,11 @@ void __pci_write_msi_msg(struct msi_desc *entry,
struct msi_msg *msg)
                msgctl |= entry->msi_attrib.multiple << 4;
                pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);

+if (entry->msi_attrib.is_64) {
+pci_write_config_word(dev, pos + PCI_MSI_DATA_64, 0x4012);
+} else {
+pci_write_config_word(dev, pos + PCI_MSI_DATA_32, 0x4012);
+}
                pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
                                       msg->address_lo);
                if (entry->msi_attrib.is_64) {

And indeed, I get a machine check, despite the fact that MSI_DATA is
overwritten just after address is updated.

[   79.937179] smpboot: CPU 1 is now offline
[   80.001685] smpboot: CPU 3 is now offline
[   80.025210] smpboot: CPU 5 is now offline
[   80.049517] smpboot: CPU 7 is now offline
[   80.094263] x86: Booting SMP configuration:
[   80.099394] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   80.136233] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   80.155732] smpboot: Booting Node 0 Processor 5 APIC 0x5
[   80.173632] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   80.297198] smpboot: CPU 1 is now offline
[   80.331347] EVAN MACHINE CHECK HC died
[   82.281555] Kernel panic - not syncing: Timeout: Not all CPUs
entered broadcast exception handler
[   82.295775] Kernel Offset: disabled
[   82.301740] gsmi: Log Shutdown Reason 0x02
[   82.313942] Rebooting in 30 seconds..
[  112.204113] ACPI MEMORY or I/O RESET_REG.

-Evan
