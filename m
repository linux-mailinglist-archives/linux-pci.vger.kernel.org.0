Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EC40B89A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 22:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhINUCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 16:02:17 -0400
Received: from mail.i8u.org ([75.148.87.25]:65321 "EHLO chris.i8u.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233390AbhINUCQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 16:02:16 -0400
Received: by chris.i8u.org (Postfix, from userid 1000)
        id E0A9816C94EA; Tue, 14 Sep 2021 13:00:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by chris.i8u.org (Postfix) with ESMTP id DB7D316C9364;
        Tue, 14 Sep 2021 13:00:54 -0700 (PDT)
Date:   Tue, 14 Sep 2021 13:00:54 -0700 (PDT)
From:   Hisashi T Fujinaka <htodd@twofifty.com>
To:     Dave Jones <davej@codemonkey.org.uk>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
In-Reply-To: <20210914142419.GA32324@codemonkey.org.uk>
Message-ID: <c02876d7-c3f3-1953-334d-1248af919796@twofifty.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com> <20210913141818.GA27911@codemonkey.org.uk> <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com> <20210913201519.GA15726@codemonkey.org.uk> <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk> <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com> <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com> <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com> <20210914142419.GA32324@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Sep 2021, Dave Jones wrote:

> On Tue, Sep 14, 2021 at 07:51:22AM +0200, Heiner Kallweit wrote:
>
> > > Sorry to reply from my personal account. If I did it from my work
> > > account I'd be top-posting because of Outlook and that goes over like a
> > > lead balloon.
> > >
> > > Anyway, can you send us a dump of your eeprom using ethtool -e? You can
> > > either send it via a bug on e1000.sourceforge.net or try sending it to
> > > todd.fujinaka@intel.com
> > >
> > > The other thing is I'm wondering is what the subvendor device ID you
> > > have is referring to because it's not in the pci database. Some ODMs
> > > like getting creative with what they put in the NVM.
> > >
> > > Todd Fujinaka (todd.fujinaka@intel.com)
> >
> > Thanks for the prompt reply. Dave, could you please provide the requested
> > information?
>
> sent off-list.
>
> 	Dave

Whoops. I replied from outlook again.

I have confirmation that this should be a valid image. The VPD is just a
series of 3's. There are changes to preboot header, flash and BAR size,
and as far as I can tell, a nonsense subdevice ID, but this should work.

What was the original question?

Todd Fujinaka <todd.fujinaka@intel.com>
