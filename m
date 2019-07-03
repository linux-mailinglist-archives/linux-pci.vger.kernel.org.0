Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860C85EB19
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGCSF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 14:05:28 -0400
Received: from verein.lst.de ([213.95.11.211]:53941 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCSF2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 14:05:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9950C68B05; Wed,  3 Jul 2019 20:05:25 +0200 (CEST)
Date:   Wed, 3 Jul 2019 20:05:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        AlexDeucher <alexander.deucher@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/22] mm: move hmm_vma_fault to nouveau
Message-ID: <20190703180525.GA13703@lst.de>
References: <20190701062020.19239-21-hch@lst.de> <20190703180356.GB18673@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703180356.GB18673@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 03, 2019 at 03:03:56PM -0300, Jason Gunthorpe wrote:
> I was thinking about doing exactly this too, but amdgpu started using
> this already obsolete API in their latest driver :(
> 
> So, we now need to get both drivers to move to the modern API.

Actually the AMD folks fixed this up after we pointed it out to them,
so even in linux-next it just is nouveau that needs fixing.
