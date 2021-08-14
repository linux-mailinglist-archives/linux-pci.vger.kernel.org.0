Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88163EC3BF
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhHNQQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 12:16:45 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:15969
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229818AbhHNQQp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Aug 2021 12:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym96+FTc3xe1O8cnREVMn20QQkK7cP22UiDGqgz1MSAUxNWzj5JsLhKSnlQgNtJTrOJ/L/rKyCDY9QNDH2RAo96KS6zQ7DhhOCXZGt2LN8DvwCXEvGh8Tkbn4GbLvMny0nxJVXLmyAnIz2EOzB+IrYZMYlWpMgfxRDTrBVrKjLK1re2zPdhBSllaVsybCD/wE1MKHAL5b6Z470r6VeLnzkCPmcHmltsEw4nTKAAQjuWn2G+5mk7Dbt1P8M+tIIGbY3MWjHgr97oi1rE8NZp1BV9vAX3R10foWBXaNfiXU8pK+iOrRDB+qziXVUhpvI9ha9c7gDSZR8cZxKb6iVgRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39H1tzP1eSTTEMiynjM0s2p8sN9YrXaVBbcr9YNY7Dk=;
 b=L0tKRob/eeWNVOEFFdkJP7sp/uv8FuD6UjQ65VCwFKKPQktKP4tWiwUhwRBZ1lURA2MYtp/n2HVr3Mb0VlWTY8A8EqTqAJ6EgDOuTLTRE8yE0qGk9HkAKjZrFXy+aCjiXyDUjr1ytBfgPjdq6oCr9ttUjbyUqkvKjmUW3+liLLtpC4USPP7QwEambE07JXe37rDeDlJW4fKQlPNQvoqkGbz9sXZ2HDhxyM2L72R7Hpm3XwpX5RUROOXHANudEXeS3wwPY2Vkg2bLnnsAUrWDT7RhfreXKW97+DsSoVIRmMYLUhHekTYw9G7iaImGa1G0B+BIKL5pFnNs6h489IQIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39H1tzP1eSTTEMiynjM0s2p8sN9YrXaVBbcr9YNY7Dk=;
 b=ZS+UrCiyyLtl1PQD51YKvx7nA2Aq88h8UyBF5/LkWTfs40AmsA7jE6LbEqvuC+qM7SK9lrVimIoO6eM+VORC1mOFDvtOeS5iKqAeMNpFcaJxuLmn6DOPypZxRs1/iV7Z2MHZDCQ4+QnYDPCKJrT/4ARud28pjzyP4Ta6kIRXjytfJ8+86YW6mLX+0m1DCSRjxA5bLcx8MhoPINy8e2ugfOkTarI0H/74aDwwF5QSCksAXBf/Yaom88WfoA4AqtY+pNFQUV5nBCuXHHMNixvBXAQQvhN/FGgbvMbINwWyUSda1MOuvYo97rFDQP0xyEhzlB+8j7HWU2ADu7lvmXuUXw==
