Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A9300EEB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbhAVVao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 16:30:44 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:29390 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbhAVUL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 15:11:59 -0500
Received: from xps-7390 (unknown [172.58.172.248])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4DMr4F58VMzPkQ;
        Fri, 22 Jan 2021 15:11:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1611346270; bh=f9Z+x3/4G/BuKC+VE3eAdur1W1Sy+IC+m8mfccnT14o=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=kvu5oBL8cJUh/DOaT4hlGdwX1X/9Tu53Dqpv24Wkwqp9CKuHI5iekhtp6dWGeNoKx
         iIZnf8KvSKyukuh3j3/07jehKPc4VGBFBx4uvwUDhBAOXDayLLX97j58LZRzkZeneT
         bc89MJaUCvkXrptrZnFw8+eVt3nWFW/53DXk76Us=
Date:   Fri, 22 Jan 2021 12:11:08 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
In-Reply-To: <20201228040513.GA611645@bjorn-Precision-5520>
Message-ID: <2563ba4a-81bc-d27-2670-cae48690db5e@panix.com>
References: <20201228040513.GA611645@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> > From: Kenneth R. Crudup <kenny@panix.com>
> > I've been running Linus' master branch on my laptop (Dell XPS 13
> > 2-in-1).  With this commit in place, after resuming from hibernate
> > my machine is essentially useless, with a torrent of disk I/O errors
> > on my NVMe device (at least, and possibly other devices affected)
> > until a reboot.
> >
> > I do use tlp to set the PCIe ASPM to "performance" on AC and
> > "powersupersave" on battery.

On Sun, 27 Dec 2020, Bjorn Helgaas wrote:

> Thanks a lot for the report, and sorry for the breakage.
> 4257f7e008ea restores PCI_L1SS_CTL1, then PCI_L1SS_CTL2.  I think it
> should do those in the reverse order, since the Enable bits are in
> PCI_L1SS_CTL1.  It also restores L1SS state (potentially enabling
> L1.x) before we restore the PCIe Capability (potentially enabling ASPM
> as a whole).  Those probably should also be in the other order.

Any new news on this? Disabling "tlp" (which just shifts the problem around
on my machine) shouldn't be a solution for this issue.

I'd thought it may have been tied to some of the PM regressions of the last
week of December, but all of those have been fixed but this still remains.

Thanks,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
