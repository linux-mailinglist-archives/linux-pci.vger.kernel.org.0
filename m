Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABE435A43C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDIRAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 13:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIRA3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 13:00:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88E1E610CA;
        Fri,  9 Apr 2021 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617987616;
        bh=NcMu3K5s+EstN7YGbfSrZEaN+hQc8nD73JtF3kYhCn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u87IevmXQVwdtN8T4HwxhlKLVxb1XMWubwx2vpzRrCOXIvXiYWovubRituAtHEFuu
         S1k5uETe3LqxWN9fZKj3591AFUblCTOYCqEE7QTCi1bCZva71e5M6+nykR7dKRU471
         PGiU7NkzjLq1aMazRw0BOgugWtSvyRVLZ0tRGd9whfLolZ75gQLHfXe0l08yjQO21W
         PuQFBkvP8fvWF2ozg4OT8Itg5XdYYBGcTPQQzBwB1E6NZ/2f1th1I8listNB2JqHt/
         13DCu0NLeQ/kCaHhYTE4XQ3SYOAL+OjR8rBlTkuT7QQNlLqTAc/uXXhnt7wC8FiFfg
         pYD1CB+2uvYKw==
Date:   Fri, 9 Apr 2021 12:00:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: Are back to back PCIe BAR allocations supported by Linux?
Message-ID: <20210409170015.GA2038290@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30b3cc23-75db-a2f7-cf1d-e02182db8be3@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 02:03:34PM +0200, Christian König wrote:
> Hello everyone,
> 
> we recently had a bug report of a system which works fine when a PCIe
> hotplug device is connected on boot, but fails to initialize if those device
> are disconnected and then reconnected again.
> 
> During investigation I've found that Linux isn't able to assign the BARs of
> the device correctly while reconnecting. The problem seems to be that the
> Linux PCI code doesn't seem to use back to back BAR allocations.
> 
> Now what's back to back BAR allocation? Let's assume you have two devices
> with a 256MiB BAR and a 2MiB BAR each behind a common upstream bridge.
> 
> The configuration Linux seems to use is the following:
> Device A - 256MiB BAR
> Device A -     2MiB BAR
> Padding     254MiB
> Device B - 256MiB BAR
> Device B -     2MIB BAR
> 
> With padding this results in at least 770MiB address space requirement for
> the common upstream bridge, with alignment this is probably more like 1GiB.
> 
> The BIOS on the other hand seems to be capable of configuring the BARs like
> this:
> 
> Device A - 256MiB BAR
> Device A -     2MiB BAR
> Padding     252MiB
> Device B -     2MIB BAR
> Device B - 256MiB BAR
> 
> The result is that you only need 768MiB address space for the upstream
> bridge which then perfectly fits into what is assigned for hotplug here.
> 
> Is that already supported by the Linux PCIe code? If yes then how? I've
> tried to read a bit into the BAR allocation code, but it is kind of hard to
> understand.

I'm sorry that I don't have a ready answer.  The Linux resource
allocation code is indeed very difficult to understand.  I'm quite
sure it is incapable of doing optimal assignments.

If the BIOS has already assigned working values, Linux generally
doesn't change them.  But when you hot-remove and then reconnect a
device, the BIOS assignments are lost, of course, and it's not
surprising that Linux doesn't recreate them exactly.  I certainly
agree that if it worked before, Linux *should* be able to make it work
again.

Bjorn
