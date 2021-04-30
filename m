Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB333700FD
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 21:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhD3TH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 15:07:26 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:8673
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230356AbhD3THW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 15:07:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+Ipmw+hrduC5YqXm+ChUxzpAmd6Gnzdw1j/lloA/ZNf4pUA2ayyw81EAro+fS/yZtVwX+dbuuS77dCA3jgKZ4g69YlpSi372aW40uBXsKHdTT3fYopc8iJAS75gSWilIh+n4AbcWg4kGxpPsoblYKzIkd7kvGy+f7VYern41lq8kkncA8lQ6jlKIhzXr716qPrWREFwYlvz8PHQZPzdoXs4kQjbAiVb1bGJFT0VMw/TnS650nd2untEOMueTnkFJqPUVlOItZ8FFEutBtCLW+lzDifjeU8LDp759l6yGmCh2fJkKflomnWosszxGdTRaqvpe+c8F4Wa0k8cyvYy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VYXX9SZZJiLg+FdylyuRickCQJMcgjKecsxzmLSuwY=;
 b=XOt9mwD7G00kA0xr7Trso0/yZc3FkpreOOhGXFGwZ8HBryzZc1+ESYPozEVq4d3ie1S8uY6oYDkdO3jQTZtcumR6uVwJw4Ii7obq98jWzfxv/DGnbHDEkGzn5NENtKSrb0cwXtZngFgkyGo7bzDpb9oTcMS1MBOxS0y9X4Rw8ggrlBpfuQ1dLkkwduqLP0Bi7//M186R5AFpJ4YAq1ujaZVUNN3WlCeJ5AcxNyvn67v1fPdYePqZy2PB/Y7oCgPOG1Bq0wVfWGANlfbBS+8UyRGPbxiPXc6kjP7ZhFg/xmTHEs/gttXOiDyiIlJ8pfNQgFkAcieD5qLvJBPB54WNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VYXX9SZZJiLg+FdylyuRickCQJMcgjKecsxzmLSuwY=;
 b=Fxj/JwRTZgZ5adQehYD+xV8HA3LCPgqzITXwiZPFjdm3SWxuUSRalH6DbxgIiJDgprueYQcUU4OCtLvnFJqBT1Xm6yAs0vGElIv1c8kODMTPfXAeFSZDyPRJES45w4eoICv9sqNIuDOhdz4ntWBt898ntBbLYI30WADmfePN7U6KcrJr4MnFOWZMC5XVkuTZh3tL2YoZlCuul4vbWwQDRDg3CsYT1Jq3nlLlXztXbvWvRU+u8+vOCciffz85/kgEBR9n5/shseg3sVwdZSird5LKTskaoZKEaBCQaXDivMZmsRu6p8v4oLAGqEVZmnnfWjnMos0Udc9kNM0u7YjtDw==