Received: from DS7PR05CA0008.namprd05.prod.outlook.com (2603:10b6:5:3b9::13)
 by CH2PR12MB3733.namprd12.prod.outlook.com (2603:10b6:610:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Sat, 14 Aug
 2021 16:16:14 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::cd) by DS7PR05CA0008.outlook.office365.com
 (2603:10b6:5:3b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend
 Transport; Sat, 14 Aug 2021 16:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Sat, 14 Aug 2021 16:16:14 +0000
Received: from [10.20.114.145] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 14 Aug
 2021 16:16:12 +0000
Subject: Re: [PATCH v15 7/9] PCI: Setup ACPI fwnode early and at the same time
 with OF
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20210814041048.GA2765970@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <63e0f64c-e51b-feb7-a193-c2999a280b80@nvidia.com>
Date:   Sat, 14 Aug 2021 11:16:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210814041048.GA2765970@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356ba3e2-35a8-4961-589c-08d95f3ed6dc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3733:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37337F5B67509692B0B72E1CC7FB9@CH2PR12MB3733.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iw55GMj3VcJ5WhGuv9W6qVK7g94RrGU1T8tgXcmchZgV1q6mTgQL/yc1eTVXj+DAs6l4kuZ1MQSZbfirWLfZEtNjgR6DZtpNxmCN4AaVcbJJ7CUBVTiStukEgKxB15SddAuBEEDhEaIFv8R2uUYTrYKj4efeP4zDrXeHimCHlczW6S5L8FNQK80GBNBliz9KV9yFtygAMlIYUIL9EySIaFJoem5BXzwy4TYmmg0WqYpkp0x4KlOrOahF3obTvMcfiCjUuIo9IqLv1RdBHXn3152jkqN0z4ZOgoCs8NOGmR6EmYQ1Q3L7zn86WNaiwnh6dyVNr66mE0F9EYzexuFwNkMQ3sv6sjI2qjbsRbd0wItIlqlEj4hlm6WDukDnNkbNtfGYm2w2V2J0V5bU+3z0YH6FMfNBOCVCErq7LAlHeKFN5V9mY4FHlJwPEBjj8fFBNicDb1ECyqK2bHHya+BVvdUBPiiSxkxk81ss+aVekj8S+imJkb6ADgIYBWmTxcI3kBjNc/ACkzXwoBwtk9trLa6EyaC6rbjUZSjJvMPOqbTlG5qIMMuFWYTCPzCElQOqZo/lgmwyr66SQAWsq0FyWMS5c7mJi6zZ1IT2xJBEXz9C0AgF8DNIwZOYYCLgugCoFXLCwkj1s/nUIwcR+QECols5nc6+EQ1dY6fqV1M8nsJTLeoL6Biku3/FNyKXiIn1RNIDLIQWv+jLSbwC74meLZiH1fsC2QgpdG/0PY6y3dM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(36860700001)(336012)(16576012)(82740400003)(316002)(426003)(36906005)(7416002)(31686004)(86362001)(5660300002)(478600001)(4326008)(2616005)(2906002)(8676002)(54906003)(53546011)(186003)(70206006)(70586007)(356005)(16526019)(7636003)(82310400003)(6916009)(8936002)(36756003)(47076005)(31696002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2021 16:16:14.5912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 356ba3e2-35a8-4961-589c-08d95f3ed6dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3733
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 8/13/21 11:10 PM, Bjorn Helgaas wrote:
>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>> index eaddbf701759..dae021322b3f 100644
>>>> --- a/drivers/pci/pci-acpi.c
>>>> +++ b/drivers/pci/pci-acpi.c
>>>> @@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>>               return false;
>>>>
>>>>       /* Assume D3 support if the bridge is power-manageable by ACPI. */
>>>> -     pci_set_acpi_fwnode(dev);
>>>>       adev = ACPI_COMPANION(&dev->dev);
>>> I *think* the Root Port code farther down in this function is also now
>>> unnecessary:
>>>
>>>   acpi_pci_bridge_d3(...)
>>>   {
>>>     ...
>>>     root = pcie_find_root_port(dev);
>>>     adev = ACPI_COMPANION(&root->dev);
>>>     if (root == dev) {
>>>       /*
>>>        * It is possible that the ACPI companion is not yet bound
>>>        * for the root port so look it up manually here.
>>>        */
>>>       if (!adev && !pci_dev_is_added(root))
>>>         adev = acpi_pci_find_companion(&root->dev);
>>>     }
>>>
>>> Since we're now setting the ACPI_COMPANION for every pci_dev long
>>> before we get here, I think this could now be simplified to something
>>> like this:
>>>
>>>   acpi_pci_bridge_d3(...)
>>>   {
>>>     if (!dev->is_hotplug_bridge)
>>>       return false;
>>>
>>>     adev = ACPI_COMPANION(&dev->dev);
>>>     if (adev && acpi_device_power_manageable(adev))
>>>       return true;
>>>
>>>     root = pcie_find_root_port(dev);
>>>     if (!root)
>>>       return false;
>>>
>>>     adev = ACPI_COMPANION(&root->dev);
>>>     if (!adev)
>>>       return false;
>>>
>>>     rc = acpi_dev_get_property(dev, "HotPlugSupportInD3",
>>>                                ACPI_TYPE_INTEGER, &val);
>>>     if (rc < 0)
>>>       return false;
>>>
>>>     return val == 1;
>>>   }
>> Agree, thanks for your suggestion. Yes, it can be simplified too.
>> Can I do something like this using the unified device property API?
>>
>> static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>> {
>>         struct acpi_device *adev;
>>         struct pci_dev *root;
>>         u8 val;
>>
>>         if (!dev->is_hotplug_bridge)
>>                 return false;
>>
>>         adev = ACPI_COMPANION(&dev->dev);
>>         if (adev && acpi_device_power_manageable(adev))
>>                 return true;
>>
>>         root = pcie_find_root_port(dev);
>>         if (!root)
>>                 return false;
>>
>>         if (device_property_read_u8(&root->dev, "HotPlugSupportInD3", &val))
>>                 return false;
> I guess that might be OK.
>
> TBH I don't really like the device_property_read_u8() thing because
> (1) we know this is an ACPI property and I don't see a reason to use
> an "generic" interface that doesn't buy us anything, and (2) the
> connection to the source of the data (a _DSD method) is really, really
> hard to find.
>
> Admittedly, it's still pretty hard to connect acpi_dev_get_property()
> with "_DSD".  The only real clue is the comment about "Look for a
> special _DSD property ..."
>
Does it satisfy you if I change the comment and still use device_property API?

static bool acpi_pci_bridge_d3(struct pci_dev *dev)
{
        struct pci_dev *rpdev;
        u8 val;

        if (!dev->is_hotplug_bridge)
                return false;

        /* Assume D3 support if the bridge is power-manageable by ACPI. */
        if (acpi_pci_power_manageable(dev))
                return true;

        /*
         * Look for 'HotPlugSupportInD3' property for the root port and if
         * it is set we know the hierarchy behind it supports D3 just fine.
         */
        rpdev = pcie_find_root_port(dev);
        if (!rpdev)
                return false;

        if (device_property_read_u8(&rpdev->dev, "HotPlugSupportInD3", &val))
                return false;

        return val == 1;
}

If not, I'll do changes like this.

static bool acpi_pci_bridge_d3(struct pci_dev *dev)
{
        const union acpi_object *obj;
        struct acpi_device *adev;
        struct pci_dev *rpdev;


        if (!dev->is_hotplug_bridge)
                return false;

        /* Assume D3 support if the bridge is power-manageable by ACPI. */
        if (acpi_pci_power_manageable(dev))
                return true;

        /*
         * Look for 'HotPlugSupportInD3' property for the root port and if
         * it is set we know the hierarchy behind it supports D3 just fine.
         */
        rpdev = pcie_find_root_port(dev);
        if (!rpdev)
                return false;

        adev = ACPI_COMPANION(&rpdev->dev);
        if (!adev)
                return false;

       if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
                                   ACPI_TYPE_INTEGER, &obj) < 0)
                return false;

        return obj->integer.value == 1;
}


