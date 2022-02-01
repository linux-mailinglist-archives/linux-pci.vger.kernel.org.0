Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59A4A64F1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiBATZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 14:25:01 -0500
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:42369
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242278AbiBATZA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 14:25:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX66V9kOGpsOFFWnX8Yv+K+Ra6+Y30JoAriNX3RkY1hiaokt6RMCJfUyF/OIdIDWb5squgnBpFV08pQK7w6fW680O6d1iSxcERJKX0pajRH+kCJ33OdS0SqHu4iakL5+KbwK0+inttufNePcWSDR7euuVC05lLzU7aXxvREqywR1sXXcZZg7mN9BrbhWpgLtDjREVqHuMBTQQGBV1Cjieik+G0qMDdNBzWvdUdZ6lJe6a4j9jH00ebDw39FLhCn94ZFwHnomGldPv6xtIiW7kP4MiYdA0V++Ex+rOSu/kAonYAvPSzvcZIzXON7j1DXb0KipRDJJlOsyHxGW85/ZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkBzZ3YCrSVUwjEK7OwyovLMRStuAgn6hJnkJueOZns=;
 b=L2fdu+YugMnbakOVCpsZfWTLzWSPDcbuF5+Oeq0GN3rpfWvA2fM61FkiTh5UxewBsdH5weKQ87/x88Q8Oa03XF9n7Hce/YhXXTf0WBOOqGfm5UwmLentnuHULPlfqkjgapY3+H1BXlK9rbizgsdiNyj3or9nKQkrHqyY5tJE+lobmYjRPKMzDp6awfTeYIXpRQtIo+pSd8WDjcrBs5+l62LnGKeayC8042W239+6jOfm196vIb13toHKZJ/PKiuQT+DCHo4K7p1jgh5+MkDAyTnCU962HK7CfsGHnkr1fmFMguJCU/3TWa8awL6tdIW/ENntlO5K2R2fEl5i2UCAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkBzZ3YCrSVUwjEK7OwyovLMRStuAgn6hJnkJueOZns=;
 b=halnAeGKuZhL6Tl4IYmxZRErvPM0CWVSc38w/VK8Rd+i3HS3CiZfpE8cU9XdLPJkhUjQ9T7aGhopMvsBN1cqobepShgER5idnt/09C5pcby7bjGO8v93d0qvg/B6L+YeXTbcjdxiaZbhV6Nhw6wohRTeWiq+802C/dDGzi1NltlwMi7rRRgPqOuYszh4EniamwoERXfZhvP6DbdRpdGcgWyqM6C9ElXf7HrTDnPgl/gl6/HqmwWSMs26p3chfBrfH4D2MaSjfPC5DEy/9/mUaHG+RZNYR3noJcWllS3wQCRrY6lIH4eKo04gtQD+k2coRSMHBUbKrUMYYaGQEULb7w==
Received: from MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11)
 by DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 19:24:58 +0000
