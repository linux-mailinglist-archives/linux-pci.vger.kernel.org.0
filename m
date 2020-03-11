Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC4181B0A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 15:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgCKOUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 10:20:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45694 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgCKOUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 10:20:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id h62so3027536edd.12
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9tl1iLU38egfZZhVKhZocJxiDFhBVJ4sdLJ75mYBMTg=;
        b=SD5UJtg9J2lvJOl1Zy/rj4qjbUj21+4W0+L/d8CTr/MZv0+6e5iPxIuW0cLKgrQQ6h
         LOm+aVH5nH9b1QMhojb1j/mLN5ltf0ySN74NZ5coasqw1qlD10srFtvFSNLAAsxre6a/
         52Y6l5cHs0zJoWteD11msQm0LNZ2p5lYbWuCRVM3z8Vit5wCs6NiRIDcdBcnCenKHNNL
         ZlPa1fKIEHb3uCYPdZGc7srSrlV9JAomcTCMJn1FCZZt/Sgx1hqSkXCethHXzMTc0RMX
         lhQUsGNbZj+u7Wyx/fFlDzyrtVLbf9WSavzdoTjxG6K9yf0uH1YepJZnCQbgsMuXLnWx
         P7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9tl1iLU38egfZZhVKhZocJxiDFhBVJ4sdLJ75mYBMTg=;
        b=E0MXcojNHvo9Ng2u71oA9Fg2vOY98hQuKFxeuvkk9fRv+E4YOt+WJR1FEp9vHR6ksk
         w15KY4Lq8kMfXRQimtnP1s77PpJjsuqgdG62h1a0lsb7f/lKm/V4iiJ9PUVUUys2UfnR
         HnEU/jmNOypa8fkGvScp0UXhLOpeH0X+sLX7Z8HtbpOlNMQGiuAnJt3xBOdNudxBJ7Dz
         pir5t1yvgrKXETNJn97cZNPG6OHdxO5VbBYAV39McyPNiUTGk6lqgPEP3PKcFbM7rgk9
         /2vMsXMZtyKmQaU1it42nMMmjSft7PJiURseYj4phFGh8lvkz+ba5UQNaQ5W6XsaM/pU
         Oz5w==
X-Gm-Message-State: ANhLgQ0OU9vvQR2A5N6wgsJ0j/NN1aHAsgpMCmWTh+0RBPqpX/qpG67n
        LSSQiK07vkF4T3jtIhxDHG5qHvQkz9MwEDP8jlYm9w==
X-Google-Smtp-Source: ADFU+vv8g/7qhoeTIHJ81NUyoMBbdJNoqQewHY8yvtwiLsjRorCZhuuvggIj6sKvW5SMLE/8WKjKvRB2ftfGGgIHov8=
X-Received: by 2002:aa7:d9d9:: with SMTP id v25mr2984333eds.291.1583936437845;
 Wed, 11 Mar 2020 07:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1oukcnjgkY8Y6rkHcBAKwSvTDJsJVCf7nix4eoPPFsNqg@mail.gmail.com>
 <20200307213853.GA208095@google.com> <PSXP216MB04382D268822AD1C3D9A57C780E10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CAEzXK1o27oUXFYydcvRb2oOV4Q7AF2zef=AsnH9ks5eQ30Qk8w@mail.gmail.com>
In-Reply-To: <CAEzXK1o27oUXFYydcvRb2oOV4Q7AF2zef=AsnH9ks5eQ30Qk8w@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 11 Mar 2020 14:20:26 +0000
Message-ID: <CAEzXK1oPME9-PiA5uv9+6NjfwsBP8DKnOGtEpk5Sg+RbVW3xrA@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re-sending... after 48 hours the previous message still didn't hit the
mailing list...

On Mon, Mar 9, 2020 at 11:21 AM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> =
wrote:
>
> Hi Nicholas,
>
> Thanks for your help.
> Replies follow below.
>
> Kind Regards,
> Lu=C3=ADs
>
> On Sun, Mar 8, 2020 at 5:51 AM Nicholas Johnson
> <nicholas.johnson-opensource@outlook.com.au> wrote:
> >
> > Hi,
> > > > On Sat, Mar 7, 2020 at 12:11 PM Lu=C3=ADs Mendes <luis.p.mendes@gma=
il.com> wrote:
> > > > > This issue seems to happen only with the Coral Edge TPU device, b=
ut it
> > > > > happens independently of whether the gasket/apex driver module is
> > > > > loaded or not. The BAR 0 of the Coral device is not assigned eith=
er
> > > > > way.
> > > > >
> > > > > Lu=C3=ADs
> >
> > So the problem only occurs with the Coral Edge TPU device, so there is =
a
> > possibility that it is not a problem with the platform, or something
> > caused by the combination of the TPU and platform. Is it possible to pu=
t
> > the TPU into an X86 system with the same kernel version(s) to add more
> > evidence to this theory? If it works on X86 then we can focus on the
> > differences between X86 and ARM.
>
> I've tested two Coral TPUs on two x86_64 platforms and the BARs seem
> to be assigned, however the driver fails to load, during probe and the
> system is unable to shutdown cleanly, but I think that is a driver
> issue when setting up sysfs entries. I can blacklist gasket/apex, if
> it helps in some way, or try an older kernel.
> Dmesg log for one of the x86_64 system is here:
> https://pastebin.ubuntu.com/p/FHhHNN6XTF/
> lspci -vvv for the same x86_64 system is here:
> https://pastebin.ubuntu.com/p/xbSNWFQ9TS/
>
> >
> > Also, please revert c13704f5685d "PCI: Avoid double hpmemsize MMIO
> > window assignment" or try with Linux v5.4 which does not have this
> > commit, just to rule out the possibility of it causing issues. This
> > patch helps me and also solved the problem of one other person using an
> > ARM computer who came to us regarding a problem. However, it could also
> > adversely affect unknown use cases - it is impossible to completely rul=
e
> > out, due to the nature of how drivers/pci/setup-bus.c is written.
>
> On armhf with 5.4.14 the problem remains, BAR 0 and BAR 2 are not
> assigned: https://pastebin.ubuntu.com/p/9H2qqqMNJN/
> I've also tried kernel 4.20.11 and the problem also exists.
> I've got JTAG on this system with OpenOCD. I believe I can debug the
> kernel, if needed.
>
> >
> > Kind regards,
> > Nicholas
