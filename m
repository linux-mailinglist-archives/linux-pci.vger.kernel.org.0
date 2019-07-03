Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D15EB61
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGCSPs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 14:15:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38213 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfGCSPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 14:15:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so3565312qkk.5
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2019 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wryDEDMxoF6Vk+K+7duTnFgyottGCGFfZAdbutaWn2g=;
        b=MGb4X8V0OjUmCxHXdwat5t//603Imvm3kttDyzPr4B1R8dke3zyk8pDWGq7fzjOf9T
         vhoLDzI6WCU5N4NrK/vZZAt9KDue5n72hIeNC1cz1j/ds592t4xYj0gPc7RQWN5tu3kK
         y/BZeSVV19CFNNBfNU5x0lM9OM/CH02xFeKxUrblZJMqjjhX0l4gjG924KSmb6umCVqY
         q+ZOkych1AFQ/2d82ikRe4cso3C8TVySqyZbPVlAYKLNARrOu29Nsf2uO3Rs45jVcEQb
         PCfasJR/oBWrfsPe016/1vxmUYZfy876Nti6m+RO+WQbCOzAxMa5i5a/ZdgHoU8lAwIn
         KN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wryDEDMxoF6Vk+K+7duTnFgyottGCGFfZAdbutaWn2g=;
        b=ssXSTlHLqDOcRpLb+ajnhV0ih7FCcF5TmHcDYaIzYAEdozo6JgAVMTc+sYdrmHBtEX
         gFtaxxr/+C+kMVzk5vRSzqg1e8JMwyXztSNfKYSWw9u3Gk7LN/mPPbVLAr0Jc/vRP56r
         B9wBPtSrYzlB9B691v9AqlotxPmbI/2F/xRJD68T442HglSbTfeRemDfk6q1a9p8o4Bi
         GUcmIg6rCb4UUK6Bq2Q/jbViXEmW2UDK972fFVWExDe2YEhEMAOQUCUNsq+EflSIrjHP
         ifby48/kWT+IDoRCvUz+IQbM+n8y0PYqasXiKnAUfSoX59m0SpwgUPJHRlkjJehhrSxw
         yDOA==
X-Gm-Message-State: APjAAAWlhIgT1K3ltobud7uMVPDJzJABeqDObDSB5r/k2uLMroPN2yV5
        C3kGBci1kJCGL3MXLWPSsJ7hHu1j+WpDvw==
X-Google-Smtp-Source: APXvYqx+Obpp289GMjyQScpks1hosaCdzO2IJ2gOygQVUkXAuZU/IoXFFk8Hk2uU2aW+fFE5K61x4g==
X-Received: by 2002:a37:4914:: with SMTP id w20mr31403797qka.156.1562177743091;
        Wed, 03 Jul 2019 11:15:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j184sm1204269qkc.65.2019.07.03.11.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:15:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijnC-0000Ju-2z; Wed, 03 Jul 2019 15:15:42 -0300
Date:   Wed, 3 Jul 2019 15:15:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] mm: remove the legacy hmm_pfn_* APIs
Message-ID: <20190703181542.GD18673@ziepe.ca>
References: <20190701062020.19239-1-hch@lst.de>
 <20190701062020.19239-23-hch@lst.de>
 <20190703180125.GA18673@ziepe.ca>
 <20190703180308.GA13656@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703180308.GA13656@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 03, 2019 at 08:03:08PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 03, 2019 at 03:01:25PM -0300, Jason Gunthorpe wrote:
> > Christoph, I guess you didn't mean to send this branch to the mailing
> > list?
> > 
> > In any event some of these, like this one, look obvious and I could
> > still grab a few for hmm.git.
> > 
> > Let me know what you'd like please
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Thanks.  I was going to send this series out as soon as you had
> applied the previous one.  Now that it leaked I'm happy to collect
> reviews.  But while I've got your attention:  the rdma.git hmm
> branch is still at the -rc7 merge and doen't have my series, is that
> intentional?

Sorry, I rushed it too late at night to do it right apparently. Fixed.

Jason
