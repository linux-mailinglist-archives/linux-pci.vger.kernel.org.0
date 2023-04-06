Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85E6D9C7E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbjDFPgp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 6 Apr 2023 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbjDFPgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 11:36:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE27EDC
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 08:36:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-29-UuMCYDyaOwWGz8MYzNkIwA-1; Thu, 06 Apr 2023 16:36:38 +0100
X-MC-Unique: UuMCYDyaOwWGz8MYzNkIwA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 6 Apr
 2023 16:36:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 6 Apr 2023 16:36:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bjorn Helgaas' <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
Thread-Topic: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
Thread-Index: AdlodgFkFYa3Wd45RlGJwWEgKJXFDwAGyW4AAALDCHA=
Date:   Thu, 6 Apr 2023 15:36:36 +0000
Message-ID: <be2acdf424b74d948c3ff45093dc6332@AcuMS.aculab.com>
References: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
 <20230406150742.GA3703273@bhelgaas>
In-Reply-To: <20230406150742.GA3703273@bhelgaas>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas
> Sent: 06 April 2023 16:08
> 
> [+cc linux-pci, regressions]
> 
> On Thu, Apr 06, 2023 at 11:05:14AM +0000, David Laight wrote:
> > The change in bab65e48cb064 breaks pci_enable_msix_range().
> > The intent is to optimise the sanity checks, but it is
> > somewhat overenthusiastic.
> >
> > The interface allows you to ask for a lot of vectors and
> > returns the number that were allocated.
> > However, after the change, you can't request a vector
> > that is higher than the largest the hardware supports.
> > Which makes that rather pointless.
> >
> > So code like:
> > 	for (i = 0; i < 16; i++)
> > 		msix_tbl[i].entry = i;
> > 	nvec = pci_enable_msix_range(dev, msix_tbl, 1, 16);
> > Now returns -22 if the hardware only supports 8 interrupts.
> >
> > Previously it returned 8.
> >
> > I can fix my driver, but I suspect that any code that relies
> > on a smaller number of vectors being returned is now broken.
> 
> Thanks for the report!  bab65e48cb06 ("PCI/MSI: Sanitize MSI-X
> checks") appeared in v6.2-rc1, so this is a recent regression and it
> would be good to fix it for v6.3.

I do try to test every release at around rc3.

> bab65e48cb06 only touches drivers/pci/msi/msi.c, but since it didn't
> go through the PCI tree, I'll let Thomas handle any revert (or better,
> an improvement to pci_msix_validate_entries()) since he wrote and
> applied the original.

Looking it:

static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries,
				      int nvec, int hwsize)
{
	bool nogap;
	int i, j;

	if (!entries)
		return true;

	nogap = pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGACY);

	for (i = 0; i < nvec; i++) {
		/* Entry within hardware limit? */
		if (entries[i].entry >= hwsize)
			return false;

		/* Check for duplicate entries */
		for (j = i + 1; j < nvec; j++) {
			if (entries[i].entry == entries[j].entry)
				return false;
		}
		/* Check for unsupported gaps */
		if (nogap && entries[i].entry != i)
			return false;
	}
	return true;
}

It probably needs to return an updated 'nvec'.
The gap/duplicate check is also a bit horrid, why not:
		if (nogap) {
			if (entries[i].entry != i)
				return false;
			continue;
		}

		if (!i || entries[i].entry > entries[i - 1].entry)
			continue;

		horrid, expensive loop...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

