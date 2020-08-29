Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29028256417
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 04:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH2CFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 22:05:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbgH2CFu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 22:05:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FE8A17D0484826F4B3E;
        Sat, 29 Aug 2020 10:05:47 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.235) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 29 Aug 2020
 10:05:43 +0800
Subject: Re: [PATCH] lspci: Decode 10-Bit Tag Requester Enable
To:     =?UTF-8?Q?Martin_Mare=c5=a1?= <mj@ucw.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <1596266480-52789-1-git-send-email-liudongdong3@huawei.com>
 <20200828164931.GA2161257@bjorn-Precision-5520>
 <mj+md-20200828.205604.86207.nikam@ucw.cz>
CC:     <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <aba15183-0c97-0acb-7d42-e8a455cbc1fd@huawei.com>
Date:   Sat, 29 Aug 2020 10:05:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <mj+md-20200828.205604.86207.nikam@ucw.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin, Bjorn

On 2020/8/29 4:56, Martin Mareš wrote:
> Hello!
>
>> And we have a bit of a mess in the names here.  There are a bunch of
>> "PCI_EXP_DEV2_*" names that would be "PCI_EXP_DEVCTL2_*" if they
>> followed the convention.  You didn't start that trend, so I'm just
>> pointing it out in case you or Martin want to clean it up.  When I add
>> names I try to use the same name between the Linux kernel source [1]
>> and lspci.
>
> Yes, could you please clean it up?
>
> Otherwise it's OK.
>
> 					Martin

Will do in next patch.

Thanks,
Dongdong.
>
> .
>

