Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9EF1B8E99
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 11:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDZJ6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 05:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDZJ6V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 05:58:21 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4372070A
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587895101;
        bh=rUyV4pt/g7F908RwLX3i+yj94w0SwCRhmQzqbjnowsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=URgvqn9wvCkb4AyrS66j2B7y+1mEEZI46Z4e4BNYRBrbtpMQ1SyHQ6djaIHIiNWyl
         PUbaV7dn/kfu5VDav/Q4j/p+1c7HZztgnT7V91CMmHBoGywp1jplCeeKXxQcu2mhwS
         o5CkJDMDXEPJyw9AsT2KWK7YLf1epd9KkyoPNnW8=
Received: by mail-il1-f171.google.com with SMTP id t12so13894881ile.9
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 02:58:20 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ+HgESzWsB0Bbpb/QRd3S9Jhhp22S2Ovb0CNop/vIvUGENc43J
        pLo59Vop4OOQ33LmseK8QhNJv27t9+2kl+Dm2Aw=
X-Google-Smtp-Source: APiQypImW/86phTT65AtNNbN7D+xPcJ8otnB/480lX2o8t2xp1nK4/DpLdFUVU5yfvP0eMjbzc1oHX7/zeaduvpgQ0c=
X-Received: by 2002:a92:3c55:: with SMTP id j82mr17036757ila.258.1587895100290;
 Sun, 26 Apr 2020 02:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200421162256.26887-1-ardb@kernel.org> <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com> <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com>
In-Reply-To: <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 26 Apr 2020 11:58:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
Message-ID: <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        jon@solid-run.com, wasim.khan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 26 Apr 2020 at 11:08, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
> > On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
> >> On Tue, 21 Apr 2020 at 18:43, Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
> >>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
> >>>> bring the bridge windows of parent bridges in line with the new BAR
> >>>> assignment.
> >>>>
> >>>> This assumes that the device whose BAR is being resized lives on a
> >>>> subordinate bus, but this is not necessarily the case. A device may
> >>>> live on the root bus, in which case dev->bus->self is NULL, and
> >>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
> >>>> will cause it to crash.
> >>>>
> >>>> So let's make the call to pci_reassign_bridge_resources() conditiona=
l
> >>>> on whether dev->bus->self is non-NULL in the first place.
> >>>>
> >>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizin=
g BARs")
> >>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> Sounds like it makes sense, patch is
> >>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
> >> Thanks Christian.
> >>
> >>> May I ask where you found that condition?
> >>>
> >> In this particular case, it was on an ARM board with funky PCIe IP
> >> that does not expose a root port in its bus hierarchy.
> >>
> >> But in the general case, PCIe endpoints can be integrated into the
> >> root complex, in which case they appear on the root bus, and there is
> >> no reason such endpoints shouldn't be allowed to have resizable BARs.
> > Actually, looking at this more carefully, I think
> > pci_reassign_bridge_resources() needs to do /something/ to ensure that
> > the resources are reshuffled if needed when the resized BAR overlaps
> > with another one.
>
> The resized BAR never overlaps with an existing one since to resize a
> BAR it needs to be deallocated and disabled. This is done as a
> precaution to avoid potential incorrect routing and decode of memory acce=
ss.
>
> The call to pci_reassign_bridge_resources() is only there to change the
> resources of the upstream bridge to the device which is resized and not
> to adjust the resources of the device itself.
>

So does that mean that BAR resizing is only possible if no other BARs,
either on the same device or on other ones, need to be moved?
