Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7A454C9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 08:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfFNGdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 02:33:47 -0400
Received: from verein.lst.de ([213.95.11.211]:44432 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFNGdr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:33:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DDC1568B02; Fri, 14 Jun 2019 08:33:17 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:33:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/22] memremap: add a migrate callback to struct
 dev_pagemap_ops
Message-ID: <20190614063317.GJ7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-11-hch@lst.de> <d6916d71-c17e-74df-58f2-c28ff8044b96@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6916d71-c17e-74df-58f2-c28ff8044b96@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 04:42:07PM -0700, Ralph Campbell wrote:
> This needs to either initialize "page" or be changed to "vmf->page".
> Otherwise, it is a NULL pointer dereference.

Thanks, fixed.
