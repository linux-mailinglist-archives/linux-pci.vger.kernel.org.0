Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9E152879
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBEJhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 04:37:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbgBEJhf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 04:37:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 780EE876068C6BED71B9;
        Wed,  5 Feb 2020 17:37:33 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 5 Feb 2020
 17:37:26 +0800
Subject: Re: [PATCH 0/6] Improve link speed presentation process
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
CC:     <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <36d8ddfb-df1a-18cb-bd17-809bf805e8bd@hisilicon.com>
Date:   Wed, 5 Feb 2020 17:37:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

would you mind giving some comments to help me get these patches merged?

Thanks,
Yicong Yang

On 2020/1/15 17:04, Yicong Yang wrote:
> In this series:
> 1. Add 32 GT/s decoding in some macros as a complementary
> 2. Remove redundancy in speed presentation process and improve the codes.
>
> Currently We use switch-case statements to acquire the speed
> string according to the pci bus speed in current_link_speed_show()
> and pcie_get_speed_cap(). It leads to redundant and when new
> standard comes, we have to add cases in the related functions,
> which is easy to omit at somewhere.
>
> Abstract the judge statements out. Use macros and pci speed
> arrays instead. Then only the macros and arrays need to be
> extended when next generation comes.
>
> Link:
> https://lore.kernel.org/linux-pci/20200113211728.GA113776@google.com/
> https://lore.kernel.org/linux-pci/20200114224909.GA19633@google.com/
>
>
> Yicong Yang (6):
>   PCI: add 32 GT/s decoding in some macros
>   PCI: Make pci_bus_speed_strings[] public
>   PCI: Add comments for link speed info arrays
>   PCI: Improve and rename PCIE_SPEED2STR macro
>   PCI: Add PCIE_LNKCAP2_SLS2SPEED macro
>   PCI: Reduce redundancy in current_link_speed_show()
>
>  drivers/pci/pci-sysfs.c | 26 ++++----------------------
>  drivers/pci/pci.c       | 23 +++++++----------------
>  drivers/pci/pci.h       | 22 +++++++++++++++-------
>  drivers/pci/probe.c     | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/slot.c      | 39 +++------------------------------------
>  5 files changed, 66 insertions(+), 81 deletions(-)
>
> --
> 2.8.1
>
>
> .
>


