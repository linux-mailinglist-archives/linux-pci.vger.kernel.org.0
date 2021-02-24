Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0232452A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 21:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhBXU06 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 15:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBXU05 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 15:26:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F7CC061574;
        Wed, 24 Feb 2021 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=12uBme4GCr5a64UICfDbTfX0OuT87MBZBcK/kCTZvbk=; b=SLzy9dCxAYlVLXy9GlVICcWvPV
        ZONL9MQqnJfS1YM/LP75Jfcel8YwDJkw6fH5DdbfexEETSxS9ZiRhvP8QNPaYa3T9rbQ+ZZ8DRQev
        sLpED6AGOXn7Og/bztdtJXh8KRt17lvpa1FwI/tAXYAuNYvurT1uej9jqAJ/BIB6GnEgm7XDrBvUH
        HZu1fqXTyo9NXr27Gq3Gjgc9BCbWq39LBfHPCepditv8nnhRU5uj/uu1OzpfSorpP9bx1uQUYKIRx
        m8qNHOcctLnyxydwggT39kNF1kscayTHiEI7wCW2WEr9V4ZpWxZ3zfeHojXDcUffe8WJB/8raN8lB
        hbB9c3NQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lF0j4-009qsn-3j; Wed, 24 Feb 2021 20:25:49 +0000
Date:   Wed, 24 Feb 2021 20:25:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
Message-ID: <20210224202538.GA2346950@infradead.org>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
 <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
 <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 08:55:10AM -0800, Florian Fainelli wrote:
> > Working around kernel I/O accessors is all very well, but another
> > concern for PCI in particular is when things like framebuffer memory can
> > get mmap'ed into userspace (or even memremap'ed within the kernel). Even
> > in AArch32, compiled code may result in 64-bit accesses being generated
> > depending on how the CPU and interconnect handle LDRD/STRD/LDM/STM/etc.,
> > so it's basically not safe to ever let that happen at all.
> 
> Agreed, this makes finding a generic solution a tiny bit harder. Do you
> have something in mind Nicolas?

The only workable solution is a new

bool 64bit_mmio_supported(void)

check that is used like:

	if (64bit_mmio_supported())
		readq(foodev->regs, REG_OFFSET);
	else
		lo_hi_readq(foodev->regs, REG_OFFSET);

where 64bit_mmio_supported() return false for all 32-bit kernels,
true for all non-broken 64-bit kernels and is an actual function
for arm64 multiplatforms builds that include te RPi quirk.

The above would then replace the existing magic from the
<linux/io-64-nonatomic-lo-hi.h> and <linux/io-64-nonatomic-hi-lo.h>
headers.
