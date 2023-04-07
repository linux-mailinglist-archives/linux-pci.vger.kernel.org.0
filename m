Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2406DB06D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjDGQR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 7 Apr 2023 12:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDGQRz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 12:17:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBF11D
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 09:17:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-308-OPa1XfCHOUqjfcav9MZvBA-1; Fri, 07 Apr 2023 17:17:51 +0100
X-MC-Unique: OPa1XfCHOUqjfcav9MZvBA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 7 Apr
 2023 17:17:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 7 Apr 2023 17:17:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: PCIe cycle sequence when updating the msi-x table
Thread-Topic: PCIe cycle sequence when updating the msi-x table
Thread-Index: AdlpadQ6VkkNAoyZRj6svqE6jQb3+Q==
Date:   Fri, 7 Apr 2023 16:17:48 +0000
Message-ID: <b2d1bb86ea4642d2aa01ebd9d3d7a77e@AcuMS.aculab.com>
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

The function that updates the MSI-X table currently reads:

static inline void pci_write_msg_msix(struct msi_desc *desc, struct msi_msg *msg)
{
	void __iomem *base = pci_msix_desc_addr(desc);
	u32 ctrl = desc->pci.msix_ctrl;
	bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);

	if (desc->pci.msi_attrib.is_virtual)
		return;
	/*
	 * The specification mandates that the entry is masked
	 * when the message is modified:
	 *
	 * "If software changes the Address or Data value of an
	 * entry while the entry is unmasked, the result is
	 * undefined."
	 */
	if (unmasked)
		pci_msix_write_vector_ctrl(desc, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);

	writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
	writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
	writel(msg->data, base + PCI_MSIX_ENTRY_DATA);

	if (unmasked)
		pci_msix_write_vector_ctrl(desc, ctrl);

	/* Ensure that the writes are visible in the device */
	readl(base + PCI_MSIX_ENTRY_DATA);
}

Now I'm not 100% sure about the cycle ordering rules.
I've not got the spec here, and I recall it isn't that easy to
understand.
I can't remember whether reads are allowed to overtake writes
(to different addresses).
I do remember that reading back the same address was needed to
flush the cpu store buffer on some space cpus.
So it might be that the final readl() won't actually flush
the write to the mask register.
(The same readback of 'the wrong' address also happens elsewhere.)

But there is a bigger problem.
As the comment says writing the address/data while an entry is
unmasked must be avoided (because a mixture of the old and new
values could easily by used for the PCIe write cycle).

But it is also quite likely that that hardware checks the masked
bit before/after reading the address+data.

So masking the interrupt immediately before the update and/or
unmasking immediately after could also cause issues.

I'd suggest adding a readl() of the mask register after the disable
and moving the readl() of the data to before the enable.
The delays inherent in the PCIe reads should be enough to ensure
that the interrupt generation logic doesn't run until all the
writes are complete.

(I'm also going to have to look at our fpga to see if the
global enable/mask bits are actually exported by the pcie block.
The MSI-X logic definitely doesn't have them as inputs.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

