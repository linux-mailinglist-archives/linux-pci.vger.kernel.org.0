Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04B5475D59
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 17:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbhLOQ0t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 11:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhLOQ0t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 11:26:49 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4B8C061574
        for <linux-pci@vger.kernel.org>; Wed, 15 Dec 2021 08:26:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id f74so3784790pfa.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Dec 2021 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTRbuI/6g5AXvWugU85g5gbhP7TTAqjknAxL9YJEtAE=;
        b=JqGbzjGn+Ec5smoj95rmRBhpNTJewqtE3YrTn9VYiKlm0s2Lnw759T+sySM60GbGTQ
         RWY9RXPiQxBTHY48MhgSKrpeweqDxV9DkRJgRWinpzrg93jgB54R3aweFHmFYBJXuStS
         FQih2gnmkUOQ61ZjMcU5qfQQvhABS6tvWDsBazBaxOxyDyYVyR18tt4re+tuu2QI7hKv
         uURujgOgLPcgY+NQvTtXZl4626OBVYHbBTaHeh9uPs2XM/ahuT3TFJxhAiCvGU8opksg
         UYkwN5CUEm2ZRgc7czSID4uVZUlXFmurmQ+a5y5gWz+O2aD2Z9W9Q8iqq8xe1wfK3qPJ
         d1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTRbuI/6g5AXvWugU85g5gbhP7TTAqjknAxL9YJEtAE=;
        b=Y6FTXLEqTTSFk3Cl0ATo1D/WebdBjqs813UWLcgJcwwSKKGtK/73TF/4wOXFFCMh/W
         p8oCtM1DQjUigB5sf8IFHKNgvxhGhRF39gsADD+m++1hHTPEHB7t0KGGzknkgmKlfHo8
         vhxtlBXqgIydgJzq42ggFQAjAdRgC6gFS3jG1mjiyv180QFcMuVp34FJw2WacIi8whJM
         EqyK0MIOGlbiDa48k7+lIEx6r3FaEwvV2toNJwIq1SQcTB6mu9mTIVCyPlDjCelRoFqg
         itgPlBWSgiXHHjs419LWbXgTFymvJJ7RacfAL4H6RBR1PJHURGoHU/oGmcq1D81fJv+W
         yiXg==
X-Gm-Message-State: AOAM530WgVC2y38uU7/eQamphLNuSSwaGgBm8uN1EfIu9HdrIBMGO4lz
        FtyVcDiNSufV9O1VE84PH2KjHk0ljazm7X9cLP3gLw==
X-Google-Smtp-Source: ABdhPJw3EKwx98eRkVsM8cLAFAc9HWEt7P8Xqr1FUlNgASGNZeP+xf6ADzAIkY3xqbrGDAzyTCWijQSI6C4AxxTV7Mw=
X-Received: by 2002:a63:5d57:: with SMTP id o23mr6284724pgm.115.1639585608269;
 Wed, 15 Dec 2021 08:26:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU0OZvy4RamHZ18aJ6+AiO3BxXQx-3-sQYop6sF1QRMmwA@mail.gmail.com>
 <20211203233131.GE3839336@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211203233131.GE3839336@dhcp-10-100-145-180.wdc.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 15 Dec 2021 08:26:37 -0800
Message-ID: <CAJ+vNU3rEgc+G67ETAcSo6FaLc39AoMzwrxmY8jQLN0VOShkyA@mail.gmail.com>
Subject: Re: IMX8MM PCIe performance evaluated with NVMe
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Barry Long <barry@epiqsolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 3, 2021 at 3:31 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Dec 03, 2021 at 01:52:17PM -0800, Tim Harvey wrote:
> > Greetings,
> >
> > I'm using PCIe on the IMX8M Mini and testing PCIe performance with a
> > NVMe constrained to 1 lane. The NVMe in question is a Samsung SSD980
> > 500GB which claims 3500MB/s read speed (with a gen3 x4 link).
> >
> > My understanding of PCIe performance would give the following
> > theoretical max bandwidth based on clock and encoding:
> > pcie gen1 x1 : 2500MT/s*1lane*80% (8B/10B encoding) = 2000Mbps = 250MB/s
> > pcie gen2 x1 : 5000MT/s*1lane*80% (8B/10B encoding) = 4000Mbps = 500MB/s
> > pcie gen3 x1 : 8000MT/s*1lane*98.75% (128B/130B encoding) = 7900Mbps = 987.5MB/s
> > pcie gen3 x4 : 8000MT/s*4lane*98.75% (128B/130B encoding) = 31600Mbps = 3950MB/s
> >
> > My assumption is an NVMe would have very little data overhead and thus
> > be a simple way to test PCIe bus performance.
>
> Your 'dd' output is only reporting the user data throughput, but there
> is more happening on the link than just user data.
>
> You've accounted for the bit encoding, but there's more from the PCIe
> protocol: the PHY layer (SOS), DLLP (Ack, FC), and TLP (headers,
> sequences, checksums).
>
> NVMe itself also adds some overhead in the form of SQE, CQE, PRP, and
> MSIx.
>
> All told, the best theoretical bandwidth that user data will be able to
> utilize out of the link is going to end up being ~85-90%, depending on
> your PCIe MPS (Max Payload Size) setting.
>
> > Testing this NVMe with 'dd if=/dev/nvme0n1 of=/dev/null bs=1M
> > count=500 iflag=nocache' on various systems gives me the following:
>
> If using 'dd', I think you want to use 'iflag=direct' rather than 'nocache'.
>
> > - x86 gen3 x4: 2700MB/s (vs theoretical max of ~4GB/s)
> > - x86 gen3 x1: 840MB/s
> > - x86 gen2 x1: 390MB/s
> > - cn8030 gen3 x1: 352MB/s (Cavium OcteonTX)
> > - cn8030 gen2 x1: 193MB/s (Cavium OcteonTX)
> > - imx8mm gen2 x1: 266MB/s
> >
> > The various x86 tests were not all done on the same PC or the same
> > kernel or kernel config... I used what I had around with whatever
> > Linux OS was on them just to get a feel for performance and in all
> > cases but the x4 case lanes 2/3/4 were masked off with kapton tape to
> > force a 1-lane link.
> >
> > Why do you think the IMX8MM running at gen2 x1 would have such a lower
> > than expected performance (266MB/s vs the 390MB/s an x86 gen2 x1 could
> > get)?
> >
> > What would a more appropriate way of testing PCIe performance be?
>
> Beyond the protocol overhead, 'dd' is probably not going to be the best
> way to meausre a device's performance. This sends just one command at a
> time, so you are also measuring the full software stack latency, which
> includes a system call and interrupt driven context switches. The PCIe
> traffic would be idle during this overhead when running at just qd1.
>
> I am guessing your x86 is simply faster at executing through this
> software stack than your imx8mm, so the software latency is lower.
>
> A better approach may be to use higher queue depths with batched
> submissions so that your software overhead can occur concurrently with
> your PCIe traffic. Also, you can eliminate interrupt context switches if
> you use polled IO queues.

Thanks for the response!

The roughly 266MB/s performance results I've got on IMX8MM gen2 x1
using NVMe and plain old 'dd' is on par with what another has found
using a custom PCIe device of theirs and a simple loopback test so I
feel that the 'software stack' isn't the bottleneck here (as that's
removed in his situation). I'm leaning towards something like
interrupt latency. I'll have to dig into the NVMe device driver and
see if there is a way to hack it to poll to see what the difference
is.

Best regards,

Tim
