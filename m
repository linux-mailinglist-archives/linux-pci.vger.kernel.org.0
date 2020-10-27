Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E503B29CBD4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374764AbgJ0WMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 18:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S374763AbgJ0WMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 18:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603836727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRuFbHtaAkJdPTvp6LEp7mXtZfo5ruFW5uTt7pI7cuY=;
        b=LtnA6UTjdjPStLmy4DNZkY+3AXxGpStS94smwBkRXdpja+eoKAM1KUIJmfJmt9nITZwxhC
        UahVIvjeJz22vutJtEga1nhrVoo8ebLfbtC+8pYPxN58Z/+RWhHhkJGa1+oAbeKHmGQnjm
        BuOK+FVpUf5IE4QMWCeUTq7upWjnyL0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-a_ZfZFROP9el93sjYNJsBQ-1; Tue, 27 Oct 2020 18:12:05 -0400
X-MC-Unique: a_ZfZFROP9el93sjYNJsBQ-1
Received: by mail-io1-f72.google.com with SMTP id s10so1966586iot.21
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 15:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zRuFbHtaAkJdPTvp6LEp7mXtZfo5ruFW5uTt7pI7cuY=;
        b=P6hY1Vsi0qLw3U1C6QwT6kjJ3vQcGxpR8zaf8HhVPJbQeiZKPszU2QCM2GU3ovO8kZ
         GXR+AxZBNtjnhdnj7PI8rgSksq7BS/RT4kQ+9osxIXoUvJ2BBn1dGYYtSviPzGP0yiAb
         DAIcBGmDWZWgx5OlKfqI6Nlyzonl4li61eboTHNQTVjRCc3sDOBnHkxnG863+izTonRk
         ROoCvwzicgK9TXwSNJUvFXtgQwgj01so2a68T6jzb0+ZbRKzN/dfDRnif7x57hGyHBz8
         cetM875D3EySEYLM0nLEBpHjcuH4+7+FcRCE7iown1HCfxhGbopbLFRL+5o7BmDsnqUV
         qb8w==
X-Gm-Message-State: AOAM531kU+1PXSznM7JBaOEr/19HPrdNYo7WvkQSboX5Q6JIe7RirjOU
        zOFFQCUMPDKKNikUCLqI/2j5LSR2scIAlnnjHgRCKbeeXal/7DrqEqF/R3C+hUzENhjW/T8gd1p
        lnzmXFMIA5EeIDsJWEKkG
X-Received: by 2002:a92:9911:: with SMTP id p17mr3568415ili.165.1603836725024;
        Tue, 27 Oct 2020 15:12:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlvUTTXC9XO8ce1nBV02/0A4u/BTtOd3xrQaDggtovnoJg4byxd6zmlfrpKkEBHIvzOElcaQ==
X-Received: by 2002:a92:9911:: with SMTP id p17mr3568390ili.165.1603836724725;
        Tue, 27 Oct 2020 15:12:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m66sm1731362ill.69.2020.10.27.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:12:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 422C2181CED; Tue, 27 Oct 2020 23:12:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     vtolkm@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <15545174-46bf-8a35-0612-950a3dbefd0a@gmail.com>
References: <20201027172006.GA186901@bjorn-Precision-5520>
 <c3751931-8126-e823-1ee5-62cbdb6883ed@gmail.com> <87d013wl52.fsf@toke.dk>
 <874kmfwhdb.fsf@toke.dk> <03d03828-fec2-5062-5c0b-ffc1df719911@gmail.com>
 <87y2jruziw.fsf@toke.dk> <15545174-46bf-8a35-0612-950a3dbefd0a@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Oct 2020 23:12:02 +0100
Message-ID: <87v9evuxn1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@googlem=
ail.com> writes:

