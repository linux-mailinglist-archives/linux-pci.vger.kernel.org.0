Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E324445DA0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 02:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKEBzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 21:55:33 -0400
Received: from mail-eopbgr1320119.outbound.protection.outlook.com ([40.107.132.119]:8512
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229685AbhKEBzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 21:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfv82r+YskmvRbkOhvjxg2gkb5NSMJQWNezi94v4S5Qd09iM52m7cBsT2Kh/w9jHEfKvuTTOop2PXdCI9yHPm5hYFCtw44KdziQbIQ0xq1ilxDE6Tc9h0aIVZ3QQnmE14Y5QgSwQOGuqpH3l2q3r1OOgxRDQQzvSdI8AtZrR8tHwxKTUq/XQx2QBVrMDx/OhPxCg0z3bsVohpRHMHKEDG+qJSOanK9e6Bucpo6roJQJ3066JwBQr9Joz704vCAiH5EAkvHyF8AIiW793W1+HLpHtaZfT3lkfXZqyq+ARS2VHThLNWqvx6s8skP/DuxDLLtF08ioG2Rnl5sdtTMEvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJf+kOJDXLy80dZ93O645Kl5anNe2k7FlgS2J1agIwM=;
 b=SfxtTKKvMrrAWsdFPQHTOSNw8Jo9WlSFiB3HijVsgRa8+JUkeuj+S0sxfoY1Dsy9aBkXvenytFwB0Nn8V1TxNayhGc356rX4GyQxdTK8I78iC7OSzINxsU5mj2SWNrF/kFP7PpKdWh5AiRDZ4EXEz7vU5hZGr/y50xUYZzZr+CGA9BfGzHHlb144H9ubg1FUtOvgPfixt2/QubPHVyqv93Hu+Zbkx9rHeV59OygTsvbVvmw9zT77C6qhU2NEEA7ueRWfuMqfrgscwhzZH978QqchhDLP7e4Yy7AeiRqgzPovH5y3TZmPt5clnjjFUQBMsL968dLeVqI1+0Q968DIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJf+kOJDXLy80dZ93O645Kl5anNe2k7FlgS2J1agIwM=;
 b=X4wJ4wexndmMUBy8J7rE0nI8HN3U43Fx+kVUN/61IKTfYrq4Wl+XgHEqD59xgsFKtcr++c9UHqYEjPsCPeSUBT9xAR/7LlVGKe8o2sARLdEQOP2KB0G/WQzJcGq8MciVQjKbn31xQS+6w9CWqPYHUu5c3p8OZKk5p4rloseRfVc=
Authentication-Results: qq.com; dkim=none (message not signed)
 header.d=none;qq.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3045.apcprd06.prod.outlook.com (2603:1096:4:6c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Fri, 5 Nov 2021 01:52:50 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 01:52:49 +0000
Subject: Re: [PATCH] PCI: kirin: Fix of_node_put() issue in pcie-kirin
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jiabing.wan@qq.com
References: <20211103062518.25695-1-wanjiabing@vivo.com>
 <20211103143059.GA683503@bhelgaas>
 <AF*AtQCaEjn8dlEJIiS9Xqqm.9.1636034225636.Hmail.wanjiabing@vivo.com>
From:   Jiabing Wan <wanjiabing@vivo.com>
Organization: vivo
Message-ID: <8819ab07-9cbf-dc68-34c8-69d67cae53c5@vivo.com>
Date:   Fri, 5 Nov 2021 09:52:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <AF*AtQCaEjn8dlEJIiS9Xqqm.9.1636034225636.Hmail.wanjiabing@vivo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from [172.22.218.43] (218.213.202.190) by SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 01:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a747a0d2-87a0-451c-3ad6-08d99ffef869
X-MS-TrafficTypeDiagnostic: SG2PR06MB3045:
X-Microsoft-Antispam-PRVS: <SG2PR06MB30455C4E15AA84A8E960E6EAAB8E9@SG2PR06MB3045.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:289;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PRUApkU7snaJ5SaTr7xuzCDX2xhAtyPUbW/csdmsr987Mek9z8wEoOJgGxPRLYs3X4one+krgoEVfDdDzVf/A3qikCVPbq6FGgisnKDC+kdlEJzHxYjqz4WuX20tdO87/6etInE4HrxBMVvFiocVlLnIs9VFOtcaPuOSJdFBHUJbMyVPoqNoFp5qDKmLDK84b8hkkUOZD/gA6GEjSmx/HJ6yZpULiBNZY3SXGKjR+11/d8JDFNyrmWD1rR1fqwT1dK/FRMar9KyIg45DaFYQOv2WuTQUn8SKcOS4a/rEWToIGucS19Tq8YtFWmQ8JFhGPjrQYW1/6wEpz8LeLIgnJRH/GayrUZn86JqEj7ThvzadjvNRwzTnVTnnbCJmp8P/KNFpNo10HLNxqvlmaraYnXTaJpGFgBl+0cPX1WDpAO4VHF9RnjHl+DgksQbi9+nlzpreG/Kj+n/93T/Xe+fJJ02a41fPk6T0WnuFO0oTZYb38q91Q5xm7bKHj2UtZgnRCkOl0T0n+9aTXHsnFiM33rtO5ONDqz+zxBPpto9txNzj/Vz45j3S6iYYfibDXENDMER6dnBP9YMctxDDE8Gm7tsyQjy7qETNilrQXCxsPFOto23HfRPll6VzojtqjezI6gL2PwsGdn5NCiZNAum89pPUymzrBRzNfeq2XCPkT5ADdfdc8iHXdRxcHtm521G1fOJR9DmD9wBisx9gbJMzGEhb3DwMs2pON6rgF74OX4YamqQLlNGHavuYIxlmneYLve+3aTrsBSU0gABVubhJS8OZHSrDSAz14bNZ4GDpHXP4IoVgapZ5ofg+hGbMHLCR1dYm+4k1rNko0ekM7WvSwt971v5iccCfaK9cY0NmVZnzNFVtjERbxpuqPp0yg2s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(966005)(7416002)(66946007)(66556008)(66476007)(26005)(316002)(508600001)(16576012)(186003)(6486002)(6666004)(38100700002)(38350700002)(53546011)(110136005)(36916002)(8936002)(36756003)(2906002)(2616005)(31696002)(52116002)(54906003)(31686004)(49246003)(83380400001)(956004)(86362001)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?8ra03zTXVMPVA6rUYM7HpEXDMX0B+Hiyce5hX6Gh2nn1MC4zba5fe1LF?=
 =?Windows-1252?Q?glG5OspcjCGDh7itQbxSZYIWB33etJZqrSChiwpzS3zTs6NPJOoamph9?=
 =?Windows-1252?Q?JaQvD8GJFvSt1Crs2Af9FXWycKtUd2jN8m/XqsZLMG3gnwCguO7i3UcS?=
 =?Windows-1252?Q?V93czfkJstzkYMIG8anmPPhuTGMstOlpYjPLDYVNt1Up3t7gqwyo863M?=
 =?Windows-1252?Q?+bq7MEMTU8mSrZXGNmBxBI5BnbA/ptkcriUkvrwgpW2C/9J211vWyGp+?=
 =?Windows-1252?Q?qrI9bqcVmbHVGpQ5zrtN6TFT+EWmec9TGMyDU1hR68l2OoWkbNRPj8Qw?=
 =?Windows-1252?Q?We5vhByk1nVp6o99eC/KQ+NUgVLSCoz6iKviBxAWNksMWWRo9fjT/qji?=
 =?Windows-1252?Q?SzzvgcxTenS4XLY6yMBNyEq9D4T3T0jekbJg7IM+YTKTs20rJDYN/CJZ?=
 =?Windows-1252?Q?ouEBhht2FuTRHdGrBuurDTpLOn0yW37tdIalSagV22DZWgqZaVYq8ooC?=
 =?Windows-1252?Q?77msaP7QYP0p4rXQD6PidwS9KT8//OPn96hPvg2gHVQTbOBFhcYa67c0?=
 =?Windows-1252?Q?slVXgYoo0YAywHIjhen2d22lgrF4YSVwKKk69Cv9GSqmM8BoJ5lELhxa?=
 =?Windows-1252?Q?/E7I62+urmc2ueP+3RTTUT5aaW0TGzV9ubIykLLbFTiX79I7HvNygXPc?=
 =?Windows-1252?Q?eyuE6pbVkE8yseZhuA/lZ1SMS7SkJiZK7e1HC1v/txLT4iCUyTorfxmU?=
 =?Windows-1252?Q?FqiA3BT+SPlTEl/ZFCK+VrUUHkZkCdvTSXvu6vRpHa1SD57ha7nSJ6B/?=
 =?Windows-1252?Q?uOBFhLgVsWSMrFyU/k6+fPcvnoBPJGfzrQBOn9z+Aq5Ggse0PbKgVLMl?=
 =?Windows-1252?Q?/JJCN1YsOC0D4aRW4aUShR7JQxHMQl5c6nO3dtnjzWBeJDlNINip4Wde?=
 =?Windows-1252?Q?JejrS3Q0ElPE7ZGn5XYD+L1S5vr00H1HJ5ps3yz1oQzxjUTAEYcnSzNA?=
 =?Windows-1252?Q?2rwCrFAelURauzCajCqaZk7A3dQRuhMEAbH+m/cY8oWz1QUCqAfeQlk9?=
 =?Windows-1252?Q?Ilqa7oNIALZo8+Sjj/xBys2AcF9iJEWD9fvO9BRRyzbFe8R2ELG57lzE?=
 =?Windows-1252?Q?LI1mIFVRcKOheJQRe2h+x1C8LTI1c3X15L+LVRM76LcSMXiPE/cScwpJ?=
 =?Windows-1252?Q?jd25FwnJNe+DbS0UaV5S94SBQtAbXrnTwjIiy7fvVAcwHVKsABX6bQp3?=
 =?Windows-1252?Q?J3yVLK7jH7jeRYZ2fXdNbjDTqf/IKNxhzcQQ6Le1XYT2C2Hn/VPiPx2T?=
 =?Windows-1252?Q?VKJheUAaZqUH7R6FzYpsEm8+ELcRiB7dpWLF3upLXaqWJXe6YSgaJjYo?=
 =?Windows-1252?Q?1+YzJx15xGigmAgfVTw3s4pfePZqK5oJTa3b2mr4eimm2RClTvl6uZmv?=
 =?Windows-1252?Q?+9oEjooegPvXruU0P3tnzzGx3gL3XPAsRWwtj+hGK7n51Gy7Cwj3j/zk?=
 =?Windows-1252?Q?b2avjySz7LyIcPhAwcozvP6CBJkWpCENqtHyChBAfbEJnS224C66rGEP?=
 =?Windows-1252?Q?OJ+gMCeGrOrOHT/BrIGS1JhidcDLHfQB5/d+asE3fsP4pDxYuiXys1Pc?=
 =?Windows-1252?Q?m4qZW/49sPX0+ui5a3pGL3+f+l1v6sy7pBEtTwkpMUr57rH+7gm5zFBe?=
 =?Windows-1252?Q?Khhu3pqMyaQdHS3rarAeCHx62F/Xfx5tsZRuKLjhSrJK1D6DGRd6GWJb?=
 =?Windows-1252?Q?c7Xo78eqNyM2pWq7+Wk=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a747a0d2-87a0-451c-3ad6-08d99ffef869
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 01:52:49.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uG7tjBDz6X7esYN/ExCgsJOpS5jzwct7adjNSt5id5u/ar/ctV36Cm4HScjS1nkkbszbBGFv5KpIQPMkigo9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3045
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/11/4 21:56, Rob Herring wrote:
> On Wed, Nov 3, 2021 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+to Mauro, author of code being changed,
>> Rob for "of_pci_get_devfn()" naming question]
>>
>> On Wed, Nov 03, 2021 at 02:25:18AM -0400, Wan Jiabing wrote:
>>> Fix following coccicheck warning:
>>> ./drivers/pci/controller/dwc/pcie-kirin.c:414:2-34: WARNING: Function
>>> for_each_available_child_of_node should have of_node_put() before return.
>>>
>>> Early exits from for_each_available_child_of_node should decrement the
>>> node reference counter. Replace return by goto here.
>>>
>>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-kirin.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
>>> index 06017e826832..23a2c076ce53 100644
>>> --- a/drivers/pci/controller/dwc/pcie-kirin.c
>>> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
>>> @@ -422,7 +422,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>>>                        pcie->num_slots++;
>>>                        if (pcie->num_slots > MAX_PCI_SLOTS) {
>>>                                dev_err(dev, "Too many PCI slots!\n");
>>> -                             return -EINVAL;
>>> +                             ret = -EINVAL;
>>> +                             goto put_node;
>>>                        }
>>>
>>>                        ret = of_pci_get_devfn(child);
>> This is a change to the code added here:
>>    https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=31bd24f0cfe0
>>
>> This fix looks right to me; all the other early exits from the inner
>> loop drop the "child" reference.
>>
>> But this is a nested loop and the *outer* loop also increments
>> refcounts, and I don't see that outer loop reference on "parent" being
>> dropped at all:
>>
>>      for_each_available_child_of_node(node, parent) {
>>        for_each_available_child_of_node(parent, child) {
>>          ...
>>          if (error)
>>            goto put_node;
>>        }
>>      }
>>
>>    put_node:
>>      of_node_put(child);
> Indeed. There should be a put on the parent.
OK, I'll fix in v2. Thanks.

Jiabing Wan

