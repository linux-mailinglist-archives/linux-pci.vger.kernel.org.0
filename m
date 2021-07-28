Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9591E3D9591
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 20:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhG1SyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 14:54:24 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:7369
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229542AbhG1SyY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 14:54:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu2hmM2yMLWlgLi+U4DadOqpAXyh/3AKvFQGxktUXhtb9IdZGfLDHxKw82jfFjhMY/O9lbmxKISPDduTJekd2fCAFwI/7mBt7mUg+KM3S2gB62e0y1xyCuGyYeEMjMiknh366NOHf02PiYpsx7e3OBMXgZeev7hDm/yGB1BNx2llbFY7NA1PRunCggq2s/BDOHq6sf7aGjP0JxykPmV8h6BoL2u9S/68vzzl70hGBYAxLqwXMxnw3bCQzIdEXF1ZtRcMX4wrWoa3vAeIPr3FLU3FAnsaFAB/rqSc5aW6Hz4Tz2OVP46d4GzQ6x9kRcz4nEt+rta22zjB3FXMI9sjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT7bii2gOsKJA1EDCAJp9j5fqawNn/p1wHRxU4c8378=;
 b=kpKKBtryinHntSxh+RpLdycN72MrqImYB4LGON6uRiJTK3FpF+2JLnt0vasfoBF4cqoCjMFW+nJJo/PVyO4rOKTme7mmXz2DN0pmZPd7ZGGaYBDpo6FGG/LxoEo5o+d9ZM6TOJc+yp8NqyrvrJ/VGHPbsZw0M7qjX/3bU/3AdCeecnxJparc+znBI4eclu1fTJka3AE9a8ix8wZem/xBMTA+ly5wR3zbHM/K8mdYjMqxhy2hwKm0Y5ppNUgb9BZd3/LLnJ5HaKYgKlKDo6xhHUU089Lu5EJqENAi4sWq+fdkIn6Qk7dCxraXO1i8eXL3jMWdMMHoCiRqq31uBAfLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT7bii2gOsKJA1EDCAJp9j5fqawNn/p1wHRxU4c8378=;
 b=gubFP+4gWP8Q4M9NZFfjT3KPItgKztdxXzhRQT0MzszWm8kmAriI85deNEzfq+7AQgq4KZcqfC3z2B/b6hIfI76OMNoSoYUF8+2SNvgTEnzqLVbAK/nljn5vvzsjhA5j44V7mc/+yl8glmXCRbyY1/HQZKxoWSNhdttfacfUdrbq8kvnDXIjC+xq58kaem6Zz1azAM6fnIbViqqy9ksOXADZirczTwi3QcnEihcZDLbQyazs8S0yLC1hXFkuQ23Um/XXUDKBa6AbeCua03Z17vUcPw5VW0nYjGz9tdvkj0FhNNZjDeCt+a1e9F9oRd+Xl+doPXncWhMRIUm7+/buUA==
