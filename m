Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1456A3E6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfGPIcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 04:32:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36699 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfGPIcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 04:32:04 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so38655919iom.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2019 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sKdxU6girRO1TqV8WThQeqzTOlWNp9bBRPW3AAWw3EE=;
        b=0f58P8VQwlkJ/rLmi2ztU74s0mYPu0RPsbPZ83qZuKLqcKxk5YPGbzo3PG9M4E5aym
         sXGG/Yr2A00tpz6yRrNHx96THBD37Mp/sGqFgX6lqyr23gkHOMxm85mizdn5NWpEHpF5
         NuoLsx3x3W6zJB5O12izjCLC7Zg74NSpPZz+RmaftNf36EpTcuvU1ymR6DFM6hh4IoVH
         N7JfpvTzR4AAu7ZDphMIPdrl6WhqP/1TOvslDpSF1NhmV9Vu2OZRs8qCGm3FE4DdQ4bz
         /bbh4RWykT/fFfqdF50k5GcAtXC5fXb1MaaePQX6akllVpM3Y+4LSCAJ1+a2OXRqV9yo
         oQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sKdxU6girRO1TqV8WThQeqzTOlWNp9bBRPW3AAWw3EE=;
        b=cxAGyUG8tjTinSyFuP6VOqn73lfVS4r0W6YTXl5727P3yNn4uHNc0XUN/pbBD+t12r
         SASkqFhzc0RabK+f+6ahD8J7OJt4/nMkzH5FoaCmo9nIXj3HhWm6cuZNnYxUwkSZ9C2q
         toxvtYUcZeBqoxsPlli5XD/B8rVCm/qOdFyxkqUhtbsY2Y3pTqmLV9Kx3GhAQiVAksol
         Ia7M5ntOZn8Izzr/btQlQ9fCvj3ZHqk3+fobOmxzXFYEkZRsGVGrUL03keGeppL83Wp9
         RWKFYluhZ1i8OtdAiq63uPr02l2J6xkLfe7QVB7589DXtZldfs4MZExl8weTwgATJ2HC
         +hOw==
X-Gm-Message-State: APjAAAWMrWzFfCxy6oFNbmbsjSSzsy8Mn3fCijS7e7ocxKpFt8O9rGPy
        VE/6adwX6e7EO4MWftFc/9crMi3zUGKVVM0FYbU=
X-Google-Smtp-Source: APXvYqysvbnNzDFZTOSk9lKhMkpJ49xrRxE2EWpZWMnPCXhWzYs6MW4wC2tnJbZvK6bGRWTX90Jc2AgTPs8k3BJG0IM=
X-Received: by 2002:a5d:860e:: with SMTP id f14mr30170291iol.242.1563265923194;
 Tue, 16 Jul 2019 01:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <1563200122-8323-1-git-send-email-jaz@semihalf.com> <20190715170840.326acd73@windsurf>
In-Reply-To: <20190715170840.326acd73@windsurf>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Tue, 16 Jul 2019 10:31:52 +0200
Message-ID: <CAH76GKNXnBaR+3N14yMNoTbMtXD2fU17ZvrCA+W19q21jt9Osg@mail.gmail.com>
Subject: Re: [PATCH] PCI: aardvark: fix big endian support
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

pon., 15 lip 2019 o 17:08 Thomas Petazzoni
<thomas.petazzoni@bootlin.com> napisa=C5=82(a):
>
>
> > -     bridge->conf.vendor =3D advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & =
0xffff;
> > -     bridge->conf.device =3D advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >>=
 16;
> > +     bridge->conf.vendor =3D
> > +             cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xff=
ff);
> > +     bridge->conf.device =3D
> > +             cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16)=
;
> >       bridge->conf.class_revision =3D
> >               advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
>
> So conf.vendor and conf.device and stored as little-endian in the
> emulated config address space, but conf.class_revision is stored in the
> CPU endianness ?

Thank you it seems it slip over - after my change I dump whole config
space in big and little endian and compere to be sure that there are
no more fields that Iam missing and everything seemed ok - so it is
probably '0' therefore the bug wasn't caught.
In bridge emulation the conversion is done correctly:
bridge->conf.class_revision |=3D cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);

>
> >
> > @@ -489,8 +491,8 @@ static void advk_sw_pci_bridge_init(struct advk_pci=
e *pcie)
> >       bridge->conf.iolimit =3D PCI_IO_RANGE_TYPE_32;
>
> >
> >       /* Support 64 bits memory pref */
> > -     bridge->conf.pref_mem_base =3D PCI_PREF_RANGE_TYPE_64;
> > -     bridge->conf.pref_mem_limit =3D PCI_PREF_RANGE_TYPE_64;
> > +     bridge->conf.pref_mem_base =3D cpu_to_le16(PCI_PREF_RANGE_TYPE_64=
);
> > +     bridge->conf.pref_mem_limit =3D cpu_to_le16(PCI_PREF_RANGE_TYPE_6=
4);
>
> Same here: why are conf.pref_mem_{base,limit} converted to LE, but not
> conf.iolimit ?

Here we are ok, since iobase and iolimit are 1byte wide.

>
>
> Also, the advk_pci_bridge_emul_pcie_conf_read() and
> advk_pci_bridge_emul_pcie_conf_write() return values that are in the
> CPU endianness.
>
> Am I missing something ?

Yes because we are mixing the 4byte accesses in
advk_pci_bridge_emul_pcie_conf_read/write with u16 and u8 accesses
when referring to structure fields directly.
E.g. please see what will happen when in BE e.g. device id and vendor
id are set via conf->vendor and conf->device and then read via
advk_pci_bridge_emul_pcie_conf_read which first read whole 32bit value
and then shift it. The same with other not u32 fields.

Before my changes PCIe didn't work in BE mode at all - I've tested it
on a3700. Nevertheless Russell advice about Sparse validation is
really good - it helps to detect some bugs which slip over - I will
send v2 soon.

Best regards,
Grzegorz
