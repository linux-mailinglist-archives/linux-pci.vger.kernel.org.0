Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645E16B543D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCJWZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 17:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCJWZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 17:25:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DBAD1AC0
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 14:25:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g17so8574294lfv.4
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678487141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NCfw/2KP8IPVEfHShweA7sW0Sw8UUtNsK0jcL5a1bU8=;
        b=lKQiDKm+O9syt+UAWQT3Y9JxrSfThGC2wWx4gWdxvt9wdxm6D0PUlE+cIw9gGYBJtd
         izHDmyCe8oMVhGzJkshJ00d34kNeBSXgnECnC1AjwSJsLBZlyUMXzVDT+PyMUHNfxllv
         ucTwscLD8f6Sp2LIAQrH62XEeUXoAZi9j/Jzn4cQb+KZJ9z5icUwLICU1Z6lFcQDjQ+q
         FfCOfXAEMbb5K+zyvnIioPQLiykn8ed2AlMF9BZJdcnq/6O9MEhqTlTLA2/6J4bFwXeL
         jawwh5XO12+lwvp6gqWdiC6pMfGlZEyyAYJIk7UDZSAEoi6Q7csW3RhMVdqwmVGPuVip
         OYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCfw/2KP8IPVEfHShweA7sW0Sw8UUtNsK0jcL5a1bU8=;
        b=k5QiLQvNgaPAzwoIKpgicH9NMzHdGP0Sm1XeGPy9NZeEBj07WaCmrCDG0d+3aAqNaS
         A8jNRJTbEuhG+mbMhzU1F8HfXATAVBQiMCennwBk1R27n1nO04sp8fhghRUcjLVkIVuu
         ZwhuTclWEmxjKJKTHIv7V00jsgP5Bjin/Ql7rC8WHccgH6wtBFS0ADmqkI+mRjELDfDc
         A57sDjF3MjlRBP4xt8YiNggaxcmhV+8HydvTzBpGak4B99f22QwmEYlhUGHStmpF2+yi
         SiuxuAhGVCWz3VKmuNVuSWc3ej8yMCSwcd5HsubTW9i4EziX0CDK21UIQFhn5h8OXhTt
         TMow==
X-Gm-Message-State: AO0yUKW4qEJ7qSdBtLJpsp+fx4CAKEga4Zm0niUgDvsRoGHkMN3loWxO
        xYutrbK5AiWfyqAy/aONFUJ5TdMcsJJCffQAv1Vam2hzP9I=
X-Google-Smtp-Source: AK7set/ukx5sQ36ele45d+870XprIjY6K4JvBCYFDzKS6BIq0+Se4/iefPuwC6eyIxY4WdrmutN8WXZn8QKxE48vpvE=
X-Received: by 2002:ac2:5fa7:0:b0:4db:f4b:a552 with SMTP id
 s7-20020ac25fa7000000b004db0f4ba552mr8495823lfe.13.1678487140963; Fri, 10 Mar
 2023 14:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20230310184102.GA1267642@bhelgaas> <JVFJQDZS.Q55VEGY3.FOVANOEZ@FBOHK6ZC.GEUI7GR4.PNS4DLI2>
In-Reply-To: <JVFJQDZS.Q55VEGY3.FOVANOEZ@FBOHK6ZC.GEUI7GR4.PNS4DLI2>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Fri, 10 Mar 2023 16:25:29 -0600
Message-ID: <CABhMZUXs7OM4FypEVM9BpuznVKsVdew5tu5sB+eLvK9d19oe7w@mail.gmail.com>
Subject: Re: The MSI Driver Guide HOWTO
To:     gael.seibert@gmx.fr
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 3:32=E2=80=AFPM <gael.seibert@gmx.fr> wrote:
> On 10/03/2023 19:41:02, Bjorn Helgaas wrote:
> > On Fri, Mar 10, 2023 at 11:23:14AM +0100, gael.seibert@gmx.fr wrote:
> > > On 09/03/2023 23:55:03, Bjorn Helgaas wrote:
> > > > On Thu, Mar 09, 2023 at 10:57:51AM +0100, rec wrote:
> > > > > On 09/03/2023 00:03:04, Bjorn Helgaas wrote:
> > > > > > On Tue, Mar 07, 2023 at 12:22:44PM +0100, rec wrote:
> > > > > > > Like asked in :
> > https://www.kernel.org/doc/html/latest/PCI/msi-howto.html#disabling-msi=
s-globally
> > > > >
> > > > > > Thanks for the report!  I assume this means your system has
> > problems
> > > > > > with MSIs, and booting with "pci=3Dnomsi" makes it work better?
> > > > >
> > > > > You are welcome,
> > > > > The system doesn't boot completely without the "pci=3Dnomsi"
> > option.
> > > >
> > > > What exactly do you mean by "it doesn't boot completely"?  I
> > compared
> > > > the two dmesg logs, and I see that the "with MSI" log also has the
> > > > "single" parameter, so it will only boot to single-user mode.
> > >
> > > It does it mean than either the boot stop or the system halt,
> > power-off
> > > before it can be possible to connect tty console or display manager.
> >
> > Wow.  I'm not sure what would cause a sudden halt or power-off like
> > that.  Is there any indication on the console when this happens?  Can
> > you try adding the following to your kernel boot parameters to see if
> > you can catch anything via a photo or video (you may have to adjust
> > the boot_delay to make things readable):
> >
> >   nosmp ignore_loglevel lpj=3Dlpj=3D7000000 boot_delay=3D100
>
> It will be possible that is a fan problem with a cpu temperature.
> (Probably)
> I attach a video to the boot.

Thanks for this.  I should have asked at the very beginning whether
there are any older kernels that work correctly without "pci=3Dnomsi".
If there is such an older kernel, we can try to figure out what change
broke it.  Otherwise, I'm running out of ideas.

> > I'm curious about the Ricoh thing because I don't see an obvious MSI
> > connection.  Can you collect the output of "sudo lspci -vv"?  The
> > lspci output in your initial email wasn't collected as root, so it
> > doesn't include information about Capabilities (including MSI).
>
> Output of #lspci --vv attached

Thanks!  I was hoping something from lspci would connect with
ricoh_mmc_fixup_rl5c476(), where we get the "proprietary Ricoh MMC
controller" message, e.g., if that function looked at the MSI
Capability or something.  But 00:0d has four functions and none of
them has an MSI Capability.  And 00:0d.0 has nothing we know about at
the offsets the function uses:

  00:0d.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832
    Capabilities: [dc] Power Management version 2

Bjorn
