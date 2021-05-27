Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3238C3934A6
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhE0RWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 13:22:25 -0400
Received: from mail-sn1anam02on2073.outbound.protection.outlook.com ([40.107.96.73]:26062
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234431AbhE0RWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 13:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrVNcrrbEHLx2snraAuxtR5sZkpPTgb/dgXiB7YRQVVZM5R+vXd5X0vcEdv29aawVYvE/mnLyr3ldaITEccUZfZqcB6MnxUioWS2Kq2exMWU8+wOMG6TCABmuZv2Nnxh/DRIQ1dpqtAxTquUphEZygCVQZJu4GObUbJ+d5YDbRmFP/V9PVQg5l5YPcIG6cKUPnGx8/BamZTJOTfGh1pVFdN7g/vB/CY8Pyc1ILwnFje5z7Nlg3EsNKkX8EAjurDWmcFR303g1bJNhdEVIDDAt/KQSRTAcS/dexJIB8FxhmdZxEcCzKnhkPCjXt8MyMuhcfCzWjx9fBIpSLo0d3i4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sg5W0LdajdqyFfQ82iBS4qfVwWWE9/iUMCDgW0Phzg=;
 b=OtffGH0pwzcS0p1duNXBEEdRusMpF4iIiH8m+hZh3e2fTKkHGsnij2tRdsH77LOnI1yUpJonyqZ9Xw9yODf0eV+KbpYA0fy9qA1jGV4WRri39S5dS17fErkjX7mfgS0csE93YzPnxMs/4W30yiEilt1WlNhk5tqdA6Nx3Kjob9P8NNZOHa1MiMkjWqw72fQzZkRVldAqvbB3MDHpTI6ntBiK1mdxE8SXOKCWAOef1/1syIRgfD3ktM0QJTBwKq69awBI6bzpnzSASpSkgvbmdWy+GN1kUO2kGSgWZqKp8B5pXS2UoJXHqP9DLl054IUiPPjXIb5vXwDm+nJZvDkapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sg5W0LdajdqyFfQ82iBS4qfVwWWE9/iUMCDgW0Phzg=;
 b=Nz9UaexME0vGWOht7JgnQR3Yxfu6KRhMwdAHpO5gFThMV4zdyRhsElXlGFn2HNHblB6V2Ij/nk92Xm+2nIZguhR0uzcE/QDHHZedQVVevXTATGeK5VxfD+BQrDk1rjiKt21lk84+Xv+l7FOCzy64NAZwbi2DvS5Rg4QY8R1u64HLzgqwLNk3Tghwre7e5NSCkTIj/QkSzpgpROTHPYnY3kjB+u1Aq1R+bnHe6RuulhBSH21ynzRMNd25qnnHxDvSeEEYYzVMTRz+qB71tlsBW12vqoze7/yPVQn6V09+0Nk0BQpfHWzhM+IMPsesa/ERz8tvHXyg/12tya2JPs80gA==
Received: from DM6PR06CA0053.namprd06.prod.outlook.com (2603:10b6:5:54::30) by
 CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Thu, 27 May 2021 17:20:49 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::6c) by DM6PR06CA0053.outlook.office365.com
 (2603:10b6:5:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 17:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 17:20:49 +0000
Received: from [10.25.75.220] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 17:20:45 +0000
Subject: Re: [PATCH 2/3] PCI: debugfs: Add support for RAS framework in DWC
To:     Shradha Todi <shradha.t@samsung.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>,
        <p.rajanbabu@samsung.com>, <hari.tv@samsung.com>,
        <niyas.ahmed@samsung.com>, <l.mehra@samsung.com>
References: <20210518174618.42089-1-shradha.t@samsung.com>
 <CGME20210518173823epcas5p1cb9f93e209ca4055365048287ec43ee8@epcas5p1.samsung.com>
 <20210518174618.42089-3-shradha.t@samsung.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <6fbff9d5-a398-f2ad-b7e3-36d6153d2114@nvidia.com>
Date:   Thu, 27 May 2021 22:50:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518174618.42089-3-shradha.t@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abe92310-a69b-4183-baae-08d92133c5b3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42319FDAC2476591732A4002B8239@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUh16EjJciix24zpuUWCRY+GNo1Ex8AfroMvDjcJhniZ+gYsKcccdD5mpPq35SET3mtPlo2wq2I5DBcJzzF+NmJJJiM2/wYZkAOsp37xu0v3NeGYXm7Y7i4tRVYK2RClOp52OQI43NeOsu0cPVroPn2E0JuQw26wB1gga8O9GgxSqF4yM1cKwttlqI7Fp0NAit4yzcy16XWiwXw2solNcCw1NZncqjev1ou936v4LMTZnq9hjlw++3IpauR1rXm++UvDjwzDm/4JdgSdjTNpOXc65izy0WqffnVYuQMejdJBIS6ARCma4AEy/BpLMknuKMe7GPX+g2umSVWOvFn8huLnxVKC8LSK3ztGhEhrl93I4TWRH0+XDnFPN/LMgsT1gxmYZqXdoAwfPwXn2iJx2DMh0KMM9bL592dZgCl/zr3scEImvmbLi0UN//QbqV08a8ueonXQNmF5UUHQBgleCGLkSONF6HYibNS+dGA+8XnhWbiVOIOVHVjts7Eg1nY6rgH7NQWgX3tRQYLJNJv/9+Ew0i+VIaJ+SU9ooVxgBw2LHL+YDY9WHpcjeIPoK2axgl5a+gpqHJvLiamZg/Lqa5cCUgqqy3ORxjSgjl80H7nMyac+zsmbF7qs2wtYhCC2842dfskLJm+YjfbFMSxAB93zEd+1mnMf9KzM2ao+ERNupoNJ/L/SPpb6g7i4XcWxj7BfUTVh4lcgPsKSpkvr/1NjfrE21AveA60nEtFmTP8xuCEAK+0YpnygkWVOpFe3CHcDkEisUU1U410CiEvX758812enBYD7I/U3HWAJMYd8KhDBRyCfh8GxNH4pta8S
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(2616005)(5660300002)(31696002)(2906002)(31686004)(4326008)(30864003)(16526019)(336012)(7416002)(6666004)(47076005)(86362001)(8676002)(8936002)(186003)(82310400003)(82740400003)(53546011)(426003)(83380400001)(110136005)(966005)(26005)(36906005)(54906003)(70206006)(70586007)(478600001)(16576012)(36756003)(356005)(36860700001)(7636003)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 17:20:49.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe92310-a69b-4183-baae-08d92133c5b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/18/2021 11:16 PM, Shradha Todi wrote:
> External email: Use caution opening links or attachments
> 
> 
> RAS is a vendor specific extended PCIe capability which which helps to read
> hardware internal state.
> 
> This framework support provides debugfs entries to use these features for
> DesignWare controller. Following primary features of DesignWare controllers
> are provided to userspace via debugfs:
>   - Debug registers
>   - Error injection
>   - Statistical counters
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>   drivers/pci/controller/dwc/Kconfig            |   9 +
>   drivers/pci/controller/dwc/Makefile           |   1 +
>   .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
>   .../controller/dwc/pcie-designware-debugfs.h  | 133 +++++
>   drivers/pci/controller/dwc/pcie-designware.h  |   1 +
>   5 files changed, 688 insertions(+)
>   create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
>   create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 423d35872ce4..2d0a18cb9418 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -6,6 +6,15 @@ menu "DesignWare PCI Core Support"
>   config PCIE_DW
>          bool
> 
> +config PCIE_DW_DEBUGFS
> +       bool "DWC PCIe debugfs entries"
> +       default n
> +       help
> +         Enables debugfs entries for the DWC PCIe Controller.
> +         These entries make use of the RAS DES features in the DW
> +         controller to help in debug, error injection and statistical
> +         counters
> +
>   config PCIE_DW_HOST
>          bool
>          depends on PCI_MSI_IRQ_DOMAIN
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index eca805c1a023..6ad12638f793 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> +obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
>   obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>   obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>   obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> new file mode 100644
> index 000000000000..84bf196df240
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2021 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +#include "pcie-designware.h"
> +#include "pcie-designware-debugfs.h"
> +
> +#define DEBUGFS_BUF_MAX_SIZE   100
> +
> +static char debugfs_buf[DEBUGFS_BUF_MAX_SIZE];
> +
> +static struct dentry *dir;
Why can't this be moved inside struct dw_pcie?
> +static struct dentry *sub_dir;
> +
> +static struct event_counters ras_events[] = {
> +       {"ebuf_overflow",               ebuf_overflow},
> +       {"ebuf_underrun",               ebuf_underrun},
> +       {"decode_error",                decode_error},
> +       {"sync_header_error",           sync_header_error},
> +       {"receiver_error",              receiver_error},
> +       {"framing_error",               framing_error},
> +       {"lcrc_error",                  lcrc_error},
> +       {"ecrc_error",                  ecrc_error},
> +       {"unsupp_req_error",            unsupp_req_error},
> +       {"cmpltr_abort_error",          cmpltr_abort_error},
> +       {"cmpltn_timeout_error",        cmpltn_timeout_error},
> +       {"tx_l0s_entry",                tx_l0s_entry},
> +       {"rx_l0s_entry",                rx_l0s_entry},
> +       {"l1_entry",                    l1_entry},
> +       {"l1_1_entry",                  l1_1_entry},
> +       {"l1_2_entry",                  l1_2_entry},
> +       {"l2_entry",                    l2_entry},
> +       {"speed_change",                speed_change},
> +       {"width_chage",                 width_chage},
> +       {0, 0},
> +};
> +
> +static struct error_injections error_list[] = {
> +       {"tx_lcrc",             tx_lcrc},
> +       {"tx_ecrc",             tx_ecrc},
> +       {"rx_lcrc",             rx_lcrc},
> +       {"rx_ecrc",             rx_ecrc},
> +       {0, 0},
> +};
> +
> +static int open(struct inode *inode, struct file *file)
> +{
> +       file->private_data = inode->i_private;
> +
> +       return 0;
> +}
> +
> +/*
> + * set_event_number: Function to set event number based on filename
> + *
> + * This function is called from the common read and write function
> + * written for all event counters. Using the debugfs filname, the
> + * group number and event number for the counter is extracted and
> + * then programmed into the control register.
> + *
> + * @file: file pointer to the debugfs entry
> + *
> + * Return: void
> + */
> +static void set_event_number(struct file *file)
> +{
> +       int i;
> +       u32 val;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +       u32 max_size = sizeof(ras_events) / sizeof(struct event_counters);
> +
> +       for (i = 0; i < max_size; i++) {
> +               if (strcmp(ras_events[i].name,
> +                          file->f_path.dentry->d_parent->d_iname) == 0) {
> +                       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                                       RAS_DES_EVENT_COUNTER_CTRL_REG);
> +                       val &= ~(EVENT_COUNTER_ENABLE);
> +                       val &= ~(0xFFF << 16);
> +                       val |= (ras_events[i].event_num << 16);
> +                       dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +                                       RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +                       break;
> +               }
> +       }
> +}
> +/*
> + * get_error_inj_number: Function to get error number based on filename
> + *
> + * This function is called from the common read and write function
> + * written for all error injection debugfs entries. Using the debugfs
> + * filname, the error group and type of error to be injected is extracted.
> + *
> + * @file: file pointer to the debugfs entry
> + *
> + * Return: u32
> + * [31:8]: Type of error to be injected
> + * [7:0]: Group of error it belongs to
> + */
> +
> +static u32 get_error_inj_number(struct file *file)
> +{
> +       int i;
> +       u32 max_size = sizeof(error_list) / sizeof(struct error_injections);
> +
> +       for (i = 0; i < max_size; i++) {
> +               if (strcmp(error_list[i].name,
> +                          file->f_path.dentry->d_iname) == 0) {
> +                       return error_list[i].type_of_err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * ras_event_counter_en_read: Function to get if counter is enable
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/counter_enable
> + * It returns whether the counter is enabled or not
> + */
> +static ssize_t ras_event_counter_en_read(struct file *file, char __user *buf,
> +                                        size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       set_event_number(file);
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                               RAS_DES_EVENT_COUNTER_CTRL_REG);
> +       val = (val >> EVENT_COUNTER_STATUS_SHIFT) & EVENT_COUNTER_STATUS_MASK;
> +       if (val)
> +               sprintf(debugfs_buf, "Enabled\n");
> +       else
> +               sprintf(debugfs_buf, "Disabled\n");
> +
> +       ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +                                     strlen(debugfs_buf));
> +
> +       return ret;
> +}
> +
> +/*
> + * ras_event_counter_lane_sel_read: Function to get lane number selected
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/lane_select
> + * It returns for which lane the counter configurations are done
> + */
> +static ssize_t ras_event_counter_lane_sel_read(struct file *file,
> +                                              char __user *buf, size_t count,
> +                                              loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       set_event_number(file);
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                       RAS_DES_EVENT_COUNTER_CTRL_REG);
> +       val = (val >> LANE_SELECT_SHIFT) & LANE_SELECT_MASK;
> +       sprintf(debugfs_buf, "0x%x\n", val);
> +       ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +                                     strlen(debugfs_buf));
> +
> +       return ret;
> +}
> +
> +/*
> + * ras_event_counter_value_read: Function to get counter value
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/counter_value
> + * It returns the number of time the selected event has happened if enabled
> + */
> +
> +static ssize_t ras_event_counter_value_read(struct file *file, char __user *buf,
> +                                           size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       set_event_number(file);
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                               RAS_DES_EVENT_COUNTER_DATA_REG);
> +       sprintf(debugfs_buf, "0x%x\n", val);
> +       ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +                                     strlen(debugfs_buf));
> +
> +       return ret;
> +}
> +
> +/*
> + * ras_event_counter_en_write: Function to set if counter is enable
> + *
> + * This function is invoked when the following command is made:
> + * echo n > /sys/kernel/debug/dwc_pcie_plat/
> + *             ras_des_counter/<name>/counter_enable
> + * Here n can be 1 to enable and 0 to disable
> + */
> +static ssize_t ras_event_counter_en_write(struct file *file,
> +                                         const char __user *buf,
> +                                         size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       u32 enable;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       ret = kstrtou32_from_user(buf, count, 0, &enable);
> +       if (ret)
> +               return ret;
> +
> +       set_event_number(file);
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                               RAS_DES_EVENT_COUNTER_CTRL_REG);
> +       if (enable)
> +               val |= PER_EVENT_ON;
> +       else
> +               val |= PER_EVENT_OFF;
> +
> +       dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +                          RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +
> +       return count;
> +}
> +
> +/*
> + * ras_event_counter_lane_sel_write: Function to set lane number
> + *
> + * This function is invoked when the following command is made:
> + * echo n > /sys/kernel/debug/dwc_pcie_plat/ras_des_counter/<name>/lane_select
> + * Here n is the lane that we want to select for counter configuration
> + */
> +static ssize_t ras_event_counter_lane_sel_write(struct file *file,
> +                                               const char __user *buf,
> +                                               size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       u32 lane;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       ret = kstrtou32_from_user(buf, count, 0, &lane);
> +       if (ret)
> +               return ret;
> +
> +       set_event_number(file);
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                               RAS_DES_EVENT_COUNTER_CTRL_REG);
> +       val &= ~(LANE_SELECT_MASK << LANE_SELECT_SHIFT);
> +       val |= (lane << LANE_SELECT_SHIFT);
> +       dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +                          RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +
> +       return count;
> +}
> +
> +/*
> + * ras_error_inj_read: Function to read number of errors left to be injected
> + *
> + * This function is invoked when the following command is made:
> + * cat /sys/kernel/debug/dwc_pcie_plat/ras_des_error_inj/<name of error>
> + * This returns the number of errors left to be injected which will
> + * keep reducing as we make pcie transactions to inject error.
> + */
> +static ssize_t ras_error_inj_read(struct file *file, char __user *buf,
> +                                 size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val, err_num, inj_num;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       err_num = get_error_inj_number(file);
> +       inj_num = (err_num & 0xFF);
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
> +                               (0x4 * inj_num));
> +       sprintf(debugfs_buf, "0x%x\n", (val & EINJ_COUNT_MASK));
> +       ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +                                     strlen(debugfs_buf));
> +
> +       return ret;
> +}
> +
> +/*
> + * ras_error_inj_write: Function to set number of errors to be injected
> + *
> + * This function is invoked when the following command is made:
> + * echo n > /sys/kernel/debug/dwc_pcie_plat/ras_des_error_inj/<name of error>
> + * Here n is the number of errors we want to inject
> + */
> +static ssize_t ras_error_inj_write(struct file *file, const char __user *buf,
> +                                  size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val, err_num, inj_num;
> +       u32 counter;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       if (count > DEBUGFS_BUF_MAX_SIZE)
> +               return -EINVAL;
> +
> +       ret = kstrtou32_from_user(buf, count, 0, &counter);
> +       if (ret)
> +               return ret;
> +
> +       err_num = get_error_inj_number(file);
> +       inj_num = (err_num & 0xFF);
> +       err_num = (err_num >> 8);
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
> +                               (0x4 * inj_num));
> +       val &= ~(EINJ_TYPE_MASK << EINJ_TYPE_SHIFT);
> +       val |= (err_num << EINJ_TYPE_SHIFT);
> +       val &= ~(EINJ_COUNT_MASK);
> +       val |= counter;
> +       dw_pcie_writel_dbi(pci, pci->ras_cap_offset + ERR_INJ0_OFF +
> +                          (0x4 * inj_num), val);
> +       dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +                          ERR_INJ_ENABLE_REG, (0x1 << inj_num));
> +
> +       return count;
> +}
> +
> +static ssize_t lane_detection_read(struct file *file, char __user *buf,
> +                                  size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                               SD_STATUS_L1LANE_REG);
> +       val = (val >> LANE_DETECT_SHIFT) & LANE_DETECT_MASK;
> +       sprintf(debugfs_buf, "0x%x\n", val);
> +
> +       ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +                                     strlen(debugfs_buf));
> +
> +       return ret;
> +}
> +
> +static ssize_t rx_valid_read(struct file *file, char __user *buf,
> +                            size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                               SD_STATUS_L1LANE_REG);
> +       val = (val >> PIPE_RXVALID_SHIFT) & PIPE_RXVALID_MASK;
> +       sprintf(debugfs_buf, "0x%x\n", val);
> +
> +       ret = simple_read_from_buffer(buf, count, ppos, debugfs_buf,
> +                                     strlen(debugfs_buf));
> +
> +       return ret;
> +}
> +
> +static ssize_t lane_selection_write(struct file *file, const char __user *buf,
> +                                   size_t count, loff_t *ppos)
> +{
> +       u32 ret;
> +       u32 val;
> +       u32 lane;
> +       struct dw_pcie *pci = (struct dw_pcie *) file->private_data;
> +
> +       if (count > DEBUGFS_BUF_MAX_SIZE)
> +               return -EINVAL;
> +
> +       ret = kstrtou32_from_user(buf, count, 0, &lane);
> +       if (ret)
> +               return ret;
> +
> +       val = dw_pcie_readl_dbi(pci, pci->ras_cap_offset +
> +                               SD_STATUS_L1LANE_REG);
> +       val &= ~(LANE_SELECT_MASK);
> +       val |= lane;
> +       dw_pcie_writel_dbi(pci, pci->ras_cap_offset +
> +                          SD_STATUS_L1LANE_REG, val);
> +
> +       return count;
> +}
> +
> +static const struct file_operations lane_detection_fops = {
> +       .open = open,
> +       .read = lane_detection_read,
> +       .write = lane_selection_write
> +};
> +
> +static const struct file_operations rx_valid_fops = {
> +       .open = open,
> +       .read = rx_valid_read,
> +       .write = lane_selection_write
> +};
> +
> +static const struct file_operations cnt_en_ops = {
> +       .read = ras_event_counter_en_read,
> +       .write = ras_event_counter_en_write,
> +       .open = simple_open,
> +};
> +
> +static const struct file_operations lane_sel_ops = {
> +       .read = ras_event_counter_lane_sel_read,
> +       .write = ras_event_counter_lane_sel_write,
> +       .open = simple_open,
> +};
> +
> +static const struct file_operations cnt_val_ops = {
> +       .read = ras_event_counter_value_read,
> +       .open = simple_open,
> +};
> +
> +static const struct file_operations inj_ops = {
> +       .read = ras_error_inj_read,
> +       .write = ras_error_inj_write,
> +       .open = simple_open,
> +};
> +
> +int create_debugfs_files(struct dw_pcie *pci)
> +{
> +       int ret = 0;
> +       char dirname[32];
> +       struct device *dev;
> +
> +       struct dentry *ras_des_debug_regs;
> +       struct dentry *ras_des_error_inj;
> +       struct dentry *ras_des_event_counter;
> +       struct dentry *lane_detection;
> +       struct dentry *rx_valid;
> +
> +       if (!pci) {
> +               pr_err("pcie struct is NULL\n");
I think just returning from here should be fine without print.
Also, it is better to use dev_* instead of pr_* for prints.
> +               return -ENODEV;
> +       }
> +
> +       dev = pci->dev;
> +       sprintf(dirname, "pcie_dwc_%s", dev_name(dev));
> +
> +       pci->ras_cap_offset = dw_pcie_find_vsec_capability(pci,
> +                                                          DW_PCIE_RAS_CAP_ID);
> +       if (!pci->ras_cap_offset) {
> +               pr_err("No RAS capability available\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Create main directory for each platform driver */
> +       dir = debugfs_create_dir(dirname, NULL);
> +       if (dir == NULL) {
> +               pr_err("error creating directory: %s\n", dirname);
> +               return -ENODEV;
> +       }
> +
> +       /* Create sub dirs for Debug, Error injection, Statistics */
> +       ras_des_debug_regs = debugfs_create_dir("ras_des_debug_regs", dir);
> +       if (ras_des_debug_regs == NULL) {
> +               pr_err("error creating directory: %s\n", dirname);
> +               ret = -ENODEV;
> +               goto remove_debug_file;
> +       }
> +
> +       ras_des_error_inj = debugfs_create_dir("ras_des_error_inj", dir);
> +       if (ras_des_error_inj == NULL) {
> +               pr_err("error creating directory: %s\n", dirname);
> +               ret = -ENODEV;
> +               goto remove_debug_file;
> +       }
> +
> +       ras_des_event_counter = debugfs_create_dir("ras_des_counter", dir);
> +       if (ras_des_event_counter == NULL) {
> +               pr_err("error creating directory: %s\n", dirname);
> +               ret = -ENODEV;
> +               goto remove_debug_file;
> +       }
> +
> +       /* Create debugfs files for Debug subdirectory */
> +       lane_detection = debugfs_create_file("lane_detection", 0644,
> +                                            ras_des_debug_regs, pci,
> +                                            &lane_detection_fops);
> +
> +       rx_valid = debugfs_create_file("rx_valid", 0644,
> +                                            ras_des_debug_regs, pci,
> +                                            &lane_detection_fops);
Shouldn't it be 'rx_valid_fops' instead of 'lane_detection_fops', 
otherwise I don't see any references for 'rx_valid_fops'.
> +
> +       /* Create debugfs files for Error injection sub dir */
> +       CREATE_RAS_ERROR_INJECTION_DEBUGFS(tx_ecrc);
> +       CREATE_RAS_ERROR_INJECTION_DEBUGFS(rx_ecrc);
> +       CREATE_RAS_ERROR_INJECTION_DEBUGFS(tx_lcrc);
> +       CREATE_RAS_ERROR_INJECTION_DEBUGFS(rx_lcrc);
> +
> +       /* Create debugfs files for Statistical counter sub dir */
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(ebuf_overflow);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(ebuf_underrun);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(decode_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(receiver_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(framing_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(lcrc_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(ecrc_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(unsupp_req_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(cmpltr_abort_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(cmpltn_timeout_error);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(tx_l0s_entry);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(rx_l0s_entry);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_entry);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_1_entry);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(l1_2_entry);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(l2_entry);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(speed_change);
> +       CREATE_RAS_EVENT_COUNTER_DEBUGFS(width_chage);
> +
> +       return ret;
> +
> +remove_debug_file:
> +       remove_debugfs_files();
> +       return ret;
> +}
> +
> +void remove_debugfs_files(void)
> +{
> +       debugfs_remove_recursive(dir);
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> new file mode 100644
> index 000000000000..3dc3cf696a04
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2021 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#ifndef _PCIE_DESIGNWARE_DEBUGFS_H
> +#define _PCIE_DESIGNWARE_DEBUGFS_H
> +
> +#include "pcie-designware.h"
> +
> +#define RAS_DES_EVENT_COUNTER_CTRL_REG 0x8
> +#define RAS_DES_EVENT_COUNTER_DATA_REG 0xC
> +#define SD_STATUS_L1LANE_REG           0xB0
> +#define ERR_INJ_ENABLE_REG             0x30
> +#define ERR_INJ0_OFF                   0x34
> +
> +#define LANE_DETECT_SHIFT              17
> +#define LANE_DETECT_MASK               0x1
> +#define PIPE_RXVALID_SHIFT             18
> +#define PIPE_RXVALID_MASK              0x1
> +
> +#define LANE_SELECT_SHIFT              8
> +#define LANE_SELECT_MASK               0xF
> +#define EVENT_COUNTER_STATUS_SHIFT     7
> +#define EVENT_COUNTER_STATUS_MASK      0x1
> +#define EVENT_COUNTER_ENABLE           (0x7 << 2)
> +#define PER_EVENT_OFF                  (0x1 << 2)
> +#define PER_EVENT_ON                   (0x3 << 2)
> +
> +#define EINJ_COUNT_MASK                        0xFF
> +#define EINJ_TYPE_MASK                 0xFFFFFF
> +#define EINJ_TYPE_SHIFT                        8
> +
> +enum event_numbers {
> +       ebuf_overflow           = 0x0,
> +       ebuf_underrun           = 0x1,
> +       decode_error            = 0x2,
> +       sync_header_error       = 0x5,
> +       receiver_error          = 0x106,
> +       framing_error           = 0x109,
> +       lcrc_error              = 0x201,
> +       ecrc_error              = 0x302,
> +       unsupp_req_error        = 0x303,
> +       cmpltr_abort_error      = 0x304,
> +       cmpltn_timeout_error    = 0x305,
Is there a plan to add entries for Group-4?
> +       tx_l0s_entry            = 0x502,
> +       rx_l0s_entry            = 0x503,
> +       l1_entry                = 0x505,
> +       l1_1_entry              = 0x507,
> +       l1_2_entry              = 0x508,
> +       l2_entry                = 0x50B,
> +       speed_change            = 0x50C,
> +       width_chage             = 0x50D,
Also wondering about the plan for Groups-6,7
> +};
> +
> +/*
> + * struct event_counters: Struct to store event number
> + *
> + * @name: name of the event counter
> + *        eg: ecrc_err count, l1 entry count
> + * @event_num: Event number and group number
> + * [16:8]: Group number
> + * [7:0]: Event number
> + */
> +struct event_counters {
> +       const char *name;
> +       u32 event_num;
> +};
> +
> +enum error_inj_code {
> +       tx_lcrc                 = 0x000,
> +       tx_ecrc                 = 0x300,
> +       rx_lcrc                 = 0x800,
> +       rx_ecrc                 = 0xB00,
> +};
This is a generic query. DesignWare cores have 'Time-based Analysis 
Support' as well as part of DES. Is it in your pipeline to upstream the 
support for it as well?
> +
> +/*
> + * struct error_injectionss: Struct to store error numbers
> + *
> + * @name: name of the error to be injected
> + *        eg: ecrc_err, lcrc_err
> + * @event_num: Error number and group number
> + * [31:8]: Error type. This should be same as bits [31:8]
> + *         in the EINJn_REG where n is group number
> + * [7:0]: Error injection group
> + *        0 - CRC
> + *        1 - seq num
> + *        2 - DLLP error
> + *        3 - symbol error
> + *        4 - FC error
> + */
> +struct error_injections {
> +       const char *name;
> +       u32 type_of_err;
> +};
> +
> +#define CREATE_RAS_EVENT_COUNTER_DEBUGFS(name)                         \
> +do {                                                                   \
> +       sub_dir = debugfs_create_dir(#name, ras_des_event_counter);     \
> +       debugfs_create_file("counter_enable", 0644, sub_dir, pci,       \
> +                               &cnt_en_ops);                           \
> +       debugfs_create_file("lane_select", 0644, sub_dir, pci,          \
> +                               &lane_sel_ops);                         \
lane selection is required only for group-0 & 4 and other group counters 
are defined for all common lanes. Since group-4 is anyway not 
implemented in the current patch series, it would be good to create 
'lane_select' file only for group-0?
> +       debugfs_create_file("counter_value", 0444, sub_dir, pci,        \
> +                               &cnt_val_ops);                          \
> +} while (0)
> +
> +#define CREATE_RAS_ERROR_INJECTION_DEBUGFS(name)                       \
> +       debugfs_create_file(#name, 0644, ras_des_error_inj, pci,        \
> +                               &inj_ops);
> +
> +#ifdef CONFIG_PCIE_DW_DEBUGFS
> +int create_debugfs_files(struct dw_pcie *pci);
> +void remove_debugfs_files(void);
> +#else
> +int create_debugfs_files(struct dw_pcie *pci)
> +{
> +       /* No OP */
> +       return 0;
> +}
> +
> +void remove_debugfs_files(void)
> +{
> +       /* No OP */
> +}
> +#endif
> +
> +#endif
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 307525aaa063..031fdafe0a3e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -278,6 +278,7 @@ struct dw_pcie {
>          u8                      n_fts[2];
>          bool                    iatu_unroll_enabled: 1;
>          bool                    io_cfg_atu_shared: 1;
> +       u32                     ras_cap_offset;
>   };
> 
>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> --
> 2.17.1
> 
