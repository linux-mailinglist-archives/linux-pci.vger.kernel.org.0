Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F28C292817
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgJSNVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgJSNVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 09:21:52 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE9C0613CE;
        Mon, 19 Oct 2020 06:21:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u17so12347297oie.3;
        Mon, 19 Oct 2020 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3Lz+f5H2qnCm4YPaUNgSzjSIKDYKn6c8ZxYUYNfS1w=;
        b=JFS4SpmyPt5ZOjC7dlCnr4rKUh/FWhWLlYxEQ7unXai0oPrxai1RJZlmpbxaZtjqn/
         WsGr4jpeEPexCxQElREO/n28ABT1DPKZYLoqDlvKtvyQ/ZKRwW/a14TvIaEjgQzPjrIe
         amwUZzmIfhkqG9mdD5iBJ7dmY3T3wU1+9qXLCRNYcooTOcthVz/YDa5+ltTYvh3bd4U5
         ZZldtf0fyU0QWKczckMPiuuMqQovFlOA2TXVhOl5NEES/bzIIhaTajDMlxUJTGLLdlyT
         wcjnk1LxwGfMwHXbMO1NGsA67qPltFCIRb3RzlJrJ2bIEVtvcOyLYf9nF9TSWeQLF5aS
         hq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3Lz+f5H2qnCm4YPaUNgSzjSIKDYKn6c8ZxYUYNfS1w=;
        b=uiT1C2ZT4Q4uTes/rb9UbLjWKsm+2gPdoT0FTx0vCsKK1K2RFjKKnmrkNcaiTQwlfW
         xeCOxTqOqYOcLNHEhzP9F0el/CP1epdm0/CH4ikTa9z8Ai35IwdJYCZKKneILpNl4sKN
         ipjwwt6snEsNluE+wX4eExDSytt2S1QnPHxwN1OoJXZ6kbDIkJWuXxFuMzu/e+yNq4IA
         qGhAIsSILb21nPy86oU9TrTbBv5DJB5a496sUPIma9vUOXvSAnj/rM07oSDnvL0+9IIw
         4q2op7vXWYucrSDjXA7MFSrsCRwafsGUx2ysRzas3k2wYzIYE/zi7DlLUTkekQrJdyDh
         cVfQ==
X-Gm-Message-State: AOAM531JrcVM7KmNHVcKxHhOFc8aS7qVoTGDA5p84eJOwds0EqC+Q2eF
        68sJMk7oW3YpWgCcFE5dAT4t14cEkyzF5m8xrDM=
X-Google-Smtp-Source: ABdhPJyJ8FZf8rCCzlAoa9tjv/hbnEkXiWU94wZJumCKipG5ZENn745vfPepWrBUB7XWR7xR6+/WY28kSGyZruv7OX4=
X-Received: by 2002:aca:4dd2:: with SMTP id a201mr10963292oib.135.1603113711085;
 Mon, 19 Oct 2020 06:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201016055235.440159-1-allen.lkml@gmail.com> <20201016062027.GB569795@kroah.com>
 <CAOMdWSJDJ-uXpis1WbG3LnOG7bMiif5Q4Maafv_a=55Y_qypfQ@mail.gmail.com> <20201019131613.GA3254417@kroah.com>
In-Reply-To: <20201019131613.GA3254417@kroah.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 19 Oct 2020 18:51:39 +0530
Message-ID: <CAOMdWS+F=cCK=Rgy-0xk4_mqUFMn1PQBWR8u3JwqTP2AVifxsA@mail.gmail.com>
Subject: Re: [RFC] PCI: allow sysfs file owner to read the config space with CAP_SYS_RAWIO
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        ast@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Allen Pais <allen.pais@lkml.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > >
> > > >  Access to pci config space is explictly checked with CAP_SYS_ADMIN
> > > > in order to read configuration space past the frist 64B.
> > > >
> > > >  Since the path is only for reading, could we use CAP_SYS_RAWIO?
> > >
> > > Why?  What needs this reduced capability?
> >
> > Thanks for the review.
> >
> > We need read access to /sys/bus/pci/devices/,  We need write access to config,
> > remove, rescan & enable files under the device directory for each PCIe
> > functions & the downstream PCIe port.
> >
> > We need r/w access to sysfs to unbind and rebind the root complex.
>
> That didn't answer my question at all.

Sorry about that, breaking it down:

When the machine first boots, the VFIO device bindings under /dev/vfio
are not present.

root@localhost:/tmp# ls -l /dev/vfio/
total 0
crw-rw-rw-. 1 root root 10, 196 Jan  5 01:47 vfio

We have an agent which needs to run the following commands (We get
access denied here and need permissions to do this).
echo -n xxxx yyyy > /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id
echo -n xxxx yyyy > /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id

And we want to avoid handing CAP_SYS_ADMIN here. Which is why the
thought about CAP_SYS_RAWIO.
>
> Why can't you have the process that wants to do all of the above, have
> admin rights as well?  Doing all of that is _very_ low-level and can
> cause all sorts of horrible things to happen to your machine, and is not
> really "raw io" in the traditional sense at all, right?


If the above approach is going to cause the system to do horrible things,
then I'll drop the idea.

-- 
       - Allen
