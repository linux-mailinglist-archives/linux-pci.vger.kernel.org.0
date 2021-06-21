Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAC3AEBEA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 17:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUPEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 11:04:37 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:11187
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229747AbhFUPEh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 11:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt/kkgofD4Ao59f4xpYPAwRjT0iQwkV4KcmdLZNv/2ARQFDG8a8qTLFQCzIVrEemdOyXxBXZI/dEq/qdtBzM+ourV+XDDICoU0Vzymb/vNngrFGaoC1lxHhY+XVc40uD0H2jQ1z9xuq3Npd7S2gNZuI4Abft2aBZx4hZIb/NF3uDMJt970ciMJe4J+GH6a4Ygrqw5YUFN4FdyUbqHgoX7XdCnvY7jzsUikkMlr53F4ZDOXayh2OLDj9I28IaRefvCv1rYZRIeMGnuJmuVFvKicJ8oTAN5iZJxGMKCARpg2G5Fjj1i8ZuWm0jkB3rx6j7Jw+i5BHYFxh1z56w5GPgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC5W2jPnJXLF13B3RZOEIkbI6c3gJOmbyYjIswtU3wo=;
 b=FkNUb0U+44aIBM4n+JoXhcWpL6S4nhRdwrf2NUk/H9ROpBoIcinq0YKCBc/vXj100tva/1BwbK33mB3B2wwcIRVZsIJUKF/7IFAofYcEy1Q/MUOl0MqMRm4hm7lmpZyIVSXePC1WDT2YMuReRQH7GQ+QsF7wOqd2nXpi6zHRbnGOYvGnZsUG7qwow1sq0BuSW7Z8sOzRutQLyYBuqpHX8wBVpDyi9opld0ef5WXPS5UhqHTs4KQXxGs/RUk2iOsJbOYcys2/b1VW7/9XMBd9tcJ8Tn2uxiHkCXhreVcXTL99hdd+Y/6+lGoafZerMo2ry5oV6DCsoWMwXAJSz7f8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC5W2jPnJXLF13B3RZOEIkbI6c3gJOmbyYjIswtU3wo=;
 b=eCblXx60AKr8IMJ8l3+hgS1WZGYR85ZLQr8/mALpYkPYnfnTYaBKCVOD0tsrN0xsU89EsJzpJO3J2sbDlzzdaGDI9b4GAfUVkHreGHrZT2fT4LekqQRy3Eyn/ZM5jNmbGf/KrYYR5tvVgf0euQ8myx1GBPRdJkgbXzV37co7ob6bQKWsWCgvdBq7+63f1TmHiguyFYDtVSzYBS0SF6EM/u0vJBKUFjilNxVTYMh6MA66dHn12DsSlG0kr5c+6jYs6TidO7u5JDx5vkT3vZL8EtzDofPSUBTvGRUtD/UiBaS+BM/PMLe+r/XB7lZO+KEdhh+VYm3GhUaoG1Z5s7jfnA==