Received: from DM6PR06CA0070.namprd06.prod.outlook.com (2603:10b6:5:54::47) by
 MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17; Wed, 28 Jul 2021 18:54:20 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::55) by DM6PR06CA0070.outlook.office365.com
 (2603:10b6:5:54::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Wed, 28 Jul 2021 18:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 18:54:20 +0000
Received: from [10.20.23.47] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 18:54:18 +0000
Subject: Re: [PATCH v10 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210727221229.GA750669@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <709c80db-3420-917d-31de-a5161aaf30ac@nvidia.com>
Date:   Wed, 28 Jul 2021 13:54:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727221229.GA750669@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8792a8a-dfc1-4ca0-ed2e-08d951f91bf0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4540:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4540695E44B16F2B41825F55C7EA9@MW3PR12MB4540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TUmesAfkzifa1XsBQ1WLSDIrh2ExXQFiNyGlZisU6aFxtNGitpCla3NqACuposQTM4YmF0Zyv/1dGoH62NdVuqYFXZ/ZQ+ftsrdxsyEIX3AVtsaCYEBK75Jno18ufXgaCJY6FIPANKW6VL26+mHX+yBlptagqbVjP3OwTpgXMw0nUSLR1MGqRnCSPFISLLa5MIbAsH2aEriabSZN1uwrq2c0gn58wOQmRl7vcj+YWWFYk1PwIGJ3IXYWlRqfPfLXEQ3/R9JR3kIj53YrUcBMDLxXS9EoaS4iyril/VeuqB7oIZ698S48D/BCxKiOc/qIDvaAZ845z4LxtTCoDEIFVRDRzQNUcJtiQjKfaM5AH9XlNmy2XOt01kKwBk3Mtrzn79Do3pEEnerOd2SKn/tgW5lX2WficZdwpkfElLUk1G4O/h3bxP3ea3OQLlX5m39FPRqdQ1ahONU8UGZAM8YgzbtJ94X6g6Tw9N2LLDS8oXxufOo58kuvL/E/C58DiPZHrduE0HY0OxhqUBiS/UWQsg56b6dE5/NcHL+Gg3nmal6/tBfPfuhcAuj9lRTTPvVTc0jl7uykHWI5bZAbqqoXdH3zJ63BIklJHeyMp2Y1Ud+fwDl0wqOl0+bS2NkebFX8mo1kJBDy561nxqq+jQKqS1nakzLsoTF9IsIEs9BrPfFI1E1LV8duvqrKBxrc3bVPOtlEb1Ir8R9NBH11r83xIY8UY9vuS43Pah0os/60Ude+u2vbl+CnDKolnmcVr8partaYp5FRQMN2mCcSImX7Wr43aKLKVh7xQmcc+q/oXU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(110136005)(47076005)(186003)(426003)(54906003)(356005)(336012)(82310400003)(5660300002)(36860700001)(16526019)(36906005)(83380400001)(16576012)(4326008)(316002)(70586007)(8676002)(7636003)(26005)(53546011)(86362001)(70206006)(8936002)(478600001)(82740400003)(31696002)(7416002)(31686004)(2906002)(36756003)(2616005)(21314003)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 18:54:20.6117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8792a8a-dfc1-4ca0-ed2e-08d951f91bf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/27/21 5:12 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Jul 09, 2021 at 06:08:06PM +0530, Amey Narkhede wrote:
>> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
>> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
>>
>> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
>> is supported by the device which does not match the calling convention
>> followed by reset methods which use second function argument to decide
>> whether to probe or not. Add new function pcie_reset_flr() that follows
>> the calling convention of reset methods.
>>
>> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>> ---
>>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>>  drivers/pci/pci.c                          | 59 +++++++++++-----------
>>  drivers/pci/pcie/aer.c                     | 12 ++---
>>  drivers/pci/probe.c                        |  6 ++-
>>  drivers/pci/quirks.c                       |  9 ++--
>>  include/linux/pci.h                        |  3 +-
>>  6 files changed, 45 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
>> index facc8e6bc..15d6c8452 100644
>> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
>> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
>> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>>               return -ENOMEM;
>>       }
>>
>> -     /* check flr support */
>> -     if (pcie_has_flr(pdev))
>> -             pcie_flr(pdev);
>> +     pcie_reset_flr(pdev, 0);
> I'm not really a fan of exposing the "probe" argument outside
> drivers/pci/.  I think this would be the only occurrence.  Is there a
> way to avoid that?
>
> Can we just make pcie_flr() do the equivalent of pcie_has_flr()
> internally?
>
I like your suggestion don't change the existing definition of pcie_has_flr()/pcie_flr()
and define a new function pcie_reset_flr() to fit into the reset framework. This way
no need to modify logic/drivers outside of driver/pci/xxx.

int pcie_reset_flr(struct pci_dev *dev, int probe)
{
        if (!pcie_has_flr(dev))
                return -ENOTTY;

        if (probe)
                return 0;

        return pcie_flr(dev);
}


And add a new patch to begging of the series for caching 'devcap' in pci_dev structure.

--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -333,6 +333,7 @@ struct pci_dev {
        struct rcec_ea  *rcec_ea;       /* RCEC cached endpoint association */
        struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
+       u32             devcap;         /* Cached PCIe device capabilities */
        u8              pcie_cap;       /* PCIe capability offset */
        u8              msi_cap;        /* MSI capability offset */
        u8              msix_cap;       /* MSI-X capability offset */


--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include "pci.h"

 DEFINE_MUTEX(pci_slot_mutex);
@@ -4630,13 +4631,10 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 bool pcie_has_flr(struct pci_dev *dev)
 {
-       u32 cap;
-
        if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
                return false;

-       pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-       return cap & PCI_EXP_DEVCAP_FLR;
+       return !!FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap);
 }

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -19,6 +19,7 @@
 #include <linux/hypervisor.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
+#include <linux/bitfield.h>
 #include "pci.h"

 #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
@@ -1498,8 +1499,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
        pdev->pcie_cap = pos;
        pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
        pdev->pcie_flags_reg = reg16;
-       pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
-       pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+       pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
+       pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);

