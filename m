Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8724764EB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 22:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhLOVvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 16:51:55 -0500
Received: from ale.deltatee.com ([204.191.154.188]:34998 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhLOVvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 16:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=GuxFQNSNLJReNjtJIS9Cmh4bZ5NKV9u+LJA0YjgO5lE=; b=B4zTSUHoDTrzGOCncS80uplmng
        4GBfY8AVbAmCod+d8qhXvmAHZ0k2ksUIo2jaNCdLcfhn1hHjjzPH8VdGAgbyMuR+/3ekCAYNzi8Gg
        qxJlSumPWFasG8S68jEcLZFmbUpyq6H/ZxnRzkTAw/zFlOG80gIUIUc6sM7jDx/3rHOGUXhywNZdh
        wmYn4r4eICMdI4XALI5n6AFIItcAveq8UQeSweeZCX5satlidfER3R812zBj4IheFRsUa0Q6z8Dc2
        KHibwtfepjoQKwYTiYnA4Q0hySrHz9zzpgJdMpEmUGqgQlCbo9/flnc0ZHmIDQfaeiVbVv2t0IWdC
        U07+/Z5g==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mxcBk-005ffJ-Ig; Wed, 15 Dec 2021 14:51:53 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
References: <20211215214721.GA715509@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3043c3ab-2b0a-4e97-ac43-21e4398d08e6@deltatee.com>
Date:   Wed, 15 Dec 2021 14:51:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215214721.GA715509@bhelgaas>
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



On 2021-12-15 2:47 p.m., Bjorn Helgaas wrote:
> On Wed, Dec 15, 2021 at 02:37:51PM -0700, Logan Gunthorpe wrote:
>> On 2021-12-15 10:35 a.m., Bjorn Helgaas wrote:
>>> Maybe we need a MAINTAINERS entry for P2PDMA?
>>
>> I'm not opposed to this. Would it be a duplicate of the PCI SUBSYSTEM
>> just with my name added as maintainer? I could send a patch if so.
> 
> Maybe something like this?  Are there other relevant files?  I just
> want to make sure that you see updates to p2pdma stuff.

Largely looks good to me.

The one missing file is:

Documentation/driver-api/pci/p2pdma.rst

Do you want me to put that in a patch or will you handle it?

Thanks,

Logan
