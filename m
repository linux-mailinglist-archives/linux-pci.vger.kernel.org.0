Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7F57C38
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 08:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0GcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 02:32:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41542 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfF0GcZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 02:32:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so706316pls.8
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2019 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CxcmhcduYl1f+p8Q6K2P2tN31Ue+lZEcvfx29yQXcTA=;
        b=m4qtlRsuSk58BwN1KjuVxv1OBILIvoJnLL/W5x8gKQGKClqscPAZtSz5HIvZkBZeaP
         3YNDZbTITdkT9d4NODS4YBRtUWymp+dc1Frl9vN52KgPgeSBy8PuVOd1wpDqdViUXGuU
         TaoL6w12s1LCWVE6nAVStEUf6ToOh2LrH0l4rAjW0YWcykR1wBUiW/kiHYkRyaFw/b+m
         5RKkHPbZrlfJtX/jysSBDiQyarjXby+MLOi6XZdFtLwkUxPqEd3s89nrZCy07o0cLs07
         /nNhohMH1gqtNbY5OQLkVy7sE3hn5AauPYz18DSUKOmknEkjo7985c+vomp74sOA3gvV
         PN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxcmhcduYl1f+p8Q6K2P2tN31Ue+lZEcvfx29yQXcTA=;
        b=Tyj69GQt+4PfXYoVkk8odRAcpq526epOsLhJFrBNOUa6pSn+CAy44N4F/q+n9rHyvI
         hIFiDM393ew4jLe3uw5zqXN/zSNoz6HYidj7qJmzN6fCXPlqVnd4LUp9tRIlhCOBAGDW
         2H2bKAxXCPtAlktoeEJ7EjTgOspaJx+uCsSqAD7/s5aORsxTZaSADBGTYpjw0L+vGfzw
         XUhIie7nIQfxy9nKLAs6xzQlStLan/nootmn7Cu9uAr7SyI1ghVZitsvGBo/86K3WKi9
         E44qlNXymorSFB82Ndw7B3ec9vylcZo5u2pAZMcA9h5YVHWHeBZ7s+xG0fthD0TGc7j0
         sTCQ==
X-Gm-Message-State: APjAAAUcWUJibyjyqBVS4BOT/iz5Ock+taxJED7kyn1mJNWIr9HNKoBN
        gG7zVyHAeBZJZKogFJyrDHFQvQ==
X-Google-Smtp-Source: APXvYqwZ07G5863ndEAB+RksF+e+99jGlEHoSljL/kmhY9ivkki8aBvxOy/aBdnHgI3TPZQaVOsxJA==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr2700794plf.86.1561617144785;
        Wed, 26 Jun 2019 23:32:24 -0700 (PDT)
Received: from ziepe.ca ([12.199.206.50])
        by smtp.gmail.com with ESMTPSA id k184sm1017237pgk.7.2019.06.26.23.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 23:32:24 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgNxH-00029V-At; Thu, 27 Jun 2019 03:32:23 -0300
Date:   Thu, 27 Jun 2019 03:32:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190627063223.GA7736@ziepe.ca>
References: <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 03:18:07PM -0600, Logan Gunthorpe wrote:
> > I don't think we should make drives do that. What if it got CMB memory
> > on some other device?
> 
> Huh? A driver submitting P2P requests finds appropriate memory to use
> based on the DMA device that will be doing the mapping. It *has* to. It
> doesn't necessarily have control over which P2P provider it might find
> (ie. it may get CMB memory from a random NVMe device), but it easily
> knows the NVMe device it got the CMB memory for. Look at the existing
> code in the nvme target.

No, this all thinking about things from the CMB perspective. With CMB
you don't care about the BAR location because it is just a temporary
buffer. That is a unique use model.

Every other case has data residing in BAR memory that can really only
reside in that one place (ie on a GPU/FPGA DRAM or something). When an IO
against that is run it should succeed, even if that means bounce
buffering the IO - as the user has really asked for this transfer to
happen.

We certainly don't get to generally pick where the data resides before
starting the IO, that luxury is only for CMB.

> > I think with some simple caching this will become negligible for cases
> > you care about
> 
> Well *maybe* it will be negligible performance wise, but it's also a lot
> more complicated, code wise. Tree lookups will always be a lot more
> expensive than just checking a flag.

Interval trees are pretty simple API wise, and if we only populate
them with P2P providers you probably find the tree depth is negligible
in current systems with one or two P2P providers.

Jason
