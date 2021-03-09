Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1173325DC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 13:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCIMyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 07:54:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13587 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCIMyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 07:54:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dvw8Y2rgTz17HmR;
        Tue,  9 Mar 2021 20:52:13 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Mar 2021
 20:53:53 +0800
Subject: Re: [RESEND PATCH] PCI: Factor functions of PCI function reset
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.dom>, <prime.zeng@huawei.com>
References: <1605090123-14243-1-git-send-email-yangyicong@hisilicon.com>
 <YEVoEKxb+Sj2pYHs@rocinante>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <6977e2b7-ed8c-fc45-2143-aaa3c4a287a7@hisilicon.com>
Date:   Tue, 9 Mar 2021 20:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YEVoEKxb+Sj2pYHs@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

thanks for picking up this.

On 2021/3/8 7:56, Krzysztof Wilczyński wrote:
> Hi,
> 
> [...]
>> + * Returns 0 if the device function can be reset or was successfully reset.
>> + * negative if the device doesn't support resetting a single function.
> [...]
> 
> A small nitpick, so feel free to ignore it, of course.  A little change
> to the above sentence:
> 
>   Returns 0 if the device function can be reset or was successfully
>   reset, otherwise negative if the device doesn't support resetting
>   a single function.
> 
> What do you think?
> 

sure. any other comments on the patch? otherwise i'd like to post a v2 one
according to your suggestion. :)

Regards,
Yicong

