Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D703B34503A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 20:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCVTth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 15:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCVTtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 15:49:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF890C061574
        for <linux-pci@vger.kernel.org>; Mon, 22 Mar 2021 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a2YNmkFHFWJdUV3G4mTov/7QvS9+ADavhMLaJEkKeio=; b=i9FF28K/oSTYnMuAINyz46NpQC
        Z+smB3s551EiSa/A9n+LWS58Afh9EvXd7Pitjf62vJyPjACu07shyPBI0Cexhgkuez31YesBTq8H3
        VcoOwfEUf0wSnT/OBP24DwjWYSDW3aAqcImD3giQ3aL77ZdQkWAZ1V5WOn0bFJoLl82r5b+YMR6K6
        833z2n91XflFRYWQ4dUFTxIVdScJFp9CUMt+0fDmzIvdygDxAzaDN2bMfl88eW9vSw4113veLxh4f
        sJlQfpsk2Xxz8XPf7y6Nv+D7ZGRKs7DwTRLPNk9fd1BGf0unE4Gu5kuIWIKqL/5eYpWQuT1d6KTVo
        mufPP4Sg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQX5-008zTM-3z; Mon, 22 Mar 2021 19:48:18 +0000
Date:   Mon, 22 Mar 2021 19:48:11 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: Re: [PATCH 0/5] Legacy direct-assign mode
Message-ID: <20210322194811.GA2141770@infradead.org>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
 <20210322122837.GC11469@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322122837.GC11469@e121166-lin.cambridge.arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 22, 2021 at 12:28:37PM +0000, Lorenzo Pieralisi wrote:
> > correctly program bridge windows with physical addresses. Some customers are
> > using a legacy method that relies on the VMD subdevice domain's root port
> > windows to be written with the physical addresses. This method also allows
> > other hypervisors besides QEMU/KVM to perform guest passthrough.

This seems like a bad idea.  What are these other hypervisors?  AFAIK
there are no purely userspace hypervisors, so in other words what you
propose here is only for unsupported external modules.

I don't think we shoud merge something like this.
