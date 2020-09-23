Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B6D27634D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 23:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWVsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 17:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWVsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 17:48:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8134C0613CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 14:48:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w16so1290091qkj.7
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9XjOwjH5bhViAuU1pfAIKZVLt/QnhzuWphVzTZWsjs=;
        b=DnNrcuDWzsYw4gPiagQ65VUeCZD5AQybzz4b3GllhEaxivq+Swq6rQPkbfl5Yodo/F
         DgIse6PJPubH0RTurG8UJKEb1fxu98M7sS0OAeZcLX7CdK7mDC4DWkoDo7Sxi/rdSMKH
         pvuGY5ZEGhmODoSpEqM3gdTRr8bHTefwAYxyVkx8AEAua1D/ukYx/MSddx1ENH7itMMU
         n56K+atPBxbm9iMUVRuIyV0tjxFKpjAN/EXt/pbIlKEdOYAMk70kUaPrXf0fwKPmqCVQ
         VNfD7OYGBjzw19YOe3fECEpYE8zdzaux34k4AMHSHYODWRYd4gLQTlLQS5M7zB5pFrLd
         ROcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9XjOwjH5bhViAuU1pfAIKZVLt/QnhzuWphVzTZWsjs=;
        b=LNa/sfh9y4insm3hbAPHOd1z2F+cRkraT4+bSFjHgHg0mn53bxwLjl+VKVXNY1XygN
         QvbtRVe/6AEC/Qi4VrCcwEt5yU5+/vYxOU3js3X4jzFPdgdjQ3gPDoZuv5gZbeVo3VFR
         P00cqoA+RkQHCcCoTtlvKR6a2y+Sc6J7BeKN57OKwTKplOLmH16pEajaIjYbwCZA2HlE
         5CJ+aGBxAsSI1XgX7fFPFW1yeox/7S8r6zlSKI0YJV9gyMjnlePiCR2eIrpLhiJ3Lm92
         nd6MVMaHXIsiAKMl9t9V1HvI7eiw8v1AxAIYlPi77XQpFeA0btBNO/fMd789hQRq3nXe
         9g/w==
X-Gm-Message-State: AOAM531oa8PB5P9vS+3LzYBJkEXEP56xNQjPlQUQj3XfjwAS/9djBJjP
        Tc93liet47ryYtsP29hfsAtJZboDaTgVBlkaMLY=
X-Google-Smtp-Source: ABdhPJz7gwDnIY3GOSRygxlWNDfg3L/CucHEDUxxHO5iVnmjBvKXdj3y3L99VCwp3ZJCS4LpgidUOAFjeIM/Wmt3Ckg=
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr1903247qke.175.1600897725720;
 Wed, 23 Sep 2020 14:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZs5f09uh+eCcZ+2Mh4Hj=GVVncZjyGR8Ru3vBQ3Z-_nNA@mail.gmail.com>
 <20200923212318.GA2295660@bjorn-Precision-5520> <CAA85sZvm5SyiG_AE3=4Xowz4AYuMW38uvw8QJ5D8WL3=1Tkv7w@mail.gmail.com>
In-Reply-To: <CAA85sZvm5SyiG_AE3=4Xowz4AYuMW38uvw8QJ5D8WL3=1Tkv7w@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 23 Sep 2020 23:48:34 +0200
Message-ID: <CAA85sZsu9hL3kVvBkZgSNbFBVyLr6W95RLzajH0awMmaoAhdRQ@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Added dmesg with pci=earlydump on the bugzilla

https://bugzilla.kernel.org/attachment.cgi?id=292601

