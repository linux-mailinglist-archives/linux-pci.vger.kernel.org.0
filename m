Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A46621E80
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 22:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKHVX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 16:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiKHVX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 16:23:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB621B1;
        Tue,  8 Nov 2022 13:23:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTYrjxsdY3ZWAJla9PFZKJxOR/h6PSltcDrw+WirPNNifB/IEpT8rGHTKV0nmfp8jF8DjxVMr9s7ls55PcvmSM8y8sOHZ2hILNHA5aIC5+oF8RiDIt8x7RX4637kQjVqQHkBKnYCjuYH4nQo8L/dUC81tgAwGw8IdwmTdPXS/CtVI9zBGHXIUhea5Fcy740AinEUgcZkxCJkTWnwHyT8MyGMN7TiPyRNHmBD7A/8VUHsv0e/xXvyvdH+Qy6o1jPUXN2TXBeP3zArNoAjjFdZabDJ43EQqpsTlR5cDKgwSEFfa4OGZjSEzAKh4nDlP0BLEN1iZgiE4D9ISbuv1xTgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odZzxDeh1zcp76hiTbsRYGkPv6bL7N13q9oyJD7M7E8=;
 b=WzTT3PM53fC0mkZpgHjwTr6D9NwH3t+nltao4hZ1FAKc7HYdPFYMNuqtd4OQ45OYsOTp0n+8DOa4V4BVHCmjm5Y5khHoY2zTk2xaZ4aSqBW7NSz0ehXyxE6Ht8AGnQ4q1B0t6JPc5oPVmwkTDPG6nekhhL3ytCLjWZn/xOniEdkPlObb8SB4AV90tHEpZj2yMEtqvaOhOg19VLvv/QhbhDV1Jgkz8QH79v1JK6+f+jRp1p43AURV6PD9bkdW195HA3fxOg0T1i/V/TIBjTSIugd/MxqAm2vvEll4wvYsJ/5lp3t61dCbYIieoT9goHTbrjQoZDJ/MCRaT/PvomPLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odZzxDeh1zcp76hiTbsRYGkPv6bL7N13q9oyJD7M7E8=;
 b=l3lflR169bonYijzi4DL5yCU8hcojkw+UiIm148G0qvL+8G1GhRfHFkKFx58bj4w7nEolnVrUt69Ayf6TyjVercXa81X9ZycwSlxEDWtyhxfDyTWrAJZo405RGZ5n+oY+fpz4mSeVOruTzVkfvhqvLbQ4NUBaht+IkF75AnxkjM=
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 21:23:22 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::7a) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Tue, 8 Nov 2022 21:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 21:23:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 14:50:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 14:50:49 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 8 Nov 2022 14:50:48 -0600
Message-ID: <ad614a7b-2a40-31a0-a624-779403d91498@amd.com>
Date:   Tue, 8 Nov 2022 12:50:43 -0800
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cb8d0d-9958-4073-7acf-08dac1cf76c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2N/sEIIo20KuYbKlPWgIv3mg7g36+b66kEe7eLB0BcHer8hWsnI3hpPLx/LxJiHTTH7argh+zmk4iLWakmB9/kXT+VS+sUxCRXNBb3cpPpG8He8ggO+3PozcQwl2ytnzM6DNQU1rrRitqvmqymca/IJi1Gx3yIQ+1o5qkLtlRbmntiRA+0Ew42tqsWBzhYb9Q2Oc0tMFJCzoIv11i7k3zr1GkkBI0jao+kH8nYoXVOUrGAzOhvqwi0drAifujgaDApRtkFvqRH+/sqOVvivVhqCvKsx4x3sQVzpC1K+xkFK/Td+IW5INHMVa7GvfOcu+kyePIYl0RgvPLDkLixUUisLBtdMlJnx1biNrJXH4w9NdYW5Dxpp7sDhE0alwx4Ny1ZuihhshEk69IX6XMz5QK86NfoDGsQYYfYypW0PfgZpSRSRMmDVtQE2ImMTGreN5eZatP5xqkEJOcDnR6/JlaIJnMWy+wQ/XZ0yca7kkV6IHqyz910NSjLPa/RjsVcw8HfFjev7FQuFYSRdqX87N+M/D+kTzX2Q0/2BCUMUbFKDip6O7N1rT2SbL3Y8xpJo7GrSXg5XHhGDDRdNgaXKgaooHLVGLj+ZKWLbRkl191RTqGZzM2lUuVMs7Rx8AXfGHOasMA8kgcdZkl0vBVzsTmUXFd9WAQ4O3dA9zwJUSq9kdi/rMoER+/4klxqXBfL7PmbVAyRYl4RaKLpT2EDdCPtv4VxGqjnYfDJv0dod8to6u9KVeAL9vaQBMiViDde2FmThg7aScx59ryyWQwlYwcvqN4jtF+esXK0W9ys++3zzyQbnXhtT5JWFmmY0dutSiDa6SRxmdCctXhXZk4+ZlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(44832011)(2616005)(6916009)(478600001)(47076005)(70586007)(426003)(8936002)(26005)(54906003)(41300700001)(186003)(4326008)(8676002)(83380400001)(5660300002)(336012)(2906002)(70206006)(31696002)(40480700001)(86362001)(82310400005)(36756003)(356005)(36860700001)(81166007)(6666004)(316002)(82740400003)(53546011)(31686004)(16576012)(40460700003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 21:23:22.0115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cb8d0d-9958-4073-7acf-08dac1cf76c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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
