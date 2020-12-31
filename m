Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86252E7E69
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 07:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLaGQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 01:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLaGQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 01:16:10 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83DC061573
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 22:15:30 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 81so16419359ioc.13
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 22:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oa93LH33mt5WYdFfr1vL4VzB7N3LhKeLmogcVs5DjiU=;
        b=DuUN3vMCElhlFsMBVRV2lQ42v4vkGQiqGz6vlLneuSR18SF3AeLFcWa+TSYpycV5IG
         lJFVw3z5JvMLEneqohff20Hhf+dYaJEsqVpwED/IDmn8URCrwhp0wS0D5DuFwdTOcrmM
         97hSdiGhMbnASNYOl+YpdgJlWBgutbAYUIV+1+PRI8q8Lvoh2fue1BTr8CiuYABEYu0T
         g1v7zgYFiIDmyUqIFTlml+R8eGAelF0RH38dvMw2RZO0NP+8Ip/7j8FFmiT2rtv1/Bl9
         obtaX2rg5rfRHfhKMafFy8yJBDQZKtYg8iphQ7Gz+ChhRNSyTIkCw2qhmMOtY6iNED3j
         4F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oa93LH33mt5WYdFfr1vL4VzB7N3LhKeLmogcVs5DjiU=;
        b=emojALTsOy632fyQxXjXQQ32qj4pU7aGwJSoyhjwlsstiykXwyesX58gvGQwobRUJu
         qFKCXFwIfmr3OE5aXBltey18zMdpp9/oXHsWPc3MLC6Zp7qqiIoODCO12j+Ffjafljoi
         kBLaIJq/Sp7FtGbzgOWpzovIPU1sde8uiIpgKPwU9b9V/+P0fFh3TVk2HL+FQJ3TENUf
         2KXaPvTvk9elFVHYVtzePu9U4pXFpPw9jSSx3bEFSzfhiCGzcvzb/g8qSD7zEtmssI8z
         SogMtqNUe6tvqTZytFIUzlxRzOjlSqbs4h8i6oZLCpzB5JQ+n9I8X8lpmcbsahQiZBFP
         zk9w==
X-Gm-Message-State: AOAM530pc5DSxURYuaAOFLhX4b9Bj7oxq+HyDXwaz0Fc7LzvRR4w9FRS
        McnO5gmXFiu+w6btmHztPYEVXLJuwQzkEktuH0I=
X-Google-Smtp-Source: ABdhPJwu9+3eNo+tJCK8gJOgXKcvRa31HEXLZ0zzBOP9fShOEB9ZHEjGcS4zUeyHvSZfRBuqODfpZR9lA8EefVJFgbg=
X-Received: by 2002:a5e:9612:: with SMTP id a18mr45437359ioq.13.1609395329523;
 Wed, 30 Dec 2020 22:15:29 -0800 (PST)
MIME-Version: 1.0
References: <1600680138-10949-1-git-send-email-chenhc@lemote.com>
 <45e7272c-e074-d894-9319-ee29f451f282@kernel.org> <CAAhV-H6+57ss5p037r04-X7=YZrQnLUsLDB3GrR-_OPXiucUgw@mail.gmail.com>
 <CAAhV-H6_BBe1MWJyuVrQNd7NyOarUtz1_YKrQJYxXs3Jby-bsw@mail.gmail.com>
In-Reply-To: <CAAhV-H6_BBe1MWJyuVrQNd7NyOarUtz1_YKrQJYxXs3Jby-bsw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 31 Dec 2020 14:15:17 +0800
Message-ID: <CAAhV-H5SDrOUO-BdptM=e-VwOBrVQ+UtqxVx+qYNU2FO12w+SQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Don't disable pci device during shutdown
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On Tue, Sep 22, 2020 at 2:16 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Hi, Sinan,
>
> On Tue, Sep 22, 2020 at 10:11 AM Huacai Chen <chenhc@lemote.com> wrote:
> >
> > Hi, Sinan,
> >
> > On Mon, Sep 21, 2020 at 11:50 PM Sinan Kaya <okaya@kernel.org> wrote:
> > >
> > > On 9/21/2020 5:22 AM, Huacai Chen wrote:
> > > > Use separate remove()/shutdown() callback, and don't disable pci device
> > > > during shutdown. This can avoid some poweroff/reboot failures.
> > > >
> > > > The poweroff/reboot failures can easily reproduce on Loongson platforms.
> > > > I think this is not a Loongson-specific problem, instead, is a problem
> > > > related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> > > > devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> > > > ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
> > >
> > > This sounds like a quirk to me rather than a behavior that should be
> > > applied to all platforms.
> > Yes, this is very like a quirk, but it seems there are a lot of
> > platforms that have problems, and removing the pci_disable_device()
> > has no side effect.
> I have seen that you talk about kexec (but this email didn't go to my
> inbox). This has been discussed in another thread, and Lucas told us
> that in pci_device_shutdown the Bus Master is disabled for kexec. So I
> think there will be no memory corruption. Moreover, before 4.15 there
> is no .shutdown callback for portdrv, but kexec still works.
>
> Yes, the perfect way is to modify all problematic drivers, as
> radeon/amdgpu does. But I don't have enough knowledge about all of the
> devices.
>
> Huacai
Any new comments?

Huacai
> >
> > Huacai
