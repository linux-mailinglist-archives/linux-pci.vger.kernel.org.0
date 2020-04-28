Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349891BB5B5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 07:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgD1FNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 01:13:16 -0400
Received: from verein.lst.de ([213.95.11.211]:53676 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgD1FNQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 01:13:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B715168C7B; Tue, 28 Apr 2020 07:13:12 +0200 (CEST)
Date:   Tue, 28 Apr 2020 07:13:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Message-ID: <20200428051312.GB17146@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 05:32:12PM -0700, David E. Box wrote:
> NVMe storage power management during suspend-to-idle, particularly on
> laptops, has been inconsistent with some devices working with D3 while
> others must rely on NVMe APST in order for power savings to be realized.
> Currently the default is to use APST unless quirked to do otherwise.
> However newer platforms, like Intel Comet Lake systems, may require NVMe
> drives to use D3 in order for the PCIe ports to be properly power managed.
> To make it easier for drivers to choose, these platforms may supply a
> special "StorageD3Enable" _DSD property under the root port that the device
> is attached to. If supplied, the driver must use D3 in order for the
> platform to realize the deepest power savings in suspend-to-idle.
>     
> The first patch adds the new _DSD GUID and fowards the property through the
> pci/acpi layer to the pci device.
> 
> The second patch adds support for the property to the nvme driver.

I'm not sure who came up with the idea to put this into ACPI, but it
belongs into NVMe.  Please talk to the NVMe technical working group
instead of trying to overrules them in an unrelated group that doesn't
apply to all of PCIe.
