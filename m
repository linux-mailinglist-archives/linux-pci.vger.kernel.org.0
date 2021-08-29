Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD83FAC74
	for <lists+linux-pci@lfdr.de>; Sun, 29 Aug 2021 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhH2PPd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Aug 2021 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhH2PPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Aug 2021 11:15:31 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE6C061575;
        Sun, 29 Aug 2021 08:14:39 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 37so6325830uau.13;
        Sun, 29 Aug 2021 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CE5DJ6I0bkqbGScS9NHu7P+t4w7mOT4FbVurC5+UIKw=;
        b=K3bPJ2wK1Ok8UQJoPWFjDCOt5KkMvjpWTPPSd9kxvWAMw+Nj4rDoLHfDJ0fbbOkvAe
         4nWdOKLhtdcPZjm+XVRqzhVjbwCgHFH0FfycB1Gsv5uYILSKGJE0shs1IWZnX9HaFC6l
         OWsz/iqcv8ei2cQ5PyNRRBIPlu2plTUnUhSBIkpl+GCChA5MTPJ5WKlK7pO5bNWvE1oA
         2DcsUGoMzwh+tnuO26O5hK34zvoPauqqO+VvOA6kP1gWWR2p1v1uwr7GcnXJjKzNn3DW
         QNxECArl3/9SL9vmAn/KkS3O2NyXCf8vB1Ud3hiKMRxk9mQu0C7HUV8SrtQXFPyZKBc0
         BjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CE5DJ6I0bkqbGScS9NHu7P+t4w7mOT4FbVurC5+UIKw=;
        b=tPnX25dCSzxEfD92vvtvoMaYnAF7owfIznkvzMFsqnEKfSPlHiVen4R6mhjp3BWaf6
         bBuMNduXc4uu7E3II7LaBjhLJpoFZNykZ9WkLZnA4Ou86EUpyAQivyxrcpSrdF33Ysar
         nxtVNP2n3cINppdYgsTRGrTNBDruiRx7ctU4Py4FHtRZQ7udYVl1oEbOhldKqxAxv8o+
         nOI4aYEFLu4Ze3ilvXdQMoF7ZfvVdrZ3mnGQgW1dx42FrvtmzfVMIjY45DrwqQGfsujM
         TJp/2qS9RpWePjB08n/jTSZRjWLyT87E9p178R0Qyz7Gj5zOaeEkmQC2NcoS8bzFooQT
         VXug==
X-Gm-Message-State: AOAM532edVovH8sOm5aSvqUgNJMmGEXuNxhRZ2tz56QyU9P89WBJgFYK
        G3xGudMQVOMXlBYtHDhthJL/t/J6emcb0FfpoZg=
X-Google-Smtp-Source: ABdhPJxNSz5alZOAE48+fiABe+l62fCRif3TJvSSlHYrT6MwKcd1hDeR6n/NQU69bkZyVPpmgdcFW9QTxYeo0z62LWY=
X-Received: by 2002:ab0:26cd:: with SMTP id b13mr12684124uap.98.1630250078925;
 Sun, 29 Aug 2021 08:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
 <20210822161005.22467-4-sergio.paracuellos@gmail.com> <YSip4/kMNOG4uYC3@kroah.com>
In-Reply-To: <YSip4/kMNOG4uYC3@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 29 Aug 2021 17:14:27 +0200
Message-ID: <CAMhs-H_0ytYCoBLj9GJDjHSPPHLC6_oBsm-V9s4FjhE7NY8TCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging: mt7621-pci: set end limit for 'ioport_resource'
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 11:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Aug 22, 2021 at 06:10:05PM +0200, Sergio Paracuellos wrote:
> > We have increase IO_SPACE_LIMIT for ralink platform to get PCI IO resources
> > properly handled using PCI core APIs. To align those changes with driver
> > code we have to set 'ioport_resource' end limit to IO_SPACE_LIMIT to avoid
> > errors.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks. Since I am planning to move 'mt7621-pci' from staging to
'drivers/pci/controller' and send v3 after the next merge window, I
prefer this patch to go through the staging tree. For the other two I
don't have any preference and it is ok for me to go through mips or
pci trees. So, Bjorn and Thomas is up to you if you are ok with the
changes.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos
