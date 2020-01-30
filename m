Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6014014DF11
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 17:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgA3Q0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 11:26:11 -0500
Received: from verein.lst.de ([213.95.11.211]:40905 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgA3Q0L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 11:26:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 07E0468B20; Thu, 30 Jan 2020 17:26:07 +0100 (CET)
Date:   Thu, 30 Jan 2020 17:26:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issues with "PCI/LINK: Report degraded links via link
 bandwidth notification"
Message-ID: <20200130162606.GB6377@lst.de>
References: <20200115221008.GA191037@google.com> <20200120023326.GA149019@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120023326.GA149019@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 19, 2020 at 08:33:26PM -0600, Bjorn Helgaas wrote:
> NVMe, GPU folks, do your drivers or devices change PCIe link
> speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
> the PCI core interprets changes like that as problems that need to be
> reported.

The NVMe driver doesn't.  For devices I don't know of any, but Ican't
find anything in the spec that would forbid it.
