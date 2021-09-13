Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC9C409E2E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbhIMUdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbhIMUdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:33:53 -0400
X-Greylist: delayed 1034 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Sep 2021 13:32:36 PDT
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE300C061574;
        Mon, 13 Sep 2021 13:32:36 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mPsd1-0003tb-6B; Mon, 13 Sep 2021 16:32:35 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id CE4CA5600F9; Mon, 13 Sep 2021 16:32:34 -0400 (EDT)
Date:   Mon, 13 Sep 2021 16:32:34 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux 5.15-rc1
Message-ID: <20210913203234.GA6762@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 10:22:57PM +0200, Heiner Kallweit wrote:

 > > This didn't help I'm afraid :(
 > > It changed the VPD warning, but that's about it...
 > > 
 > > [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
 > > [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)                                                                                           
 > > [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
 > > 
 > With this patch there's no VPD access to this device any longer. So this can't be
 > the root cause. Do you have any other PCI device that has VPD capability?
 > -> Capabilities: [...] Vital Product Data


01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
        Subsystem: Device 1dcf:030a
	...
	        Capabilities: [e0] Vital Product Data
                Unknown small resource type 06, will not decode more.


I'll add that to the quirk list and see if that helps.

	Dave
