Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68439273A92
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgIVGQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 02:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgIVGQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 02:16:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BCAC061755
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 23:16:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g128so18313367iof.11
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9s9Po6UiKRbZ5uT/8fH/TuJNU/zicMYiMISGAeP/xA=;
        b=Pt9nzUaQ9puQlUPRX93LI00du7c//10Vm3whMQgAOc5heM8UnDvVGqm4nWNHpjOfrI
         6hqjJABa+RcgctwZc1/dGc8MzXXk3ePmwBZOtzoIYyrAve82ykthJYDnhkG2OPPZl6r2
         5wHRr1zvXGaucDv4HVKiRyuGqAv9qTjgVXKjlkDeWbDrDgmDfs/d2PXjd00vNRxqSFb3
         HiFepAXHrqeSh5G7MVbq1LgSlRf0oYcaiuh4bqCObl2CLYw7gFK9LpHXvE6f5xqdRcca
         eolhxc7l+1bbId6mT9hULXDsgB2CJfJCreZw2fSLn6uMzO2EFXUxCV5y7mWOTily3t1d
         XJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9s9Po6UiKRbZ5uT/8fH/TuJNU/zicMYiMISGAeP/xA=;
        b=aPx4YAUA7INPN0tWoTTSPWYMnbPZ96pn1mu7sJTwD5uf4S4TbkrhRXElOohl3VIGo6
         mWndmLTuhALM+oDEKg8fvkl9pncJnwodMxweGbXC9iDOfTQoUORKtxUZMzRIepMGVGBS
         Qwj5Hhi+9t+g9+bd3ELh0FmE6k9dukr85Do5YSWwpT3BXjBOcfS/RU4jVhQMYUEEFQrn
         mAJfHTGkgxxJBIChLaoaiIYTgle62xA0CVgAy73rqTgNm6JEFN1BsrVuniospmgjEKvo
         RCGeULPEBxZV4hP8j6PsehrMFCRxB4maguv7Vtu9sbQ7zZj4tAK4OgyqgH1MZPV6apWr
         zSQQ==
X-Gm-Message-State: AOAM533gwxuE4kNCuQPJO5jmj7IPJmHPueNElxIQFrG1gQzOOo9CzIqW
        HwJBoWeqEnkuxCExYqa00g3rw+a/gviviUeYDgU=
X-Google-Smtp-Source: ABdhPJwpStlmFVd9oyKFexCV3XkCirafLNVcTAd06GdyRBhDhkt+TsJafSirPz4cJEtmKQZ+tJxOvFrEnup4j8yljWM=
X-Received: by 2002:a02:9086:: with SMTP id x6mr3000769jaf.126.1600755403176;
 Mon, 21 Sep 2020 23:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <1600680138-10949-1-git-send-email-chenhc@lemote.com>
 <45e7272c-e074-d894-9319-ee29f451f282@kernel.org> <CAAhV-H6+57ss5p037r04-X7=YZrQnLUsLDB3GrR-_OPXiucUgw@mail.gmail.com>
In-Reply-To: <CAAhV-H6+57ss5p037r04-X7=YZrQnLUsLDB3GrR-_OPXiucUgw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 22 Sep 2020 14:16:31 +0800
Message-ID: <CAAhV-H6_BBe1MWJyuVrQNd7NyOarUtz1_YKrQJYxXs3Jby-bsw@mail.gmail.com>
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

On Tue, Sep 22, 2020 at 10:11 AM Huacai Chen <chenhc@lemote.com> wrote:
>
> Hi, Sinan,
>
> On Mon, Sep 21, 2020 at 11:50 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > On 9/21/2020 5:22 AM, Huacai Chen wrote:
> > > Use separate remove()/shutdown() callback, and don't disable pci device
> > > during shutdown. This can avoid some poweroff/reboot failures.
> > >
> > > The poweroff/reboot failures can easily reproduce on Loongson platforms.
> > > I think this is not a Loongson-specific problem, instead, is a problem
> > > related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> > > devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> > > ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
> >
> > This sounds like a quirk to me rather than a behavior that should be
> > applied to all platforms.
> Yes, this is very like a quirk, but it seems there are a lot of
> platforms that have problems, and removing the pci_disable_device()
> has no side effect.
I have seen that you talk about kexec (but this email didn't go to my
inbox). This has been discussed in another thread, and Lucas told us
that in pci_device_shutdown the Bus Master is disabled for kexec. So I
think there will be no memory corruption. Moreover, before 4.15 there
is no .shutdown callback for portdrv, but kexec still works.

Yes, the perfect way is to modify all problematic drivers, as
radeon/amdgpu does. But I don't have enough knowledge about all of the
devices.

Huacai
>
> Huacai