On Wed, Sep 23, 2020 at 11:36 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Wed, Sep 23, 2020 at 11:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Sep 23, 2020 at 01:29:18AM +0200, Ian Kumlien wrote:
> > > On Wed, Sep 23, 2020 at 1:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Sep 22, 2020 at 11:02:35PM +0200, Ian Kumlien wrote:
> >
> > > > > commit db3d9c4baf4ab177d87b5cd41f624f5901e7390f
> > > > > Author: Ian Kumlien <ian.kumlien@gmail.com>
> > > > > Date:   Sun Jul 26 16:01:15 2020 +0200
> > > > >
> > > > >     Use maximum latency when determining L1 ASPM
> > > > >
> > > > >     If it's not, we clear the link for the path that had too large latency.
> > > > >
> > > > >     Currently we check the maximum latency of upstream and downstream
> > > > >     per link, not the maximum for the path
> > > > >
> > > > >     This would work if all links have the same latency, but:
> > > > >     endpoint -> c -> b -> a -> root  (in the order we walk the path)
> > > > >
> > > > >     If c or b has the higest latency, it will not register
> > > > >
> > > > >     Fix this by maintaining the maximum latency value for the path
> > > > >
> > > > >     See this bugzilla for more information:
> > > > >     https://bugzilla.kernel.org/show_bug.cgi?id=208741
> > > > >
> > > > >     This fixes an issue for me where my desktops machines maximum bandwidth
> > > > >     for remote connections dropped from 933 MBit to ~40 MBit.
> > > > >
> > > > >     The bug became obvious once we enabled ASPM on all links:
> > > > >     66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)
> > > >
> > > > I can't connect the dots here yet.  I don't see a PCIe-to-PCI/PCI-X
> > > > bridge in your lspci, so I can't figure out why this commit would make
> > > > a difference for you.
> > > >
> > > > IIUC, the problem device is 03:00.0, the Intel I211 NIC.  Here's the
> > > > path to it:
> > > >
> > > >   00:01.2 Root Port              to [bus 01-07]
> > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > >   02:03.0 Switch Downstream Port to [bus 03]
> > > >   03:00.0 Endpoint (Intel I211 NIC)
> > > >
> > > > And I think this is the relevant info:
> > > >
> > > >                                                     LnkCtl    LnkCtl
> > > >            ------DevCap-------  ----LnkCap-------  -Before-  -After--
> > > >   00:01.2                                L1 <32us       L1+       L1-
> > > >   01:00.0                                L1 <32us       L1+       L1-
> > > >   02:03.0                                L1 <32us       L1+       L1+
> > > >   03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-
> > > >
> > > > The NIC says it can tolerate at most 512ns of L0s exit latency and at
> > > > most 64us of L1 exit latency.
> > > >
> > > > 02:03.0 doesn't support L0s, and the NIC itself can't exit L0s that
> > > > fast anyway (it can only do <2us), so L0s should be out of the picture
> > > > completely.
> > > >
> > > > Before your patch, apparently we (or BIOS) enabled L1 on the link from
> > > > 00:01.2 to 01:00.0, and partially enabled it on the link from 02:03.0
> > > > to 03:00.0.
> > >
> > > According to the spec, this is managed by the OS - which was the
> > > change introduced...
> >
> > BIOS frequently enables ASPM and, if CONFIG_PCIEASPM_DEFAULT=y, I
> > don't think Linux touches it unless a user requests it via sysfs.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=66ff14e59e8a
>
> "7d715a6c1ae5 ("PCI: add PCI Express ASPM support") added the ability for
> Linux to enable ASPM, but for some undocumented reason, it didn't enable
> ASPM on links where the downstream component is a PCIe-to-PCI/PCI-X Bridge.
>
> Remove this exclusion so we can enable ASPM on these links."
>
> > What does "grep ASPM .config" tell you?
>
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_POWERSAVE=y
>
> And all of this worked before the commit above.
>
> > Boot with "pci=earlydump" and the dmesg will tell us what the BIOS
> > did.
> >
> > If you do this in the unmodified kernel:
> >
> >   # echo 1 > /sys/.../0000:03:00.0/l1_aspm
> >
> > it should enable L1 for 03:00.0.  I'd like to know whether it actually
> > does, and whether the NIC behaves any differently when L1 is enabled
> > for the entire path instead of just the first three components.
>
> With an unmodified kernel, I have ~40 mbit bandwidth.
>
> > If the above doesn't work, you should be able to enable ASPM manually:
> >
> >   # setpci -s03:00.0 CAP_EXP+0x10.w=0x0042
>
> I used something similar to disable ASPM, which made the nic work again.
>
> > > > It looks like we *should* be able to enable L1 on both links since the
> > > > exit latency should be <33us (first link starts exit at T=0, completes
> > > > by T=32; second link starts exit at T=1, completes by T=33), and
> > > > 03:00.0 can tolerate up to 64us.
> > > >
> > > > I guess the effect of your patch is to disable L1 on the 00:01.2 -
> > > > 01:00.0 link?  And that makes the NIC work better?  I am obviously
> > > > missing something because I don't understand why the patch does that
> > > > or why it works better.
> > >
> > > It makes it work like normal again, like if i disable ASPM on the
> > > nic itself...
> >
> > I wonder if ASPM is just broken on this device.
> > __e1000e_disable_aspm() mentions hardware errata on a different Intel
> > NIC.
>
> I doubt it. The total time seems to surpass the time it can handle
> with it's buffers.
>
> Note that the nic is running with ASPM now, and it is working =)
>
> > > I don't know which value that reflects, up or down - since we do max
> > > of both values and
> > > it actually disables ASPM.
> > >
> > > What we can see is that the first device that passes the threshold
> > > is 01:00.0
> >
> > I don't understand this.  03:00.0 claims to be able to tolerate 64us
> > of L1 exit latency.  The path should only have <33us of latency, so
> > it's not even close to the 64us threshold.
>
> Well, this is why i dumped the raw data - i don't know how lspci reads it
>
> > > How can I read more data from PCIe without needing to add kprint...
> > >
> > > This is what lspci uses apparently:
> > > #define  PCI_EXP_LNKCAP_L0S     0x07000 /* L0s Exit Latency */
> > > #define  PCI_EXP_LNKCAP_L1      0x38000 /* L1 Exit Latency */
> > >
> > > But which latencies are those? up or down?
> >
> > I think the idea in aspm.c that exit latencies depend on which
> > direction traffic is going is incorrect.  The components at the
> > upstream and downstream ends of the link may have different exit
> > latencies, of course.
>
> Yes, and the max latency is the maximum time the device can buffer before
> the link has to be up, so maximum time to establish link must be
> max(up, down) right?
