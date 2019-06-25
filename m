Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D38B524AE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfFYH3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 03:29:48 -0400
Received: from verein.lst.de ([213.95.11.211]:60293 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfFYH3s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 03:29:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0839568B02; Tue, 25 Jun 2019 09:29:16 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:29:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Message-ID: <20190625072915.GD30350@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-19-hch@lst.de> <20190620192648.GI12083@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620192648.GI12083@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 09:26:48PM +0200, Michal Hocko wrote:
> On Thu 13-06-19 11:43:21, Christoph Hellwig wrote:
> > The code hasn't been used since it was added to the tree, and doesn't
> > appear to actually be usable.  Mark it as BROKEN until either a user
> > comes along or we finally give up on it.
> 
> I would go even further and simply remove all the DEVICE_PUBLIC code.

I looked into that as I now got the feedback twice.  It would
create a conflict with another tree cleaning things up around the
is_device_private defintion, but otherwise I'd be glad to just remove
it.

Jason, as this goes through your tree, do you mind the additional
conflict?
