Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94183D97EF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhG1V6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 17:58:23 -0400
Received: from mail-bn8nam08on2083.outbound.protection.outlook.com ([40.107.100.83]:23376
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231903AbhG1V6X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 17:58:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASNoMirl7JjTge/6HDKgsfANL5/uX4XE85qDj9TNVdHoYr9u8g3RmIkZdWeZnkE8di3F9m5OM4iabkdKGnEHoT9OB861FvhRqOWFszjkJkgARfe9RbQwO0RW4gf8mQLHB8AuuImB8CF9RUBLgOu9XcbIlxOv/C6dN9XWKnKuioqwBEPD8/MVk8fgym624tSN4hLWLENlnH7XL14YJooEOXoWQy7NAf6O8WhsI/EU6klDsVwVC1dyttdUkMGZcps13RiY74bbWsm+Q56c02xiPvKjuctpEUH1vJB8vfiVQfx7wL99tjzdS4b5tfHwYNdnDqJXlcn8V2RI268Iy8v21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFhpmd5SEoOnaNEPNID9FDr2L98ukqo8rkLF/iXvuJM=;
 b=NHTkcFnpS7EQxziW654wujoosNlnNDe0RFkCQSyIFYT6vxzsWQIQfVKxuU4OxozjMm7M6pvT2y/6dGrO3Un51bpXGR48STtMDCxwa51YzmbF1CthAo1TDHuYnoMSpdiVbQfMmcqpm0XZXBy4c9v4PhLdm6vPB19qdFHL+zmW3F4ZnZ4joB3yeTZmjtsJA9KzJT8rqTM4us+nbIu3qmdDy/xEokvVU5IP2HyjrjHVdKKPhuwDXqU4dl0P1oaNsTq6rp7R94osWERj4ZZKlsalCxb52ZpAxUyliQ0s5zXWeg+pSlK3PEgqU6qcLUGdJKsqoOabtBNakQ6dWVI2T0mC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFhpmd5SEoOnaNEPNID9FDr2L98ukqo8rkLF/iXvuJM=;
 b=kgpKOnPnKqPAzH5edWvFrUqnG/ZYxqviGpCG1EcyxdXf8HZADL4YMqdaRM8SMNdtUOu28vbJD6Zv6X1XjzBgIhe3/y8gtEFA+mQ2Wc/936+YGkqZixlZ9EqAaHdRJnZtrJP9Qvf4+0tjmcTiPfWEHsltYyH5zVDI0auxNpbbZ8y0NbRDtUqzML6ozQNB4qNwIAKF2Oc90r560CYA6BgDpVuRnKAL9lFztn7hUl3WZRQjWJzXEfdTnj34b2RNGgDhl0HllMtgyBnP12xI6RxgcAR8IjYptqbkhFOY4Ct/N5Jpb3F/YU4Ue2wavCX782eSnIGzV4nEITPDzBa7H3V+qw==
Received: from DM6PR12CA0016.namprd12.prod.outlook.com (2603:10b6:5:1c0::29)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Wed, 28 Jul
 2021 21:58:18 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::1a) by DM6PR12CA0016.outlook.office365.com
 (2603:10b6:5:1c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend
 Transport; Wed, 28 Jul 2021 21:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 21:58:18 +0000
Received: from [10.20.23.47] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 21:58:16 +0000
Subject: Re: [PATCH v10 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210728202303.GA847802@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <64a0049e-00dc-8b10-6c9a-0b270c0a181d@nvidia.com>
Date:   Wed, 28 Jul 2021 16:58:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728202303.GA847802@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5bc7eb4-2ade-4d51-ccca-08d95212ced5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:
X-Microsoft-Antispam-PRVS: <BYAPR12MB25970D4BA93130C2A1F900ECC7EA9@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVZTfCoTSvmj7CusCBJE5XulB/rYMM9aPnFWJ9Se9R2lUwCqO7GFjFvBDFcjl9lIpnu/cov7IZF6f8lcNpghzeD294fCFls+rNgVCishVfOkpqPY6EVLAjc8hhqhjCbQLuCFcVaIDJRB4HUdcGj8AI/TWKXrKziojLZR0Vqi++9BObhE2Tz4hKmwL4+UuKYBPpfpVQMm1dMmXLus6DmRNUVpyaOuXaikbYepH4abLmUWbz6ghuAln+bIZ7YY+NVFTMP+QRgUuylljQApO1j4nG62VrsbsGBkN6GRWa707mDFe91D1mLOBg8F6YxzYxHWxE6GLOn9nLCImU765JF1tGkIe0gLt2uridqFohKv/mMnr/7kIWy51T4874nhhOXajfl7BKsozmQ0NC540e/kAOch1V0TyOogW6fEdLkO04AqnbzzsicVDVsSwM8fjUh3njtzzavsFBLcnukQLwmr0UqB7TlTm5f8sg9LOY2M05d9QPCOnvPwnPfuXzz8/aavqofMzoHxGe8pTUpiDtqZka52ARYwi1RTP+ubxtNFxuJR6mZz5IGOyLUYvYbhBUBAyaWkpMA0izDGKK1WiVzWG4+f9Bjp5mFArh5mXhAiLJhGEebXunq1vpChXFwH6Bm19eT6VE8H2Fm9ape5T0qxeUpc3qJi+y+DnvMlAwfoJMSfUKjPGz58cTNlNU1T1PQ+2hZgP5ZgJtkX+bSM5yQcQ2Kya6FzGtCGhGO83pvJ25XAvguGdQjCcf8QQmnDnOZCC1r+3WxijYvX3Y+u/BOwnkpt6cfPHkjKEGh72mmyQ+s=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(31686004)(83380400001)(8676002)(82310400003)(6916009)(36756003)(54906003)(2906002)(316002)(47076005)(16576012)(5660300002)(36906005)(336012)(356005)(70586007)(86362001)(186003)(70206006)(426003)(7636003)(31696002)(53546011)(4326008)(82740400003)(2616005)(478600001)(8936002)(16526019)(36860700001)(7416002)(26005)(21314003)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 21:58:18.1563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bc7eb4-2ade-4d51-ccca-08d95212ced5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/28/21 3:23 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jul 28, 2021 at 01:54:16PM -0500, Shanker R Donthineni wrote:
>> On 7/27/21 5:12 PM, Bjorn Helgaas wrote:
>>> On Fri, Jul 09, 2021 at 06:08:06PM +0530, Amey Narkhede wrote:
>>>> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
>>>> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
>>>>
>>>> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
>>>> is supported by the device which does not match the calling convention
>>>> followed by reset methods which use second function argument to decide
>>>> whether to probe or not. Add new function pcie_reset_flr() that follows
>>>> the calling convention of reset methods.
>>>>
>>>> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>>>> ---
>>>>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>>>>  drivers/pci/pci.c                          | 59 +++++++++++-----------
>>>>  drivers/pci/pcie/aer.c                     | 12 ++---
>>>>  drivers/pci/probe.c                        |  6 ++-
>>>>  drivers/pci/quirks.c                       |  9 ++--
>>>>  include/linux/pci.h                        |  3 +-
>>>>  6 files changed, 45 insertions(+), 48 deletions(-)
>>>>
>>>> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
>>>> index facc8e6bc..15d6c8452 100644
>>>> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
>>>> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
>>>> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>>>>               return -ENOMEM;
>>>>       }
>>>>
>>>> -     /* check flr support */
>>>> -     if (pcie_has_flr(pdev))
>>>> -             pcie_flr(pdev);
>>>> +     pcie_reset_flr(pdev, 0);
>>> I'm not really a fan of exposing the "probe" argument outside
>>> drivers/pci/.  I think this would be the only occurrence.  Is there a
>>> way to avoid that?
>>>
>>> Can we just make pcie_flr() do the equivalent of pcie_has_flr()
>>> internally?
>>>
>> I like your suggestion don't change the existing definition of
>> pcie_has_flr()/pcie_flr() and define a new function pcie_reset_flr()
>> to fit into the reset framework. This way no need to modify
>> logic/drivers outside of driver/pci/xxx.
>>
>> int pcie_reset_flr(struct pci_dev *dev, int probe)
>> {
>>         if (!pcie_has_flr(dev))
>>                 return -ENOTTY;
>>
>>         if (probe)
>>                 return 0;
>>
>>         return pcie_flr(dev);
>> }
> Can't remember the whole context of this in the series, but I assume
> this would be static?

It should be static since it's referenced in driver/pci/qrirk.c and aer.c.

>> And add a new patch to begging of the series for caching 'devcap' in
>> pci_dev structure.
>>
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -333,6 +333,7 @@ struct pci_dev {
>>         struct rcec_ea  *rcec_ea;       /* RCEC cached endpoint association */
>>         struct pci_dev  *rcec;          /* Associated RCEC device */
>>  #endif
>> +       u32             devcap;         /* Cached PCIe device capabilities */
>>         u8              pcie_cap;       /* PCIe capability offset */
>>         u8              msi_cap;        /* MSI capability offset */
>>         u8              msix_cap;       /* MSI-X capability offset */
>>
>>
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/vmalloc.h>
>>  #include <asm/dma.h>
>>  #include <linux/aer.h>
>> +#include <linux/bitfield.h>
>>  #include "pci.h"
>>
>>  DEFINE_MUTEX(pci_slot_mutex);
>> @@ -4630,13 +4631,10 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>>   */
>>  bool pcie_has_flr(struct pci_dev *dev)
>>  {
>> -       u32 cap;
>> -
>>         if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>>                 return false;
>>
>> -       pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
>> -       return cap & PCI_EXP_DEVCAP_FLR;
>> +       return !!FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap);
> Nice, thanks for reminding me of FIELD_GET().  I like how that works
> without having to #define *_SHIFT values.  I personally don't care for
> "!!" and would probably write something like:
>
>   return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;

Both are same since FLR is a single bit value.

>>  }
>>
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/hypervisor.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/bitfield.h>
>>  #include "pci.h"
>>
>>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
>> @@ -1498,8 +1499,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>>         pdev->pcie_cap = pos;
>>         pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>>         pdev->pcie_flags_reg = reg16;
>> -       pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
>> -       pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
>> +       pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
>> +       pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
>>

