Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B541E688
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 06:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhJAETY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 00:19:24 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57314
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237622AbhJAETY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 00:19:24 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BACA44028F
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 04:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633061859;
        bh=SQu/5bN0exvN+2VZmVqasdBLNWTyrRXGdzKFgUCYVbs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tjFsHEe7FFjNcbpMQ7PL/T7RZOI2ognR2H++m/2q41FRa00Bv4TKAkzR65JmqCeM7
         yYTCJD4cVzKwRiC0pZHlny8vxxUuZE7zaMDlVoKX1hbpHqGcPak5FVgpf0uZrqW6hL
         VMcvuK4Xz62WKrNMkwhTWiqCpq9TVj1aDJy6yDjrRjxEQWzqvgqUdg7CG7GFjrc/kc
         iKSx5uO88f9xbcarEHGv6B0tWyGmjoPlNpXGkAxFV+Oav+pgCRb8sH47ZdEwkFs81U
         jbfYqcOmDavadiaJ36jUu8SflLq/FIhtkjuqzfl8MC1dsuOZ4GSh9Nptah2FjDK3jq
         1aplwvQt52wyQ==
Received: by mail-ot1-f71.google.com with SMTP id m12-20020a0568301e6c00b005469f1a7d70so5835199otr.15
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 21:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQu/5bN0exvN+2VZmVqasdBLNWTyrRXGdzKFgUCYVbs=;
        b=s8iJ9IxdRjkVhJKMDxcq0rZPI+3W/XJ7GjdThboef/GIyXdoqBp5DveBx3EEREPb0e
         jLTefunKfhRzZyAv92SScVbl/UIoeTFXz1xN/SOEHutTDnQUUB6KkigTrZGfTH/mDcQC
         DcRCkl6O/cwP5k5i/+btXOtk3gsROAKpEgb4/cphFCLpFcAcemEQdmruSIvh5UpqR80J
         e34qfAQetszGQTN1/KnQBnJj9MjQ9z7KuGZbWqZTYZGKHlS1Ozm5Y0zmFuVoAGY3RDi0
         i1XPtfrXPi1JOzcfd8caRRmGSheFM6Shj2boV77nuOhsWNs50IwV8YPlUAXk/WeNqkKE
         /xRg==
X-Gm-Message-State: AOAM531RTfJCEbrHC/x+mxXL3RVaQAbUpX+Oh7cmmg2Nwt4/4sn2gf0u
        3fIrDlFgfnuQH02PpuGIwyYTX/u/wohblUKkOW/QN5CMR0kKFJCzVkmIWUd+1LlWfRWnLtXTgb2
        9OmAVMK8WZ2Fp69j/KLfMxRIpYFAjBrdRCsgEoWcGxCyEfY8x9TZhPw==
X-Received: by 2002:a9d:6655:: with SMTP id q21mr8298623otm.269.1633061858447;
        Thu, 30 Sep 2021 21:17:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5sIFTWlNrMXzTMDwY9YsLGtg0P9BgxhaFy/YbVon+0xU6YDee9qv+1r4cYz7/RpEmtDpUMMD7dYG2ftih8jY=
X-Received: by 2002:a9d:6655:: with SMTP id q21mr8298609otm.269.1633061858170;
 Thu, 30 Sep 2021 21:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210916154417.664323-1-kai.heng.feng@canonical.com> <20210917220942.GA1748301@bjorn-Precision-5520>
In-Reply-To: <20210917220942.GA1748301@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 1 Oct 2021 12:17:26 +0800
Message-ID: <CAAd53p409uhbor1ArZ=kfiMK2JRHVGVyYukDSSyDvFsVSs=ErQ@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v5 0/3] r8169: Implement dynamic ASPM
 mechanism for recent 1.0/2.5Gbps Realtek NICs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 18, 2021 at 6:09 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 11:44:14PM +0800, Kai-Heng Feng wrote:
> > The purpose of the series is to get comments and reviews so we can merge
> > and test the series in downstream kernel.
> >
> > The latest Realtek vendor driver and its Windows driver implements a
> > feature called "dynamic ASPM" which can improve performance on it's
> > ethernet NICs.
> >
> > Heiner Kallweit pointed out the potential root cause can be that the
> > buffer is too small for its ASPM exit latency.
>
> I looked at the lspci data in your bugzilla
> (https://bugzilla.kernel.org/show_bug.cgi?id=214307).
>
> L1.2 is enabled, which requires the Latency Tolerance Reporting
> capability, which helps determine when the Link will be put in L1.2.
> IIUC, these are analogous to the DevCap "Acceptable Latency" values.
> Zero latency values indicate the device will be impacted by any delay
> (PCIe r5.0, sec 6.18).
>
> Linux does not currently program those values, so the values there
> must have been set by the BIOS.  On the working AMD system, they're
> set to 1048576ns, while on the broken Intel system, they're set to
> 3145728ns.
>
> I don't really understand how these values should be computed, and I
> think they depend on some electrical characteristics of the Link, so
> I'm not sure it's *necessarily* a problem that they are different.
> But a 3X difference does seem pretty large.
>
> So I'm curious whether this is related to the problem.  Here are some
> things we could try on the broken Intel system:

Original network speed, tested via iperf3:
TX: ~255 Mbps
RX: ~490 Mbps

>
>   - What happens if you disable ASPM L1.2 using
>     /sys/devices/pci*/.../link/l1_2_aspm?

TX: ~670 Mbps
RX: ~670 Mbps

>
>   - If that doesn't work, what happens if you also disable PCI-PM L1.2
>     using /sys/devices/pci*/.../link/l1_2_pcipm?

Same as only disables l1_2_aspm.

>
>   - If either of the above makes things work, then at least we know
>     the problem is sensitive to L1.2.

Right now the downstream kernel disables ASPM L1.2 as workaround.

>
>   - Then what happens if you use setpci to set the LTR Latency
>     registers to 0, then re-enable ASPM L1.2 and PCI-PM L1.2?  This
>     should mean the Realtek device wants the best possible service and
>     the Link probably won't spend much time in L1.2.

# setpci -s 01:00.0 ECAP_LTR+4.w=0x0
# setpci -s 01:00.0 ECAP_LTR+6.w=0x0

Then re-enable ASPM L1.2, the issue persists - the network speed is
still very slow.

>
>   - What happens if you set the LTR Latency registers to 0x1001
>     (should be the same as on the AMD system)?

Same slow speed here.

Kai-Heng
