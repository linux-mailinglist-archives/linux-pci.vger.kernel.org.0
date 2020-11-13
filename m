Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C982B1361
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 01:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgKMAlZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 19:41:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8076 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMAlZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 19:41:25 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXKQX5jPQzLmVr;
        Fri, 13 Nov 2020 08:41:08 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 08:41:14 +0800
Subject: Re: [PATCH v8 5/9] ACPI/IORT: Enable stall support for platform
 devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <joro@8bytes.org>, <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>
CC:     <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <bhelgaas@google.com>,
        <Jonathan.Cameron@huawei.com>, <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <baolu.lu@linux.intel.com>,
        <zhangfei.gao@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
        <vivek.gautam@arm.com>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
 <20201112125519.3987595-6-jean-philippe@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f266330a-4c06-d33d-96a1-d703a6b7e76b@huawei.com>
Date:   Fri, 13 Nov 2020 08:41:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201112125519.3987595-6-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/11/12 20:55, Jean-Philippe Brucker wrote:
> Copy the "Stall supported" bit, that tells whether a platform device
> supports stall, into the fwspec struct.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Hanjun Guo <guohanjun@huawei.com>
