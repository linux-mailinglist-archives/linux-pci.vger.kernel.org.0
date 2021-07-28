Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8728F3D951E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhG1SRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 14:17:35 -0400
Received: from mail-dm6nam08on2075.outbound.protection.outlook.com ([40.107.102.75]:43489
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229614AbhG1SRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 14:17:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwBodKWwznISLozseLGnYgabaGC3QbSAhW8XkoyamUwNQItrX+tLn9BAc4dOrp2PqQhHVjg6TzQ/u6hus3Oxz8pr2zGF1iyLRFDhyY/M2FtsT5JIejUlV0hrjMId2OBodkMiVxZuucYfC1Nt/opqOMCuRpo2QtC4sCS0VhnMrRYGgjmGYep+8qWlK3/WDDhxPLycv5hD/P2NHC0XwZWY1uWnvRdF6UfmYJuFBiW92Mrxutss058pbkv50kooDdhMswlW6dVZOpYftZEfVv4TpaiXxYlsbzoOlaBmAv8VXehcK+2jyOocmQGFmETVle1DCchLlU7fpLBDtnuHbUG6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWPH/WnxjjFDAYLV85v/ECVuO3M5OvuMbf4A65dAoQ4=;
 b=D54SswKcvz7WUE3O2vBZMWtcKZVznSXdv/9SYO+CiGX0clPIjW8DmcWbcACygotlQgSFrV7DAfh53MC7VMGT5ZAKL6zFIQtDR77sjQd0ITDxbeiWyrakA5m0v2aN2oKQzIf+jfhpm/AJvge8mBtjFCj3Xy/LO2Ppc0dCJfpkS8M68iA5wDQH+uivG5LqeZH3c0FaBejbnGnZgSq9+45Nb0xPTLUAhH3oqTp9ejLKiTID6sgEvmkWFFsbb6amHlIlLoWzcYZsIJ9XRv91BvxyDqiNZ4oVFFjHHLcXmBuxZw5BSHCuYTCj66NI7i9gbRcPB99m1j4+hlXAwNDqdWk0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWPH/WnxjjFDAYLV85v/ECVuO3M5OvuMbf4A65dAoQ4=;
 b=hPLm0WveP1W0OV+aN5KQl2We1EFde3BlHjJ+ZfOftoqTeOBdO5Jej6TKCGp0NyTWJndIlM2yhfniAS88Dx43jItI/DeXQsyHcp54r+Jg9gHDSG/OiJbNdusMN4kM0N+YOlG2Z8UxAFLiF6mrKsokyHZ2i48rfzVb31byyarglzdCK40YLzViCCRXLwqHFAGibZqvwEsqGznaSNQktfnp/oDSqoaf4JQlSD57JsWJDFzx+cS2jJturX9RpLJ8molslo+WKitcFNyNv6tA3mJsa1J75+t3xLqgZcCUlOuj2q/uD0wCLu0gwqnyOH/8hFxFCWs2n9EVqzkYvxSFjb55Ew==
Received: from DM5PR20CA0025.namprd20.prod.outlook.com (2603:10b6:3:13d::11)
 by DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 18:17:30 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::6) by DM5PR20CA0025.outlook.office365.com
 (2603:10b6:3:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend
 Transport; Wed, 28 Jul 2021 18:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 18:17:30 +0000
Received: from [10.20.23.47] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 18:17:28 +0000
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210728175911.GA835695@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <afaf66ea-2eee-cd16-ede8-095b8b6a6de6@nvidia.com>
Date:   Wed, 28 Jul 2021 13:17:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728175911.GA835695@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dec8192-7ce5-4bc6-22a5-08d951f3f659
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1724AED8CADAD2C593C7950DC7EA9@DM5PR12MB1724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0/SCmDgbcNfFdVHdFCP4uV8qjmQm5JH03EsKp/w6dD1Vv2cl8yfzOuzEH0l1ppEB9GdEXoLOxrKLGv9dMZg2+RsvNLM2OdCduR8Nr27xX4huImxfaeOL/ypkDnq3m67qgySNCvzXa7yjdWiBAtafvVADwdd1oYAI/dJ8pY9nPavyQ/unqldNxwtHHxAz7snaGRvd/37AuiTMxeK7wdlLNqxyY4bzqAe+aCu2ynHM8zub1Y1eaj7wzE2fgLzGm0d9RRYpzKVdWfH7IAFVj0rhKKacaMN6sxyL/zPopN2GBuTwqhRNv6RfmwN2cQXpJYMZ7JjSchjfxxGE7myNz8GxA2KDiz0y2TfFeNiJt+AgDE/gaVgo6+4sohIqbUgL/chp2YI0DnWv7DoxQNCkuYwG3R7kB2veCyru2+i9Cj4nMi79YHg0en1qzYnlvmzr9Hx/+S7VAhnB02gAswOgUsQMx4KtoKSbCcocbTy7QG80yBImVrOBeuzE0MjWXqmaycVydA/ht23lQ7kZnyXPFb+3im1tleiZIuRL7yS+2FDDfONSI3XfiHy/DO06MyW6IVZ2C4riJYXVLruXOTIsE/IhXuFICglhYtRi5uMxDX57LlI5eZl1v0ecovtHun7L4F3aN2nY8KzfzVyCCyq0QR0kz8F3vuAHp4dhB4E3nO6TcTU6jvHlPH1unQ2xYRHIdjNiYAcMwFWa+2uA93L8H3bE5d0g1S1jM98lvk8UiB7u6k=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(53546011)(426003)(70206006)(70586007)(8936002)(82310400003)(86362001)(83380400001)(31686004)(36860700001)(110136005)(4326008)(508600001)(8676002)(186003)(7416002)(336012)(16526019)(54906003)(7636003)(31696002)(2906002)(26005)(36756003)(5660300002)(356005)(2616005)(16576012)(296002)(47076005)(316002)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 18:17:30.0535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dec8192-7ce5-4bc6-22a5-08d951f3f659
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/28/21 12:59 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jul 28, 2021 at 11:15:19PM +0530, Amey Narkhede wrote:
>> On 21/07/27 05:59PM, Bjorn Helgaas wrote:
>>> On Fri, Jul 09, 2021 at 06:08:07PM +0530, Amey Narkhede wrote:
>>>> Introduce a new array reset_methods in struct pci_dev to keep track of
>>>> reset mechanisms supported by the device and their ordering.
>>>>
>>>> Also refactor probing and reset functions to take advantage of calling
>>>> convention of reset functions.
>>>>
>>>> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
>>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>>> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>>>> ---
>>>>  drivers/pci/pci.c   | 92 ++++++++++++++++++++++++++-------------------
>>>>  drivers/pci/pci.h   |  9 ++++-
>>>>  drivers/pci/probe.c |  5 +--
>>>>  include/linux/pci.h |  7 ++++
>>>>  4 files changed, 70 insertions(+), 43 deletions(-)
>>>>
>> [...]
>>>> + BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
>>>>
>>>>   might_sleep();
>>>>
>>>> - rc = pci_dev_specific_reset(dev, 1);
>>>> - if (rc != -ENOTTY)
>>>> -         return rc;
>>>> - rc = pcie_reset_flr(dev, 1);
>>>> - if (rc != -ENOTTY)
>>>> -         return rc;
>>>> - rc = pci_af_flr(dev, 1);
>>>> - if (rc != -ENOTTY)
>>>> -         return rc;
>>>> - rc = pci_pm_reset(dev, 1);
>>>> - if (rc != -ENOTTY)
>>>> -         return rc;
>>>> + for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
>>>> +         rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
>>>> +         if (!rc)
>>>> +                 reset_methods[n++] = i;
>>> Why do we need this local reset_methods[] array?  Can we just fill
>>> in dev->reset_methods[] directly and skip the memcpy() below?
>>>
>> This is for avoiding caching of previously supported reset methods.
>> Is it okay if I use memset(dev->reset_methods, 0,
>> sizeof(dev->reset_methods)) instead to clear the values in
>> dev->reset_methods?
> I don't think there's ever a case where you look at a
> dev->reset_methods[] element past a zero value, so we shouldn't care
> about any previously-supported methods left in the array.
>
> If we *do* look at something past a zero value, why do we do that?  It
> sounds like it would be a bug.
>

I think either we need memset or clear 0th/last element. Can we set the last
index explicitly to zero?

void pci_init_reset_methods(struct pci_dev *dev)
{
        int i, n, rc;

        BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);

        might_sleep();

        n = 0;
        for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
                rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
                if (!rc)
                        dev->reset_methods[n++] = i;
                else if (rc != -ENOTTY)
                        break;
        }
        dev->reset_methods[n] = 0;
}





