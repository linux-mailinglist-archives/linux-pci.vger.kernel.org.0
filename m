Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1146F358B50
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhDHR2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232599AbhDHR2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 13:28:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5092861131;
        Thu,  8 Apr 2021 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617902869;
        bh=wruduVdkbEbjN2mkVIAUSClY/ZLVAdEhtioJoWM82c8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CqdEGb/8ql8gxFI9ZAxHjCSp2KJOBGLddZcJljSWmiyITjK1b+lXL010kJBb7WK1+
         Y5gRpFGSaqFA4yEgLTp7P9DHY5j4qL4R6AikY8C0qGbh9Hg3R4YsvEJyhaH5r8kG/E
         hmZpM91u/oLi5pc0NE/y13EN55Bq5CXkz7xhLoR8t0ds1N6l02Z8ebDAO4Ujeh0E5S
         SC5omn30dv5VmmWpjgQpw31bylwLGQY+9bsku2FVXVWHAwpARmWhpMgZz8FutCqlt5
         1iB98o3V7gU5X2MuDzCCxhy+OlP8gdMBWQJYdq0ieMbOoS5mCnbX3y4Gg3JRWXFcUf
         Wehm+KVBxoV1Q==
Date:   Thu, 8 Apr 2021 12:27:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [PATCH 1/1] PCI/VPD: Fix blocking of VPD data in lspci for
 QLogic 1077:2261
Message-ID: <20210408172747.GA1940414@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2104071535110.13940@irv1user01.caveonetworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 03:57:32PM -0700, Arun Easi wrote:
> On Wed, 7 Apr 2021, 3:13pm, Bjorn Helgaas wrote:
> 
> > On Wed, Mar 03, 2021 at 02:42:50PM -0800, Arun Easi wrote:
> > > "lspci -vvv" for Qlogic Fibre Channel HBA 1077:2261 displays
> > > "Vital Product Data" as "Not readable" today and thus preventing
> > > customers from getting relevant HBA information. Fix it by removing
> > > the blacklist quirk.
> > > 
> > > The VPD quirk was added by [0] to avoid a system NMI; this issue has
> > > been long fixed in the HBA firmware. In addition, PCI also has changes
> > > to check the VPD size [1], so this quirk can be reverted now regardless
> > > of a firmware update.
> > 
> > This is not a very convincing argument yet since 104daa71b396 ("PCI:
> > Determine actual VPD size on first access") appeared in v4.6 and
> > 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722") appeared
> > in v4.11.
> > 
> > If 104daa71b396 really fixed the problem, why did we need
> > 0d5370d1d852?
> 
> True, 0d5370d1d852 was not really neeeded for 104daa71b396 and newer 
> kernels; my theory is that when Ethan Z. ran the tests, he was using an 
> older (older than 104daa71b396) kernel, but by the time the blacklisting 
> was put in place, the kernel already had the fix that made the 
> blacklisting unnecessary.
> 
> More of my investigation details explained here:
> 	https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com/
> 
> A quick summary of which is that, when Ethan reported the crash stack, it 
> had pci_vpd_pci22* calls which is seen only in older kernels. Though 
> 104daa71b396 too had those calls, it was very close to the commit that 
> renamed those calls (f1cd93f9aabe) -- and I theorized Ethan probably was 
> not running a kernel between 104daa71b396 and f1cd93f9aabe (only 3 
> commits (drivers/pci/) away).

We should put the outline of this theory in the commit log for the
benefit of future readers who have the same question I did.

Bjorn
