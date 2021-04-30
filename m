Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D27370359
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 00:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhD3WMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 18:12:19 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:17088
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229997AbhD3WMS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 18:12:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzU/T5MlS23AU0PayEQgRUyO4fz+KAYB6A5DQTKRmrckLgkX8KmbFyv9YsMryqKPyiWQ4EE4PkisF9IofuDWk2YMcczfeJKbxVNervLBPxjrWHH69pZ98Tmb7F0Jx4gwRKHjTQddrB+K5M9n+6emXtSOtvIeTJpQ1b1/o+g7AjmD7beSxKG27po4wzWPw4tLQTthfQLSmEBEN2ZNIo/xdahLglIV4J6XwT8MWGgd+g37tqoPMgqJZfEfoN20/+9vCdA3B7g3/saWfO21PL+5MCLtXGFleyUlvyE6T8Oj4FCPlNzSijVWS6dvFfuoR7p5TntIdzrLf8eTMNs1hq0y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYyiSHJHEwKD+NhBdjTnVysOzSoBkE+3Jg9WVaFEGAc=;
 b=Vhid1ArqeZ2O8EVqAnHw1bOSuYNfpRyOocVRdwHot45pnzIgPTaSGc2o59hbZwNL/lSa8UxryyDCVKI37snCnmaS+gKx2O9x7O4sQBw5iDcQadbZDZufvsI+vx9ouvczS5AH9Z5Niz6F5MT6YnoUxhGvC1Djb6ec+uD/viXpShxYau1eyjsGtmTbElHD/IcLKR6x4CO+7VlZGGRBoo0ZLJdU0qnVFxmRc/EmFP/sKzz9Qyya2HjMfyrO6iShEFBJciBvlgc/1fcj4mowVjskX79AUoeDD+RYpUdwWJ1fDMTWKnFh6j9O89aj7o0vz8ize0YTLf0tg5jPjUHOdfMKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYyiSHJHEwKD+NhBdjTnVysOzSoBkE+3Jg9WVaFEGAc=;
 b=SgLjvIH/nff4y1LXdohXVvTe28hMlGA1RSOijX2qlrOfN7rv/o1Xsptl5fl2jHGtkoyLV6r3KZw6Wrxl61Ecff5Lp+RnPxuqtzQJg0yn2+TLd79CNF/X5/vK8eCyVxiUgXqIDSWaaNWGrD3hKfzV9EmdQgrVKCyB7bKq/mDaSDNofbXLfEanZMKeBdXXW6lLMTRBNb5KqhH3cLPQ/OC9GdaCN0CDbs+AQ9PigtVOjnpQX9nQfVaeOUY2ngv3XPO21DLIYAGQWLIY0mbJexv2Cyp19rvpIyMFXDMcXP7BkN1la/VC/WEMJYZHowq5Kfw5GO0gdxvUfMjoQcpZIkuDNQ==
