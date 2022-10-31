Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DA614173
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 00:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJaXVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 19:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaXVI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 19:21:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B6BC35;
        Mon, 31 Oct 2022 16:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTC4/W4qgfiCkV/jGk+J+KQixTSfpKmh2pdgpgsv5oyNGzhjBLYgh0TXWXQZxGVSzL4PytvPq7MqlaYhV+FmrmrWt+WqhsEAQ7oxiQM6LBplMOlCA+FNIjxQln9nn9zr7EGYACM7ge6rJqJmIHIQn122Bj1uSNoQA/VfCujIjReFz4TUYLd+bOr+abFypK8mct40gBoHXpg7oTnSGKmXPOjpE2ktxPNU2ZHmFZu1GslvysFnKT+DQIcfXVqacS81DSH0dPY4m2rhh7eIO/Bh2DJVEnzraDs5eLNBlk1NQbW3+U2AEKbCcweJm6VVZvOgv/MhUC8TPP1KrkkZjoZ8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XU4TPDEzRpAQSijseWASt48UhNamRO58DbpfqlFY50=;
 b=VsjFk3bNWgybfsomSHKqC/p3nNERoAdhPFl8nZlQtzYKOw3szkm2lGc3eEh5FPFHLxPy9JaC3aa/wWc7E2RFluaT41Zio0ORWbcWXTHkykQqik1WVwH/XTERVuAPkR7BcF66X9LMlJqF0pocz5gFHfhDCtW2j9lN4/QS4/jWGeQDUx37c9CHXs05FSKAKn9JxNMreMQB6nXGokIkyhC/N2vvGqSrtOqmLFYTb/OWCgYcZe1XP+QYWm0kXKn157ujMLx4YRzW5p5k25C9xAN+9uw2Il7817PW/AKZFeRtifG3gZgC96CJeb265OZ8DUv9cARUcDXifub3Egq1zbjULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XU4TPDEzRpAQSijseWASt48UhNamRO58DbpfqlFY50=;
 b=pEjW5RigS13zuXPFAE4/lyA0vvaC/v9ddGoppgc0znkYEFny4y75G/Ky5HSiXAwpOlyPeXkV3UauzesFDvvvGMwimBhUduvZZ9ma8CBElRsMAIk/4OLVYny1SsGEGlYiTG8wePqChBJ80jboGg8d5Casu2GwC7jMDkngZ2zUj+4=
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 23:21:02 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::3e) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 23:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 23:21:02 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 18:21:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 16:21:01 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 31 Oct 2022 18:21:00 -0500
Message-ID: <ebaed54f-94d7-addc-7084-d073436c5553@amd.com>
Date:   Mon, 31 Oct 2022 16:21:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC V2 3/3] PCI: Add basic properties for dynamically
 generated PCI OF node
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
 <1665598440-47410-4-git-send-email-lizhi.hou@amd.com>
 <20221026193907.GA902790-robh@kernel.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20221026193907.GA902790-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f2e133-ba32-42f5-dd4c-08dabb969385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTs48h2U4v5M9QTEeLRdHg5O8mqVLWhKF0vvxJu/gXJSC52w0ZpknKe04rfzkuDYbWc1dGKcJ74sBbpJbeal1F6HAy5XGL2b9cnMb3iMmzGoj72rBih1Kc480IF3mXCg5DQUkjF1uwY3WvOvFYiwvLsTkjTshjqVFy+lvbQoQCmsLukpmSS7esEaC9azsd0+7Z8KP/XmqFfW325njUcMm8b3HYozvy6mh8bycA5uVVbGuOoVhJ2ZhxM0wAKMQLDKYqpiDZyrxQGSePkCahss2ntoVkQalI9dmeXtiL0L23LNpYyJDlYMoB7LVRbxRpkwuRH9aCi1mjlqTUpc+1wmAvNtX6lmB/MZDSQVoF/pX+u/ifi2vFgoQ8RhBq/M1wWhtuzm8IRX+vi0EQE7AySXCsqMeEcllQwa+Jc4ARFXkLX/ATFOpmV1fkzl4ZOnznpy+SBciHBpJw/I+j3ej7FytgpGTu+ilCw+dQQIQDHISNOySUVE0mPyEcN9dhOjfMBAbVAg1RME7l/U9BCByhvLnHA5/DxowFfWPODZT5Ws53oM3JVTj/HEdIAeW1ouYGDX2lRJIGNsYcvDK1CSnwe25hK4xZeOVuYIduMICRBCl3trh3DKTmkCYrKmlObgXPBkEaYAqaUY7or6U67IYVDwqyvCKP0Vp06TLHqU3UqU4mmpIJZ05LIFo//zDsT0aj+51Qd/lmyDkz3j4oRIsk4X2CpgpX0W/ShlUshh+xXnKpvn5xgFGCel9qu9m6ZUWKS1FBrnk1frVG6GjsfBNEPMPpsysIvvryBQz0bHOlLpR4mhb71c3PpqVsGhF6zXHkI+h5uHuvUZfAEnE08FMB1Dng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(16576012)(26005)(81166007)(356005)(31686004)(70206006)(86362001)(36860700001)(31696002)(82740400003)(44832011)(4326008)(5660300002)(83380400001)(8936002)(47076005)(426003)(82310400005)(336012)(186003)(53546011)(41300700001)(2906002)(316002)(478600001)(36756003)(70586007)(40460700003)(54906003)(6916009)(40480700001)(2616005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 23:21:02.0390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f2e133-ba32-42f5-dd4c-08dabb969385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/26/22 12:39, Rob Herring wrote:
