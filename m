Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634D2D74DA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfJOLYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 07:24:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41082 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfJOLYG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 07:24:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9FBNt9L109230;
        Tue, 15 Oct 2019 06:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571138635;
        bh=JtonZDXxyNuqLG8pQHZ0YDPt2+49Y+aRH6v4JFO9anw=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=KXldssEfQzIdpm/xL8bImgE+7Ze0Bn9jIXXOnN70YnNZKpAMKNdcwEo0QGf1J7Ho6
         stYsk6C5V/k+6jw6wWWXVDJqsklMPsFPRUJcuvAo5qOvyNWz10sCxyTWkfpxedJvBp
         hiJnDWmiw6Hq46Tx/xcwFpuTYDsy2XmeiSj8KrPk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9FBNtMH052386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Oct 2019 06:23:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 15
 Oct 2019 06:23:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 15 Oct 2019 06:23:55 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9FBNmk2109164;
        Tue, 15 Oct 2019 06:23:50 -0500
Subject: Re: [PATCH] PCI:cadence:Driver refactored to use as a core library.
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>
References: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
 <03a8af4b-96bb-48b6-a79b-7db3a2ee59d0@ti.com>
Message-ID: <ba7cf838-dc20-2007-cbf4-e8fbcd49e69f@ti.com>
Date:   Tue, 15 Oct 2019 16:53:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <03a8af4b-96bb-48b6-a79b-7db3a2ee59d0@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tom,

On 01/10/19 4:45 PM, Kishon Vijay Abraham I wrote:
> Hi Tom,
> 
> On 30/09/19 10:12 PM, Tom Joseph wrote:
>> All the platform related APIs/Structures in the driver has been extracted
>>  out to a separate file (pcie-cadence-plat.c). This will enable the
>>  driver to be used as a core library, which could be used by other
>>  platform drivers.Testing was done using simulation environment.
>>
>> Signed-off-by: Tom Joseph <tjoseph@cadence.com>
>> ---
>>  drivers/pci/controller/Kconfig             |  35 +++++++
>>  drivers/pci/controller/Makefile            |   1 +
>>  drivers/pci/controller/pcie-cadence-ep.c   |  78 ++-------------
>>  drivers/pci/controller/pcie-cadence-host.c |  77 +++------------
>>  drivers/pci/controller/pcie-cadence-plat.c | 154 +++++++++++++++++++++++++++++
>>  drivers/pci/controller/pcie-cadence.h      |  69 +++++++++++++
>>  6 files changed, 278 insertions(+), 136 deletions(-)
>>  create mode 100644 drivers/pci/controller/pcie-cadence-plat.c
>>

<snip>

>> diff --git a/drivers/pci/controller/pcie-cadence-plat.c b/drivers/pci/controller/pcie-cadence-plat.c
>> new file mode 100644
>> index 0000000..274615d
>> --- /dev/null
>> +++ b/drivers/pci/controller/pcie-cadence-plat.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2019 Cadence
>> +// Cadence PCIe platform  driver.
>> +// Author: Tom Joseph <tjoseph@cadence.com>
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/of_device.h>
>> +#include "pcie-cadence.h"
>> +
>> +/**
>> + * struct cdns_plat_pcie - private data for this PCIe platform driver
>> + * @pcie: Cadence PCIe controller
>> + * @regmap: pointer to PCIe device
>> + * @is_rc: Set to 1 indicates the PCIe controller mode is Root Complex,
>> + *         if 0 it is in Endpoint mode.
>> + */
>> +struct cdns_plat_pcie {
>> +	struct cdns_pcie        *pcie;
>> +	bool is_rc;
>> +};
>> +
>> +struct cdns_plat_pcie_of_data {
>> +	bool is_rc;
>> +};
>> +
>> +static const struct of_device_id cdns_plat_pcie_of_match[];
>> +
>> +int cdns_plat_pcie_link_control(struct cdns_pcie *pcie, bool start)
>> +{
>> +	pr_debug(" %s called\n", __func__);
>> +	return 0;
>> +}
>> +
>> +bool cdns_plat_pcie_link_status(struct cdns_pcie *pcie)

How do you get cdns_plat_pcie from pcie? Cadence plat doesn't need it however
the platform specific base address will be stored in the platform specific
structure (struct cdns_plat_pcie here) which will be used for performing
controller configuration.

I think you can just move *dev to struct cdns_pcie from struct
cdns_pcie_ep/struct cdns_pcie_rc and use dev_get_drvdata here to get platform
specific structure.

Thanks
Kishon
