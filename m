Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7718758156
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjGRPuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjGRPut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 11:50:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A0172B;
        Tue, 18 Jul 2023 08:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYxFeCkCRsTljNz3FiZz2tjrjmdsJ5H4HLUSZHbnUhELjtm1SUuUUmEN+pdrKtqy0pvVcHSbSjaL2a2BXfCD8ouw23VsH3Kr9cAdmjlp42z1aX+ZRo83t0teu+J/FEke3uMCmrqWSV6j7437Iat+Fm/Ejb/srDHI2SRjNBYUgvR4Hay9ByXjBR2pVDFNUHlEReP1xdkyHZajTWQ9Vr/5aP7IKaptN7IS/C7pB/vPrxfENhrpBP6fg6HottWf/GzGvfu0E6xuzx0YGDllqVgOVXRkWRSVGP5i8BZPa351aLS2dC+0d9PTF6McpOV++qC8osnnCu/NENISR/064joo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqVJ4A73agcGt7gS2MNk3R9JOpQ6OImiQhToI6uRVaI=;
 b=asMOZM/4Z8nzzUEgrGa6mxshrghvN5R0NZLIlL5r+eGrDoH9cpLiA5JrplufX3mQ2J8NA1mxbna74wuDDlLh7JYJr9RYJ/DSSWbXItH8Wvm3Nh9j6abAEnXmT+v0JNpw4BddP9bCBlIHbY4INyS8unwPLjeL9BqTL1lg2yOiHUn9jnKLm+pQscfk+aqMf4AjBaWgLfwgAgRGXBHlE6KfaAKbLhz8UrW4Bd0d2yEJ0nW2D3l4bv9git9CZ/AP3cXWekeA2jwEd+9NqAoZ0m3fEUWcmof3c6U6M7iPBKnu/lSVEot61lhkK6TYKPpEqU7u/huPKAb7w9VdzCSrUHXYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqVJ4A73agcGt7gS2MNk3R9JOpQ6OImiQhToI6uRVaI=;
 b=bgyBPYX0OBXHswK8PmorUDM0i+4Zytqj9YJsHDcFJ0J45VMIC5SwAGL7NqEs3Xlbm76EVGA9fRTgLS4X5ier+01Igq3tYBdX1kNQXwseomUWeVM9X8VqTdMpkvm05Ykyvruz+69unQ1SAPuSTeo6sDmatFWlE8yP+tPwo8BXhlI=
Received: from DS7PR03CA0354.namprd03.prod.outlook.com (2603:10b6:8:55::12) by
 SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 15:50:42 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::97) by DS7PR03CA0354.outlook.office365.com
 (2603:10b6:8:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Tue, 18 Jul 2023 15:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 15:50:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 10:50:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 08:50:40 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 18 Jul 2023 10:50:40 -0500
Message-ID: <6fc414de-2693-87b6-719d-e3b168a570e4@amd.com>
Date:   Tue, 18 Jul 2023 08:50:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
References: <1688059190-4225-3-git-send-email-lizhi.hou@amd.com>
 <20230629225631.GA446944@bhelgaas> <20230629235226.GA92592-robh@kernel.org>
 <9f39fc3d-ae40-e5b1-8d40-8c27fc4e1022@amd.com>
In-Reply-To: <9f39fc3d-ae40-e5b1-8d40-8c27fc4e1022@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfb7a9b-e98b-4771-f9c1-08db87a6bd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiRyukwepGA5ecx3DmEjZL2vS06Z55EinNQgpE9dV9b+1dq0GOkxnNHApTTs5rqWgaLwJmM8krYrImQF5o2dwkBRldca7r7IBMha0Qz6OUAwyi7446wVPG4NtZZ64DTFwDiYEt5Vwjgrkw0xT14526hiZtBa2iEODbVJeNh7Ds0lo8dTXSymK3nCCnTg1EnEMSNIq7F9dzJMvsAneKcVeTMF5QihISj0sc8usZ5Efqj+3+YOXzZDFaXLAfL1rwRBLMLJD0dJKiMFi1Ld83yu1OkvzTCC+kU59g/ivUmlSGaPqhSb9q4pQB5U5GwLMN5wHf30Px3YZwarLX11TPIK9EHJeG9mkhhP+T5VoXZk9KLr50eDVjZn3h/n65PZbcsL1YPSmh0KyC3IqQndbJ1bAn5rwcqkT08Dh43ky43At/9O51D8zMEYVlVNgysRyak3SsJTrWq3cp6h4kQiToriAB6GnXvM0U1/oJ6YU1nDTOK5iTN9Cs2oUPNrD4NpoOlyB+xvve9MDS6DFK7uIXMca00z1iLF4Dkbto+FPnIbWKFfW3HDNrZ0LoHLzWn6bU7ficmkFBQulGd7Q604w9HtMhMqkbgIYwDR3bjG1xxg7jqQ9UUCrJfMiWsjNvVSecxBQUHJrGdW+z9vR2DSF4tisi93wTEwKbLgKDC3JGx07K6VNwzE1jN8I2n+pc/az/cGNQ8Cs5AH94rp4lbLqPwnXxgadqPSLjPP6Jh/yqK3Vl28oPH+WqYzJZ7ub1q4DIqFST1kzbUVCgSMc/yI/msJ6VTs6IyOgRFiI8JJ/n7UbNsMnyxUv5Xq7kjBxcisZuRd1Fq3VCD4Zlx+zPdmaOpMQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(8676002)(70586007)(966005)(2906002)(8936002)(70206006)(6666004)(54906003)(356005)(86362001)(31686004)(16576012)(4326008)(36860700001)(316002)(44832011)(81166007)(47076005)(36756003)(5660300002)(426003)(2616005)(40460700003)(83380400001)(186003)(336012)(26005)(40480700001)(31696002)(82740400003)(53546011)(110136005)(478600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:50:41.6860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfb7a9b-e98b-4771-f9c1-08db87a6bd8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

Hi Rob,

Do you have any comment on this?

Thanks,

Lizhi

On 6/30/23 11:24, Lizhi Hou wrote:
>
> On 6/29/23 16:52, Rob Herring wrote:
>>>> +            rp[i].child_addr[0] = j;
>>>> +    ret = of_changeset_add_empty_prop(ocs, np, "dynamic");
>>> It seems slightly confusing to use a "dynamic" property here when we
>>> also have the OF_DYNAMIC dynamic flag above.  I think they have
>>> different meanings, don't they?
>> Hum, what's the property for? It's new in this version. Any DT property
>> needs to be documented, but I don't see why we need it.
>
> This is mentioned in my previous reply for V9
>
> https://lore.kernel.org/lkml/af9b6bb3-a98d-4fb6-b51e-b48bca61dada@amd.com/ 
>
>
> As we discussed before, "interrupt-map" was intended to be used here.
>
> And after thinking it more, it may not work for the cases where ppnode
>
> is not dynamically generated and it does not have "interrupt-map".
>
> For example the IBM ppc system, its device tree has nodes for pci bridge
>
> and it does not have "interrupt-map".
>
> Based on previous discussions, OF_DYNAMIC should not be used here.
>
> So I think adding "dynamic" might be a way to identify the dynamically
>
> added node. Or we can introduce a new flag e.g OF_IRQ_SWIZZLING.
>
>
> Thanks,
>
> Lizhi
>
