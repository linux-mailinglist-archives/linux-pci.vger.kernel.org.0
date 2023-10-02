Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1447B5A67
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjJBSks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 14:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjJBSkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 14:40:47 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7809F1
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 11:40:39 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id nLq2qA4lsnGhUnNqOqjZhF; Mon, 02 Oct 2023 18:40:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id nNqNqGgrOT6hQnNqNqdPyj; Mon, 02 Oct 2023 18:40:35 +0000
X-Authority-Analysis: v=2.4 cv=FIIIesks c=1 sm=1 tr=0 ts=651b0ea3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=gXLdhW2jAAAA:8 a=MqvWAp6GOtdlVlTrVWUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=Dn9eIPSr_RzuO0KTJioD:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7ClwwiYL5MaAd6g9xWmRVME3vEiVZ83RtKSsFLeZH90=; b=aD+wgnXlbRDuzRcV2OZazjH5P4
        AqpZWHdIkg+cjMYqvbj8Vr1+wq0saI3cAHD/iPUBuk5J50iVbJFNZoGGu7vihEjTHEOmETr74aR9r
        pEMGfTzUr+DIc4LwYoiz7+MxyON0MbHV7vRAtNLw/sfZeTnaxSRlg0feSY7l+xTOGWRejO3g2TnmE
        l77Bp06LIg+h8JTnqgpTPKWX1b99Szb/E1fEDJx5dmTl95llZ3yYeGXW/UGc/WpW6mf5MRWapj7O3
        38yTTPShFZCJugG27W/tXCcJHTxeuV7jkL8vGxqlW6z3IBhfGXtSElCkI+6UeyR9h2Mfoqj8FyHLT
        Jj0YvC6g==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:41648 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnNqM-003NdX-1u;
        Mon, 02 Oct 2023 13:40:34 -0500
Message-ID: <734c7fdf-4c41-2890-dbe7-ddb23fd6bcc7@embeddedor.com>
Date:   Mon, 2 Oct 2023 20:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH][next] PCI/P2PDMA: Fix undefined behavior bug in struct
 pci_p2pdma_pagemap
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZRnf6wVOu0IJQ2Ok@work>
 <29da763d-1570-7197-2d5a-03c5659b8b52@deltatee.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <29da763d-1570-7197-2d5a-03c5659b8b52@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qnNqM-003NdX-1u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:41648
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJZWysl4KZmCgwHaMI6+55BNQ6xXsm9Fk2vc2+ws+lVhRNyMK3KZgE+CVYFO7hxckNilL46caF34u1OBK4kS65Aeg/LmwH7H2m9WqFdU4zgCgF3RwMeR
 LfkxsyvpzpILBzWsNiiRDmtQPSb9eHlpdhuM1pCUTz1ZhwT8WjJfjBkNL7e+KkAiCUH8EnO9LKWiPZW3ZbsJuxnFcHqI14DnNH8=
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/2/23 18:07, Logan Gunthorpe wrote:
> 
> 
> On 2023-10-01 15:08, Gustavo A. R. Silva wrote:
>> `struct dev_pagemap` is a flexible structure, which means that it
>> contains a flexible-array member at the bottom. This could potentially
>> lead to an overwrite of the objects following `pgmap` in `struct
>> pci_p2pdma_pagemap`, when `nr_range > 1`.
>>
>> Fix this by placing the declaration of object `pgmap` at the end of
>> `struct pci_p2pdma_pagemap`.
>>
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> Fixes: 0afea3814358 ("PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct")
>> Fixes: a6e6fe6549f6 ("PCI/P2PDMA: Introduce private pagemap structure")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> 
> Makes sense to me, thanks.
> 
> Although, I'm not sure the fixes tags are appropriate. The
> flexible-array member was introduced in 5.10 (b7b3c01b19) and both the
> "fixed" commits predate that change by a number of releases.

You're right. I'll remove those tags.

> 
> Also, it's probably worth noting in the commit message that the p2pdma
> code hardcodes nr_ranges to 1 (in pci_p2pdma_add_resource); so there is
> no way to actually hit any bug with the current code.

Yep. I mention that in this part "This could potentially lead to an
overwrite of the objects following `pgmap` in `struct pci_p2pdma_pagemap`,
when `nr_range > 1`."

> 
> I totally agree that the patch should be applied to prevent possible
> bugs being introduced in the future:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for the RB and the feedback. :)
--
Gustavo