Received: from BN6PR14CA0011.namprd14.prod.outlook.com (2603:10b6:404:79::21)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Fri, 30 Apr
 2021 19:06:33 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::a1) by BN6PR14CA0011.outlook.office365.com
 (2603:10b6:404:79::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Fri, 30 Apr 2021 19:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.32 via Frontend Transport; Fri, 30 Apr 2021 19:06:32 +0000
Received: from [10.20.22.163] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 30 Apr
 2021 19:06:28 +0000
Subject: Re: [PATCH v4 1/2] PCI: Add support for a function level reset based
 on _RST method
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
References: <20210429004907.29044-1-sdonthineni@nvidia.com>
 <20210430123945.54dd479c@redhat.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <917ee9fe-53b0-c637-5200-cd1b55512895@nvidia.com>
Date:   Fri, 30 Apr 2021 14:05:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210430123945.54dd479c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59185791-dcc0-4a67-280a-08d90c0b11b1
X-MS-TrafficTypeDiagnostic: PH0PR12MB5467:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5467F47522C7A02FC04B5215C75E9@PH0PR12MB5467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBTSNKxLt3vb/xndtBArHGuB1BdZLNCEu1DX/lyltni7+cXUfvUGxGJQxZPg36QYiK0AoxUWJxxZtqmRwnug9L+MIeqPcDz8uhJPwzTsxRuJoGg6OdWQ9IDiAImrS+ux6RjDSX3DHuRMhcA0DHZQHmWL1LHYHTGqDzMMvD9ehDfUrHNadtql5d6+9Drrx6keScizzZd57yfs0WKW5MPooCU+udAyw4BHB7imWHdcFD/HXZgFGq9L8gO1Y7mjQ9lBKWr4yx6w7zAljU/SCE7kQEl7EeqlHC7yL7NHgsmCPeQHAol2G0Q+/+DlnLw0++e2KpizJtbyF+Q7U0ccXJlwGPfMCIp+ZRrlYUwmmzF0m84P0+0QAaSawaJu1PzHqBmVHsaOyzmZgcNt826uSnPGub7ud4dMTPq1JjTJ4GUHdWq76QunINkA7fA9gh7Jz501ikYIOwY1DwIxe8xXFKZDag93QK+bWnPdztHoEEjYAtTV7CgmcKNnO73ByzyglMu+9+3Qhobw6enrw51j7hNxqO2DI13ikQymC9satjwq0Mc0XHlj5Doell2fSOv8/0FTyCyisAaIJN5mBsPBM1nhJ7roXTUw05EJ5aX80l58pbZl0RRyQfq0a7ussf4EpYs0noWaFlRZBV1cEtpVihzTuYjRpYPsTH+ySNzpapgO9WUAVUtGHNq3w6aONpB45Ra4iSpaslLLUbSJWYzuOkDKHxPRv/SeNhx1RzTW9w1FF7tvS9mdrTkgR86SIrztFc/jY5lU1baei1zVl22eR3qm1A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(16526019)(86362001)(2616005)(6666004)(8676002)(83380400001)(2906002)(6916009)(36756003)(8936002)(186003)(478600001)(82310400003)(82740400003)(316002)(336012)(54906003)(36906005)(26005)(426003)(31686004)(47076005)(356005)(16576012)(53546011)(966005)(70586007)(7636003)(36860700001)(4326008)(31696002)(5660300002)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 19:06:32.8873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59185791-dcc0-4a67-280a-08d90c0b11b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

On 4/30/21 1:39 PM, Alex Williamson wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 28 Apr 2021 19:49:06 -0500
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>
>> The _RST is a standard method specified in the ACPI specification. It
>> provides a function level reset when it is described in the acpi_device
>> context associated with PCI-device.
>>
>> Implement a new reset function pci_dev_acpi_reset() for probing RST
>> method and execute if it is defined in the firmware. The ACPI binding
>> information is available only after calling device_add(), so move
>> pci_init_reset_methods() to end of the pci_device_add().
>>
>> The default priority of the acpi reset is set to below device-specific
>> and above hardware resets.
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>> changes since v2:
>>  - fix typo in the commit text
>> changes since v2:
>>  - rebase patch on top of https://lore.kernel.org/linux-pci/20210409192324.30080-1-ameynarkhede03@gmail.com/
>>
>>  drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
>>  drivers/pci/probe.c |  2 +-
>>  include/linux/pci.h |  2 +-
>>  3 files changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 664cf2d358d6..510f9224a3b0 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5076,6 +5076,35 @@ static void pci_dev_restore(struct pci_dev *dev)
>>               err_handler->reset_done(dev);
>>  }
>>
>> +/**
>> + * pci_dev_acpi_reset - do a function level reset using _RST method
>> + * @dev: device to reset
>> + * @probe: check if _RST method is included in the acpi_device context.
>> + */
>> +static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
>> +{
>> +#ifdef CONFIG_ACPI
>> +     acpi_handle handle = ACPI_HANDLE(&dev->dev);
>> +
>> +     /* Return -ENOTTY if _RST method is not included in the dev context */
>> +     if (!handle || !acpi_has_method(handle, "_RST"))
>> +             return -ENOTTY;
>> +
>> +     /* Return 0 for probe phase indicating that we can reset this device */
>> +     if (probe)
>> +             return 0;
>> +
>> +     /* Invoke _RST() method to perform a function level reset */
>> +     if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
>> +             pci_warn(dev, "Failed to reset the device\n");
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>> +#else
>> +     return -ENOTTY;
>> +#endif
>> +}
>> +
>>  /*
>>   * The ordering for functions in pci_reset_fn_methods
>>   * is required for reset_methods byte array defined
>> @@ -5083,6 +5112,7 @@ static void pci_dev_restore(struct pci_dev *dev)
>>   */
>>  const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>>       { .reset_fn = &pci_dev_specific_reset, .name = "device_specific" },
>> +     { .reset_fn = &pci_dev_acpi_reset, .name = "acpi_reset" },
> Would it make sense to name this "acpi_rst" after the method name?
> Otherwise "_reset" is a bit redundant to the sysfs attribute, we could
> simply name it "acpi" to indicate an ACPI based reset.  Thanks,
>
Thanks,  I will change to "{ .reset_fn = &pci_dev_acpi_reset, .name = "acpi" }"

