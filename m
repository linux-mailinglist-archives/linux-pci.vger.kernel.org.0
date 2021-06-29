Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9193B6D02
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 05:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhF2DfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 23:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhF2De7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 23:34:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E04C061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 20:32:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k16so24860230ios.10
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMuFf3U3bymIWzb7jHsdeVe64zkSyYygXOWJmrfS37s=;
        b=m/UCdQlYoU9+VE06x5XNmxPnNmYp7laKuAy5PFRCq0/ekjOCXx02NZc1Hq9zvqMJGk
         MWIX+z6A3HeVQ53xhPmTwUJGX1cUcrUITaCUM74F/AaV6+azVzOlhxKxu95MLGnh/aE3
         0PE/sDb55GICuSzFYjXaxuax0A4bTlRttD8wXd1qgNavyuR3arOCE3s3TGhU/6tYbKJu
         TKrgZHAVD6UUUgW04a7fsjY2QemEmONmuRHHWY56wGk8UTZgxRUVh5zhGnsh6lJUrDz1
         owvI9u4th9YZF37zYb4XBjsQEUPWDLKZeyKAJdoBYhVBzS1RXUI4L57a+V73t7IhMlRL
         7/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMuFf3U3bymIWzb7jHsdeVe64zkSyYygXOWJmrfS37s=;
        b=c/OcQBjesPKmfDrOH/D+EhKvrQdjX/AocnL0oAMOKfJOIuPEnPsOOKxLkFOEvYjAHp
         jVUdWXddPiMpRfOKmfUShppgz7z1TKa0THv9TjFl7VzbEjxu9oCZxfqkJZBcCwPV3yOd
         bTLFYXQJYkBNymW5N4JkUCQ0Rq/B35udo/cTRT4qxqpHlPm9BQKZRrGgnTF1Fgzh4DHx
         BRHOy0p9kvTEVXwHJ5gh3HNYp9uzGMOFoABxgmDtij9qWDNPiyzlxxTj55rsv9HeBlM1
         4NoNfgkzo6MWzVPQxzcPV+EzZvQO8HbeNEzgT1XTcug67zYrWPM//l/w7gzQ4wlcv1Yh
         dHgA==
X-Gm-Message-State: AOAM533AosEQSvYznrlKmjP3cmeZBGieFEjHVBXHCXuuOsZ+UhXpQ9R6
        Z6DVS5nEnO/80BexzHdS09rv+VvjEaxRZNQ/LGk=
X-Google-Smtp-Source: ABdhPJw044wieFJSpjwi6M91SoBCgYNbRBQhYxnxdrFk2aO587aTsbiO9qNscpVa1Vjp3mVSulN0nHxeaKKNMB/vmLk=
X-Received: by 2002:a5d:8584:: with SMTP id f4mr2123770ioj.59.1624937551938;
 Mon, 28 Jun 2021 20:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6rmQjfeOhoLDUu_rCBGLUrL_Vi4wRAgNzSjEdOjSjUmg@mail.gmail.com>
 <20210629021231.GA3982831@bjorn-Precision-5520>
In-Reply-To: <20210629021231.GA3982831@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 29 Jun 2021 11:32:20 +0800
Message-ID: <CAAhV-H4FaV0PK-cy0dzzWxsHW2QM==HUoydz0oQAh042EHo_TQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Tue, Jun 29, 2021 at 10:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 29, 2021 at 10:00:20AM +0800, Huacai Chen wrote:
> > On Tue, Jun 29, 2021 at 4:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Sun, Jun 27, 2021 at 06:25:04PM +0800, Huacai Chen wrote:
> > > > On Sat, Jun 26, 2021 at 6:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Jun 25, 2021 at 05:30:29PM +0800, Huacai Chen wrote:
> > > > > > In new revision of LS7A, some PCIe ports support larger value than 256,
> > > > > > but their maximum supported MRRS values are not detectable. Moreover,
> > > > > > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > > > > > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > > > > > will actually set a big value in its driver. So the only possible way is
> > > > > > configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
> > > > > > PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.
> > > > > >
> > > > > > However, according to PCIe Spec, it is legal for an OS to program any
> > > > > > value for MRRS, and it is also legal for an endpoint to generate a Read
> > > > > > Request with any size up to its MRRS. As the hardware engineers says,
> > > > > > the root cause here is LS7A doesn't break up large read requests (Yes,
> > > > > > that is a problem in the LS7A design).
> > > > >
> > > > > "LS7A doesn't break up large read requests" claims to be a root cause,
> > > > > but you haven't yet said what the actual *problem* is.
> > > > >
> > > > > Is the problem that an endpoint reports a malformed TLP because it
> > > > > received a completion bigger than it can handle?  Is it that the LS7A
> > > > > root port reports some kind of error if it receives a Memory Read
> > > > > request with a size that's "too big"?  Maybe the LS7A doesn't know
> > > > > what to do when it receives a Memory Read request with MRRS > MPS?
> > > > > What exactly happens when the problem occurs?
> > > >
> > > > The hardware engineer said that the problem is: LS7A PCIe port reports
> > > > CA (Completer Abort) if it receives a Memory Read
> > > > request with a size that's "too big".
> > >
> > > What is "too big"?
> > >
> > "Too big" means bigger than the port can handle, PCIe SPEC allows any
> > MRRS value, but, but, LS7A surely violates the protocol here.
>
> Right, I just wanted to know what the number is.  That is, what values
> we can write to MRRS safely.
>
> But ISTR you saying that it's not actually fixed, and that's why you
> wanted to rely on what firmware put there.
Yes, it's not fixed (256 on some ports and 4096 on other ports), so we
should heavily depend on firmware.

Huacai
>
> This is important to know for the question about hot-added devices
> below, because a hot-added device should power up with MRRS=512 bytes,
> and if that's too big for LS7A, then we have a problem and the quirk
> needs to be more extensive.
>
> > > I'm trying to figure out how to make this work with hot-added devices.
> > > Per spec (PCIe r5.0, sec 7.5.3.4), devices should power up with
> > > MRRS=010b (512 bytes).

> > >
> > > If Linux does not touch MRRS at all in hierarchices under LS7A, will a
> > > hot-added device with MRRS=010b work?  Or does Linux need to actively
> > > write MRRS to 000b (128 bytes) or 001b (256 bytes)?
Emm, hot-plug is a problem, maybe we can only disable hot-plug in
board design...

Huacai
> > >
> > > Bjorn
