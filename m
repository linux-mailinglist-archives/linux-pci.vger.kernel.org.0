Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8233A195
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 23:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhCMWIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 17:08:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234758AbhCMWIL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Mar 2021 17:08:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED6D664EB3;
        Sat, 13 Mar 2021 22:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615673291;
        bh=jaKwIz5Q9rt1m/yRb9UztFHybMZGC1BZH4s2vMT77Dc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=luoFmZ4/zLE9N+60M9HQi8u7VQetBSguPK1JjYkwMjx/A3CpWKvZEj/n++rpwLclK
         ChRwNReJsoqfkOfbfRpMSGvrZBqZ+3dOik88L8/4ZCjXCEBPMNYfAL7VvpAU6VKsIO
         IVlWEHJx5edYwJTp/E2sxNDefB7EZAWU2HflfEtoGg1OGdsbzsDfkjOrN1OhalvwYD
         f9wo8QK5VZwlZPAE8IbrjoQ+H4oAdunt5uDBQh21Ox/1FvMeqJm/wC1v6ncnQR8/ej
         AW38yTTXDBiSno+d9/UKMAne6vn2IsoJFas/CiE6fneU2owbBd3ocjoh/djbINcOTy
         XTY6XrjngqlBg==
Date:   Sat, 13 Mar 2021 16:08:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Erik Quaeghebeur <kernelbugs@equaeghe.nospammail.net>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [Bug 212261] New: pci 0000:00:00.2: can't derive routing for PCI
 INT A
Message-ID: <20210313220809.GA2401557@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-212261-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 13, 2021 at 01:19:39PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=212261
> 
>             Bug ID: 212261
>            Summary: pci 0000:00:00.2: can't derive routing for PCI INT A
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.10.22
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: kernelbugs@equaeghe.nospammail.net
>         Regression: No
> 
> I'm on a Lenovo T14 AMD, with a Ryzen 4750U. In the logs, I find
> 
> pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> pci 0000:00:00.2: can't derive routing for PCI INT A
> pci 0000:00:00.2: PCI INT A: not connected
> 
> where the last two lines are warnings. Various bugreports related to this can
> be found elsewhere.
> 
> I guess there is either something wrong with the hardware/firmware or with the
> kernel. I'd hope this warning can be fixed. Feel free to ask for more
> information.

Thanks for the report!

What device is 00:00.2?  Does it work?  If not, did it ever work,
i.e., is this a regression?  If it's a regression, what's the newest
kernel you know of where it did work?

Can you please attach a complete dmesg log and output of
"sudo lspci -vvv" to the bugzilla?

Can you also add links to any related bug reports you're aware of?

Bjorn
