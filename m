Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C830EE4AB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 17:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfKDQaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 11:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfKDQaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 11:30:07 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CFE20848;
        Mon,  4 Nov 2019 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572885006;
        bh=Df9XllAi0EtAJqNQk9KzfRX6H27z2QIDR1Jk+Gu6u1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1N1UF3Y8B+Zx3OoExLvkKFiNM/S+vbs7vx4hHm3SYW3Sk2fG3zyg+VH+1T8V5exK8
         US9emasPu+5EvWFTukrxoBhVsVNo0a5zao3lEgJWsDIiMx9s9+7KvB9MIrwmwieUg7
         8NRNywVpRfL+BsWXDy7NqvUVqfI/yO+UcxFVt2+w=
Date:   Mon, 4 Nov 2019 10:30:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
Message-ID: <20191104163004.GA117590@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QBN9D4bckEZmNhLJPBmr92St1W2GGyazLGR9kANFk2cfV8Pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Mon, Nov 04, 2019 at 05:04:54PM +0100, Carlo Pisani wrote:
> > > > It sounds like the firmware fails to even load v4.11?  If that's the
> > > > case, it's probably not a problem with the kernel itself, since it
> > > > hasn't even started executing.  Possibly a kernel size problem?  Maybe
> > > > the v4.11 kernel is larger than v4.4, v4.9, etc?  Does v4.11 boot if
> > > > you strip out non-essential drivers?
> 
> kernel v4.11 is 7.5Mbyte and doesn't boot from the TFTboot option
> offered by the firmware, it claims "out of range", which makes no
> sense
> 
> out of range in what? too big? bad initialized? who knows ....
> 
> > Is the v4.11 kernel image bigger than the v4.4 kernel that boots?
> 
> everything bigger than 7Mbyte seems to be bad for the firmware.

You should be able to test this by adding built-in drivers to your
v4.4 kernel so it becomes larger than 7 MB.  If the kernel size is the
problem, a large v4.4 kernel should fail the same way the v4.11 kernel
does.

> anyway, I post here to hear if someone is on the RB532A (Mikrotik),
> should I also open a ticket to OpenWrt?

I guess it wouldn't hurt to open an OpenWrt ticket because maybe more
people there have experience with the RB532A.  But if the problem is
simply that the RB532A has broken Rhine devices that don't correctly
support PCI MMIO access, the only fix is to work around it by using
I/O port access instead.

Your matrix at [1] seems to show that the only reliable "stable for
48h" combination is the one with PCI MMIO access disabled.

If there's some way to identify that broken device or the platform,
e.g., RB532A, somebody could write a quirk to automatically disable
PCI MMIO in the driver.  But the comment in the driver already
mentions that, so I guess it's not trivial to identify those cases.

[1] http://www.downthebunker.com/reloaded/space/viewtopic.php?f=79&p=2755
