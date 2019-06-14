Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1235D454A6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 08:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfFNGZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 02:25:24 -0400
Received: from verein.lst.de ([213.95.11.211]:44359 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfFNGZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:25:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 844DF68B02; Fri, 14 Jun 2019 08:24:55 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:24:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/22] mm: factor out a devm_request_free_mem_region
 helper
Message-ID: <20190614062455.GH7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-7-hch@lst.de> <20190613191626.GR22062@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613191626.GR22062@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 07:16:35PM +0000, Jason Gunthorpe wrote:
> I wonder if IORES_DESC_DEVICE_PRIVATE_MEMORY should be a function
> argument?

No.  The only reason to use this function is to allocate the fake
physical address space for the device private memory case.  If you'd
deal with real resources you'd use the normal resource allocator.
