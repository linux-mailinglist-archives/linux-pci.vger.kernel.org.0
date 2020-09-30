Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7E27DE6B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 04:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgI3CVD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 22:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgI3CVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 22:21:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C390EC061755;
        Tue, 29 Sep 2020 19:21:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so530769ejb.4;
        Tue, 29 Sep 2020 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VviVj9bYE7aXVNpstffQ7ePdMsng1BehF9I+7/XekM8=;
        b=LQjmSSLzZ9xYDHO61ieHODLq/x3LIKoty3Zho6MH+qyAsGtCXqf1zsbpyYdcNjOnlg
         jDJwEezl9CWPcn4aXXwJdR/S7lVyj6Zr1RP2+KOGNdvW/KXEfM4B3+uO+RCXRzCOLJee
         9s3hQcE7/Pk6DbfwhWhgtgKP8il+cYIcTFaZcFgp7xSw3L2N0ToUtFPX+ybtQO00RDdN
         vcs4N11g2A+uEZvNOzyoI3cO7v+bMoKAKRJp8ejjarx45ev2xpZNzi8c/Kp5tobzJSdV
         9gqfjyjoOKuBG0tNH03aWWXGNnrL8z3eehgI/+dZFwUgdPJliWMrjAe1Qb5BqM7ZrIIV
         qr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VviVj9bYE7aXVNpstffQ7ePdMsng1BehF9I+7/XekM8=;
        b=awLFjnx4XtxBt/HtNZ/zqubD855sZ+T177tlzFYCfQs63OgxlY/3QsYpYtTyT6U74L
         15vQ633oc1QkueuSSkeqMaN9Fd1gvX6kQsZp8gQSHJIMJb6LDJpv93zBV3Gf1HVTBdqh
         KtVKgaucR3Lpaxv5v01Cp5OaTIuTtwLIvRu2ey5M6GL7tMbufge/5SKXKQL9GxaqVTqf
         4sujg9jVqtoX/Ly9y+GmtLoLrLBN0GEb8chfkXdGEZ/Vug9xG3t8ga9kWgT0ywMC6Nns
         UA8uYE2Q2aw29xG56TPJ6Cx/mmjnY+0oPe+EFQ27u9NXOubBTj3oznAzFZUurjLTfWCb
         9n7A==
X-Gm-Message-State: AOAM532f74t3v4BL5pxgyCxbo9n/3vPm3RokHkxD1jiHNGTFtshzuhKj
        T8TyFsKz1gCPle7LDMgPQ+cjdHk3UXTB0SrgZs0=
X-Google-Smtp-Source: ABdhPJxrFIv5ybeLKeFyWBmAzsMd72cDCVT2+TMBsOuyb25Ml82cB6Y4bzJUTA6bJniQcZMA+Z29ogsfeRXUEg0cOuA=
X-Received: by 2002:a17:906:6409:: with SMTP id d9mr580121ejm.344.1601432461534;
 Tue, 29 Sep 2020 19:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com> <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
 <20200929081800.GA15858@wunner.de> <CAKF3qh3UxkVOwCOUB4rNdxLX0k9oZQRzXT_N0BNYKWL_BAHa5w@mail.gmail.com>
 <20200929100759.GA21885@wunner.de>
In-Reply-To: <20200929100759.GA21885@wunner.de>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 30 Sep 2020 10:20:50 +0800
Message-ID: <CAKF3qh2xVfj0KNGj8MFC_Z+gOqNw7JD1uDbVy=OgLnkZ0t-0+Q@mail.gmail.com>
Subject: Re: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sinan Kaya <okaya@kernel.org>, Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 6:08 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Sep 29, 2020 at 05:46:41PM +0800, Ethan Zhao wrote:
> > On Tue, Sep 29, 2020 at 4:29 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Sun, Sep 27, 2020 at 11:27:46AM -0400, Sinan Kaya wrote:
> > > > On 9/26/2020 11:28 PM, Ethan Zhao wrote:
> > > > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > > > > @@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> > > > >     down_read(&ctrl->reset_lock);
> > > > >     if (events & DISABLE_SLOT)
> > > > >             pciehp_handle_disable_request(ctrl);
> > > > > -   else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
> > > > > +   else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
> > > > > +           pci_wait_port_outdpc(pdev);
> > > > >             pciehp_handle_presence_or_link_change(ctrl, events);
> > > > > +   }
> > > > >     up_read(&ctrl->reset_lock);
> > > >
> > > > This looks like a hack TBH.
> [...]
> > > > Why is device lock not protecting this situation?
> > > > Is there a lock missing in hotplug driver?
> > >
> > > According to Ethan's commit message, there are two issues here:
> > > One, that pciehp may remove a device even though DPC recovered the error,
> > > and two, that a null pointer deref occurs.
> > >
> > > The latter is most certainly not a locking issue but failure of DPC
> > > to hold a reference on the pci_dev.
> >
> > This is what patch 3/5 proposed to fix.
>
> Please reorder the series to fix the null pointer deref first,
> i.e. move patch 3 before patch 2.  If the null pointer deref is
> fixed by patch 3, do not mention it in patch 2.

Make sense.

Thanks,
Ethan
>
> Thanks,
>
> Lukas
