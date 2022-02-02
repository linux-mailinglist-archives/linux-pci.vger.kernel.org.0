Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50704A6AD4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 05:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiBBER1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 23:17:27 -0500
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:40929
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230456AbiBBER0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 23:17:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py/gbvx+2azrJXizqZ1cJvmaf2d9VzX/2oI+voiQJSWucmn/ZF+F2spmMTPe7Fg4O+eqAuW1IH6gaX24bxGj661FUlL460oCnQMxEe9Pr1N0owp+Ho5iBNbh6dsGuPf9pnDhVGuUFQSFntII7ZTkDwq+/5L5AxmDnkf/VeYXOJU3oN7Jd9BZsfBC5Q7kiGlysKk9F97R2nll3KXXfI/BK7YxwP/IZ1QuFVwygrCRtU2mf70LS8/jL7E5WEbV/BGNXsiMKUDi/Iyc7fUIGUDzPns95RX8lzgI5CY1c1qK8J2Fhjcx4+rDH1EF1Tuy+nXvAod3D9AD3JO86YygOnVUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg+pcM2gFoObv9Qil2fKSsw3z+UevZFUIz5aF+CBaqw=;
 b=njjUXFz6TKOJzSVqHF21VKLOmugQXjBuQIsFxglfFLzQvqnsJiIvK3Vt1xl6h022DT7yP7bOGGDrSag+Tmk9vYLgnrwc/7pPZhCj3hItMOaSX/5I8JJw5TG6M+YKXkd1+GVtjgzvo/AfOADe6BvicEW1J9/0ntUSgvygMebuXQuqAjCPvWxQm0kutzjHOI5LURhKW3rXsFASGLtavZ8J7T7jxPRBU/PlNlKxImjk/NZpNBwHtYsb6NTuKhUTJbNWUoql4LbvcAPcF7luQg/LmQF3KyACrUtAchMo8jf1Ci+A+eQlvi08IDmQKURkWVyhes9skEDj4pXHF/uqFN5Tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg+pcM2gFoObv9Qil2fKSsw3z+UevZFUIz5aF+CBaqw=;
 b=G2WNSTKPXFVPSkIAorhHcQBy6XGRcAFJdg8ewnuMZg4IKGP5dTKBMRLR0/BtWEz3sdMOEGzkHdVc/PMYBMH7ODZXs4xWivK0F9hs531B8nswnNlY4ybXhX+KRpsVcmTRf8KwnHepn2qOLrqZJLM4CPGoYeqnmN7VstGsUPo20iSQQdPnFv4oSLOAIyL/H4cL4eo8O6KVuhlcs0nfz0zLOIFk5z6VVZ/3l9/8MZ21G07wP+ssXrhbzIlXcZmG4OC7JKi4CJEC8VoFqA1gEAqIt73fYXxGgv29uRU9VQ+viFdeVA874kt+q77oJRx3s9LcJ5r6vhakdr3p+4Y0PAxbyg==
Received: from BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12)
 by CY4PR12MB1301.namprd12.prod.outlook.com (2603:10b6:903:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 04:17:23 +0000
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 04:17:22 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::aa) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Wed, 2 Feb 2022 04:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 04:17:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 2 Feb
 2022 04:17:14 +0000
Received: from [10.25.79.72] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 20:17:08 -0800
Message-ID: <708b746c-1715-9d64-5a59-55c9ad81bd0a@nvidia.com>
Date:   Wed, 2 Feb 2022 09:47:06 +0530
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
 <2ab59f0d-3ae7-ca5e-6bfc-12bed18813b2@nvidia.com>
 <38a02915-906f-c53-7e13-6c8710315e7@panix.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <38a02915-906f-c53-7e13-6c8710315e7@panix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b290e84-6b56-4a90-d9da-08d9e602e611
