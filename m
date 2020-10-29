Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0529F687
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJ2U7F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 29 Oct 2020 16:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJ2U7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 16:59:04 -0400
X-Greylist: delayed 70663 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Oct 2020 13:59:04 PDT
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CAFC0613CF
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 13:59:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id C059F140837;
        Thu, 29 Oct 2020 21:59:01 +0100 (CET)
Date:   Thu, 29 Oct 2020 21:58:53 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201029215853.6ccce4e0@nic.cz>
In-Reply-To: <20201029193022.GA476048@bjorn-Precision-5520>
References: <871rhhmgkq.fsf@toke.dk>
        <20201029193022.GA476048@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 29 Oct 2020 14:30:22 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Oct 29, 2020 at 12:12:21PM +0100, Toke Høiland-Jørgensen wrote:
> > Pali Rohár <pali@kernel.org> writes:  
> 
> > > I have been testing mainline kernel on Turris Omnia with two PCIe
> > > default cards (WLE200 and WLE900) and it worked fine. But I do not know
> > > if I had ASPM enabled or not.
> > >
> > > So it is working fine for you when CONFIG_PCIEASPM is disabled and whole
> > > issue is only when CONFIG_PCIEASPM is enabled?  
> > 
> > Yup, exactly. And I'm also currently testing with the default WLE200/900
> > cards... I just tried sticking an MT76-based WiFi card into the third
> > PCI slot, and that doesn't come up either when I enable PCIEASPM.  
> 
> Huh.  So IIUC, the following cases all try to retrain the link and it
> fails to come up again:
> 
>   - aardvark + WLE900VX (see commit 43fc679ced18)
>   - mvebu + WLE200
>   - mvebu + WLE900
>   - mvebu + MT76

Bjorn, IIRC Pali's patches fix the WLE900VX card for Aardvark (both in
kernel and in U-Boot).
IMO mvebu has similar issues. Both these drivers handle the PCIe reset
signal incorrectly (or at least Aardvark did before Pali's work).

mvebu is used on Turris Omnia, and our HW guys first solved the WLE900VX
not working issue by using different capacitors for the SerDeses (this
was 5 years ago). But after Pali's work on Aardvark I think this could
also be solved for mvebu driver in software.

BTW the WLE900VX card has problems on many systems, it won't work for
example on Thinkpad X230. There is a bug on kernel bugzilla reported
for this.

My opinion is that many drivers do not respect the PCIe specification
for reset and link training totally correctly (Pali was talking about
this when he was looking at Aardvark) and that WLE900VX has a bug that
in combination with those drivers causes the fail. If you look at the
drivers, they are incompatible in how they handle the reset signal and
link training.

I am curious what Pali will tell us, he said that he will look into the
mvebu driver.

Marek
