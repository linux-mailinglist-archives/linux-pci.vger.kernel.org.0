Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B424C51B03
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 20:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfFXSyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 14:54:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37082 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfFXSyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 14:54:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so394594wme.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2019 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VLB62LTLlXO8oWMzmxndKFmxYDQNRrl1nYzZ7fiBH8=;
        b=bssP7nVtbxic8x1W+7aINGmVwUOYnfJSdJihHr+XXest3Vx9i0deL1LOz0fug7R1U1
         B5g5IL/YBGy8xioHik2tNV6c6asgwNQLrq+uBuFoxRMgZJ4BuztaJWrkpPSpqVsKILZx
         14viaNCjBFFfPcy4wbxl2lhjSG22PDgW5GgEPY+aiVW57k23uu6GJEjQYvC/FgVfHEUM
         7d3P9SFXDAUtN220jCpceeo0OnTuWEohYBulBbQvXmpACGPIxLabY5EMrRWaAaowQaS4
         rSCmwjE/WHV4DGUGkvibovageI+23aZgeutKLX3qZ1Fp8lrfuajpCPGxlls7Z8yyNbcA
         ILfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VLB62LTLlXO8oWMzmxndKFmxYDQNRrl1nYzZ7fiBH8=;
        b=W37oFW4a8AvpouVYS+4hWMmpTqyFPv3itfnJwgcPoSO+n/M844daCY1VoqPSsPy6Eq
         MIljP2rVDifuGyW1di03A1ldj+0JV5ZKSjX0lk4yJ3TqpwE63X/4QGneeL0cbjrsEbug
         lyeUYXsEwTXEXNkn9c7cR+IaO5a+FPh1JafOtZzPu2eIXpxoB0QhvcZnuhw7tc9Z2e/S
         COzsCJeHwFMnP5c6UmshiIfjmpvLHfLy1XwENb5AYt3Xaedy8ZhXFgWWl98HPU3s+kj8
         SZsSsspJ0Q5Ck4DiM7gGCczN3PDn0QA1f6MAJmNqZuFKwI2WcUQCVZjYDOSolFg3vLP1
         XigQ==
X-Gm-Message-State: APjAAAUkiBVhznQ098huxGNeNTRU0A0lepmUFqX1Y14c3xurI38gg9o1
        D9WQ+T8qchXLVQKG0Ti3MTWo6Q==
X-Google-Smtp-Source: APXvYqwuzff7/kg/rNAW2pQFDbje1NhrbmshAeZpBjzb6O9dqiGhfTGm1OhmaQBXRqL6CYA5mJ8psQ==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr16384528wml.97.1561402487618;
        Mon, 24 Jun 2019 11:54:47 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id y2sm10324854wrl.4.2019.06.24.11.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 11:54:46 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfU72-0006ZX-QC; Mon, 24 Jun 2019 15:54:44 -0300
Date:   Mon, 24 Jun 2019 15:54:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190624185444.GD8268@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
 <20190624073126.GB3954@lst.de>
 <20190624134641.GA8268@ziepe.ca>
 <20190624135024.GA11248@lst.de>
 <20190624135550.GB8268@ziepe.ca>
 <7210ba39-c923-79ca-57bb-7cf9afe21d54@deltatee.com>
 <20190624181632.GC8268@ziepe.ca>
 <bbd81ef9-b4f7-3ba7-7f93-85f602495e19@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd81ef9-b4f7-3ba7-7f93-85f602495e19@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 24, 2019 at 12:28:33PM -0600, Logan Gunthorpe wrote:

> > Sounded like this series does generate the dma_addr for the correct
> > device..
> 
> This series doesn't generate any DMA addresses with dma_map(). The
> current p2pdma code ensures everything is behind the same root port and
> only uses the pci bus address. This is valid and correct, but yes it's
> something to expand upon.

I think if you do this it still has to be presented as the same API
like dma_map that takes in the target device * and produces the device
specific dma_addr_t

Otherwise this whole thing is confusing and looks like *all* of it can
only work under the switch assumption

Jason
