Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548282DD690
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgLQRtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 12:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQRtD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Dec 2020 12:49:03 -0500
Date:   Thu, 17 Dec 2020 11:48:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608227302;
        bh=+tD42SLQe9xn0RAbjN1Ki/j49p9w5aI1aNn/jsIAcwU=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=WpOEwdu5snoXXX5tQJQvD3fWyd2pt9eTuaQ+tM40014fAoAFMi9oMTCIh5L/VtTL8
         hs0p4mKocFNAKZJ1B/l50eIWGnnfb6COVx6+QRESpQI2ZGaoYigxRqf/v7+BcZ7LMd
         n4AN1RtAGgm6Hj8z0JFX3boygGgPbNOGpiuE/3dIfMwAVHGdwWWsW4JsSaYcWNPdtJ
         y8fldjVJJURSa0gbE/hht7blDbrkanEk+vLzxvotPYvxAfSjlp5VSrHYOcAe+kSqs/
         W9dA1NwkcBTuEIWQ3MjwGAiottzW0Z3VjEBo35BUuiJrR7+uEtnpN9u/XolFOfhM3v
         V0ClyjBhOzh5w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: VPD blacklist of Marvell QLogic 1077/2261
Message-ID: <20201217174821.GA9644@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 16, 2020 at 04:44:47PM -0800, Arun Easi wrote:
> Hi Bjorn,
> 
> This is regarding the blacklisting of one of the Marvell QLogic FC
> adapter (1077/2261) on VPD area access. The commit that did was
> this:
> 
> --8<-- pruned commit message --8<--
> | commit 0d5370d1d85251e5893ab7c90a429464de2e140b
> | Author: Ethan Zhao <ethan.zhao@oracle.com>
> | Date:   Mon Feb 27 17:08:44 2017 +0900
> | 
> |     PCI: Prevent VPD access for QLogic ISP2722
> |     Call Trace:
> |      <NMI>  [<ffffffff817193de>] dump_stack+0x63/0x81
> |      [<ffffffff81714072>] panic+0xd0/0x20e
> |      [<ffffffff8101c8b4>] do_nmi+0xf4/0x170
> |      <<EOE>>  [<ffffffff815db4b3>] raw_pci_read+0x23/0x40
> |      [<ffffffff815db4fc>] pci_read+0x2c/0x30
> |      [<ffffffff8136f612>] pci_user_read_config_word+0x72/0x110
> |      [<ffffffff8136f746>] pci_vpd_pci22_wait+0x96/0x130
> |      [<ffffffff8136ff9b>] pci_vpd_pci22_read+0xdb/0x1a0
> |      [<ffffffff8136ea30>] pci_read_vpd+0x20/0x30
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d5370d1d85251e5893ab7c90a429464de2e140b
> 
> While investigating the original report of the issue, I found an
> interesting information that may explain why Ethan Zhao was
> hitting the NMI/crash.
> 
> If you notice the stack referred in the commit, you could see that
> a bunch of old vpd access functions, pci_vpd_pci22*, were referred.
> When these functions were in use (these functions were renamed
> around 2016 Feb by f1cd93f9aabe), there was a critical VPD
> access bug missing; missing in fact most of the life of those
> functions.
> 
> This one:
>     104daa71b396: PCI: Determine actual VPD size on first access
> 
> Without this patch, a read of the vpd sysfs file can access area
> outside of VPD space, which is not allowed by the spec.
> 
> My guess here is that, Ethan, when trying to access VPD of the QLogic
> 1077/2261 adapter, was using a kernel that had the bug present and
> it led up to the NMI/crash he was observing on his machine.
> 
> We had an early firmware that returned CA on VPD access beyond
> bounds that is known to NMI some servers. The FW has since changed to
> not clear the VPD flag upon out-of-bound access.
> 
> In light of the above, plus the fact that I did try the
> experiment on multiple setups and was not able to reproduce the
> issue, would you be willing to revert the above patch? If so, I
> could send a git revert (or equivalent) patch of the commit.
> 
> This blacklisting is preventing multiple customers from accessing
> the VPD area of the said production adapter and making their life
> a bit difficult.
> 
> Regards,
> -Arun
> 
> Old discussion of the topic:
>     https://lkml.org/lkml/2019/5/21/991

It makes sense to revert 0d5370d1d852 ("PCI: Prevent VPD access for
QLogic ISP2722") as long as the resulting kernel works correctly on
all versions of the 2722 firmware.  We have to assume some customers
still have the old firmware on their adapters.

Bjorn
