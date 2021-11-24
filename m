Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2078D45B56A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 08:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbhKXHgd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 02:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241130AbhKXHga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 02:36:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D702760ED4;
        Wed, 24 Nov 2021 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637739201;
        bh=fAoZJXLu4kdGq8lV85I9ZGE3DyGUx4/jwY+1T7LxN+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVEc42WNzkV9yZzFVYiNNc8ZogMajpuGRiBxMA/VqD7GdJZ4/iwvJWRb7rauVsvD1
         kstnOrZkMKLQrVkPuiwo7m10gORNOkKCc6GHeuq60RgK/py+L6618H6Ouw3cBgRppo
         DBvNiFTc+vAgwk2AYgJ8VGPr3AVIzHiox7Wsodts=
Date:   Wed, 24 Nov 2021 08:33:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <YZ3qvtHlMkRnC74f@kroah.com>
References: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
 <20211123235557.GA2247853@bhelgaas>
 <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
 <20211124063316.GA6792@lst.de>
 <CAPcyv4ii=bjKNQxoMLF-gscJy7Bh8CUn205_1GpCwfMyJ22+6g@mail.gmail.com>
 <20211124072824.GA7738@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124072824.GA7738@lst.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 08:28:24AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> > I am missing the counter proposal in both Bjorn's and your distaste
> > for aux bus and PCIe portdrv?
> 
> Given that I've only brought in in the last mail I have no idea what
> the original proposal even is.

Neither do I :(
