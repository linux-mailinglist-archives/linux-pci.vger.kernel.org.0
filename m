Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A042C8AE1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgK3RYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 12:24:44 -0500
Received: from verein.lst.de ([213.95.11.211]:45231 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387484AbgK3RYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 12:24:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA34C6736F; Mon, 30 Nov 2020 18:24:01 +0100 (CET)
Date:   Mon, 30 Nov 2020 18:24:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tom Yan <tom.ty89@gmail.com>, Christoph Hellwig <hch@lst.de>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma()
 to scsi_add_host()
Message-ID: <20201130172401.GA1735@lst.de>
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com> <20201128154849.3193-1-tom.ty89@gmail.com> <20201128154849.3193-2-tom.ty89@gmail.com> <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com> <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com> <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com> <X8T0E2qvF2cgADl+@kroah.com> <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com> <20201130172004.GA966032@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130172004.GA966032@rowland.harvard.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 12:20:04PM -0500, Alan Stern wrote:
> > https://lore.kernel.org/linux-usb/fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com/T/#t
> 
> It's hard to go wrong with reverting, so it's okay with me.
> 
> Still, Hans, have you checked out the difference between the 
> scsi_add_host() and scsi_add_host_with_dma() calls?  It's just a matter 
> of using dev vs. sysdev.  In particular, have you checked to see what 
> those two devices are on your system?
> 
> It seems likely that if one of those calls messes up some DMA settings, 
> the other one does too -- just maybe not settings that matter much.

The effects from scsi_add_host_with_dma should be:

 (1) picking which device is used for the SCSI dma map helpers
 (2) use dma_max_mapping_size() to limite the I/O size

The helpers affected by (1) are not used by UAS (or usb-storage for that
matter), while we do have a real bug in the intel-iommu with bounce
buffering implementation used in the bug report.  So my clear bet is on
(2) not limiting the size, but the patch that would have fixed this
did not make a different for Hans, which leaves me a little confused.
