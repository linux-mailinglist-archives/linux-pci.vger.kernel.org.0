Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C842D1DC751
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 09:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEUHGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 03:06:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38463 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUHGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 03:06:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id f189so6308757qkd.5
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 00:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqZyQvj8CQ7gEi09rHTW9lIVtf4WDRzqE04BlRBiJZE=;
        b=lq9g/CrS0emlALl2kAj5xhn3PPaWj5J9qDrtAAd2p9+vhwEIDz6vwQls5E9HuiMSf0
         y8qCUewsupdwp0nk8LrLMEKg+0GavQo1lPXmzAExm7uzJkUJjmaLQmWHiuB17DP3zyGE
         XT7ZsEyQKYYbzmkgWJE7UdlZG4NuUNNlJ9slPUrqZAhuHbYTorKMrkWFPuRdgqhDYqOm
         M/11BuO+dMHBZPvMH1upoxXSJLyF0TttGc2tHbAIGyH4Y1yajSnz3DcEIdPU554yNIb2
         H3cjgf1u98OwlfaPE9QYr+pZP3NPyghQqJaJP2Fvsi9VqcgmPfzHKWMgPfGfyK1zSxSj
         OymQ==
X-Gm-Message-State: AOAM531tDg4czO+4yV34ARHZVsEk58lwsJVqdhiXerzAknDcRxpu/Rqy
        A3x0/xd0uvlU+Q/78IhKc6Kbesr/IBo=
X-Google-Smtp-Source: ABdhPJylrhVHB04IwX6B7brzQnTXTJv9IoF8rsCKapD37IO87tZQe69NXLIW3D9/vwcDU9bJ1iuGfQ==
X-Received: by 2002:a05:620a:1f7:: with SMTP id x23mr8715741qkn.491.1590044764831;
        Thu, 21 May 2020 00:06:04 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id z201sm4258133qkb.2.2020.05.21.00.06.04
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 00:06:04 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id m44so4711860qtm.8
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 00:06:04 -0700 (PDT)
X-Received: by 2002:ac8:547:: with SMTP id c7mr9115199qth.168.1590044764038;
 Thu, 21 May 2020 00:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAri2DoF-6A3qcag4etdWh3vQQUGqzfebw6syeU8HFeph5tWQw@mail.gmail.com>
 <20200520232954.GA1124908@bjorn-Precision-5520>
