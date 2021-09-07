Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E104022F1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 07:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhIGE7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 00:59:49 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49744
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233113AbhIGE7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 00:59:49 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 18BBF4077A
        for <linux-pci@vger.kernel.org>; Tue,  7 Sep 2021 04:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630990715;
        bh=B+j2BVDv9Qq/RPNv/sjl985zDy7vdDYDwWfVfLo5d1k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RlCW67FS5e4SYKlp3XWUaV9xCp4njF3uz3zkOrG59xhB6HDhq9JtIHvdS6O1RhOYF
         MR5xX6mzUzgJ/TNS8X8201fkM4GMCJgjh5+T88Erx89h5IR+C3MN5eSeeIRqWMhvz0
         n8GuhyT66A3hSzxqh9h6VVuXcTTftIzKL/SwLiZ+Z2K45a/IE/gHAkV7E83/18nOmN
         N65VcUkMITDChieRvHACmvS3BjQDpW0WoW7jj2BocpuK/O8tJgbSMna/5rpYhfX0xi
         S+taAvSspwAGsoacu/6fD6XNPgG3CY3jabknJG+f6aX72XwSgBTsjAN3Flo60JBVwN
         fB+XMQd1ekA3g==
Received: by mail-oi1-f200.google.com with SMTP id s10-20020a056808008a00b00268c82cc7a0so3056155oic.14
        for <linux-pci@vger.kernel.org>; Mon, 06 Sep 2021 21:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+j2BVDv9Qq/RPNv/sjl985zDy7vdDYDwWfVfLo5d1k=;
        b=N0J3fHgOEb/t9+B4kf0vn1d0e7ZBLMaI7lew9qIurPqgXxc9txRL/m33QA2Md8M+1m
         zLuJZd+rg+OCz8LOyvk9l1541NX0/lqJhTxIfRaIbNfdq7a9BUBex7LpYxKq6SwxX1W2
         6TXm/vnYUWwXs0p5hPSNuQ3re71hnjvNqTLG2LjbcM1VqOXlZlZX7WqAId6eDGpFwhS4
         ek0H2REajVdcXpgO3YZbOxBzODmxwbxDCqRVb7uPFfEHvhsVq8cGqatVZ1yT+LjUBJqL
         7DyKfiYDmYAd4RHY7tF/HCY9/pULxcA9XfdEgPgsEoxwkXbxlzuCUvDMOBDQoOe4g2o4
         /7/g==
X-Gm-Message-State: AOAM533bpNVv71leaMwomzgBUR4VFwiL9G8xr8TXjhvJuBHbvI6dzsI+
        5Ty4poqEdmviTcM4AfngDJRl+XTQOeYHFVy/cL6EuAmqa0v0mBSGJSwF3UO5qvfFVg2SfYQ7dBP
        aMjy6bqqxxjWnWJQBLVBJEE/sJwirhLCaWLXGAF3bcNSPu0ZYPljW7A==
X-Received: by 2002:aca:2102:: with SMTP id 2mr1641803oiz.98.1630990713917;
        Mon, 06 Sep 2021 21:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTa3enskGABo1zgybld2TdjokvafafEZXxFHkkFQKDx7ZPXad3iDWl31Cer2M8ks6ePkoN+MUCbl4I8k9+vjo=
X-Received: by 2002:aca:2102:: with SMTP id 2mr1641788oiz.98.1630990713547;
 Mon, 06 Sep 2021 21:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210827171452.217123-3-kai.heng.feng@canonical.com>
 <20210830180940.GA4209@bjorn-Precision-5520> <CAAd53p634-nxEYYDbc69JEVev=cFkqtdCJv5UjAFCDUqdNAk_A@mail.gmail.com>
 <71aea1f6-749b-e379-70f4-653ac46e7f25@gmail.com> <CAAd53p7XQWJJrVUgGZe0MC1jO+f3+edAmkEVhP40Lwwtq2bU2A@mail.gmail.com>
 <c39bd0ad-c80a-dbed-3f30-95c2b31434cc@gmail.com>