Received: from BN8PR15CA0039.namprd15.prod.outlook.com (2603:10b6:408:80::16)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 15:02:21 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::f6) by BN8PR15CA0039.outlook.office365.com
 (2603:10b6:408:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 15:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 15:02:21 +0000
Received: from [10.2.55.109] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 15:02:20 +0000
Subject: Re: [PATCH v7 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210608054857.18963-3-ameynarkhede03@gmail.com>
 <20210617231305.GA3139128@bjorn-Precision-5520>
 <20210618172242.vs3qwimjpcicb4m4@archlinux>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <1fb0a184-908c-5f98-ef6d-74edc602c2e0@nvidia.com>
Date:   Mon, 21 Jun 2021 10:02:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210618172242.vs3qwimjpcicb4m4@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab3dba6-47af-42ae-4714-08d934c59242
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53510A31E417B47DF770995FC70A9@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEKMLCrdLhzTGhifpES4xPfhbVRcADVONVvaWTU52gdJn4MtdpshZ4IKH1vyou50qjyLTRQ+1zGS0onWs3e1U3UJS+ALiXfx8rNVRlG7t9g82Sog0dfoQUroJbapsdDSoeRgw4mDbHs9b8d8u+sdcN5O528aMOO3cbVs+qV6Q2ZebtJzDOxoCVY7J7p8qXmzYGsjxV9Gi4LTDshqL8yPzYiPLsmgHRqAPps2miHLvGEjURTO7ZQVIv47lCuie1Xgg9yPWrSDTSd3lWSZgN4YcRUxoSswSGwZ1WbVpJf9AWuuaVz4INQOodG/zMOaOe1hRGHhOFBLKO8Bq63f94U9yKayeBy4mP+JyUXysacn6S4F7s/mVdZd4fgAalvDwvJ3YNbTMNb8TYY9pDew0F8di0F78EN0yClYyCdDyEATTxOlPkoXwoOQzjz8zP7vLaEwUjG+vHPxhscJyY4dmx7u+j15tkZmznb6LphpNQ8RQBKDcZqNoTgBfKIxZBCk2hXmtk0yufmVWgjtBkdTLrPbVzC8FZlTw+tevsR0vPZROqWT7bd5O6gYq4sIFh9pYUszkLlF/6sxR+a1kPdsDoELFHXzKUbf5OJqW/6iZLbN173jAkQrBPmf6ii3VlFMftCAOK+UIno88Ac5FWHnGgm78zOyJU3MxTNJIyUbW/f/sE96liAJhEeAQLBGF/ZvGAXTEzLk/MO0xwrQRyrBm5S8RA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(478600001)(53546011)(36860700001)(2906002)(47076005)(26005)(83380400001)(82310400003)(31686004)(5660300002)(186003)(16526019)(8676002)(31696002)(36906005)(36756003)(70586007)(70206006)(316002)(296002)(86362001)(426003)(6666004)(82740400003)(110136005)(54906003)(336012)(4326008)(8936002)(356005)(16576012)(2616005)(7416002)(7636003)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 15:02:21.3826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab3dba6-47af-42ae-4714-08d934c59242
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/18/21 12:22 PM, Amey Narkhede wrote:
> I wonder if this would be easier if dev->reset_methods[] contained
> indices into pci_reset_fn_methods[], highest priority first, with the
> priority being determined when dev->reset_methods[] is updated.  For
> example:
>
>   const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>     { },                                                     # 0
>     { &pci_dev_specific_reset, .name = "device_specific" },  # 1
>     { &pci_dev_acpi_reset, .name = "acpi" },                 # 2
>     { &pcie_reset_flr, .name = "flr" },                      # 3
>     { &pci_af_flr, .name = "af_flr" },                       # 4
>     { &pci_pm_reset, .name = "pm" },                         # 5
>     { &pci_reset_bus_function, .name = "bus" },              # 6
>   };
>
>   dev->reset_methods[] = [1, 2, 3, 4, 5, 6]
>     means all reset methods are supported, in the default priority
>     order
>
>   dev->reset_methods[] = [1, 0, 0, 0, 0, 0]
>     means only pci_dev_specific_reset is supported
>
>   dev->reset_methods[] = [3, 5, 0, 0, 0, 0]
>     means pcie_reset_flr and pci_pm_reset are supported, in that
>     priority order
What about keeping two bitmap fields 'resets_supported' and 'resets_enabled' in
pci_dev object and mange it through sysfs and probe helper function. We can avoid
two loops multiple paces and takes only 2Bytes of memory to keep track resets.

resets_supported  ---> initialized during pci_dev setup
resets_enabled ---> Exposed to userspace through sysfs by default set to resets_supported

include/linux/pci.h:
------------------------
/* Different types of PCI resets possible, lower number is higher priority */
#define PCI_RESET_METHOD_DEVSPEC     0
#define PCI_RESET_METHOD_ACPI            1
#define PCI_RESET_METHOD_FLR              2
#define PCI_RESET_METHOD_Af_FLR         3
#define PCI_RESET_METHOD_PM               4
#define PCI_RESET_METHOD_BUS             5
#define PCI_RESET_METHOD_MAX            6

struct pci_dev {
    ...
        u8              resets_supported;
        u8              resets_enabled;
};

static inline bool pci_reset_supported(struct pci_dev *dev)
{
        return !!(dev->resets_supported);
}


drivers/pci/pci.c:
--------------------
const struct pci_reset_fn_method pci_reset_fn_methods[PCI_RESET_METHOD_MAX] = {
        [PCI_RESET_METHOD_DEVSPEC] = { &pci_dev_specific_reset,
                                                                   .name = "device_specific" },
        [PCI_RESET_METHOD_ACPI] = { &pci_dev_acpi_reset, .name = "acpi" },
        [PCI_RESET_METHOD_FLR] = { &pcie_reset_flr, .name = "flr" },
        [PCI_RESET_METHOD_Af_FLR] = { &pci_af_flr, .name = "af_flr" },
        [PCI_RESET_METHOD_PM] = { &pci_pm_reset, .name = "pm" },
        [PCI_RESET_METHOD_BUS] = { &pci_reset_bus_function, .name = "bus" }
};


void pci_init_reset_methods(struct pci_dev *dev)
{
        int i, rc;

        BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_RESET_METHOD_MAX);
        might_sleep();

        for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
                rc = pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_PROBE);
                if (!rc)
                        dev->resets_supported |= BIT(i);
                else if (rc != -ENOTTY)
                        break;
        }
        dev->resets_enabled = dev->resets_supported;
}

int __pci_reset_function_locked(struct pci_dev *dev)
{
        int i, rc = -ENOTTY;

        might_sleep();

        for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
                if (dev->resets_enabled & BIT(i)) {
                        rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
                        if (rc != -ENOTTY)
                                return rc;
                }
        }

        if (rc == -ENOTTY)
                pci_warn(dev, "No reset happened reason %s\n",
                         !!dev->resets_supported ?
                         "disabled by user" : "not supported");

        return rc;
}

drivers/pci/pci-sysfs.c
----------------------------
static ssize_t reset_method_store(struct device *dev,
                                  struct device_attribute *attr,
                                  const char *buf, size_t count)
{
        struct pci_dev *pdev = to_pci_dev(dev);
        u8 resets_enabled = 0;
...
        if (sysfs_streq(options, "default")) {
                pdev->resets_enabled = pdev->resets_supported;
                goto set_reset_methods;
        }

        while ((name = strsep(&options, ",")) != NULL) {
                if (sysfs_streq(name, ""))
                        continue;
                name = strim(name);

                for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
                        if ((pdev->resets_supported & BIT(i)) &&
                            sysfs_streq(name, pci_reset_fn_methods[i].name)) {
                                resets_enabled |= BIT(i);
                                break;
                        }
                }
...
        }

set_reset_methods:
        kfree(options);
        pdev->resets_enabled =  resets_enabled;
        return count;
}

static ssize_t reset_method_show(struct device *dev,
                                 struct device_attribute *attr,
                                 char *buf)
{
        struct pci_dev *pdev = to_pci_dev(dev);
        ssize_t len = 0;
        int i;

        for (i = 0; i < PCI_RESET_METHOD_MAX; i++) {
                if (pdev->resets_enabled & BIT(i))
                        len += sysfs_emit_at(buf, len, "%s%s",
                                             len ? "," : "",
                                             pci_reset_fn_methods[i].name);
        }
        len += sysfs_emit_at(buf, len, len ? "\n" : "");

        return len;
}

