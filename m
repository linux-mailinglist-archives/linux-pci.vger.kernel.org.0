Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D963AEAF0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUOQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 10:16:42 -0400
Received: from mail-bn1nam07on2046.outbound.protection.outlook.com ([40.107.212.46]:26477
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229765AbhFUOQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 10:16:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhMYslwh3JCR/6yPmEouitNXRVvcRnxoNGF4OUSug+V2ZRla3PNje+UqcuZvAtFLN88Cwk+DbPbZK41X9Jgkw5rf46lAXY+25xVRjg7UwOCCnrN2AKA3wDIT56f1drcS3yd02lkpunT63yhfvC2/aQpgHdxXfCDItxwv2Lcy2LBJujR8DwLD0BqXGuumO8tF00rteau42Sq0ACBd9jCuhHmmb3+mzukUlebrSzeXUpyenwItCq85NRpULn0RxCRLQQpdAT8bxaYNgoRLqE+mByls4R2ALY5Sily9YvRj8e4TRTGe9OfLNbxkLy2cD4g1aGVHKscyu2yVSRNSbrmKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7PFXwSgJ1FrN+6jdAgTO561y1bdM+3fz+nVyAKU8Y4=;
 b=NUeriFffVKXR4Mo4/12wklyUl3ax8F/1mcJHVk+WMP3h1QWd0epDRhLgkxdkFtE7QGiGyjNx5KCAl6jDwThInrbwfRAs68yJ0kZyb+083LUYeKQkpamBigvezIuion7m+1jfJbuKnEpkqRGiKe5oxS3tlXSs2XRnMUgzcponGvBm64lrAM4ggvytEArn7KMXW4wQoS6Qt+gEZa9Y5dHirsPp/7nbF26+838cyOUsnUpDiYx2q8qrtIkOTH7tMo6fXKxpEUlOVETyfwvmXLMhXGn5UgcTcBF/RXGZbXOcjGjssVJRowQG2Bpaz1rX/NumdWRXe9fdzWaQC5uNGGEsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7PFXwSgJ1FrN+6jdAgTO561y1bdM+3fz+nVyAKU8Y4=;
 b=qG9HMDGVYULhJfle+EoWxyTyPKeag9Ao/3fIYy+9GB412rCAUsd36thAaiI314P5HUsbgW5PaWAY96gCfaXHZJDB1zkFW+zymsJZi5xdIK3s9e77ASnhzpzUtbOzR0kqlNwClgeVMZGKyYkh3afPSglxwhCGYu+jJ74K93mdfOMfgaNjofuOVKmGFVfMU6B9rPdhMC+JYF+BXjnfBt6iSHEUJWxi2Bv7D5a+y++Z9BPoHEl8QajqXPOkv3+6CSAeCs/bK+JO3SFgKxa/r2Md9s/2021wHA2k7BQpWdWI8tuGag8G5GGdaHWYva5bjaDvpJEoRlssihY4D5oIHUQCog==
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 14:14:25 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::c0) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 14:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 14:14:25 +0000
Received: from [10.40.204.223] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 14:14:22 +0000
Subject: Re: New Defects reported by Coverity Scan for Linux
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Vidya Sagar" <vidyas@nvidia.com>
CC:     <linux-pci@vger.kernel.org>
References: <20210621130526.GA3289008@bjorn-Precision-5520>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <7ded7733-8b7d-c959-3eab-f8924a397285@nvidia.com>
Date:   Mon, 21 Jun 2021 19:44:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621130526.GA3289008@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4870c225-415c-4f7f-7718-08d934bedfe8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:
X-Microsoft-Antispam-PRVS: <CH0PR12MB53465C86917EF47DA01FBBF9DA0A9@CH0PR12MB5346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKHe74YI0LwZLVAcVvryZgNx2Rx2ui2yJAoYMRyEc8bqR2xR71NchmY+EH9hjkyA7t13rIv0MiyJEBt/HDhvgtm27cTWA6ag73DaK5tccF/F7uDE/1z8No4WxGMogMs9RIFkYbcYOOYZV0Q+EPUctOwqWF3cVs+TsjN77ckD9BUqa47/dK1gbZLOToKSoyzK5Ho2vNc0BGLUe8Frk3FamNGqYkEpcuudmX5n5Xa9W3UTvVRZjAlnDWXA9SwNhsCJboh8LPkBNn2a/6/4XV0j8CUKqQFwtvspK9DItGSybG6Zg0cRLlzwVZCK+PR0RD1CFvegrYLQJrrmCKGBh/Lg3WIeIuFlw+UH7b+HwUK6vhkwCL962Z9OkSeWL1m5DLXJYVJ5Y4GLdGRzwI2bN71ZcAlaFr0qhcukjK/jk0Vo3WEqyeR+YuxJbEF9Bar6nxdcxRfJElKvS5vQZsOlCD9ubIWAAPR7upHHeTNXafIsq6HULvzjMPQpmdtdnvoS2KTmKS3Z0NylY7CwwQhgJIlWmXjoJ/Tx4z5C01R+O6fc+FBZ4viota8fNlMZMfxKv6AuhoZRcC4OAzXuWneYSwUeY5ca1RqRGIvbUwdumyr35pxPCcc0uB2uX+5aEF+SL0DU+c9gAaLPmbeatemJ34LzF8IIcaT07pYk92BVFLuSrnmzb4QE/qcjHq/JYfWGlRgL
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(46966006)(86362001)(53546011)(2906002)(8936002)(426003)(2616005)(70586007)(36906005)(6636002)(7636003)(82310400003)(110136005)(316002)(336012)(16576012)(70206006)(6666004)(47076005)(4326008)(356005)(82740400003)(36756003)(31696002)(36860700001)(26005)(478600001)(31686004)(5660300002)(186003)(8676002)(83380400001)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 14:14:25.3491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4870c225-415c-4f7f-7718-08d934bedfe8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Bjorn for sharing the result.