> On Wed, Oct 12, 2022 at 11:14:00AM -0700, Lizhi Hou wrote:
>> This patch addes 'reg', 'compatible' and 'device_typ' properties for
> typo
>
> Please read submitting-patches.rst and what it says about 'This patch'.
Sure. And I will merge patch 2 and 3.
>
>> dynamically generated PCI device tree node
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>> ---
>>   drivers/pci/Makefile      |   1 +
>>   drivers/pci/of.c          |  10 ++-
>>   drivers/pci/of_property.c | 177 ++++++++++++++++++++++++++++++++++++++
> I don't think we need a separate file here and patches 2 and 3 should be
> combined. Patch 2 alone doesn't really make sense.
>
>
>>   drivers/pci/pci.h         |   3 +-
>>   4 files changed, 189 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/pci/of_property.c
>>
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 2680e4c92f0a..cc8b4e01e29d 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>>   
>>   # Endpoint library must be initialized before its users
>>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 83e042f495a6..00d716589660 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -619,6 +619,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>   {
>>   	struct device_node *parent, *dt_node;
>>   	const char *pci_type = "dev";
>> +	struct property *props;
>>   	char *full_name;
>>   
>>   	/*
>> @@ -645,10 +646,15 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>   	if (!full_name)
>>   		goto failed;
>>   
>> -	dt_node = of_create_node(parent, full_name, NULL);
>> +	props = of_pci_props_create(pdev);
>> +	if (!props)
>> +		goto failed;
>> +
>> +	dt_node = of_create_node(parent, full_name, props);
>>   	if (!dt_node)
>>   		goto failed;
>>   
>> +	of_pci_props_destroy(props);
>>   	kfree(full_name);
>>   
>>   	pdev->dev.of_node = dt_node;
>> @@ -656,6 +662,8 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>   	return;
>>   
>>   failed:
>> +	if (props)
>> +		of_pci_props_destroy(props);
>>   	kfree(full_name);
>>   }
>>   #endif
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> new file mode 100644
>> index 000000000000..693a08323aa4
>> --- /dev/null
>> +++ b/drivers/pci/of_property.c
>> @@ -0,0 +1,177 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/of.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +
>> +struct of_pci_prop {
>> +	char *name;
>> +	int (*prop_val)(struct pci_dev *pdev, void **val, u32 *len);
>> +};
>> +
>> +struct of_pci_addr_pair {
>> +	__be32		phys_hi;
>> +	__be32		phys_mid;
>> +	__be32		phys_lo;
>> +	__be32		size_hi;
>> +	__be32		size_lo;
>> +};
>> +
>> +#define OF_PCI_ADDR_SPACE_CONFIG	0x0
>> +#define OF_PCI_ADDR_SPACE_IO		0x1
>> +#define OF_PCI_ADDR_SPACE_MEM32		0x2
>> +#define OF_PCI_ADDR_SPACE_MEM64		0x3
>> +
>> +#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
>> +#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
>> +#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
>> +#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
>> +#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
>> +#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
>> +
>> +#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
>> +#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)
>> +
>> +#define OF_PCI_PROP_COMPAT_LEN_MAX	256
>> +static int of_pci_prop_device_type(struct pci_dev *pdev, void **val, u32 *len)
>> +{
>> +	if (!pci_is_bridge(pdev))
>> +		return 0;
>> +
>> +	*val = kasprintf(GFP_KERNEL, "pci");
>> +	if (!*val)
>> +		return -ENOMEM;
>> +
>> +	*len = strlen(*val) + 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int of_pci_prop_reg(struct pci_dev *pdev, void **val, u32 *len)
>> +{
>> +	struct of_pci_addr_pair *reg;
>> +	u32 reg_val, base_addr, ss;
>> +	resource_size_t sz;
>> +	int i = 1, resno;
>> +
>> +	reg = kzalloc(sizeof(*reg) * (PCI_STD_NUM_BARS + 1), GFP_KERNEL);
>> +	if (!reg)
>> +		return -ENOMEM;
>> +
>> +	reg_val = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, OF_PCI_ADDR_SPACE_CONFIG) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
>> +	reg[0].phys_hi = cpu_to_be32(reg_val);
>> +
>> +	base_addr = PCI_BASE_ADDRESS_0;
>> +	for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
>> +	     resno++, base_addr += 4) {
>> +		sz = pci_resource_len(pdev, resno);
>> +		if (!sz)
>> +			continue;
>> +
>> +		if (pci_resource_flags(pdev, resno) & IORESOURCE_IO)
>> +			ss = OF_PCI_ADDR_SPACE_IO;
>> +		else if (pci_resource_flags(pdev, resno) & IORESOURCE_MEM_64)
>> +			ss = OF_PCI_ADDR_SPACE_MEM64;
>> +		else
>> +			ss = OF_PCI_ADDR_SPACE_MEM32;
>> +
>> +		reg_val &= ~(OF_PCI_ADDR_FIELD_SS | OF_PCI_ADDR_FIELD_PREFETCH |
>> +				OF_PCI_ADDR_FIELD_REG);
>> +		reg_val |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss) |
>> +			FIELD_PREP(OF_PCI_ADDR_FIELD_REG, base_addr);
>> +		if (pci_resource_flags(pdev, resno) & IORESOURCE_PREFETCH)
>> +			reg_val |= OF_PCI_ADDR_FIELD_PREFETCH;
>> +		reg[i].phys_hi = cpu_to_be32(reg_val);
>> +		reg[i].size_hi = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_HI, sz));
>> +		reg[i].size_lo = cpu_to_be32(FIELD_GET(OF_PCI_SIZE_LO, sz));
>> +		i++;
>> +	}
>> +
>> +	*val = reg;
>> +	*len = i * sizeof(*reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static int of_pci_prop_compatible(struct pci_dev *pdev, void **val, u32 *len)
>> +{
>> +	char *compat;
>> +
>> +	compat = kzalloc(OF_PCI_PROP_COMPAT_LEN_MAX, GFP_KERNEL);
> The size here looks pretty arbitrary yet we should be able to calculate
> the worst case.
I will remove this.
>
>> +	if (!compat)
>> +		return -ENOMEM;
>> +
>> +	*val = compat;
>> +	if (pdev->subsystem_vendor) {
>> +		compat += sprintf(compat, "pci%x,%x.%x.%x.%x",
>> +				  pdev->vendor, pdev->device,
>> +				  pdev->subsystem_vendor,
>> +				  pdev->subsystem_device,
>> +				  pdev->revision) + 1;
>> +		compat += sprintf(compat, "pci%x,%x.%x.%x",
>> +				  pdev->vendor, pdev->device,
>> +				  pdev->subsystem_vendor,
>> +				  pdev->subsystem_device) + 1;
>> +		compat += sprintf(compat, "pci%x,%x",
>> +				  pdev->subsystem_vendor,
>> +				  pdev->subsystem_device) + 1;
>> +	}
>> +	compat += sprintf(compat, "pci%x,%x.%x",
>> +			  pdev->vendor, pdev->device, pdev->revision) + 1;
>> +	compat += sprintf(compat, "pci%x,%x", pdev->vendor, pdev->device) + 1;
>> +	compat += sprintf(compat, "pciclass,%06x", pdev->class) + 1;
>> +	compat += sprintf(compat, "pciclass,%04x", pdev->class >> 8) + 1;
> No checking/preventing overrunning the compat buffer?
>
> I don't think we need all these compatible strings. One with VID/PID and
> one with the class should be sufficient. But I'm not sure offhand what
> subsystem_vendor/device device is...
Ok. I will keep pci%x,%x, pciclass,%06x, pciclass,%04x.
>
>> +
>> +	*len = (u32)(compat - (char *)*val);
>> +
>> +	return 0;
>> +}
>> +
>> +struct of_pci_prop of_pci_props[] = {
>> +	{ .name = "device_type", .prop_val = of_pci_prop_device_type },
> This only only applies to bridge nodes.

In of_pci_prop_device_type, it returns immediately for pci endpoint.

To make it obvious, I will separate bridge and endpoint property arrays.

>
>> +	{ .name = "reg", .prop_val = of_pci_prop_reg },
>> +	{ .name = "compatible", .prop_val = of_pci_prop_compatible },
>> +	{},
>> +};
>> +
>> +struct property *of_pci_props_create(struct pci_dev *pdev)
>> +{
>> +	struct property *props, *pp;
>> +	void *val;
>> +	u32 len;
>> +	int i;
>> +
>> +	props = kcalloc(ARRAY_SIZE(of_pci_props), sizeof(*props), GFP_KERNEL);
>> +	if (!props)
>> +		return NULL;
>> +
>> +	pp = props;
>> +	for (i = 0; of_pci_props[i].name; i++) {
>> +		len = 0;
>> +		of_pci_props[i].prop_val(pdev, &val, &len);
>> +		if (!len)
>> +			continue;
>> +		props->name = of_pci_props[i].name;
>> +		props->value = val;
>> +		props->length = len;
>> +		props++;
> This creates an array of properties and then copies each one, and it
> also exposes the internals of 'struct property' which we want to make
> opaque. Neither of these is great.
>
> I'd rather see the of_changeset API expanded to handle specific types of
> properties. Something like this:
>
> of_changeset_add_prop_string(cset, node, "device_type", "pci");
> of_changeset_add_prop_string_array(cset, node, "compatible", compats, cnt);
> of_changeset_add_prop_u32_array(cset, node, "reg", reg, cnt);
>
> And perhaps these functions just wrap similar non-changeset functions
> that produce a struct property.
>
> IOW, it should be similar to the of_property_read_* APIs, but to
> set/add rather than get.
Okay. I will add above 3 APIs and use them to create properties.
>
>
> You are also missing 'ranges', '#address-cells, and '#size-cells' in
> bridge nodes.

I will add them. Do you have more in mind that I need to add with this 
patch?


Thanks,

Lizhi

>
> Rob
