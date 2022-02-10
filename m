Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5704B0445
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 05:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiBJELQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 23:11:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBJELP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 23:11:15 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F77F1EADC;
        Wed,  9 Feb 2022 20:11:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceINkZOUqJj6poia2Gr/nvAILWaLYkTggPne0BIKXMMfQeQS1VASEyAgngyGm5S2N4AuWxP+ANrXxJaLM6JN2wQr3hhTh2/cLJjlJ8f5lBrnxSgf3atmJr9cOQHxyyVjbFVYN9fzGN8rBlJjFNuytypu2Gd+0uNKfd5jJp9RwqkekBZgj/qIfx1hCmDMufNzr149SzEFYXVTlwNpCrpT7bWDe+YflPNcgzIPT7UvMUx6h32YaM1k39FjOUeqOk8YH52o/wmMh+wI8+q4DcaDSNl+ba8xMP79lYnvpVXp2058AI3MZOOT+wgqvrvts876xGT29qoSyFxrnr6V7BI6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJkZQ/ansNT8Yy/AQj6IyrWLaPeP3kJgF/1HtXp4U4=;
 b=WGZSf6rJzvfobZ7gjU1Lmewwj/uBmsu9pRN0qNRXGV3wnwDPnRJPQSqMZ8yga7hdi/IK6Dhg7HCr+Q01UYq418+UFzFI0qhuerftaJDbVKMoCuc6Cq+Ew48RRrXxiI4xe79Cg7ao7nUlsVhQhaOJiqZycDBx0oz51NhruiEOTWG/rFtkM1mcgITyrrmCvQUgkX7/f+8FvBc8tWfNSkanYsG+GUig3izwrsvt7M3NEBoVMQLgX3553HWGq4eb3OF65ZO96DjF6qAAxdHTb9e3PhivgFuB9mM6CBFGBPmj81AJYssa2e6mHf3YxoleISKuKOEqJH8XLj+kq94gwlTCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJkZQ/ansNT8Yy/AQj6IyrWLaPeP3kJgF/1HtXp4U4=;
 b=FdcYgbRMzhH48MUmdn+hU6Kb01p14VdavKnYkw3HCkzFXlf55w2dkDAsKKbmJy0eBG+zIhoGncjRN9USIj7yMfc5x4El3HTqjMzAOJjbCPmeluNuo2RF/sKcfjp78tePV80lxQZM7EHO32E4+/87Zg2gIgE5cr2yeqfObXR4WhwGwDBv9KlzmYhWKpiT9pHcdkQl7w6GKCjFud1BsAG0tiixeSQyPPoxfdNbZq+sAiZo11rjVyNxTbyFlOLy0pWusVImkoNEgtX5Os6JCG8pBz56f2VpnmV/2z/i4IFxKr6vSZkIT6Utm0wxAw+imOEqxuSa187K/wXLWfLZgoX0Mw==
Received: from DM5PR07CA0140.namprd07.prod.outlook.com (2603:10b6:3:13e::30)
 by MN2PR12MB2895.namprd12.prod.outlook.com (2603:10b6:208:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 04:11:13 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::84) by DM5PR07CA0140.outlook.office365.com
 (2603:10b6:3:13e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 04:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 04:11:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 04:11:12 +0000
Received: from [10.25.73.196] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Feb 2022
 20:11:08 -0800
Message-ID: <0801d0ee-1c39-4413-7865-6c1c61e4706e@nvidia.com>
Date:   Thu, 10 Feb 2022 09:41:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Query related to shutting down NVMe during system suspend
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, <robh+dt@kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <keith.busch@intel.com>,
        <hch@lst.de>, <bhelgaas@google.com>, <mmaddireddy@nvidia.com>,
        <kthota@nvidia.com>, <sagar.tv@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a44ab84-0a4a-4545-bf29-08d9ec4b6004
X-MS-TrafficTypeDiagnostic: MN2PR12MB2895:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2895F1CC2751537355E04B4CB82F9@MN2PR12MB2895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r95n7uvL/KPfIYJMWcdPiXxW3WwAfiTjAlPXN1qXr6jCSNUWQRbJ+nteiJ0FxTHUfnJ1/eF5wSPDwvQ7Bcoyw1/d2FXy2hZ9NjPRl06gNGXgSts92xH7d7WhosTY0YZOXDt3OwGyW0blejyHRV3c4kLl8DX1R1eIiKuiagSEh1rUYF39nku1gPaHOqVSggilRkm88UDnmJqXvTNB1IflOGxo6FlCz2zk01YHYLMtvMZWFmStdnsizCMx9Zf4wBUFGeOAFv7VCx45sRji33WutGOzeENeFiqf+49Xno4EZGQk+lKCGWWpvpWqj9APdVk7h1b9Ik+Y4da0BqDbb/WZWzK4GjoKUssIwUjndnCkzksR0zuP671gQPSSn/biADpc2UGIIegy0GjwqfZdxUy1fQ59FsMldOo5PaKzSYJFVHkBaxxeKFa/7gJShz7esOBmwIKwLpV5OPubwqqITAsXtW9XPElS4EXoBeFdaANpQqr7u6JXhKA8zTBYOdlRabqiYB1M6iBsxgTLQ4eY1cfvQQlLO4qa3oohGnsWmXmnVsOeti7ybOoIe6EGOjQHjSuFeIeHjlTwu4NdZguYJ0fDfFev3B+Lf8X8woNtYcscuaRKrrm2FTgnmFSATrpr8u8FwPD8ThXu4PpAFcFEfTLxphkT+Z6CBzNa3jnLSkeV86f4lS5V1WV5Va4oyZRwqx8XtXf/T562RQbCsVUHhZar+6URToe7GARVpZxTX5qyY+/oWVVxNu7xVh7x+viOnXDQ/1aBzEl8mNKNhfRMtbDh0VQO9AOxc6E9Ib3XclBmNTAzFaNKI4+DtWkCwlpuA0xV7Nqk1wHGcvX88c5dbj/P2g==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(8676002)(53546011)(8936002)(86362001)(966005)(4326008)(15650500001)(40460700003)(508600001)(16576012)(31696002)(2906002)(6666004)(426003)(5660300002)(82310400004)(26005)(16526019)(2616005)(54906003)(31686004)(316002)(70586007)(186003)(83380400001)(36756003)(356005)(47076005)(81166007)(110136005)(70206006)(336012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 04:11:12.6168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a44ab84-0a4a-4545-bf29-08d9ec4b6004
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2895
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



On 2/10/2022 1:56 AM, Keith Busch wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
>> Hi Rafael & Christoph,
>> My query is regarding the comment and the code that follows after it at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243
>> What I understood from it is that, there is an underlying assumption
>> that the power to the devices is not removed during the suspend call.
>> In the case of device-tree based platforms like Tegra194, power is
>> indeed removed to the devices during suspend-resume process. Hence, the
>> NVMe devices need to be taken through the shutdown path irrespective of
>> whether the ASPM states are enabled or not.
>> I would like to hear from you the best method to follow to achieve this.
> 
> Christoph prefers to append quirks for platforms that need full device
> shutdown on s2idle instead of changing the driver default.
> 
> We use dmi matching for our current platform quirk list. I do not know
> what the equivalent is for device-tree based platforms. Do you know?
I'm afraid I don't.
Rob, could you please help here?

> 
