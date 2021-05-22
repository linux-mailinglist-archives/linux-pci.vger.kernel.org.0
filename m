Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6438D4E7
	for <lists+linux-pci@lfdr.de>; Sat, 22 May 2021 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhEVJpL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 May 2021 05:45:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5665 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEVJpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 May 2021 05:45:11 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnJPf3jwNz1BQ0c;
        Sat, 22 May 2021 17:40:54 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 17:43:42 +0800
Received: from [10.67.103.235] (10.67.103.235) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 17:43:42 +0800
Subject: Re: [PATCH V2 0/2] lspci: Decode VF 10-Bit Tag Requester
To:     <mj@ucw.cz>, <helgaas@kernel.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>
References: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <a2aaa86f-8ed7-12a5-9910-751496a6bc68@huawei.com>
Date:   Sat, 22 May 2021 17:43:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.235]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


kindly ping...

On 2021/3/9 21:35, Dongdong Liu wrote:
> The patchset is to decode VF 10-Bit Tag Requester and
> update the tests files.
>
> V1->V2: Fix comments suggested by Krzysztof Wilczyński.
>
> Dongdong Liu (2):
>   lspci: Decode VF 10-Bit Tag Requester
>   lspci: Update tests files with VF 10-Bit Tag Requester
>
>  lib/header.h        | 2 ++
>  ls-ecaps.c          | 8 ++++----
>  tests/cap-dvsec-cxl | 4 ++--
>  tests/cap-ea-1      | 4 ++--
>  tests/cap-pcie-2    | 4 ++--
>  5 files changed, 12 insertions(+), 10 deletions(-)
>
> --
> 1.9.1
>
> .
>
