Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30110D941
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfK2R6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 12:58:25 -0500
Received: from ale.deltatee.com ([207.54.116.67]:36434 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfK2R6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Nov 2019 12:58:25 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iakX3-0000J2-H1; Fri, 29 Nov 2019 10:58:18 -0700
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
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
 <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
 <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <20f1dbe3-0349-86b6-ca98-f284d34753b7@deltatee.com>
Date:   Fri, 29 Nov 2019 10:58:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
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
Subject: Re: [PATCH v5 1/3] PCI: Fix off by one in dma_alias_mask allocation
 size
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-29 10:56 a.m., James Sewart wrote:
> The number of possible devfns is 256 so the size of the bitmap for
> allocations should be U8_MAX+1.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>

Looks good to me. Thanks! For the whole series:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/pci/pci.c    | 2 +-
>  drivers/pci/search.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..0a4449a30ace 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5876,7 +5876,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
>  	if (!dev->dma_alias_mask)
> -		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
> +		dev->dma_alias_mask = bitmap_zalloc(U8_MAX+1, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
>  		pci_warn(dev, "Unable to allocate DMA alias mask\n");
>  		return;
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bade14002fd8..b3633af1743b 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -43,7 +43,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	if (unlikely(pdev->dma_alias_mask)) {
>  		u8 devfn;
>  
> -		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
> +		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX+1) {
>  			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
>  				 data);
>  			if (ret)
> 
