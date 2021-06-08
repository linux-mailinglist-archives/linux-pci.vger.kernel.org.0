Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6C39F38D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 12:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFHKav (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 06:30:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3165 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFHKav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 06:30:51 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzmNZ15TMz6K5ZX;
        Tue,  8 Jun 2021 18:16:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 12:28:57 +0200
Received: from [10.47.88.167] (10.47.88.167) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 11:28:56 +0100
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To:     Xingang Wang <wangxingang5@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <robh@kernel.org>, <will@kernel.org>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>
References: <20210604190430.GA2220179@bjorn-Precision-5520>
 <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0379c9c4-f7c7-fe4d-596d-7486377c8462@huawei.com>
Date:   Tue, 8 Jun 2021 11:23:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7cd2f48a-8cb5-d290-7187-267d92e9a595@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.167]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/06/2021 13:58, Xingang Wang wrote:
> On 2021/6/5 3:04, Bjorn Helgaas wrote:
>> [+cc John, who tested 6bf6c24720d3]

I think that whoever committed this patch just blanket applied my TB 
tag. I would not have tested anything supporting ACS or even DT:
https://lore.kernel.org/linux-iommu/c8eb97b1-dab5-cc25-7669-2819f64a885d@huawei.com/

Thanks,
John
