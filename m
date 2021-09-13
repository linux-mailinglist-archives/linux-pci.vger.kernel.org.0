Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C871409DF2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbhIMULA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236133AbhIMUK7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 16:10:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7110E603E7;
        Mon, 13 Sep 2021 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631563783;
        bh=XrR2dJ1N43olPr7nnlRqhoV64SDmyXAuDwHZVU/O6vI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YbaYOqbuTQt9lrVTCa/+FoDKb2QkTWvIqtfC9l+PNibrE3BUcte0l3/1PubUkuNAO
         TtTppTzhT21EZyIrWAYqd0V+FFjyFQR8quAfSEEUuKVuKIJhQSjMDN1/WHyhwWQi1m
         2MWx6gc1M1TGnC8Bkdhl2BCyc0z1bNtdmjMCx8hkU/4h2CUKg4amiFaUk7h7S5PEVZ
         2txenvzrZxHmJUKG7xfLBU0OVceM18aHUljsCGWpRfsou1Iur0+Afiwp3jK0ZxPZlO
         rSouBKYAmhhjMB5G488WJJGifLy625ZTw7MPMRPzUqA+oTgtRlu3V1ZLCe2gS7yFJJ
         r1ljTGFeB7OkA==
Date:   Mon, 13 Sep 2021 15:09:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux 5.15-rc1
Message-ID: <20210913200942.GA1351739@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUJe9rsM5kbmq7jLZc2E6N6XhYaeW9-zJgWaDC-wDiuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 12:51:30PM -0700, Linus Torvalds wrote:
> On Mon, Sep 13, 2021 at 12:00 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >
> > With an older kernel you may experience the stall when accessing the vpd
> > attribute of this device in sysfs.
> 
> Honestly, that old behavior seems to be the *much* better behavior.
> 
> A synchronous stall at boot time is truly annoying, and a pain to deal
> with (and debug).
> 
> That pci_vpd_read() function is clearly NOT designed to deal with
> boot-time callers in the first place, so I think that commit is simply
> wrong.
> 
> And yes, I see that "128ms timeout". If it was _one_ timeout, that
> would be one thing,. But it looks like it's repeated over and over.
> 
> Not acceptable at boot time. Not at all.
> 
> Bjorn. Please revert. Or I can do it.

Sorry about this.

Dave said it wasn't a trivial revert, but I'll be happy to work with
Heiner and Dave to revert and test it.

I agree that we shouldn't read VPD at boot-time unless we actually
need the data then.

Bjorn
