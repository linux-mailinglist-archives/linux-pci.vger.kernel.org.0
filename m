Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B84621E7D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 22:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiKHVXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 16:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKHVXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 16:23:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A50B46;
        Tue,  8 Nov 2022 13:23:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMjpjaVaS8pMKSNtlOOzXDbPciHPy+Bz4OWKgt9/Jg9PkdQDXqtgGvN3wrErsbNuBACqDdBo8AWGX+14kApaeQrETKUL95BGKNHCyObRtHSmSszz1F5l5fjLekgugff9Bca7/pjHgz4CyDZdmwqt2/YwNGV9DZylUfgtNrKbG734A3YpfF+SQgJtX+j6eovgGHCtUH/0AVKgOEaoK8fWdgGLfsCYl+VcuQI8vJagyICaGTiVQX3Uziu03eBQ74VEyDAfAo2+wwJj3ESN+zM4b5Ao7TDXTeDa9YoRT62oKlJ1Z8SFGGhYIOHjyHKJFd7n1RBiXuG7iuTPjiBH9pZ7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odZzxDeh1zcp76hiTbsRYGkPv6bL7N13q9oyJD7M7E8=;
 b=mcfQjT4GGeZt9/5wkLhHLJUdubtFZRW3l3/9ZYBoVBAAacMHE/WmtGWEKR8JDjn+038ieZj8mRpJaruPYZo1a9LyarKo+hZb5HUq04bqBcKYkkPHHfY0G1ITHzxKuW5Xj/zMrjXHkncTp1Cbk/4JLKQ1P3V5iztECWaxaBdDjtLJBLywzve5vKlLTPAU7ld+BLroQkkxzSNud+3GDK1K+r2ksGJ0pC1w8QGmqOw5D9/ORPEvYZcQdniS8XuMPkFQ/SyafSG6OEIIIYeza22M2f9nMIfZ8YK5rSiNIin+2UsD9JIjilfrwbn8UlSu59FyWcfqylxBMb1+F5l6kr3YhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odZzxDeh1zcp76hiTbsRYGkPv6bL7N13q9oyJD7M7E8=;
 b=5ZP7TmRG1EfcaDXTlqiQxOlK/difJI4PXMb8vYT8VccCpNX7lklTSu9oduEV6nNnonIV4YusT55Xq6SvyH83c28RzQZsHKYg3ZOuRqFyW5PtNPN8eqleVKlA7fS/MLKie+0/dSYHKlXdvIK+fGfAywvEAkDUbl7+iZzPuXnB1wg=
