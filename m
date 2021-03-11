Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1332533759D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 15:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhCKO0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 09:26:02 -0500
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:18177
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234036AbhCKOZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 09:25:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUrwiNMFOWrUWc+Vtumv0JtcFc/rJQISiq+AP0fW1rmQPJxHlX5/lZYkTq/WoUS68lRpGxgFAm2RBf4i9D/24wVpxhYS5MrJcs4Zvf51fOJzYURJmdzptQXYzuZqL1pWDAmPPaawF64m1s/0Ji0Lv1fJLnIyukf+n9X/Ih/9jM8/e9u96Jcz6x4as38GiQez6qGSuD146bfKqkBe0mMy2ruDyouqq5uxWW0+rhWnYs63ybHKcCMMI9FNNNexH8d8jqVOrmsgErDgyh56UzQZ9/MyegJ2lD1N9TQb3gPkcC6+dWgqcIOfxiedAMw1+F9Vtcm0Qvi3jyIJhqBcYDv4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ09EhgiOhwPRLtyMXWFJVTGVeqXgP0FG+XKC2eJ7jg=;
 b=bdlZSHkUu3JVL1fYVEW/5AuFqPtHnhya02wZj0bDcj5kepqf+4DXRCjFmWqGpZgKeZN5i2cEMPrnnfFPDqgYqGqRuveASPUoakcwFMGmlj9YEq9XY+PmdjOCkuX/Y7Y+ejwwefIea7i4/vw76w6CFRunbMQGDMIg6Hh1tCFwp3hm7k/ewrnjahj5CImbt5K6X18wYm9mXtC7FmR9K81TRiE3lrNqHSnURNJLuqGwVggUA7msITYDQ/2c97pf+lh57x91IBC4ziFRTpiFXAfIkKp+HZCkFp8jHZWYtg3OrLgITrNwu6tFq+NxytX1vjoyFB9jS/CAltc8UhBWFbsjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ09EhgiOhwPRLtyMXWFJVTGVeqXgP0FG+XKC2eJ7jg=;
 b=j1ppvFy+9eyY84XydpzuXkGt11FOhwJYa0K0r1EYL9gHcQNBPRDRpg40GP1xdV6+l5onWDyrIj1aQ5BSsOYfnofGuECCmOkyIXyyRGL05LRivkfh2VF3x5fQnurXJbM6ZRwH1A0HJnW44xABGeFHO1eJRD3vRAUAnVsU0LmOwfOW2Gz2QrUMo/eYystNKw3na8jUmvD2AHwkuYQ4fGE5S6wkHbq2uAvgx4UWlGfHAdJg2KqqsDXIkMoHm1pGujPYAbJ4yLWSmKMYPpcm2/wlvotgs6PprXA6hWyD8jjIlgMuiqlNf5K6fLa9UNYCgzI1GLy6+Qv5OVPZtzoumEqQhg==
