Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F52E9B66
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 17:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhADQ53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 11:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhADQ53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 11:57:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A6C061574
        for <linux-pci@vger.kernel.org>; Mon,  4 Jan 2021 08:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CsdkWqMPYpLCdzLV15LOrVfBBoHeF9cMJDrzd73YqOc=; b=oQxmBpr8U0onNaYXpyVK8tNb+Z
        kt5/aJPVRz98uFxNHYffECmzK13HNGUfsWAvygVZ3/qI/mTJNjyQM8payfCXv9TLlqGRs9VuT95vc
        l2bQwMOOvWU+jTh1LStrj6A4GPU9+yZtk3YZjxULjgRxMuGeJcfYYfjZD6A96lgZMEQRCiOFkOnkl
        Vzgu+u9Ban3DLI84mYN1Am6G1KafWbfvYrdNkVE7YRCbWJ85+ql1E8Ewaa6CB1eglOEyo3gYqzfL0
        qN5ZJvtwFCxOKul8epnK9hYHOm0vt9K0o6nGaQ/4UWDjb6EIoKJdL47BoU2MrEcgQFCF7BKn1ZQ1f
        N67AWKUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwT9g-000KLt-B5; Mon, 04 Jan 2021 16:56:32 +0000
Date:   Mon, 4 Jan 2021 16:56:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc:     linux-mm@kvack.org, linux-pci@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Question regarding page fault handlers in kernel mappings
Message-ID: <20210104165628.GB22407@casper.infradead.org>
References: <d511840d-50af-44bd-92db-876180c503a5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d511840d-50af-44bd-92db-876180c503a5@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 04, 2021 at 11:38:38AM -0500, Andrey Grodzovsky wrote:
> Hello, I am AMD developer and I am trying to implement support for on the
> fly graceful graphic card extraction.

Are you talking about surprise removal (eg card on the other end of
a Thunderbolt connector where there is no possibility for software
locking), or are you talking about an orderly removal (where the user
requests removal and there is time to tear everything down gracefully)?

> One issue I am facing is how to avoid
> accesses to physical addresses both in RAM and MMIO from user mode and
> kernel after device is gone. For user accesses (mmap) I use the page fault
> handler to route all RW accesses to dummy zero page. I would like to do the
> same for kernel side mappings both form RAM (kmap) and device IO
> (ioremap) but it looks like there is no same mechanism of page fault
> handlers for kernel side mappings.

ioremap() is done through the vmalloc space.  It would, in theory, be
possible to reprogram the page tables used for vmalloc to point to your
magic page.  I don't think we have such a mechanism today, and there are
lots of problems with things like TLB flushes.  It's probably going to
be harder than you think.

I'm adding the linux-pci mailing list so you can be helped with the
logistics of device hot-remove.
