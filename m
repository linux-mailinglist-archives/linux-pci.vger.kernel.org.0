Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9AC4AAA3A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiBEQoV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:44:21 -0500
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:46176
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233494AbiBEQoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:44:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYpKIuWv7a5iRXNat0wA6gi0sT1gEQqkogwXsK8su+mvrwa7KuxVtbk7dgPmD8Ju7SouHfOHx5DMGcr6XlhkxMAqkYYpDyST7Q5dyrPS8TUF13C7wGisrrn3dLcIXrbx5G4UgLRaE5vxxniVLX3As4sKpG9awFsdeJo+kzz7g/fmRcS/1UsCfuYjoNvbEikg/ZihngB7me1hABNDIB4IYuKDI1sbvQlXnkV9w+jL7yqFq6qNV/NecJV1WVKwCZw38rlO6CuF6J3b71c1FfzZRyFIyW+xUo4+Wgfabo/IJV5ce+eI+xWN1SNu6kALYHGiLdK+ZYmDB28NJJYGGIWstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJcrahXrs0BxVyl9DrCC1T+PdhtX6OyNfMjfqig9uWY=;
 b=S4ONeYgSfG1lLLCesen0cmlgmJ0BvU85xAGGGAogvcjtXwyUmacabvrAbj9V/cHLOIUFW+cmSvyga+pOjUD44rB2QHNvukRS/kHuhXRMR0sqjiuzfo2dyrxNj7OhekOIlEDaxVwl1BVB1FgTXdCrszGO30Nv26aCxBkJl2Q+w3hmpoplNQI4IM1vzM2Wxpn2kLoihQwy87zudnmcjXsL2QH2ZzKJewAt4KO0CJ+2GErkZVoPvdLj2493idT6ZjQUFYHnLqnApOqzJp3swL3j1+ZjR7wuEloqpx7uyZfvFDakBc8oX3hQRzVJa652TFUI8CtGwAzNb0EJx6tG1FmLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJcrahXrs0BxVyl9DrCC1T+PdhtX6OyNfMjfqig9uWY=;
 b=WSki6s1u17yf6ndQqty4+3Y838OfsCqdDLqhg0ZGBi3x/jK97oOW9Mp3JBVzD0y1eMnl1N98+AUGeGYCBUi13g0RI/wC68gcBXWb3wlMF/U9i0L8/N7vUqXYuSEkw61ndkE1jmEFlkLjRKlwYhaBub0zI7UwzD56o7q2nf+Y0lfcnhv/P+4HkGE+X8iPt89feIF4VJuJW45XR4dkf/UGi38OFcAggxIgbwoqIzyG6MKH+unevTR7JEVku1XO7a5p8TaPVUHSJkkZ/IPqSFNN0rzIWyPOOneMzciGfirrfjQogw3IkORW1mqmNWLveo6AEIMqDO8CaHMBwoHcqE4NXw==
Received: from BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 16:44:19 +0000
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 16:44:15 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::7) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 16:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:44:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:44:14 +0000
Received: from [10.25.79.243] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:44:08 -0800
Message-ID: <47c4eb66-c81e-05e7-b31f-ace8b61b09fa@nvidia.com>
Date:   Sat, 5 Feb 2022 22:14:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <hkallweit1@gmail.com>, <wangxiongfeng2@huawei.com>,
        <mika.westerberg@linux.intel.com>, <kai.heng.feng@canonical.com>,
        <chris.packham@alliedtelesis.co.nz>, <yangyicong@hisilicon.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <abhsahu@nvidia.com>,
        <sagupta@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20220204230234.GA226601@bhelgaas>
 <7b377c19-23-6793-5e43-b757cfd8437@panix.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <7b377c19-23-6793-5e43-b757cfd8437@panix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08cd5b45-9b40-4b84-311d-08d9e8c6beb3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2632:EE_|DM6PR12MB4234:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2632F6F7E0EF31B1D88A8EA0B82A9@BYAPR12MB2632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zE2dvdUM8JhjC6qWeupkAns9+sVDjQ87EKZPATWVy9+nWID5ZhUQBTKLO5AwwsWNXPH4VM75krtGnHhUAJWckVNlFEC9vWtPBaq68L23bR4TGkEGMhAHIV1dOYqgbygmZyl6bzt7z2/p1CP2rFPMr5NafURLKWcgxTOS3DObM8ytRmVKimSXX/0LeUQDfwWjmiUb8rYf7041wDtpBLAXh8Hz6pIhUDKg/Ly38T35VaDTfiZ5bxMrMjAujLqsU8YZNGfUt/d6bnAVBJe1tp9im5EYykiIQMze5NIy2PvSRleLy+v1qDqpcpLRN9/UY9OuVTQYXwyTgXeiQabETDDcA89Fcf5lplXn6mQW62RvxLz3E4w3Tla3TvWaJALZw2IOOXsLXaB390jJT1FPX7muZJK3nB9hWDKVWXqgt/z0Zz3T3xKTrY7OiKzzfhdmrRZxOYZm8yYJxMcxeL0PZ3VDszMIUtpjkI+8Ikw/pDJJAr/gxKFyAAys3zcIUpAKb7wcCG1ReMeLdymahbhDPfKqiRCSpS2caHj+wDysNgIHs7dtmFVnomEgmNRCw9uSKl0m60t93okyIt0k4Ya8Bw4LPWkVa1vqorbvx/YTFekIYIHMLMcn4iYZ2nB9EmHxxys1ag3uNTfNT6PS/N0bH+gnQc0RGXYyWG2po87SlWe7oPcdd5N7GOYluEVlcwkaopPn8LKwyc+ebn3KGiojO9SDhGq/jMQG4BFCbtCdoKt/+EMkER29wcUWzOygxLmoo0DHcbhbJHc8rxtCYWnhp9569w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(4326008)(70206006)(508600001)(2616005)(8676002)(70586007)(53546011)(316002)(16576012)(336012)(54906003)(426003)(31696002)(86362001)(81166007)(36860700001)(36756003)(110136005)(7416002)(82310400004)(2906002)(31686004)(16526019)(40460700003)(26005)(47076005)(356005)(186003)(5660300002)(32563001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:44:14.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cd5b45-9b40-4b84-311d-08d9e8c6beb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/5/2022 4:47 AM, Kenneth R. Crudup wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, 4 Feb 2022, Bjorn Helgaas wrote:
> 
>> Do we have a theory on what might have caused the regression before?
>> Or at least something that is different this time around?
> 
> If you'd like, I could try re-applying the previous problem commit or your
> attempted fix on top of Linus' master if you'd like to see if something was
> fixed somewhere else in the PCIe subsystem, but if you think it's not worth-
> while I'm satisfied with the current fix (or probably more-exactly for my
> particular machine, lack of regression).
That would be a good starting point to understand it better. In fact if 
the previous problematic patch works fine on master, then, we are sure 
that something in the sub-system would have fixed the issue.
I'll wait for the outcome of this experiment before re-sending my patch.
Thanks in advance Kenny for volunteering for this activity.

- Vidya Sagar
> 
>          -Kenny
> 
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
