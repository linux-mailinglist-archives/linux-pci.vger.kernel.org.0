Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B685B10DB43
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 22:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfK2VoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 16:44:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39589 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2VoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 16:44:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id d124so11554208qke.6
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2019 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3Xs0CQVZmeQA3Vdfnwn92z4nQazeWOpTUsfR+WB79M=;
        b=aGwio6+HVzCkLlkPoQj49RuDXf16/8Ir6SBBPVouKfxQvQv3oxLYJig0nTpl/GYgtI
         sLz/+LA0x6dcSzQa4sRTAm0kudkbPqKZwOT2E+nZuEhTHafhdiNbdu+UJbDFqg7vl4DG
         8SQQMM/QXIYjYUt+ywAgmsb1zdlH7uf3HcWUBqWcg4Utav2HrmoW/JLwspA/KNFrFoSt
         YyX7gOhSBJe1DtjM/lpr76L4byZTO14JUsAZyPTDMMyUGO759ZDDumSlOiqRzbeekGT0
         z6GYkM4v5gEgSS5863A+9Urb9wgglUXqHvmEtS9wdYkSVJnQxriSsgi0+acMy/LT1jgN
         a9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3Xs0CQVZmeQA3Vdfnwn92z4nQazeWOpTUsfR+WB79M=;
        b=oGIsunwM+f6NYAJ+f21cyQyZKxdKnjDSZ2bUQfT53S57PArli3+QByqduQhEk502Is
         +0P+vK6uo8rgKlGGv+d2BbRDwQgkzb28dFttvr3rqVbS+xVnxGt59wfGtBP1elTffACn
         LVHxDtQrJj9HwlnsTjH2dhGpfLdsUQM3WWxjqOngPH5/1pXOD9TqqPXcvo4mEKpmpHLR
         p6Vio06wljzr2OxdzRybBQ7sOUPF+D6XaoYVcnLYFOh5a3ZHtjI4gB+IWLviccs+vVqK
         qlZluB4QJapT8GDyMJFZHGK5g1hFfhlVozXiCIxIc+fFuq/8F1Q0SVKvgn2nfV9jWcre
         RWMQ==
X-Gm-Message-State: APjAAAV9b6DxThURaa8LuOANxb5OJGYlgGNQ3wulwj4zvNsbfnKXYN5L
        wPF0As2PohrxVRhfcyPGWrSrw+lqisTrOodWKijbJA==
X-Google-Smtp-Source: APXvYqz68xmpSEN6M2G1u1P39XQQQlsRAyRlTACG2DiFoiKp+p9uW4stR+jgQJAw1CmrJdX34YS3JXvwQ34aWT0eP20=
X-Received: by 2002:a37:7f45:: with SMTP id a66mr17162986qkd.427.1575063842507;
 Fri, 29 Nov 2019 13:44:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2oMhJ10FTcNH5wqWT2nfNz4jwG0BYr1DcVYTUPOcsSwpkMYg@mail.gmail.com>
 <20191129183836.GA20312@google.com>
In-Reply-To: <20191129183836.GA20312@google.com>
From:   Ranran <ranshalit@gmail.com>
Date:   Fri, 29 Nov 2019 23:43:50 +0200
Message-ID: <CAJ2oMhJaHSqj1_gVDfWF+V4wn3YMFxhDKs-E4cTQ7G9bUBPW8A@mail.gmail.com>
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 29, 2019 at 8:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 29, 2019 at 06:10:51PM +0200, Ranran wrote:
> > On Fri, Nov 29, 2019 at 4:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=205701
> > > > ...
> > > >
> > > > Using Intel Xeon computer with linux kernel 4.18.0 centos8.
> > > > Trying to access RAM (with DMA) using FPGA  fails in this computer.
> > > >
> > > > 1. I tried to add intel_iommu=off - it did not help.
> > > >
> > > > 2. Installing windows on same PC - FPGA can access RAM using DMA without
> > > > issues.
> > > >
> > > > 3. using another PC (Intel Duo) with same linux and OS - FPGA access works.
> > > >
> > > > FPGA access the RAM using a physical address provided by a kernel module which
> > > > allocates physical continuous memory in PC. (the module works perfectly with
> > > > Intel Duo on exactly same OS and kernel).
> > >
> > > Hi, thanks for the report!  Can you please attach the complete dmesg
> > > and "sudo lspci -vv" output for the working and non-working v4.18
> > > kernels to the bugzilla?
> > >
> > > Then please try to reproduce the problem on the current v5.4 kernel
> > > and attach the v5.4 dmesg log.  If v5.4 fails, we'll have to debug it.
> > > If v5.4 works, figure out what fixed it (by comparing dmesg logs or by
> > > bisection) and backport it to v4.18.
> > >
> > > Bjorn
> >
> > Hi,
> > I've attached 2 files:
> > 1. dmesg.log - is the dmesg you've requested.
> > 2. dmesg_intel_iommu_off.log - dmesg when I added intel_iommu=off
> > kernel parameter.
>
> Thanks, I attached these to the bugzilla.  I think the linux-pci
> mailing list rejected your mail since it wasn't plain-text.
>
> Please also attach the "sudo lspci -vv" output to the bugzilla and
> indicate which device is your FPGA.  I guess it might be 0000:20:00.0,
> since it looks like it's being claimed by an out-of-tree module in
> your dmesg_intel_iommu_off.log (but not dmesg.log).
>
> Please also attach the driver source so we can see how it is obtaining
> and using the DMA buffer address.
>

I've added the module in bugzilla,

I will try to fetch the other information you requested and update in bugzilla.

Thank you

> > I might try the new kernel, yet since we are required to use the
> > installation of centos8  (centos8 was just published about 2 month ago
> > and it comes with kernel 4.18.0), updating kernel might be
> > problematic.
>
> Even if you can't use the v5.4 kernel for your project, if you can
> establish that it works, then you have a clear path to finding the
> fix.  If v5.4 still *doesn't* work, then we'll be much more interested
> in helping to fix that.
>
> > I would please like to ask if there is some workaround you can think of ?
> > For example, might it help if I disable iommu (VT-d) in BIOS ?
>
> Usually when an IOMMU blocks a DMA, it seems like there's a note in
> dmesg.  I don't see that in either of your logs, but I'm not an IOMMU
> expert, so it does seem reasonable to try disabling the IOMMU.
>
> Bjorn