Received: from BL1PR13CA0418.namprd13.prod.outlook.com (2603:10b6:208:2c2::33)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 21:23:18 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ac) by BL1PR13CA0418.outlook.office365.com
 (2603:10b6:208:2c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Tue, 8 Nov 2022 21:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 8 Nov 2022 21:23:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:29:38 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 8 Nov 2022 12:29:37 -0600
Message-ID: <4a0e72b8-fd7f-4b03-8a6f-9bf4c7727e59@amd.com>
Date:   Tue, 8 Nov 2022 10:29:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC V3 2/2] PCI: Create device tree node for selected
 devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <20221107210559.GA419452@bhelgaas>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20221107210559.GA419452@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d9837f-bf80-4297-a6bf-08dac1cf740e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxUkSt2TGB2LLvTRf1EKpAVpgLhaxF9E0YSByhhONChmfC0+SnIKoVx2jiupBdhTaZY5fD/woqEE99yNxc39lewFs04orBBO+w7jRxrl8H/1rT4WSRgb2lLjLUd8uF8jglViLdpdO37p0LsMfDD0Qjeq3LKQiBdV2ss4OcEdN9IhXfb5NSc1RHCcv0U4bTmIQzfxqSob0PNfjFiHogcL2tb9NqBxs58jrdriZZcj9h2XZoJQ4hyE6DQZDJVnRFIlAb0j2VOJ86p24JOVho3vlmW74MGtdSCxRm7QxqIWSgpGStKwRO0LTDp17Y2PBK9CjGoM+XNx1i9e1lSYvk0LTWc5dTTO4gU4rvufchUZXxNeiZp3WHPOIOdxxo6mbwGC3gEKMt6Aq/gzm0d5kvvWZvG9bLGAD2kAWcFuxL6fxU9AnzSt494EOfo032oR5eYDtGEi7TtXMK0mP32FjTmMO1TCLImru4U7WtSR4ZXJvLMpWHk1kHj0m8VcAbSDEJ3RESRMqWNetoJ+OLtyJ6ZGOfbdZ8ZeICC1XCmtRfm6WZG3Vu/fZ6778fyKLHDQl1VUo/5EHbSZUBMgzpw2JDAmlVTwURx3R0X/reQYj6p85wnvJWmcv1xjEokJYJo2Uf/hM8mP6+8G1JYG35DIKOwhszZqGDMzwlr19beT8YWp5MqkBJyUXmKVDvQwQRVaL09shn20LdsAnssU5b+w38fyZKQEPZroHjlTIKi4lO7mkSsIKtEGsSsN7DaYljmmDemejAi+/QwNES8uZet9G+0y7b05volf2i8cJkz+uZnq/NWHBUM6lpR0Mk1tJjZ9GEN5ABbHZQbR3U/EH6i77WWDyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(81166007)(36756003)(82740400003)(31696002)(31686004)(86362001)(356005)(53546011)(40480700001)(40460700003)(44832011)(2906002)(2616005)(26005)(336012)(186003)(426003)(47076005)(36860700001)(83380400001)(8676002)(70206006)(6916009)(54906003)(82310400005)(478600001)(16576012)(4326008)(8936002)(316002)(70586007)(5660300002)(41300700001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 21:23:17.5385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d9837f-bf80-4297-a6bf-08dac1cf740e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your comments. I will fix all these with next submission.

Lizhi

On 11/7/22 13:05, Bjorn Helgaas wrote:
> On Fri, Nov 04, 2022 at 08:24:14AM -0700, Lizhi Hou wrote:
>> The PCIe endpoint device such as Xilinx Alveo PCIe card maps the register
>> spaces from multiple hardware peripherals to its PCIe BAR. Normally,
>> the PCI core discovers devices and BARs using the PCI enumeration process.
>> There is no infrastructure to discover the hardware peripherals that are
>> present in a PCI device, and which can be accessed through the PCI BARs.
>>
>> For Alveo PCIe card, the card firmware provides a flattened device tree to
>> describe the hardware peripherals on its BARs. The Alveo card driver can
>> load this flattened device tree and leverage device tree framework to
>> generate platform devices for the hardware peripherals eventually.
>>
>> Apparently, the device tree framework requires a device tree node for the
>> PCIe device. Thus, it can generate the device tree nodes for hardware
>> peripherals underneath. Because PCIe is self discoverable bus, there might
>> not be a device tree node created for PCIe devices. This patch is to add
>> support to generate device tree node for PCIe devices. It introduces a
>> kernel option. When the option is turned on, the kernel will generate
> Specify the kernel option here.  These last two sentences should
> probably be a separate paragraph because they say specifically what
> this patch does.
>
>> device tree nodes for PCI bridges unconditionally.
>> It will also generate
>> a device tree node for Xilinx Alveo U50 by using PCI quirks.
> I think I would split the Xilinx Alveo U50 quirk to a separate patch
> from the infrastructure and make this patch more generic.
>
>> +config PCI_DYNAMIC_OF_NODES
>> +	bool "Device tree node for PCI devices"
>> +	depends on OF
>> +	select OF_DYNAMIC
>> +	help
>> +	  This option enables support for generating device tree nodes for some
>> +	  PCI devices. Thus, the driver of this kind can load and overlay
>> +	  flattened device tree for its downstream devices.
>> +
>> +	  Once this option is selected, the device tree nodes will be generated
>> +	  for all PCI/PCIE bridges.
> PCI/PCIe
>
> Actually, in this context (and in the commit log), you should just say
> "PCI" because there's nothing PCIe-specific here.
>
>> +void of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *parent, *dt_node = NULL;
>> +	const char *pci_type = "dev";
>> +	struct of_changeset *cset;
>> +	const char *full_name;
>> +	int ret;
>> +
>> +	/*
>> +	 * if there is already a device tree node linked to this device,
>> +	 * return immediately.
> s/if there/If there/
>
>> +	 */
>> +	if (pci_device_to_OF_node(pdev))
>> +		return;
>> +
>> +	/* check if there is device tree node for parent device */
> s/check/Check/
>
> Follow the style of the file, which is "capitalize English sentences."
