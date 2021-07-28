Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7683D853D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 03:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhG1BTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 21:19:04 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:31244
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233008AbhG1BTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 21:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVQOpanIkproldAdP5m2fbOWezY8RvJ5Dht8YlTShSLyfMiMZNAuMpql2TY5ITpZ2BJM+YQahAGy21kvKC/bsbvbKc5E6x6reXBV/2r4NR9YZV5GVKnfo8A+9gH8HdZCa+7kTsNYs9OmIZXIIu2M8c8f35c4JaUB8EsmQS3320tD9Rw12fSrug+OE++X9sjKXdkW6XJXndCnUAHWMOaIiNRashWgYrsakuD92Fpc7DrfnBFRnlJTu20ACjvgugiCylZNf4ipiEYBfmo269WpRegnE61TO4kkgKbysiNQn62G/9sfeE5hRWaeyDEC18/EdOYzspHmduh+BwXiO8DVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTG+NllRELnXtgCQE2P3m5lcbEde1Xuo4zwiFYD0ZAo=;
 b=QUA0qa3oB+3XGyZQUIflRYZ64SxpH8ePgRrfhGzs31kQk6SB2WRGE0xbX3Z+EKUI0pcZS/vGRbhcSFlFdF5A2UWDJt+pnWMfmBGx7ax8SVFaL2GelxmWTzjbn2cakGfZpQzBOilYdeqnF7eI6t94btt443qQcrRzhFK3HKXdBLXvOQwfUujpOcQKLcJMLSkKRO9BVtVAt/K5D30/7yGFsu1YrJfXfZwmd45xuahTpnzFo8r6judlsfAB2jBBZdTIhMJL81hXWxa8qPdfg8hMNSczCsvZdOqHdlnpCtVVFQ0gNPg+CAkzjrHoAtb6N3SkWfRA9xR3Toi8BttIBhkBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTG+NllRELnXtgCQE2P3m5lcbEde1Xuo4zwiFYD0ZAo=;
 b=pjMD5iG47nDg9xIeWmTh383JNNRbri7fApKn7UUltAEoBwDNK4XEO5tJiPhSvhylq6sst4PBFWZ/n5quMT0xoQ/CdPx1JP7NNBQs+cqhvNda/jS9ARLyl49hC0M7OxDqCZ4VrBHHCmX0/QYX8kb9zofgzKfe/yFT4ZWkof+shi7JzRPkmVa8RwbGmOjMfnIGMGOslO+pzDITKSQix9MR5fD+AoiLljrQBvG5M922QqEdLwg87vYMMXo5hou5yK3lOUGXEHVa6+Pb5RjX809TrAtXqbfZtmBSJwAHPkpdsemDb3cqCxtstPBYSfxRBI9vJn+q+D8RNFwnuKu8u2fvvA==
