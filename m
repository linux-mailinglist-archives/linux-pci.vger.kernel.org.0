Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134CB4B7F8E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 05:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbiBPEkd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 23:40:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbiBPEkc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 23:40:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528DAF4076;
        Tue, 15 Feb 2022 20:40:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpBShwmJWHNBPUz4PWh1NaB7ou1ZDKC6UAqxYmUm2pE+cnWVq/o+ZzJjMtpKHx7YgJ1dlT8LbOhH1i6EvSPziCo8PsEYyPRpJ7qihSAJnNbG6UkanKVmDKyICkkSqwdRFEoKp6aA5Qfm7lsnWQMFCbXHza08B0xBN9J35FyD+4IKeh6F+4K4TZOrz0cleNFwJie78JYeS36fWF/CHXU47Kn12MG7vakHw5487UdZQWrSTaPfNSQpk/lYieV8fAY9PtJCljHczWnksUPFO1JM2hX6MNTiA8cAdmpyB1Z8+xwny0KiAmJ/3ZxogwiDzLaApGu3xc+BIuqiQGf0wo8N1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqL3BgSp1bDHscKdamZp+wKvDWtpnVP4rZeaQpwypio=;
 b=lnkVkGK14qFpl+o9ieqZktDE2QOHI1+l2tdt4TuY8BpAeAO7gqN+Ub5SqE18LyvxIDp3HbrbG+TXIgSJa4iJHJG0d9JqkLcHX31uwtHgl6AQCF7p/RJfyLx2VPpTZAi9136t9wRrr0ouDRutg5L0IUn2/i+bSdLluEmx5qXiZFxa8aCflDQ6slvlJECQzuUTqyXIx7x4zzQWAve2I/8K/GCulD7hM9dII+/sy+wtRsbuXJc3FWiikJGLOMc35Wkg9hq4vxb278zUDb+jfZKscTSHbGEJalpoYbDcHVlh31absD7C/3QnwiV7E9n+hwdLzNoAz6XfN2BAQIgQyopaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqL3BgSp1bDHscKdamZp+wKvDWtpnVP4rZeaQpwypio=;
 b=jutVIFVwKn85CaKdZUfiZlkXBrCRaOd/USOGPixx0W7g1YvCYc2UoxUD5BJ1smEbKn8DWgqTrVzUVtooP1U7RidNhmljoqNQH1vxJcFL65OD4RguaOq8cA5EMYpaTLALU0XsXi+n7nwtNal1iTQWrMDnzIHa7d1k7pZnT4ECER3nN1pm8GinsmomPiHDhUHaNMzM5uwdox7oKR6tBMsxSfaGHuuZQj1K3LTbPZ0YKqRkgfFVOLqyCcjHF1G0ugZWNSw+lAQEoNxkE0cTTp8tV62pIeQe6M5IvuInGJemLXvySOJYA+ySxDhOTjILiWNMFeyS0JGzTKHkrR6tFNVHag==
Received: from BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23)
 by DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 04:40:17 +0000
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 04:40:16 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::52) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 04:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 04:40:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 04:40:15 +0000
Received: from [10.25.73.191] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 20:40:09 -0800
Message-ID: <0ccd43af-0293-521b-86d3-ea2ea1c70e5c@nvidia.com>
Date:   Wed, 16 Feb 2022 10:10:07 +0530
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
References: <20220207163332.GA397884@bhelgaas>
 <79a41832-12e2-2ed-f3af-da3bac90d941@panix.com>
 <3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79b82b77-2d53-4b95-a699-08d9f1066dea
X-MS-TrafficTypeDiagnostic: BL1PR12MB5224:EE_|DM5PR1201MB0057:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52240BDCA2D09690A948D065B8359@BL1PR12MB5224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMbprMS4LR51OcvTVyg+5YirBpubHxbXF/v5ICL9u8XeODLX6ExSQfKDAkiU9O0NbXcUOExZBdn7E2h2TVqyTZhqhIph6LdiLur1VLRY8S0QqYrdNrrXoJuRAA+1X/nOlZSaaErZ6Jh9Lg5um2TSrd/63Zs2nFTsoa7mVTN27zIk36hA2KKE0bGkkdSxaz6yg8B51nzNTZ0g9UDu2JyypE9IhWOr5EDLoN/qr4Dk6P+ZGeJpbbrUR3pX1kWeLWyXnJDmOGFH67osQNSMY+KqlyuZ7tkk+VMkivmA6Xo1TKBvG8a/r1r3tyd4gGZkmD4YouLvt9rQSj5LAVK7Xao9VtjZktdD6ZGdjVs/YqjXLGmLWj+IcfrtqT5cQ6ZcQscb9pP7s1jS+TjR3Y23g5qwyKoQLx4ugPL/RXSI0q9lnxpB3AE6gyh9HVU3/WY6R11dGICBKpJHbZhxOucjyhSBbvpo+awIFtaNiawgZbWc9XDJh8StuZ+qgb4spQZ8ah9RcBCnsu61CzQtW75+fEOG2E9k9W+pI2TB4pArOIBOuaNSZwEApjINTQwvuCavWuBzoDit3y+U5zrPApK8/r+q0BL/eCwJcxw2JQ6pEYQ/YVRoRa/4Eyg8hEfaQsfsCS0YzevDwXTz8KjNvtDaDFb5ueUZWC9HkZ2nFJ9ljZApHZrl/TcwSULKi2WBiis5cZUkGjrgjQuOhCp+lS2+sbgkYOMj6kylmL62NawkAsWcaVM5tyW1629yINoZ2nUeMdJ128w6iQMPaidOLVY7EJ3Zmg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(2616005)(508600001)(36860700001)(31696002)(356005)(86362001)(426003)(83380400001)(26005)(47076005)(16526019)(186003)(8676002)(336012)(2906002)(316002)(53546011)(16576012)(7416002)(81166007)(70206006)(4326008)(8936002)(5660300002)(31686004)(54906003)(70586007)(40460700003)(36756003)(15650500001)(110136005)(32563001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 04:40:16.3953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b82b77-2d53-4b95-a699-08d9f1066dea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0057
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/15/2022 6:40 PM, Kenneth R. Crudup wrote:
> External email: Use caution opening links or attachments
> 
> 
>> On Mon, 7 Feb 2022, Bjorn Helgaas wrote:
> 
>>> If the problem really was fixed by some change elsewhere, it *should*
>>> still happen on v5.11-rc1.  I think we should verify that and try to
>>> figure out what the other change was.
> 
>> Yeah, not a bad idea. I'm a little busy now, but I'll cut a kernel at
>> 4257f7e0, remake, and see what happens. Gimme a day or so.
> 
> So I did this- checked out a branch hard-reset to commit 4257f7e0, used my
> current _defconfig on it, and built and tested it- NOW it doesn't exhibit the
> NVMe-device-killing behavior I'd seen a year earlier; I'm assuming Dell must
> have fixed something in the BIOS?
> 
> Anyway, I'd done an "lspci -vvvnn" before and after hibernation, if you're
> interested, and a diff of same; I'll send those in subsequent E-mails.
Thanks Kenny for the dump.
I see that the ASPM-L1 state of Realtek NIC which was in disabled state 
before hibernate got enabled after hibernate. This is weird. This patch 
doesn't do anything to LnkCtl register which has control for ASPM L1 
state. Could you please check why ASPM L1 got enabled post hibernation?

> 
>          -Kenny
> 
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
