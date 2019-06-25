Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D3552BD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfFYPA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 11:00:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731153AbfFYPA4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 11:00:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BBA5AF4C;
        Tue, 25 Jun 2019 15:00:54 +0000 (UTC)
Date:   Tue, 25 Jun 2019 17:00:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
Message-ID: <20190625150053.GJ11400@dhcp22.suse.cz>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
 <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625072317.GC30350@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue 25-06-19 09:23:17, Christoph Hellwig wrote:
> On Mon, Jun 24, 2019 at 11:24:48AM -0700, Dan Williams wrote:
> > I asked for this simply because it was not exported historically. In
> > general I want to establish explicit export-type criteria so the
> > community can spend less time debating when to use EXPORT_SYMBOL_GPL
> > [1].
> > 
> > The thought in this instance is that it is not historically exported
> > to modules and it is safer from a maintenance perspective to start
> > with GPL-only for new symbols in case we don't want to maintain that
> > interface long-term for out-of-tree modules.
> > 
> > Yes, we always reserve the right to remove / change interfaces
> > regardless of the export type, but history has shown that external
> > pressure to keep an interface stable (contrary to
> > Documentation/process/stable-api-nonsense.rst) tends to be less for
> > GPL-only exports.
> 
> Fully agreed.  In the end the decision is with the MM maintainers,
> though, although I'd prefer to keep it as in this series.

I am sorry but I am not really convinced by the above reasoning wrt. to
the allocator API and it has been a subject of many changes over time. I
do not remember a single case where we would be bending the allocator
API because of external modules and I am pretty sure we will push back
heavily if that was the case in the future.

So in this particular case I would go with consistency and export the
same way we do with other functions. Also we do not want people to
reinvent this API and screw that like we have seen in other cases when
external modules try reimplement core functionality themselves.

Thanks!
-- 
Michal Hocko
SUSE Labs
