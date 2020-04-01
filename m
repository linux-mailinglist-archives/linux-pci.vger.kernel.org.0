Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4120619B77F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 23:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgDAVU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 17:20:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39380 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 17:20:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so1634916edf.6
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wnw5fFLbqWzlpaQZHImF3FnVGu737bktCzqconzta6w=;
        b=c53sjDwvpErU/GgLRheBHjRrw51/g3qlJCIAs5fs8ibF6hPR7Fn0MJR1ANKaBiqjGc
         WJrlFNiHf1idSVeF+n229YEzjbsfhim2RjXrcAq7mQcFeu9/0eUCJHMs2GAbyhugdI1a
         o2BWSVM/1jWl0+QqfU7oxAr4EhpN2UWMMgTQUYfLNuN2//a8RRrXx8ljzV/W9DcUJQsh
         b65xSfSJU4+DQrUYcBu4YF9PTpSfgEwyYpTKPRnWM7iocscZ+I6H+LGY23Ld1KC+bzC0
         TZc+sXh2JO8jbVJ8orbAeFuAHa7sim1ojrFoRU7zTgxk/1FhgcTTgBf2nnKYKzEqm24d
         58Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wnw5fFLbqWzlpaQZHImF3FnVGu737bktCzqconzta6w=;
        b=iromy8yN4HYoYlskPJInx1siDU81D3pA1bOmguTf/FIgO4t0tNKAoJfUh4gyfaJcVI
         WHHDMljzLyrr19au8FB1FFgFRaFsFJ3sMGkn5HFc6DsuSDLvd+bB1rumeSmyPmjPBmTT
         KdMoDyxd0f7ihs5gOG7aL8v0v3pHM5kSshwL8aitW6MEXSM8/zA3JyHb/FSgSQO5Hy87
         O5AkHSxM1hDSo5B2T6xs8xGmVHZK9bZDV8rPkFJk+etk5hQU4bpEw4ty/h1sReuxuglE
         Y0/nmK/+gKypfRiaUYxmLguYDb5f7fRtPJ9Qo1kgWIWQ3UpU1o2Tlop3KGEQEo+xmNeC
         7r+A==
X-Gm-Message-State: ANhLgQ2aH6nCXD15huX65r2/sLVDMnE5SOJdIB+FF7E7JKyW2H+EgED2
        PpszPsDEr4UeGhK0KSBs5kZJmHiVoB6Kb8e4FeE=
X-Google-Smtp-Source: ADFU+vu/MeSdRXnS1a8YuEO7O1wLYOG9kjWEEAu18sz5pHcfLnxD4Uhhpda3UXdu+p/zxU5bH+Xx1O3BXGYAI5THqac=
X-Received: by 2002:a50:9f85:: with SMTP id c5mr22207299edf.55.1585776053854;
 Wed, 01 Apr 2020 14:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1q1ufa1GoL_ZXdqothu_Dub4SAV1KZ_JFcpuF-p0f2Z4w@mail.gmail.com>
 <20200401181632.GA96762@google.com>
In-Reply-To: <20200401181632.GA96762@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 1 Apr 2020 22:20:42 +0100
Message-ID: <CAEzXK1pZufvY9VcXnjrrDMmiMoURtTaL1+8jGWL7k+yyGhKyDw@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
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

Hi Bjorn,

Here is the dmesg output with the new kernel patch:
https://paste.ubuntu.com/p/7cv7ZcyrnG/

Lu=C3=ADs

On Wed, Apr 1, 2020 at 7:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Mar 31, 2020 at 10:28:51PM +0100, Lu=C3=ADs Mendes wrote:
> > I've removed all other PCIe devices to make the analysis easier.
> > The dmesg with the traces can be found at:
> > https://paste.ubuntu.com/p/W3m2VQCYqg/
> >
> > Didn't find anything new related to BAR0 or BAR2, in the dmesg,
> > though. Anyway I'm no expert in this, maybe it can give you some
> > useful information, still.
>
> It looks like we assigned the right amount of space to the bridge, but
> for some reason didn't assign it to the device *below* the bridge.
>
> I added a few more messages in this patch.  Can you remove the first
> one and replace it with this?  This is still based on v5.6-rc1.
>
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 8e40b3e6da77..2cdb705752de 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
...
