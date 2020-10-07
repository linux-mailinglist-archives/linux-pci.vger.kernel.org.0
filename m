Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8171C28599A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 09:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgJGHeA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 03:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgJGHeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 03:34:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAA8C061755;
        Wed,  7 Oct 2020 00:33:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b12so1076437edz.11;
        Wed, 07 Oct 2020 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOwACkyD8dEtsrUHuldNDeZjoZsGRiveXSWhLCbbCV4=;
        b=dP79MDkd6MgzJF1q/AtCcrvFV98Hp4azX/2FgqgeE/hidSKPgCcpGlOhJEaEhnha2k
         05+kNxOCYZF23LhCyFDA9AHv/298dvpowB6rL99MGqyNUmTE1H1BVn1Wo0kqevfFF+ly
         tBn/E+C4Cgwm1mIafrXTQ+ifw9JrFeXmSq4ksHqfJKklfCDr8QKv/zhMlSk6EsBjP6bR
         1urCqTU24IHjbPdh9PkGo0aW+F6hmr4U/WOgdfgGyLqCzEXm2N1P0B4v8E0/7J4Tqa5k
         00zlHz7pnxKYsPo091W3LXVP+s+d9zzy2QjtCFZovjtU5CZuur1JwgECetHc0P3sNbtp
         SmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOwACkyD8dEtsrUHuldNDeZjoZsGRiveXSWhLCbbCV4=;
        b=iu2b7SAmhL1J88Xvb/rmtIOU3lHxU+dnCC+JSKQ5ooaTaUxEGzy8P/3EBROLoVK6Mk
         VYPGHwZLN4eX3HFdjCqz6+yIoqsDYOGLPEVVqUOq9oklAGCWyhtjxuJ1rBElx5nrSQah
         ym1VMoZdv7u0kRP9xzUTelKTTVZOfKrujHCYTlho4Dx+6JRzp5nU6jXBcVDImFdGSZ4f
         GIss7JvFX+N1667qwX9/kbScCpldpTCb1bxx3zWZbKNWfCL6DFgYpDq4bH95U1iCkp76
         EAg45PyPJhBIoyp/tDCuyIIMLrkaVuMa3i7867rVSFEBBrXGMgTov9L3n27HThszTMQz
         FRUQ==
X-Gm-Message-State: AOAM532SZiNOTTEXXV5QDXnTrfqiez8SnwF1dVWKMPSlbGbQwOcDNegN
        uXvXijJbIkNsCU08FpgFZNgfQuCzoiPFNqsOifw=
X-Google-Smtp-Source: ABdhPJyor7ZwQ947NcEp3PAlytPlCemU5zOUicZRxlJEWmnOQgkBjGxyY1pQsRHgezaxJNB6m41NZ6h/Hv0c+FRcOP8=
X-Received: by 2002:a50:9f66:: with SMTP id b93mr2163710edf.201.1602056038619;
 Wed, 07 Oct 2020 00:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201003075514.32935-1-haifeng.zhao@intel.com> <20201004045745.GA3207@araj-mobl1.jf.intel.com>
In-Reply-To: <20201004045745.GA3207@araj-mobl1.jf.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 7 Oct 2020 15:33:47 +0800
Message-ID: <CAKF3qh2WyqAsCMZ5MueUfJtQPbWOCDH1eJNf6bu5G96mx+PqQg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Fix DPC hotplug race and enhance error handling
To:     "Raj, Ashok" <ashok.raj@linux.intel.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Raj,

On Sun, Oct 4, 2020 at 12:57 PM Raj, Ashok <ashok.raj@linux.intel.com> wrote:
>
> Hi Ethan
>
> On Sat, Oct 03, 2020 at 03:55:09AM -0400, Ethan Zhao wrote:
> > Hi,folks,
> >
> > This simple patch set fixed some serious security issues found when DPC
> > error injection and NVMe SSD hotplug brute force test were doing -- race
> > condition between DPC handler and pciehp, AER interrupt handlers, caused
> > system hang and system with DPC feature couldn't recover to normal
> > working state as expected (NVMe instance lost, mount operation hang,
> > race PCIe access caused uncorrectable errors reported alternatively etc).
>
> I think maybe picking from other commit messages to make this description in
> cover letter bit clear. The fundamental premise is that when due to error
> conditions when events are processed by both DPC handler and hotplug handling of
> DLLSC both operating on the same device object ends up with crashes.

Yep, that's right.

Thanks,
Ethan
>
>
> >
> > With this patch set applied, stable 5.9-rc6 on ICS (Ice Lake SP platform,
> > see
> > https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server))
> >
> > could pass the PCIe Gen4 NVMe SSD brute force hotplug test with any time
> > interval between hot-remove and plug-in operation tens of times without
> > any errors occur and system works normal.
>
> >
> > With this patch set applied, system with DPC feature could recover from
> > NON-FATAL and FATAL errors injection test and works as expected.
> >
> > System works smoothly when errors happen while hotplug is doing, no
> > uncorrectable errors found.
> >
> > Brute DPC error injection script:
> >
> > for i in {0..100}
> > do
> >         setpci -s 64:02.0 0x196.w=000a
> >         setpci -s 65:00.0 0x04.w=0544
> >         mount /dev/nvme0n1p1 /root/nvme
> >         sleep 1
> > done
> >
> > Other details see every commits description part.
> >
> > This patch set could be applied to stable 5.9-rc6/rc7 directly.
> >
> > Help to review and test.
> >
> > v2: changed according to review by Andy Shevchenko.
> > v3: changed patch 4/5 to simpler coding.
> > v4: move function pci_wait_port_outdpc() to DPC driver and its
> >    declaration to pci.h. (tip from Christoph Hellwig <hch@infradead.org>).
> > v5: fix building issue reported by lkp@intel.com with some config.
> > v6: move patch[3/5] as the first patch according to Lukas's suggestion.
> >     and rewrite the comment part of patch[3/5].
> > v7: change the patch[4/5], based on Bjorn's code and truth table.
> >     change the patch[5/5] about the debug output information.
> >
> > Thanks,
> > Ethan
> >
> >
> > Ethan Zhao (5):
> >   PCI/ERR: get device before call device driver to avoid NULL pointer
> >     dereference
> >   PCI/DPC: define a function to check and wait till port finish DPC
> >     handling
> >   PCI: pciehp: check and wait port status out of DPC before handling
> >     DLLSC and PDC
> >   PCI: only return true when dev io state is really changed
> >   PCI/ERR: don't mix io state not changed and no driver together
> >
> >  drivers/pci/hotplug/pciehp_hpc.c |  4 ++-
> >  drivers/pci/pci.h                | 55 +++++++++++++-------------------
> >  drivers/pci/pcie/dpc.c           | 27 ++++++++++++++++
> >  drivers/pci/pcie/err.c           | 18 +++++++++--
> >  4 files changed, 68 insertions(+), 36 deletions(-)
> >
> >
> > base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7
> > --
> > 2.18.4
> >