Received: from BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31)
 by BN8PR12MB3508.namprd12.prod.outlook.com (2603:10b6:408:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 11 Mar
 2021 14:23:38 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::59) by BN8PR07CA0018.outlook.office365.com
 (2603:10b6:408:ac::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 14:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Thu, 11 Mar 2021 14:23:37 +0000
Received: from [10.25.77.87] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Mar
 2021 14:23:31 +0000
Subject: Re: RFC: sysfs node for Secondary PCI bus reset (PCIe Hot Reset)
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amey Narkhede <ameynarkhede02@gmail.com>
References: <20210301171221.3d42a55i7h5ubqsb@pali>
 <20210301202817.GA201451@bjorn-Precision-5520>
 <20210302125829.216784cd@omen.home.shazbot.org>
 <20210303175635.nv7kxiulevpy5ax5@pali>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <85786a3a-c7d4-95cc-170f-26f89c2b337e@nvidia.com>
Date:   Thu, 11 Mar 2021 19:53:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303175635.nv7kxiulevpy5ax5@pali>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4ed2d19-3bb4-4081-bb07-08d8e4994316
X-MS-TrafficTypeDiagnostic: BN8PR12MB3508:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3508851F400F5C8DC2E8012CB8909@BN8PR12MB3508.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIZWen6jjXaZuXseQ/Oz8CxkRpPc4iP0mTldqbk/K+VIkCnp94mt0ieBT84wEpJdjKQdkNOMNBiDvzIf75OPkFqmfqlDLMv0adwzCkSibG4l/QOgTbmBIxtRUrpI+YYHCqGrcXuZ8MzrL8osuGBqiFxC0D9gefUYhPkr6/OG20VZUGcRvYKpmuP/8rxTjRQg+AQK1Ndgj9AY6Lzz87KnTA13GF2afLowJxZFqcqZA3mMO6NXH3l6P+QTeMGoQwiGa4muP44VRPxXtE6ieBkGZoZxPansOMix4LXUdecg7H2EGEad7GVIpMiJkxyIm1ymEFDXbysCQJv9tb8PT1qMhLnZHb8NULyS22NwLX4wDDP4VUUg6VfRSiWABKYLo0hR/SUlLGIUSKA6F7jVNIvMqT2/XWETMNJasHj4QB8CUuPa8XO1QsX7BDP9+3c2HLyYc2O6B3b/k/tOCaMtECNZ2zuVXIn9aEY9y6DD9IGJnVmOSwCZQ02PvnLzSJj40L4650tbUzPihJ3iRbcMwQzEZBDwXfnHWmFJ1onGTPp6acvfUJor/cSXPV5Oy0KGXZ2jhC9Ad8MENr4N7N04PS9mHcKuzQhlOFd9HpLcWs5qNXbf4lIYIn6uUkvmKJ267UO2zBmMyIfKKvS9W7rsJzuazC/QpGKnCPS9zkt5bsN6IZVmC6JltUsQFhVi1DVuZkhX7TfkjTvHSZDS191bRCO454nZ+TEYSWKMHOCC8H0MA8aS5aWpvt7hwi5LFOZUlfUYhAveJirOEbT7lA5VSDeJOqvS0uR/d9W7WkJ0w9Wdk40=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(31686004)(8936002)(426003)(86362001)(47076005)(82740400003)(36906005)(70206006)(2906002)(16526019)(82310400003)(356005)(316002)(66574015)(4326008)(83380400001)(26005)(186003)(110136005)(54906003)(53546011)(7636003)(966005)(2616005)(31696002)(5660300002)(16576012)(8676002)(336012)(6666004)(36860700001)(36756003)(70586007)(478600001)(34070700002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 14:23:37.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ed2d19-3bb4-4081-bb07-08d8e4994316
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3508
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/3/2021 11:26 PM, Pali Rohár wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tuesday 02 March 2021 12:58:29 Alex Williamson wrote:
>> On Mon, 1 Mar 2021 14:28:17 -0600
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>> [+cc Alex, reset expert]
>>>
>>> On Mon, Mar 01, 2021 at 06:12:21PM +0100, Pali Rohár wrote:
>>>> Hello!
>>>>
>>>> PCIe card can be reset via in-band Hot Reset signal which can be
>>>> triggered by PCIe bridge via Secondary Bus Reset bit in PCI config
>>>> space.
>>>>
>>>> Kernel already exports sysfs node "reset" for triggering Functional
>>>> Reset of particular function of PCI device. But in some cases Functional
>>>> Reset is not enough and Hot Reset is required.
>>>>
>>>> Following RFC patch exports sysfs node "reset_bus" for PCI bridges which
>>>> triggers Secondary Bus Reset and therefore for PCIe bridges it resets
>>>> connected PCIe card.
>>>>
>>>> What do you think about it?
>>>>
>>>> Currently there is userspace script which can trigger PCIe Hot Reset by
>>>> modifying PCI config space from userspace:
>>>>
>>>> https://alexforencich.com/wiki/en/pcie/hot-reset-linux
>>>>
>>>> But because kernel already provides way how to trigger Functional Reset
>>>> it could provide also way how to trigger PCIe Hot Reset.
>>
>> What that script does and what this does, or what the existing reset
>> attribute does, are very different.  The script finds the upstream
>> bridge for a given device, removes the device (ignoring that more than
>> one device might be affected by the bus reset), uses setpci to trigger
>> a secondary bus reset, then rescans devices.  The below only triggers
>> the secondary bus reset, neither saving and restoring affected device
>> state like the existing function level reset attribute, nor removing
>> and rescanning as the script does.  It simply leaves an entire
>> hierarchy of PCI devices entirely un-programmed yet still has struct
>> pci_devs attached to them for untold future misery.
>>
>> In fact, for the case of a single device affected by the bus reset, as
>> intended by the script, the existing reset attribute will already do
>> that if the device supports no other reset mechanism.  There's actually
>> a running LFX mentorship project that aims to allow the user to control
>> the type of reset performed by the existing reset attribute such that a
>> user could force the bus reset behavior over other reset methods.
> 
> Hello Alex? Do you have a link for this "reset" project? I'm interesting
> in it as I'm dealing with Compex wifi cards which are causing problems.
> 
> For correct initialization I need to issue PCIe Warm Reset for these
> cards (Warm Reset is done via PERST# pin which most linux controller
> drivers controls via GPIO subsystem). And for now there is no way to
> trigger PCIe Warm Reset for particular PCIe device from userspace. As
> there is no userspace <--> kernel API for it.
> 
>> There might be some justification for an attribute that actually
>> implements the referenced script correctly, perhaps in kernel we could
>> avoid races with bus rescans, but simply triggering an SBR to quietly
>> de-program all downstream devices with no state restore or device
>> rescan is not it.  Any affected device would be unusable.  Was this
>> tested?  Thanks,
> 
> I have tested my change. First I called 'remove' attribute for PCIe
> card, then I called this 'bus_reset' on parent PCIe bridge and later I
> called 'rescan' attribute on bridge. It correctly rested tested ath9k
> card. So I did something similar as in above script. But I agree that
> there are race conditions and basically lot of other calls needs to be
> done to restore state.
> 
> So I see that to make it 'usable' we need to do it automatically in
> kernel and also rescan/restore state of PCIe devices behind bridge after
> reset...
But, is save-restore alone going to be enough? I mean what is the state 
of the device-driver going to be when the device is going through the 
reset process? Isn't remove-rescan the correct thing to do here rather 
than save/restore?

- Vidya Sagar
> 
>> Alex
>>
>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>> index 50fcb62d59b5..f5e11c589498 100644
>>>> --- a/drivers/pci/pci-sysfs.c
>>>> +++ b/drivers/pci/pci-sysfs.c
>>>> @@ -1321,6 +1321,30 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>>>>
>>>>   static DEVICE_ATTR(reset, 0200, NULL, reset_store);
>>>>
>>>> +static ssize_t reset_bus_store(struct device *dev, struct device_attribute *attr,
>>>> +                        const char *buf, size_t count)
>>>> +{
>>>> + struct pci_dev *pdev = to_pci_dev(dev);
>>>> + unsigned long val;
>>>> + ssize_t result = kstrtoul(buf, 0, &val);
>>>> +
>>>> + if (result < 0)
>>>> +         return result;
>>>> +
>>>> + if (val != 1)
>>>> +         return -EINVAL;
>>>> +
>>>> + pm_runtime_get_sync(dev);
>>>> + result = pci_bridge_secondary_bus_reset(pdev);
>>>> + pm_runtime_put(dev);
>>>> + if (result < 0)
>>>> +         return result;
>>>> +
>>>> + return count;
>>>> +}
>>>> +
>>>> +static DEVICE_ATTR(reset_bus, 0200, NULL, reset_bus_store);
>>>> +
>>>>   static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>>>>   {
>>>>    int retval;
>>>> @@ -1332,8 +1356,15 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>>>>            if (retval)
>>>>                    goto error;
>>>>    }
>>>> + if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>>> +         retval = device_create_file(&dev->dev, &dev_attr_reset_bus);
>>>> +         if (retval)
>>>> +                 goto error_reset_bus;
>>>> + }
>>>>    return 0;
>>>>
>>>> +error_reset_bus:
>>>> + device_remove_file(&dev->dev, &dev_attr_reset);
>>>>   error:
>>>>    pcie_vpd_remove_sysfs_dev_files(dev);
>>>>    return retval;
>>>> @@ -1414,6 +1445,8 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>>>>            device_remove_file(&dev->dev, &dev_attr_reset);
>>>>            dev->reset_fn = 0;
>>>>    }
>>>> + if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>>>> +         device_remove_file(&dev->dev, &dev_attr_reset_bus);
>>>>   }
>>>>
>>>>   /**
>>>
>>
