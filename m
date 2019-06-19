Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52D04BE5C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFSQg6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 12:36:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42722 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSQg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 12:36:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so20645235qtk.9
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DzpNw7iMfHgKemdLUrfJxvdy9KGKJSIkCkr6aus8rCA=;
        b=EDamHHKFiI7TTHkw3d71MrV0NdBwB6F1R0bV3XkjGbuH5mQMYmiVlZa63N43certmw
         GaIE2u+163Cb4BhvTpbwTBxOWcLAcGEeI/3LO9nZ2D3hphDdktczve9XtPtWbb/zjdgx
         QuoJYZuWKxQ1Q1HWKQMOXlDG8688RHVxOe9ZrXX0wEZogGnlfFfLqDn8V5Dbs8IQvczi
         yQX28xdFN722tg0xFkBas291DRO6iaiEm0BDaeD7B2Eul7XBDtVnG/ZeKQsPeS/6vBSl
         FO7l2jZl3LYlQIBoVhkk/uCuTaMtyaMfsLTID0dqUBuf/FNrb2Plto9Q3eXvKdPYCYXn
         mxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DzpNw7iMfHgKemdLUrfJxvdy9KGKJSIkCkr6aus8rCA=;
        b=SeICj2Lx3Dh6Pno/ymFHAN/xAW+t29AUNrhyFG4PzucWcVjuIVR1V3tBV/kkHgTBxt
         SMESWhNMPTNp60CdGbuCf6zzJ/oreOsj649PnXVpxKlr5YN64KwG5qUMklsCqZzf5iPG
         ZdP2diy6xTZaW5Km4rpPVvrR91y/AV3HBLkfMSkTSgRl2ieHZSfGWPbAgjP91zPmlgiG
         GabcbhzxWUmNHGfZidzmd+3+m+2EoWpFCGEsiT0I5WfjoiEaQdsV0YVPPU2urY6RXzwe
         easDcabRg8a1LbkOeKC6Uow97Bnn/1LpC5CUdF8/P61BlaZZyOcqp++H6n/AkUE2fe6w
         jvVA==
X-Gm-Message-State: APjAAAWsxAuYVPeA2GUgLWNzCwNJzLwUFC5z7aOApZ3rVtkeCbX8Iwpy
        6boHEqZCgYiAiowi6lNPO12k6A==
X-Google-Smtp-Source: APXvYqzqHRHHrr8SACyRyLxcASgrxSvjDf6v3XwfN8DQX4ZVR7KLVzKliqO65H7tJkj2zv0u+29foQ==
X-Received: by 2002:a0c:d24d:: with SMTP id o13mr34947576qvh.86.1560962216870;
        Wed, 19 Jun 2019 09:36:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r36sm11720396qte.71.2019.06.19.09.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 09:36:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hddZv-0001vf-QN; Wed, 19 Jun 2019 13:36:55 -0300
Date:   Wed, 19 Jun 2019 13:36:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dev_pagemap related cleanups v2
Message-ID: <20190619163655.GG9360@ziepe.ca>
References: <20190617122733.22432-1-hch@lst.de>
 <CAPcyv4hBUJB2RxkDqHkfEGCupDdXfQSrEJmAdhLFwnDOwt8Lig@mail.gmail.com>
 <20190619094032.GA8928@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619094032.GA8928@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 11:40:32AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 18, 2019 at 12:47:10PM -0700, Dan Williams wrote:
> > > Git tree:
> > >
> > >     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.2
> > >
> > > Gitweb:
> > >
> > >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.2
> 
> > 
> > Attached is my incremental fixups on top of this series, with those
> > integrated you can add:
> 
> I've folded your incremental bits in and pushed out a new
> hmm-devmem-cleanup.3 to the repo above.  Let me know if I didn't mess
> up anything else.  I'll wait for a few more comments and Jason's
> planned rebase of the hmm branch before reposting.

I said I wouldn't rebase the hmm.git (as it needs to go to DRM, AMD
and RDMA git trees)..

Instead I will merge v5.2-rc5 to the tree before applying this series.

I've understood this to be Linus's prefered workflow.

So, please send the next iteration of this against either
plainv5.2-rc5 or v5.2-rc5 merged with hmm.git and I'll sort it out.

Jason
