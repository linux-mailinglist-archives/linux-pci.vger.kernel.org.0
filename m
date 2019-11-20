Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95B510448D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 20:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKTTtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 14:49:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfKTTtu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 14:49:50 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983292068F;
        Wed, 20 Nov 2019 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574279389;
        bh=8OdhdfUvBh8yeItPx5lvDqJRDQbjk4jNjuLGV67HFng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GbZyyAeiPOGuUe8N9Fv82aD0Pxho+dCO/gqZASt0YMaHyTmsnepyhPWHi4F6E3Phf
         jUAFSXAIM8P2hprpRslh8ToPol8KmKVsY2+p5MB2UQYj0IOa6HKnCafT5bzsdT8K7l
         IksCj4JrRGuMlqVJRFKXNX+7eQdIEjpVSf5J3B1A=
Date:   Wed, 20 Nov 2019 13:49:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when IOMMU is turned on
Message-ID: <20191120194948.GA117003@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c683ec65-40a9-6430-ae85-ce3934ed8af5@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 12:30:48PM -0700, Logan Gunthorpe wrote:
> On 2019-11-20 10:48 a.m., Dmitry Safonov wrote:
> > On 11/5/19 12:17 PM, James Sewart wrote:
> >>
> >>> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
> >>>
> >>> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
> >>> PCI devices. The devfn for a transaction is used as an index into a lookup table
> >>> storing the origin of a transaction on the other side of the bridge.
> >>>
> >>> This patch aliases all possible devfn's to the NTB device so that any transaction
> >>> coming in is governed by the mappings for the NTB.
> >>>
> >>> Signed-Off-By: James Sewart <jamessewart@arista.com>
> >>> ---
> >>> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
> >>> 1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>> index 320255e5e8f8..647f546e427f 100644
> >>> --- a/drivers/pci/quirks.c
> >>> +++ b/drivers/pci/quirks.c
> >>> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> >>> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> >>> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> >>>
> >>> +/*
> >>> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
> >>> + * are used to forward responses to the originator on the other side of the
> >>> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
> >>> + * turned on.
> >>> + */
> >>> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
> >>> +{
> >>> +	if (!pdev->dma_alias_mask)
> >>> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> >>> +					      sizeof(long), GFP_KERNEL);
> >>> +	if (!pdev->dma_alias_mask) {
> >>> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	// PLX NTB may use all 256 devfns
> >>> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);
> 
> I think it would be better to create a pci_add_dma_alias_range()
> function instead of directly accessing dma_alias_mask. We could then use
> that function to clean up quirk_switchtec_ntb_dma_alias() which is
> essentially doing the same thing.

Great idea!

Bjorn
