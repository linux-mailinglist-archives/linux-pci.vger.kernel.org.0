Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE8251203
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHYGXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Aug 2020 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHYGXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2020 02:23:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E0C061574;
        Mon, 24 Aug 2020 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jCMEu3LP4rV3TV/crFuaErr1op6MoCd32OJKHJT+1Qc=; b=T1CrdikhBaO8D8p7db1LXHq4Kb
        pLs2oB4WAasNRgSBnXX6PHevM0stlTFMilnwYhyG6DiBix0cL18Nbx/HJsNv2GcI83lrO+AJ5E4TK
        P0J3/fhCj7dzeaa8TB78fymcDtekIeFPk453VQMnpMRjpbhQbVwwQy9PimVIhMtmQ1FbYlnR2b9/L
        Py97CNxIf4BhXWjaCMPloR4OKm4Hnntb9HQ1phWDfOAlOtp8GnyqlzciiJziutmC5c9SuzeX6x5be
        6prIKshVHSgGdu1unr6XZLY1CikYfrrrj/RTuwfr/YlciYR0It4+bjT06NojWINuT7zA7DGehbzOL
        GLiWnAsQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kASMa-0007NM-7H; Tue, 25 Aug 2020 06:23:20 +0000
Date:   Tue, 25 Aug 2020 07:23:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, jonathan.derrick@intel.com,
        Mario.Limonciello@dell.com, Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Huffman, Amber" <amber.huffman@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200825062320.GA27116@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821123222.32093-1-kai.heng.feng@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 08:32:20PM +0800, Kai-Heng Feng wrote:
> New Intel laptops with VMD cannot reach deeper power saving state,
> renders very short battery time.

So what about just disabling VMD given how bloody pointless it is?
Hasn't anyone learned from the AHCI remapping debacle?

I'm really pissed at all this pointless crap intel comes up with just
to make life hard for absolutely no gain.  Is it so hard to just leave
a NVMe device as a standard NVMe device instead of f*^&ing everything
up in the chipset to make OS support a pain and I/O slower than by
doing nothing?
