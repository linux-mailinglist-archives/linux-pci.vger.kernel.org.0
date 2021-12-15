Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732C6476565
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 23:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhLOWHo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 17:07:44 -0500
Received: from ale.deltatee.com ([204.191.154.188]:35196 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhLOWHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 17:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=YPLObzydNABXK47I4VoZKcpNYeXLBeSKX7HWc2tOlYU=; b=fnhQG6MQEZFmVPPa8xA9WKMEur
        nJCrxkWoyf47BzVGcxG0jKFN7skgrxnhG+NMTdNMBlGAFenHl2RDv1pobXf1RLxWLdllnnkjKLAQF
        oSyFne0S4sNcKeeA/0l67D0S8mVUAIPa+NeFFu9fnNR7UdafHoRZb91ebL6w5efHvByU1yDrVmkwT
        qXNgG9H+PsZ1u3JWBY5oYTsrQ0AlXRlMm3nfcwqzUdD+Is9hR7LW14AcUEKt2xBtp7/F05Q9XF3qG
        yol8KJfcQlq8vv3i2zKx7IJv2w2YIIIXTiFq3i0+U3Ia/29d2toql5M6a2sNdjkuU061lc1A3T20H
        xmAsLEYg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mxcR4-005g54-Pt; Wed, 15 Dec 2021 15:07:43 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
References: <20211215220433.GA716667@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <137ba7be-b53f-eb4b-d456-2e53306d4105@deltatee.com>
Date:   Wed, 15 Dec 2021 15:07:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215220433.GA716667@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: edumazet@google.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, christophe.jaillet@wanadoo.fr, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] PCI/P2PDMA: Save a few cycles in 'pci_alloc_p2pmem()'
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-12-15 3:04 p.m., Bjorn Helgaas wrote:
> On Wed, Dec 15, 2021 at 02:51:51PM -0700, Logan Gunthorpe wrote:
>> Largely looks good to me.
>>
>> The one missing file is:
>>
>> Documentation/driver-api/pci/p2pdma.rst
>>
>> Do you want me to put that in a patch or will you handle it?
> 
> I put the patch below on pci/p2pdma for v5.17, let me know if you want
> any other tweaks.
> 
> I had mistakenly included these, which don't include any P2PDMA
> content, so I dropped them so you don't get inundated with other
> random changes:
> 
>   +F:     Documentation/PCI/
>   +F:     Documentation/devicetree/bindings/pci/

Yup, ok. Looks good to me. If you want or need my Acked-by or whatever,
you can add it:

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
