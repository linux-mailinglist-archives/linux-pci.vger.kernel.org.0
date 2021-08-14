Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3593EC014
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 05:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhHNDgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 23:36:20 -0400
Received: from mail-mw2nam12on2047.outbound.protection.outlook.com ([40.107.244.47]:57760
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236789AbhHNDgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 23:36:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE2NmE3D3Nd31r/SeTjbOyDEx/MGR2tniPdr8QMmJdS4XfyWAgfPBJwD4b0IJ8YOX4l/tytUDXrk6fQfXMt6glnkX6YT7O35gkbjG56iYg+a1F6NNUCR+nqXdekvEP/KTu0BOatizxOFNNX4ObietlR8xf3AxV32DpAOkxCcLvaQYgdr7k/QIdJ3qA2hrzsQxs2ya9pm13k3abyefDsk3dF84cVEIkrWxOAs+yfcRWymzpIpO534I+Gx94Fedn4ItuVIJ/WCqE2SSzjQgCktJQDiYIX+RB2U7lbWkj0IyQog1gZPTYjy+RtDszvAJ2/whv1hUSU9JKhwU8KKLTzjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU2VUIoADZvOdfOeudWlnhRkQtgVJpTtpkDxSVSFqgU=;
 b=ckqTU8AvWm0eGZac1DQ9sGgT/5t8oa4Hu//MrRjjQXyEYHP530S6R1Q8RyzPpUf9nbJtwz9Ag3MYH/k2gezo/NWhRb5H7B2LU6xGE3z4fAm28dVh5p7C9huxovkizVmWystj9glWoYmwS4gSLQMDY40oM+LqfJc/oM3mtQ4k3y/2fHualB/iEJD5wvkSr7ki9sFalQ863EYeIPHRqPsknbXvV5izDYl2q7cTIBfn6KU2Z1A2voxwFbogCiRp2PAsBQ3fR5JKS4VZgzUQGSynJv33VGCB3Knywo6CpXziZD/5bI9fjEDB4vlH9o86z4lrBrFfMtK/5077QS8TAuQN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU2VUIoADZvOdfOeudWlnhRkQtgVJpTtpkDxSVSFqgU=;
 b=aBUaNVJ2wfXXfqapHA+Q8cJHO9XxPZEZU6XTPmUA8fy4pPFiTELdriSwjvM6lyAV5y6haWBAmPX7AktKRyHVMs1u4yicM5enwitZGo9BJ/aw8+MU19N6l8XnOZVQ7LMX2Ze3v7VAztoe38uWqj1hSbK+zejZGP80odcA8NqV2fhJS8nxCo5kdfC9vBRuih0oay0TC1DfVzWnX+mJvJ6SUSfEVsXY6m2nnXTMKssMCFBPIlqw/vWj+wrrHo6vf3DE0Zgd+L/6X892Y1UQIFWwNWy7TWb3ugZ7MSb3iW4XjvCuAVZMtW/AH+kba6yMTinaRyPETST03cljpD+qriqwww==
Received: from DM6PR06CA0032.namprd06.prod.outlook.com (2603:10b6:5:120::45)
 by DM5PR12MB2520.namprd12.prod.outlook.com (2603:10b6:4:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Sat, 14 Aug
 2021 03:35:50 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::bc) by DM6PR06CA0032.outlook.office365.com
 (2603:10b6:5:120::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Sat, 14 Aug 2021 03:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.14 via Frontend Transport; Sat, 14 Aug 2021 03:35:50 +0000
Received: from [10.20.114.145] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 14 Aug
 2021 03:35:48 +0000
Subject: Re: [PATCH v15 7/9] PCI: Setup ACPI fwnode early and at the same time
 with OF
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20210813230428.GA2745285@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <0ed12600-a6d4-f6f1-6250-a8ff9a3625a6@nvidia.com>
Date:   Fri, 13 Aug 2021 22:35:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210813230428.GA2745285@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f010117e-516f-474b-602b-08d95ed49cc2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2520:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25206999A0461A2CBB3BBEE1C7FB9@DM5PR12MB2520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDaoJI88BEAe75xwtD+aI8WBfjzqUlKl3ZIbgpmZ7yOFEjIQX+QaBKPwyncsdl84appOELZyNm8hdm70HLscFBEqoXDjCJ2f8taVyP7Hf1qXaHvjNifwJoN26SCkcCSkwNUJCvsFK4mmW6hihEvKYrVaH0EdsjQrLSiDHl7J9eBAv00s4yHfehbciwF85c1tKo4LnvF1dOJwyhg55LyHanR7CYkXUpb0KhMK04MucQ+09hKiejzWYgMuWA/Pc/B6ZcRxK+qvYj6j96FyC/pr7fDEEg36rxhnEG4XcQ9Yc/jUCj2pBu8ZAC8N56/EloIU5Oy5nbScJPUT5RpMCBLH2stOQQyVQXonZY4LkDivQF4/CtMU6EcmxBLld2vN+sJTE6SVy86tqgqJcRV16cbEftzHxgaoSArsQnHJ05lxc2KO5QAi9Lgg8HFale/x8XeSabnnDw3TSPLNPFE/Zx9Cnz6A3oobw3XjobrDB6pb9utZL49rUhLa3xgwxWXX2LLJwDzW1nW7XEdoHPMe6tEKRX6YlfIdsrEJkPSztSv+3JL3Gh3RYcsE2LsBdX66Zfr/1My3GKbnXkYnG5ABkbtelxftFxsXqOZP5YuUitC8nd4Qblnq2JjvG5uGf8QeG7soTNKzuKk9hDiP6CzFRBYmxV+41Y0Bb4GB+eca7vEooZ+USW5HibqIW5fxvPSTCmtia1CNnH3dM6L86CRFDl4WIOU9bk35HV8I9gJsL1Wh772ssexmcPBLAFSYiN4Mq5FD
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(86362001)(36756003)(31696002)(82310400003)(31686004)(26005)(36860700001)(53546011)(7636003)(83380400001)(8676002)(70586007)(426003)(336012)(5660300002)(2906002)(16526019)(36906005)(2616005)(8936002)(508600001)(70206006)(7416002)(186003)(316002)(356005)(4326008)(110136005)(16576012)(54906003)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2021 03:35:50.4538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f010117e-516f-474b-602b-08d95ed49cc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2520
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 8/13/21 6:04 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> [+cc Ben, Mika]
>
> On Thu, Aug 05, 2021 at 09:59:15PM +0530, Amey Narkhede wrote:
>> From: Shanker Donthineni <sdonthineni@nvidia.com>
>>
>> The pci_dev objects are created through two mechanisms 1) during PCI
>> bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
>> is being set at different places depends on the type of firmware used,
>> device creation mechanism, and acpi_pci_bridge_d3().
>>
>> The software features which have a dependency on ACPI fwnode properties
>> and need to be handled before device_add() will not work. One use case,
>> the software has to check the existence of _RST method to support ACPI
>> based reset method.
>>
>> This patch does the two changes in order to provide fwnode consistently.
>>  - Set ACPI and OF fwnodes from pci_setup_device().
>>  - Remove pci_set_acpi_fwnode() in acpi_pci_bridge_d3().
>>
>> After this patch, ACPI/OF firmware properties are visible at the same
>> time during the early stage of pci_dev setup. And also call sites should
>> be able to use firmware agnostic functions device_property_xxx() for the
>> early PCI quirks in the future.
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>  drivers/pci/pci-acpi.c | 1 -
>>  drivers/pci/probe.c    | 7 ++++---
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index eaddbf701759..dae021322b3f 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>               return false;
>>
>>       /* Assume D3 support if the bridge is power-manageable by ACPI. */
>> -     pci_set_acpi_fwnode(dev);
>>       adev = ACPI_COMPANION(&dev->dev);
> I *think* the Root Port code farther down in this function is also now
> unnecessary:
>
>   acpi_pci_bridge_d3(...)
>   {
>     ...
>     root = pcie_find_root_port(dev);
>     adev = ACPI_COMPANION(&root->dev);
>     if (root == dev) {
>       /*
>        * It is possible that the ACPI companion is not yet bound
>        * for the root port so look it up manually here.
>        */
>       if (!adev && !pci_dev_is_added(root))
>         adev = acpi_pci_find_companion(&root->dev);
>     }
>
> Since we're now setting the ACPI_COMPANION for every pci_dev long
> before we get here, I think this could now be simplified to something
> like this:
>
>   acpi_pci_bridge_d3(...)
>   {
>     if (!dev->is_hotplug_bridge)
>       return false;
>
>     adev = ACPI_COMPANION(&dev->dev);
>     if (adev && acpi_device_power_manageable(adev))
>       return true;
>
>     root = pcie_find_root_port(dev);
>     if (!root)
>       return false;
>
>     adev = ACPI_COMPANION(&root->dev);
>     if (!adev)
>       return false;
>
>     rc = acpi_dev_get_property(dev, "HotPlugSupportInD3",
>                                ACPI_TYPE_INTEGER, &val);
>     if (rc < 0)
>       return false;
>
>     return val == 1;
>   }

Agree, thanks for your suggestion. Yes, it can be simplified too.
Can I do something like this using the unified device property API?

static bool acpi_pci_bridge_d3(struct pci_dev *dev)
{
        struct acpi_device *adev;
        struct pci_dev *root;
        u8 val;

        if (!dev->is_hotplug_bridge)
                return false;

        adev = ACPI_COMPANION(&dev->dev);
        if (adev && acpi_device_power_manageable(adev))
                return true;

        root = pcie_find_root_port(dev);
        if (!root)
                return false;

        if (device_property_read_u8(&root->dev, "HotPlugSupportInD3", &val))
                return false;

        return val == 1;
}

> acpi_pci_bridge_d3() was added by 26ad34d510a8 ("PCI / ACPI: Whitelist
> D3 for more PCIe hotplug ports") [1], so I cc'd Mika in case he has
> any comment.
>
>>       if (adev && acpi_device_power_manageable(adev))
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 379e85037d9b..15a6975d3757 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1789,6 +1789,9 @@ int pci_setup_device(struct pci_dev *dev)
>>       dev->error_state = pci_channel_io_normal;
>>       set_pcie_port_type(dev);
>>
>> +     pci_set_of_node(dev);
>> +     pci_set_acpi_fwnode(dev);
> Is there a reason why you moved pci_set_of_node() from
> pci_scan_device() to here?  I think it's a good change; I'm just
> curious if you tripped over something that required it.

There is no specific reason and not required but setting both the fwnodes
at the same time improves the code readability and provides consistent
device properties for callers.

> The pci_set_of_node() was added to pci_scan_device() by 98d9f30c820d
> ("pci/of: Match PCI devices to OF nodes dynamically") [2], so I cc'd
> Ben just in case there's some reason he didn't put it in
> pci_setup_device() in the first place.
>

Thanks,
Shanker Donthineni

