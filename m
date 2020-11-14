Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E622B311E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 23:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKNWKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 17:10:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42181 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKNWKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Nov 2020 17:10:00 -0500
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=[192.168.0.209])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ke3k4-0006jr-3q; Sat, 14 Nov 2020 22:09:56 +0000
Subject: Re: [PATCH][V2] PCI: Fix a potential uninitentional integer overflow
 issue
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20201114215329.GA1197070@bjorn-Precision-5520>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <69ad6ee1-60d5-61e1-8c07-fc81e9425722@canonical.com>
Date:   Sat, 14 Nov 2020 22:09:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201114215329.GA1197070@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/11/2020 21:53, Bjorn Helgaas wrote:
> [+cc Dan]
> 
> On Tue, Nov 10, 2020 at 10:10:48PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The shift of 1 by align_order is evaluated using 32 bit arithmetic
>> and the result is assigned to a resource_size_t type variable that
>> is a 64 bit unsigned integer on 64 bit platforms. Fix an overflow
>> before widening issue by making the 1 a ULL.
>>
>> Addresses-Coverity: ("Unintentional integer overflow")
>> Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Applied to pci/misc for v5.11 with Logan's Reviewed-by and also the
> Fixes: correction.
> 
> I first applied the patch below to bounds-check the alignment as noted
> by Dan.
> 
>> ---
>>
>> V2: Use ULL instead of BIT_ULL(), fix spelling mistake and capitalize first
>>     word of patch subject.
>>
>> ---
>>  drivers/pci/pci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 3ef63a101fa1..248044a7ef8c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6214,7 +6214,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>  			if (align_order == -1)
>>  				align = PAGE_SIZE;
>>  			else
>> -				align = 1 << align_order;
>> +				align = 1ULL << align_order;
>>  			break;
>>  		} else if (ret < 0) {
>>  			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
> 
> commit d6ca242c448f ("PCI: Bounds-check command-line resource alignment requests")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Nov 5 14:51:36 2020 -0600
> 
>     PCI: Bounds-check command-line resource alignment requests
>     
>     32-bit BARs are limited to 2GB size (2^31).  By extension, I assume 64-bit
>     BARs are limited to 2^63 bytes.  Limit the alignment requested by the
>     "pci=resource_alignment=" command-line parameter to 2^63.
>     
>     Link: https://lore.kernel.org/r/20201007123045.GS4282@kadam
>     Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8b9bea8ba751..26c1b2d0bacd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6197,19 +6197,21 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  	while (*p) {
>  		count = 0;
>  		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
> -							p[count] == '@') {
> +		    p[count] == '@') {
>  			p += count + 1;
> +			if (align_order > 63) {
> +				pr_err("PCI: Invalid requested alignment (order %d)\n",
> +				       align_order);
> +				align_order = PAGE_SHIFT;
> +			}
>  		} else {
> -			align_order = -1;
> +			align_order = PAGE_SHIFT;
>  		}
>  
>  		ret = pci_dev_str_match(dev, p, &p);
>  		if (ret == 1) {
>  			*resize = true;
> -			if (align_order == -1)
> -				align = PAGE_SIZE;
> -			else
> -				align = 1 << align_order;
> +			align = 1 << align_order;
>  			break;
>  		} else if (ret < 0) {
>  			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
> 

Thanks.
