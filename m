Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89A44C783
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFTGdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 02:33:07 -0400
Received: from verein.lst.de ([213.95.11.211]:58050 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTGdH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 02:33:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0877068B05; Thu, 20 Jun 2019 08:32:37 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:32:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dev_pagemap related cleanups v2
Message-ID: <20190620063236.GE20765@lst.de>
References: <20190617122733.22432-1-hch@lst.de> <CAPcyv4hBUJB2RxkDqHkfEGCupDdXfQSrEJmAdhLFwnDOwt8Lig@mail.gmail.com> <20190619094032.GA8928@lst.de> <20190619163655.GG9360@ziepe.ca> <CAPcyv4hYtQdg0DTYjrJxCNXNjadBSWQ5QaMJYsA-QSribKuwrQ@mail.gmail.com> <20190619181923.GJ9360@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619181923.GJ9360@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 03:19:23PM -0300, Jason Gunthorpe wrote:
> > Just make sure that when you backmerge v5.2-rc5 you have a clear
> > reason in the merge commit message about why you needed to do it.
> > While needless rebasing is top of the pet peeve list, second place, as
> > I found out, is mystery merges without explanations.
> 
> Yes, I always describe the merge commits. Linus also particular about
> having *good reasons* for merges.
> 
> This is why I can't fix the hmm.git to have rc5 until I have patches
> to apply..
> 
> Probbaly I will just put CH's series on rc5 and merge it with the
> cover letter as the merge message. This avoid both rebasing and gives
> purposeful merges.

Fine with me.  My series right now is on top of the rdma/hmm branch.
There is a trivial conflict that is solved by doing so, as my series
removes documentation that is fixed up there a bit.  There is another
trivial conflict with your pending series as they remove code next to
each other in hmm.git.
