Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20DA50203
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 08:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfFXGQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 02:16:50 -0400
Received: from verein.lst.de ([213.95.11.211]:52606 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfFXGQu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 02:16:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A185E68AFE; Mon, 24 Jun 2019 08:16:17 +0200 (CEST)
Date:   Mon, 24 Jun 2019 08:16:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
Message-ID: <20190624061617.GA2848@lst.de>
References: <20190620051333.2235-1-drake@endlessm.com> <20190620051333.2235-3-drake@endlessm.com> <20190620061038.GA20564@lst.de> <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 04:11:26PM +0800, Daniel Drake wrote:
> On Thu, Jun 20, 2019 at 2:11 PM Christoph Hellwig <hch@lst.de> wrote:
> > The Linux NVMe driver will deal with NVMe as specified plus whatever
> > minor tweaks we'll need for small bugs.  Hiding it behind an AHCI
> > device is completely out of scope and will not be accepted.
> 
> Do you have any new suggestions for alternative ways we can implement
> support for this storage configuration?

IFF we want to support it it has to be done at the PCIe layer.  But
even that will require actual documentation and support from Intel.

If Intel still believes this scheme is their magic secret to control
the NVMe market and give themselves and unfair advantage over their
competitors there is not much we can do.