> On 27/10/2020 22:31, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> To follow up on this, everything seems to work just fine (ath10k init =
at
>>>> boot + regulatory db load) if I simply set:
>>>>
>>>> CONFIG_EXTRA_FIRMWARE=3D"ath10k/QCA988X/hw2.0/board.bin ath10k/QCA988X=
/hw2.0/firmware-5.bin regulatory.db regulatory.db.p7s"
>>>>
>>>> -Toke
>>>>
>>> That works on my node only for the regulatory files but not the ath10
>>> firmware with kconfig:
>>>
>>>   =C2=A0Symbol: EXTRA_FIRMWARE_DIR [=3D/srv/fw]
>>>   =C2=A0Type=C2=A0 : string
>>>   =C2=A0Defined at drivers/base/firmware_loader/Kconfig:63
>>>   =C2=A0=C2=A0 Prompt: Firmware blobs root directory
>>>   =C2=A0=C2=A0 Depends on: FW_LOADER [=3Dy] && EXTRA_FIRMWARE [=3Dregul=
atory.db
>>> regulatory.db.p7s board.bin firmware-5.bin]!=3D
>>>   =C2=A0=C2=A0 Location:
>>>   =C2=A0=C2=A0=C2=A0 -> Device Drivers
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Generic Driver Options
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware loader
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> Firmware lo=
ading facility (FW_LOADER [=3Dy])
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->=
 Build named firmware blobs into the kernel binary
>>> (EXTRA_FIRMWARE [=3Dregulatory.db regulatory.db.p7s board.bin
>>> firmware-5.bin])
>> I think that's because you're missing the path prefix
>> (ath10k/QCA988X/hw2.0/) from board.bin and firmware-5.bin?
>> request_firmware() uses the full path...
>>
>> -Toke
>
> Well, that would be weird/strange having to specify the path prefix for=20
> build-in firmware,considering:
>
>  =C2=A0CONFIG_FW_LOADER:
>
>  =C2=A0This enables the firmware loading facility in the kernel. The kern=
el
>  =C2=A0will first look for built-in firmware, if it has any. Next, it will
>  =C2=A0look for the requested firmware in a series of filesystem paths:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o firmware_class path module parame=
ter or kernel boot param
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware/updates/UTS_RELEASE
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware/updates
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware/UTS_RELEASE
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o /lib/firmware

Why would that be weird? The driver is requesting firmware with a path
prefix, so the firmware location has to match... Doesn't matter if it's
in the filesystem or builtin.

> ----
>
> Nevertheless, I tried with same path prefix as per your kconfig but the=20
> compilation fails, which I am not surprised since the ath10 blobs are=20
> not located at that path

Well you'd need to fix that :)

>  =C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0 drivers/base/firmware_loader/builtin/=
regulatory.db.gen.S
>  =C2=A0 UPD drivers/base/firmware_loader/builtin/regulatory.db.p7s.gen.S
> make[4]: *** No rule to make target=20
> '/srv/fw/ath10k/QCA988X/hw2.0/board.bin', needed by

Based on that error message, you'd need to do something like:

mkdir -p /srv/fw/ath10k/QCA988X/hw2.0
mv /srv/fw/{board.bin,firmware-5.bin} /srv/fw/ath10k/QCA988X/hw2.0

> 'drivers/base/firmware_loader/builtin/ath10k/QCA988X/hw2.0/board.bin.gen.=
o'.=20
> Stop.
> make[4]: *** Waiting for unfinished jobs....
>  =C2=A0 UPD=20
> drivers/base/firmware_loader/builtin/ath10k/QCA988X/hw2.0/board.bin.gen.S
> make[3]: *** [scripts/Makefile.build:500:=20
> drivers/base/firmware_loader/builtin] Error 2
> make[2]: *** [scripts/Makefile.build:500: drivers/base/firmware_loader]=20
> Error 2
> make[1]: *** [scripts/Makefile.build:500: drivers/base] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1799: drivers] Error 2
> make: *** Waiting for unfinished jobs....
>
> I suspect that since you are booting the kernel directly from my build=20
> box over tftp it accesses the ath10 firmware blobs on the build box.

Yes, obviously it's reading the firmware blobs at build time from the
location on the build box, then embedding them in the kernel image,
which is then served over tftp to the Omnia. It's not loading anything
from the build box after that (how would that work?)

-Toke

