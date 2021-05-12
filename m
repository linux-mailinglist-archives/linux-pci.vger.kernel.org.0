Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003237B6F3
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhELHfm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 03:35:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3731 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHfj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 03:35:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg60T3X04zmg90;
        Wed, 12 May 2021 15:31:05 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 15:34:25 +0800
Subject: Re: [PATCH V2 5/5] PCI: Enable 10-Bit tag support for PCIe RP devices
To:     Christoph Hellwig <hch@infradead.org>
References: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
 <791a5af6-bcbb-a824-ecd7-504abe7194e2@huawei.com>
 <YJqjReTXy5+xaTfN@infradead.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <1dc1802e-9b40-58e8-d743-4d69e1b980ec@huawei.com>
Date:   Wed, 12 May 2021 15:34:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YJqjReTXy5+xaTfN@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/5/11 23:31, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 11:24:16PM +0800, Dongdong Liu wrote:
>> This patch is based on the patchset [PATCH V2 0/5] PCI: Enable 10-Bit tag
>> support for PCIe devices.
>>
>> I use "git send-email" report "4.4.2 Message submission rate for this client
>> has exceeded the configured limit" lead missed [PATCH V2 5/5].
>
> That is a message from your mail server. Try tweaking the
> sendemail.smtpBatchSize option in your .gitconfig
> .
Thanks for you suggestion. It maybe my mail server issue,
change mail server addrees seems work ok.
>
