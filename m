Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F403E0CF0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 05:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhHED4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 23:56:06 -0400
Received: from mail-bn1nam07on2064.outbound.protection.outlook.com ([40.107.212.64]:4318
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231533AbhHED4G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 23:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNAybr4LWR19O0cdNzdRdcNSPx6zx1gPhAYfUHtEc22ni7xHct/qZbCJsOkjWDj5CD71WAaofdyPAi1TuuvPott6e6XHvcDrcQPO/XL9BrxQV4BupEk/FpE+Q5zP1rz7H4aHY2+AkIEiXbJ9WNSsbRWMW2XniXEboV1/+8cPfkUyOQ2SoeEj7Ok8/m+MfzHa1FF6BDv2XAuQW0tkw6SfGevPgW1pXZV9Musz/ZZk7/iLBWvl+j62AblQWV7A/7pXBpxdFjoIvpN6S91ewOOOSwEmCxG7tQZKeUoXOKut09N1yGzLVxfER6ggjFRkC3nycMZ1Vm9+Ul2pvesFp0Uq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvJC6CkESSLItiM/VQ2fRE/3CmXQ+Q9HMIrYZdk+dnA=;
 b=AEbSIZlT5PKfyg+mIm7V22wwjd7xDxrS+sW/PX6azpdz5uG3RrAZ+W5AC5MyXHN60ZM2TgNNTXeEnjpiNzuR44IPQ+YUFWxidZPe1tQ9TzSbYNuSEe8L9ap2mq3ZBKX2kDytsbHsXutLyTRf91wBmHiK88DaDTe8a2+UpBLlkMalduuFUMFJYPcr9qdcfuQAKfmq+c6tgLWp5SbKu9c5V3RrDq3ZvTTxVKhMM0EqNbVj17GxxI92rXWSoJm11gA7tnkT2NHswE+TuDiTvTWfpsufnFdcP2cm0ll1xWAtdrrxg1a2GhYvzIJwU/R4xdxszB47nnfpJVRFytfUXFDSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvJC6CkESSLItiM/VQ2fRE/3CmXQ+Q9HMIrYZdk+dnA=;
 b=fg8kAveA4b0kaJw+Mb9Ce1EJZHiNjgN5mQlCJzyt40vOXciAngqsuG3Yt6+/ZRgFEqI5a23atdRq36tXIID1ybtOU8/Ek3NqYFtdflIIfdmJJt7jewfWj5Xo8fyItMDtIMO+5oaoLKMg5+xfVmYdTOpQlc0PIe4bo9N63EaxHyBc0fb8gLi9GlH64HTmUahwSBBZpT6l+v3Q24PkfJCf5tWmt3Nhll0AkD+2uaPzsalXhYtwDh59wuZocR0e/Mr/4u46eAKAQjfHMZs0AZF+4K86NzVa2zPbXFacH00xs5Ff/aVUly4W+adZ82LG0gdt8LmBKDjD0CVIsj00m+Kd5Q==
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by MN2PR12MB3583.namprd12.prod.outlook.com (2603:10b6:208:c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 03:55:49 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::41) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Thu, 5 Aug 2021 03:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 03:55:49 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 5 Aug
 2021 03:55:49 +0000
Received: from [10.20.23.47] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 5 Aug 2021
 03:55:47 +0000
Subject: Re: [PATCH v14 5/9] PCI: Allow userspace to query and set device
 reset mechanism
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
 <20210804204201.1282-6-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <81810acc-b3b6-1ca7-4f03-aa3c33b80b40@nvidia.com>
Date:   Wed, 4 Aug 2021 22:55:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804204201.1282-6-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84671f2-f4d2-4c47-af8a-08d957c4e9dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3583:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3583A5A7D51FDEA7FC1DC483C7F29@MN2PR12MB3583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:136;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZhBkOpvEhMmjxll6lKeHcut8bU+hrCWFIk7htgjAiaJY5WHUd4DDK4uIsm7fRP7IzkLUMrghOfJuIaAy9jTgZezlRg/Kw51ADs3ifkB/xlv92SwBprwYImpuMc6SsBTmXsBVznllGi7ftS7emMQyAZHsI254wbYFg45WZoRnmm+plru4aw3oFaQtDn2Lo3tIlqAC63LV5hBsZgEyuz/I3VhXZ+BqDpI5ptFJm2FLE6vxAKF9rXmlz4DRuOar0B/9j+KEDvPuMb3kPSnbrfSLU81q8ZWrkPO+FruS/goM3wm3pDC2FoSrFRYuycs3DUQ8sGxR8mpd7cwRcFew/eXX5HAdu6Y3eTC9qiyczaRuFyj04faw3CEuGDCFNAFZbxxRurLwbZBAI7s/xbyZrbav0eQneg3HzSyscOKesAEAJ9vAMA8ohd6J0uQwJm0Oxc2PMkow5aeNsajTQEcICJhbqxcusjkOOHYkThxim7/GTkR31I3XWMGja808MEgjRWFhDtOb+/5K7M6QgsB0TOgE2Btzab81Vv3vGcbW97ysMk5+mWaYO3luMtBcDw0Kvb4ldsC2MVsj/GFrPQkQKqzQ2zqeqsE3YrsNtidNdiIMtWFVYNnSXUk4/vUReHtzugF6lRQejp3FaALRnmhv9yDBvb4eYorrnZwJL7Lcnp+TRFgWAUkZu3uYp7fNU7dBQY7T3F6RShVZiYHPR9d28VfcDK3GbnRCZHl+wG1G92nDT8=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(26005)(36906005)(8676002)(53546011)(4326008)(31696002)(47076005)(82740400003)(36860700001)(2906002)(316002)(186003)(336012)(8936002)(16576012)(426003)(110136005)(70586007)(86362001)(54906003)(70206006)(2616005)(7416002)(83380400001)(5660300002)(7636003)(82310400003)(36756003)(31686004)(478600001)(16526019)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 03:55:49.6803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84671f2-f4d2-4c47-af8a-08d957c4e9dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

On 8/4/21 3:41 PM, Amey Narkhede wrote:
> External email: Use caution opening links or attachments
>
>
> Add reset_method sysfs attribute to enable user to query and set user
> preferred device reset methods and their ordering.
>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  19 ++++
>  drivers/pci/pci-sysfs.c                 |   1 +
>  drivers/pci/pci.c                       | 116 ++++++++++++++++++++++++
>  drivers/pci/pci.h                       |   2 +
>  4 files changed, 138 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ef00fada2efb..ef66b62bf025 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,25 @@ Description:
>                 child buses, and re-discover devices removed earlier
>                 from this part of the device tree.
>
> +What:          /sys/bus/pci/devices/.../reset_method
> +Date:          March 2021
> +Contact:       Amey Narkhede <ameynarkhede03@gmail.com>
> +Description:
> +               Some devices allow an individual function to be reset
> +               without affecting other functions in the same slot.
> +
> +               For devices that have this support, a file named
> +               reset_method will be present in sysfs. Initially reading
> +               this file will give names of the device supported reset
> +               methods and their ordering. After write, this file will
> +               give names and ordering of currently enabled reset methods.
> +               Writing the name or space separated list of names of any of
> +               the device supported reset methods to this file will set
> +               the reset methods and their ordering to be used when
> +               resetting the device. Writing empty string to this file
> +               will disable ability to reset the device and writing
> +               "default" will return to the original value.
> +
>  What:          /sys/bus/pci/devices/.../reset
>  Date:          July 2009
>  Contact:       Michael S. Tsirkin <mst@redhat.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 316f70c3e3b4..54ee7193b463 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1491,6 +1491,7 @@ const struct attribute_group *pci_dev_groups[] = {
>         &pci_dev_config_attr_group,
>         &pci_dev_rom_attr_group,
>         &pci_dev_reset_attr_group,
> +       &pci_dev_reset_method_attr_group,
>         &pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>         &pci_dev_smbios_attr_group,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8a516e9ca316..994426b2b502 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5132,6 +5132,122 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>         { pci_reset_bus_function, .name = "bus" },
>  };
>
> +static ssize_t reset_method_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       ssize_t len = 0;
> +       int i, m;
> +
> +       for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
> +               m = pdev->reset_methods[i];
> +               if (!m)
> +                       break;
> +
> +               len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
> +                                    pci_reset_fn_methods[m].name);
> +       }
> +
> +       if (len)
> +               len += sysfs_emit_at(buf, len, "\n");
> +
> +       return len;
> +}
> +
> +static ssize_t reset_method_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       int i, m, n = 0;
> +       char *name, *options = NULL;
> +
> +       if (count >= (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       if (sysfs_streq(buf, "")) {
> +               goto free_and_exit;
> +       }
> +
> +       if (sysfs_streq(buf, "default")) {
> +               pci_init_reset_methods(pdev);
> +               return count;
> +       }
> +
> +       options = kstrndup(buf, count, GFP_KERNEL);
> +       if (!options)
> +               return -ENOMEM;
> +
> +       while ((name = strsep(&options, " ")) != NULL) {
> +               if (sysfs_streq(name, ""))
> +                       continue;
> +
> +               name = strim(name);
> +
> +               for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
> +                       if (sysfs_streq(name, pci_reset_fn_methods[m].name))
> +                               break;
> +               }
> +
> +               if (m == PCI_NUM_RESET_METHODS) {
> +                       pci_warn(pdev, "Skip invalid reset method '%s'", name);
> +                       continue;
> +               }
> +
> +               for (i = 0; i < n; i++) {
> +                       if (pdev->reset_methods[i] == m)
> +                               break;
> +               }
> +
> +               if (i < n)
> +                       continue;
> +
> +               if (pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
> +                       pci_warn(pdev, "Unsupported reset method '%s'", name);
> +                       continue;
> +               }
> +
> +               pdev->reset_methods[n++] = m;
> +               BUG_ON(n == PCI_NUM_RESET_METHODS);
> +       }
> +
> +free_and_exit:
> +       kfree(options);
No need to initialize 'options' to NULL if you move label 'free_and_exit) to after kfree().
and also improves the code readability. 

> +       /* All the reset methods are invalid */
> +       if (n == 0 && m == PCI_NUM_RESET_METHODS)
> +               return -EINVAL;

Coding bug, uninitialized variable 'm' reference. It contains garbage value
if the user writes NULL string to 'reset_method'. Bjorn also suggested in v10
discard junk/invalid reset methods and return OK to user in case of errors.

Either remove the above two lines or initialize variable 'm' to zero at the
beginning the function to fix the issue.

> +       pdev->reset_methods[n] = 0;
> +       if (pdev->reset_methods[0] == 0) {
> +               pci_warn(pdev, "All device reset methods disabled by user");
> +       } else if ((pdev->reset_methods[0] != 1) &&
> +                  !pci_reset_fn_methods[1].reset_fn(pdev, 1)) {
> +               pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> +       }
> +       return count;
> +}
>

