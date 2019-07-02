Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06035DA81
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 03:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGCBOZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 21:14:25 -0400
Received: from verein.lst.de ([213.95.11.211]:46852 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfGCBOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 21:14:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F50E68B20; Wed,  3 Jul 2019 00:47:31 +0200 (CEST)
Date:   Wed, 3 Jul 2019 00:47:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dev_pagemap related cleanups v4
Message-ID: <20190702224731.GA23841@lst.de>
References: <20190701062020.19239-1-hch@lst.de> <20190701082517.GA22461@lst.de> <20190702184201.GO31718@mellanox.com> <2807E5FD2F6FDA4886F6618EAC48510E79DEA747@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79DEA747@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 10:45:34PM +0000, Weiny, Ira wrote:
> > 
> > On Mon, Jul 01, 2019 at 10:25:17AM +0200, Christoph Hellwig wrote:
> > > And I've demonstrated that I can't send patch series..  While this has
> > > all the right patches, it also has the extra patches already in the
> > > hmm tree, and four extra patches I wanted to send once this series is
> > > merged.  I'll give up for now, please use the git url for anything
> > > serious, as it contains the right thing.
> > 
> > Okay, I sorted it all out and temporarily put it here:
> > 
> > https://github.com/jgunthorpe/linux/commits/hmm
> > 
> > Bit involved job:
> > - Took Ira's v4 patch into hmm.git and confirmed it matches what
> >   Andrew has in linux-next after all the fixups
> 
> Looking at the final branch seems good.

Looks good to me as well.
