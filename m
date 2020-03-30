Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA801981AC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgC3Qv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 12:51:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40159 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgC3Qv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 12:51:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so8924931pgj.7
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2020 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLV+OA7NswcSpcRp5zK3H2qQIrq9TzUdJBNcxTbI9Bc=;
        b=EK8sREFUiPPj/IUg6JFCXxympmdVEARveyIvP/6dKC5N4LiA1CxRUWIE0IKm6fnLFd
         ZiLDpoywQEbgxz6MG8NWT4rKV4s+AmUn6R4leL1PSL0OT2Bongpy5OrvmFVJAGNeWZDS
         0MpN9eXaST+Xu1w53V7E1P/DlAgn7sosXPpuFRhbv+OQDKn5vtNvD3CzOGw78KGAVwR3
         PLs62nvS1vgN4V4fef6+N4PPeAHI/YOdB2p4rW+WhJoMQDUIm3Ihs5/0zJYuYjcXLm1n
         xHF8GG3AFeB4hOQmExup91gtXJhPCjyYzxayUfm+dvfCSFwWVpRWutBlvAlOIBdVwVL6
         Ys+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLV+OA7NswcSpcRp5zK3H2qQIrq9TzUdJBNcxTbI9Bc=;
        b=rxAq32k6mjhR2v+LFuoCWv5AEJ4tAHPdCxkp4VkNN4Ruyp2LIFAQ2GYSHjF2sVyCDM
         9oHM0H1y+4XQx3nGzmImrSzjaui5VLajxBJEGZOp47ecMo/6GHrqF3gHwUVaEKot44xV
         H/dSXs/NxO02IPmZ/ouatEgc4tu5T8i94ip4YcmIPMdXB0wKcfMh52snUYXhWZu6qz3e
         ECXJ7YQ19SBDq6/yJHYvbOWd9a8aIulRiWzpjIB8H4IU88UpoiD0FtBoCpcKzOA9WJDy
         W3IeDBauwDr3WUySBzU4ftAjd73F3lYwiZO7LB41T1iL8Fi2MLOIzwLEn3UdWCasyigY
         muxQ==
X-Gm-Message-State: ANhLgQ18CBUorH1H1a99GhQefJxJ89ec0+Ax592vbB3ZHCGukxfmVC2C
        t5XzPjDoUy4YYlBJqKtnCJfv8AkPKMob1QFhE9lOonakzLQ=
X-Google-Smtp-Source: ADFU+vsVZrEc7hYIw/PzJOX6cO6WWwxOUKGWlSIoUiL5OHi5b078O4q48dYfbd0GgTt7jIXHl8BcT4zBSdnSzvJl60k=
X-Received: by 2002:a05:6a00:42:: with SMTP id i2mr13628743pfk.108.1585587114191;
 Mon, 30 Mar 2020 09:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <202003290223.P0IbgBYa%lkp@intel.com> <20200328182304.GA70832@google.com>
In-Reply-To: <20200328182304.GA70832@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Mar 2020 09:51:43 -0700
Message-ID: <CAKwvOdkBYH1MFncDPnPG_squJmVYKDD82szCr6WFnQHOjGkE+g@mail.gmail.com>
Subject: Re: [pci:pci/edr 4/10] drivers/pci/pcie/err.c:168:28: error: use of
 undeclared identifier 'service'
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 28, 2020 at 11:23 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Mar 29, 2020 at 02:09:30AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/edr
> > head:   3a4c9f97543f0dbf580dd3646164e829ba08e600
> > commit: d9dbf5828770b236fcae3cc866d844fe360174d0 [4/10] PCI/ERR: Remove service dependency in pcie_do_recovery()
> > config: x86_64-defconfig (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 0fca766458da04bbc6d33b3f9ecd57e615c556c1)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout d9dbf5828770b236fcae3cc866d844fe360174d0
> >         # save the attached .config to linux build tree
> >         COMPILER=clang make.cross ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/pci/pcie/err.c:168:28: error: use of undeclared identifier 'service'
> >                    status = reset_link(dev, service);
>
> My merge error, sorry.  This is on a test branch (pci/edr), not in my
> -next branch yet.

FWIW: https://github.com/intel/lkp-tests/wiki/LKP-FAQ#is-there-a-way-not-to-trigger-kbuild-tests-on-a-specific-branch

>
> >                                             ^
> >    1 error generated.
> >
> > vim +/service +168 drivers/pci/pcie/err.c
> >
> > 2e28bc84cf6eec Oza Pawandeep              2018-05-17  148
> > d9dbf5828770b2 Kuppuswamy Sathyanarayanan 2020-03-23  149  void pcie_do_recovery(struct pci_dev *dev,
> > d9dbf5828770b2 Kuppuswamy Sathyanarayanan 2020-03-23  150                   enum pci_channel_state state,
> > d9dbf5828770b2 Kuppuswamy Sathyanarayanan 2020-03-23  151                   pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> > 2e28bc84cf6eec Oza Pawandeep              2018-05-17  152  {
> > 542aeb9c8f930e Keith Busch                2018-09-20  153     pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> > 542aeb9c8f930e Keith Busch                2018-09-20  154     struct pci_bus *bus;
> > 2e28bc84cf6eec Oza Pawandeep              2018-05-17  155
> > bfcb79fca19d26 Keith Busch                2018-09-20  156     /*
> > bfcb79fca19d26 Keith Busch                2018-09-20  157      * Error recovery runs on all subordinates of the first downstream port.
> > bfcb79fca19d26 Keith Busch                2018-09-20  158      * If the downstream port detected the error, it is cleared at the end.
> > bfcb79fca19d26 Keith Busch                2018-09-20  159      */
> > bfcb79fca19d26 Keith Busch                2018-09-20  160     if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > bfcb79fca19d26 Keith Busch                2018-09-20  161           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> > bfcb79fca19d26 Keith Busch                2018-09-20  162             dev = dev->bus->self;
> > 542aeb9c8f930e Keith Busch                2018-09-20  163     bus = dev->subordinate;
> > bfcb79fca19d26 Keith Busch                2018-09-20  164
> > 542aeb9c8f930e Keith Busch                2018-09-20  165     pci_dbg(dev, "broadcast error_detected message\n");
> > b5dfbeacf74865 Kuppuswamy Sathyanarayanan 2020-03-27  166     if (state == pci_channel_io_frozen) {
> > 542aeb9c8f930e Keith Busch                2018-09-20  167             pci_walk_bus(bus, report_frozen_detected, &status);
> > 6d2c89441571ea Kuppuswamy Sathyanarayanan 2020-03-23 @168             status = reset_link(dev, service);
> >
> > :::::: The code at line 168 was first introduced by commit
> > :::::: 6d2c89441571ea534d6240f7724f518936c44f8d PCI/ERR: Update error status after reset_link()
> >
> > :::::: TO: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > :::::: CC: Bjorn Helgaas <bhelgaas@google.com>
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200328182304.GA70832%40google.com.



-- 
Thanks,
~Nick Desaulniers
