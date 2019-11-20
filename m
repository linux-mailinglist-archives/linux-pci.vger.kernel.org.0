Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95E10445D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfKTTcc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 14:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfKTTcc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 14:32:32 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D4820715;
        Wed, 20 Nov 2019 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574278351;
        bh=b3qJemuygSOHQEtvC3bNqqipcwfplG1GcI0t5RyJZRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LxOhsLrBbDLVJAtnner/OZ/2C00+vtavCsvxNCt3t+fAKZVU3uNwWR8L/aaQgzoWx
         kdFgSoxeDUfJC5Dm8VfwclUN1ziMsoDX+T9BG808CeFORefSJUGgpAbPstk7MFTKzv
         NgtVq2R7IOmAVcnBd4wh7RsIcGr6xB1malqjBpv0=
Date:   Wed, 20 Nov 2019 13:32:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when IOMMU is turned on
Message-ID: <20191120193228.GA103670@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3b56dd-7088-e544-6628-01506f7b84e8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

Hi James,

Thanks for the patch, and thanks, Dmitry for the cc!

"scripts/get_maintainer.pl -f drivers/pci/quirks.c" will give you a
list of relevant email addresses to post patches.  It was a good idea
to augment that list with related addresses, e.g., Logan and the iommu
list.

Follow existing style for subject, e.g.,

  PCI: Add DMA alias quirk for Microsemi Switchtec NTB

for a recent similar patch.

On Wed, Nov 20, 2019 at 05:48:45PM +0000, Dmitry Safonov wrote:
> On 11/5/19 12:17 PM, James Sewart wrote:
> >> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
> >>
> >> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
> >> PCI devices. The devfn for a transaction is used as an index into a lookup table
> >> storing the origin of a transaction on the other side of the bridge.
> >>
> >> This patch aliases all possible devfn's to the NTB device so that any transaction
> >> coming in is governed by the mappings for the NTB.
> >>
> >> Signed-Off-By: James Sewart <jamessewart@arista.com>

Conventionally capitalized as:

  Signed-off-by: James Sewart <jamessewart@arista.com>

> >> ---
> >> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
> >> 1 file changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 320255e5e8f8..647f546e427f 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> >> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> >> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> >>
> >> +/*
> >> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
> >> + * are used to forward responses to the originator on the other side of the
> >> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
> >> + * turned on.
> >> + */
> >> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)

Conventional style is all lower-case (e.g.
quirk_switchtec_ntb_dma_alias()) for function and variable names, and
upper-case in English text.

> >> +{
> >> +	if (!pdev->dma_alias_mask)
> >> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> >> +					      sizeof(long), GFP_KERNEL);
> >> +	if (!pdev->dma_alias_mask) {
> >> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");

pci_warn()

> >> +		return;
> >> +	}
> >> +
> >> +	// PLX NTB may use all 256 devfns
> >> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);

Use C (not C++) comment style, as the rest of the file does.

I was about to suggest using pci_add_dma_alias(), but as currently
implemented that would generate 256 messages in dmesg, which seems
like overkill.

But I think it would still be good to allocate the mask the same way
(using bitmap_zalloc()) and to set the bits using bitmap_set().

It would also be nice to have one line in dmesg about these aliases,
as a hint when debugging IOMMU faults.

> >> +}
> >> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, quirk_PLX_NTB_dma_alias);
> >> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, quirk_PLX_NTB_dma_alias);
> >> +
> >> /*
> >>  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
> >>  * not always reset the secondary Nvidia GPU between reboots if the system
