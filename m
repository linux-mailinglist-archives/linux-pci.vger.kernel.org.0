Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1672454FC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 08:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfFNGsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 02:48:52 -0400
Received: from verein.lst.de ([213.95.11.211]:44529 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNGsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:48:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AC5EF68B05; Fri, 14 Jun 2019 08:48:23 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:48:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org
Subject: Re: [Nouveau] [PATCH 22/22] mm: don't select MIGRATE_VMA_HELPER
 from HMM_MIRROR
Message-ID: <20190614064823.GO7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-23-hch@lst.de> <7f6c6837-93cd-3b89-63fb-7a60d906c70c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6c6837-93cd-3b89-63fb-7a60d906c70c@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 06:53:15PM -0700, John Hubbard wrote:
> For those who have out of tree drivers that need migrate_vma(), but are not
> Nouveau, could we pretty please allow a way to select that independently?

No.  The whole point is to not build this fairly big chunk of code in
unless we have a user in the tree.
