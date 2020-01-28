Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18D14ADDA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 03:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA1CJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 21:09:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41095 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1CJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jan 2020 21:09:19 -0500
Received: by mail-io1-f67.google.com with SMTP id m25so12450837ioo.8;
        Mon, 27 Jan 2020 18:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jqeka4BRN4QCngINzPSMLmJvVtJZ+1civQXaHl9LEDU=;
        b=C2nySqPo3DP5zUI8IHxkiPq3mjvT9ZQJ2FWeALKWoafxbpxXKAbIzhv3ZNS55XAx36
         L5jUaL3lhl9wM2FZJSY9jOPEJU9DrAaTWlNu/uJzhcUEOD1uI07VSn/rz4Sx1HVEM+SX
         rUOhFR0QiCRR7vb9Toywv7Eg3nSJp02dUIZ7PsBhqTHjjlI46gGYrP/jKBxRHcD+t6Ny
         iTErSIWGrSxsmE4hV6bsPiHhW9+99BM3BbX/kWWWeNAT06b4zYLKx83/XdVFWrYzdn2v
         xLRtABKiTjYUnx2T7CihXALM2CACMml8iUqpyuuDGGYTHZEIe7xpsOVk77b79SYqbcFT
         qpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jqeka4BRN4QCngINzPSMLmJvVtJZ+1civQXaHl9LEDU=;
        b=cBbCseaOXkt6lYPxD+Qvrkd0IUVNX5uhj+IWnARJhPcE/nNEUJp/5IcSYDb+sbZb7P
         VF5kqVWYVYDop87/OxLzIwGx8ubwanM+Wczu3wfRa0cE2MvXcyVPGxTMP6KYDUkAE6+g
         jvwtIay2qOa2uW7r7nP2LZeM9xfTvUWKBBfFaf2L7rTy7o8gp7yU0VFj8ztvEPjRRZvc
         2cHpudfsOtkqqxiT2OiI53AvJ9dMvE2IJD8kMqK2t4Ffx7fQMPSlK7/jE7j7rru44h7k
         1CLg5gAIeH8MNRtlBc0920Fz716RzT3+PfMzxSdZIrQP5san3MbuGxeRsxB6uyWXCaj6
         KsYQ==
X-Gm-Message-State: APjAAAWBMEanF74XCMmplbI3UTMYCmLvMBuGnJN1WJhEVIAakaWhvN50
        AzwC+PT7K3/qXFLHSsYES+TTT3O28SLyj5YEpmfadg==
X-Google-Smtp-Source: APXvYqzlDUE7G1Cuqxvk6DspgP0RYK+1bgmqnUAa+UnGxlsbxG55exqQISC752x7GdmlfCj/k3BIaeo+bpCjBIQ2KXI=
X-Received: by 2002:a6b:4e1a:: with SMTP id c26mr13878144iob.154.1580177358558;
 Mon, 27 Jan 2020 18:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20200124144248.11719-1-yu.c.chen@intel.com> <20200124192743.GL4675@bombadil.infradead.org>
In-Reply-To: <20200124192743.GL4675@bombadil.infradead.org>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Tue, 28 Jan 2020 10:09:07 +0800
Message-ID: <CADjb_WTBuhtKpko4dSh3Rj9D3=ie3hyh-nU6ib-XsCu9br1XZQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] PCI: Add "pci=blacklist_dev=" parameter to blacklist
 specific devices
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Matthew,
Thanks for repy.
On Sat, Jan 25, 2020 at 5:01 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 24, 2020 at 10:42:48PM +0800, Chen Yu wrote:
> > It was found that on some platforms the bogus pci device might bring
> > troubles to the system. For example, on a MacBookPro the system could
> > not be power off or suspended due to internal pci resource confliction
> > between bogus pci device and [io 0x1804]. Another case is that, once
> > resumed from hibernation on a VM, the pci config space of a pci device
> > is corrupt.
> >
> > To narrow down and benefit future debugging for such kind of issues,
> > introduce the command line blacklist_dev=<vendor:device_id>> to blacklist
> > such pci devices thus they will not be scanned thus not visible after
> > bootup. For example,
> >
> >  pci.blacklist_dev=8086:293e
> >
> > forbid the audio device to be exposed to the OS.
>
> This feels really unsafe to me.  Just because Linux ignores the device
> doesn't mean the device will ignore I/O requests.  I think we should
> call this pci.disable_dev and clear the device's I/O Space Enable,
> Memory Space Enable and Bus Master Enable bits (in the Command register,
> config space offset 4).
Oh right, the BIOS might already has enabled Memory/IO space
in the config during boot up and thus has already claimed the resource range
for this pci device.
I'll summarize the problem I found currently in Bjorn's reply and let's
discuss it there.

Thanks,
chenyu
