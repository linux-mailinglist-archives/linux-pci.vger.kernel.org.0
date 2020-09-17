Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7133A26E229
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIQRT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgIQRTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 13:19:39 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A89C061756;
        Thu, 17 Sep 2020 10:19:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so3091216ioa.2;
        Thu, 17 Sep 2020 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTx4SmzLTM9R4VIN+7JIqONJ9j1anOACjhRKh3TuGxY=;
        b=NlrhQuY65CItYgVlKVrPYv/5crqW3ibCPMk9LN9mZtLDYC2iLLp/ETU5vCCGuErIjE
         h4qWU0VLhRjQkqk1xSCZH2asba2SaNDkmFD4XttCbTy6eWVNuyRnmCIb9xscUb36id8v
         MLsqGzk+7tnaveXKoLtKxPCaOPKBB53kpbYCcoiRfkIjtO8hahzl/SJZy9H3sWlBVYdY
         CSxqbEFjDnEELiGL1KiqaHvZ/NyLS7Z0puxlVCqeXYDtKuZTgDs04ofRzeaH3lTvP0vC
         bxY6mEr7nACVyzICjHlTGa7VTtd3PDKHJi/nhLM6M1lrkMWwHm5GSJFmugzlPnbqqwdM
         iRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTx4SmzLTM9R4VIN+7JIqONJ9j1anOACjhRKh3TuGxY=;
        b=ZPWB9nBEFHevL7fk2xu+THmlyq0/BcArg6AiHJCRF0AlHObGIp+vwCeu3Qd98gBjC2
         Qwl0677jyB3KXVLu16c41QcJ/bF3fqJflHJvXFKwcZxBTu8p5p2eQvbvp99esfcnODJ6
         +sVxdLBTEWUyyCNd5lWQLM5XkhPDX5j8tB6Zd0bKsU+G/OTwg+qe7WC/+tfqN7n30Rat
         YuQed9fvJd7tTjnN+DnpJCaARIBY/oLOouyrUbsKC9L4SVUHwIq848x/8gVH4U6JijYM
         Nr9caN98mV141+ueq3jLEgwSn4rAT4WvGfB9B2+lURDyAZE+7RDC7azG04CP4KNd0lAD
         HzVg==
X-Gm-Message-State: AOAM533+z1AnboCDgFfv+lReIW9bPjlpmXHfb8X7q8TLVjCmzRW+L/ba
        GEtYKg0UjjIVDmZIEpwKCZzHyDe0ik0Cmw2Fs5UlS5mVbYk=
X-Google-Smtp-Source: ABdhPJxEY+mHc6gjE46QOlMBUYdnQ3inoVgBHX0mg3UwNm23n6R5Yz3een21dvdSmgbc+3nYVeB0wUL4vk5Q2HVMZsY=
X-Received: by 2002:a05:6638:1448:: with SMTP id l8mr27177276jad.83.1600363163802;
 Thu, 17 Sep 2020 10:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200917071042.1909191-1-liushixin2@huawei.com> <20200917165143.GA1707439@bjorn-Precision-5520>
In-Reply-To: <20200917165143.GA1707439@bjorn-Precision-5520>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 17 Sep 2020 10:19:13 -0700
Message-ID: <CAKgT0Uf=TmW0SKWROPcwAOdoaXvLn3t6_ynUtPVoH64bnCRTww@mail.gmail.com>
Subject: Re: [PATCH -next] PCI/IOV: use module_pci_driver to simplify the code
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 9:56 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Alexander]
>
> On Thu, Sep 17, 2020 at 03:10:42PM +0800, Liu Shixin wrote:
> > Use the module_pci_driver() macro to make the code simpler
> > by eliminating module_init and module_exit calls.
> >
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>
> Applied to pci/misc for v5.10, thanks!

The code below seems pretty straight forward.

Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

> > ---
> >  drivers/pci/pci-pf-stub.c | 14 +-------------
> >  1 file changed, 1 insertion(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
> > index a0b2bd6c918a..45855a5e9fca 100644
> > --- a/drivers/pci/pci-pf-stub.c
> > +++ b/drivers/pci/pci-pf-stub.c
> > @@ -37,18 +37,6 @@ static struct pci_driver pf_stub_driver = {
> >       .probe                  = pci_pf_stub_probe,
> >       .sriov_configure        = pci_sriov_configure_simple,
> >  };
> > -
> > -static int __init pci_pf_stub_init(void)
> > -{
> > -     return pci_register_driver(&pf_stub_driver);
> > -}
> > -
> > -static void __exit pci_pf_stub_exit(void)
> > -{
> > -     pci_unregister_driver(&pf_stub_driver);
> > -}
> > -
> > -module_init(pci_pf_stub_init);
> > -module_exit(pci_pf_stub_exit);
> > +module_pci_driver(pf_stub_driver);
> >
> >  MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
