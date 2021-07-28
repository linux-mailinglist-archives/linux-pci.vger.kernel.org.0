Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523A3D9503
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhG1SIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 14:08:44 -0400
Received: from mail-bn1nam07on2053.outbound.protection.outlook.com ([40.107.212.53]:13958
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229542AbhG1SIo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 14:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULAwQiTaXVFzyIhAQPk+lnVBMBWZaxyrqDd6C/N0nr7mydQfyIoyfoZEsw1oGxxh6PxsyYj34q24vBoyWPFfVJ8nfI/EJXsrYHZ7cm3/WKjM6kjrX1JG2wQRWzlfhXE2IRwvSq/zn7Uraqe/ZHxEkT/tDQXIJbaFWJoiy6Iwdp8R/SW7tCrg2D9Quiu9klVkMwAreQrw5dLf7hU9pQs8t1JDqc89dEQi2bRSRQUtAWXTdD9DsDFtSKPM8L9/n7fXMhDc8ZfYp07frUoaHU6RFJUVnQpDXY1Tl7zC7nXOuVmpwds04v1ERBcvo1pqfyH27D2FysrEzUJcNdQmDSADHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yutGl2JXoYQtPHIKC00dK9B+HtCnkecdQEfEWl1u5T8=;
 b=YUVKCAz48wJlShav71bk1dfvKJ8IIHSA+CS9FKSw33SaH/MLn04YaNWe31tO8DKHxZ1JPNbcxLzEFG/PjAy1jRApia951ccusgXzhhRKtNtcNU5v+/OmMvmfId4SHigxv8LfUc1xi8Q/Ui4jY/+Co5CPnRX4VMOAdYeKIQKbmsomzTY2jCePX3DqUOW57PdHBu5B1LGH/2R5ohStj6xPfrWGiEFjszHf9TBxyo/HpXLSKuk7oxQxmupQV3S5CuSXdQUTKH15yX86XTzqZJxaRlq0gyV8LQc3npzq5u1owxm3v7bG7M6kmqAPUaAb10veGMMFgvIIPTpyPYtOzeewvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yutGl2JXoYQtPHIKC00dK9B+HtCnkecdQEfEWl1u5T8=;
 b=I3RZYxeaELdWfGcpCWYxid/NKcy9k/P4MIpLnDHJegGxcV/WhhzFXohC9ydi5GBDzNLNfAHHMjedEFP6YRbw9L1P8BQBhlU2yjBjZje+elDzFlzH12DkUwv3HhwWvjp/RhfjFR69lJnITfCYsFNOJtqo0xRAQoFjFkyo+bm1tn4a4EqtJewgRBjIQqAMhNT5KJKq7d3lLON6afrndvU7S7YRzZ4mi9NExiG47X1motq1AwJ/kjwHsIshDaRLFjEFox7QKVPEfYb+D55AePQfsp9rHO+9nZ0gkOKdxHpfERw6UsxIhKybCeuMNaczzaLmDxxbjb4/Y8214An77M3vGg==
Received: from DM6PR06CA0006.namprd06.prod.outlook.com (2603:10b6:5:120::19)
 by DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 18:08:41 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::82) by DM6PR06CA0006.outlook.office365.com
 (2603:10b6:5:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Wed, 28 Jul 2021 18:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 18:08:40 +0000
Received: from [10.20.23.47] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 18:08:38 +0000
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210709123813.8700-3-ameynarkhede03@gmail.com>
 <20210727225951.GA752728@bjorn-Precision-5520>
 <20210728174519.has5xvy6rksbukup@archlinux>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <e8ad2686-22e8-7d75-f0f4-82c0c57fc65e@nvidia.com>
Date:   Wed, 28 Jul 2021 13:08:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728174519.has5xvy6rksbukup@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320faaf6-f7aa-4906-0780-08d951f2baf3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2473:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2473DC31F6D48F9D2237FB44C7EA9@DM5PR1201MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpA+JC4ly3JXxA7Z3cyAWGgsUH3zu8LcBaqJvDzpOmK82/QFNTJkXd2mhYNEDk9TOTYoFUaAkBhz03Un1I1v3z0fCVCcL+FYMDzE2+Zgzy61KLzJvBcRWi+H0O9ZFByi8n0Ui5PUmxKgyX+r6GE7uOhiNmZ/cFc0AQpM6Vwloxu8Z2ljjEv23fPmEHKTJTynVI1wR+MHi/ODAL3eF9XfjYXaTAgfW3PM3H1YeZKwsiNe/peh0S2Tu3eLbuG1tgxbZu9pLep6I1vPanHQC5Vcvhh0ZhT+IK1jfs7IBQHFTg3Ce8iDSgwKvjHQEzcmhgNdDhsTfhIM0boNrhOvZhKj9Xojs07IsYEl1Z06CixNRVEtg6M2XbRJXXLFCP8BTzigs8dosK5LLItCyNf3vHN9EOG3reeK16n0T1XHgli1i2xVr/4L9vPg8Pbd+P84TasTJBiG0QoZOj2q0I+fc4UJZ1J0elG3tdF5wIVmTB+cY94whDBfFxn+OmDGyoeyxjKJxuEDhq9GwImhh7SqYJLQ9h0o+i0OepoAtns/tKOE9VLQpok5Mr1xSENrkH4E86HWDo26sCY2XVXU4cXGR4thO4gZ1hLsHO8gVE7xIHWabv/Wtn1gLbcIwI570k9BltUfgWrKd4vplIPGh4L8T4fVevrqPd1YZWoSNI3LSDY20vDV1U5cUAY0B+O2UPPK8Qz97TAuIlIS9ufASuPZVzJd3CxOD38l1pBUYWbDj9qkOCI=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(7416002)(47076005)(16526019)(36756003)(186003)(53546011)(86362001)(36906005)(2906002)(31696002)(70586007)(26005)(316002)(8676002)(8936002)(36860700001)(426003)(336012)(2616005)(70206006)(356005)(508600001)(5660300002)(4326008)(7636003)(296002)(54906003)(110136005)(31686004)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 18:08:40.8901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320faaf6-f7aa-4906-0780-08d951f2baf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

On 7/28/21 12:45 PM, Amey Narkhede wrote:
>>> +   BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
>>>
>>>     might_sleep();
>>>
>>> -   rc = pci_dev_specific_reset(dev, 1);
>>> -   if (rc != -ENOTTY)
>>> -           return rc;
>>> -   rc = pcie_reset_flr(dev, 1);
>>> -   if (rc != -ENOTTY)
>>> -           return rc;
>>> -   rc = pci_af_flr(dev, 1);
>>> -   if (rc != -ENOTTY)
>>> -           return rc;
>>> -   rc = pci_pm_reset(dev, 1);
>>> -   if (rc != -ENOTTY)
>>> -           return rc;
>>> +   for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
>>> +           rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
>>> +           if (!rc)
>>> +                   reset_methods[n++] = i;
>> Why do we need this local reset_methods[] array?  Can we just fill
>> in dev->reset_methods[] directly and skip the memcpy() below?
>>
> This is for avoiding caching of previously supported reset methods.
> Is it okay if I use memset(dev->reset_methods, 0,
> sizeof(dev->reset_methods)) instead to clear the values in
> dev->reset_methods?

Clearing the array before the loop might a better option, we can get rid of a local variable.

void pci_init_reset_methods(struct pci_dev *dev)
{
        int i, n, rc;

        BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);

        might_sleep();

        memset(dev->reset_methods, 0x0, sizeof(reset_methods));

        n = 0;
        for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
                rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
                if (!rc)
                        dev->reset_methods[n++] = i;
                else if (rc != -ENOTTY)
                        break;
        }
}


