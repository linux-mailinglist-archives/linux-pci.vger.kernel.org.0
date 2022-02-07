Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057C94ABF11
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377732AbiBGNMU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 08:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442757AbiBGMVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 07:21:38 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A9E01CF7C;
        Mon,  7 Feb 2022 04:11:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSXbQp5+kobZRRCWsP32cki5g0T34eILRBBAoXCOQpw1JHKp4TiSOpmG4g/suVpgmK/zIIQCz4bMPjyLrB8xXsr6syGLiHZVj06dPMSl6rpWiz9uMfRjfBz54vIlFhOxmFrySJdqUptr4khcykR3PG08VRskKBwwHq/E8FWTcKCmJpncq11F/KGqQT3okDZ48U1NpGuBF+9WbkMqjxmQqITf/4Qk+OCmClw3wf/6DEd0WTpTfMGx/owLt47yEf5ugYz44mmt4YhpDgF7MCb/GhJdkAW7/VN9oN63a95UeSK5hNmJWeJp5wKGUK20GTw14Fh5+jd5W2ZAGuuI+jrtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBkBRpwBXNSYPqCLE9zV60zZI9Itw9vCm4Qb+wsn6+4=;
 b=YKtgqSCmJlaTxxR5VG0LB0h8fxI7/8FTR5pzOApLcvWghstRyUpE0Qq6CcDEDe3b4yyvgp2TAzck3GqUOPgWCoe4gAY6OwidWHwkmha7yEaGLltC/1fTeEFHG/Uysahtn5FIz2cBwe2vM+J+4Mutb+puQfs3j0e3+GistVCkNbMP58Xuw9LOd9YJOGg/9DhyL7AixMmUYyBGNoVnL4r9M8lwjzxRHBisyhJe8/Als7A5i5Il0AUPR5qRA5CM1ND23a28PGM8//6T9yNPUEeXEmI3v+p3gwBOmNEwCEXp3suKTjgun83L0swaUrOtnhS7UR7bmp5D3KQm9MsiRlTkrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBkBRpwBXNSYPqCLE9zV60zZI9Itw9vCm4Qb+wsn6+4=;
 b=JGCR5z+8JRZt+TTHrtKUfFdP0IIN39vrDAX7iQJiJKAy51Asrh69Ouw+bXnMeSzlV2V4WJ9gf0wbw9nsforFW/a+arwacuDxF/w5j/0x8dSiZTUNKPBuQe+rlPKrpxCF3nLVuwUFgCiDBD4TnFqYS3C7/VgeWoeSO+H06KC1KyB2TAk+OZKMOzp0xqcGAJdpCK/cNeUa3mmCj1ZQvcaTkHg6sTM2ozMfsIrr6o35fJw6MTAjsYgp/2X3sxxCElPXGriOaudcEBlkAZoxaDZjpeuuArFagDHhGeyfUQaOZW090TzDAIPsICiBh1QAWdlYQGWevqMF9Y8KxLVcGQAg/g==
