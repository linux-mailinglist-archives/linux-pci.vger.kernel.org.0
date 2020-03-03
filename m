Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9817F1786C1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 00:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCCX53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 18:57:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34635 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgCCX53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 18:57:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id w27so4340593lfc.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2020 15:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIWGur3bsHzpzpsDDYwv29XnZSnnJNIFZvGbNS4jrEo=;
        b=kDnUpYpdn4DAr4q2+USJm5D+Fm0EG/v+rd4s9F6wFuVXBRLXddHQ+/f0t4DFkkQ+3Q
         eBcaSIqkYIuy53rq98q1mHS3xL2RtzGAIQO2CLrUnJdK4EJtDXeVl6PdXaACwg1yxD83
         KLoXEudsQ8rXYTgIgtth79gb8JOYaXvThTtjUTvrkO2UnUDAZKVhOyQ0sM0Dh8y0cy7T
         x7c6ZJRQeiva4BdwyggRsrozYSAaI1lq79XSN90vSRowrZlPAbE1G13Qdg4Ro+8djiBX
         ZGGI3UFY12ilEHoXGE8jE5rpfmGBT8LYcI/8AzDqCZMiPlySSJpfsoVgP1G8NnIC+kRj
         tEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIWGur3bsHzpzpsDDYwv29XnZSnnJNIFZvGbNS4jrEo=;
        b=rZqV3ab3KDOE4TMV9K8lgGhUCZxmo2mTBexxyVuGsrS+n07x9mjYQUTzYQ6KfmHRMg
         VxxikvkcJIRPo0ksjbsX+J+k1uX+5cwksfjmPneY8xLP2KEhZCEUO+EUBNOI9nNJajR3
         4Pmw52fay7my6S405kdmsrRxzcb4/ASg/RWKmiT3Vr9fnuYJw5kZHYmZsgIDL9Qb3bvM
         2sfTauc0CdF1TGa2SmLD7PlEtGW3z7LbN2LLBMWtDbnjEWMseIuxyE6xPpiqVcLf1Amu
         z4apZcLeQwIUE1n4eb/99v8pfxTOXB/RsNNxHF9A2gtcB+EYVazFEyTpE61jJByKKYIb
         zw3Q==
X-Gm-Message-State: ANhLgQ3lmXZijdJ5QoM7tJsmJTMVykDD+aLY1fu1pm6+fcdj7Ugw6Nzn
        DqVHRcRej3LHQMTkWSgiuVv7mfF+OfvLsKeopPAmrw==
X-Google-Smtp-Source: ADFU+vuSXV6dJHAw44cUBpwZDzV0Ata45u0U9iunTKOnYcvhn4CAzW/6jGOxJT8MXZjlles3cvD5zW2DxOE8xH8AoFU=
X-Received: by 2002:a19:ca15:: with SMTP id a21mr232523lfg.67.1583279845785;
 Tue, 03 Mar 2020 15:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20200225091130.29467-1-kishon@ti.com> <1582665067-20462-1-git-send-email-alan.mikhak@sifive.com>
 <7e1202a3-037b-d1f3-f2bf-1b8964787ebd@ti.com> <CABEDWGz=4E8mYx0usw4A1UAMHrq+MGyKOX47yO7Cdgmcq=aOag@mail.gmail.com>
In-Reply-To: <CABEDWGz=4E8mYx0usw4A1UAMHrq+MGyKOX47yO7Cdgmcq=aOag@mail.gmail.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 3 Mar 2020 15:57:13 -0800
Message-ID: <CABEDWGwejv-1h=pLt_o5n=Mct+6r9oQdQCLT7GZSMgBR2bDJHg@mail.gmail.com>
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

On Wed, Feb 26, 2020 at 9:39 AM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> On Tue, Feb 25, 2020 at 9:27 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >
> > Hi Alan,
> >
> > On 26/02/20 2:41 am, Alan Mikhak wrote:
> > > @@ -380,6 +572,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> > >         int bar;
> > >
> > >         cancel_delayed_work(&epf_test->cmd_handler);
> > > +       pci_epf_clean_dma_chan(epf_test);
> > >         pci_epc_stop(epc);
> > >         for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > >                 epf_bar = &epf->bar[bar];
> > > @@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> > >                 }
> > >         }
> > >
> > > +       epf_test->dma_supported = true;
> > > +
> > > +       ret = pci_epf_init_dma_chan(epf_test);
> > > +       if (ret)
> > > +               epf_test->dma_supported = false;
> > > +
> > >         if (linkup_notifier) {
> > >                 epf->nb.notifier_call = pci_epf_test_notifier;
> > >                 pci_epc_register_notifier(epc, &epf->nb);
> > >
> > > Hi Kishon,
> > >
> > > Looking forward to building and trying this patch series on
> > > a platform I work on.

Hi Kishon,

I applied this v1 patch series to kernel.org linux 5.6-rc3 and built for
x86_64 Debian and riscv. I verified that when I execute the pcitest
command on the x86_64 host with -d flag, the riscv endpoint performs
the transfer by using an available dma channel.

Regards,
Alan

> > >
> > > Would you please point me to where I can find the patches
> > > which add pci_epf_init_dma_chan() and pci_epf_clean_dma_chan()
> > > to Linux PCI Endpoint Framework?
> >
> > I've added these functions in pci-epf-test itself instead of adding in
> > the core files. I realized adding it in core files may not be helpful if
> > the endpoint function decides to use more number of DMA channels etc.,
>
> Thanks Kishon,
>
> I now realize they are in [PATCH 1/5] of this series. May I suggest renaming
> them to pci_epf_test_init_dma_chan() and pci_epf_test_cleanup_dma_chan()?
> With just pci_epf in their name, I was looking for them in pci-epf-core.c.
>
> Regards,
> Alan
>
> >
> > Thanks
> > Kishon
