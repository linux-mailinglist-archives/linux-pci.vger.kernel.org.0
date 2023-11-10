Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39777E85DE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 23:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjKJWuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 17:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJWuC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 17:50:02 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A060C125
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 14:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=ENslX0mBD3/hDJpEC6EHBmuTSKpY7C+IN7aGsX5Ti1A=; b=TmOxQV7Uus3ceZ26aebHr/DK81
        xEWJRoMt7EK2CCdGpRiDlKwEu5+guYeSMLLBqVkK6nljizaNuvznW+VnFCJoYTl63uLE044xI9m55
        RX12F8/jwiXR6tzuBycJrSqx7VaHgCju2QuGwGlUYFEd8Wea5CuKfi/3xrqAt8QeuB888ar/ie8iD
        owLGPhUW6VALcGqIJQ4+EMQdMtKVZN/zsRlrJZUB8xnIpkj8FLkxIKgh6F+rZRmoQBcXwjYZqU3Pb
        8YaxUFplAfMvd9kLe7FPxfCj1Ibt1odYuzPH5+TZcFj7PtJIOlUKo3DO5WPn5UY8NbNC/er/bvOO3
        rldeoy6w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1r1aK3-002GaG-W9; Fri, 10 Nov 2023 15:49:57 -0700
Message-ID: <3916e092-201a-401c-b6f9-e3a5732308b0@deltatee.com>
Date:   Fri, 10 Nov 2023 15:49:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To:     Daniel Stodden <dns@arista.com>
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org
References: <20231110201917.89016-1-dns@arista.com>
 <20231110201917.89016-2-dns@arista.com>
 <dc15dc87-d199-4295-96b4-b972f4965bd5@deltatee.com>
 <531029E9-0321-4E5A-8C65-3378B8DCB5E2@arista.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <531029E9-0321-4E5A-8C65-3378B8DCB5E2@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dns@arista.com, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 1/1] switchtec: Fix stdev_release crash after suprise
 device loss.
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-11-10 14:30, Daniel Stodden wrote:
> 
> Hi.
> 
> [Sorry, sending this twice, again, hoping this time it won't bounce, because html]
> 
>> Nice catch, thanks!
>>
>> The solution looks good to me, though I might quibble slightly about
>> style: I'm not sure why we need two helper functions (disable_dma_mrpc()
>> and switchtec_exit_pci()) that are only called in one place. I'd
>> probably just open code both of them.
>>
>> Other than that:
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> I'm fine with it either way. I added those mainly because of the enable_dma_mrpc/switctec_init_pci
> counterparts were already there. And likewise single-use, as would be usual.
> 
> So the subroutines would maintain symmetry between probe() and remove().
> 
> So.. just don't add the new remove()-relevant ones? (One alternative would be to send another change right after,
> which goes after single-use pairs altogether.)

Ah, I see. Just because it's single use doesn't necessarily mean it's
wrong. I would say switchtec_init_pci() should not be inlined because
it's rather long and keeps switchtec_pci_probe() a little more readable.

enable_dma_mrpc() more questionable. I'm not sure why it was done that
way. Perhaps something changed.

In any case, I'm not all that concerned. If you want to leave it the way
it is, I wouldn't mind.

Thanks,

Logan
