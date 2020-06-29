Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31AC20DBF5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgF2ULN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 16:11:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729379AbgF2ULB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 16:11:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C36D583A98373F3E8DC4;
        Mon, 29 Jun 2020 12:24:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 29 Jun 2020
 12:24:44 +0800
Subject: Re: [PATCH v2 01/12] ACPI/IORT: Make iort_match_node_callback walk
 the ACPI namespace for NC
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <iommu@lists.linux-foundation.org>, <linux-acpi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-2-lorenzo.pieralisi@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <718cae1f-2f33-f6d9-f278-157300b73116@huawei.com>
Date:   Mon, 29 Jun 2020 12:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619082013.13661-2-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 2020/6/19 16:20, Lorenzo Pieralisi wrote:
> When the iort_match_node_callback is invoked for a named component
> the match should be executed upon a device with an ACPI companion.
> 
> For devices with no ACPI companion set-up the ACPI device tree must be
> walked in order to find the first parent node with a companion set and
> check the parent node against the named component entry to check whether
> there is a match and therefore an IORT node describing the in/out ID
> translation for the device has been found.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>   drivers/acpi/arm64/iort.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 28a6b387e80e..5eee81758184 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -264,15 +264,31 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>   
>   	if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT) {
>   		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> -		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> +		struct acpi_device *adev;
>   		struct acpi_iort_named_component *ncomp;
> +		struct device *nc_dev = dev;
> +
> +		/*
> +		 * Walk the device tree to find a device with an
> +		 * ACPI companion; there is no point in scanning
> +		 * IORT for a device matching a named component if
> +		 * the device does not have an ACPI companion to
> +		 * start with.
> +		 */
> +		do {
> +			adev = ACPI_COMPANION(nc_dev);
> +			if (adev)
> +				break;
> +
> +			nc_dev = nc_dev->parent;
> +		} while (nc_dev);

I'm lost here, we need the ACPI_COMPANION (the same as
to_acpi_device_node()) of the device, but why do we need to go
up to find the parent node?

For a platform device, if I use its parent's full path name for
its named component entry, then it will match, but this will violate
the IORT spec.

Thanks
Hanjun

