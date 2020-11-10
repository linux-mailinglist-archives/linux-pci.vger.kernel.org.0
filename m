Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE02AE47A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 00:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgKJXzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 18:55:44 -0500
Received: from ale.deltatee.com ([204.191.154.188]:47818 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJXzo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 18:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CemXXlpsOMiyxV9KdJOMOb00+hwTcrKC8bryO5FGpJQ=; b=qWwyU5J1VNmv3RUV8GoilaFpTi
        QuaGEq0gvt+UwTKG1hH9guguo7cit8ihhBZS02oRsG8JOsidQ5iy7SKKvxQau+GpFOG0w1hmrYvPP
        Bh9mJNGCDs7+q9LU5KQNWHCDOVH+8iAm+32vreXEjdgrZ+I/MeprJN8vXSVbADvdUxWHAAx0fJ9qB
        n70UNf7p2qt6x0SyIOmBWlidwkiSxNMaYqH52bAWe+rE0PkGtNhukyn3gQxqWHkr1GUJ0mbmLb3ax
        vIvNOnVZRR2nlQ3JF2EAX9V+LtlVU4Hp4XGIstGIHa8V1e39ZJQUgReLmXTbQoHvgDHmr7M+/iCYV
        Yd0eJDCg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kcdUE-0000tZ-31; Tue, 10 Nov 2020 16:55:43 -0700
To:     Colin King <colin.king@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201110221048.3411288-1-colin.king@canonical.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aaa8ae87-170b-ada0-0465-9727967594cb@deltatee.com>
Date:   Tue, 10 Nov 2020 16:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110221048.3411288-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org, christian.koenig@amd.com, alex.williamson@redhat.com, sbates@raithlin.com, bhelgaas@google.com, colin.king@canonical.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH][V2] PCI: Fix a potential uninitentional integer overflow
 issue
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-11-10 3:10 p.m., Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The shift of 1 by align_order is evaluated using 32 bit arithmetic
> and the result is assigned to a resource_size_t type variable that
> is a 64 bit unsigned integer on 64 bit platforms. Fix an overflow
> before widening issue by making the 1 a ULL.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")

I think this should probably be

Fixes: 32a9a682bef2 ("PCI: allow assignment of memory resources with a
specified alignment")

That is the commit where the original bug was introduced. 644a544fd9bcd
then extends the code a little bit and 07d8d7e57c28 only refactors it
into a reusable function. If we want this in older stable kernels then
we will probably need to make different patches for the other two vintages.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Besides that, the change makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
