Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93489270ED
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEVUlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 16:41:24 -0400
Received: from ale.deltatee.com ([207.54.116.67]:52802 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbfEVUlY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 16:41:24 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.141])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hTY33-0003ne-TI; Wed, 22 May 2019 14:41:18 -0600
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
Date:   Wed, 22 May 2019 14:41:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, Christian.Koenig@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-05-22 2:30 p.m., Koenig, Christian wrote:
> Hi Logan,
> 
> Am 22.05.2019 22:12 schrieb Logan Gunthorpe <logang@deltatee.com>:
> 
>     [CAUTION: External Email]
> 
>     Presently, there is no path to DMA map P2PDMA memory, so if a TLP
>     targeting this memory hits the root complex and an IOMMU is present,
>     the IOMMU will reject the transaction, even if the RC would support
>     P2PDMA.
> 
>     So until the kernel knows to map these DMA addresses in the IOMMU,
>     we should not enable the whitelist when an IOMMU is present.
> 
> 
> Well NAK, cause that is exactly what we are doing.

Are you DMA-mapping the addresses outside the P2PDMA code? If so there's 
a huge mismatch with the existing users of P2PDMA (nvme-fabrics). If 
you're not dma-mapping then I can't see how it could work because the 
IOMMU should reject any requests to access those addresses.

By adding the whitelist in this way you will break any user that 
attempts to use P2P in nvme-fabrics on whitelisted RCs with an IOMMU 
enabled.

Currently, the users of P2PDMA use pci_p2pdma_map_sg() which only 
returns the PCI bus address. If P2PDMA transactions can now go through 
an IOMMU, then this is wrong and broken.

We need to ensure that all users of P2PDMA map this memory in the same 
way. Which means, if the TLPs will go through an IOMMU they get 
dma-map'd and, if they don't, they use the PCI Bus address (as the 
current code does).

Without the change proposed in this patch, I have to retract my review 
and NAK your patch until we can sort out the mapping issues.

Logan
