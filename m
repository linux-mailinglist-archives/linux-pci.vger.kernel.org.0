Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C118F32
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 19:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEIRfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 13:35:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35339 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 13:35:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so1567624pgs.2;
        Thu, 09 May 2019 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akpYpVhrodXoRvrgP/LEUjRFiW5901KOOal38MfuHM0=;
        b=Jdvuc2rVQLwxFZvIrYAnRa/1ADxCw/q7WAuDG4a9UdMbQhBX5InFlYXw1R6XKHbH2h
         1q0UA50rmHMQLZitsakIStwG9GsrKnx09AO8qvXbs55jXO9RZEpsr+0eaX42+HkwTw9B
         1YNlAoEremna7f3q5O5VMatAF6zG7nNdTK4sy8zSHhkynGavJLgMjc3aid+JDdC30c1B
         XYE4AojCWqyHxjTPsFfQM/B9dXemaLXnU3Ya4N8iZnn03wd4iRph4DOe2Qk/fC33fa4r
         bShaWvOiznvehIIv8X3zz/ZLfWkW0bI+By3Z3C/dzg5BZOap/kp4kTw4g45IKm3MDco+
         VrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akpYpVhrodXoRvrgP/LEUjRFiW5901KOOal38MfuHM0=;
        b=f4wtkLkfS89oxIeLbl2cBO051EBlb4NHAianSe3STxttXZqvDEW0G9GBhMPPnPLuh+
         mLbwWjO+c7V5FtKN/pCyCt3RPWFknye1ax0ZXp/Kyrrsq2yBPORkCJIqOMNW793AC/Ux
         EFEJhwwfyRBRRnyNif4fa0XUAh+Jl7UVIaNTYmVis79TYugew+AnIEBYBNfvij7sEj7z
         JHKKpLl2Q2p3suPkD3VS/jlaaE7JgT1QXl9TdcJNboXLxsql3Wi2Dg6Zi0IMgYQXmJqW
         jZ9FZnb8i0CoI2b1EKqcFBg/SZpOMzA34mfnoktMp382Zrrv8uoCv0S+60UBaD4jWeEg
         2log==
X-Gm-Message-State: APjAAAW0L4xVd6V5fFrwDamGJb4ZwW3zzx9clmA/TTLFqDf8dwdiDh9D
        2r45Z4TOYGbM4bsPXi1co0oEzJT3Ws78qqc6sKvN5JC1
X-Google-Smtp-Source: APXvYqzLPqQaZlDEMurmATwLJDI48U0kwADSZ8Rtkg9QOK/Vf4K2t2SJbV5EsJ4AKk6U8Y4g/nS/jC5UqEzqQUQvaXk=
X-Received: by 2002:aa7:8212:: with SMTP id k18mr7001726pfi.50.1557423311885;
 Thu, 09 May 2019 10:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190509141456.223614-1-helgaas@kernel.org> <20190509141456.223614-3-helgaas@kernel.org>
In-Reply-To: <20190509141456.223614-3-helgaas@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 20:35:00 +0300
Message-ID: <CAHp75Ve9-659N5N=f7pPb-9amvbGbi+zWxL9p-BnYocvXJPwZg@mail.gmail.com>
Subject: Re: [PATCH 02/10] PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 9, 2019 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Replace dev_printk(KERN_DEBUG) with dev_info() or dev_err() to be more
> consistent with other logging.
>
> These could be converted to dev_dbg(), but that depends on
> CONFIG_DYNAMIC_DEBUG and DEBUG, and we want most of these messages to
> *always* be in the dmesg log.
>
> Also, use dev_fmt() to add the service name.  Example output change:
>
>   - pcieport 0000:80:10.0: Signaling PME with IRQ ...
>   + pcieport 0000:80:10.0: PME: Signaling with IRQ ...

> +               pci_info(port, "interrupt generated for non-existent device %02x:%02x.%d\n",

Can we be slightly more consistent here, i.e. start from Capital letter?

> +                        busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));

> +               pci_info(port, "Spurious native interrupt!\n");

> +       pci_info(port, "Signaling with IRQ %d\n", srv->irq);

-- 
With Best Regards,
Andy Shevchenko
