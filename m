Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E63E369C2D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 23:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhDWVrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 17:47:02 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:18785
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232438AbhDWVq7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Apr 2021 17:46:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6gTyjHurxTrmKKJQA4DIxdT2e23LtcznakAu3d/RuYwvIVaIP593gwOXD6Hq1xf6WyaKyZ8gN8xhHSnYwDQ8L0btTDXmiKTx/ZsW6cZvX7851J+k8a4RrKIXjrktlqPCFwXo4k44tsFseNJkIO5Xh0s0VSLcI04MliIcPTc3twEdupqgR6aBaY2WY+gLbWQHhaWiH35Di1ZVBaOdNlGLxFa26IPN3aB2Fj1/EShpSf4Q025znT0F5K2y4Y8v/1zrZBoDP5y6XyDEX+N061bn7StKQIE3q74ejI9znqDFNumahlpHOLRBZ1DKemXH0acAAKApqLSQ4LjpQIzCDN7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5XjwuE6vQRmu22FshZCcvcVgOaNiNyn3Y+uyu4n8k4=;
 b=MzzAuoEqShdHNHzXbATSH9J9kyZna+JdvRg7bzqaQf3sWxiOSuSISlb9abVW700cEt3SIXFQbugi9zFuM6ceKw37VewboJvj/OQlJ7xHgyPs/BxcEq2Q5JJv3PuqvBTvi3ygS8RkjyUp/u7kmXe1flOCYqqZ5TfDtse3XoXj9B4Zk/19lFsd2+q9WZ4WElOflxoJ001Z2ITX6InlDtUSDvBT3qKkHhML0VUNQLSco1Ndw5tdSQ0atgy7lYIXZFzS04BBkyB4jUWDiqX+nKYz3n70RPVKh94CwzXEZyY3bWs2e3e5BAvLvChVT78Aw4JI4RVTWywcVsy8uf/lr/NjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5XjwuE6vQRmu22FshZCcvcVgOaNiNyn3Y+uyu4n8k4=;
 b=uheKALhwqRDGav+14qmO4u9lE404UWIqPHlb3SocbyhyeatW57nzDp0l+LmtMKza+SB+xqFQZeCdN3TO+mkdcZCg07AvtZKy3SryUykBeC3aqiDjHt2a9M26PRdXDGsS7zjFcCmZRTQRv9Vg4NvwQCZMll4phmH9NXyG1JnOJP0z0zP7sdh6sPWwZBpXdW25Z5AAE6A7VFwB3G2HHAjc75mMQIs5l4UbmLIUZ8d7ub/JInqIPzlei4Y9hYzpLvJUI/UbWiHyx8TgmFHyCiZoYSeX4j/8JPR6q08dSHiZ9Pkx4V9khuTq4+zHp+zBB7hbui2REoMYD57JWcQpHKuhLw==
