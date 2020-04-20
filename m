Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC731B0D86
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgDTN53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgDTN53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 09:57:29 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F23C061A0F
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 06:57:29 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so8466427qtv.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Y6perFiVeQ3QgWqLdIJUPsNvFY3EZijv/H4bCO6lY4=;
        b=mkrf0mj2uMHggYNoMXheWws/vfopgkKMdOj2sk/jq91aSFV+FBOaAWfRgYM4xhELk7
         anpstJTVDOqB4qOo0kIzlwP5u+6LnNpFVukNArZe7hoXCLYhFl026KWaIuXtr4kZkZid
         IJPXMEIC09IH6YOe2rwd+xfDBeWBnrWSySHhYgTBZSWTKpo9IqVk8fy6bXSM56vwA15i
         B+iFKjqNtcVfDZUiEh19W3zpSzKpdAhDy9qMwP2cjBEKkXw0Ag44wC60d6gA72lrJVpw
         SXd4MaW5F4oNRRxVYpJvgy0d14clAWod3shTlEIMW54sI5mktrnVJXVbeAuYZDLtCCXN
         7OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Y6perFiVeQ3QgWqLdIJUPsNvFY3EZijv/H4bCO6lY4=;
        b=b94IByoB5mHCiTl+U40BBIjJtyLOFxrB0HC+NhfF7dM2leVpZmKW8GSYuc17t4e8UL
         kv0L5ZdBFg8WR0v6vGuSwxSTeoukGFVc+D9BTYMGmRCW3/4inNziXlebkY2QZtF0U0ug
         msEfot2zIh0yOH9tbwgobOxtx8iKoxx7Ggaja2lTnGKsgFFNOAunGONOEgNUx9spUO+/
         IXToq4P7UTcPnJz47Pw8FDv4CjbY3xJsDaH3H/115F3W3cHug4uY9fPsb5bPBRQp5D8V
         ne+d9tWJ88vYlD5I2j6bEY0NEgDDzcie7Vvfb8MW/h1narLMGuumvaK1C/yDA1hbHpA7
         eqDw==
X-Gm-Message-State: AGi0PuaGp4DAMfdioQHsYOrJZL/UOsmzOIzAKc70UZhyTM612i0D9ro7
        CqQLmRVasleq+YHww1WZ/bEuZA==
X-Google-Smtp-Source: APiQypIj1R9FcMRfRka1KKXW7j9di+d85e9nm7Td/03CCkb8wDdEAIcizkSgGYTTocgktyzsVQW4zw==
X-Received: by 2002:ac8:82f:: with SMTP id u44mr15905874qth.198.1587391048363;
        Mon, 20 Apr 2020 06:57:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g14sm550791qtb.24.2020.04.20.06.57.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 06:57:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jQWvP-0002ax-4d; Mon, 20 Apr 2020 10:57:27 -0300
Date:   Mon, 20 Apr 2020 10:57:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, xuzaibo@huawei.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420135727.GO26002@ziepe.ca>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420074213.GA3180232@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Apr 16, 2020 at 05:13:31AM -0700, Christoph Hellwig wrote:
> > On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker wrote:
> > > On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig wrote:
> > > > > +	rcu_read_lock();
> > > > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> > > > > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > > > > +				       start, end - start);
> > > > > +	rcu_read_unlock();
> > > > > +}
> > > > 
> > > > What is the reason that the devices don't register their own notifiers?
> > > > This kinds of multiplexing is always rather messy, and you do it for
> > > > all the methods.
> > > 
> > > This sends TLB and ATC invalidations through the IOMMU, it doesn't go
> > > through device drivers
> > 
> > I don't think we mean the same thing, probably because of my rather
> > imprecise use of the word device.
> > 
> > What I mean is that the mmu_notifier should not be embedded into the
> > io_mm structure (whch btw, seems to have a way to generic name, just
> > like all other io_* prefixed names), but instead into the
> > iommu_bond structure.  That avoid the whole multiplexing layer.
> 
> Right, I can see the appeal. I still like having a single mmu notifier per
> mm because it ensures we allocate a single PASID per mm (as required by
> x86). I suppose one alternative is to maintain a hashtable of mm->pasid,
> to avoid iterating over all bonds during allocation.

I've been getting rid of hash tables like this.. Adding it to the
mm_struct does seem reasonable, I think PASID is a pretty broad
concept now.

Jason
