Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5753DEF38
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhHCNqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 09:46:02 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:60737
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232748AbhHCNqB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 09:46:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG52myjMyMXKt03eNG6oBc3+voxNYS48p9NmXR4LdXSyYl4iDU491M/VPowlrpWzvUYjJPgOfTEJlP1G7Po6DfpHiVcPmi9C3r6AzadCp4fpexJUvRT9EtI5rg2DOWX/JiIlQAWvBSF72HxpS6D6oERyE2FhbM3WwnX5wBt8a6Gemah2++aLjU5I7AqdTviHjd3kGEq8b/EXRC8pr3vdryIpDL8NR+nwJs55HGHah9QlfiZoSJ9vORNGwPrcvf9Lijv2mac4y2vXKL97qkJmBx7h51VhzTTMywW6jHItQxXpqobFWvVed5rZZ4qoFD+A1H/m1j3+s9aPzb4KSJFsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOK3AQPqCDwxTiIlBBo9JJR9mv4mxXVJjXJMI5iOHww=;
 b=V3+ATnZfsKjChEza+TysYTKCz42PPaL5p7HVt8rl2yGieDuUvBxJhDSmEKzRH2mFVvSIWCX4/k+HX/ICgb8ZyPsws7LiXlk1mEj3XiQqZC26bbfAbp/mZz/a+dvCedg69PcYBoFViUIfhA8YMtLQ+GudGTQQokq1uSvZkNyyRaI1q3G5Ny6OdT59QzLUjZqlwg98qqba3sIAf3fsq1vhflmFyXAMwENHKQJEAEu9aLmjboUJh7pYZOUSBfon4AZMPp8+Nmx5fzeJEwhHcZxixprN9NWpT6yC85T0QbnkikzP5VP7WFAwGFMy/eWbEafSuO/5M5eksh5FvlbvAm1kvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOK3AQPqCDwxTiIlBBo9JJR9mv4mxXVJjXJMI5iOHww=;
 b=ajzgl/kfhSXOgAP8ikEd5Ss9gTnOnKkYOCHp0QZYx5QhODM+yBLpHU7+WWjuq1x78LGJNRDqpCQN7hnvOSUxgeP8iDU0b4qKGuk4qz2mjmbteuUwpu84gUDTC9pqFqmHOk/BPWIOA/lnMxP8CCyCBMVfofxEszaSgWSrufJaKs+AAGCcVKnerxshMbBc1fwKSYs9bBXZMRtQp0adLxuqfpgOcMgb3qaBLi/IpbAQLuergHGkFsM6dlI/1aQYPdRGz9EAeg7Se3Nv8lhfLqX88elwEd5dqixnPpbwHe50wRZzQzLEsSyIvUHSk/GXbl4xrEM+EJVyBlLhoTo4wc2EwA==
