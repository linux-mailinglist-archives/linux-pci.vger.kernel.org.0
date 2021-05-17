Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA6382F3A
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbhEQOO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 10:14:56 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:58846
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238756AbhEQOMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 10:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXdKubOLI9QR+Yy3bLd2a2f3NxXs5utlM0FBKNC3AW/mND1wJNARHM8+k5wQks7jkAFW4Ft8p3RwevBVf3VrAgndSZyudsa8NU6YVm1IT5QUPwEKqqsH9lkftSEpx1DN4Q9BsX1LE7K4utsAQUVA+3rLPi2i0PtE8Z/ti2no24vvYWSeKZDNlhATKHpqB8mzlGzuNca4ys9qWOD7eEK/AaUVKm366xFedpIMjg3UewQvVMHxBpJDwVK8Rk3xCu1gZ4hun4o/tKLhFU23wghXkv+Qoa9VCSXUfhjNesOWRi3Q8pWR/zvzmboNcpREsgpnijdULsIJkgerGoVX83r6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZgilUNrIXEfRjcKgvViJczoO5z42F8Z8QCENXr1Ypw=;
 b=XpXJy/UqY5MDT0K8xiZ+3ismrJDA0Ti8YK5jsKFTZJPgH65LvGX+lNQlh0m2dTYKMMxSSFutfNzckS096La7qvuSAkfYu84SLihsiUKkIMwDjaLrUh925E7p6QyaPY+f14DLnc7RfoUq7MvigrnrAvfxErXJ/M4ozHZiI754M7ehlSg54j6MSXKIDBBuPdwiL4fcrMYv2UTCr2N1Q4IYCse0AZ2hpwaRZmJYv5Vy1s0arg7sH+RTClgohTDDHoWs9ROlINrCgKsADMdSF7sdIMYwWkCVcIu2jalP+1jq/ymM715Erz8MCrlxJOqpV/68XNnVdG+GAgtfcwpC2ZfVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZgilUNrIXEfRjcKgvViJczoO5z42F8Z8QCENXr1Ypw=;
 b=RilI0UoT91mNUx8LeU+DnwQTf0LFW7EOSjv/HQvE204PMRKuyh2qo3grbcNBs990wxx3hNTv8+cbUzpppRVkjCOCiVQ0RyPtRuVz1tJXzKb/Jkuqsth3ixkSvXKpVNi74NeXcoSRtqAoBNnqGnozUKuhrpegYWpcFmrnQ4IS8M4jApixiR3gfvFYMtpwM8W/Ykd+47zoP0/LygAUgk9tfAaBP5bVp86QZmBMsgdGzR4wcUFdXWlAmE1/NwuBlrT1kl3MZjLotfLaAZhr2AGCjacTfsQkQOvWunPPRuX398NO5HWSpDDB8FJLXd0QuBlcoVy0MjwOYDtnokB2rhqDVA==
Received: from DM5PR16CA0019.namprd16.prod.outlook.com (2603:10b6:3:c0::29) by
 SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 14:11:05 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::69) by DM5PR16CA0019.outlook.office365.com
 (2603:10b6:3:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:11:05 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May
 2021 14:11:02 +0000
Subject: Re: [PATCH] PCI: tegra: Fix host initialization during resume
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Vidya Sagar <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20210504172157.29712-1-vidyas@nvidia.com>
 <fecc2899-06ef-f91f-4a39-bb4ee664c800@nvidia.com>
Message-ID: <7dbc7daf-5512-c938-3aee-3c1994b50d07@nvidia.com>
Date:   Mon, 17 May 2021 15:11:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fecc2899-06ef-f91f-4a39-bb4ee664c800@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d229e493-739c-49e2-7e15-08d9193d9c39
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28293B18F31475C36BB805D8D92D9@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBWfqRUAHmmqcO3rCM6/v49RFcqHSzTuxyXddGThzy3Q+F1CJ2t3PK4vv7c3cthFst4VPDhv03qRdqnD2FvhI872e5CKPlZPDS+1ExyxTNc4JAt8CrGk+LSrUGoYR7Tongu42Y43MAkvyhc0h35vx1kYfmVT2dolaeNp3MAyTjDpHO4TeZni6fOZPDXx85lSbdPvfTZWpTkQxo6HcBNcF2o5hO2gyP/YKVgusKhq7TsoA+ntKTR/R6/ipeqlMyNzYkFrVlu2lcIQRt6BNs04eWu+Lsfgwav+eNG82abjF8HvMUoctJp07IzV0aLkPvxL2E1CUcIWUXmBtx9kC1BbiDRelhwC6FuSaq3JdgAy8pd4q7Td7B5fN5pX078Zqz8BtJS7KS/WeEB1sBXOph4JyAg9aeVizK5UXGvlW2szLJr5IwxFC7F9YIhiL+bh9JTTCbImQLc5eLuxa4CV5AlEQXOowx0BTmFDZQinrFWRHfE4rGXXOzGSKIdAo+iFZF1xVo0pZ86xRiNLP52tkwY1vwabDga91sTYjLMLBoP07nFgOMlM+sZbXZN0ZNLKPCf9Xu/svI4JXW9W6cEr/l8pwUefALEeCSiPwG+TMLeZ6TAcRMC8vSgFY9/uguFhedWFEfWYiDikuAuCgayVOeueHhbZpUdldblAsFh0zZW4wLrpu8QLWXrr68uxDwVCYuAN
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(31686004)(2906002)(5660300002)(426003)(16576012)(36860700001)(336012)(478600001)(70206006)(7636003)(36756003)(2616005)(86362001)(186003)(16526019)(4326008)(82740400003)(7416002)(70586007)(8936002)(54906003)(53546011)(8676002)(82310400003)(26005)(356005)(36906005)(110136005)(316002)(47076005)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:11:05.3349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d229e493-739c-49e2-7e15-08d9193d9c39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Bjorn,

On 06/05/2021 09:49, Jon Hunter wrote:
> 
> On 04/05/2021 18:21, Vidya Sagar wrote:
>> Commit 275e88b06a27 ("PCI: tegra: Fix host link initialization") broke
>> host initialization during resume as it misses out calling the API
>> dw_pcie_setup_rc() which is required for host and MSI initialization.
>>
>> Fixes: 275e88b06a27 ("PCI: tegra: Fix host link initialization")
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 6fa216e52d14..4c3c0738f2e6 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -2214,6 +2214,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>>  		goto fail_host_init;
>>  	}
>>  
>> +	dw_pcie_setup_rc(&pcie->pci.pp);
>> +
>>  	ret = tegra_pcie_dw_start_link(&pcie->pci);
>>  	if (ret < 0)
>>  		goto fail_host_init;
>>
> 
> 
> Thanks for fixing!
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> We should also mark this for stable so that this gets back-ported.


Can we queue this as a fix for v5.13 and tag for stable?

Thanks!
Jon

-- 
nvpublic
