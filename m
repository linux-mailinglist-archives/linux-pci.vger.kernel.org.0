Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D4306080
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhA0QEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 11:04:42 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:48289 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbhA0QBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 11:01:40 -0500
Received: from xps-7390.lan (mobile-166-172-191-81.mycingular.net [166.172.191.81])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4DQpGv2Qgnz1MrG;
        Wed, 27 Jan 2021 11:00:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1611763239; bh=fOYP0duwL8Kjziejp0T4vgqHhH8fZmJ0jxpYrWBI5jY=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=n9qTSBA42RqzL8bg7LDfnkmBTlbb0dVimQ1Xhnky+lq/2SalkzHYkBYI/L6CqWXFh
         GGoDeIDO3kMvKeEfZVZOt4y8hFtH7wT9f2QAB0InPfZssWBVteLu63nZReFQPP2+P/
         ddB2CBTHymQR0c2pjhhWoFo7+spX5gpHKxlZH/IE=
Date:   Wed, 27 Jan 2021 08:00:38 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
In-Reply-To: <20210127155023.GA2988674@bjorn-Precision-5520>
Message-ID: <512023b-30d2-4ac-fca2-f4cade3d8b7f@panix.com>
References: <20210127155023.GA2988674@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 27 Jan 2021, Bjorn Helgaas wrote:

> Do you have a URL for your initial report that I could include in the
> revert commit log?

I don't, as I'd emailed the committers first and that was then CCed to the
mailing list, but here's what I'd sent:

----
Date: Fri, 25 Dec 2020 16:38:56
From: Kenneth R. Crudup <kenny@panix.com>
To: vidyas@nvidia.com
Cc: bhelgaas@google.com
Subject: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for suspend/resume") causing hibernate resume
    failures

I've been running Linus' master branch on my laptop (Dell XPS 13 2-in-1). With
this commit in place, after resuming from hibernate my machine is essentially
useless, with a torrent of disk I/O errors on my NVMe device (at least, and
possibly other devices affected) until a reboot.

I do use tlp to set the PCIe ASPM to "performance" on AC and "powersupersave"
on battery.

Let me know if you need more information.

        -Kenny

----

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
