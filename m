Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143AA47DC5C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 01:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbhLWAux (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 19:50:53 -0500
Received: from ale.deltatee.com ([204.191.154.188]:41476 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbhLWAuw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 19:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=2dF1CFJJey1d0BzeLcah2Hg/8NGRiEzQ3KICdfa8L5Q=; b=pjGmoQ3K7DykwUMfWNfA/s4/5C
        O6CA7DIod++AUg1YF6L1aGGMaFycRbFROBT2NWhGh0IeYBsKsNr6sCxpH23KtZONNBu4IboVk35L/
        yX4nkprn+F8TRDQ3ukdcyYkZxZsZKRzJIc15SDWfekMFRZFrxMsq1PeqUnggnKy7hvam0/eP3jWXy
        aJaMTUNa/5lSzUcZXI8iotcJ0X7VuWTjSqwz6IQDxDwQ9pfPVWlrivEVAD37RWz11ReTnDBb6UOLQ
        gxQQ2kAqBJLDlTJZTQU+2NURfp7xaNQ1SGCSUjatnOGQMZFE7wo517vbYRhADaFaAjI/p4RSWw65v
        4i8m4lyA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1n0CJj-00BQTy-FU; Wed, 22 Dec 2021 17:50:48 -0700
To:     Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>
References: <20211223004802.18184-1-rdunlap@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <db287ffb-0599-6d5a-bf03-fbaad19377ba@deltatee.com>
Date:   Wed, 22 Dec 2021 17:50:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211223004802.18184-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jdmason@kudzu.us, linux-ntb@googlegroups.com, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, rdunlap@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] ntb_hw_switchtec: fix the spelling of "its"
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-12-22 5:48 p.m., Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction "it's" (it is)
> in user messages.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> 

Oh, yup, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Though this patch should have been sent to the NTB list as changes to
that file go through there. (I've cced that list and the maintainer Jon,
but the original patch might need a resend).

Logan

