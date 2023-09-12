Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6FD79D729
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjILRFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjILRFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 13:05:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E186110;
        Tue, 12 Sep 2023 10:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THsW2jzwxz5CIzxhR6l9Hf4CrN2JysWVa9zmRl8cO2+iflE941DwPuGrTOIREvZZbJyF9dnzbjsYJDasu8ewABH4SVk82CkA3rLdoMwUkAau4Y9mAz7YiYztj1XySn/SxmJ/ohVRz2SVKU4bplDTa4VNFRhP4GgMBAQWLB1Vr+pZCc2QIlij57TyM8+/Kp5hD2TtBcIKb3YKk6sVBaNSXeruUmPRC51yXWSFEXntVy0Ju79ePfyR26o0Q2ZCeHEF4S8PndDGwKKIDVncvd3LntqkY83PyKGHgDZFuYWWTGwoTInuwrrHZUmw+hAjApnxGzGb0sMCknym7BYW1AwVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9W5sSmukbvXMNyRwhS9Ldrh480kZr+qRQEdSzBMDHk=;
 b=mW2wWD177EWUUEEqrGH4eGLPgsAAF1sCiNN8Rs9jFoNSFgs9tTUjN6+vnbm8UlCDa9lwzvNpkyzAJDo9+MlVqqVaZHdD8JqVZq3rlxCQhrJuWZNzD/yXQn8LyB4uQNaKHfj8vYPp15La0tkSycrNLioJdsvsJIBHMJc6zsLPNLU0TmjTT7bcakqQbGgGqE42kuOFpH3qqKtmKRjVyOqXlOlrEucxDkrk+IeU2QMiBIp6/h6/gG7FwD6cHQxX5OspI7TvgT5XQshyyRqtCR8eAaSQjL+2UDF8M+rqTKOpQyz8WhZ+2ED76iQ4i3oq+iXV13EabYR7yrHjBJ9D0WXiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9W5sSmukbvXMNyRwhS9Ldrh480kZr+qRQEdSzBMDHk=;
 b=FuAsMQKBTIaZdeFEHcGjQtGmmG7LxFQXRvulTcse94dAdjMGyMPOd/j2c+nVcUtu51/6OHo/GOEvbbd8mI4fXyFzH1wvWJuFkMVS0Ojh5LuZSJUiCcwV78Fmri8xDo7ijWe/2yxjKMRYMURaYW7uL1Fjzk57NMEA0NwT4ad/W9E=
