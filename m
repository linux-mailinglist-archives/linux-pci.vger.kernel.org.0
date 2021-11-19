Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3892C4572BE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 17:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhKSQYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 11:24:24 -0500
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:42177
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230193AbhKSQYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 11:24:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8SSIP2Am2pajebzt/mDpBJJAtRENnGkRD993YKGVM4tB4BEUopFqx8ajIeKSJVMaiLdsBtF0BC15jQD71ruYECfSrsBrDbVdVt0p5G+ke/4Kiw588nGyjOSnyQGHM+9UpyCb4K5eNtejq/idt1ZLTbr7mI3tpBKT5VMTq9usOlGl3/Q3tsa4l+5ezIJhUE+HqPMiMZWkisxMVEmBuFAqrMDhgtb9HTWtc614vzzzgoWQtQhZ1975cMn3IrVVjZ/ihN2y6Pub7CjtfOYY6KG5J2iwlKVveFBuZOhvc4lW+cidvPCTFCowdaKxDnqMJ5F3fTO3UAtepLKVtn7F212rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cIG6lL5bO8q991aH9wbOt9ksfWcm8WTrVN26HM9RAo=;
 b=bFvaSN31XuGkQoBh238VpoNAM9xR5QitDzuphFzPQLo2c3ZO9MCXfk2VzDjk7kREg2TBHUv9JZwhDhJYz2NbDUvi1hCoWIPEhdPFu6TldY5ICEKW7eZEpSHfdhZdXbKBbcg8bTU10y9w9zzPn50eUsIb/AgfLEDG60iIAPb+r4dKaYdTlq6hEXyoju5/KOB5Cb9AaLuxPX+fb3uL5yRxRXu27lEVSglMDl4sCvHrS1aN4l/KXQfepbkc9DD5ZTNfLNcH8hmM4H4JQ0QdDIhiDX0ge3kCm3N8MlPK3YtmSU9jLLei3MnCPwrCe70wV84gAh31nQozf1oe0CohAoJ2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cIG6lL5bO8q991aH9wbOt9ksfWcm8WTrVN26HM9RAo=;
 b=UKyivPksXyA4ahsZo+Z+yOoghp8wCZBs+5Qkwc4KDwKN/EpFFL0Y9kKsMpAAxljmQdlUdjEQ06FTPzwCKY6nBq/+BQ0BGujxmWPsHR6u1ecj2YEmFYVMmX/PMbzBvlyNbnWtDu/KKOyCGZ7LkiBdJwsaURUP2nF3YJfwsCUf+7iU3JUDo10G3pF1K+/B+0axQWU8jcNT89M09knR+dhnaMHT5FZwAbM6LTShYh1ckg6DoCR4nAg3EAmaW+G6y1scPl+MbgfrqtflYAVHq+VkD6eahJ6OqYoV9Afk2VvqYHFCtEqEeissG4HW7w2Yq9ldQR2m3s1wiVYKqq5Ne2aNFA==
Received: from DM5PR07CA0115.namprd07.prod.outlook.com (2603:10b6:4:ae::44) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Fri, 19 Nov 2021 16:21:19 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::52) by DM5PR07CA0115.outlook.office365.com
 (2603:10b6:4:ae::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 16:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 16:21:19 +0000
Received: from [10.25.99.100] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 19 Nov
 2021 16:20:24 +0000
Subject: Re: Query about secondary_bu_reset implementation
To:     Sinan Kaya <okaya@kernel.org>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <hch@lst.de>
CC:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>
References: <40b03450-8f42-29d5-b65e-43644ec44940@nvidia.com>
 <0cc150cd-664f-05de-c8eb-81c81583cad7@nvidia.com>
 <4925ab12-2406-916c-7594-f23de3ede068@kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <916f7fb6-9f29-80d5-e6c0-fd68032161c4@nvidia.com>
Date:   Fri, 19 Nov 2021 21:50:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4925ab12-2406-916c-7594-f23de3ede068@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32dd06dd-15c5-474c-338a-08d9ab789e99
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514AD088F7311382D3ECA67B89C9@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvBHQcXCv/HSwN1xGeqgOC0zPPIYIlRCd/12C0+zD+8MPvWQMJxILe4EYZFWpPs6zuDycvQhDlYF5pca4zOSjzXBKrgxUkJy7nFbWr7GotqOCFVobv0A0jSlYipdRThodWiC/Bg2ZjECDmKu+n1+VnN2s63KLnjia9YDnB2+Ai4PjdSE/DV36rLm6sazAwZmjhhFPsbuSl5KZgo3TqWQulu9VWUpObjo+PS4tOhoVTBwd6QnbwXjHeWqlVBqewKk6YXMwHX81MmrSbeqWLqwsoDm2eKwQ1ZnSIigpXBqa4eJ0PTUcq/ANSbccbe0pe4PZZcD1arF4T9p+3zr7N6WW/YvmVo7FVfEqN7Hf2pQYLhpot97hAEErvtWLZlywIBVSsujx98XuYCeRGerwpTz8T8ROQ+BRa0MPHVxfG4sSyZdshNkdve5CFoekmReYK7XsfmA7wXDaXP1Eo0lQXs6oppNHkUuRoKLbVLn8r1e3bIi99D4t1I88P/YFe7+pC9lrgaepytCpn4Fu2GiUCWcOlerYrevtS0DGWnTdrpr+R5Ai3eN1cIoWsnD6skuYrNJLa4jS7WL92xK4olkIfs7FDkEEicnB51MnpSVYFIvqPl3HYi6j70aSfH2enen58YbGh6Lafl6gbpbasbk143SpKtGYswvlJjoNM95RXNcroDaK7L1iqL53SsVa5P7bsjya8Enb/9ZJw2m00fQgsGnom9UMSpRDx2o0hTpYXuhOzE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(336012)(26005)(2906002)(110136005)(54906003)(356005)(2616005)(508600001)(316002)(7636003)(426003)(4326008)(5660300002)(70206006)(8676002)(16576012)(70586007)(47076005)(16526019)(186003)(31686004)(36860700001)(86362001)(31696002)(82310400003)(8936002)(83380400001)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:21:19.2842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dd06dd-15c5-474c-338a-08d9ab789e99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/19/2021 12:16 AM, Sinan Kaya wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/18/2021 10:03 AM, Vidya Sagar wrote:
>> Regarding the below commit that added pci_dev_wait() API to wait for the
>> device (supposed to be a downstream device.. i.e. and endpoint) get
>> ready, I'm wondering, given the 'dev' pointer here points to an upstream
>> device (i.e. a root port) because the same is passed to
>> pcibios_reset_secondary_bus() API, how is passing a root port's dev
>> pointer to pci_dev_wait() is going to serve the purpose?
> 
>> My understanding is that it would always get the response immediately as
>> the reset is applied to the endpoint here (through secondary bus reset)
>> and not to the root port, right? or am I missing something here?
> 
> Root port is not reset.
> This is a link reset and recovery from link reset can take time per CRS
> response.
> 
> We have seen some GPUs going all the way up to 60 seconds while
> returning CRS response and waiting to reinitialize.
Yes, but the pci_dev_wait() is called here with the pci_dev * of the RP 
and not the endpoint, right? So, how is CRSes from the endpoint are 
handled in this case?
