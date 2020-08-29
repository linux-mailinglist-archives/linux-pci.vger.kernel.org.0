Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC3256595
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgH2HYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Aug 2020 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2HYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Aug 2020 03:24:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAEEC061236;
        Sat, 29 Aug 2020 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b660aar3g6/JJYoLm+eUfNa34ts9ix4M3QDleqnb3gw=; b=pLldZGWXJimg9P6mCsRrKFdTvx
        +tWqoU3zirJpqHj3nuY9IUdwAoEZ8YOdTXpXJWJtn9vvTq/wqjz41X/A/k2SYiOsqE4IUDymkW8DO
        xUYByzEanMFhZnR3d7nZvrz5zl05p9eCYDHPcCf1L86lgms0eK3T6ypnKnZJWC2AThGDDT3jAp5+8
        XXQRTrWOljEIBxOAq7tKEILzHXZ/qONGxGMGuBT8j4ke8Ag3Mgm4yFf3hhbW+xDNnLKBNlkB0yEU/
        MJQaMlooU3V6aQYg3TP7bin0Ow487p2hXtDdW57xRAhHa+rddzTvDyu3OP1lt+6kQejtHiLIUxjtk
        q2cL9stg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBvDZ-0001qk-Bp; Sat, 29 Aug 2020 07:24:05 +0000
Date:   Sat, 29 Aug 2020 08:24:05 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200829072405.GB6704@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
 <20200827063406.GA13738@infradead.org>
 <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
 <20200827162333.GA6822@infradead.org>
 <DM6PR19MB2636ACECA16E43638B502A6DFA550@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB2636ACECA16E43638B502A6DFA550@DM6PR19MB2636.namprd19.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 27, 2020 at 05:49:40PM +0000, Limonciello, Mario wrote:
> Can you further elaborate what exactly you're wanting here?  VMD enable/disable
> is something that is configured in firmware setup as the firmware does the early
> configuration for the silicon related to it.  So it's up to the OEM whether to
> offer the knob to an end user.
> 
> At least for Dell this setting also does export to sysfs and can be turned on/off
> around a reboot cycle via this: https://patchwork.kernel.org/patch/11693231/.
> 
> As was mentioned earlier in this thread VMD is likely to be defaulting to "on"
> for many machines with the upcoming silicon.  Making it work well on Linux is
> preferable to again having to change firmware settings between operating systems
> like the NVME remapping thing from earlier silicon required.

And the right answer is to turn it off, but we really need to do that
at runtime, and not over a reboot cycle..
