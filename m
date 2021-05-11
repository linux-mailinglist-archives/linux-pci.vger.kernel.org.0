Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7578837AAAD
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhEKP2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhEKP2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 11:28:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46991C061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sts2IrOoKBA5j3zJDaICa1bOg5V7ZlxBwe2th4dfflA=; b=tINMrJ4orF7fJGgJCWfekg7N4b
        2ZZ5WLA9AzdqIGHmLv38jZqNGTqjh7l0I6WznSNJ6tDGwg+OuzVgzR736swbVjiBJjhetxHEbOBlV
        f4bOHwukIR4RGdM98OH5D3K+Tgh7qQuZCl6MDm1gvVjJe5D4VSgoBS0USzYGY1h7pIEmR9YrzLpym
        fBtkGopXK4jP1aRCfpOCSIDH/0H3LADiEHS9+/OVvrrEDj9Uhcy4a1e/KgnsT9Zzbnv6Yx/vxSBf3
        nY21yHnapjD/9iLTTOGeDPe5qii+F9dr8iVzVwxUpIXaOV1YhK2VI9zOEFF+W5zyqcBBr29gjFB1I
        JZS5iWfQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgUGu-007P9j-W9; Tue, 11 May 2021 15:26:12 +0000
Date:   Tue, 11 May 2021 16:26:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, hch@infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/5] PCI: Use cached Device Capabilities 2 Register
Message-ID: <YJqiEAoxcCkVAEsK@infradead.org>
References: <1620745744-91316-1-git-send-email-liudongdong3@huawei.com>
 <1620745744-91316-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620745744-91316-2-git-send-email-liudongdong3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 11:09:00PM +0800, Dongdong Liu wrote:
> It will make sense to store the devcap2 value in the pci_dev structure
> instead of reading Device Capabilities 2 Register multiple times.
> So we add pci_init_devcap2() to get the value of devcap2, then use
> cached devcap2 in the needed place.

This looks sensible.  Should the devcap field maybe grow a pcie_
prefix?  What about caching PCI_EXP_DEVCAP as well while you're at it?
