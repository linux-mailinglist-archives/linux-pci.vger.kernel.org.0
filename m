Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD7383B80
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhEQRnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 13:43:17 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:53504
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236106AbhEQRnQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 13:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVnYfgWY4rgaZ6tmd7oLtmz6bQZMLF4DJOhQAFbNUwrmW4D9Asy3PCTO1P6UC+Z8Z2spO2XQpzhakxgqxeV5ga0PmhioTzb9NFwuAvMtHKTCySwykwQGsD3bl02J92d4Ru4AnSMTe7WkwzEqnZtH1uOgXam1w8XZUXYDSYwn4hxVlcDrYVQT/AQqoNYGlU/eihEGsvsNNhhqOeo0HPDfstuU0MBD198UeleGkM4y9codQVK0vKnCCImJCuuuLg5BeYLXguzr6/+GLeumSQ+TSH9EAKs3yZ0BmmMS8qK/xaF1IaTdsG+inntoxyCgOWAmdqkqqXxAnc6OxGDnt5zrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3UnyQ2VJlsHUPJijOyPw26iTrQ76wEAC4WK/WZ9r4Q=;
 b=iGRacWKGWmGE6t1yLFku4cbP+t3P50oW58LwasXa6Dpcd4kLHdzuYgGum5mcxfcav1OXZXzjurJv1muqonA1vjiBZVwnD59B3LQZOn4SC9JMKiU42KuS6lPiXv69yi6F+Dqq+S3XVsi5WhwfOQLH9Pr+hbYosZF4Ue+bxpseEJ+xJfjMyPGd9CxhtXLHtcEIKcoHhgiWY2upQtCNZS/hv0WNLLC9s4Hy2x52H9fXnNLsXlXREvquB5xUNKPlolE0ktdJfr7r6NYM+UI7zPyrESElIQfAYJ91+cBLLNhJCY2vpSlknrdtIzGHnngP8curssX0l4hXKkh10L0Hbb0Xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3UnyQ2VJlsHUPJijOyPw26iTrQ76wEAC4WK/WZ9r4Q=;
 b=QjWJrDdx6rxqu7HMBgqWTlZYk6MYA13MTZzlvnz8EUhQsz6vs7e/VvaGMt0ufk7CKyJaPLeRSikE4HUzaHyTTO311NvzrSQetz5V+ritj5CqTnor4QzsETDk7/YJjJxjOUA6jezV+vjznZrHeyZFDdXuHwdD9/X5+XLS5B+PPfaQib6p1lW8e45DnlsDU10i4L0e3P2FOcsOZ5ZEHK9iAvlAiULR5Og+JFmrl95sCUlH5pmFuVHUTf3jyRDjgqimffz4ZihzYeBDKNrwhsyJ/RhLcbTy4IrLbqQ4JHzzZLXLj+hnVTv/doR/Ia7xezEJQvX3Ka/l3xWJVeL5lpU7lg==