Received: from MW4PR04CA0281.namprd04.prod.outlook.com (2603:10b6:303:89::16)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 13:45:49 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::11) by MW4PR04CA0281.outlook.office365.com
 (2603:10b6:303:89::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 3 Aug 2021 13:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 13:45:48 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 13:45:48 +0000
Received: from [10.20.23.47] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug 2021
 13:45:46 +0000
Subject: Re: [PATCH v13 5/9] PCI: Allow userspace to query and set device
 reset mechanism
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210801142518.1224-1-ameynarkhede03@gmail.com>
 <20210801142518.1224-6-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <b3a5aef9-45ba-5f61-a756-c024c3a728ad@nvidia.com>
Date:   Tue, 3 Aug 2021 08:45:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210801142518.1224-6-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c5e96ee-2c02-4003-4d17-08d956850064
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2779909231BB7B50609F6BACC7F09@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hU310r+v7gUUzVyA1Cwp5qTxu6nM4+2AySphZfTXyWDdvzxbT8gqxUC/BKwEQO4mNm06znCOg539mXo9yGRnMU9y5vTjFbvM0W1CBNP3jZYKEph8T3lL64GKhmlVi2PiR+Gkc37leBWfHXKIw7uVjZZe0XaKiSbKsmv+xjBwdkL1X38DcvKd14sNTvWp62S1fdDKRB+C0ouv9noNmgV1GHVwU54N7NaxbBm4xP+PTh7m6M7Q9UlOJRdWmRfeKHwcXOLinKCKqg4J2vl8iLO8b875aoR9LhM5f5NKjQ7tpoK3t7vV37Q+92+nv/DynOiM4I32ldd1q4SSQFWyEivhQ3eig0SbibFTEmP8gXwL1t1eRF5wqMLAocIUDsIl1zIEbfuvyo3WmlyRhWh/pwHpTn8iouR601cL5pnJzhYL6KOWmAwotuLmUyrlJy8QEW/qM/KBHi6FmB25mm5TlqOsIxM9h+REOUijqsDBn/y0sLuUF0zt5i5qeqNYx8dvaHcMiuzvkRf631wUFFEiCBB2a6Q6MU8yQb6INIO5yGAaPEYnceOIgFWJLohWHoI2U0sNqi6KtTGrPIn1uHb0Jwu0QaNHqHrxKkpITHb/tYPN2jaCOTolZMDbP9Qy5N1vm/dBm0YP6S91xCAJwFwm1xCKWW+gd8FF2N4FsoSPQ/i8i62L4wZm7+cNb3Ff9ddre4h1Btm3OAWqSMsbrL6MhqXxpmTuyjprMG2q6D9nDyC6vuc=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(86362001)(2616005)(2906002)(82740400003)(7636003)(82310400003)(36756003)(47076005)(54906003)(31696002)(53546011)(83380400001)(426003)(110136005)(26005)(7416002)(356005)(16576012)(316002)(186003)(36906005)(31686004)(478600001)(16526019)(70206006)(70586007)(336012)(5660300002)(4326008)(8676002)(8936002)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 13:45:48.5728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5e96ee-2c02-4003-4d17-08d956850064
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/1/21 9:25 AM, Amey Narkhede wrote:
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
>  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
>  drivers/pci/pci-sysfs.c                 |   1 +
>  drivers/pci/pci.c                       | 105 ++++++++++++++++++++++++
>  drivers/pci/pci.h                       |   2 +
>  4 files changed, 127 insertions(+)
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
> index 932dd21e759b..c496cd164aca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5132,6 +5132,111 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>         { pci_reset_bus_function, .name = "bus" },
>  };
>
> +static ssize_t reset_method_show(struct device *dev,
> +                                struct device_attribute *attr,
> +                                char *buf)
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
> +       int i = 0;
> +       char *name, *options = NULL;
> +
> +       if (count >= (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       if (sysfs_streq(buf, "")) {
> +               pdev->reset_methods[0] = 0;
> +               pci_warn(pdev, "All device reset methods disabled by user");
> +               return count;
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
> +               int m;
> +
> +               if (sysfs_streq(name, ""))
> +                       continue;
> +
> +               name = strim(name);
> +
> +               for (m = 1; m < PCI_NUM_RESET_METHODS && i < PCI_NUM_RESET_METHODS; m++) {
> +                       if (sysfs_streq(name, pci_reset_fn_methods[m].name) &&
> +                           !pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
> +                               pdev->reset_methods[i++] = m;
> +                               break;
> +                       }
> +               }
> +
Checking reset method logic isn't optimized, iterating through all entries if the
device doesn't support a requested method.

Something like this:
        for (m = 1; m < PCI_NUM_RESET_METHODS && i < PCI_NUM_RESET_METHODS; m++) {
                if (!sysfs_streq(name, pci_reset_fn_methods[m].name))
                        continue;
                if(!pci_reset_fn_methods[m].reset_fn(pdev, 1))
                        pdev->reset_methods[i++] = m;
                break;
        }

I think we should avoid duplicate entries in pdev->reset_methods.
Example:
   root# cat reset_method
   acpi flr bus

   root# echo "acpi flr bus flr" > reset_method
   root# cat reset_method
   acpi flr bus flr




> +               if (m == PCI_NUM_RESET_METHODS) {
> +                       kfree(options);
> +                       return -EINVAL;
Set the last entry to zero in pdev->reset_methods otherwise the inconsistent
methods are enabled.
Example:
   root# cat reset_method
   acpi flr bus

   root# echo "flr a" > reset_method
   root# cat reset_method
   flr flr bus

> +
> +               }
> +       }
> +
> +       if (i < PCI_NUM_RESET_METHODS)
> +               pdev->reset_methods[i] = 0;
> +
Last entry can be set unconditionally after removing the duplicate entries.
Refactored code to filter duplicate entries and warn the user about the invalid
& unsupported reset methods.

static ssize_t reset_method_store(struct device *dev,
                                  struct device_attribute *attr,
                                  const char *buf, size_t count)
{
        struct pci_dev *pdev = to_pci_dev(dev);
        char *name, *options = NULL;
        int i, m, n = 0;

        if (count >= (PAGE_SIZE - 1))
                return -EINVAL;

        if (sysfs_streq(buf, ""))
                goto done;

        if (sysfs_streq(buf, "default")) {
                pci_init_reset_methods(pdev);
                return count;
        }

        options = kstrndup(buf, count, GFP_KERNEL);
        if (!options)
                return -ENOMEM;

        while ((name = strsep(&options, " ")) != NULL) {
                if (sysfs_streq(name, ""))
                        continue;
                name = strim(name);

                /* Validate reset method */
                for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
                        if (sysfs_streq(name, pci_reset_fn_methods[m].name))
                                break;
                }
                if (m == PCI_NUM_RESET_METHODS) {
                        pci_warn(pdev, "Skip invalid reset method '%s'", name);
                        continue;
                }

                /* Check if the reset method is already enabled */
                for (i = 0; i < n; i++) {
                        if (pdev->reset_methods[i] == m)
                                break;
                }
                if (i < n)
                        continue;

                /* Probe the requested reset method */
                if (pci_reset_fn_methods[m].reset_fn(pdev, 1))
                        pci_warn(pdev, "Unsupported reset method '%s'", name);

                pdev->reset_methods[n++] = m;
                BUG_ON(n == PCI_NUM_RESET_METHODS)
       }
        kfree(options);

done:
        pdev->reset_methods[n] = 0;
        if (pdev->reset_methods[0] == 0) {
                pci_warn(pdev, "All device reset methods are disabled");
        } else if ((pdev->reset_methods[0] != 1) &&
                   !pci_reset_fn_methods[1].reset_fn(pdev, 1)) {
                pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
        }
        return count;
}



