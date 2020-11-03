Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499A12A37F9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 01:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKCAnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 19:43:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6736 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCAnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 19:43:19 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQ9xY5hbczkd80;
        Tue,  3 Nov 2020 08:43:13 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 08:43:12 +0800
Subject: Re: [PATCH v4 0/6] resource: introduce union(), intersection() API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <1183267b-3e90-ab71-b1f6-7760ad0ca57c@huawei.com>
Date:   Tue, 3 Nov 2020 08:43:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/11/3 5:00, Andy Shevchenko wrote:
> Some users may want to use resource library to manage their own resources,
> besides existing users that open code union() and intersection()
> implementations.
> 
> Provide a generic API for wider use.
> 
> Changelog v4:
> - added Rb tag (Rafael)
> - Cc'ed to LKML and Greg (Rafael)
> 
> Changelog v3:
> - rebased on top of v5.10-rc1
> - dropped upstreamed dependencies
> - added Rb tag to the last patch (Mika)
> 
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> 
> Andy Shevchenko (6):
>    resource: Simplify region_intersects() by reducing conditionals
>    resource: Group resource_overlaps() with other inline helpers
>    resource: Introduce resource_union() for overlapping resources
>    resource: Introduce resource_intersection() for overlapping resources
>    PCI/ACPI: Replace open coded variant of resource_union()
>    ACPI: watchdog: Replace open coded variant of resource_union()
> 
>   drivers/acpi/acpi_watchdog.c |  6 +-----
>   drivers/acpi/pci_root.c      |  4 +---
>   include/linux/ioport.h       | 34 +++++++++++++++++++++++++++-------
>   kernel/resource.c            | 10 +++++-----
>   4 files changed, 34 insertions(+), 20 deletions(-)

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
