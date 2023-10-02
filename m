Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD137B5A98
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjJBSqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJBSqX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 14:46:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD5E4;
        Mon,  2 Oct 2023 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=pHRwcTMtYqZ00aS53hi/hxRGP9MoFIyEpBDBgDayrDk=; b=VAGmYhxZgzG/xEQ2bQGpeBFS08
        cxrhvs+dLJDiPVQ+ZmKy76VOWIj8NHxJAstgUSb5XSXIRmPs33f6xGSsiPbuzKDuE0f7/3lr2HS9p
        ThLZKmKqppB1KJxPiwmepTWtNA6eNnAkYHoYLThHE8qy7VBYLe6ba/4Wj7h+tah2JAuWU7JoAbQye
        EMLGW12ZSc0ZC6jczyztymEp+VweAMQfHK2LMbeXYkEw2LLkxU7/OFrYsgLovGnhIWYEs/7czwKDP
        x5QM3c5ykhPUKyrnsfNY3Z8AcFioz8hUZKZzlTPACVURHPfaFyaSBUolZNWt0ZAJswuzrZYFk53k6
        ux8Q0yGQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qnNvh-002n7O-6j; Mon, 02 Oct 2023 12:46:09 -0600
Message-ID: <e76ff7de-8c42-4393-36e2-b37ffcb58149@deltatee.com>
Date:   Mon, 2 Oct 2023 12:46:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-CA
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZRnf6wVOu0IJQ2Ok@work>
 <29da763d-1570-7197-2d5a-03c5659b8b52@deltatee.com>
 <734c7fdf-4c41-2890-dbe7-ddb23fd6bcc7@embeddedor.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <734c7fdf-4c41-2890-dbe7-ddb23fd6bcc7@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: gustavo@embeddedor.com, gustavoars@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH][next] PCI/P2PDMA: Fix undefined behavior bug in struct
 pci_p2pdma_pagemap
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-10-02 12:40, Gustavo A. R. Silva wrote:
> 
> 
> On 10/2/23 18:07, Logan Gunthorpe wrote:
>>
>>
>> On 2023-10-01 15:08, Gustavo A. R. Silva wrote:
>>> `struct dev_pagemap` is a flexible structure, which means that it
>>> contains a flexible-array member at the bottom. This could potentially
>>> lead to an overwrite of the objects following `pgmap` in `struct
>>> pci_p2pdma_pagemap`, when `nr_range > 1`.
>>>
>>> Fix this by placing the declaration of object `pgmap` at the end of
>>> `struct pci_p2pdma_pagemap`.
>>>
>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>> ready to enable it globally.
>>>
>>> Fixes: 0afea3814358 ("PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct")
>>> Fixes: a6e6fe6549f6 ("PCI/P2PDMA: Introduce private pagemap structure")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>
>>
>> Makes sense to me, thanks.
>>
>> Although, I'm not sure the fixes tags are appropriate. The
>> flexible-array member was introduced in 5.10 (b7b3c01b19) and both the
>> "fixed" commits predate that change by a number of releases.
> 
> You're right. I'll remove those tags.
> 
>>
>> Also, it's probably worth noting in the commit message that the p2pdma
>> code hardcodes nr_ranges to 1 (in pci_p2pdma_add_resource); so there is
>> no way to actually hit any bug with the current code.
> 
> Yep. I mention that in this part "This could potentially lead to an
> overwrite of the objects following `pgmap` in `struct pci_p2pdma_pagemap`,
> when `nr_range > 1`."

Yes, but the commit message is not clear that nr_range can never be >1
in the code as it currently is.

Logan
