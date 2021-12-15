Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C631B4764B3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 22:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhLOVh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 16:37:56 -0500
Received: from ale.deltatee.com ([204.191.154.188]:34846 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhLOVh4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 16:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=jWTj3wubn/0E/EwdQLFg156OS16E/EeY/O90DwhWuc8=; b=S/EAnnK6MO/X7SIASHuxJgMs3V
        FIHpm1uuzGtao4cocaQsn80ed0jvqqUPIuSBExaeMwCl8qZzBWukIN26uAQYHOrR3Zco3njceTh8W
        yyUWXRYnYbrCvU3/SadN/J+blhTlF3SLUZEE4NwRZyxfTne/oX0YLrXgK2ExCtzObs+jiARkkKsbY
        QTL4JdcP3Rso5nICLz/C3uqbF1zwcWXf0Ii9MFAaUSEo3kk1A44SzIl7yxUGTjnqIBdLNnEwbfSts
        4PydtjWXrMgnnCv/e1RHG+iiC9OTVhgXXD/p9q3lX07i4CY5SJosq+xQ1zu/Ml4ZcedBjYF8L38VI
        orWEql3A==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mxbyC-005fWQ-GJ; Wed, 15 Dec 2021 14:37:53 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
References: <20211215173556.GA702194@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7676711-52c0-2ca4-f117-bea540d61cb1@deltatee.com>
Date:   Wed, 15 Dec 2021 14:37:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215173556.GA702194@bhelgaas>
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



On 2021-12-15 10:35 a.m., Bjorn Helgaas wrote:
> [+cc Logan, Eric]
> 
> On Wed, Nov 03, 2021 at 10:16:53PM +0100, Christophe JAILLET wrote:
>> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
>> save a few cycles when it is known that the rcu lock is already
>> taken/released.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Added Logan and Eric since Logan is the author and de facto maintainer
> of this file and Eric recently converted this to RCU.

Looks fine to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> Maybe we need a MAINTAINERS entry for P2PDMA?

I'm not opposed to this. Would it be a duplicate of the PCI SUBSYSTEM
just with my name added as maintainer? I could send a patch if so.

Logan