Received: from BN9PR03CA0173.namprd03.prod.outlook.com (2603:10b6:408:f4::28)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 01:18:58 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::22) by BN9PR03CA0173.outlook.office365.com
 (2603:10b6:408:f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Wed, 28 Jul 2021 01:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 01:18:58 +0000
Received: from [10.40.204.204] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 01:18:54 +0000
Subject: Re: Query on ASPM driver design
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <hemantk@codeaurora.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <bjorn.andersson@linaro.org>,
        <linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
References: <20210727151816.GA714116@bjorn-Precision-5520>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <3bfac041-9559-40a2-fc97-1dbe9c5295b1@nvidia.com>
Date:   Wed, 28 Jul 2021 06:48:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727151816.GA714116@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e261643-a7af-4157-ab07-08d95165acfd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4317AA7D898CE818A673396DDAEA9@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5muc5ovyTNBXrpY3SeLhXNAOPka0WSaioW0uUgvupus0eLp+AAHZ4AOIQvdGnlah0eTiqiFj5cBwWHJAiaPpiSoe2kJmlBsHmgm15WtV9onB0IZO277coi+QnCB6BN1ZNNOM2HJt4jNCgLU6BzCM1Vk/viW97s2XGdJ3jDqdTzHssbz43sXGdcRFIlu+3F7kcT8fFzeFFttwwwYPPkTVLpjoyMO67pXAUlu9MM7R/HWLG1utw0MgyBrTNt8X8XPnCmy3u3P4Zy+Ccjet7CvE0ia3ZacCnkksu4GXl6yvq9j1XQxvt5MEa4NsMpjld3zYKOgYTCkqYCTZI2qDjmoZEeC0AHE+SednsYQ1c9moXKznEds84TAEzQnA9avDijEMp7tAQ6bZcudCbhvu49bQB950f3OkyWfAjjIwikbe8Y8Tlb5WS6fLyF0EFdzPixRMQ77Ahsi/XASWjvnKow7X/BJwt3xZefmswlOortppg91lcAbcFkdq6s9NT4Rt6dLytd3uRlsqhBtGn7bThdgN9Cpva3Sz/wYSHKE23eGZ9pX3y9dfuFvIdMNGqYOVFoNUkq4E32+E8vBIEvMf/nsHW5KOHRwggyrtOZDMuZhKSAIAnbyj9RIDbli8umEwKKPbPggu++0XgVfbg1VDCwR+Hb9aVA59raiwsA0ymHyq06k1K/5wqTMG8+Bz6vLaMhT04emeSEhxj6zqJeD5rSRhFwCnDB/UAt2/vYlzSUx1mk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(36756003)(53546011)(83380400001)(478600001)(336012)(356005)(70586007)(36860700001)(54906003)(26005)(186003)(16526019)(31696002)(2616005)(70206006)(426003)(5660300002)(107886003)(16576012)(4326008)(86362001)(36906005)(316002)(2906002)(47076005)(31686004)(6916009)(8676002)(8936002)(6666004)(7636003)(82740400003)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 01:18:58.3089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e261643-a7af-4157-ab07-08d95165acfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/27/2021 8:48 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Jul 27, 2021 at 07:51:37AM +0530, Om Prakash Singh wrote:
>> Hi Bjorn,
>> I think it makes sense to have the scope of keeping default ASPM
>> policy disable and API pci_enable_link_state() to selectively enable
>> by EP Driver.
>>
>> sysfs interface for ASPM also does not allow enabling ASPM for a
>> device if the default policy (policy_to_aspm_state()) does not allow
>> it.
> 
> The ASPM policy implementation may require changes.  I think the
> current setup where a policy is compiled into the kernel via Kconfig
> options is seriously flawed.
> 
> We need a fail-safe kernel parameter, i.e., "pcie_aspm=off", for cases
> where devices don't work at all with ASPM.  We need quirks to work
> around devices known to be broken, e.g., those that advertise ASPM
> support that doesn't actually work, or those that advertise incorrect
> exit latencies.  I think most other configuration should be done via
> sysfs.
> 
>> Consider a situation, for a platform one wants to utilize ASPM
>> capability of an onboard PCIe device because it is well evaluated,
>> at the same time they want to keep ASPM disabled for other PCIe
>> devices that can be connected on open PCIe slot to avoid possible
>> performance issue.
>>
>> I see ASPM is broken on many devices, though the device shows ASPM
>> capabilities but has performance issues when it is enabled.
> 
> I'll wait to see your proposal and use case before commenting on this.

few suggestions:

1. We can have a device-tree property to disable ASPM capabilities of a 
Root port. Corresponding to my example, the device-tree can use be use 
to enable ASPM capabilities of Root ports that have known/good/onboard 
PCIe device, and keep ASPM disabled for opens slots

2. sysfs should allow overriding default ASPM policy.
    With below change system can boot with default policy ASPM disabled 
(performance). But sysfs will still allow to enable ASPM capability of 
selective device

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a08e7d6..268c2c5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1278,7 +1278,7 @@
  		link->aspm_disable |= state;
  	}

-	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	pcie_config_aspm_link(link, state);

  	mutex_unlock(&aspm_lock);
  	up_read(&pci_bus_sem);


3. Add API pci_enable_link_state()
    This will give control to driver to change ASPM at runtime depending 
on user selected performance mode. For example Android has different 
performance modes for Wifi chip, for sleep and active state. We are 
using similar API to overcome some performance issue related to wifi on 
our internal platform.




> 
> Bjorn
> 
