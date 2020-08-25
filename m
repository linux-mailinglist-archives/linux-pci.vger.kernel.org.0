Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF04251272
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 08:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgHYG4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Aug 2020 02:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgHYG4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2020 02:56:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CD6C061574;
        Mon, 24 Aug 2020 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mP8n04TXgNIN9kqtprAkjh2pKjIiOhhJ0sYIylsGTp0=; b=gNUiHyXXnX6v2kMzN7Nx+HnwhP
        XbILaOvxU1zWgHNCn8LRTE8fvCmusluHjxJAqNB6Wpe74bz3Jyt+ScrwqhctVFT5jNr05tuNPgKec
        Dpluy9PEI+ogrwyCDz7R619+Hn/wbgmbI7DgLX2YEC7tTbydKnT9kxLTNmNmRja/X6f8ndeJeE7bv
        7nFcpt0a41KPSE7FZYzbCjoyM4wcBHxofrh+jD7AbNpVJAwwt2K8uC6E+wIH6KV34W8r+m64bE0/r
        TWFtG1XWwoZtEH7We+Mmn0ytJLEqNLMGn2Jp2pmNhHjeTnP8J6uNNpnS4LZ2bf4Y3YdObKpck/Eve
        xGPRJkqQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kASsl-0000qN-0Z; Tue, 25 Aug 2020 06:56:35 +0000
Date:   Tue, 25 Aug 2020 07:56:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        jonathan.derrick@intel.com, Mario.Limonciello@dell.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Huffman, Amber" <amber.huffman@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200825065634.GA2691@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <08080FC7-861B-472A-BD7D-02D33926677F@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08080FC7-861B-472A-BD7D-02D33926677F@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 25, 2020 at 02:39:55PM +0800, Kai Heng Feng wrote:
> Hi Christoph,
> 
> > On Aug 25, 2020, at 2:23 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Fri, Aug 21, 2020 at 08:32:20PM +0800, Kai-Heng Feng wrote:
> >> New Intel laptops with VMD cannot reach deeper power saving state,
> >> renders very short battery time.
> > 
> > So what about just disabling VMD given how bloody pointless it is?
> > Hasn't anyone learned from the AHCI remapping debacle?
> > 
> > I'm really pissed at all this pointless crap intel comes up with just
> > to make life hard for absolutely no gain.  Is it so hard to just leave
> > a NVMe device as a standard NVMe device instead of f*^&ing everything
> > up in the chipset to make OS support a pain and I/O slower than by
> > doing nothing?
> 
> From what I can see from the hardwares at my hand, VMD only enables a PCI domain and PCI bridges behind it.
> 
> NVMe works as a regular NVMe under those bridges. No magic remapping happens here.

It definitively is less bad than the AHCI remapping, that is for sure.

But it still requires:

 - a new OS driver just to mak the PCIe device show up
 - indirections in the irq handling
 - indirections in the DMA handling
 - hacks for ASPSM
 - hacks for X (there were a few more)

while adding absolutely no value.  Basically we have to add a large
chunk of kernel code just to undo silicone/firmware Intel added to their
platform to make things complicated.  I mean it is their platform and if
they want a "make things complicated" option that is fine, but it should
not be on by default.
