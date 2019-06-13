Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E573944C8E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfFMTpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 15:45:06 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39488 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfFMTpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 15:45:06 -0400
Received: by mail-ua1-f67.google.com with SMTP id j8so46282uan.6
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2019 12:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kty5SqcDEL4347wZ8UzAvmzntdto7UwCBDOLGP1a6M=;
        b=YIHEasWQfsz3IQHZgKiQEwWYjZ2Atcpi8qW8K6/DRO9CnXOlKw+HZPoz97iCuda3Fn
         yVU14P0CkGX9/v/G85aK420ItHIGKJ9XtUWaNOnpkV49p3RnmxVGr2IP0yU62GotaAHp
         fnmNFjKuV0AyCVabzE+qU5O7TMIObjmck98HaTkAwYLWYKCeIDnh/VaazWEapgqH71zT
         Y88eqy3gTWKi8rRDIjIQfofh06745RvIeCicjsoVZd43YZl7ucEkZpzDQiZ5tcZE5fWJ
         IaQv1RE0HlSsQlAqPIiz0cgU4dEPCY5EQVNM3MImnphhjqIT+Dkw8i6Y7aymW3Kw+5pM
         jgFA==
X-Gm-Message-State: APjAAAWewDkx25PRwEnzqGjZOlCqvQDjTIBTaBZGw3WxXLRgqO0foOWQ
        0LgpXPe+Jkh1G6prTLgy0BGP3CBzuZruK0eem7A=
X-Google-Smtp-Source: APXvYqxrDAsHxjpm2iNqHN+6K6m4s/cQG8mobsEF9GG2hjuBxnxKHdpDiZsDqpU85xWHJTIwBNsGJCcqS7ZJvStMd/s=
X-Received: by 2002:ab0:644d:: with SMTP id j13mr20789609uap.98.1560455105673;
 Thu, 13 Jun 2019 12:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190613063514.15317-1-drake@endlessm.com> <CAKb7UvjAGtQrcgO=GE8JHuy=mgCtOr+eTinBVwekXGHiam1t1A@mail.gmail.com>
In-Reply-To: <CAKb7UvjAGtQrcgO=GE8JHuy=mgCtOr+eTinBVwekXGHiam1t1A@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 13 Jun 2019 15:44:54 -0400
Message-ID: <CAKb7UvhWzHaRzG3WK3-fu=cWZNbsn9Q1EQ4hvV7JhEoT7LpP5w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Expose hidden NVIDIA HDA controllers
To:     Daniel Drake <drake@endlessm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>, linux@endlessm.com,
        nouveau <nouveau@lists.freedesktop.org>,
        Lukas Wunner <lukas@wunner.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 9:15 AM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Thu, Jun 13, 2019 at 2:35 AM Daniel Drake <drake@endlessm.com> wrote:
> >
> > From: Lukas Wunner <lukas@wunner.de>
> >
> > The integrated HDA controller on Nvidia GPUs can be hidden with a bit in
> > the GPU's config space. Information about this scheme was provided by
> > NVIDIA on their forums.
> >
> > Many laptops now ship with this device hidden, meaning that Linux users
> > of affected platforms (where the HDMI connector comes off the NVIDIA GPU)
> > cannot use HDMI audio functionality.
> >
> > Avoid this issue by exposing the HDMI audio device on device enumeration
> > and resume.
> >
> > The GPU and HDA controller are two functions of the same PCI device
> > (VGA class device on function 0 and audio device on function 1).
> > The multifunction flag in the GPU's Header Type register is cleared when
> > the HDA controller is hidden and set if it's exposed, so reread the flag
> > after exposing the HDA.
> >
> > According to Ilia Mirkin, the HDA controller is only present from MCP89
> > onward, so do not touch config space on older GPUs.
>
> Actually GF100 also has it, and has a lower PCI ID than MCP89. But I
> don't think it really matters - I can't imagine anyone played HDA
> hiding tricks on that power-hungry monster. I'd appreciate it if you
> could reword this sentence to imply that it's on PCI IDs >= MCP89's
> rather than GPUs newer than MCP89. GT215 was released before MCP89,
> I'm fairly sure, but its PCI ID comes later, for example. [Wikipedia
> says November 17, 2009 for GT215 vs some point in 2010 for MCP89.]
> Maybe like
>
> "..., the HDA controller is only present on GPUs with PCI IDs values
> from MCP89's and onward, so ..."
>
> >
> > This quirk is limited to NVIDIA PCI devices with the VGA Controller
> > device class. This is expected to correspond to product configurations
> > where the NVIDIA GPU has connectors attached. Other products where the
> > device class is 3D Controller are expected to correspond to configurations
> > where the NVIDIA GPU is dedicated (dGPU) and has no connectors.
> >
> > It's sensible to avoid exposing the HDA controller on dGPU setups,
> > especially because we've seen cases where the PCI BARs are not set
> > up correctly by the platform in this case, causing Linux to log
> > errors if the device is visible. This assumption of device class
> > accurately corresponding to product configuration is true for 6 of 6
> > laptops recently checked at the Endless lab, and there are also signs of
> > agreement checking the data from 74 previously tested products, however
> > Ilia Mirkin comments that he's seen cases where it is not true. Anyway, it
> > looks like this quirk should fix audio support for the majority of
> > affected users.
>
> Yeah, this is fine. We used to have code which prevented enabling the
> display portion when 3d class != VGA. We had to change it :) So I'm
> definitely not making things up... However whether any of those people
> *also* had HDA hiding issues -- unknown. And it wouldn't make things
> any worse for them.

FTR, this is where it was enabled:

commit fc1620883af8cbc10bfb1a4ef2eb4e8113243012
Author: Ben Skeggs <bskeggs@redhat.com>
Date:   Tue Sep 10 13:20:34 2013 +1000

    drm/nouveau/kms: enable for non-vga pci classes

    Signed-off-by: Ben Skeggs <bskeggs@redhat.com>

Unfortunately no bug id included.
