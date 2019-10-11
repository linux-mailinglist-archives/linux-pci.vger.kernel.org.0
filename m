Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE92D3BDE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 11:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJKJFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 05:05:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44401 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfJKJFM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 05:05:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so4160008pll.11;
        Fri, 11 Oct 2019 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPcuPeIlGeOi9YaKxS0E+IUcP4UClOCoB6akqo9MA54=;
        b=sgaN4KE7J6nZ1zyZAXZdmNnMCJvCdAf1A9dZTN75N71vjZozqgVkF6SRCgwAlsp4QD
         8XWapee9vlLUR7jMvU+ZgVJTqhlijr7ODzf03Fl0COjniRsj/oazOw10D4SSea4KpXB3
         R9e6V8EG+vKLDiRYT/2AXS5bHbocBAhnGzWP4bdjedIRZG14P7KEvGWDPy07kRKJrBzZ
         uM4OdbNzf5RlH2/C03woRXD7hg8MPZGXLj5BGUJb3gnSW9UmHYRwpkNYpWx/QsvJLk4o
         hiC3F6G7R4Q8nfi3Ry5tgWmBqGZhD8Hg02FaRW90wkFOvFGpNgibktw8SCSWcyjWlGO6
         5Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPcuPeIlGeOi9YaKxS0E+IUcP4UClOCoB6akqo9MA54=;
        b=Pz5BeG1B3CSZv6ZQiJJDrUegDeo9p/vyBsZ+7/m7jVB8ByQR8doi6LA5N6qF5hhKs9
         hJ5b0m1UsNIiYOgLILKRf87BeZZIbhfjlKvzRdbgMBrksq+GFMaXiZv545GZ91tdw//+
         JhmlKfIJ2YAHeFnRvhLShheOFTeKSyTPISKEze0zHdIMIKx5b4DbP4OfovezGLYyhDkI
         HSbZb9sv3FRJglr3DvLFNwy+x6R/7aAaKXUK3G4Djob/yUgX9stKMl/hAEsUylE0RwiW
         xdluOQXTCwTuAdZfw2qbD+wUF6hdm8UxYksh2Oj8XVUaTo/p3TC/h4/kmUk0SZLfV4Ap
         7RjA==
X-Gm-Message-State: APjAAAWGVwIkWqK/zV95Z9dAeRxwoPBCBE3lZKBgi/SCMPkbuuD1bE+y
        MRMPA5u6lQgVwIN0GLc1t8tyCMgAvAnzTIoBBAE=
X-Google-Smtp-Source: APXvYqxbzxppCszYm0qJzDIQnxj+XzuVTYxiUW4vwnqwrnlvr31HA/eEjVaDVkHfEVYX3aAUVyrO0WzYtlrASSdeU5Y=
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr13678309plr.262.1570784711945;
 Fri, 11 Oct 2019 02:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
 <20191009200523.8436-3-stuart.w.hayes@gmail.com> <CAHp75Vc1mZ7qxKPGaqDVAQ9d_UjNq9LJDEPWHQHaYCfw7vGrmA@mail.gmail.com>
 <CAHp75VfNjnAxua6ESx1Vp=57O=pVM10P1UK8bGNQUk7FeY=Dmw@mail.gmail.com>
 <CAL5oW02uRk-ZLMaE6Skt7rX6xy=sQNttfSZ2N1JRBXPfjJpZNg@mail.gmail.com>
 <CAHp75VfEpH4Nv0J+wc3vhFWXYgVLcFdOr263dAFRZiz_ZEfZrw@mail.gmail.com> <CAHp75VeuQ0O9SxveRXqOKoRKQQJNwJ_1WX6taNfgWebiP0KdJA@mail.gmail.com>
In-Reply-To: <CAHp75VeuQ0O9SxveRXqOKoRKQQJNwJ_1WX6taNfgWebiP0KdJA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Oct 2019 12:05:01 +0300
Message-ID: <CAHp75VesLq28L3rWfAciyU5kQjXSfuKRtnoKciuj+wZ_ogb0TQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 11, 2019 at 11:48 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 11, 2019 at 9:49 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Oct 10, 2019 at 11:37 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> >
> > > Thank you for the feedback!  An infinite loop is used several other places in
> > > this driver--this keeps the style similar.  I can change it as you suggest,
> > > though, if that would be preferable to consistency.
> >
> > Better to start the change now. I'll look into the file and see how we
> > can improve the rest.
>
> I found only one infinite loop there, the other timeout loop is done
> as do {} while.
> I'll send a patch to refactor the infinite one.

https://lore.kernel.org/linux-pci/20191011090230.81080-1-andriy.shevchenko@linux.intel.com/T/#u

-- 
With Best Regards,
Andy Shevchenko
