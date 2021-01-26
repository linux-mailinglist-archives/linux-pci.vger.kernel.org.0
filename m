Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403423036BC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 07:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbhAZGlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 01:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbhAZGkV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 01:40:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1975722228;
        Tue, 26 Jan 2021 06:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611643180;
        bh=81dmrWCqb+2VLXgV/3KvxluKegBm4QhjGHeoJkGi1gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMRds7dhkuwahSQd92jfhVR4QGXr/8X4Tp+QOY6Rve0duoK7Xf/j56vR3yfQSS4v5
         JdVoWG8pxuSWrqVKiqnSUJm4BuWxMIFsTzFXTx2PryLi0Uv0sZmFYzvRYD7hrW5GTW
         8IBMEC+xcUPYrESO0+TCOnlIRvXKa4TICfx7VbdRIfp90nI//jl6gemhWpVCvfeYNZ
         G7qZWn2zXmM/MJ1A93Y2Tc2mfclSP7PXf0Ak6O1PNOVfps5SkyeTWUluzH7W+YNqQ0
         PR2rW4tffwsyrAs6f2RQq97eTHoCI2YmwKIEHkRNS8eY2X24q2tBM1AQvbmaEejcmG
         hgo0+c8L7xDRA==
Date:   Tue, 26 Jan 2021 08:39:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-pci@vger.kernel.org, Myron Stowe <mstowe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] pci-driver: Add driver load messages
Message-ID: <20210126063935.GC1053290@unreal>
References: <20210125194138.1103155-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210125194138.1103155-1-prarit@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
> There are two situations where driver load messages are helpful.
>
> 1) Some drivers silently load on devices and debugging driver or system
> failures in these cases is difficult.  While some drivers (networking
> for example) may not completely initialize when the PCI driver probe() function
> has returned, it is still useful to have some idea of driver completion.

Sorry, probably it is me, but I don't understand this use case.
Are you adding global to whole kernel command line boot argument to debug
what and when?

During boot:
If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
If device fails, you should get an error from that device (fix the
device to return an error), or something immediately won't work and
you won't see it in sysfs.

During run:
We have many other solutions to get debug prints during run, for example
tracing, which is possible to toggle dynamically.

Right now, my laptop will print 34 prints on boot and endless amount during
day-to-day usage.

➜  kernel git:(rdma-next) ✗ lspci |wc -l
34

>
> 2) Storage and Network device vendors have relatively short lives for
> some of their hardware.  Some devices may continue to function but are
> problematic due to out-of-date firmware or other issues.  Maintaining
> a database of the hardware is out-of-the-question in the kernel as it would
> require constant updating.  Outputting a message in the log would allow
> different OSes to determine if the problem hardware was truly supported or not.

And rely on some dmesg output as a true source of supported/not supported and
making this ABI which needs knob in command line. ?

>
> Add optional driver load messages from the PCI core that indicates which
> driver was loaded, on which slot, and on which device.

Why don't you add simple pr_debug(..) without any knob? You will be able
to enable/disable it through dynamic prints facility.

Thanks
