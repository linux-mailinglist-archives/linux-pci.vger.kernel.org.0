Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5327385C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 04:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgIVCLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 22:11:14 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40678 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgIVCLO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 22:11:14 -0400
Received: by mail-il1-f194.google.com with SMTP id x18so13365002ila.7
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 19:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkrRJwab9CG0RUeg9YflKhsNvqxO8lJPbICSSd2wELQ=;
        b=r4I4ayTkeNOItZUFao5xC1YvkwR1tt9/2N2pLLkUUqtMvUcxzI7E5ty3K1DOVUR09g
         /CuBy/WEs8duLvYQeA4OAkwksbPI4u21yhjM0rNp3Mc1lzmmyZPUvQOPmmpCywTXgd7S
         KQoH3aRWDAtAXNLE3BWStODxs/1q58tTkkn3+DQLIykFXdWfoofjM8DFUyYVPmpoGk+/
         VW0ip+LaDyA70DRzPSe1NDm9a/ORfdII6o+FRY3NOYCk43l8X0jFV1RPLewzisjZ0znN
         YmLB4aYqFabgN/IjVBnCnOXn0O/ENER/GX7TFZ69MkI++aTDBWDF6u45WUjIiGHnqj6s
         R6FQ==
X-Gm-Message-State: AOAM532X8lXJ7meooTv2UwqsI7Efh1pHdBLYvpyvrAQNXLXR9qxu0y3p
        rweONfOPILhx9rxEF7Y0V1IAEYvQDUPd/wuXpyI=
X-Google-Smtp-Source: ABdhPJz1ZdQhv1prVLHuKy/POghRVDozsVvfZBkNrtd7aayI/3lYDToYWC3ODoBmzc84CNINq3KZtG5MsQQynLFIXp4=
X-Received: by 2002:a92:2806:: with SMTP id l6mr2351805ilf.147.1600740673687;
 Mon, 21 Sep 2020 19:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <1600680138-10949-1-git-send-email-chenhc@lemote.com> <45e7272c-e074-d894-9319-ee29f451f282@kernel.org>
In-Reply-To: <45e7272c-e074-d894-9319-ee29f451f282@kernel.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 22 Sep 2020 10:11:02 +0800
Message-ID: <CAAhV-H6+57ss5p037r04-X7=YZrQnLUsLDB3GrR-_OPXiucUgw@mail.gmail.com>
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

Hi, Sinan,

On Mon, Sep 21, 2020 at 11:50 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 9/21/2020 5:22 AM, Huacai Chen wrote:
> > Use separate remove()/shutdown() callback, and don't disable pci device
> > during shutdown. This can avoid some poweroff/reboot failures.
> >
> > The poweroff/reboot failures can easily reproduce on Loongson platforms.
> > I think this is not a Loongson-specific problem, instead, is a problem
> > related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> > devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> > ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
>
> This sounds like a quirk to me rather than a behavior that should be
> applied to all platforms.
Yes, this is very like a quirk, but it seems there are a lot of
platforms that have problems, and removing the pci_disable_device()
has no side effect.

Huacai