Received: from BN8PR15CA0033.namprd15.prod.outlook.com (2603:10b6:408:c0::46)
 by MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 17:41:58 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::5b) by BN8PR15CA0033.outlook.office365.com
 (2603:10b6:408:c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 17:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 17:41:58 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May
 2021 17:41:55 +0000
Subject: Re: [PATCH] PCI: tegra: Fix host initialization during resume
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Vidya Sagar <vidyas@nvidia.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20210517164733.GA22939@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <20676ee9-670d-311a-b417-1eb5b5837376@nvidia.com>
Date:   Mon, 17 May 2021 18:41:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517164733.GA22939@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b77a4f67-efd7-4457-30c7-08d9195b1237
X-MS-TrafficTypeDiagnostic: MN2PR12MB3439:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3439FE3D3758B37DB079EFEAD92D9@MN2PR12MB3439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylaulc+zGwThpE6o+x8wMqSorgiKglnNgdPj6Gb5Uc2JtjVL6mEAldJtX2+/d/WyzUcV6U6xPeGtydDhy0OjZQnsyyB6ijFqBiC5O95ArLpFVNXRHiGKBeQKRFoQrBH16Zuzmwy33UJ+NxIzoJpipXMbCXPNwqJQFIoCwJZOGfg2ng9tKsa36UBIWGpA3RRn6vGFPiDFcBKVrGxYXoG2leknQM+A9PShzQTATK3qiD/pIi4g5G5Foabhb+pAZMEQUhahFpdn6eKuLUsDcfxLZuFFRFIQA9NIKA9qP4VGEGy9F6vniIbsu86vtfOu7fAunoz7P60Kp2CKidL0DayPopuxIV3M7IslvcEH+x0dlxNZJvwmUx62cEhHh1vgwZ1an38gEzWET1YEL258KMp3/gVa4mIboId+w4DVQa5bzmIsvEq8dNCe/iBL9dC9TxV1O1GbOH/DCPmLAMGY0gnzxe8esOZMcAfKH2qhdnni/nzhpDBFho8Qja35X2mTrcSRJPf4hibMCt+FX7RGXtD3GLSTnjw6I0/vIRlt4AgPYfytsdPXF9MNN3pIr+rAVjVLp0StwBgYaSJuRNQo0srmIdc0BGaHKGEkPq/UpyKh0RQDV3T9CWHe4uijVbCggkj6QSaZ0K6JAmaqGXxk8FMoaRWfSEs1kIoIH5sWqj2KC0dbGjj9r5NBSOjDFU+moCTq
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(47076005)(36756003)(70206006)(5660300002)(316002)(36906005)(356005)(186003)(86362001)(7636003)(8936002)(26005)(16526019)(54906003)(31696002)(70586007)(110136005)(2906002)(16576012)(8676002)(53546011)(31686004)(36860700001)(82310400003)(2616005)(83380400001)(4326008)(426003)(336012)(82740400003)(478600001)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 17:41:58.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77a4f67-efd7-4457-30c7-08d9195b1237
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 17/05/2021 17:47, Bjorn Helgaas wrote:
> On Mon, May 17, 2021 at 05:18:36PM +0100, Lorenzo Pieralisi wrote:
>> On Mon, May 17, 2021 at 03:11:00PM +0100, Jon Hunter wrote:
>>> Hi Lorenzo, Bjorn,
>>>
>>> On 06/05/2021 09:49, Jon Hunter wrote:
>>>>
>>>> On 04/05/2021 18:21, Vidya Sagar wrote:
>>>>> Commit 275e88b06a27 ("PCI: tegra: Fix host link initialization") broke
>>>>> host initialization during resume as it misses out calling the API
>>>>> dw_pcie_setup_rc() which is required for host and MSI initialization.
>>>>>
>>>>> Fixes: 275e88b06a27 ("PCI: tegra: Fix host link initialization")
>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>> ---
>>>>>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>>> index 6fa216e52d14..4c3c0738f2e6 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>>> @@ -2214,6 +2214,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>>>>>  		goto fail_host_init;
>>>>>  	}
>>>>>  
>>>>> +	dw_pcie_setup_rc(&pcie->pci.pp);
>>>>> +
>>>>>  	ret = tegra_pcie_dw_start_link(&pcie->pci);
>>>>>  	if (ret < 0)
>>>>>  		goto fail_host_init;
>>>>
>>>> Thanks for fixing!
>>>>
>>>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>>>>
>>>> We should also mark this for stable so that this gets back-ported.
>>>
>>> Can we queue this as a fix for v5.13 and tag for stable?
>>
>> We usually send fixes for -rc* when the patches they are fixing
>> were merged in the current cycle (ie merged for v5.13).
> 
> Looks like this has been broken since v5.11-rc1 (December 27, 2020),
> when 275e88b06a27 was merged.  Probably would be worth an occasional
> boot test to make sure things stay working.


Yes exactly it has been broken for a while and unfortunately went unnoticed.

We do boot test -next, mainline and the various stable branches on our
Tegra boards daily. The boot test did not catch this, but there is a
error generated when resuming from suspend and I am working to ensure we
catch such errors when resuming from suspend.

Cheers
Jon

-- 
nvpublic
