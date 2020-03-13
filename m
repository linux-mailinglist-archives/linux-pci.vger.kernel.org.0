Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414E2184C62
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 17:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCMQXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 12:23:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39660 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgCMQXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 12:23:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id f10so11189207ljn.6
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2020 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70ePSJuTd9jPZleegGAqK11IpYl7EbJ3uYsoNnJCr5s=;
        b=ggPAxHO6cDFqEQBiTjZvbp5kAYtvzMhdNcsKVGWE77gE18rxiT7Mjw+Z6/IkBIISXY
         71myi2dzqL6aVwiamHxxi1ooLdzpeXHRzXFVydlfvmalSqA40p3j4MGOi8527Ufba0Az
         AEAktk+xd9tc0Ip6xzSAETiQSjH6q2kaImCr9WPMtVcrNH1Kdm/jYqw4hppKsNSXUSgj
         pcrNcYPC36GT7Ce6otPC2Ztu0/H8Z/a4HfNwHLKm5avjtj7ibMyVOVzYWl6AI/aoA/2k
         tSNR5Y9Eshsrc5zxhsofcVJ6Wkib/72RuhcDaLU2JvYjlbu714rWwoJCZ/Ef6TMDTmud
         h5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70ePSJuTd9jPZleegGAqK11IpYl7EbJ3uYsoNnJCr5s=;
        b=c5X7w++GpzjXRrDZ36kngHMGTGNvcM4NSf+INl9WXC0E6eNC7VQEVMuMp2XUcgqjDa
         7EK6GQtkNOiKVnTO+NzLyFb/qci6O7ICPRfdEixOURNIc0JbycJhZ67lLc/1W9QgSgCw
         YthofpgkKnmgCVgZCKgkZpVUaozvCr9mT51dSDVXopLrwEnT7uDEN8FL/7teJx4OH7Wj
         TgUviXolYwICFKsn3jfjX8C2HUWDJyX6Qdea25gqAtHYHGD53yWh4AfKi+Rcd1yvDHbu
         qh+I6dW5m/uxzWGuXEJpvLAnTX+i7KtiHSr3DCn6MnM8Sb+qGjJ2BiflMlaWmpT8wz/n
         nwRw==
X-Gm-Message-State: ANhLgQ2JcJ9EEU2BAsYsKJ/KOCB0giMeb0Yddn0PhPbWJe14q+ReKJQY
        RLB0NVGPRiHnypVixbqPj0wu/LULMJcuZoma7z7VVw==
X-Google-Smtp-Source: ADFU+vugMdas4PNwyjYpvyOCRB4tbgSgyTdjP8oQ/zrPgH9pf6kHQ17D7DkSCcyPEyLwDHJs3yza1fq62TWYVkoLnmo=
X-Received: by 2002:a2e:9ac5:: with SMTP id p5mr8954510ljj.200.1584116614420;
 Fri, 13 Mar 2020 09:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200303103752.13076-1-kishon@ti.com> <1583342836-10088-1-git-send-email-alan.mikhak@sifive.com>
 <d6f19709-f48c-839a-1323-aaf85e9d56ce@ti.com>
In-Reply-To: <d6f19709-f48c-839a-1323-aaf85e9d56ce@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Fri, 13 Mar 2020 09:23:23 -0700
Message-ID: <CABEDWGx4ZpFWOrMmu5uDsetsgGwS=LvZwDH2R+1ox11BZVXDuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PCI: functions/pci-epf-test: Add DMA data transfer
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     amurray@thegoodpenguin.co.uk, Bjorn Helgaas <bhelgaas@google.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, lorenzo.pieralisi@arm.com,
        tjoseph@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 10:24 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Alan,
>
> On 04/03/20 10:57 pm, Alan Mikhak wrote:
> > Hi Kishon,
> >
> > I applied this v2 patch series to kernel.org linux 5.6-rc3 and
> > built for x86_64 Debian and riscv. I verified that when I execute
> > the pcitest command on the x86_64 host with -d flag, the riscv
> > endpoint performs the transfer by using an available dma channel.
>
> Stephen raised a build error issue [1] after including this series. Did
> you also see a similar issue when you tried in x86_64?

Hi Kishon,

I didn't see this error when I built pcitest with your dma patch for x86_64
on Ubuntu 16.04 (xenial) and Debian 9.9 (stretch). Same for riscv. The
following output is from my Ubuntu machine:

$ cd ~/src/kernel.org/linux
$ cd tools/pci
$ ls
Build  Makefile  pcitest.c  pcitest.sh
$ make
mkdir -p include/linux/ 2>&1 || true
ln -sf /home/sfnuc/src/kernel.org/linux/tools/pci/../../include/uapi/linux/pcitest.h
include/linux/
make -f /home/sfnuc/src/kernel.org/linux/tools/build/Makefile.build
dir=. obj=pcitest
make[1]: Entering directory '/home/sfnuc/src/kernel.org/linux/tools/pci'
  CC       pcitest.o
  LD       pcitest-in.o
make[1]: Leaving directory '/home/sfnuc/src/kernel.org/linux/tools/pci'
  LINK     pcitest
$ ls
Build  include  Makefile  pcitest  pcitest.c  pcitest-in.o  pcitest.o
pcitest.sh

Regards,
Alan

>
> [1] -> https://lkml.org/lkml/2020/3/12/1217
>
> Thanks
> Kishon
>
> >
> > Regards,
> > Alan
> >
> > Tested-by: Alan Mikhak <alan.mikhak@sifive.com>
> >
