Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9F3889A4
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbhESIqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 04:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbhESIqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 04:46:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC2C06175F;
        Wed, 19 May 2021 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i4kTadda4oBt3afddYxcQHXtH210DToQIegrKDmu7Qs=; b=KayoCEogTLKFg5jrVgTEnTOVfZ
        hb8/pRDvfaaqQHvTUh4wopMGPdhivz06WHgnbV72RvjsaXV+6cm6cFH9oW+SDqiZl4ZWVxv4T1lj0
        CGk0x5+2pozw6bB+QbibCPFBLp9JSsxfVtUTv/EfK2GQdpAPkA/iYAjFGnKCeJQuUVJeZCJmDXa30
        NLfXWuByzbVnzcOHnp5UqctgfTHdBHG2jOvp2H1gBpF96nPXsXh2RZKqj/coj841wT7xsNEel7S3m
        nZ29e8D7ZPJNlG1996IoXbZc+8PU17eJvSUGAxKGrkljO99EBmA2NPiA31SK9awmPEjSoai5TU7YL
        3d52UGgQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljHoG-00Em7l-Ci; Wed, 19 May 2021 08:44:21 +0000
Date:   Wed, 19 May 2021 09:44:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Robert Straw <drbawb@fatalsyntax.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci: add NVMe FLR quirk to the SM951 SSD
Message-ID: <YKTP2GQkLz5jma/q@infradead.org>
References: <20210430205105.GA683965@bjorn-Precision-5520>
 <CBDZPI1DXKMS.88UVUXVIGC5V@nagato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBDZPI1DXKMS.88UVUXVIGC5V@nagato>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 15, 2021 at 12:20:05PM -0500, Robert Straw wrote:
> On page 40, sec 3.1.6 of the NVMe 1.1 spec, the documentation on SHST 
> states the following:

While it doesn't matter here, NVMe 1.1 is very much out of data, being
a more than 8 year old specification.  The current version is 1.4b,
with NVMe 2.0 about to be released.

> Knowing this I would suspect we'd actually want to treat most NVMe
> drives in this manner *if the kernel sees the SHN/SHST has been set
> prior.* Perhaps other NVMe devices are more tolerant of not doing this?

No, we don't.  This is a bug particular to a specific implementation.
In fact the whole existing NVMe shutdown before reset quirk is rather
broken and dangerous, as it concurrently accesses the NVMe registers
with the actual driver, which could be trivially triggered through the
sysfs reset attribute.

I'd much rather quirk these broken Samsung drivers to not allow
assigning them to VFIO.