Received: from BN6PR22CA0043.namprd22.prod.outlook.com (2603:10b6:404:37::29)
 by DM6PR12MB2953.namprd12.prod.outlook.com (2603:10b6:5:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 12:11:37 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::6e) by BN6PR22CA0043.outlook.office365.com
 (2603:10b6:404:37::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 12:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 12:11:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 12:11:36 +0000
Received: from [10.25.77.245] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Feb 2022
 04:11:32 -0800
Message-ID: <cc0b6768-5722-2277-6e51-75baf3311dc5@nvidia.com>
Date:   Mon, 7 Feb 2022 17:41:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Query related to shutting down NVMe during system suspend
Content-Language: en-US
To:     <nitirawa@codeaurora.org>
CC:     Keith Busch <kbusch@kernel.org>, <rafael.j.wysocki@intel.com>,
        <hch@lst.de>, <bhelgaas@google.com>, <mmaddireddy@nvidia.com>,
        <kthota@nvidia.com>, <sagar.tv@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
 <0bd9fdc1-99d4-1c59-7343-3708b331b2b5@nvidia.com>
 <24710253b2e34dfdd81ebe1f46b84652@codeaurora.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <24710253b2e34dfdd81ebe1f46b84652@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dce19bd-cb05-43ca-e7bf-08d9ea32fd76
X-MS-TrafficTypeDiagnostic: DM6PR12MB2953:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2953ECE96CC39122E01908C9B82C9@DM6PR12MB2953.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t65SBOr59bCLitKlGF3Ur/aBKdMW8Hi8fP8TScMRnw2PvnwreWOFqdLxGBlRY+R25e9er8pBkmRuRH9vF/kQvLE1MVIsYAne7/N6mIfCp2otHGtH/UYk+yvB03+ZhT2ktHMZlmC5nWDkKV0dIwLVmKBlzybtlab1ja9pmrzDDANJZGXy49EACn+Wc0cE/XAKGEfwutR1cuuN0E8HpFFueHubRPeMWFUgZ0emqNFEQ/oZNH0QjfVDTRio+y3z8o1z429oITgqKIl546o6SeiGlwHxofHetfVd9ZFivx0ou/iXH4jbizey0oYnH/LVThlKEzC6JLqbKvoDHzv+k6rqhwxBSjhGJU5zABSdS4J5BPe4YDiRjziBCIUEbg3LVgnHYyw/fBzchsmkR9b/xLYZhfMCbEA/ZyHgCY4QgmR9w4FtXBY9947Y7Vk0V1mxHpuivXjIsBzU7FVt6ZStEm0emyVABLfpreuGvuzoy3mW37m6Wy+XSpI9fbB/nzGoK1XjdFTVnLbZAhYYDX1wkjSUOHsxDSyONu4+GHVV1N428SLTbTO5FyVRyDGmMMgktvC3GN5hrG2obNF3zxktIiff1Bok+JiWwHZJHry7oMTO0eV5XK6k9pxAE0UKuFX2noSoHYnJQNdf+Ngsw7hLhCx+QxlByaFhCoFl1tYB/qhcfQbCa2OX6HVWMp68yOqGTlL+20PKpC/HiFCR4GtivjCnUiM8Y3aqL9/u8c4hkmAkfkwL1Edu3blyVtb6/bEKOTUoiAaVbQeQSIQ3PqrATfMLbCDgVR4KlbM1izL02cA9umWGatIlRYS87IpBX4KWjJHOpZKcBAFQ1lXSMbWCjzWTdKfMKG11beaFhc5iQaqiDw=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16576012)(6916009)(966005)(40460700003)(508600001)(53546011)(54906003)(316002)(4326008)(8676002)(8936002)(86362001)(70586007)(70206006)(36860700001)(82310400004)(81166007)(15650500001)(47076005)(356005)(5660300002)(83380400001)(31686004)(31696002)(2616005)(26005)(336012)(426003)(16526019)(186003)(36756003)(2906002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 12:11:36.9609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dce19bd-cb05-43ca-e7bf-08d9ea32fd76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2953
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/7/2022 4:27 PM, nitirawa@codeaurora.org wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022-02-01 22:28, Vidya Sagar wrote:
>> Thanks for the super quick reply and I couldn't agree more.
>>
>> On 2/1/2022 10:00 PM, Keith Busch wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
>>>> Hi Rafael & Christoph,
>>>> My query is regarding the comment and the code that follows after it
>>>> at
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243 
>>>>
>>>> What I understood from it is that, there is an underlying assumption
>>>> that the power to the devices is not removed during the suspend call.
>>>> In the case of device-tree based platforms like Tegra194, power is
>>>> indeed removed to the devices during suspend-resume process. Hence,
>>>> the
>>>> NVMe devices need to be taken through the shutdown path irrespective
>>>> of
>>>> whether the ASPM states are enabled or not.
>>>> I would like to hear from you the best method to follow to achieve
>>>> this.
>>>
>>> Since platform makers can't converge on how to let a driver know what
>>> it's supposed to do, I suggest we default to the simple shutdown
>>> suspend
>>> all the time. We can add a module parameter to let a user request nvme
>>> power management if they really want it. No matter what we do here,
>>> someone is going to complain, but at least simple shutdown is safe...
>>>
> 
> Hi Vidya,
> 
> Are you planning to add module parameter based on above discussion. I
> see similar behaviour even with  qualcomm platform.
> 
> [  119.994092] nvme nvme0: I/O 9 QID 0 timeout, reset controller
> [  120.006612] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe4 returns
> -16
> [  120.013502] nvme 0001:01:00.0: PM: pci_pm_resume+0x0/0xe4 returned
> -16 after 60059958 usecs
> [  120.022239] nvme 0001:01:00.0: PM: failed to resume async: error -16
Not really.
Keith Busch has already pushed a patch to fix it in a different way and 
issue is resolved (on Tegra platforms) with that patch.
https://lore.kernel.org/all/20220201165006.3074615-1-kbusch@kernel.org/ 
is that patch.

Thanks & Regards,
Vidya Sagar
> 
> Regards,
> Nitin
> 
> 
