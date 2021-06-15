Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54923A751B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 05:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFODah (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 23:30:37 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:58744
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhFODah (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jun 2021 23:30:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7LtDsI72P4AaCzfX6PHe5NDg/KBLoEvMFymJOtxtTyD9j3HZM8Rdg5KvA1BKS7/cPn8ze6dkJCnbg9TVIP3/P+60K1df0WQWEtHz5Hx1G5GTO91RUHgVWrQweIXhzKT771mcbG7KppF0PfNnYpn+oBC9kpHbtXPiWavddmLlnZjQ+i/S1/3941CiBVbz1wn/6izEERrQedy+toWnJg3gKgm+udMTXQPM2+teLs/1yesQaA+pU4KN6UAhKmfQdkiodnxUy+MEs3prhfG002FMR/iXnLCeuwNBt/u0x0qGSwk2575TF97d0rU48oDY1H21KeCxA9TajgvepRJMQOp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0xqGiKolo13urEJyjMTTwg6+3Zu0nDGlgF//K9DoPY=;
 b=XBO839s5thxMOxRFFd0nEj2GK/8UmGig/hkIPoPlKeBhMPz/9cO0UDC2IQiE1dLBGFsI0owZZO+FGtL1wJA+sJT/tZ8rkWDFFRJJFlYavdq0+lO1tV+oAkZUPP24unryYIK5vUX8q/NUkDsNHoC436CosrTchr1CT2gVA+QXGaB6fEkjMWtsi4dKdsCH05JW/ZiYHqDuIlb9TyS8MobNQvVfk+6DGqhfGhBz7tUmJXV+FvlQwd/4nEts+xvz9ytuJyki8+V9BiEaGj4crIxIC8B/J6uXIcS85QNaYDDyDn8RBA5REkw8dkB3QBi3qswdB3oAg/lLeMGZXL5C+LufVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=synopsys.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0xqGiKolo13urEJyjMTTwg6+3Zu0nDGlgF//K9DoPY=;
 b=FMT2MvGI5VRjdcYgXMo+yfJ2nbgS5y8fxru3SVXjAquIgLXLqG+CooMR5nSsjFkzYcnJ9Y9h6HkVoXTce5pu6185jSGOFyJJmJLfH6JlPOAqR/Fkm+JnzCjXKjzcxWtrs/pV3oZvvZRzfrmxbX5IXxDewrDJID4yp7mwzKHEBfo5tdodztNBkTKXunHtCOXR2v71lGLImTm7s1Q22yUEiUqsfmBaeHYSBP0K76IfYj47Tto4pS7AZYZ+lzA0XOB3Z1vnxobYa5EuQRlHIkxbsGEjShJDAmV1/limYY+T5Npq2HVYUJV03ZMZE4pWUSEAQW0TKHWDAvCG4hMEq4ZfOg==
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by DM5PR12MB1931.namprd12.prod.outlook.com (2603:10b6:3:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 03:28:32 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::62) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 03:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 03:28:31 +0000
Received: from [10.25.75.2] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Jun
 2021 03:28:28 +0000
Subject: Re: Query regarding the use of pcie-designware-plat.c file
To:     Thierry Reding <treding@nvidia.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <34650ed1-6567-3c8f-fe29-8816f0fd74f2@nvidia.com>
 <DM5PR12MB18351813A8F94B0D18E6B505DA379@DM5PR12MB1835.namprd12.prod.outlook.com>
 <d142b6be-f006-1edf-8780-da72ff4f20e3@nvidia.com>
 <YMCOoGzE2uGxabqF@orome.fritz.box>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <26a86c55-7c35-484a-2e6f-9d5c36b078f4@nvidia.com>
Date:   Tue, 15 Jun 2021 08:58:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMCOoGzE2uGxabqF@orome.fritz.box>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e21e2c1-3005-41fc-310b-08d92fada67e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1931:
X-Microsoft-Antispam-PRVS: <DM5PR12MB193184F987636840659BBB62B8309@DM5PR12MB1931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz9UIzt1ZgEDU7ClKTaDlw0UcW4I5/pE9ChAOPMRDY5NJNiZ4eHva1oFKUYJYOnBrDwxQT8DJUfyUaQ60CHxyEnYvg12Negl8cMdeJIgxHtI1FUOsgc18AYZJzgIzRtOKJfhtMN9LMTcojZabmM2pAowJUFC1LtPkdCy2oTcGknf9FroCj+IqDg1/BsPaOZ/GUvh/tkmRPljFlZMCHuuQ9cVj0ypP7AYKdSh+QYyUCRlmlW9QOaT+/5myFeHwfEEemYrt+BQYG9fF1Qb7VLV1BE43MkkHpPqfdBYZ6Noo+lc2M9tJIJKIZ5DGRToWmFQvNadVrhjgwxkTBPJxhJe96J+IoTLfVb63ytYfjVSGSwLCesSvOlq4Of4TgpraAfLigECSaftlD4nXgEXjPpQwQHGCjQzFZF9+m9DODAfqFL7mW443LipGZHTDFGDV/6EeucHvAqqr9xu60GO+soshTcaUDQizgUV0Ohcfk8ADo/f3LtHwclm6XfuPFvfn1uBDCpdwiO+ezp0UZecP2OlFpufbcuMrNik1RmufqSAq4ydyRi9hsXdlibMh6ciqMl9vf68757E77+MeHNz1EJi7ZEbBCNHUvnpvOQsrJYdXTw03N7FuMbRLVa2wG+AIi8VbdqdEBDR27UjPQmzmj89Qim8EkIkxuyntSJwqRqjO7GhbHtR2T/e8AtRP6w5yPWL
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(8936002)(4326008)(31696002)(70586007)(31686004)(82740400003)(53546011)(426003)(336012)(26005)(47076005)(36860700001)(16526019)(70206006)(186003)(2616005)(110136005)(316002)(2906002)(86362001)(16576012)(5660300002)(54906003)(478600001)(36906005)(8676002)(356005)(36756003)(82310400003)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 03:28:31.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e21e2c1-3005-41fc-310b-08d92fada67e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1931
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn / Lorenzo,
Could you please comment on the options proposed by Thierry?

- Vidya Sagar

On 6/9/2021 3:19 PM, Thierry Reding wrote:
> On Wed, Jun 09, 2021 at 10:56:48AM +0530, Vidya Sagar wrote:
>>
>>
>> On 6/9/2021 2:47 AM, Gustavo Pimentel wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Vidya,
>>>
>>> The pcie-designware-plat.c is the driver for the Synopsys PCIe RC IP
>>> prototype.
>> Thanks for the info Gustavo.
>> But, I don't see any DT file having only "snps,dw-pcie" compatibility
>> string. All the DT files that have "snps,dw-pci" compatibility string also
>> have their platform specific compatibility string and their respective host
>> controller drivers. Also, it is the platform specific compatibility string
>> that is used for binding purpose with their respective drivers and not the
>> "snps,dw-pcie". So, wondering when will pcie-designware-plat.c be used as
>> there is not DT file which has only "snps,dw-pcie" as the compatibility
>> string.
> 
> Sounds to me like we have two options:
> 
>    1. If there's indeed real hardware that's identified by the existing
>       "snps,dw-pcie" compatible string, then it's wrong for other devices
>       to list that in their compatible string because they are likely not
>       compatible with that (i.e. they might be from a register point of
>       view, but at least from an integration point of view they usually
>       differ).
> 
>    2. If "snps,dw-pcie" is meant to describe the fact that these are all
>       based off the same IP but may be differently integrated, then there
>       should be no driver matching on that compatible string.
> 
> Option 2 is not very robust because somebody could easily add a matching
> driver at some point in the future. Also, if we don't match on a
> compatible string there's not a lot of use in listing it in DT in the
> first place.
> 
> So I think option 1 would be preferred.
> 
> Thierry
> 
