Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB05B42D2
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiIIXGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 19:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiIIXGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 19:06:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1D117481;
        Fri,  9 Sep 2022 16:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMP7fZIhE3oKDKPKIgVM3LH2UsZXNXrcQnibrM/2fPkiHJVxnMIdL90sE8QSULcVo2ZL7gdAR466ygB4h7xiXTvpwlB4dDKS50dN3MOE007W1Gs6PdBOeVVvRRUgDTreaBIaWJtOW5qaaUDlGWclxzrKfgRuKL3sStCYyMXtrDylfQ8NhoZHLst1yT9jKGGy0AHlmqBA1KifTa/YEP3+2f0FBjK73GDKPAfha57eySszQLHV4J7F3Xn1wzj8WcNp4tezI7Onujh5FOxZxir/SOxH+nch1E3cqx6vvc72OgC1Vw7xu56x2cmWS4LorpQlD4J75SwCMlZ/1x5ki2v+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rdubbjsfJIERrpbFNGgEnP2fgpS9htunGRKkwJ441I=;
 b=XjRM13p3W+FTmX+gMgkHtTsojmDb+Lte8JAn9ienkcRrMh57S6lApZDihnedFHr8KGbUBfn5vP9QrhwCwXgaKWXPuO7EUn8ZnGw/SgruIdkNME4oGbu3NMuTlQce+2G+9iBvax985FMpm16xk9LwnueQmSddTv9Oos1fRPwQUyiLSeDy74aHRp9L26a73D+kYTeuuidlCSN2ERbk7ma2aJjMO5sqUokbIvL8YX1AHYbA8zjouwpMv0VJB2czTu9OIvemmilLxOI3SDEHkJwlbxuJPMqMuAocNqjyMscXB3kwetytQmlztbwx9QSXjICUOXUfv92SEhaYwNMQTkNguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rdubbjsfJIERrpbFNGgEnP2fgpS9htunGRKkwJ441I=;
 b=pB8CgZRaYM7odkrtpyyUE7h7bhS5853BJ2yLUQEOl12g1TfB0h1eCglVcAZ/e6eacI9gB0M/jDdpfWMIqQ1NWnbrszN4C+kZjNuvN+U1n3X0iMmJ8JXVp597xTsElNgKCuSNOkZSIYSj2ORjAhf5KSkBdPR+DDDrm/aIu8Z1eds=
Received: from DM6PR10CA0024.namprd10.prod.outlook.com (2603:10b6:5:60::37) by
 BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 23:06:43 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::98) by DM6PR10CA0024.outlook.office365.com
 (2603:10b6:5:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Fri, 9 Sep 2022 23:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Fri, 9 Sep 2022 23:06:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 18:06:41 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 9 Sep 2022 18:06:40 -0500
Message-ID: <12c4d5cc-f764-b4f9-331d-634533703076@amd.com>
Date:   Fri, 9 Sep 2022 16:06:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <20220902204321.GA374266@bhelgaas>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20220902204321.GA374266@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: d925f010-af63-479d-6561-08da92b7f611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpXLFDq0/w0O2rhw56zGiApgBv8swP3+azC5aRKoAriBaQZntqej2qnPzkpc2fBTioIN6EzaAlD1qKzgVj5aRHUmZUFaBTUoLQyLon/T4jdFnLbg6qVyKbHtWZSOZgAVO8tCcx0SpNzaDVSKiI3dvh8tscTOX1SrnVVeREabMhjek8+DVy1jTOHbBwqE9xbl5dDZNJZN1km1Q15TXqulYEC50Bi2aUlvrk+E0CHiu9+lXMxXaV+zwD9Yt8g8j2j/jys4S8RnYU1xVBDs/bVdPuHR6WHIaUjBQLGiDvEbpgDdFC+TBpVMTB2g9rGHsngiNh+pn+hEYbfCnlvE33FaHB56yIrpe2QFERqyvoe+Xe+6simN6JjFLg54pL1crcmGoVgLDasrdfvynhwsmhp23sgY3C3mqFSEh7+5H18iEcBvJB7aHWlKnXerMkKO5fIMVOJHNATJhIyFI5PaHxHRBIMvjOygKEjT0uIx4UWYWgB2fP7GSavGcevoBhQRhwZzH+4dznlOw2eqElnW82rG65/gYtY3jxjcdwV/gJ5OkDbfaD5z9x/JBbCAT6b6VXHuK47LEbSWCJy1uc3y/vuBUOdfwO/1rM3/p9/wGlPyfpsga2W5fTFLjxm5zea47xvBy4Kysfd1k9zk8xI9Uy0n6fAvPiac+MK6p8BkPQpcwbQLHykwylToibwZA1eO8g9s+1tw7oDmx4ULXzpvm6PABeQ/X8WWKXTWJMwC4gNd7eG4XTZ22bqSx8onYn5fPjKha4QMY2eNcVvk1nuqrRwjC8rAss9YV1e8aAfO1s8msE3E97Qg5HReepkkEORbr2M/qLK2MWCno9GGKCHHKvqe5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(82310400005)(53546011)(26005)(356005)(41300700001)(81166007)(40480700001)(478600001)(36756003)(82740400003)(40460700003)(36860700001)(2616005)(186003)(426003)(70586007)(336012)(31686004)(8676002)(70206006)(47076005)(31696002)(4326008)(316002)(16576012)(6916009)(54906003)(5660300002)(2906002)(4744005)(44832011)(8936002)(86362001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 23:06:43.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d925f010-af63-479d-6561-08da92b7f611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,


On 9/2/22 13:43, Bjorn Helgaas wrote:
> On Mon, Aug 29, 2022 at 02:43:35PM -0700, Lizhi Hou wrote:
>
>> Clément Léger (1):
>>    of: dynamic: add of_node_alloc()
>>
>> Lizhi Hou (1):
>>    pci: create device tree node for selected devices
> Please capitalize both subject lines to match previous history of the
> files involved.

Sure. Does this subject format look ok?

of: dynamic: Add of_node_alloc()

PCI: Create device tree node for selected devices


Thanks,

Lizhi

