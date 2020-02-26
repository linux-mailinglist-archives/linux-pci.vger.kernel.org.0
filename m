Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC9170647
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 18:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBZRje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 12:39:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42940 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgBZRje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2020 12:39:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id d10so4054577ljl.9
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2020 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJVWNiLO2XYEh/FJRHM/WNaS94bI+2bjZE1Lp7/CNI8=;
        b=dIpH/wDA+5ORYci2RAKWNzFzZt5sm/omU0tq/L8PepurNM9S4YzCfMTtXNupSrv7Vf
         IQOMP7hSQn6ONokXpHYW3RocjvKVT5PyIFE42iTyo7MRFtyalwi62sBMB3uYHgq37BU6
         0uI0CzLwZaCydkkf2fhIjihY3VFbPs3sPPnfUT0R3phOU4KGGU93CNtzkT/3yj89lmES
         rwYv88J/icWZ9owhdYngzLVojP0+K90bJ+wJqOyv/Y0XqjEm5fE3Ufq8pxsXGOzxs37m
         HhXkPDIq1/ZlxFuPieRYRDT7xRng9aV/Km9JRptj6X54C+mR5+6/82XSud2X7kEDCanm
         ZAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJVWNiLO2XYEh/FJRHM/WNaS94bI+2bjZE1Lp7/CNI8=;
        b=bEz1NeA4mjAk3UlxIjpLWqvLHc/e9mXjNDjfIXY8K7TKSr52x+ZwlSrSe1pWLCbZxV
         0IzaWrGxEee35Ijlk4HbBFq5EVCW95KBfvVKTta/OwpjQSkPAYeaPz3Ux5qsWlAULbrs
         MELbmorr3RmEuRmwa6O1CBkgT5ZrURh18M7UdBvUScYmjQCfdfZiyvuTvFqxCt8496fE
         fewVcotUN8JzGY/VZThZ5KA4aIg6UPjyX/4+UCprc1orEIRrIy6tz4ZuMejeM4QMSPTr
         9DRYINtJGWUYsvH4zDtY2U05dwjCKjgSGy1swtU5WNvtk/xQEttMjJphVlo/PbxcaBqH
         7nTg==
X-Gm-Message-State: ANhLgQ3OsgKwYHxokRO4E9PjvxcjPTzqaSgt+WeFCu3nRtrqzr7jepw7
        gW2Vpb69Dh3U0HZ6po+BUdDvHfMDrVRUxfTw0LqaCw==
X-Google-Smtp-Source: ADFU+vuPmfbzX+kp1bQMaa19DZeJLZS2/xebkEMlQ+2Mu+nTBi1ugPq1kbldly3/J1XURnWOQxnczPGaMtkL78UUh5M=
X-Received: by 2002:a2e:9052:: with SMTP id n18mr27628ljg.251.1582738772180;
 Wed, 26 Feb 2020 09:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20200225091130.29467-1-kishon@ti.com> <1582665067-20462-1-git-send-email-alan.mikhak@sifive.com>
 <7e1202a3-037b-d1f3-f2bf-1b8964787ebd@ti.com>
In-Reply-To: <7e1202a3-037b-d1f3-f2bf-1b8964787ebd@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 26 Feb 2020 09:39:20 -0800
Message-ID: <CABEDWGz=4E8mYx0usw4A1UAMHrq+MGyKOX47yO7Cdgmcq=aOag@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: endpoint: functions/pci-epf-test: Add DMA
 support to transfer data
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     amurray@thegoodpenguin.co.uk, arnd@arndb.de,
        Bjorn Helgaas <bhelgaas@google.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, lorenzo.pieralisi@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 9:27 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Alan,
>
> On 26/02/20 2:41 am, Alan Mikhak wrote:
> > @@ -380,6 +572,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> >         int bar;
> >
> >         cancel_delayed_work(&epf_test->cmd_handler);
> > +       pci_epf_clean_dma_chan(epf_test);
> >         pci_epc_stop(epc);
> >         for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> >                 epf_bar = &epf->bar[bar];
> > @@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >                 }
> >         }
> >
> > +       epf_test->dma_supported = true;
> > +
> > +       ret = pci_epf_init_dma_chan(epf_test);
> > +       if (ret)
> > +               epf_test->dma_supported = false;
> > +
> >         if (linkup_notifier) {
> >                 epf->nb.notifier_call = pci_epf_test_notifier;
> >                 pci_epc_register_notifier(epc, &epf->nb);
> >
> > Hi Kishon,
> >
> > Looking forward to building and trying this patch series on
> > a platform I work on.
> >
> > Would you please point me to where I can find the patches
> > which add pci_epf_init_dma_chan() and pci_epf_clean_dma_chan()
> > to Linux PCI Endpoint Framework?
>
> I've added these functions in pci-epf-test itself instead of adding in
> the core files. I realized adding it in core files may not be helpful if
> the endpoint function decides to use more number of DMA channels etc.,

Thanks Kishon,

I now realize they are in [PATCH 1/5] of this series. May I suggest renaming
them to pci_epf_test_init_dma_chan() and pci_epf_test_cleanup_dma_chan()?
With just pci_epf in their name, I was looking for them in pci-epf-core.c.

Regards,
Alan

>
> Thanks
> Kishon
