Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716468F66F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 23:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfHOVc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 17:32:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36732 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbfHOVcZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 17:32:25 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hyNM3-0007aB-C8; Thu, 15 Aug 2019 15:32:21 -0600
To:     Bart Van Assche <bvanassche@acm.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190815212821.120929-1-bvanassche@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3dc57299-199f-4583-9b66-748a6aec059f@deltatee.com>
Date:   Thu, 15 Aug 2019 15:32:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815212821.120929-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: keith.busch@intel.com, hch@lst.de, linux-pci@vger.kernel.org, bhelgaas@google.com, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Fix a source code comment
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-08-15 3:28 p.m., Bart Van Assche wrote:
> Commit 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory"; v4.20)
> introduced the following text: "there's no way to determine whether the
> root complex supports forwarding between them." A later commit added a
> whitelist check in the function that comment applies to. Update the
> comment to reflect the addition of the whitelist check.

Thanks for the vigilant patch, but I've already got a series[1] that
cleans up most of these commits. It looks like this patch will conflict
with that series.

Logan

[1]
https://lore.kernel.org/linux-pci/20190812173048.9186-1-logang@deltatee.com/

> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/pci/p2pdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 234476226529..f719adc2b826 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -300,8 +300,8 @@ static bool root_complex_whitelist(struct pci_dev *dev)
>   * Any two devices that don't have a common upstream bridge will return -1.
>   * In this way devices on separate PCIe root ports will be rejected, which
>   * is what we want for peer-to-peer seeing each PCIe root port defines a
> - * separate hierarchy domain and there's no way to determine whether the root
> - * complex supports forwarding between them.
> + * separate hierarchy domain and there's no way other than using a whitelist
> + * to determine whether the root complex supports forwarding between them.
>   *
>   * In the case where two devices are connected to different PCIe switches,
>   * this function will still return a positive distance as long as both
> 
