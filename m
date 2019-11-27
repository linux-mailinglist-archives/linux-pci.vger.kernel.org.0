Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5201E10B4A2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfK0Riv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 12:38:51 -0500
Received: from ale.deltatee.com ([207.54.116.67]:57182 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0Riv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Nov 2019 12:38:51 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ia1H3-0003xR-Id; Wed, 27 Nov 2019 10:38:46 -0700
To:     James Sewart <jamessewart@arista.com>, linux-pci@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
Date:   Wed, 27 Nov 2019 10:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: helgaas@kernel.org, alex.williamson@redhat.com, dima@arista.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, 0x7f454c46@gmail.com, hch@infradead.org, linux-pci@vger.kernel.org, jamessewart@arista.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-27 6:27 a.m., James Sewart wrote:
>   * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
>   * which is used to program permissible bus-devfn source addresses for DMA
> @@ -5873,8 +5874,12 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * cannot be left as a userspace activity).  DMA aliases should therefore
>   * be configured via quirks, such as the PCI fixup header quirk.
>   */
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, int nr_devfns)
>  {
> +	int devfn_to = devfn_from + nr_devfns - 1;
> +
> +	BUG_ON(nr_devfns < 1);

Why not just make nr_devfns unsigned and do nothing if it's zero? It
might also be worth checking that nr_devfns + devfn_from is less than
U8_MAX... But I'd probably avoid the BUG_ON and just truncate it.

Logan
