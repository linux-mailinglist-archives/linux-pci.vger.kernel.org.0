Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17243265E9F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 13:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKLQH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 07:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKLQD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 07:16:03 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F14C061573;
        Fri, 11 Sep 2020 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=36ZkAoKN0iM1NJFnvg/F9ZJ4FujUHf3nFyIgYS8P20E=; b=mCkPoBCG7tgxr2kE/Qp1HVqZL
        h81Rtwehr+ARfsh7bmrzSubSwZ6TrCNOpp4KKPoPmEJWZjFv+2/sFHEGgvvsP3NuwFJonTkPZXghH
        6npI0zHhfXgkZ7oV4DOdcPY8RVKLb51mdOONSN9MuAvFR1TUnY/vLnoEzjW+Zx/UO0D8gAosOohhi
        9mjZR+SSIO18EltTo6oerFym0wiGncjRKliSmXjXiHTg4LC4kqTIBnz8gOo7A3piVYJcjryjVQadS
        JIOopqxmg0two8HXps05Mob6s6ZDn8ZLxDm88ujhBsL1KmRGK2aZQQa2BASe6ElJ5fbcT8GtpFDo7
        TBU2NvCsQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33012)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kGh21-0007Ia-To; Fri, 11 Sep 2020 12:15:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kGh1z-0008Az-Jq; Fri, 11 Sep 2020 12:15:51 +0100
Date:   Fri, 11 Sep 2020 12:15:51 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM/keystone: move the DMA offset handling under
 ifdef CONFIG_ARM_LPAE
Message-ID: <20200911111551.GG1551@shell.armlinux.org.uk>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910054038.324517-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 07:40:37AM +0200, Christoph Hellwig wrote:
> The DMA offset notifier can only be used if PHYS_OFFSET is at least
> KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
> phys_addr_t.  Currently the code compiles fine despite that, a pending
> change to the DMA offset handling would create a compiler warning for
> this case.  Add an ifdef to not compile the code except for LPAE
> configs.

However, to have use of the high physical offset, LPAE needs to be
enabled, which ensures that phys_addr_t is 64-bit.

I believe that DMA is non-coherent on this platform unless the high
physical address is used. Or something like that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
