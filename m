Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CA137C9A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 10:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgAKJZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jan 2020 04:25:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728346AbgAKJZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jan 2020 04:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578734710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEia/ZgGyocdXAkiZ79+dRz2HyOO0KgveENibSFOSgc=;
        b=U9Y1pL8BeWiqqBIvwAx3qYFbnEYpmR1SnRbwCSxRuXaCbo+VkbbCSAU5SAKvT/ObHJwUwc
        K9brHFRkHJ967D4LQMwiq+PPMKqi8v0eiGgwZt8EwdrQMu+WWcrNDjsdLy8MyabTSLnM8i
        mJf95X7tqQfKbsfPpd2zc1HPY72RlSY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-rC060Tn7Mu24IF1nimFnDA-1; Sat, 11 Jan 2020 04:25:09 -0500
X-MC-Unique: rC060Tn7Mu24IF1nimFnDA-1
Received: by mail-io1-f72.google.com with SMTP id i8so3077398ioi.0
        for <linux-pci@vger.kernel.org>; Sat, 11 Jan 2020 01:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEia/ZgGyocdXAkiZ79+dRz2HyOO0KgveENibSFOSgc=;
        b=ubx69R/+zQmj/PE2CFplmTVG2sfoVJ+avDlzrEsXJX4/piDuEhV9bMalkHYAh8wwGA
         WxRlbkxv7VxydgSjICk+Q16gj0HW9Jxa6Ch18xgudN2nbmD4+PUSrbKb5mgCUw4YgqRT
         Z/BU5LunhdNVVrhxfckyaiIjFZLaQ/xwHdYttwOWb5UR4bz9ohVIEi1RI/CzvINcc9mb
         /dUHMo3/cq7h1BWT4t7U+3ZeZhLqALSgFcka3BB4A3Q+dOYSQKa81xyHfxL/1VSKUIwt
         eukci7Jy73agQtggLGjd2UxrjRd0acNY613o0K6zX7JGtIEmfZ9kV90nsRx3KnT/XG3W
         6oMQ==
X-Gm-Message-State: APjAAAVyvClUysoXlZII1JTfFvhHWfqoF+u06gowsNGzKkCvq/5Arp8S
        uCi7+NL5ykdDpM4fADWei7/OYDRTQ6ah/qhbx2vZFntZGoz0nKubFMGSJiA0Bq3dW/5Q+YcFTye
        IW2jrsSzYhnawnjWE/C5YeX4TpDjMPbay++3S
X-Received: by 2002:a02:1041:: with SMTP id 62mr6480347jay.51.1578734709193;
        Sat, 11 Jan 2020 01:25:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRzDzWCBV4XIfkmNcbzobOQCK8wZqqQAknqywrZtA4meXq+5slVruplp6DwagtH372xu3P/r/OtAzG81djj1w=
X-Received: by 2002:a02:1041:: with SMTP id 62mr6480332jay.51.1578734708922;
 Sat, 11 Jan 2020 01:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20200110214217.GA88274@google.com> <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net> <20200111004510.GA19291@MiWiFi-R3L-srv>
In-Reply-To: <20200111004510.GA19291@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Sat, 11 Jan 2020 17:24:57 +0800
Message-ID: <CACPcB9eM7j0Q_RVMGemw2FoY29YbKgn-96sGrsG6=D9iOm_d2g@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Baoquan He <bhe@redhat.com>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Khalid Aziz and Shuah Khan <azizkhan@gonehiking.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 11, 2020 at 8:45 AM Baoquan He <bhe@redhat.com> wrote:
> On 01/10/20 at 04:00pm, Jerry Hoemann wrote:
> > > I am not understanding this failure mode either. That code in
> > > pci_device_shutdown() was added originally to address this very issue.
> > > The patch 4fc9bbf98fd6 ("PCI: Disable Bus Master only on kexec reboot")
> > > shut down any errant DMAs from PCI devices as we kexec a new kernel. In
> > > this new patch, this is the same code path that will be taken again when
> > > kdump kernel is shutting down. If the errant DMA problem was not fixed
> > > by clearing Bus Master bit in this path when kdump kernel was being
> > > kexec'd, why does the same code path work the second time around when
> > > kdump kernel is shutting down? Is there more going on that we don't
> > > understand?
> > >
> >
> >   Khalid,
> >
> >   I don't believe we execute that code path in the crash case.
> >
> >   The variable kexec_in_progress is set true in kernel_kexec() before calling
> >   machine_kexec().  This is the fast reboot case.
> >
> >   I don't see kexec_in_progress set true elsewhere.
> >
> >
> >   The code path for crash is different.
> >
> >   For instance, panic() will call
> >       -> __crash_kexec()  which calls
> >               -> machine_kexec().
> >
> >  So the setting of kexec_in_progress is bypassed.
>
> Yeah, it's a differet behaviour than kexec case. I talked to Kairui, the
> patch log may be not very clear. Below is summary I got from my
> understanding about this issue:
>
> ~~~~~~~~~~~~~~~~~~~~~~~
> Problem:
>
> When crash is triggered, system jumps into kdump kernel to collect
> vmcore and dump out. After dumping is finished, kdump kernel will try
> ty reboot to normal kernel. This hang happened during kdump kernel
> rebooting, when dumping is network dumping, e.g ssh/nfs, local storage
> is HPSA.
>
> Root cause:
>
> When configuring network dumping, only network driver modules are added
> into kdump initramfs. However, the storage HPSA pcie device is enabled
> in 1st kernel, its status is PCI_D3hot. When crashed system jumps to kdump
> kernel, we didn't shutdown any device for safety and efficiency. Then
> during kdump kernel boot up, the pci scan will get hpsa device and only
> initialize its status as pci_dev->current_state = PCI_UNKNOWN. This
> pci_dev->current_state will be manipulated by the relevant device
> driver. So HPSA device will never have chance to calibrate its status,
> and can't be shut down by pci_device_shutdown() called by reboot
> service. It's still PCI_D3hot, then crash happened when system try to
> shutdown its upper bridge.
>
> Fix:
>
> Here, Kairui uses a quirk to get PM state and mask off value bigger than
> PCI_D3cold. Means, all devices will get PM state
> pci_dev->current_state = PCI_D0 or PCI_D3hot

Or to put it simple, I just synced the actual PM state into
pci_dev->current_state using a quirk, for kdump kernel only.

> Finally, during kdump
> reboot stage, this device can be shut down successfully by clearing its
> master bit.
>
> ~~~~~~~~~~~~~~~
>
> About this patch, I think the quirk getting active PM state for all devices
> may be risky, it will impact normal kernel too which doesn't have this issue.
>
> Wondering if there's any other way to fix or work around it.
>

Thank you for the detailed description!

-- 
Best Regards,
Kairui Song

