Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB62C22E3
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 11:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgKXK1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 05:27:18 -0500
Received: from verein.lst.de ([213.95.11.211]:53857 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbgKXK1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Nov 2020 05:27:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8AE1867373; Tue, 24 Nov 2020 11:27:15 +0100 (CET)
Date:   Tue, 24 Nov 2020 11:27:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: 5.10 regression, many XHCI swiotlb buffer is full / DMAR:
 Device bounce map failed errors on thunderbolt connected XHCI
 controller
Message-ID: <20201124102715.GA16983@lst.de>
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com> <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 23, 2020 at 03:49:09PM +0100, Hans de Goede wrote:
> Hi,
> 
> +Cc Christoph Hellwig <hch@lst.de>
> 
> Christoph, this is still an issue, so I've been looking around a bit and think this
> might have something to do with the dma-mapping-5.10 changes.
> 
> Do you have any suggestions to debug this, or is it time to do a git bisect
> on this before 5.10 ships with regression?

Given that DMAR prefix this seems to be about using intel-iommu + bounce
buffering for external devices.  I can't really think of anything specific
in 5.10 related to that, so maybe you'll need to bisect.

I doub this means we are actually leaking swiotlb buffers, so while
I'm pretty sure we broke something in lower layers this also means
xhci doesn't handle swiotlb operation very gracefully in general.