Received: from BN9PR03CA0667.namprd03.prod.outlook.com (2603:10b6:408:10e::12)
 by DM6PR12MB2651.namprd12.prod.outlook.com (2603:10b6:5:42::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Fri, 30 Apr
 2021 22:11:28 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::2c) by BN9PR03CA0667.outlook.office365.com
 (2603:10b6:408:10e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend
 Transport; Fri, 30 Apr 2021 22:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 22:11:28 +0000
Received: from [10.20.22.163] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 30 Apr
 2021 22:11:26 +0000
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
References: <20210430170151.GA660969@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <52c89d4e-6b26-6c56-d71e-508a715394ab@nvidia.com>
Date:   Fri, 30 Apr 2021 17:11:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210430170151.GA660969@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1570c040-2cf1-4aef-c42b-08d90c24e6e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2651:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2651BEBD7CD6265D82099AFFC75E9@DM6PR12MB2651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6drqdsdZyot6oQ660qV7QZICJENXkjimW4iag21Zp3h45SqXteUubVsMfAztSqwgnuJkNsU4/qcLLhlcM7H+0Z8ew5BHWuJkGY+8EL3C+33/aAAZXJRqZ81zlvMf99InIVCiEmLFg35qU1lsmtdoXOaA3dZHztKuJmLLoH/VFsexmThwfw9jSbl00eSN+4for6LyGwhqBDq599X/QJgjwcCOmM+eBpErscLfhf3EZrHiXdls/fgdXRM/Bv6Z4p1Xaf4MveyQ82UfZ5PteiV6z0/cdT07bgerh39kk398WmuzVxZzTNl0egYe9bdJbrvm8PfUfvyv5sT5052LJApUVsZ2v557cGRhdpeD025T//1EQcBL3FCuSeHHHSuyiSGzNL7u4qay29E9jegDORVDRn5PmyvRMDXLJ5mlONNR+c1r/lo2jxmaph+GM/auCsKfD5fw5HQpNVRhPdZoiG4DDoHBT1NcqyDr2CEd1iwOkBUoFkrH0uCFSpvM655QGcCxV3mkruymFaH1xDJ6jwzeEXtH1TbDtSx2kOxELneIf0WTI4AEKqa26VhAr+74rBLvFynTdsRZrhRo5WZCdJ1bgSsKuOmUfZVQWbQEuhgUmy0+JOSWjM7QnXvHT9EKq3RPluXa+IEeOebhiOW4Z3zrcq78PiGZslA0eusje56rH55iJTxgoXfSb67KvQx/3uc
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(6916009)(8936002)(356005)(83380400001)(31696002)(478600001)(82740400003)(82310400003)(316002)(36756003)(336012)(7636003)(2906002)(16526019)(86362001)(26005)(426003)(70206006)(54906003)(16576012)(36906005)(53546011)(186003)(2616005)(36860700001)(5660300002)(6666004)(8676002)(70586007)(4326008)(47076005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 22:11:28.0145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1570c040-2cf1-4aef-c42b-08d90c24e6e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Bjorn for reviewing patch.

On 4/30/21 12:01 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Apr 28, 2021 at 07:49:07PM -0500, Shanker Donthineni wrote:
>> On select platforms, some Nvidia GPU devices do not work with SBR.
>> Triggering SBR would leave the device inoperable for the current
>> system boot. It requires a system hard-reboot to get the GPU device
>> back to normal operating condition post-SBR. For the affected
>> devices, enable NO_BUS_RESET quirk to fix the issue.
> Since 1/2 adds _RST support, should I infer that _RST works on these
> Nvidia GPUs even though SBR does not?  If so, how does _RST do the
> reset?
Yes, _RST method works but not SBR. The _RST method in DSDT-AML uses
platform-specific initialization steps outside of the GPU BARs for resetting
the GPU device.
> Do you have a root cause for why SBR doesn't work?  
It is a hardware implementation specific issue. GPU end-point device
is inoperative after receiving SBR from the RP/SwitchPort. This quirk is
to prevent SBR.

> I'm not super
> confident that we perform resets correctly in general, and if the
> problem is an issue in Linux, it'd be nice to fix that.
We have not seen any issue with Linux SBR implementation.
>
>> This issue will be fixed in the next generation of hardware.
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>> Changes since v1:
>>  - Split patch into 2, code for handling _RST and SBR specific quirk
>>  - The RST based reset is called as a first-class mechanism in the reset code path
>>
>>  drivers/pci/quirks.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 8f47d139c381..e1216a8165df 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3910,6 +3910,18 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>>       return 0;
>>  }
>>
>> +/*
>> + * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
>> + * prevented for those affected devices.
>> + */
>> +static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
>> +{
>> +     if ((dev->device & 0xffc0) == 0x2340)
>> +             dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>> +                      quirk_nvidia_no_bus_reset);
> Can you move this next to the existing quirk_no_bus_reset(), and maybe
> even just call quirk_no_bus_reset(), e.g.,
>
>   if ((dev->device & 0xffc0) == 0x2340)
>     quirk_no_bus_reset(dev);
>
> It doesn't look connected to this spot.
>
Thanks, I will move next to the existing NO_BUS_RESET quirks.
>>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>                reset_intel_82599_sfp_virtfn },
>> --
>> 2.17.1
>>

