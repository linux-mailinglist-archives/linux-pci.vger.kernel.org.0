Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A13246CC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 23:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhBXWWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 17:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhBXWWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 17:22:11 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EDBC061574
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 14:21:31 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id gi9so1828421qvb.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 14:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+Ws0H8aZmmSHwNg5CvM4WzvbCuH9D2Tensi0Nawd0U=;
        b=VhxTataecCd3AYUj+zVSJV3dKyGBwatIaHXsTCYPQoeun8xOzfi6wX8xEjf3Q1kNLB
         gYXYnzLiK6Pu14cCSYGhyfDHtElh4Vu5iX2KVPobxNswV12CMJy+Od46eZY7FxpjODSu
         zF5Ubp6BsII5PvCrmXHT9PoGzretkjS0EqbBRAWQFMg7Bbof6qri/I2EEe2a0/B11yHD
         YgsI6eHAETXunT9Cr+6l2uFI5FgS4F2rDwCYwIXgtEpPwM91K3ZK6I8vsa4hz4GLdJL9
         8QveIeiXrBnxuuqix5ayKs/mSlCqYcsNIooAS90SWHfnT8XCqmCsUQPBV5a6eA51PEMU
         HRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+Ws0H8aZmmSHwNg5CvM4WzvbCuH9D2Tensi0Nawd0U=;
        b=FPKRI97UCRxtzO6LskL1qA86/v1FfRlhirlH3nx3u2hkQAsx9zypS8EY1U2TqzqSlE
         oODDTjDvPe2mDRYapGw5wns/J3ojKhzLEWAo9sLwYjgWM/Q/m53jkjKBQhsESFfQ6S9x
         pkeezfTY/1EIFkDxfiy+sfA+uWbyimbd1zxtG9DNOorTSiCefNbsHBuIYFlt2s/Q3kyc
         8CRCUxCf+wlwJLioHIP8dr5C+Z126zQpzIXQizLR1pVnE3UjCxGCusQYogNdGr+a8HBT
         BjGqOLYZjDdsOLqGhyx43uvgORMT+hQnC69rN6JSHBgPAOEDj7XdiGR2SVNKyOkpicAF
         USFQ==
X-Gm-Message-State: AOAM532XMJ5SgtZoUbeWrMWL6PkMy2xrvz+35V34mXBWlS4DvPy5oMn4
        QQ6f7/brWYeEzipr6LrdaIqZpAJtg4L6uz2B56A=
X-Google-Smtp-Source: ABdhPJwctqSZ6Y7ca6uHMUK9QGra3REq9umT7RyOsfO52NZSIenyc55Y+5/1kpjWXv9MSyI6TM8JsZT1vNpw0PWlTtg=
X-Received: by 2002:a05:6214:b2c:: with SMTP id w12mr29515189qvj.41.1614205290429;
 Wed, 24 Feb 2021 14:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20201024205548.1837770-1-ian.kumlien@gmail.com>
 <20210112204202.GA1489918@bjorn-Precision-5520> <CAA85sZuANe2+-c38LezjeMAjNve9Cj_zamSBe5mTiB+HXX0fdw@mail.gmail.com>
In-Reply-To: <CAA85sZuANe2+-c38LezjeMAjNve9Cj_zamSBe5mTiB+HXX0fdw@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 24 Feb 2021 23:19:55 +0100
Message-ID: <CAA85sZuSZck+mTnCTkGikuxQpmNyiShmrbhUUtv91rZARL5Jsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 1:41 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Sorry about the late reply, been trying to figure out what goes wrong
> since this email...
>
> And yes, I think you're right - the fact that it fixed my system was
> basically too good to be true =)

So, finally had some time to look at this again...

I played some with:
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..fdf252eee206 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -392,13 +392,13 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)

        while (link) {
                /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
+               if ((link->aspm_capable & ASPM_STATE_L0S_UP) /* &&
+                   (link->latency_up.l0s > acceptable->l0s)*/)
                        link->aspm_capable &= ~ASPM_STATE_L0S_UP;

                /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
+               if ((link->aspm_capable & ASPM_STATE_L0S_DW) /* &&
+                   (link->latency_dw.l0s > acceptable->l0s)*/)
                        link->aspm_capable &= ~ASPM_STATE_L0S_DW;
                /*
                 * Check L1 latency.
---

Which does perform better but doesn't solve all the issues...

Home machine:
Latency:       3.364 ms
Download:    640.170 Mbit/s
Upload:      918.865 Mbit/s

My test server:
Latency:       4.549 ms
Download:    945.137 Mbit/s
Upload:      957.848 Mbit/s

But iperf3 still gets bogged down...
[  5]   0.00-1.00   sec  4.66 MBytes  39.0 Mbits/sec    0   82.0 KBytes
[  5]   1.00-2.00   sec  4.60 MBytes  38.6 Mbits/sec    0   79.2 KBytes
[  5]   2.00-3.00   sec  4.47 MBytes  37.5 Mbits/sec    0   56.6 KBytes

And with L1 ASPM disabled as usual:
[  5]   0.00-1.00   sec   112 MBytes   938 Mbits/sec  439    911 KBytes
[  5]   1.00-2.00   sec   109 MBytes   912 Mbits/sec  492    888 KBytes
[  5]   2.00-3.00   sec   110 MBytes   923 Mbits/sec  370   1.07 MBytes

And just for reference, bredbandskollen again with L1 ASPM disabled:
Latency:       2.281 ms
Download:    742.136 Mbit/s
Upload:      938.053 Mbit/s

Anyway, we started to look at the PCIe bridges etc, but i think it's
the network card
that is at fault, either with advertised latencies (should be lower)
or some bug since
other cards and peripherals connected to the system works just fine...

So, L0s actually seems to have somewhat of an impact - which I found
surprising sice
both machines are ~6 hops away - however latency differs (measured with tcp)

Can we collect L1 ASPM latency numbers for:
Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)

> On Tue, Jan 12, 2021 at 9:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > My guess is the real problem is the Switch is advertising incorrect
> > exit latencies.  If the Switch advertised "<64us" exit latency for its
> > Upstream Port, we'd compute "64us exit latency + 1us Switch delay =
> > 65us", which is more than either 03:00.0 or 04:00.0 can tolerate, so
> > we would disable L1 on that upstream Link.
> >
> > Working around this would require some sort of quirk to override the
> > values read from the Switch, which is a little messy.  Here's what I'm
> > thinking (not asking you to do this; just trying to think of an
> > approach):
>
> The question is if it's the device or if it's the bridge...
>
> Ie, if the device can't quite handle it or if the bridge/switch/port
> advertises the wrong latency
> I have a friend with a similar motherboard and he has the same latency
> values - but his kernel doesn't apply ASPM
>
> I also want to check L0s since it seems to be enabled...
>
> >   - Configure common clock earlier, in pci_configure_device(), because
> >     this changes the "read-only" L1 exit latencies in Link
> >     Capabilities.
> >
> >   - Cache Link Capabilities in the pci_dev.
> >
> >   - Add a quirk to override the cached values for the Switch based on
> >     Vendor/Device ID and probably DMI motherboard/BIOS info.
>
> I can't say and I actually think it depends on the actual culprit
> which we haven't quite identified yet...
>
> > Bjorn