Received: from SA0PR11CA0061.namprd11.prod.outlook.com (2603:10b6:806:d2::6)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 17:05:45 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::8c) by SA0PR11CA0061.outlook.office365.com
 (2603:10b6:806:d2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37 via Frontend
 Transport; Tue, 12 Sep 2023 17:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 17:05:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 12:05:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 10:05:43 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 12:05:42 -0500
Message-ID: <02567845-7662-51ca-6d73-1a82dc4c6450@amd.com>
Date:   Tue, 12 Sep 2023 10:05:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
 <20230911154856.000076c3@Huawei.com>
 <0cc232a2-1743-aeaa-cb87-ce320cc9fc39@amd.com>
 <20230912111035.00002e9b@Huawei.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230912111035.00002e9b@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: b4994cf6-142b-46b5-924c-08dbb3b28068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFSGqKlSZ0dIsC7tl4EML0t9FRg4oSGh6lq6KSFiJK/ErU6hLLHiStiX0KL9i5nIl/eJ+YqI6eMzIVSWmvFq74SYHP5ecmpFS2fYVzaJAR0WHlo/Xt7WJgzmJCjLyiYNgDYKXKgk0elLw/ET2q2SZg0Zmfk+Lv64XEsUdpa8uS14adhpJz020sI+1d8HSxwsUNDvkzLlt/GXbPJK5gjCH9pqhYC0kN6k4PtQoQyBNygH6Lrbq+UpH3t8BtDlqH7AKnJkW3L8Tb6NcZM/7x6bGb3JLEiO5lg0EHzrHNGdU/d7k9RervpsT71o/kwWtah3VqhDSUuT8BX3dV2ogRzj+Dc1U0MYuKcmmy1CJXIxmXY7YPIwPCZTadGl5oIfrgwaFxOgz7xE97PX+iqrP0ufGU82UcgCIYAjWBggW3S3jC+F7bHGqZ4YjmREvmr7Im7YlEn5ZOYn5+DP8k1xEABLoPbWfekiB3dFZ+3pyPn2jZQbNWbsvvxHrY5mtbzqgTHza+ddFNQ9q5Q6/TEmj+kSCvtAU05C44BZbQjz/NG1U6AxYw379Q8AKM3iFROYLsBdoXeDSvUAULYFynFf6Ywdu+COCxVyd+BEW9catkRKxqq+iOvddnr7+OKkBgI9AwBVD1/fIJ9BYF6iCj3zjoBnJC1NHL2AeIBGGaV3gfq+rASl/zUqhmSrSaCx651G9SgDJf/ALA3L9ZbKcTbbM36iEfOVhYyUBN0meLqklDYKsn9IBEvkliF3aiFdkUJXJ1vC2nVoOo5XZKpSLwpc5qHhx6eUErY92ivCHxn/OSr2yuq/ACfuwHbU2hdHKnp7sHJw42WKMjVrWKxHSnCOl36Gzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(31696002)(8676002)(4326008)(8936002)(86362001)(40480700001)(44832011)(5660300002)(2906002)(40460700003)(36756003)(83380400001)(336012)(426003)(53546011)(356005)(81166007)(82740400003)(26005)(478600001)(2616005)(47076005)(316002)(70586007)(70206006)(54906003)(16576012)(6916009)(41300700001)(36860700001)(31686004)(21314003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:05:44.2319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4994cf6-142b-46b5-924c-08dbb3b28068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/12/23 03:10, Jonathan Cameron wrote:
> On Mon, 11 Sep 2023 09:58:04 -0700
> Lizhi Hou <lizhi.hou@amd.com> wrote:
>
>> On 9/11/23 07:48, Jonathan Cameron wrote:
>>> On Tue, 15 Aug 2023 10:19:57 -0700
>>> Lizhi Hou <lizhi.hou@amd.com> wrote:
>>>   
>>>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>>>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>>>> the PCI core discovers devices and BARs using the PCI enumeration process.
>>>> There is no infrastructure to discover the hardware peripherals that are
>>>> present in a PCI device, and which can be accessed through the PCI BARs.
>>>>
>>>> Apparently, the device tree framework requires a device tree node for the
>>>> PCI device. Thus, it can generate the device tree nodes for hardware
>>>> peripherals underneath. Because PCI is self discoverable bus, there might
>>>> not be a device tree node created for PCI devices. Furthermore, if the PCI
>>>> device is hot pluggable, when it is plugged in, the device tree nodes for
>>>> its parent bridges are required. Add support to generate device tree node
>>>> for PCI bridges.
>>>>
>>>> Add an of_pci_make_dev_node() interface that can be used to create device
>>>> tree node for PCI devices.
>>>>
>>>> Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
>>>> the kernel will generate device tree nodes for PCI bridges unconditionally.
>>>>
>>>> Initially, add the basic properties for the dynamically generated device
>>>> tree nodes which include #address-cells, #size-cells, device_type,
>>>> compatible, ranges, reg.
>>>>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> I tried to bring this up for a custom PCIe card emulated in QEMU on an ARM ACPI
>>> machine.
>>>
>>> There are some missing parts that were present in Clements series, but not this
>>> one, particularly creation of the root pci object.
>> Thanks for trying this. The entire effort was separated in different
>> phases. That is why this patchset does not include creating of_root.
>>> Anyhow, hit an intermittent crash...
>>>
>>>   
>>>> ---
>>>> +static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>>>> +				struct device_node *np)
>>>> +{
>>>> +	struct of_phandle_args out_irq[OF_PCI_MAX_INT_PIN];
>>>> +	u32 i, addr_sz[OF_PCI_MAX_INT_PIN], map_sz = 0;
>>>> +	__be32 laddr[OF_PCI_ADDRESS_CELLS] = { 0 };
>>>> +	u32 int_map_mask[] = { 0xffff00, 0, 0, 7 };
>>>> +	struct device_node *pnode;
>>>> +	struct pci_dev *child;
>>>> +	u32 *int_map, *mapp;
>>>> +	int ret;
>>>> +	u8 pin;
>>>> +
>>>> +	pnode = pci_device_to_OF_node(pdev->bus->self);
>>>> +	if (!pnode)
>>>> +		pnode = pci_bus_to_OF_node(pdev->bus);
>>>> +
>>>> +	if (!pnode) {
>>>> +		pci_err(pdev, "failed to get parent device node");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
>>>> +	for (pin = 1; pin <= OF_PCI_MAX_INT_PIN;  pin++) {
>>>> +		i = pin - 1;
>>>> +		out_irq[i].np = pnode;
>>>> +		out_irq[i].args_count = 1;
>>>> +		out_irq[i].args[0] = pin;
>>>> +		ret = of_irq_parse_raw(laddr, &out_irq[i]);
>>>> +		if (ret) {
>>>> +			pci_err(pdev, "parse irq %d failed, ret %d", pin, ret);
>>>> +			continue;
>>> If all the interrupt parsing fails we continue ever time...
>> Did you use Clement's patch to create of_root? I am just wondering if
>> parsing irq could fail on a dt-based system.
> For qemu already have of_root as there is still a device tree, it's just
> used to pass some stuff to EDK2 I think. I was carrying the Frank's
> series adding a bare device tree, it's just not doing anything on these
> systems
>
> I used Clements patch to add the pci root (cleaned up a bit to
> match the style of your series more closely).
>
> However, my interest is in ACPI based systems, not DT based ones.

Thanks for your clarification. I am also more interested in ACPI based 
system. After discussing with Rob, creating PCI nodes on DT based system 
is the first step to achieve this.


Lizhi

>
> Jonathan
>
>
>> And yes, the failure case should be handled without crash. I think if
>> irq parsing failed,  the interrupt-map pair generation should be skipped.
>>
>>
>> Thanks,
>>
>> Lizhi
>>
>>>   
>>>> +		}
>>>> +		ret = of_property_read_u32(out_irq[i].np, "#address-cells",
>>>> +					   &addr_sz[i]);
>>>> +		if (ret)
>>>> +			addr_sz[i] = 0;
>>> This never happens.
>>>   
>>>> +	}
>>>> +
>>>> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>>>> +		for (pin = 1; pin <= OF_PCI_MAX_INT_PIN; pin++) {
>>>> +			i = pci_swizzle_interrupt_pin(child, pin) - 1;
>>>> +			map_sz += 5 + addr_sz[i] + out_irq[i].args_count;
>>> and here we end up derefencing random memory which happens in my case to cause
>>> a massive allocation sometimes and that fails one of the assertions in the
>>> allocator.
>>>
>>> I'd suggest just setting addr_sz[xxx] = {}; above
>>> to ensure it's initialized. Then the if(ret) handling should not be needed
>>> as well as of_property_read_u32 should be side effect free I hope!
>>>   
>>>> +		}
>>>> +	}
>>>> +
>>>> +	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
>>>> +	mapp = int_map;
