Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C5594C0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 09:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfF1HXS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 03:23:18 -0400
Received: from verein.lst.de ([213.95.11.210]:45860 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbfF1HXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jun 2019 03:23:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A014E68CFE; Fri, 28 Jun 2019 09:23:10 +0200 (CEST)
Date:   Fri, 28 Jun 2019 09:23:10 +0200
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
Message-ID: <20190628072310.GA28896@lst.de>
References: <20190620051333.2235-1-drake@endlessm.com> <20190620051333.2235-3-drake@endlessm.com> <20190620061038.GA20564@lst.de> <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com> <20190624061617.GA2848@lst.de> <CAD8Lp464B0dOd+ayF_AK4DRzHEpiaSbUOXjVJ5bq5zMXq=BBKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp464B0dOd+ayF_AK4DRzHEpiaSbUOXjVJ5bq5zMXq=BBKQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 11:51:28AM +0800, Daniel Drake wrote:
> Bearing in mind that we've already been told that the NVMe device
> config space is inaccessible, and the new docs show exactly how the
> BIOS enforces such inaccessibility during early boot, the remaining
> points you mentioned recently were:

If we can't access the config space we unfortunately can't support
this scheme at all, as it invalidates all our quirks handling.
