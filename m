Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5573D9822
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 00:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhG1WE0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 18:04:26 -0400
Received: from mail-sn1anam02on2048.outbound.protection.outlook.com ([40.107.96.48]:53568
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231668AbhG1WE0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 18:04:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCAAxRxLA8VSX/5IUAiM+TAzvOwMZ9ofc9O24DUO1K/PDxmsSQkXPphu6Fv9Uya5sDiTmizS+1pmA2t8SH8WyuBbndfdsh2j5wUetXDtIG7F7w9PUGj6cNi7up12z5xPJxSvr7zrdWNh07Ls9aRAHv/g1NLhYtz8x+VUjqHSfkN6TyO4b3nj9IZMoQ3qstZLJzy73Tq96VAvhmMFeQZZDA74IKLpddJ9DK6MnQKT1esnFZaLm1t9veqgAJAu16MOPDW7AnB4YQRpONPwxtzABgdcTnNIJFruKG9HzjQJKwSfASU7nkXZ7ZkoOJXei32X/nHrN/aT5ldM3BEILdpuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar/q84999BW1XSCUWcklhlAN+p87l32NpPxCuLb2vo0=;
 b=IUg16ncasnExfwVO4X+W9i/rGFYD6yDDGLkCTq+T839UgIDKlGaBYZ94HpGw+CmgHvUfNBQDSCUN8E2vgutezfM+nAkmNZF2yeHxBdGGoZ3qYaD7wpP0yDBnTQ0k2GyFzdcvr417TS5SG+h+0HjrGFgfXg/Zmnu7KnkOSEZ641UdZwNT7nF4CA9WRV08vZikOZeTdxE78VLkIanXJHNsoqjvUMdkFM6iKzyDtWsyOU1M7fUeN9cqyhZK25vUBDQWXw+NNbRzHDF9LOotuWKwoEx55isQpn48M4Ppo+dTOxjsm5m3ggYP5d998xY0fzhG/8/8JMpFWj3uS0IKdns7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar/q84999BW1XSCUWcklhlAN+p87l32NpPxCuLb2vo0=;
 b=jVhUB6WBkdRMwvz8/quFC2Ib7lK+AV9yPOgyCn5nW1+3hVEomYWEvReN8ToZJWO0+Aw/Nj+9fW/TNgIb1iJlKpfJrvOl1LRF5pACS585buC6gVvcelIY+TmEpE8A7JZ1TeN28DSjMuOwhxjO4aK7/MpVoJqfrPY3bp1kuU47GWzjW1gaDiM8NRPaEuyvFqNjX5lWNLV+PbN8jIqBVIGbBOqpPzZcuzxE1p6GsbVCz7p1U1otrA18R13BFGLB9ExUSy5RwWmI3d7CBE9QNyKQFTHelz9rw7molA4hq3R2SH++zPdOH6xTYJgR1SsiRs6ad0Vct7KHlWrTdpvmsObN5g==
Received: from BN9PR03CA0943.namprd03.prod.outlook.com (2603:10b6:408:108::18)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 22:04:22 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::ce) by BN9PR03CA0943.outlook.office365.com
 (2603:10b6:408:108::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 22:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 22:04:22 +0000
Received: from [10.20.23.47] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 22:04:19 +0000
Subject: Re: [PATCH v10 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
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
 <64a0049e-00dc-8b10-6c9a-0b270c0a181d@nvidia.com>
Message-ID: <2d77799f-d551-d7d9-25a5-5a1df4483679@nvidia.com>
Date:   Wed, 28 Jul 2021 17:04:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <64a0049e-00dc-8b10-6c9a-0b270c0a181d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b7e7a0-3a82-4ed4-2b9f-08d95213a7ec
X-MS-TrafficTypeDiagnostic: BN7PR12MB2788:
X-Microsoft-Antispam-PRVS: <BN7PR12MB27882B49EA5A4AF74596C9AAC7EA9@BN7PR12MB2788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXpJ3sSuDp+dR7mzUX92423Y6F+cL5DG+Aw+8PvOVkM/qNOCTHpLTQ14L6f7TaYnCKqri4SPMl+QabTh4eoDUFRafgdfavoigrLc7xc0SVIcACZss+AwI7YW6dImu/YvlAU7IKZvMKUqWSyZTa4aLmr+NLpZsAj3fUhpgUxCi2AVP+MLLyahCvuDIZSIETf5+YPwPfs5505F9/cMWd8JbJZWvTRrnOe5/VStW/8Kog50mXjYJ+UuW+23mbhIHhnN8/2qzou6Z9pyg+6Ix4Ct0c9hOk8ZSkFM7muv30fo38wEBBuDy8x7FDvPywR0uona/tHu7YaivEuu4VCAO5nMq9JM2YNSjh0peY84MKll5KvPYzlsJoGn5s1anfRVdSMVIGvigH/Ii/lsqq6JJ/2QGatS8SIrGCuMa4ZN8A5qO6QffmwJGxjKIXh8n4mKcdumySM5rf222if2et2D80RGIVsi4V/MJyt8zpCC24FHTIZAZ8kIBosHtyBnQ+VphleyNbgxkICtZm+WphxBq9KRz7fXgnq5mbyorNqF86ikBumz2wTwG065tCO3HL+Cs9cJcTmlvh3qKQEoy71FkZgML2Uohki+3Vffz3HCdJNU0ipNYdQsjI0OReF2qhcouwaouCtuKbDP0pTko03z2b6+Hd9aEyLPo8D2wHlcVQflQDgIYbMRmB2AHVaTtt73XduvFzXITZpM4zBxpsHSHo1tpbwEyWkVIX/bOmGge2RW7quj+FDR7Cz9WIWNiEXbezv4yW43UsXMFVT4LhQGZIZ2pw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(8936002)(70206006)(4326008)(70586007)(83380400001)(5660300002)(54906003)(86362001)(36906005)(16576012)(31696002)(36860700001)(31686004)(2616005)(316002)(2906002)(16526019)(53546011)(186003)(26005)(7636003)(336012)(82310400003)(508600001)(356005)(426003)(6916009)(47076005)(7416002)(36756003)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 22:04:22.0587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b7e7a0-3a82-4ed4-2b9f-08d95213a7ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/28/21 4:58 PM, Shanker R Donthineni wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Bjorn,
>
> On 7/28/21 3:23 PM, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Jul 28, 2021 at 01:54:16PM -0500, Shanker R Donthineni wrote:
>>> On 7/27/21 5:12 PM, Bjorn Helgaas wrote:
>>>> On Fri, Jul 09, 2021 at 06:08:06PM +0530, Amey Narkhede wrote:
>>>>> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
>>>>> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
>>>>>
>>>>> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
>>>>> is supported by the device which does not match the calling convention
>>>>> followed by reset methods which use second function argument to decide
>>>>> whether to probe or not. Add new function pcie_reset_flr() that follows
>>>>> the calling convention of reset methods.
>>>>>
>>>>> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>>>>> ---
>>>>>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>>>>>  drivers/pci/pci.c                          | 59 +++++++++++-----------
>>>>>  drivers/pci/pcie/aer.c                     | 12 ++---
>>>>>  drivers/pci/probe.c                        |  6 ++-
>>>>>  drivers/pci/quirks.c                       |  9 ++--
>>>>>  include/linux/pci.h                        |  3 +-
>>>>>  6 files changed, 45 insertions(+), 48 deletions(-)
>>>>>
>>>>> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
>>>>> index facc8e6bc..15d6c8452 100644
>>>>> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
>>>>> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
>>>>> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>>>>>               return -ENOMEM;
>>>>>       }
>>>>>
>>>>> -     /* check flr support */
>>>>> -     if (pcie_has_flr(pdev))
>>>>> -             pcie_flr(pdev);
>>>>> +     pcie_reset_flr(pdev, 0);
>>>> I'm not really a fan of exposing the "probe" argument outside
>>>> drivers/pci/.  I think this would be the only occurrence.  Is there a
>>>> way to avoid that?
>>>>
>>>> Can we just make pcie_flr() do the equivalent of pcie_has_flr()
>>>> internally?
>>>>
>>> I like your suggestion don't change the existing definition of
>>> pcie_has_flr()/pcie_flr() and define a new function pcie_reset_flr()
>>> to fit into the reset framework. This way no need to modify
>>> logic/drivers outside of driver/pci/xxx.
>>>
>>> int pcie_reset_flr(struct pci_dev *dev, int probe)
>>> {
>>>         if (!pcie_has_flr(dev))
>>>                 return -ENOTTY;
>>>
>>>         if (probe)
>>>                 return 0;
>>>
>>>         return pcie_flr(dev);
>>> }
>> Can't remember the whole context of this in the series, but I assume
>> this would be static?
> It should be static since it's referenced in driver/pci/qrirk.c and aer.c.
>
Sorry it should not be static since it's referenced in driver/pci/quirk.c and aer.c