X-MS-TrafficTypeDiagnostic: BL0PR12MB2403:EE_|CY4PR12MB1301:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2403F00EA00B6325CEAF79DFB8279@BL0PR12MB2403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC4MPh7u8J2JaVBoOmycp23BhHCSnrspQ22hfOXmlns1H20UOJvaAMOkSa/iGxE1WHjf9gPTajikSihQQksoKF6RRopLrA5+/e5amPC9/cImqKxebwIkfNCWQEN54Ewahf26d0EZnPNyhVE3IvfI26CGEt+EDALZ5gjZ16K9vGwrls2rHqRga2sSs9rmm4r4D6o+ssmm4XSc903XGMumJqkd1Tbx7VVq7IyZ9BNJw711sFoEsIvn610x1GT/dPfPqKXYhWIUjnT6n3TiLMyY65l1s0UM0jcU5pQGtl7jDzX1/skRANSlFz7ruMJPY+YGMD+sXrLot6kswn2MI4gA43h8X1xpaPEEwJaCwWwwx1WBvRWGv5Tx6TXHkwUc2zRTaqHVoW6OSx2riBbWMhBFlrzxauHl97iwpcnQnyzOHDeyA09HSTbXRlNN73zbPLyj39xImSx5nIqNLZUPBNHhpSfVxwqi/a9nOjex4eYzS0vCL6JE9BugnG+ElIyz9dJgOpmtacNBHh7+lBuFxPpUEF3oHEYwrzH4vhIF56oewWkjShWqPDQ5ZefFJC+PAam0CrL80X5mObK9CxGO6DudKyJ9X+1YWPkMGADQyjEmxcFBhSuP18cX2cm1VXHFbfCtpuasFbadxVYW7Kf/Vv0W0Bah5gRzFP0Wysqk9cxqz27fdhfl5BSJQjv2OqqdHol4HGOoxktEZLxgb93xONxYR2QeLz0ZxfQVYrfYcpzjQhF09Z6vRMBPYXq35wByPYuMIGB9MlXCMbOd8EMhzq4hMA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16576012)(508600001)(70586007)(86362001)(54906003)(316002)(356005)(70206006)(81166007)(6916009)(31686004)(36860700001)(31696002)(4326008)(8936002)(36756003)(8676002)(47076005)(83380400001)(16526019)(5660300002)(7416002)(186003)(2616005)(26005)(53546011)(2906002)(336012)(426003)(40460700003)(82310400004)(32563001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:17:17.1857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b290e84-6b56-4a90-d9da-08d9e602e611
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/2/2022 3:55 AM, Kenneth R. Crudup wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 2 Feb 2022, Vidya Sagar wrote:
> 
>> BTW, I see that the ASPM L1SS capability is supported by only two endpoints
>> viz. KIOXIA's NVMe drive and Realtek's Card reader. None of the root ports
>> seem to have the support. So, I'm wondering how was it even getting enabled in
>> the first place earlier?
> 
>> (OR)
> 
>> was it the case that L1SS sub-states were never enabled earlier also and the
>> issue was occurring without having ASPM L1SS enabled? (but with only L0s and
>> L1 enabled??)
> 
> I'm not proficient enough in PCIe to be able to be sure of the answers to those-
> what can/could I do to determine this?
Nothing at this point, but could you please confirm that you are using 
the same system as before? if that is the case, then, I'm not sure how 
is it possible that the earlier patch which is also for saving/restoring 
L1SS registers could affect a system that doesn't even support L1SS.

Bjorn, any thoughts on this?

> 
>> Also, I see that from 'before' and 'after' logs that for both NVMe and Card
>> reader and their corresponding root ports, none of the ASPM states are enabled
>> (not even L0s or L1).
>> Did you set the policy to 'powersupersave' before hibernating the system?
> 
> Yeah:
> 
> CONFIG_PCIEASPM_POWER_SUPERSAVE=y
> 
> My laptop loses ~1.5%/hr in S3; I was trying anything I could to reduce that,
> if possible.
> 
>          -Kenny
> 
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