We will work on the issue

Thanks,
Om


On 6/21/2021 6:35 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Om, just noticed your series of pcie-tegra194 updates]
> 
> On Mon, Jun 21, 2021 at 07:44:26AM -0500, Bjorn Helgaas wrote:
>> FYI.  Looks like we rely directy on the result of a read from the
>> device to index an array, probably not a great idea.
>>
>> On Mon, Jun 21, 2021 at 07:45:30AM +0000, scan-admin@coverity.com wrote:
>>> Hi,
>>>
>>> Please find the latest report on new defect(s) introduced to Linux found with Coverity Scan.
>>>
>>> 7 new defect(s) introduced to Linux found with Coverity Scan.
>>> 4 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.
>>
>>
>>> ** CID 1475616:  Memory - illegal accesses  (OVERRUN)
>>> /drivers/pci/controller/dwc/pcie-tegra194.c: 994 in tegra_pcie_dw_start_link()
>>>
>>>
>>> ________________________________________________________________________________________________________
>>> *** CID 1475616:  Memory - illegal accesses  (OVERRUN)
>>> /drivers/pci/controller/dwc/pcie-tegra194.c: 994 in tegra_pcie_dw_start_link()
>>> 988                 retry = false;
>>> 989                 goto retry_link;
>>> 990         }
>>> 991
>>> 992         speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>>> 993                 PCI_EXP_LNKSTA_CLS;
>>>>>>      CID 1475616:  Memory - illegal accesses  (OVERRUN)
>>>>>>      Overrunning array "pcie_gen_freq" of 4 4-byte elements at element index 4294967295 (byte offset 17179869183) using index "speed - 1U" (which evaluates to 4294967295).
>>> 994         clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>> 995
>>> 996         tegra_pcie_enable_interrupts(pp);
>>> 997
>>> 998         return 0;
>>> 999     }
>>>
>>> ** CID 1475402:  Memory - illegal accesses  (OVERRUN)
>>> /drivers/pci/controller/dwc/pcie-tegra194.c: 457 in tegra_pcie_ep_irq_thread()
>>>
>>>
>>> ________________________________________________________________________________________________________
>>> *** CID 1475402:  Memory - illegal accesses  (OVERRUN)
>>> /drivers/pci/controller/dwc/pcie-tegra194.c: 457 in tegra_pcie_ep_irq_thread()
>>> 451         struct tegra_pcie_dw *pcie = arg;
>>> 452         struct dw_pcie *pci = &pcie->pci;
>>> 453         u32 val, speed;
>>> 454
>>> 455         speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>>> 456                 PCI_EXP_LNKSTA_CLS;
>>>>>>      CID 1475402:  Memory - illegal accesses  (OVERRUN)
>>>>>>      Overrunning array "pcie_gen_freq" of 4 4-byte elements at element index 4294967295 (byte offset 17179869183) using index "speed - 1U" (which evaluates to 4294967295).
>>> 457         clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>> 458
>>> 459         /* If EP doesn't advertise L1SS, just return */
>>> 460         val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
>>> 461         if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
>>> 462                 return IRQ_HANDLED;