Received: from MWHPR19CA0056.namprd19.prod.outlook.com (2603:10b6:300:94::18)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 21:46:18 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::4c) by MWHPR19CA0056.outlook.office365.com
 (2603:10b6:300:94::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 21:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 21:46:18 +0000
Received: from [10.20.22.65] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 21:45:48 +0000
Subject: Re: [PATCH 1/1] PCI: Add pci reset quirk for Nvidia GPUs
To:     Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
References: <20210423145402.14559-1-sdonthineni@nvidia.com>
 <ff4812ba-ec1d-9462-0cbd-029635af3267@kernel.org>
 <20210423093701.594efd86@redhat.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <c758d8a8-4f8b-c505-118e-b364e93ae539@nvidia.com>
Date:   Fri, 23 Apr 2021 16:45:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423093701.594efd86@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ec5824-b968-4f28-728a-08d906a13a34
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-Microsoft-Antispam-PRVS: <DM6PR12MB474825375DA320A520E96673C7459@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIvB9umFr/orJTJ/HNBspMCTLVqDK9BYWULOX0CahS6TGBMl0R6nSZ2ySHtQMggP6CYzIgCfTUmxfEJzQvk/8IRStXXGIc7BYFL2zRc+flvyr5q4EIHjhc3x1hmv0IEnYdIp2ETdBSzLtQQAzgrmfb9Q0IiGVN/jcrSrCwGYCj/SHe5puLWuTMq7SOsCwzROgGV2tRmEcpFU2LaVstCfv59FaPSm7nbCnkgqXj1k69kJDjbI4RWKUD0K+0ZE66iWW7qD3R0cF9yuZrEQX8JbNZZepTo5c8DxrweniEXbFEGef2E2eroyzWJOnl7A14ejHbSLc8OMTfJ4jqNMPVrzTzDWnEajmS1/UwbBeDfZ/tq/n2K9OHXT8i8gYmL+MkUR0WHAS7xrwBjV+OFViP3Rwg9erF5c6hAjbZUUaCx9BaFH4PWuRIaW3k0n+f0usYFHvOyjKKrtrVESlE4k0oCYLXYu1I9dGO+4XfQAqzNLPzVa1JU/gET/GN3ucxxECUXSa4ck87uQPyO+4u3iCcznEP0gRDFo9YYAYlhN7rZ2SwD7heZABHDCcmTacHw+K+/dK4Hl+dUa6EznTHwWZi1E1AL8efXDPNEdCMYqj09HP7nDMLNHpccEgB23Ttn6o10w+8PKIoTQCkUlceWGekwaTQDARlM+ZXiX0LNMIky1APmdGJ1Rk2E11ukm1VoloZds
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(7636003)(356005)(82310400003)(47076005)(82740400003)(83380400001)(70586007)(70206006)(31696002)(36860700001)(86362001)(53546011)(26005)(336012)(6666004)(54906003)(31686004)(4326008)(107886003)(186003)(36906005)(16576012)(36756003)(5660300002)(8676002)(110136005)(316002)(8936002)(2616005)(16526019)(426003)(478600001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 21:46:18.4623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ec5824-b968-4f28-728a-08d906a13a34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/23/21 10:37 AM, Alex Williamson wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, 23 Apr 2021 11:12:05 -0400
> Sinan Kaya <okaya@kernel.org> wrote:
>
>> +Alex,
>>
>> On 4/23/2021 10:54 AM, Shanker Donthineni wrote:
>>> +static int reset_nvidia_gpu_quirk(struct pci_dev *dev, int probe)
>>> +{
>>> +#ifdef CONFIG_ACPI
>>> +   acpi_handle handle = ACPI_HANDLE(&dev->dev);
>>> +
>>> +   /*
>>> +    * Check for the affected devices' ID range. If device is not in
>>> +    * the affected range, return -ENOTTY indicating no device
>>> +    * specific reset method is available.
>>> +    */
>>> +   if ((dev->device & 0xffc0) != 0x2340)
>>> +           return -ENOTTY;
>>> +
>>> +   /*
>>> +    * Return -ENOTTY indicating no device-specific reset method if _RST
>>> +    * method is not defined
>>> +    */
>>> +   if (!handle || !acpi_has_method(handle, "_RST"))
>>> +           return -ENOTTY;
>>> +
>>> +   /* Return 0 for probe phase indicating that we can reset this device */
>>> +   if (probe)
>>> +           return 0;
>>> +
>>> +   /* Invoke _RST() method to perform the device-specific reset */
>>> +   if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
>>> +           pci_warn(dev, "Failed to reset the device\n");
>>> +           return -EINVAL;
>>> +   }
>>> +   return 0;
>>> +#else
>>> +   return -ENOTTY;
>>> +#endif
>>> +}
>> Interesting, some pieces of this function (especially the ACPI _RST)
>> could be generalized.
> Agreed, we should add a new function level reset method for this rather
> than a device specific reset.  At that point the extent of the device
> specific quirk could be to restrict SBR.
Thanks Sinan/Alex, Agree ACPI _RST is a generic method applicable
to all PCI-ACPI-DEVICE objects. I'll define a new helper function
pci_dev_acpi_reset() and move common code to it. I've one question
before posting a v2 patch, should I call pci_dev_acpi_reset() from
the reset_nvidia_gpu_quirk() or always apply _RST method if exists?

Option-1:
static int reset_nvidia_gpu_quirk(struct pci_dev *dev, int probe)
{
     /* Check for the affected devices' ID range */
     if ((dev->device & 0xffc0) != 0x2340)
        return -ENOTTY;
     return pci_dev_acpi_reset(dev, probe);
}

OR

Option-2
int pci_dev_specific_reset(struct pci_dev *dev, int probe)
{
    const struct pci_dev_reset_methods *i;

    if (!pci_dev_acpi_reset(dev, probe))
      return 0;
    ...
}

>    It'd be useful to know what
> these devices are (not in pciids yet), why we expect to only see them in
> specific platforms (embedded device?), and the failure mode of the SBR.
These are not plug-in PCIe GPU cards, will exist on upcoming
server baseboards. Triggering SBR without firmware notification
would leave the device inoperable for the current system boot.
It requires a system hard-reboot to get the GPU device back to
normal operating condition post-SBR.
> Thanks,
>
> Alex
>
