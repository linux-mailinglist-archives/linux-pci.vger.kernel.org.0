Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6CF325D3B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Feb 2021 06:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZFdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Feb 2021 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhBZFdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Feb 2021 00:33:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F37C06174A;
        Thu, 25 Feb 2021 21:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rWddWXnuro4YAoJY8JcUhOg9+DBTrAAV7EgLMgansOs=; b=Y95JvHz+p/fgRuSqZdUJ6kTozG
        0hAoFtiyNg4giHk7sA+bUreJm0TfS3bLevc6PdklG1y06IzBDHblgOs5KDo9/3NWCY7NuMA/7UByg
        9jrDHwNwr5X1zHL8GYCCj0qcmzuCZ5LuVSQIWYroEgW1XQmEOlqVfUgYZRdlAspXhZcYl7YsK+cC8
        BCoG5w3WO3JuUlZ42r1a7m+lvxdVhuZk0p4FfsKRNYqw4tXn5We8K20zdsnscKzt8F/YATHIqQgHr
        ebQ03kMaxevLZc0Q8VZCIhTZKr4mmk0mW9HRB3r69f6tERAcAurrZcGA/SC0wowDiJtUBHY8Zgqd6
        bX7rKyag==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFVjj-00Bb9c-6O; Fri, 26 Feb 2021 05:32:23 +0000
Date:   Fri, 26 Feb 2021 05:32:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Robin Murphy <robin.murphy@arm.con>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: Re: RPi4 can't deal with 64 bit PCI accesses
Message-ID: <20210226053223.GA2763268@infradead.org>
References: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
 <2220c875-f327-586c-79c7-eadff87e4b4d@arm.com>
 <6088038a-2366-2f63-0678-c65a0d2efabd@gmail.com>
 <20210224202538.GA2346950@infradead.org>
 <0142a12e-8637-5d8e-673a-20953807d0d4@gmail.com>
 <0e52b124-e5a8-cdea-9f15-11be8c20af2a@baylibre.com>
 <0cca5246-065b-b52e-7005-b1b5229922a7@arm.com>
 <01091991523dac4c0c7e40f40e95c887af84f560.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01091991523dac4c0c7e40f40e95c887af84f560.camel@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 25, 2021 at 12:35:27PM +0100, Nicolas Saenz Julienne wrote:
> Yes, that's what I had in mind myself. All in all, why penalize the rest of
> busses in the system. What I'm planning is to introduce a '64bit-mmio-broken'
> DT property that'll utimately live somwhere in 'struct device.'
> 
> WRT why not defaulting to 32-bit accesses for distro images if they support
> RPi4. My *un-educated* guess is that, the performance penalty of checking for a
> device flag is (way) lower than having to resort to two distinct write
> operations with their assorted memory barriers. I'm sure you can
> comment/correct me here.

Various high performance devices rely on the fact that 64-bit MMIO
writes are atomic, and will have to use an extra lock and/or an entirely
different programming model if they are not supported.

If that is not the case just using 32-bit accesses always is certainly
easier, that's what we did for the slow-path only 64-bit registers in
NVMe.