In-Reply-To: <c39bd0ad-c80a-dbed-3f30-95c2b31434cc@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 7 Sep 2021 12:58:22 +0800
Message-ID: <CAAd53p4WJkO2FEjfRdvCgkeQVzYr=JQPKDbPNrRuK8RYKmzC5A@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v4] [PATCH 2/2] r8169: Implement dynamic
 ASPM mechanism
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 7, 2021 at 12:11 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 06.09.2021 17:10, Kai-Heng Feng wrote:
> > On Sat, Sep 4, 2021 at 4:00 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 03.09.2021 17:56, Kai-Heng Feng wrote:
> >>> On Tue, Aug 31, 2021 at 2:09 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>
> >>>> On Sat, Aug 28, 2021 at 01:14:52AM +0800, Kai-Heng Feng wrote:
> >>>>> r8169 NICs on some platforms have abysmal speed when ASPM is enabled.
> >>>>> Same issue can be observed with older vendor drivers.
> >>>>>
> >>>>> The issue is however solved by the latest vendor driver. There's a new
> >>>>> mechanism, which disables r8169's internal ASPM when the NIC traffic has
> >>>>> more than 10 packets, and vice versa. The possible reason for this is
> >>>>> likely because the buffer on the chip is too small for its ASPM exit
> >>>>> latency.
> >>>>
> >>>> This sounds like good speculation, but of course, it would be better
> >>>> to have the supporting data.
> >>>>
> >>>> You say above that this problem affects r8169 on "some platforms."  I
> >>>> infer that ASPM works fine on other platforms.  It would be extremely
> >>>> interesting to have some data on both classes, e.g., "lspci -vv"
> >>>> output for the entire system.
> >>>
> >>> lspci data collected from working and non-working system can be found here:
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=214307
> >>>
> >>>>
> >>>> If r8169 ASPM works well on some systems, we *should* be able to make
> >>>> it work well on *all* systems, because the device can't tell what
> >>>> system it's in.  All the device can see are the latencies for entry
> >>>> and exit for link states.
> >>>
> >>> That's definitely better if we can make r8169 ASPM work for all platforms.
> >>>
> >>>>
> >>>> IIUC this patch makes the driver wake up every 1000ms.  If the NIC has
> >>>> sent or received more than 10 packets in the last 1000ms, it disables
> >>>> ASPM; otherwise it enables ASPM.
> >>>
> >>> Yes, that's correct.
> >>>
> >>>>
> >>>> I asked these same questions earlier, but nothing changed, so I won't
> >>>> raise them again if you don't think they're pertinent.  Some patch
> >>>> splitting comments below.
> >>>
> >>> Sorry about that. The lspci data is attached.
> >>>
> >>
> >> Thanks for the additional details. I see that both systems have the L1
> >> sub-states active. Do you also face the issue if L1 is enabled but
> >> L1.2 and L1.2 are not? Setting the ASPM policy from powersupersave
> >> to powersave should be sufficient to disable them.
> >> I have a test system Asus PRIME H310I-PLUS, BIOS 2603 10/21/2019 with
> >> the same RTL8168h chip version. With L1 active and sub-states inactive
> >> everything is fine. With the sub-states activated I get few missed RX
> >> errors when running iperf3.
> >
> > Once L1.1 and L1.2 are disabled the TX speed can reach 710Mbps and RX
> > can reach 941 Mbps. So yes it seems to be the same issue.
>
> I reach 940-950Mbps in both directions, but this seems to be unrelated
> to what we discuss here.

OK. Is there anything more I need to address in next iteration?

Kai-Heng

>
> > With dynamic ASPM, TX can reach 750 Mbps while ASPM L1.1 and L1.2 are enabled.
> >
> >> One difference between your good and bad logs is the following.
> >> (My test system shows the same LTR value like your bad system.)
> >>
> >> Bad:
> >>         Capabilities: [170 v1] Latency Tolerance Reporting
> >>                 Max snoop latency: 3145728ns
> >>                 Max no snoop latency: 3145728ns
> >>
> >> Good:
> >>         Capabilities: [170 v1] Latency Tolerance Reporting
> >>                 Max snoop latency: 1048576ns
> >>                 Max no snoop latency: 1048576ns
> >>
> >> I have to admit that I'm not familiar with LTR and don't know whether
> >> this difference could contribute to the differing behavior.
> >
> > I am also unsure what role LTR plays here, so I tried to change the
> > LTR value to 1048576ns and yield the same result, the TX and RX remain
> > very slow.
> >
> > Kai-Heng
> >
>
