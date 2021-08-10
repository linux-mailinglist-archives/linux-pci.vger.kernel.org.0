Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282CB3E7BC2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbhHJPKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 11:10:08 -0400
Received: from mail-bn1nam07on2079.outbound.protection.outlook.com ([40.107.212.79]:20634
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241056AbhHJPKG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 11:10:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaBuLYhMDfcJL0atW+Mt5eY0UonfgYZrkYuocpiviiIem+YIx4g+FCWuvbLO2CHkatGrGJfOhQecHQqfEc4AkmujEdp0LDFhB17xbdovoWb4DM2s/1m0z9rMJGXyKPJ6VYAbmFG6T1ncjKUQCQrhK8dc7WIL5R2KnMSWqgmeor2HsKhnC5MgIEh2ptKKN4gfcy+v06pPsp4E1J7X0qNqNDsOiKUVd7aG83xdwNEn9izaFgUR/epHU6QNKsGROUf3oe9HiNRS6N7YuuJIwvMfRi9PffHbm59QBixjZRuij9IfeLJk3KJfXO8MTIL/iNP6zi7C2uTqskQwNpU9k6ufNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfRVAHzzIgt8lhRgwB/7MDIgeSgUJsSUblEOuuolmEI=;
 b=QFiba5kCQQewKYnRhuRlZzgUGIFHi3hbrUCh2VPyu6gftVB6x5a4aoyCaWC1hgG4HiFrJXmad3PRYnn6qX6wH3Uw0K6xXAe49IRpwUId9UmId/DfG43Yhh8CoyGNSOSIY1gjJ/RIW00p4ltfmKxpT8uAyt1SEmIDktK+/zKUW9lI6xOz03YAgsNZFum0G41bEAYLUWFS/AEJFpvOD4hNHZ1/ew2PFWKW7HsnxLOm4DB3XI2ytRAV9wyFYBkGOB07/dVmQceV1lsIJ54w38PDzjQjVfB1qs8PHi+0LtzhkpktbbT5Ke0g3ZrZBMV/0Mdgz4aY4qyFbW/2sx/LP1bNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfRVAHzzIgt8lhRgwB/7MDIgeSgUJsSUblEOuuolmEI=;
 b=retQZaT71VH8pVDHqUjeDtDmW7ruMZYmhNK0mGxhEIvXP/XudzDXKgeyovfCvM070x5bwU5huLDX5WnlYAm1RkumjAWvv7VFMzkNVxBj5Ntxw7L32510h9b1Um02Tw/3Me9i1OnH1sAholEYLZDzqiqflsinqR6Ke9zCHcBIGhk2fTWnVB5B/JMemL4nIu9CGdeimNGkCPVgEwy7n7A4yK32bIz80vgCYbmyqh09eZKKsYtoGtOIfBLj4BMQQQ3IUawFetfN+06srKLpdHEyLVDleFnzDU9LsAe7DFRqvqkm4pxLGBzFTkDm1jUyw7baF0AVwhkjIWevwN70wB7p0A==
Received: from DM5PR12CA0063.namprd12.prod.outlook.com (2603:10b6:3:103::25)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 15:09:39 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::da) by DM5PR12CA0063.outlook.office365.com
 (2603:10b6:3:103::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Tue, 10 Aug 2021 15:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 15:09:39 +0000
Received: from [10.20.114.145] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Aug
 2021 15:09:37 +0000
Subject: Re: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
To:     Jeremy Linton <jeremy.linton@arm.com>, <linux-pci@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <nsaenz@kernel.org>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210805211200.491275-1-jeremy.linton@arm.com>
 <20210805211200.491275-4-jeremy.linton@arm.com>
 <b574f9bb-72f3-72cd-9a6a-f1f4d998afda@nvidia.com>
 <1ed33f6e-fbfb-e8a0-741e-6961f9a7072b@arm.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <4dbb779a-4cf2-6cb8-81b5-871a12b1f883@nvidia.com>
Date:   Tue, 10 Aug 2021 10:09:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1ed33f6e-fbfb-e8a0-741e-6961f9a7072b@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dcd0dcd-b7d6-48f6-4bfc-08d95c10e008
X-MS-TrafficTypeDiagnostic: MW3PR12MB4427:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4427830BAAE3B85CE4AFF021C7F79@MW3PR12MB4427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlWPs1tD3TUwr4idNIDV9c1+54ikqv+C5mxkLzIg4Hs/KY4xyxQ1O+p0wHWs5QIEoe5j8KGrRC05jJbQAVavO2t+2qPRsnM2Er6SJJNzT1U6Ff8HIq29eONfqhoZhj2MELMEzlrjFTjEKUYYnRBVkcexrzk2Gjlm9ofGy+3NMs79LGSuqF4P0WJWE7wRgs3927k5J3tODVIuLPXf7OMZmlWBxF8gv62MFpzR8dLdJBZNNLW64UvflZvXfuJ9Hk3VSO+DoGHGTe8yPKm36BoFoBmowW28dTbB90zXOMW5/VHWoc5SDfbdhRrJypG6Ylpk7naa0awgsB0HpX6bqyz+x/+63FGcLJrs/s0k08f6Cupf5RBv/pFF2+rtmp6sI5WCSJxAO4JATwBfVVfIGSHjPtNecKQS5mMo2k/W7lcEJtxuCgvKr7YslwbYnS5nCsqqSDyAE3uyxxy/5cYdBrx9nKpMLOgaIjTrYkGOQbfKj7o1lrspDSggmps3/6yHlPXRyrb1mWM8J1QwRdv4m/flRZs5a9KMrSSxt5CMUX1sjS0SMIH/JZmzU08BXHaJdCbFW6mF6fiWUBDUjcIFPMC0uBHQwxjDpOYIAtpdZvvuvOnBYKb6FAr50UYaZtTxRrBb2MA0UzmVW8AhRi3kzsPPkKfRKALVB9WMnFdLwM/efqph990j6nCZ9WVE8uqzcD9bn+Zqw/NBcO65pSK4bKvP9XRu7JyEd4TEVot/dACtbUc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(82740400003)(2906002)(31696002)(8676002)(31686004)(36906005)(7636003)(16526019)(7416002)(316002)(16576012)(186003)(36756003)(110136005)(478600001)(4326008)(82310400003)(356005)(70206006)(70586007)(26005)(426003)(54906003)(86362001)(36860700001)(2616005)(53546011)(5660300002)(47076005)(8936002)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:09:39.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcd0dcd-b7d6-48f6-4bfc-08d95c10e008
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/10/21 9:47 AM, Jeremy Linton wrote:
>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>> index 53cab975f612..7d77fc72c2a4 100644
>>> --- a/drivers/acpi/pci_mcfg.c
>>> +++ b/drivers/acpi/pci_mcfg.c
>>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>>          ALTRA_ECAM_QUIRK(1, 13),
>>>          ALTRA_ECAM_QUIRK(1, 14),
>>>          ALTRA_ECAM_QUIRK(1, 15),
>>> +
>>> +       { "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>>> +         DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>>   };
>>>
>>>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>>> @@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>>>          u16 segment = root->segment;
>>>          struct resource *bus_range = &root->secondary;
>>>          struct mcfg_fixup *f;
>>> +       const char *soc;
>>>          int i;
>>>
>>> +       /*
>>> +        * This could be a machine with a PCI/SMC conduit,
>>> +        * which means it doens't have MCFG. Get the machineid from
>>> +        * the namespace definition instead.
>>> +        */
>>> +       if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
>>> +                                        "linux,pcie-quirk", &soc)) {
>>> +               memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>>> +       }
>>> +
>>
>> Is there any specific reason for not using the firmware agnostic API to get properties?
>>
>>
>>   if (!device_property_read_string(root->device, "linux,pcie-quirk", &soc)) {
>>       memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
>>   }
>>
>>
>
> IIRC it was because the "device" here isn't a struct device, rather a
> struct acpi_device. I think this is the normal way in this situation
> since we are directly picking up the fwnode rather than finding a
> generic node and then backtracking to get the fwnode. 

Yes, you are right.
