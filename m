Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93C207091
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 12:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgFXKBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 06:01:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387927AbgFXKBS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 06:01:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF273AD35A2EBF1752FB;
        Wed, 24 Jun 2020 18:01:15 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 24 Jun 2020
 18:01:06 +0800
From:   Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: patch update
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>,
        <helgaas@kernel.org>
CC:     Wang Haibin <wanghaibin.wang@huawei.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhang.zhanghailiang@huawei.com>
References: <f9e9de50-4706-188c-614d-ce6989e8f8a6@oracle.com>
Message-ID: <62475f2b-7b01-4e43-5f07-ea47f4cbd9ff@huawei.com>
Date:   Wed, 24 Jun 2020 18:01:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <f9e9de50-4706-188c-614d-ce6989e8f8a6@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Could you spare a little time for reviewing the v3 patch?
I'm afraid you had missed it.

v3: https://lkml.org/lkml/2019/12/10/36

On 2020/6/24 3:43, James Puthukattukaran wrote:
> Xiang/Bjorn -
> Any timeline when this bug will make it upstream?  We're running into this problem on some of our systems.
> I see that it was sitting for a while?
> https://lore.kernel.org/linux-pci/ee28a1f8-b928-b888-763c-9ac0f810c7c3@huawei.com/#t
> thanks
> James
> 

-- 
Thanks,
Xiang

