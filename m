Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B465A17DE9C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 12:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgCILWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 07:22:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43859 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCILWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 07:22:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id dc19so11543317edb.10
        for <linux-pci@vger.kernel.org>; Mon, 09 Mar 2020 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KKMX+K/eaB1iOliaxFqIqVqPuqJ9HDdrxFBTWxgQDR4=;
        b=OgWY0myzx0GHO6MvrIyzHR2WS2MjNhx/Rxx3ZxgrOCbSBR5gUDvLnVHEOFQM9uzT/5
         E8yCuR1QCUWSc+tUrs4E1mcYp500HPAUcThRJPpxBGLuPvLlQMOm06m4ahdNT34rinoB
         YAZixOWyUaRB1QTx61Npbtta53zj25Dq7+2sLPyvPTbNIPzLpp7fGIjEf4c2c36lxmPn
         S1gze6IfM8bmMjaCrTjbnlc3O9AeZs8gakYHcnILhAhZWY/MFTgTUKRNj/qZ5nlb9wWw
         vTigpUXjtAI/zG8vBh6M1KhhAXoceqo3HKwj2jA9lPOS8XJlW7uY9Uk6fBJqiavFwpuL
         Az7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KKMX+K/eaB1iOliaxFqIqVqPuqJ9HDdrxFBTWxgQDR4=;
        b=MaVWpS1GUYVz5e2jzNiYcGZyZNMOGkcENDewJioflx84U3xiWhsKDj1mkYSDORBIWY
         VWkEsje6MZW9qs6byF+BnVvhJVld5m7yrlR9aVtvNpt9TPfU9Bud0ddgvIsjb5jm7SwH
         sN9HA8QenF/HmzgHXTYoHK3FTPqWUFXkQqibdB5C1jdbSRNOvmYY+IpoY6c+YrI6CF8j
         eEGnLO0L5GEt8Tftj7oRfTx+1SFx4iCBiadHfWX61VuGFnoWSYHuCI4fcHQ7ha8JelW9
         rT351e4Cert4o9o0tZjCFosPSJ26mE2ycDiwzatvm/25EoFsD6Zy/xFujfUIFiVMC70r
         z41Q==
X-Gm-Message-State: ANhLgQ0KblV9jgv4Yg9bIyqu1Nd7l6+OhCvy9bBmMqr7DnWeUIJAic2r
        gMuIux8V2Lb/2PS5yHanGoo/TXzLa/+UFaHAXOM=
X-Google-Smtp-Source: ADFU+vuDf4UPdnZYxVpcPRuP8EU3bI7ovmJnNc/zKLR1qOyavrTtNZRh5uBbZ0EwF4kqqln9A+DHBvDPIaIL9TNURCk=
X-Received: by 2002:a17:906:1c07:: with SMTP id k7mr3420172ejg.378.1583752921822;
 Mon, 09 Mar 2020 04:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1oukcnjgkY8Y6rkHcBAKwSvTDJsJVCf7nix4eoPPFsNqg@mail.gmail.com>
 <20200307213853.GA208095@google.com> <PSXP216MB04382D268822AD1C3D9A57C780E10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB04382D268822AD1C3D9A57C780E10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Mon, 9 Mar 2020 11:21:50 +0000
Message-ID: <CAEzXK1o27oUXFYydcvRb2oOV4Q7AF2zef=AsnH9ks5eQ30Qk8w@mail.gmail.com>
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

Hi Nicholas,

Thanks for your help.
Replies follow below.

Kind Regards,
Lu=C3=ADs

On Sun, Mar 8, 2020 at 5:51 AM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> Hi,
> > > On Sat, Mar 7, 2020 at 12:11 PM Lu=C3=ADs Mendes <luis.p.mendes@gmail=
.com> wrote:
> > > > This issue seems to happen only with the Coral Edge TPU device, but=
 it
> > > > happens independently of whether the gasket/apex driver module is
> > > > loaded or not. The BAR 0 of the Coral device is not assigned either
> > > > way.
> > > >
> > > > Lu=C3=ADs
>
> So the problem only occurs with the Coral Edge TPU device, so there is a
> possibility that it is not a problem with the platform, or something
> caused by the combination of the TPU and platform. Is it possible to put
> the TPU into an X86 system with the same kernel version(s) to add more
> evidence to this theory? If it works on X86 then we can focus on the
> differences between X86 and ARM.

I've tested two Coral TPUs on two x86_64 platforms and the BARs seem
to be assigned, however the driver fails to load, during probe and the
system is unable to shutdown cleanly, but I think that is a driver
issue when setting up sysfs entries. I can blacklist gasket/apex, if
it helps in some way, or try an older kernel.
Dmesg log for one of the x86_64 system is here:
https://pastebin.ubuntu.com/p/FHhHNN6XTF/
lspci -vvv for the same x86_64 system is here:
https://pastebin.ubuntu.com/p/xbSNWFQ9TS/

>
> Also, please revert c13704f5685d "PCI: Avoid double hpmemsize MMIO
> window assignment" or try with Linux v5.4 which does not have this
> commit, just to rule out the possibility of it causing issues. This
> patch helps me and also solved the problem of one other person using an
> ARM computer who came to us regarding a problem. However, it could also
> adversely affect unknown use cases - it is impossible to completely rule
> out, due to the nature of how drivers/pci/setup-bus.c is written.

On armhf with 5.4.14 the problem remains, BAR 0 and BAR 2 are not
assigned: https://pastebin.ubuntu.com/p/9H2qqqMNJN/
I've also tried kernel 4.20.11 and the problem also exists.
I've got JTAG on this system with OpenOCD. I believe I can debug the
kernel, if needed.

>
> Kind regards,
> Nicholas
