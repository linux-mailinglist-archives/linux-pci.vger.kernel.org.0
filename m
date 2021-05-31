Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFAA3958AB
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEaKEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 06:04:23 -0400
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:5345
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230518AbhEaKET (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 06:04:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL+mpDvpY1A5iVrVnRlLxbM7UhmSxKWIQvUs3/uMQGhSWqmi+3OtyKnCxnnEJXKbtQufIIdKUWfRK5NTlg+Ak4rOL0oR5vW8I7yC30omqLDm/dXjKFGkmmNh51Icvo1vD3mfW930bfWjxZQy4XdfdAHw+l7cfxGrQjegY8Lm+I4LYzEZaqvHnkWzmsw8koq/2gHi9T0fL+FuRS2yvDeePstv2lq/PRru5WwTz9BlwPDfVSWD3oe7uTXZblXQNu6WHSnw7J1WoaPkhmPz3yo0ySFhkPVS0x2Yvj0im1pY7goZ6v/ZtICprg+h73318HMFmSyaEeo97BKxuvp1cbfnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6xuuHLlNLUoqJonNb8AyQo66pC4sgQQf2Ov7U9BTJU=;
 b=SNKdrvPXHInYVolA7JL42c5Rpv8eKT+B50mTcl7bBcMpWlMVO+lqfYDwgtPKc9UctOyYFXRiKUVX2Kwryh+I3A+ZJ7mvSQq71qL/b1uDJiV2jrijSF92gnDHp+fGjjVl6UO6mrRWo1TstcTVVmpvnp6+M2uLu+cTtp4Ya8rFdjedIgVWd6ThBeiNW9YENLZg76XSErKq/y09bPt/52XIZN0EBFcOqihjcFJUDa3hPWzXMZfZ0Vrk2cHCPLtuNY2y9dl60LHxYI9kQZ5viX8Uo/lauTrERXs42cqjn0tYENp+qq/d0aUy/zJe0+jmEfzvfAehgzmk56lgtk+DiieZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6xuuHLlNLUoqJonNb8AyQo66pC4sgQQf2Ov7U9BTJU=;
 b=bgnl+L3IbVeqbUbgDxCa4I57gHIyeQU6mZpazKMo3NuiOCAx6QRYuXGIfiRnS3QjVeUcn/JcV9QmlEHrJC0L2dCVvvjqwne6/yPioQo1ZrSGVsVXlEjw+buLvynTGYejpiHR+tPh66nkNxaRvONqWRFcE0a5jpbbaLkH6UnzuLXNujucYd9J4Rn8EcxsbPjo6vVlw1q7kEpUwJydu8N9Uq60Mz1hHOLQ41LDGeEP9r9zu/VvxgSRAm2E/ixFj63au/jzzAcqEdE54hBJ6SW2QF/VO2dXADJJEvJ0Wd8GvduaWwB+OpvcbSmCaoa+CILevwzpCtqBTB+NUaU+ukuPXg==
Received: from DM5PR04CA0058.namprd04.prod.outlook.com (2603:10b6:3:ef::20) by
 MWHPR1201MB0077.namprd12.prod.outlook.com (2603:10b6:301:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 10:02:38 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::4b) by DM5PR04CA0058.outlook.office365.com
 (2603:10b6:3:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Mon, 31 May 2021 10:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 10:02:38 +0000
Received: from [10.25.75.132] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 May
 2021 10:02:36 +0000
Subject: Re: [PATCH v2] PCI: tegra: move to use request_irq by IRQF_NO_AUTOEN
 flag
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Tian Tao <tiantao6@hisilicon.com>, <p.zabel@pengutronix.de>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1621213953-54030-1-git-send-email-tiantao6@hisilicon.com>
 <7e203ed5-526f-3a45-9f82-ba3f567bcc83@nvidia.com>
Message-ID: <78dd0d27-aca7-9d99-a79d-8587a2fbbbfb@nvidia.com>
Date:   Mon, 31 May 2021 15:32:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7e203ed5-526f-3a45-9f82-ba3f567bcc83@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f75905e1-481c-4bc8-7ad4-08d9241b38e6
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0077:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00772E10A100295115D63E24B83F9@MWHPR1201MB0077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjcvaB+fFwYHMA1Lfn2K/Ao+TKLFn+eM7DWJ/PjwLStJnxNq5eNQu05XD9LILt08jPlzMaEPxGUlHKqpU8szsK4l42fIwwYDDL2rtw2U8pVdrOjuyavuDcm5lgvbNT/kFmlGgYQkci/+Dj0DXWmDIif0au8Tl5CcuevtsdH07zz8xj3mN/v+vUdJPaIVeGgXDslRw5y+EsfhVP/X4/glZfLwuT/DO1CSxHD9nWk1u0vkgFHm6pbqHR75jQYgWWZvyfqBAEp0uldr6Baq5Ubbv7A4af6YX1qnKMHez7xdAsjwB3BT+wGhEWoqLnHFU67AoIh6ylF7kmdBpgCwKVOURssPIXTRa9OS0oZOttJ+WeIjjrsDf7MyFHM5RD9HUoKqfy8w8v08GK5Dg4vaGBUrpmb0nM4L24iWxGHsHNw9x3MUvS4ST0OyG3UHEn56fV/agDDFxyd9RZQD9toKAq5M/rp1IvMvNV14Qdc8K42jy34BCbvHoDHIEuxxxXQHtt81m2IYrbXVI17OGn/cfZXwQUEhmShKr+1ZD5wTcSqOLQEu5qCT2NwUOzs8+5Hh0TjyEpW21vY/vRD/JYJQE7M1wmOZxoAmqFEZ0AwEb9qlbYIEd3aAcChvgLWjik+S0prRwx0yN//koh9RAt0YVcWRDGCg1IFrSC7s6oYnvvi9yngGdLBxt7NeA48iit6NApuJ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(16576012)(36906005)(36860700001)(316002)(110136005)(54906003)(83380400001)(31686004)(4326008)(82310400003)(7636003)(47076005)(478600001)(8936002)(8676002)(426003)(82740400003)(336012)(356005)(5660300002)(31696002)(70586007)(70206006)(16526019)(186003)(86362001)(26005)(2906002)(6666004)(53546011)(2616005)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 10:02:38.5762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75905e1-481c-4bc8-7ad4-08d9241b38e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0077
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I want to re-examine this patch.
I don't see any references in the kernel where IRQ_NOAUTOEN is passed 
directly in request_irq APIs. It is always set explicitly through 
irq_set_status_flags() *before* calling request_irq APIs.
I don't see any comment in the header file either that says something 
like it should always be set before requesting the irq.
Lorenzo/Bjorn, could you please throw some light on what is correct 
thing to do here?

Thanks,
Vidya Sagar


On 5/17/2021 3:47 PM, Vidya Sagar wrote:
> Thanks for the patch.
> 
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> 
> - Vidya Sagar
> 
> On 5/17/2021 6:42 AM, Tian Tao wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> request_irq() after setting IRQ_NOAUTOEN as below
>> irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> request_irq(dev, irq...);
>> can be replaced by request_irq() with IRQF_NO_AUTOEN flag.
>>
>> this change is just to simplify the code, no actual functional changes.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>
>> v2: update the commit message.
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c 
>> b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index bafd2c6..7349926 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -2021,14 +2021,13 @@ static int tegra_pcie_config_ep(struct 
>> tegra_pcie_dw *pcie,
>>                  return -ENOMEM;
>>          }
>>
>> -       irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
>> -
>>          pcie->ep_state = EP_STATE_DISABLED;
>>
>>          ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
>>                                          tegra_pcie_ep_pex_rst_irq,
>>                                          IRQF_TRIGGER_RISING |
>> -                                       IRQF_TRIGGER_FALLING | 
>> IRQF_ONESHOT,
>> +                                       IRQF_TRIGGER_FALLING |
>> +                                       IRQF_ONESHOT | IRQF_NO_AUTOEN
>>                                          name, (void *)pcie);
>>          if (ret < 0) {
>>                  dev_err(dev, "Failed to request IRQ for PERST: %d\n", 
>> ret);
>> -- 
>> 2.7.4
>>
