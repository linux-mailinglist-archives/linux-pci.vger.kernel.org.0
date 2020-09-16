Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2A026BC9A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIPGTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 02:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgIPGTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 02:19:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF74C06174A;
        Tue, 15 Sep 2020 23:19:45 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so7029878ioe.5;
        Tue, 15 Sep 2020 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQU4Vp5hkd72K0GyoRL03/6xjT4XAFXExo8+j37YSQY=;
        b=Emg+QmhTNMGGm2Yi4tpkGItYJUUePIBz2tdkxU8bs5Wt8dZcpWrB30CmPAIAuy4jXL
         LUGCbWYagicgR9MxLlzt4mcbULxHbQrGXV5yJSGmZN7ziABoN7mqxaI8h8vAoGb6zGi8
         sJCQwNE039cWLxHl1cEUGcya5XSNB2eqh1k6Ct6J+Z01iwefgb948qLGwvJw2ut+v2H8
         d6J5PsNNR0Id9Zv3kQxYeMEj07RQM4cJ9ZMCzCexW4ylpGDm895x8xKEKWeeIxpWTfSk
         mnzMZNy/ftKg1mWqVcmbPNhbHAJzRBOeXbklo65GM9UXektQbYuxvsNnp/LOZUvZLTDy
         3bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQU4Vp5hkd72K0GyoRL03/6xjT4XAFXExo8+j37YSQY=;
        b=fXwazVLXYeQmyYqYE3sO9vdSJpJd1jpgW7BA6VCU3zNEEPu7WFzqFDBKJMiQFzCDyd
         JrrhW9ecMuvJjSC5c9sKosnHgq2FOlVvLwPmy6GT7vKIwpaopndU5QFAGjpDLb/k6RgG
         Mr+kf8YRdYnrUhUqIVS7o7aSEjqeYsldT7AwZQywtdVDnp/A98UuSlZAHne57irTJLk0
         B/MnG3TTp+oq/oNHyXxLx3duo5ZL8PjjlhT4pFtLDcQh5chOUf2uLw+LOHD24TaETVvn
         J3Q1/x57VCJQ4KgpeKxd4NtiRSWzKDXicVvIIr/a4XpCziAVYR1SR855s49DWjO0cWmQ
         qYDw==
X-Gm-Message-State: AOAM5321r558Z1mYDr6aGuuh2Nb/GU7XcFPIRQXKHSAYqy/WoIkngRFx
        OvC/xzJ9VNOPzUzSZuGLTn4BSI8hgO16+7E7Phs=
X-Google-Smtp-Source: ABdhPJxJwlKzq65lh/+l/0BV+jVylFOtHxLYQBuCozH4dYszDDV7FPy8Umwb6AE6jiBjLbsBhdhchmt7zod0tdyxYnM=
X-Received: by 2002:a05:6638:250d:: with SMTP id v13mr16460879jat.50.1600237185081;
 Tue, 15 Sep 2020 23:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H7+jMPab9oM_E1J8cfzq0NYCd3w==1WNV3_Hkt0NL7ZCA@mail.gmail.com>
 <20200915203831.GA1426995@bjorn-Precision-5520>
In-Reply-To: <20200915203831.GA1426995@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 16 Sep 2020 02:19:27 -0400
Message-ID: <CAAhV-H7QbhbUjSP-uDb3dwf0Pao-DDhGQrpgPr6NLLjq31NOeg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        zhouyanjie <zhouyanjie@wanyeetech.com>, git <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Tue, Sep 15, 2020 at 4:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 15, 2020 at 09:36:13AM +0800, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > On Mon, Sep 14, 2020 at 7:25 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >
> > > On 09/14/2020 05:46 PM, Huacai Chen wrote:
> > > > Hi, Tiezhu,
> > > >
> > > > On Mon, Sep 14, 2020 at 5:30 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > > >> On 09/14/2020 04:52 PM, Huacai Chen wrote:
> > > >>> Hi, Tiezhu,
> > > >>>
> > > >>> How do you test kexec? kexec -e or systemctl kexec? Or both?
> > > >> kexec -l vmlinux --append="root=/dev/sda2 console=ttyS0,115200"
> > > >> kexec -e
> > > > So you haven't tested "systemctl kexec"?
> > >
> > > Yes, the distro I used is Loongnix which has not kexec service now.
> > > Is there any problem when use systemctl kexec? If you have more details,
> > > please let me know.
> > If you use systemctl kexec, the first part of kexec is the same as a
> > normal reboot/poweroff. So, there is no reason that reboot/poweroff is
> > bad but kexec is good.
> > Then, Bjorn, what is the best solution now? It seems like my first
> > version is OK (commit messages should be improved, of course).
>
> Sorry, there are too many conversations going on for me to keep track
> of what first version you're referring to.  Please include a specific
> lore.kernel.org URL.
My first version means this one:
https://patchwork.kernel.org/patch/11695929/

Thanks,
Huacai
>
> Bjorn
