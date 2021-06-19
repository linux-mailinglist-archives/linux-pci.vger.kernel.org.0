Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68213AD88A
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhFSH4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 03:56:10 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:47017 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFSH4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 03:56:10 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2AD5D2800B3C2;
        Sat, 19 Jun 2021 09:53:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 103183BD009; Sat, 19 Jun 2021 09:53:58 +0200 (CEST)
Date:   Sat, 19 Jun 2021 09:53:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: xhci_pci & PCIe hotplug crash
Message-ID: <20210619075358.GA31639@wunner.de>
References: <20210505120117.4wpmo6fhvzznf3wv@pali>
 <YJKK7SDIaeH1L/fC@kroah.com>
 <20210505123346.kxfpumww5i4qmhnk@pali>
 <20210505124402.GB29101@wunner.de>
 <20210505130240.lmryb26xffzkg4pl@pali>
 <ea58430d088742a1910475a680fb1de5@AcuMS.aculab.com>
 <20210505153942.mntbkmphw3ik3pdg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505153942.mntbkmphw3ik3pdg@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 05:39:42PM +0200, Pali Rohár wrote:
> On Wednesday 05 May 2021 15:20:11 David Laight wrote:
> > From: Pali Rohár
> > Sent: 05 May 2021 14:03
> > > So seems that PCIe controller HW triggers these external aborts when
> > > device on PCIe bus is not accessible anymore.
> > > 
> > > If this issue is really caused by MMIO access from xhci driver when
> > > device is not accessible on the bus anymore, can we do something to
> > > prevent this kernel crash? Somehow mask that external abort in kernel
> > > for a time during MMIO access?
> > 
> > If it is a cycle abort then the interrupted address is probably
> > that of the MMIO instruction.
> > So you need to catch the abort, emulate the instruction and
> > then return to the next one.
> 
> Has kernel API & infrastructure for catching these aborts and executing
> own driver handler when abort happens?

Yes, see here for an example:

https://lore.kernel.org/linux-pci/20210615191405.21878-4-jim2101024@gmail.com/