In-Reply-To: <20200520232954.GA1124908@bjorn-Precision-5520>
From:   Marcos Scriven <marcos@scriven.org>
Date:   Thu, 21 May 2020 08:05:52 +0100
X-Gmail-Original-Message-ID: <CAAri2Dqp1cpWnu7xeLiGqvbPEfyCSAoXoV9sRmcuYF=LN0U0Zg@mail.gmail.com>
Message-ID: <CAAri2Dqp1cpWnu7xeLiGqvbPEfyCSAoXoV9sRmcuYF=LN0U0Zg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Matisse HD Audio and USB Controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 May 2020 at 00:29, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 20, 2020 at 10:41:03AM +0100, Marcos Scriven wrote:
> > On Mon, 18 May 2020 at 20:26, Marcos Scriven <marcos@scriven.org> wrote:
> > >
> > > On Mon, 18 May 2020 at 17:17, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+cc Alex]
> > > >
> > > > On Sat, May 16, 2020 at 02:37:23PM +0100, Marcos Scriven wrote:
> > > > > This patch fixes an FLR bug on the following two devices:
> > > > >
> > > > > AMD Matisse HD Audio Controller 0x1487
> > > > > AMD Matisse USB 3.0 Host Controller 0x149c
> > > > >
> > > > > As there was already such a quirk for an Intel network device, I have
> > > > > renamed that method and updated the comments, trying to make it
> > > > > clearer what the specific original devices that were affected are
> > > > > (based on the commit message this was original done:
> > > > > https://git.thm.de/mhnn55/eco32-linux-ba/commit/f65fd1aa4f9881d5540192d11f7b8ed2fec936db).
> > > > >
> > > > > I have ordered them by hex product ID.
> > > > >
> > > > > I have verified this works on a X570 I AORUS PRO WIFI (rev. 1.0) motherboard.
> > > >
> > > > If we avoid FLR, is there another method used to reset these devices
> > > > between attachments to different VMs?  Does the lack of FLR mean we
> > > > can leak information between VMs?
> > > >
> > > > Would additional delay after the FLR work around this, e.g., something
> > > > like 51ba09452d11 ("PCI: Delay after FLR of Intel DC P3700 NVMe")?
> > > >
> > >
> > > Thanks for looking at this patch Bjorn.
> > >
> > > To take your three points:
> > >
> > > 1. Certainly I can see those devices able to be passed back and forth
> > > between host and guest multiple times, once this patch is applied.
> > >
> > > 2. I don't know the answer to that question; would appreciate guidance
> > > on how to determine this. Do you mean perhaps some buffered data in
> > > the USB controller, for instance?
> > >
> > > 3. I have not tried an additional delay. This is the logs I see when
> > > the error is occurring:
> > >
> > > [ 2423.556570] vfio-pci 0000:0c:00.3: not ready 1023ms after FLR; waiting
> > > [ 2425.604526] vfio-pci 0000:0c:00.3: not ready 2047ms after FLR; waiting
> > > [ 2428.804509] vfio-pci 0000:0c:00.3: not ready 4095ms after FLR; waiting
> > > [ 2433.924409] vfio-pci 0000:0c:00.3: not ready 8191ms after FLR; waiting
> > > [ 2443.140721] vfio-pci 0000:0c:00.3: not ready 16383ms after FLR; waiting
> > > [ 2461.571944] vfio-pci 0000:0c:00.3: not ready 32767ms after FLR; waiting
> > > [ 2496.387544] vfio-pci 0000:0c:00.3: not ready 65535ms after FLR; giving up
> > >
> > > What makes this bug especially bad is the host never recovers, and
> > > eventually hangs or crashes.
> > >
> > > For reference, the delay example you're talking about is:
> > >
> > > static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> > > {
> > > if (!pcie_has_flr(dev))
> > > return -ENOTTY;
> > >
> > > if (probe)
> > > return 0;
> > >
> > > pcie_flr(dev);
> > >
> > > msleep(250);
> > >
> > > return 0;
> > > }
> > >
> > > I don't know if it would work, but I will try it out and report back.
> > >
> > > Marcos
> > >
> > >
> >
> > Bjorn/Alex
> >
> > I have just tried the alternate approach of adding a 250ms delay to
> > the function level reset - this unfortunately results in the same
> > broken behaviour, with the host itself never recovering.
> >
> > [   76.905410] vfio-pci 0000:0d:00.3: not ready 1023ms after FLR; waiting
> > [   79.018014] vfio-pci 0000:0d:00.3: not ready 2047ms after FLR; waiting
> > [   82.089390] vfio-pci 0000:0d:00.3: not ready 4095ms after FLR; waiting
> > [   87.209416] vfio-pci 0000:0d:00.3: not ready 8191ms after FLR; waiting
> > [   96.425440] vfio-pci 0000:0d:00.3: not ready 16383ms after FLR; waiting
> > [  114.615491] vfio-pci 0000:0d:00.3: not ready 32767ms after FLR; waiting
> > [  149.417712] vfio-pci 0000:0d:00.3: not ready 65535ms after FLR; giving up
> >
> > I also tried a full second, to no avail.
> >
> > What would be the next step in proceeding with the original patch please?
>
> Implementation of FLR is "strongly recommended" by the spec but is
> optional.  So I don't see a problem with just avoiding it via your
> patch.
>
> I applied it to pci/virtualization for v5.8, thanks!
>
> Bjorn

Hi Bjorn

Wonderful news! Thanks again for your help.

Marcos