Received: from MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::21)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 19:24:57 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::8) by MW4P220CA0016.outlook.office365.com
 (2603:10b6:303:115::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20 via Frontend
 Transport; Tue, 1 Feb 2022 19:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 19:24:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 19:24:56 +0000
Received: from [10.25.79.72] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 11:24:51 -0800
Message-ID: <2ab59f0d-3ae7-ca5e-6bfc-12bed18813b2@nvidia.com>
Date:   Wed, 2 Feb 2022 00:54:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     "Kenneth R. Crudup" <kenny@panix.com>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <hkallweit1@gmail.com>, <wangxiongfeng2@huawei.com>,
        <mika.westerberg@linux.intel.com>, <kai.heng.feng@canonical.com>,
        <chris.packham@alliedtelesis.co.nz>, <yangyicong@hisilicon.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <abhsahu@nvidia.com>,
        <sagupta@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20220201123536.12962-1-vidyas@nvidia.com>
 <8aa96f79-402-4897-424f-64a2c6893de8@panix.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <8aa96f79-402-4897-424f-64a2c6893de8@panix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5575b5a7-31de-4002-0b94-08d9e5b88858
X-MS-TrafficTypeDiagnostic: MW3PR12MB4569:EE_|DM5PR12MB1163:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45699D154B040510951DBC4AB8269@MW3PR12MB4569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhVHgEeie9yuUqwRqKzuvfVPy6Uusxxvo97PNAL6Jkd2jtR2sOo/N/wUZ6yAY4BWJcNyQBndGP0QLUTJEsqvS6vEYETKhodBbl06Gax9QkKm2Xtv/n4LFDr0GACnT+E0vuBOJvrzEaDofWkF2SydZtQvrG3iIKHPQJGTkEGi9rnK10Zbmz/WKm38Y3HftYu+HK69BWKjglSlmPsFXCG5S3RVTBnrwW+T74i+coQwhvtdpP3g6aUrEnsJaCKAvlBzxUdxpL1xzQs1RznFLclBYaieW3uhvTOD9DJahT/GcYjGCCDss4q6/glkm4XTfnkhNJeVgMyrgteEfMIjTl7d2vnowHJM+filBSlkNOcW2q05gUw8LJ160EZXD144AkbrvJf/VJc+EwMYXPh863LFAqsQWaXWftUXB9vQ7x2I9K4EyUHlvJsuZGA8VzbgVPoRXqB334C4JgyI42pymJ1bgaSrQtMzCoyIt0/PxCdVl49aXLWrtleMLLO5Q5cZmEUnCewir/CkHTo11/iM5X5n/WLhrcWwL5HXnWzGE5MIPIsHpVqOsccGz4A5VEzT1n0kPaHs6LBrAylT8VdmLdT0+dRkuI2/pzDAf7cx6LhLYgjQhkkItsW3orWcUH3WW/GA3blTLR97zFRPizXX6J5fh01j3i/KQVMjRpaAJGCeQHKgfrcYhpbahehniZs8mRXydDWG59rdkuNwt7kdrMaHWe4aZ8QQ3JIdJBuXNiB4wh9kYw8mQ8e8uMI1lTtSMJzj1rmtWdzIZVEaNpvBFs6dhA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(6916009)(16576012)(31686004)(31696002)(316002)(4326008)(356005)(40460700003)(5660300002)(36860700001)(508600001)(86362001)(47076005)(7416002)(6666004)(36756003)(16526019)(2906002)(81166007)(53546011)(26005)(8936002)(8676002)(70206006)(70586007)(82310400004)(336012)(54906003)(186003)(2616005)(426003)(32563001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 19:24:57.2756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5575b5a7-31de-4002-0b94-08d9e5b88858
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kenneth,
Thanks for sharing the files.
BTW, I see that the ASPM L1SS capability is supported by only two 
endpoints viz. KIOXIA's NVMe drive and Realtek's Card reader. None of 
the root ports seem to have the support. So, I'm wondering how was it 
even getting enabled in the first place earlier?
(OR)
was it the case that L1SS sub-states were never enabled earlier also and 
the issue was occurring without having ASPM L1SS enabled? (but with only 
L0s and L1 enabled??)

Also, I see that from 'before' and 'after' logs that for both NVMe and 
Card reader and their corresponding root ports, none of the ASPM states 
are enabled (not even L0s or L1).
Did you set the policy to 'powersupersave' before hibernating the system?

On 2/2/2022 12:23 AM, Kenneth R. Crudup wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, 1 Feb 2022, Vidya Sagar wrote:
> 
>> Kenneth R. Crudup <kenny@panix.com>
>> Could you please try this patch on top of linux-next and collect more info?
>> - 'sudo lspci -vvvv' output before and after hibernation
> 
> See attached. Added a diff file, too.
> 
>> - could you please confirm the working of this patch for non NVMe devices that
>>    support L1 Sub-States?
> 
> It seems to work, I'm on it now. I saw a "GPU Hang" from the i915 driver, but
> it doesn't seem to be affecting the GPU any.
> 
>> - Could you please try "NVME_QUIRK_NO_DEEPEST_PS" and "NVME_QUIRK_SIMPLE_SUSPEND"
>>    quirks (one at a time) in check_vendor_combination_bug() API and see if it
>>    makes any difference?
> 
> Do you still need me to do that, since this appears to work?
> 
> I will try another hibernate attempt just to be sure, too.
> 
>          -Kenny
> 
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
