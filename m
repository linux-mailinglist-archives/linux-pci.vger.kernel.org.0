Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3CA744227
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjF3SZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 14:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjF3SZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 14:25:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4293BCA;
        Fri, 30 Jun 2023 11:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJrVKYHq8kQ9rRLj8ncjvqNXyoxAFVEZdq/TthmRGeEZk1GE905Vpet5xUT8KuUAq/O2rKTQgnlJz92u4pIo2Y1drn/LOXxj0Vxb27yZtMdg1L5/S2T0I6T9ameLg/IsDSjrMxIuSMAIvGCih59MYlcGDdXKGZUrFd1KFhJLwN9Ii3UOcag2v7YbzdvQQc3MW6dxuCFkksp7G5DzVJDAzW6XbiVvPfDUj2jZIigRiT+rnU6Rtk2PkbHETC2mcn/rLyXspCxuOdiWjj+WaFyKYuvSDoRAITKYtT8fFVnXA62j70kY4iHjb3WAhwtRnrHxFtZNsxwndtM4AqOe8lDhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEKS2OQjfHTx+TTcuLZv+mAL2FZ4gz18KDCYjtohWVs=;
 b=Lynz1FLRxOONxsSs8YW3tYQX/4Bm5+G8xeAK6Loy8ylW6X+faI4dovueUjOoFWFC83kbu6tuddjr/krmc2lCBcTbV+HPel7RKIUv84Fd1DKZmfS98GqNOR+uCwSXR7jpQhUV/oucbaw/myJ/lDhfvltmlnSI8n6YZVgx3tJGv688AgSEdreoIZZPXPtOE80jR0eZT/Bj4GDvT1Rek7P7Fv18vCulhHPni/7g3DQz+93hcWlNNZ6MFf466PcfHlYE501QAxhrcvnTTUggkTDMThMd8qcmF1LMD43fepF63ek20sc1AaEtSFX5b2Fl6IciSaEnyXiIZnYiJVFXlZpRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEKS2OQjfHTx+TTcuLZv+mAL2FZ4gz18KDCYjtohWVs=;
 b=JS5jQX8CnoIDRre1YGjU7mFPHFvTOpKCIqD5Z9puiSYbxCXVAnfimxrJlk16KzDJKkw8CPr7KoCLQstk+xVtN674rJ51X73vGIcae0dvvGPVN03diC5zz+OQh8gFd2Bsp3MaYnhTM+0gnBMXCxmNfeUVfG/N5jV4mcf2sDo9Zgs=
Received: from MW2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:907:1::26)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 18:25:07 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::45) by MW2PR16CA0049.outlook.office365.com
 (2603:10b6:907:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 18:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 18:25:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 13:25:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 13:25:04 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 13:25:03 -0500
Message-ID: <9f39fc3d-ae40-e5b1-8d40-8c27fc4e1022@amd.com>
Date:   Fri, 30 Jun 2023 11:24:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
References: <1688059190-4225-3-git-send-email-lizhi.hou@amd.com>
 <20230629225631.GA446944@bhelgaas> <20230629235226.GA92592-robh@kernel.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230629235226.GA92592-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7e3027-e8e5-48a4-cc9d-08db7997549c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L8lRsAIfZhI0RydQ/hMTOSdOmEK3kFE3eJUng1sGiPnSe5uaI8x0HO4ZcSF0nbxkpxOelSTyJmGDMgumBk5Uc3+RNic+WcQYtkXOvnDcFpabHoJiVj6gQ0me/CrdiSPfMJQKT8CbTQ5mS8k8kPCPOLb18FfsrDJsltG6bwQKB2amKeC+8DA9js596Lim0QrhmQqU47GgHtfqnOD+fi1leQnddEQRDFBD+eHe/ezAGvUE3b+HpajaTKt0iBF/tuakCt+FgeVh8h0ce+xVJNfKvhoknYfNwsD4o2OA+MBeGl7p3LKGmX9mzaxKH5zNktVNbH/jNCbMWFs3UTw+0aDnDjbPMoko3ueEMzTI1XJNLIYeh5auW0/4qKElaADGhpXvhGzhDrLNt2fANgE9p5xNJ7JcQFhB+KTzRtJjMIzvhyIn2U4dDLFzNv1WhIifw1lycJDUdaq1reFs8b/LhkQBMF8rIK3nmYesIyvrRhyikibplWfQBI379K/dhQitTPcEKaPJ6LCNjplSpIACTyQstZpfCCQawq5NYd0SO7bI/TObbiIoJnHralyNWOZgxmAHK1pW0Epq9tjJ7s3CsXChb36OeDf3QxzYMxqY5VqZ8b0mxoYinBn5G7mv0Qp4YOp4BJ7jhKfr7hqq+JVJbTOyA8mx3TNq6cXfm91tNyi+UgNB+3UnAE3BivpubrYf5sILI0iMCCUixNgxVkWNj5CdSAhoQlt3jDGaM0pW1N8TrwUo7iBObOErvdlbdfiXfQLqnM2EKzFJj8ul86bNjTVkH5dIXdu5JjdIRo8LJqxoOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(966005)(82740400003)(81166007)(6666004)(356005)(426003)(336012)(47076005)(2616005)(186003)(26005)(53546011)(40480700001)(36860700001)(31696002)(5660300002)(86362001)(40460700003)(8676002)(44832011)(36756003)(2906002)(70206006)(70586007)(54906003)(110136005)(16576012)(8936002)(316002)(4326008)(41300700001)(478600001)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 18:25:06.8079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7e3027-e8e5-48a4-cc9d-08db7997549c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/29/23 16:52, Rob Herring wrote:
>>> +			rp[i].child_addr[0] = j;
>>> +	ret = of_changeset_add_empty_prop(ocs, np, "dynamic");
>> It seems slightly confusing to use a "dynamic" property here when we
>> also have the OF_DYNAMIC dynamic flag above.  I think they have
>> different meanings, don't they?
> Hum, what's the property for? It's new in this version. Any DT property
> needs to be documented, but I don't see why we need it.

This is mentioned in my previous reply for V9

https://lore.kernel.org/lkml/af9b6bb3-a98d-4fb6-b51e-b48bca61dada@amd.com/

As we discussed before, "interrupt-map" was intended to be used here.

And after thinking it more, it may not work for the cases where ppnode

is not dynamically generated and it does not have "interrupt-map".

For example the IBM ppc system, its device tree has nodes for pci bridge

and it does not have "interrupt-map".

Based on previous discussions, OF_DYNAMIC should not be used here.

So I think adding "dynamic" might be a way to identify the dynamically

added node. Or we can introduce a new flag e.g OF_IRQ_SWIZZLING.


Thanks,

Lizhi

