Return-Path: <linux-pci+bounces-27083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17932AA6943
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 05:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429654A5EE9
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860913BC0C;
	Fri,  2 May 2025 03:21:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022079.outbound.protection.outlook.com [52.101.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818242D600;
	Fri,  2 May 2025 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746156063; cv=fail; b=m7FoP/pnwQGXG9bRry6DwLceJmild4DLKH21DnohPXK7Rw4GGh0CvRtGhwgujXkiXRLX+7dNXFl063SU4X5tXrnRRaPnXx3uUK/2q/yZBrvNzFhEYvA1L0cusJXzvG4Qj5CAFMMEStI3YADGQDH25boVKesTkbbHTeUWKyJRvvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746156063; c=relaxed/simple;
	bh=cmLpXs2GfVjJwhGY5xcwckr5IicPVjncIlq3BLr9K4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bNuJVHEqcy1DOlqdZR75Npkof/8AJ6i1nw1cXXD8tylryJzF2iz0+QKaK37MMeipKky5Osxy6yIlxFTx2Ajf1l6Olm/CvTwupnzrH2tZw3gRsr/zw055EcBVnCe8h460FVr8LnVHF4wopYKqy4n0JxNTdjam9UaD9o+E+AYwir0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtAP9QGG1MMAy9gZfNmi0GZjaHNUkSaEtQP8A2I7/Fk9Dcti5G5udJulPvJ3BbcI2oY4Vt58Xu86Dcng2erMjJWnzelfTDrhznJuMihtPjSllHch0rt/djhqka/D7mnjoNB/0BI8K43+u7bFO332Lb78zCiwO6Yeq4cldRPTkd30eDRsdXtIaRItikzF8TmMcEYuUZmwOeXCtcXVCNjYzJ1tgxvP1K6PgecGUgKl+ixWXF7pFD0/gfJQ8f9Mo2R7090rKRIcxud4PqJtHzBOkpKF+mGlCWB2QnEgQyxHiXk6ieBac7c3E5qdZ1nvXP3Ww0mVnl8uz1BJU8l+fjRm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oOo+q4trKCQqqEO6uwPZaJx4YNtXsfPWdJyxyfn3Z4=;
 b=FFC0PPPdhdi+tyQJCTrqTJweHW+6GLLb6jOe9cP81WRD9JbonM5TVSpoFJ0+IZIq4BS0k4OqSjN7YNFL+irkT8lOOMaphC7puHZyhTf/hPh3H2PZJPAKbddfW8g5xML3F/KpKNX6rYVFjYrAY/9o2ANGQCl/LIizlQ9wznmdgOUl75IL8e6glUcqr4tCZ8S5ANUnupk5CUp0JL/jFkbrVZQot2ipQZalBHgFYI+52665cF5kQd3eFAwZDUoObVitCIPn+d1gFPA4gznWQhx1d8yAFFEuahEDGeyNTOULcbKRT2Q2ARdqq/dHAFOno7ATTPVTtxOTrdRllGOFj2BNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0022.apcprd02.prod.outlook.com (2603:1096:4:195::23)
 by SEZPR06MB6406.apcprd06.prod.outlook.com (2603:1096:101:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 03:20:54 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:195:cafe::d0) by SI2PR02CA0022.outlook.office365.com
 (2603:1096:4:195::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 03:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 03:20:53 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AC93441604EA;
	Fri,  2 May 2025 11:20:52 +0800 (CST)
From: hans.zhang@cixtech.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: manivannan.sadhasivam@linaro.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during suspend
Date: Fri,  2 May 2025 11:20:51 +0800
Message-ID: <20250502032051.920990-1-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SEZPR06MB6406:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4315709-988c-4e08-709c-08dd89285897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7P8Gr8GlnZco/6lfc7b27zO8P4+VYlkhcPSPrScdQi/3PhhVbYTpxC4jAqxn?=
 =?us-ascii?Q?GAXmBmoOJNIGpgHkQgaeG4akOJ/tKtpvKDaAoIBSavp1hd0K0yiMYhOWf5fY?=
 =?us-ascii?Q?9ZIYOep2tvYqNEx4adir4Br1wHk+KQ6gp5mM1dgsuoakXOtpupLmUHGRWvDB?=
 =?us-ascii?Q?hOxcV2urXlRdFwCgc4UPmJCA1tgybxjmj0R4V7nYTFUOaYD2Fzbo64IDtbmw?=
 =?us-ascii?Q?JbR1PiKCoBWcRiHaRS0IiaphpmzAdDp4/MUn7C6K8Ltgb8Ht4iWEHx+VlNYK?=
 =?us-ascii?Q?NDgzX4daqJE+pWkaChEeOFndhCBiKhD9BqySAls6vRL5O788cAjkiqtue/C5?=
 =?us-ascii?Q?scs3EWhd56OSngXEdMuZAiBIn1Bq15NWjapyd1iFK81eGELhlx5zs3roFWPe?=
 =?us-ascii?Q?XDKEzaobG6ZQCpCxqU6es2OOE8I7B3W9beOMM9f78CA4wpJbpvf7u2h7YTrV?=
 =?us-ascii?Q?1V4+Da/EJDrZ30onUwNeRKEkAhFvfY7SHQ6gzkFwpORuunlsTu9+vU9xEJX4?=
 =?us-ascii?Q?DbQYFP5hFaW+vUBQj7gqquGQTPv1cTHNUlrto0L2uJSG7cXS1c7ksuMwtEbb?=
 =?us-ascii?Q?hQprImX827eHVA6ClaLXo0HjeiqEpKuB7V9+2ta9A5qXaT4y3GDxcFSC7iLN?=
 =?us-ascii?Q?dB/J10aT/0g958tpZYXm3UOyFGoFhDzT0f7D78uZYoJocDZQCU8raOR0G5wt?=
 =?us-ascii?Q?P1AeROvilJT+wbGQRVdFNeW0NP+Rs1audp2KzmUig9oe0Kw44tSeYCB42hkI?=
 =?us-ascii?Q?lJvBcI7DhuwTVHvwz9ocAv2/HrRrAtakID/7Aff2IKyqIAMLOV6t2uXg/Efm?=
 =?us-ascii?Q?LuRyDI+zXUfF2DN6NRXbZF3yMReSRGWxXNlkn5OdCmWBc3n/nI0Wm8IzUoYp?=
 =?us-ascii?Q?26TSgkRjZ1sRhYSvDEJm4AwOw/afAouZ/CHEIadGGoQZjMXmI/S1U6UAuDJj?=
 =?us-ascii?Q?i0KNjfczro/xasi9B7HSG9+07e1GNw+oHUodnEGuS0hvuJMn//o51oDbWYPN?=
 =?us-ascii?Q?bI07mkvmLclQ4C0SFlzgECrcA7cVfsJgm3Ji5IWx344qz3sDcqwW4m/QnfZG?=
 =?us-ascii?Q?TGT4vUJZdogPY0vStb0RLZQn3RdkFoVWYu3cWywL2ztuVv51TBYe7Lc/RDqd?=
 =?us-ascii?Q?9M2glgkWDmbcRFy71O9AYhnkFnZv4q5/VSrsdrxuP0PyWWwgxIdFhTJzy0T3?=
 =?us-ascii?Q?Y8OfvQmVbWyxlwGxIZAM45rmthReGPOHexEW2akZwMDbZAbX/9QsbjfB4Tb4?=
 =?us-ascii?Q?O7++Ykhrq4aHqr50O1tXMjWxz3gCqijFCD4YR6NVQqDjAnJgG8c55U85yufm?=
 =?us-ascii?Q?aSV6K++OkIl+nNhVMBCzoAtEkJewFulocio3FCZ3CQtN2eplridl144CRtrv?=
 =?us-ascii?Q?cdbMRryvMzpiy0j/Tvxp8rUQsRGh7PPANfRrJj9B5C93IE9dtNRQoiS8rLBY?=
 =?us-ascii?Q?vJaPtj0oaXtqL9B+anNWauPClhVfeJtKY9tXSUe5PyaIQkTnHMnk4u1px5X4?=
 =?us-ascii?Q?lbBhkVDDu552d5IA7TnnBS1mH4UFGHgCO4IVvl3ztyZD5osNcK/SGiY1zw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 03:20:53.2816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4315709-988c-4e08-709c-08dd89285897
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6406

From: Hans Zhang <hans.zhang@cixtech.com>

When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
NVMe controllers fail to release LPI MSI-X interrupts during system
suspend, leading to a system hang. This occurs because the driver's
existing power management path does not fully disable the device
when ASPM is active.

The fix adds an explicit device disable and reset preparation step
in the suspend path after successfully setting the power state.
This ensures proper cleanup of interrupt resources even when ASPM
L1 is enabled, preventing the system from hanging during suspend.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
Resend and add linux-pci@vger.kernel.org.


Dear maintainers,
The problems I encountered: If our SOC enables PCIe ASPM L1, it will hang during suspend.

For Mani's patch: (I know this patch wasn't accepted.) For this patch, the STR process of our SOC is also normal.
https://patchwork.kernel.org/project/linux-pci/patch/20241118082344.8146-1-manivannan.sadhasivam@linaro.org/

Supplementary explanation:
During the suspend process of our SOC, the PCIe Root Port will shut down resources such as the AXI and APB clock
of the controller. Our hardware is in STR(suspend to ram), and the controller and PHY will lose power.

Our SOC has enabled PCIe ASPM function and configured CONFIG_PCIEASPM_POWERSAVE=y. pcie_aspm_enabled(pdev) is true.

static int nvme_suspend(struct device *dev)
{
       ......
       if (pm_suspend_via_firmware() || !ctrl->npss ||
           !pcie_aspm_enabled(pdev) ||
           (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
              return nvme_disable_prepare_reset(ndev, true);

The above will not execute nvme_disable_prepare_reset(ndev, true);
nvme_set_power_state(ctrl, ctrl->npss); return value is:
ret = nvme_set_power_state(ctrl, ctrl->npss);
->return nvme_set_features
->->return nvme_features
->->__nvme_submit_sync_cmd
->->->ret = nvme_execute_rq

/*
  * Return values:
  * 0:  success
  * >0: nvme controller's cqe status response
  * <0: kernel error in lieu of controller response
 */
int nvme_execute_rq(struct request *rq, bool at_head)
{
       blk_status_t status;

       status = blk_execute_rq(rq, at_head);
       if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
              return -EINTR;
       if (nvme_req(rq)->status)
              return nvme_req(rq)->status;
       return blk_status_to_errno(status);
}
EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, "NVME_TARGET_PASSTHRU");

But the nvme driver did not determine cases equal to 0.
Suspend flow nvme_disable_prepare_reset will free nvme SSD LPI interrupts.
If nvme_disable_prepare_reset is not called, irq_sthutdown will be executed,
followed by its_mask_masi_irq.

In my opinion, if ASPM is enabled, then run the process after nvme_suspend.
Then we can determine that the return value of nvme_set_power_state is equal
to 0 and call nvme_disable_prepare_reset. I have tested 1000+ reboots and STR
(suspend to ram and resume). The nvme works fine.

If my approach is unreasonable, please correct me. Please also offer some
suggestions on what I should do. Thank you very much.

The following is the test log: (base: kernel 6.1.44)

root@cix-localhost:~# echo 7 > /proc/sys/kernel/printk
root@cix-localhost:~# echo 1 > /sys/power/pm_debug_messages
root@cix-localhost:~# echo 1 > /sys/power/pm_print_times
root@cix-localhost:~# echo N > /sys/module/printk/parameters/console_suspend
root@cix-localhost:~# echo mem > /sys/power/state
[   85.769651] [2025:05:01 09:09:14][pid:916,cpu7,bash]PM: suspend entry (deep)
[   85.788042] [pid:916,cpu7,bash]Filesystems sync: 0.011 seconds
[   85.795451] [pid:916,cpu7,bash]Freezing user space processes
[   85.802387] [pid:916,cpu7,bash]Freezing user space processes completed (elapsed 0.001 seconds)
[   85.810998] [pid:916,cpu7,bash]OOM killer disabled.
[   85.815869] [pid:916,cpu7,bash]Freezing remaining freezable tasks
[   85.823096] [pid:916,cpu7,bash]Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   85.832590] [pid:916,cpu7,bash]platform sound: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   85.842686] [pid:916,cpu7,bash]platform sound: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   85.852169] [pid:916,cpu7,bash]amvx_dev 14230000.vpu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   85.862598] [pid:916,cpu7,bash]amvx_dev 14230000.vpu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   85.872687] [pid:916,cpu7,bash]armchina 14260000.aipu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   85.883200] [pid:916,cpu7,bash]armchina 14260000.aipu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   85.893399] [pid:916,cpu7,bash]mali 15000000.gpu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   85.903615] [pid:916,cpu7,bash]mali 15000000.gpu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 132 usecs
[   85.913532] [pid:916,cpu7,bash]linlondp 141d0000.disp-controller: PM: calling linlondp_pm_suspend+0x0/0x98 [linlon_dp] @ 916, parent: soc@0
[   85.926054] [pid:916,cpu7,bash]linlondp 141d0000.disp-controller: linlondp_pm_suspend
[   85.933928] [pid:916,cpu7,bash]linlondp 141d0000.disp-controller: PM: linlondp_pm_suspend+0x0/0x98 [linlon_dp] returned 0 after 7874 usecs
[   85.946361] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.16.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 14224000.dp
[   85.959044] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.16.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   85.970860] [pid:916,cpu7,bash]trilin-dptx-cix 14224000.dp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   85.981808] [pid:916,cpu7,bash]trilin-dptx-cix 14224000.dp: [drm:trilin_dptx_pm_suspend][info]enter!
[   85.990931] [pid:916,cpu7,bash]trilin-dptx-cix 14224000.dp: [drm:trilin_dp_pm_prepare][info]enter.
[   85.999989] [pid:916,cpu7,bash]trilin-dptx-cix 14224000.dp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 18182 usecs
[   86.010944] [pid:916,cpu7,bash]linlondp 14160000.disp-controller: PM: calling linlondp_pm_suspend+0x0/0x98 [linlon_dp] @ 916, parent: soc@0
[   86.023458] [pid:916,cpu7,bash]linlondp 14160000.disp-controller: linlondp_pm_suspend
[   86.031312] [pid:916,cpu7,bash]linlondp 14160000.disp-controller: PM: linlondp_pm_suspend+0x0/0x98 [linlon_dp] returned 0 after 7853 usecs
[   86.043743] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.15.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 141b4000.dp
[   86.056425] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.15.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.068242] [pid:916,cpu7,bash]trilin-dptx-cix 141b4000.dp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.079190] [pid:916,cpu7,bash]trilin-dptx-cix 141b4000.dp: [drm:trilin_dptx_pm_suspend][info]enter!
[   86.088312] [pid:916,cpu7,bash]trilin-dptx-cix 141b4000.dp: [drm:trilin_dp_pm_prepare][info]enter.
[   86.097358] [pid:916,cpu7,bash]trilin-dptx-cix 141b4000.dp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 18169 usecs
[   86.108313] [pid:916,cpu7,bash]linlondp 140f0000.disp-controller: PM: calling linlondp_pm_suspend+0x0/0x98 [linlon_dp] @ 916, parent: soc@0
[   86.120827] [pid:916,cpu7,bash]linlondp 140f0000.disp-controller: linlondp_pm_suspend
[   86.128681] [pid:916,cpu7,bash]linlondp 140f0000.disp-controller: PM: linlondp_pm_suspend+0x0/0x98 [linlon_dp] returned 0 after 7854 usecs
[   86.141110] [pid:916,cpu7,bash]cdns-i2s-mc 70b0000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.151709] [pid:916,cpu7,bash]cdns-i2s-mc 70b0000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.161964] [pid:916,cpu7,bash]cdns-i2s-mc 70a0000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.172563] [pid:916,cpu7,bash]cdns-i2s-mc 70a0000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.182819] [pid:916,cpu7,bash]input input4: PM: calling input_dev_suspend+0x0/0xc0 @ 916, parent: 0018:048D:8987.0001
[   86.193516] [pid:916,cpu7,bash]input input4: PM: input_dev_suspend+0x0/0xc0 returned 0 after 0 usecs
[   86.202642] [pid:916,cpu7,bash]leds input3::kana: PM: calling led_suspend+0x0/0x60 @ 916, parent: input3
[   86.212121] [pid:916,cpu7,bash]leds input3::kana: PM: led_suspend+0x0/0x60 returned 0 after 0 usecs
[   86.221159] [pid:916,cpu7,bash]leds input3::compose: PM: calling led_suspend+0x0/0x60 @ 916, parent: input3
[   86.230890] [pid:916,cpu7,bash]leds input3::compose: PM: led_suspend+0x0/0x60 returned 0 after 0 usecs
[   86.240188] [pid:916,cpu7,bash]leds input3::scrolllock: PM: calling led_suspend+0x0/0x60 @ 916, parent: input3
[   86.250178] [pid:916,cpu7,bash]leds input3::scrolllock: PM: led_suspend+0x0/0x60 returned 0 after 0 usecs
[   86.259735] [pid:916,cpu7,bash]leds input3::capslock: PM: calling led_suspend+0x0/0x60 @ 916, parent: input3
[   86.269552] [pid:916,cpu7,bash]leds input3::capslock: PM: led_suspend+0x0/0x60 returned 0 after 0 usecs
[   86.278939] [pid:916,cpu7,bash]leds input3::numlock: PM: calling led_suspend+0x0/0x60 @ 916, parent: input3
[   86.288670] [pid:916,cpu7,bash]leds input3::numlock: PM: led_suspend+0x0/0x60 returned 0 after 0 usecs
[   86.297968] [pid:916,cpu7,bash]input input3: PM: calling input_dev_suspend+0x0/0xc0 @ 916, parent: 0018:048D:8987.0001
[   86.308655] [pid:916,cpu7,bash]input input3: PM: input_dev_suspend+0x0/0xc0 returned 0 after 1 usecs
[   86.317780] [pid:916,cpu7,bash]cdns-i2s-mc 7090000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.328379] [pid:916,cpu7,bash]cdns-i2s-mc 7090000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.338633] [pid:916,cpu7,bash]cdns-i2s-mc 7080000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.349232] [pid:916,cpu7,bash]cdns-i2s-mc 7080000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.359486] [pid:916,cpu7,bash]cdns-i2s-mc 7070000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.370084] [pid:916,cpu7,bash]cdns-i2s-mc 7070000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.380338] [pid:916,cpu7,bash]cdns-i2s-mc 7050000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.390937] [pid:916,cpu7,bash]cdns-i2s-mc 7050000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.401190] [pid:916,cpu7,bash]cdns-i2s-sc 7040000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.411789] [pid:916,cpu7,bash]cdns-i2s-sc 7040000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.422041] [pid:916,cpu7,bash]cdns-i2s-sc 7020000.i2s: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.432640] [pid:916,cpu7,bash]cdns-i2s-sc 7020000.i2s: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.442894] [pid:916,cpu7,bash]cix-dsp-rproc 7000000.audio-dsp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.454189] [pid:916,cpu7,bash]cix-dsp-rproc 7000000.audio-dsp:  cix_dsp_rproc_suspend
[   86.462097] [pid:916,cpu7,bash]cix-dsp-rproc 7000000.audio-dsp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 7909 usecs
[   86.473315] [pid:916,cpu7,bash]input input2: PM: calling input_dev_suspend+0x0/0xc0 @ 916, parent: wireless_bluetooth
[   86.483915] [pid:916,cpu7,bash]input input2: PM: input_dev_suspend+0x0/0xc0 returned 0 after 0 usecs
[   86.493041] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.14.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 14144000.dp
[   86.505723] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.14.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.517545] [pid:916,cpu7,bash]arm-dma350 7010000.dma-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.529012] [pid:916,cpu7,bash]arm-dma350 7010000.dma-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   86.540138] [pid:916,cpu7,bash]rfkill rfkill0: PM: calling rfkill_suspend+0x0/0x30 @ 916, parent: wireless_bluetooth
[   86.550664] [pid:916,cpu7,bash]rfkill rfkill0: PM: rfkill_suspend+0x0/0x30 returned 0 after 1 usecs
[   86.559702] [pid:916,cpu7,bash]linlondp 14080000.disp-controller: PM: calling linlondp_pm_suspend+0x0/0x98 [linlon_dp] @ 916, parent: soc@0
[   86.572216] [pid:916,cpu7,bash]linlondp 14080000.disp-controller: linlondp_pm_suspend
[   86.580066] [pid:916,cpu7,bash]linlondp 14080000.disp-controller: PM: linlondp_pm_suspend+0x0/0x98 [linlon_dp] returned 0 after 7849 usecs
[   86.592499] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.13.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 140d4000.dp
[   86.605182] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.13.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.616998] [pid:916,cpu7,bash]trilin-dptx-cix 140d4000.dp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.627954] [pid:916,cpu7,bash]trilin-dptx-cix 140d4000.dp: [drm:trilin_dptx_pm_suspend][info]enter!
[   86.637076] [pid:916,cpu7,bash]trilin-dptx-cix 140d4000.dp: [drm:trilin_dp_pm_prepare][info]enter.
[   86.646088] [pid:916,cpu7,bash]trilin-dptx-cix 140d4000.dp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 18134 usecs
[   86.657049] [pid:916,cpu7,bash]linlondp 14010000.disp-controller: PM: calling linlondp_pm_suspend+0x0/0x98 [linlon_dp] @ 916, parent: soc@0
[   86.657155] [pid:160,cpu2,kworker/u24:3]i2c_hid_of 5-003a: PM: calling i2c_hid_core_suspend+0x0/0xc0 @ 160, parent: i2c-5
[   86.669560] [pid:916,cpu7,bash]linlondp 14010000.disp-controller: linlondp_pm_suspend
[   86.669594] [pid:916,cpu7,bash]linlondp 14010000.disp-controller: PM: linlondp_pm_suspend+0x0/0x98 [linlon_dp] returned 0 after 33 usecs
[   86.681367] [pid:160,cpu2,kworker/u24:3]i2c_hid_of 5-003a: PM: i2c_hid_core_suspend+0x0/0xc0 returned 0 after 832 usecs
[   86.688348] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.12.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 14064000.dp
[   86.688351] [pid:916,cpu7,bash]hdmi-audio-codec hdmi-audio-codec.12.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.688412] [pid:916,cpu7,bash]trilin-dptx-cix 14064000.dp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.746818] [pid:916,cpu7,bash]trilin-dptx-cix 14064000.dp: [drm:trilin_dptx_pm_suspend][info]enter!
[   86.755940] [pid:916,cpu7,bash]trilin-dptx-cix 14064000.dp: [drm:trilin_dp_pm_prepare][info]enter.
[   86.764949] [pid:916,cpu7,bash]trilin-dptx-cix 14064000.dp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 18131 usecs
[   86.775903] [2025:05:01 09:09:15][pid:916,cpu7,bash]cix-edp-panel panel_edp0: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   86.788673] [pid:916,cpu7,bash]cix-edp-panel panel_edp0: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.799017] [pid:916,cpu7,bash]backlight dp2_backlight: PM: calling backlight_suspend+0x0/0xb0 @ 916, parent: dp2_backlight
[   86.810156] [pid:916,cpu7,bash]backlight dp2_backlight: PM: backlight_suspend+0x0/0xb0 returned 0 after 1 usecs
[   86.820237] [pid:916,cpu7,bash]pwm-backlight dp2_backlight: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   86.831445] [pid:916,cpu7,bash]pwm-backlight dp2_backlight: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   86.842048] [pid:916,cpu7,bash]sky1-socinfo 83e01000.sky1_top: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   86.853254] [pid:916,cpu7,bash]sky1-socinfo 83e01000.sky1_top: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.864115] [pid:916,cpu7,bash]regulator regulator.2: PM: calling regulator_suspend+0x0/0x114 @ 916, parent: wlan-poweren
[   86.875077] [pid:916,cpu7,bash]regulator regulator.2: PM: regulator_suspend+0x0/0x114 returned 0 after 1 usecs
[   86.885071] [pid:916,cpu7,bash]reg-fixed-voltage wlan-poweren: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   86.896539] [pid:916,cpu7,bash]reg-fixed-voltage wlan-poweren: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.907400] [pid:916,cpu7,bash]regulator regulator.1: PM: calling regulator_suspend+0x0/0x114 @ 916, parent: regulator-vdd-3v3-pcie
[   86.919222] [pid:916,cpu7,bash]regulator regulator.1: PM: regulator_suspend+0x0/0x114 returned 0 after 0 usecs
[   86.929215] [pid:916,cpu7,bash]reg-fixed-voltage regulator-vdd-3v3-pcie: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   86.941550] [pid:916,cpu7,bash]reg-fixed-voltage regulator-vdd-3v3-pcie: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.953280] [pid:916,cpu7,bash]uart-pl011 40d0000.uart: PM: calling pm_generic_suspend+0x0/0x44 @ 916, parent: soc@0
[   86.963808] [pid:916,cpu7,bash]uart-pl011 40d0000.uart: PM: pm_generic_suspend+0x0/0x44 returned 0 after 4 usecs
[   86.973981] [pid:916,cpu7,bash]snd-soc-dummy snd-soc-dummy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   86.985187] [pid:916,cpu7,bash]snd-soc-dummy snd-soc-dummy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   86.995793] [pid:916,cpu7,bash]input input1: PM: calling input_dev_suspend+0x0/0xc0 @ 916, parent: 4070000.i2c:ec@76:cix_ec_pwrkey
[   87.007521] [pid:916,cpu7,bash]input input1: PM: input_dev_suspend+0x0/0xc0 returned 0 after 0 usecs
[   87.016651] [pid:916,cpu7,bash]input input0: PM: calling input_dev_suspend+0x0/0xc0 @ 916, parent: 4070000.i2c:ec@76:cix_ec_lid
[   87.028118] [pid:916,cpu7,bash]input input0: PM: input_dev_suspend+0x0/0xc0 returned 0 after 0 usecs
[   87.037243] [pid:916,cpu7,bash]cix-ec-fan 4070000.i2c:ec@76:cix_ec_fan: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.049318] [pid:916,cpu7,bash]cix-ec-fan 4070000.i2c:ec@76:cix_ec_fan: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.060960] [pid:916,cpu7,bash]cix-ec-excp 4070000.i2c:ec@76:cix_ec_excp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.073208] [pid:916,cpu7,bash]cix-ec-excp 4070000.i2c:ec@76:cix_ec_excp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.085025] [pid:916,cpu7,bash]cix-pwrkey 4070000.i2c:ec@76:cix_ec_pwrkey: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.097360] [pid:916,cpu7,bash]cix-pwrkey 4070000.i2c:ec@76:cix_ec_pwrkey: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.109263] [pid:916,cpu7,bash]rfkill_bt wireless_bluetooth: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   87.120557] [pid:916,cpu7,bash]rfkill_bt wireless_bluetooth: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.131244] [pid:916,cpu7,bash]rfkill_wwan rfkill_wwan: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   87.142103] [pid:916,cpu7,bash]rfkill_wwan rfkill_wwan: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.152357] [pid:916,cpu7,bash]cix-ec-gpio 4070000.i2c:ec@76:cix_ec_gpio: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.164606] [pid:916,cpu7,bash]cix-ec-gpio 4070000.i2c:ec@76:cix_ec_gpio: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.176422] [pid:916,cpu7,bash]cix-ec-charge 4070000.i2c:ec@76:cix_ec_charge: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.189017] [pid:916,cpu7,bash]cix-ec-charge 4070000.i2c:ec@76:cix_ec_charge: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.201179] [pid:916,cpu7,bash]cix-ec-battery 4070000.i2c:ec@76:cix_ec_battery: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.213948] [pid:916,cpu7,bash]cix-ec-battery 4070000.i2c:ec@76:cix_ec_battery: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.226282] [pid:916,cpu7,bash]cix-ec-lid 4070000.i2c:ec@76:cix_ec_lid: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.238357] [pid:916,cpu7,bash]cix-ec-lid 4070000.i2c:ec@76:cix_ec_lid: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.249999] [pid:916,cpu7,bash]pwm-fan 4070000.i2c:ec@76:pwm-fan: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.265408] [pid:916,cpu7,bash]pwm-fan 4070000.i2c:ec@76:pwm-fan: PM: platform_pm_suspend+0x0/0x70 returned 0 after 3856 usecs
[   87.276791] [pid:916,cpu7,bash]pwm pwmchip2: PM: calling pwm_class_suspend+0x0/0x13c @ 916, parent: 4070000.i2c:ec@76:ec-pwm
[   87.288004] [pid:916,cpu7,bash]pwm pwmchip2: PM: pwm_class_suspend+0x0/0x13c returned 0 after 0 usecs
[   87.297217] [pid:916,cpu7,bash]cros-ec-pwm 4070000.i2c:ec@76:ec-pwm: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.309030] [pid:916,cpu7,bash]cros-ec-pwm 4070000.i2c:ec@76:ec-pwm: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.320411] [pid:916,cpu7,bash]cros-ec-sysfs cros-ec-sysfs.11.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: cros-ec-dev.8.auto
[   87.333183] [pid:916,cpu7,bash]cros-ec-sysfs cros-ec-sysfs.11.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.344477] [pid:916,cpu7,bash]cros-ec-debugfs cros-ec-debugfs.10.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: cros-ec-dev.8.auto
[   87.357594] [pid:916,cpu7,bash]cros-ec-debugfs cros-ec-debugfs.10.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   87.369236] [pid:916,cpu7,bash]platform cros-ec-chardev.9.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: cros-ec-dev.8.auto
[   87.381657] [pid:916,cpu7,bash]platform cros-ec-chardev.9.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.392606] [pid:916,cpu7,bash]cros-ec-dev cros-ec-dev.8.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 6-0076
[   87.403898] [pid:916,cpu7,bash]cros-ec-dev cros-ec-dev.8.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.414760] [pid:916,cpu7,bash]platform platform-framebuffer.0: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   87.426313] [pid:916,cpu7,bash]platform platform-framebuffer.0: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.437265] [pid:916,cpu7,bash]psci-cpuidle psci-cpuidle: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   87.448297] [pid:916,cpu7,bash]psci-cpuidle psci-cpuidle: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.458743] [pid:916,cpu7,bash]alarmtimer alarmtimer.7.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: rtc0
[   87.458848] [pid:160,cpu2,kworker/u24:3]rts5453h 7-0031: PM: calling rts5453h_suspend+0x0/0x5c @ 160, parent: i2c-7
[   87.458886] [pid:161,cpu8,kworker/u24:4]rts5453h 7-0030: PM: calling rts5453h_suspend+0x0/0x5c @ 161, parent: i2c-7
[   87.458899] [pid:161,cpu8,kworker/u24:4]rts5453h 7-0030: PM: rts5453h_suspend+0x0/0x5c returned 0 after 2 usecs
[   87.458941] [pid:322,cpu11,kworker/u24:6]cros-ec-i2c 6-0076: PM: calling cros_ec_i2c_suspend+0x0/0x20 @ 322, parent: i2c-6
[   87.462398] [pid:322,cpu11,kworker/u24:6]cros-ec-i2c 6-0076: PM: cros_ec_i2c_suspend+0x0/0x20 returned 0 after 3436 usecs
[   87.469688] [pid:916,cpu7,bash]alarmtimer alarmtimer.7.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   87.469693] [pid:916,cpu7,bash]rtc rtc0: PM: calling rtc_suspend+0x0/0x1a0 @ 916, parent: 3-0032
[   87.470094] [pid:916,cpu7,bash]rtc rtc0: PM: rtc_suspend+0x0/0x1a0 returned 0 after 381 usecs
[   87.480153] [pid:160,cpu2,kworker/u24:3]rts5453h 7-0031: PM: rts5453h_suspend+0x0/0x5c returned 0 after 4 usecs
[   87.490631] [pid:324,cpu10,kworker/u24:7]rtc-rx8900 3-0032: PM: calling rx8900_suspend+0x0/0x220 @ 324, parent: i2c-3
[   87.490754] [pid:92,cpu0,kworker/u24:1]usb usb10: PM: calling usb_dev_suspend+0x0/0x20 @ 92, parent: xhci-hcd.6.auto
[   87.490810] [pid:9,cpu6,kworker/u24:0]usb usb9: PM: calling usb_dev_suspend+0x0/0x20 @ 9, parent: xhci-hcd.6.auto
[   87.490871] [pid:9,cpu6,kworker/u24:0]usb usb9: PM: usb_dev_suspend+0x0/0x20 returned 0 after 46 usecs
[   87.490939] [pid:326,cpu7,kworker/u24:9]rts5453h 1-0030: PM: calling rts5453h_suspend+0x0/0x5c @ 326, parent: i2c-1
[   87.490947] [pid:326,cpu7,kworker/u24:9]rts5453h 1-0030: PM: rts5453h_suspend+0x0/0x5c returned 0 after 1 usecs
[   87.490938] [pid:190,cpu1,kworker/u24:5]rts5453h 1-0031: PM: calling rts5453h_suspend+0x0/0x5c @ 190, parent: i2c-1
[   87.490961] [pid:190,cpu1,kworker/u24:5]rts5453h 1-0031: PM: rts5453h_suspend+0x0/0x5c returned 0 after 2 usecs
[   87.490963] [pid:326,cpu7,kworker/u24:9]usb usb8: PM: calling usb_dev_suspend+0x0/0x20 @ 326, parent: xhci-hcd.5.auto
[   87.490994] [pid:325,cpu0,kworker/u24:8]usb usb6: PM: calling usb_dev_suspend+0x0/0x20 @ 325, parent: xhci-hcd.3.auto
[   87.490992] [pid:190,cpu1,kworker/u24:5]usb usb7: PM: calling usb_dev_suspend+0x0/0x20 @ 190, parent: xhci-hcd.4.auto
[   87.491078] [pid:326,cpu7,kworker/u24:9]usb usb8: PM: usb_dev_suspend+0x0/0x20 returned 0 after 103 usecs
[   87.491091] [pid:326,cpu7,kworker/u24:9]usb usb5: PM: calling usb_dev_suspend+0x0/0x20 @ 326, parent: xhci-hcd.2.auto
[   87.491097] [pid:325,cpu0,kworker/u24:8]usb usb6: PM: usb_dev_suspend+0x0/0x20 returned 0 after 98 usecs
[   87.491109] [pid:325,cpu0,kworker/u24:8]usb usb4: PM: calling usb_dev_suspend+0x0/0x20 @ 325, parent: xhci-hcd.1.auto
[   87.491195] [pid:190,cpu3,kworker/u24:5]usb usb7: PM: usb_dev_suspend+0x0/0x20 returned 0 after 181 usecs
[   87.491194] [pid:108,cpu9,kworker/u24:2]usb usb3: PM: calling usb_dev_suspend+0x0/0x20 @ 108, parent: xhci-hcd.1.auto
[   87.491246] [pid:190,cpu3,kworker/u24:5]usb usb2: PM: calling usb_dev_suspend+0x0/0x20 @ 190, parent: xhci-hcd.0.auto
[   87.491257] [pid:326,cpu0,kworker/u24:9]usb usb5: PM: usb_dev_suspend+0x0/0x20 returned 0 after 161 usecs
[   87.491268] [pid:326,cpu0,kworker/u24:9]usb usb1: PM: calling usb_dev_suspend+0x0/0x20 @ 326, parent: xhci-hcd.0.auto
[   87.491279] [pid:922,cpu8,kworker/u24:10]xhci-hcd xhci-hcd.5.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 922, parent: 92f0000.usb-controller
[   87.491303] [pid:326,cpu0,kworker/u24:9]usb usb1: PM: usb_dev_suspend+0x0/0x20 returned 0 after 31 usecs
[   87.491307] [pid:922,cpu8,kworker/u24:10]xhci-hcd xhci-hcd.5.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 18 usecs
[   87.491319] [pid:916,cpu7,bash]cdns-usbssp 92f0000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 92e0310.usb
[   87.491320] [pid:108,cpu9,kworker/u24:2]usb usb3: PM: usb_dev_suspend+0x0/0x20 returned 0 after 107 usecs
[   87.491327] [pid:916,cpu7,bash]cdns-usbssp 92f0000.usb-controller: [cdns_sky1_platform_suspend:226] xhci_dev name:xhci-hcd.5.auto, hcd->regs:ffff800089798000
[   87.491335] [pid:916,cpu7,bash]cdns-usbssp 92f0000.usb-controller: [cdns_sky1_platform_suspend:242] enter D3 succeed
[   87.491337] [pid:916,cpu7,bash]cdns-usbssp 92f0000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 12 usecs
[   87.491349] [pid:108,cpu9,kworker/u24:2]xhci-hcd xhci-hcd.4.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 108, parent: 92c0000.usb-controller
[   87.491375] [pid:108,cpu9,kworker/u24:2]xhci-hcd xhci-hcd.4.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 18 usecs
[   87.491387] [pid:916,cpu7,bash]cdns-usbssp 92c0000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 92b0310.usb
[   87.491393] [pid:916,cpu7,bash]cdns-usbssp 92c0000.usb-controller: [cdns_sky1_platform_suspend:226] xhci_dev name:xhci-hcd.4.auto, hcd->regs:ffff800089788000
[   87.491398] [pid:916,cpu7,bash]cdns-usbssp 92c0000.usb-controller: [cdns_sky1_platform_suspend:242] enter D3 succeed
[   87.491399] [pid:916,cpu7,bash]cdns-usbssp 92c0000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 7 usecs
[   87.491410] [pid:108,cpu9,kworker/u24:2]xhci-hcd xhci-hcd.3.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 108, parent: 9290000.usb-controller
[   87.491431] [pid:108,cpu9,kworker/u24:2]xhci-hcd xhci-hcd.3.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 16 usecs
[   87.491441] [pid:916,cpu7,bash]cdns-usbssp 9290000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 9280310.usb
[   87.491446] [pid:916,cpu7,bash]cdns-usbssp 9290000.usb-controller: [cdns_sky1_platform_suspend:226] xhci_dev name:xhci-hcd.3.auto, hcd->regs:ffff800089728000
[   87.491450] [pid:916,cpu7,bash]cdns-usbssp 9290000.usb-controller: [cdns_sky1_platform_suspend:242] enter D3 succeed
[   87.491452] [pid:916,cpu7,bash]cdns-usbssp 9290000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 7 usecs
[   87.491462] [pid:108,cpu9,kworker/u24:2]xhci-hcd xhci-hcd.2.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 108, parent: 9260000.usb-controller
[   87.491482] [pid:108,cpu9,kworker/u24:2]xhci-hcd xhci-hcd.2.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 16 usecs
[   87.491491] [pid:916,cpu7,bash]cdns-usbssp 9260000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 9250310.usb
[   87.491496] [pid:916,cpu7,bash]cdns-usbssp 9260000.usb-controller: [cdns_sky1_platform_suspend:226] xhci_dev name:xhci-hcd.2.auto, hcd->regs:ffff800089718000
[   87.491501] [pid:916,cpu7,bash]cdns-usbssp 9260000.usb-controller: [cdns_sky1_platform_suspend:242] enter D3 succeed
[   87.491502] [pid:916,cpu7,bash]cdns-usbssp 9260000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 7 usecs
[   87.517686] [pid:325,cpu0,kworker/u24:8]usb usb4: PM: usb_dev_suspend+0x0/0x20 returned 0 after 26570 usecs
[   87.517754] [pid:92,cpu1,kworker/u24:1]usb usb10: PM: usb_dev_suspend+0x0/0x20 returned 0 after 26970 usecs
[   87.517833] [pid:9,cpu6,kworker/u24:0]xhci-hcd xhci-hcd.6.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 9, parent: 90f0000.usb-controller
[   87.517861] [pid:9,cpu6,kworker/u24:0]xhci-hcd xhci-hcd.6.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 15 usecs
[   87.517965] [pid:190,cpu3,kworker/u24:5]usb usb2: PM: usb_dev_suspend+0x0/0x20 returned 0 after 26700 usecs
[   87.522648] [pid:324,cpu10,kworker/u24:7]rtc-rx8900 3-0032: PM: rx8900_suspend+0x0/0x220 returned 0 after 2 usecs
[   87.533403] [pid:108,cpu9,kworker/u24:2]xhci-hcd xhci-hcd.1.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 108, parent: 91e0000.usb-controller
[   88.148704] [2025:05:01 09:09:17][pid:108,cpu2,kworker/u24:2]xhci-hcd xhci-hcd.1.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 25 usecs
[   88.161913] [pid:916,cpu7,bash]cdns-usbssp 91e0000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 91c0324.usb
[   88.174012] [pid:916,cpu7,bash]cdns-usbssp 91e0000.usb-controller: [cdns_sky1_platform_suspend:226] xhci_dev name:xhci-hcd.1.auto, hcd->regs:ffff800089708000
[   88.188089] [pid:916,cpu7,bash]cdns-usbssp 91e0000.usb-controller: [cdns_sky1_platform_suspend:242] enter D3 succeed
[   88.198603] [pid:916,cpu7,bash]cdns-usbssp 91e0000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 24593 usecs
[   88.210226] [pid:108,cpu5,kworker/u24:2]xhci-hcd xhci-hcd.0.auto: PM: calling platform_pm_suspend+0x0/0x70 @ 108, parent: 91d0000.usb-controller
[   88.223223] [pid:108,cpu5,kworker/u24:2]xhci-hcd xhci-hcd.0.auto: PM: platform_pm_suspend+0x0/0x70 returned 0 after 13 usecs
[   88.234499] [pid:916,cpu7,bash]cdns-usbssp 91d0000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 91c0314.usb
[   88.246600] [pid:916,cpu7,bash]cdns-usbssp 91d0000.usb-controller: [cdns_sky1_platform_suspend:226] xhci_dev name:xhci-hcd.0.auto, hcd->regs:ffff8000896a8000
[   88.260677] [pid:916,cpu7,bash]cdns-usbssp 91d0000.usb-controller: [cdns_sky1_platform_suspend:242] enter D3 succeed
[   88.271191] [pid:916,cpu7,bash]cdns-usbssp 91d0000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 24594 usecs
[   88.282760] [pid:916,cpu7,bash]cdns-usbssp 9160000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 9150310.usb
[   88.294837] [pid:916,cpu7,bash]cdns-usbssp 9160000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   88.306047] [pid:916,cpu7,bash]cdns-usbssp 90f0000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 90e0310.usb
[   88.318124] [pid:916,cpu7,bash]cdns-usbssp 90f0000.usb-controller: [cdns_sky1_platform_suspend:226] xhci_dev name:xhci-hcd.6.auto, hcd->regs:ffff8000897e8000
[   88.332199] [pid:916,cpu7,bash]cdns-usbssp 90f0000.usb-controller: [cdns_sky1_platform_suspend:242] enter D3 succeed
[   88.342711] [pid:916,cpu7,bash]cdns-usbssp 90f0000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 24588 usecs
[   88.354271] [pid:916,cpu7,bash]cdns-usbssp 9080000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 9070310.usb
[   88.354320] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: calling pci_pm_suspend+0x0/0x1b0 @ 322, parent: 0000:90:00.0
[   88.366345] [pid:916,cpu7,bash]cdns-usbssp 9080000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   88.366353] [pid:916,cpu7,bash]cdns-usbssp 9010000.usb-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 9000310.usb
[   88.377556] [pid:322,cpu11,kworker/u24:6][HANS] fun = nvme_suspend, line = 3285 ...........
[   88.388791] [pid:916,cpu7,bash]cdns-usbssp 9010000.usb-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 34 usecs
[   88.420561] [pid:916,cpu7,bash]RTL8211F Gigabit Ethernet 9320000.ethernet-ffffffff:01: PM: calling mdio_bus_phy_suspend+0x0/0x11c @ 916, parent: 9320000.ethernet-ffffffff
[   88.435767] [pid:916,cpu7,bash]RTL8211F Gigabit Ethernet 9320000.ethernet-ffffffff:01: PM: mdio_bus_phy_suspend+0x0/0x11c returned 0 after 0 usecs
[   88.448889] [pid:916,cpu7,bash]platform Fixed MDIO bus.0: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.459922] [pid:916,cpu7,bash]platform Fixed MDIO bus.0: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.470357] [pid:916,cpu7,bash]cix_nanohub cix_nanohub: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.481217] [pid:916,cpu7,bash]cix_nanohub cix_nanohub: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.491501] [pid:916,cpu7,bash]serial8250 serial8250: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.502187] [pid:916,cpu7,bash]serial8250 serial8250: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   88.521853] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: pci_pm_suspend+0x0/0x1b0 returned 0 after 144297 usecs
[   88.532654] [pid:108,cpu5,kworker/u24:2]pcieport 0000:90:00.0: PM: calling pci_pm_suspend+0x0/0x1b0 @ 108, parent: pci0000:90
[   88.543997] [pid:108,cpu5,kworker/u24:2]pcieport 0000:90:00.0: PM: pci_pm_suspend+0x0/0x1b0 returned 0 after 22 usecs
[   88.554734] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   88.565268] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.575443] [pid:916,cpu7,bash]pwm pwmchip1: PM: calling pwm_class_suspend+0x0/0x13c @ 916, parent: 4111000.pwm1
[   88.585613] [pid:916,cpu7,bash]pwm pwmchip1: PM: pwm_class_suspend+0x0/0x13c returned 0 after 0 usecs
[   88.594826] [pid:916,cpu7,bash]pwm pwmchip0: PM: calling pwm_class_suspend+0x0/0x13c @ 916, parent: 4110000.pwm0
[   88.604993] [pid:916,cpu7,bash]pwm pwmchip0: PM: pwm_class_suspend+0x0/0x13c returned 0 after 0 usecs
[   88.614236] [pid:916,cpu7,bash]platform regulatory.0: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.624922] [pid:916,cpu7,bash]platform regulatory.0: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.635045] [pid:916,cpu7,bash]dummy dummy_codec: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.645397] [pid:916,cpu7,bash]dummy dummy_codec: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.655129] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core11: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.668161] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core11: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   88.680585] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core10: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.693614] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core10: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.706038] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core9: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.718980] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core9: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   88.731317] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core8: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.744260] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core8: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.756595] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core7: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.769537] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core7: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.781873] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core6: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.794815] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core6: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.807151] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core5: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.820095] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core5: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.832431] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core4: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.845373] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core4: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.857708] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core3: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.870652] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core3: PM: platform_pm_suspend+0x0/0x70 returned 0 after 1 usecs
[   88.882987] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core2: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.895929] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core2: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.908264] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core1: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.921206] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core1: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.933551] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core0: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.946494] [pid:916,cpu7,bash]sky1_exception_core_cache cache_exception_core0: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.958830] [pid:916,cpu7,bash]sky1_exception_dsu_cache dsu_cache_exception: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.971513] [pid:916,cpu7,bash]sky1_exception_dsu_cache dsu_cache_exception: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   88.983588] [pid:916,cpu7,bash]ddr exception c070000.ddr_ctrl: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   88.995063] [pid:916,cpu7,bash]ddr exception c070000.ddr_ctrl: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.005923] [pid:916,cpu7,bash]ddr exception c050000.ddr_ctrl: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.017390] [pid:916,cpu7,bash]ddr exception c050000.ddr_ctrl: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.028251] [pid:916,cpu7,bash]ddr exception c030000.ddr_ctrl: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.039717] [pid:916,cpu7,bash]ddr exception c030000.ddr_ctrl: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.050576] [pid:916,cpu7,bash]ddr exception c010000.ddr_ctrl: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.062042] [pid:916,cpu7,bash]ddr exception c010000.ddr_ctrl: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.072903] [pid:916,cpu7,bash]rdr ap driver cix_dst:ap_adapter: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: cix_dst
[   89.084457] [pid:916,cpu7,bash]rdr ap driver cix_dst:ap_adapter: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.095491] [pid:916,cpu7,bash]rdr exception trace driver cix_dst:exception_trace: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: cix_dst
[   89.108607] [pid:916,cpu7,bash]rdr exception trace driver cix_dst:exception_trace: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.121204] [pid:916,cpu7,bash]rdr driver cix_dst: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.131629] [pid:916,cpu7,bash]rdr driver cix_dst: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.141447] [pid:916,cpu7,bash]cix-ddr-lp cix_ddr_lp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.152134] [2025:05:01 09:09:18][pid:916,cpu7,bash]cix-ddr-lp cix_ddr_lp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.164037] [pid:916,cpu7,bash]cpu-ipa 83bf0300.cix_cpu_ipa: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.175331] [pid:916,cpu7,bash]cpu-ipa 83bf0300.cix_cpu_ipa: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.186018] [pid:916,cpu7,bash]platform 84380000.ap2tf-shmem: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.197398] [pid:916,cpu7,bash]platform 84380000.ap2tf-shmem: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.208172] [pid:916,cpu7,bash]platform 65a0000.pm2pm-shmem: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.219465] [pid:916,cpu7,bash]platform 65a0000.pm2pm-shmem: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.230152] [pid:916,cpu7,bash]platform 6590000.ap2pm-shmem: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.241445] [pid:916,cpu7,bash]platform 6590000.ap2pm-shmem: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.252132] [pid:916,cpu7,bash]cix_se2ap_mbox soc@0:cix_se2ap_mbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.263772] [pid:916,cpu7,bash]cix_se2ap_mbox soc@0:cix_se2ap_mbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.275067] [pid:916,cpu7,bash]cix_mbox 5070000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.286012] [pid:916,cpu7,bash]cix_mbox 5070000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.296352] [pid:916,cpu7,bash]cix_mbox 5060000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   89.307298] [pid:916,cpu7,bash]cix_mbox 5060000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.317639] [pid:916,cpu7,bash]platform 142a0000.phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.328064] [pid:916,cpu7,bash]platform 142a0000.phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.338144] [pid:916,cpu7,bash]platform 14280000.csi: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.348568] [pid:916,cpu7,bash]platform 14280000.csi: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.358648] [pid:916,cpu7,bash]platform 142b0000.cix_bridge: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.369679] [pid:916,cpu7,bash]platform 142b0000.cix_bridge: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.380368] [pid:916,cpu7,bash]cdns-gpio 4150000.gpio-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.391835] [pid:916,cpu7,bash]cdns-gpio 4150000.gpio-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.402959] [pid:916,cpu7,bash]cdns-gpio 4130000.gpio-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.414426] [pid:916,cpu7,bash]cdns-gpio 4130000.gpio-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.425548] [pid:916,cpu7,bash]macb 9320000.ethernet: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.436359] [pid:916,cpu7,bash]macb 9320000.ethernet: gem-ptp-timer ptp clock unregistered.
[   89.445007] [pid:916,cpu7,bash]macb 9320000.ethernet: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9033 usecs
[   89.455352] [pid:916,cpu7,bash]cdns-gpio 4120000.gpio-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.466821] [pid:916,cpu7,bash]cdns-gpio 4120000.gpio-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.477943] [pid:916,cpu7,bash]pwm-sky1 4111000.pwm1: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.488375] [pid:916,cpu7,bash]pwm-sky1 4111000.pwm1: PM: platform_pm_suspend+0x0/0x70 returned 0 after 5 usecs
[   89.498455] [pid:916,cpu7,bash]pwm-sky1 4110000.pwm0: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.508884] [pid:916,cpu7,bash]pwm-sky1 4110000.pwm0: PM: platform_pm_suspend+0x0/0x70 returned 0 after 2 usecs
[   89.518963] [pid:916,cpu7,bash]sky1_timer 4116000.gpt_timer: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.529996] [pid:916,cpu7,bash]sky1_timer 4116000.gpt_timer: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   89.540686] [pid:916,cpu7,bash]trilin-dptx-cix 14144000.dp: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   89.551633] [pid:916,cpu7,bash]trilin-dptx-cix 14144000.dp: [drm:trilin_dptx_pm_suspend][info]enter!
[   89.560756] [pid:916,cpu7,bash]trilin-dptx-cix 14144000.dp: [drm:trilin_dp_pm_prepare][info]enter.
[   89.569717] [pid:916,cpu7,bash]cix-edp-panel panel_edp0: cix_edp_panel_unprepare, begin
[   90.109576] [pid:916,cpu7,bash]cix-edp-panel panel_edp0: cix_edp_panel_unprepare, end
[   90.117478] [pid:916,cpu7,bash]trilin-dptx-cix 14144000.dp: PM: platform_pm_suspend+0x0/0x70 returned 0 after 565846 usecs
[   90.128529] [pid:916,cpu7,bash]cix-pcie-phy a0f0000.pcie_phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.139651] [pid:916,cpu7,bash]cix-pcie-phy a0f0000.pcie_phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.150428] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.161548] [2025:05:01 09:09:19][pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.174145] [pid:916,cpu7,bash]cix-pcie-phy a020000.pcie_phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.185265] [pid:916,cpu7,bash]cix-pcie-phy a020000.pcie_phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.196039] [pid:916,cpu7,bash]cdnsp-sky1 92e0310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.206553] [pid:916,cpu7,bash]cdnsp-sky1 92e0310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.216035] [pid:916,cpu7,bash]cdnsp-sky1 92e0310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9483 usecs
[   90.226464] [pid:916,cpu7,bash]cdnsp-sky1 92b0310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.236977] [pid:916,cpu7,bash]cdnsp-sky1 92b0310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.246515] [pid:916,cpu7,bash]cdnsp-sky1 92b0310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9538 usecs
[   90.256943] [pid:916,cpu7,bash]cdnsp-sky1 9280310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.267456] [pid:916,cpu7,bash]cdnsp-sky1 9280310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.276898] [pid:916,cpu7,bash]cdnsp-sky1 9280310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9441 usecs
[   90.287328] [pid:916,cpu7,bash]cdnsp-sky1 9250310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.297841] [pid:916,cpu7,bash]cdnsp-sky1 9250310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.307317] [pid:916,cpu7,bash]cdnsp-sky1 9250310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9475 usecs
[   90.317746] [pid:916,cpu7,bash]cix-usb3-phy 9210000.usb-phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.328780] [pid:916,cpu7,bash]cix-usb3-phy 9210000.usb-phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.339469] [pid:916,cpu7,bash]cdnsp-sky1 91c0324.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.349982] [pid:916,cpu7,bash]cdnsp-sky1 91c0324.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.359417] [pid:916,cpu7,bash]cdnsp-sky1 91c0324.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9434 usecs
[   90.369847] [pid:916,cpu7,bash]cdnsp-sky1 91c0314.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.380360] [pid:916,cpu7,bash]cdnsp-sky1 91c0314.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.389837] [pid:916,cpu7,bash]cdnsp-sky1 91c0314.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9477 usecs
[   90.400266] [pid:916,cpu7,bash]cix-usbdp-phy 9180000.usb-phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.411387] [pid:916,cpu7,bash]cix-usbdp-phy 9180000.usb-phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.422164] [pid:916,cpu7,bash]cdnsp-sky1 9150310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.432677] [pid:916,cpu7,bash]cdnsp-sky1 9150310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.442114] [pid:916,cpu7,bash]cdnsp-sky1 9150310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9436 usecs
[   90.452546] [pid:916,cpu7,bash]cix-usbdp-phy 9110000.usb-phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.463667] [pid:916,cpu7,bash]cix-usbdp-phy 9110000.usb-phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.474443] [pid:916,cpu7,bash]cdnsp-sky1 90e0310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.484956] [pid:916,cpu7,bash]cdnsp-sky1 90e0310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.494502] [pid:916,cpu7,bash]cdnsp-sky1 90e0310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9546 usecs
[   90.504933] [pid:916,cpu7,bash]cix-usbdp-phy 90a0000.usb-phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.516053] [pid:916,cpu7,bash]cix-usbdp-phy 90a0000.usb-phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.526831] [pid:916,cpu7,bash]cdnsp-sky1 9070310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.537344] [pid:916,cpu7,bash]cdnsp-sky1 9070310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.546817] [pid:916,cpu7,bash]cdnsp-sky1 9070310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9472 usecs
[   90.557245] [pid:916,cpu7,bash]cix-usbdp-phy 9030000.usb-phy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.568367] [pid:916,cpu7,bash]cix-usbdp-phy 9030000.usb-phy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.579142] [pid:916,cpu7,bash]cdnsp-sky1 9000310.usb: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.589655] [pid:916,cpu7,bash]cdnsp-sky1 9000310.usb: ---------sky1_usb_clk_disable_suspend----------
[   90.599153] [pid:916,cpu7,bash]cdnsp-sky1 9000310.usb: PM: platform_pm_suspend+0x0/0x70 returned 0 after 9498 usecs
[   90.609581] [pid:916,cpu7,bash]platform 8000000.sensor-mcu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.620527] [pid:916,cpu7,bash]platform 8000000.sensor-mcu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.631136] [pid:916,cpu7,bash]arm-dma350 4190000.dma-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.642604] [pid:916,cpu7,bash]arm-dma350 4190000.dma-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.653734] [pid:916,cpu7,bash]cdns-spi 40a0000.spi: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.664079] [pid:916,cpu7,bash]cdns-spi 40a0000.spi: PM: platform_pm_suspend+0x0/0x70 returned 0 after 7 usecs
[   90.674072] [pid:916,cpu7,bash]cdns-spi 4090000.spi: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.684415] [pid:916,cpu7,bash]cdns-spi 4090000.spi: PM: platform_pm_suspend+0x0/0x70 returned 0 after 4 usecs
[   90.694408] [pid:916,cpu7,bash]cdns-i2c 4080000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.704748] [pid:916,cpu7,bash]cdns-i2c 4080000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 2 usecs
[   90.714740] [pid:916,cpu7,bash]cdns-i2c 4070000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.725168] [pid:916,cpu7,bash]cdns-i2c 4070000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 90 usecs
[   90.735250] [pid:916,cpu7,bash]cdns-i2c 4060000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.745686] [pid:916,cpu7,bash]cdns-i2c 4060000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 97 usecs
[   90.755767] [pid:916,cpu7,bash]cdns-i2c 4050000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.766110] [pid:916,cpu7,bash]cdns-i2c 4050000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 4 usecs
[   90.776105] [pid:916,cpu7,bash]cdns-i2c 4040000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.786541] [pid:916,cpu7,bash]cdns-i2c 4040000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 96 usecs
[   90.796622] [pid:916,cpu7,bash]cdns-i2c 4030000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.806963] [pid:916,cpu7,bash]cdns-i2c 4030000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 2 usecs
[   90.816958] [pid:916,cpu7,bash]cdns-i2c 4020000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.827300] [pid:916,cpu7,bash]cdns-i2c 4020000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 4 usecs
[   90.837297] [pid:916,cpu7,bash]cdns-i2c 4010000.i2c: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.847639] [pid:916,cpu7,bash]cdns-i2c 4010000.i2c: PM: platform_pm_suspend+0x0/0x70 returned 0 after 2 usecs
[   90.857640] [pid:916,cpu7,bash]arm-scmi firmware:scmi: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   90.868413] [pid:916,cpu7,bash]arm-scmi firmware:scmi: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.878580] [pid:916,cpu7,bash]cix_mbox 65a0000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   90.889526] [pid:916,cpu7,bash]cix_mbox 65a0000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.899865] [pid:916,cpu7,bash]cix_mbox 6590000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   90.910811] [pid:916,cpu7,bash]cix_mbox 6590000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.921151] [pid:916,cpu7,bash]cix_mbox 80a0000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   90.932097] [pid:916,cpu7,bash]cix_mbox 80a0000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.942445] [pid:916,cpu7,bash]cix_mbox 8090000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   90.953397] [pid:916,cpu7,bash]cix_mbox 8090000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.963738] [pid:916,cpu7,bash]platform soc@0:cix_dph_1: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.974425] [pid:916,cpu7,bash]platform soc@0:cix_dph_1: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   90.984764] [pid:916,cpu7,bash]platform 14270000.cix_csi_rcsu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   90.995971] [pid:916,cpu7,bash]platform 14270000.cix_csi_rcsu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.006838] [pid:916,cpu7,bash]sky1-nvmem soc@0:nvmem_fw: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.017611] [pid:916,cpu7,bash]sky1-nvmem soc@0:nvmem_fw: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.028041] [pid:916,cpu7,bash]sky1-pinctrl 4170000.pinctrl_sky1: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.039510] [pid:916,cpu7,bash]sky1-pinctrl 4170000.pinctrl_sky1: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.050633] [pid:916,cpu7,bash]sky1-pinctrl 16007000.pinctrl_s5_sky1: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.062453] [pid:916,cpu7,bash]sky1-pinctrl 16007000.pinctrl_s5_sky1: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.073927] [pid:916,cpu7,bash]cdns-gpio 16004000.gpio-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.085481] [pid:916,cpu7,bash]cdns-gpio 16004000.gpio-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.096691] [pid:916,cpu7,bash]reset_sky1 4160000.reset-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.108333] [pid:916,cpu7,bash]reset_sky1 4160000.reset-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.119628] [pid:916,cpu7,bash]reset_sky1 16000000.reset-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.131355] [pid:916,cpu7,bash]reset_sky1 16000000.reset-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.142738] [pid:916,cpu7,bash]sky1-wdt 16003000.watchdog: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.153606] [pid:916,cpu7,bash]sky1_wdt_suspend-, ret=0
[   91.158823] [pid:916,cpu7,bash]sky1-wdt 16003000.watchdog: PM: platform_pm_suspend+0x0/0x70 returned 0 after 5225 usecs
[   91.169597] [2025:05:01 09:09:20][pid:916,cpu7,bash]sky1_hwspinlock 6510000.hwspinlock: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.182976] [pid:916,cpu7,bash]sky1_hwspinlock 6510000.hwspinlock: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.194187] [pid:916,cpu7,bash]simple_protected_memory_allocator soc@0:protected-memory-allocator: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.208519] [pid:916,cpu7,bash]simple_protected_memory_allocator soc@0:protected-memory-allocator: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.222507] [pid:916,cpu7,bash]physical-memory-group-manager soc@0:physical-memory-group-manager: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.236753] [pid:916,cpu7,bash]physical-memory-group-manager soc@0:physical-memory-group-manager: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.250653] [pid:916,cpu7,bash]platform soc@0:isp_fake3: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.261341] [pid:916,cpu7,bash]platform soc@0:isp_fake3: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.271680] [pid:916,cpu7,bash]platform soc@0:isp_fake2: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.282367] [pid:916,cpu7,bash]platform soc@0:isp_fake2: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.292708] [pid:916,cpu7,bash]platform soc@0:isp_fake1: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.303394] [pid:916,cpu7,bash]platform soc@0:isp_fake1: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.313735] [pid:916,cpu7,bash]arm-cmn 10010000.cmn_pmu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.324421] [pid:916,cpu7,bash]arm-cmn 10010000.cmn_pmu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.334762] [pid:916,cpu7,bash]arm_dsu_pmu soc@0:dsu_pmu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.345536] [pid:916,cpu7,bash]arm_dsu_pmu soc@0:dsu_pmu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.355965] [pid:916,cpu7,bash]platform 9310000.gmac_rcsu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.366824] [pid:916,cpu7,bash]platform 9310000.gmac_rcsu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.377339] [pid:916,cpu7,bash]cix-se-pm-crash soc@0:cix_se_pm_crash: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.389154] [pid:916,cpu7,bash]cix-se-pm-crash soc@0:cix_se_pm_crash: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.400624] [pid:916,cpu7,bash]scp soc@0:sfh_scp@08100000: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.411484] [pid:916,cpu7,bash]scp soc@0:sfh_scp@08100000: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.421999] [pid:916,cpu7,bash]platform 8080000.sfh_cru: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.432685] [pid:916,cpu7,bash]platform 8080000.sfh_cru: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.443027] [pid:916,cpu7,bash]reset_sky1_audss 7110000.system-controller:reset-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: 7110000.system-controller
[   91.458488] [pid:916,cpu7,bash]reset_sky1_audss 7110000.system-controller:reset-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.471867] [pid:916,cpu7,bash]platform 7110000.system-controller: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.483421] [pid:916,cpu7,bash]platform 7110000.system-controller: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.494629] [pid:916,cpu7,bash]cix_mbox 7100000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.505316] [pid:916,cpu7,bash]cix_mbox 7100000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.515657] [pid:916,cpu7,bash]cix_mbox 70f0000.mailbox: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.526343] [pid:916,cpu7,bash]cix_mbox 70f0000.mailbox: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.536682] [pid:916,cpu7,bash]platform 416009c.fch_cru: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: soc@0
[   91.547369] [pid:916,cpu7,bash]platform 416009c.fch_cru: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.557731] [pid:916,cpu7,bash]simple-pm-bus soc@0: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.568243] [pid:916,cpu7,bash]simple-pm-bus soc@0: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.578150] [pid:916,cpu7,bash]platform timer: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.588228] [pid:916,cpu7,bash]platform timer: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.597701] [pid:916,cpu7,bash]platform 16000000.pdc: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.608387] [pid:916,cpu7,bash]platform 16000000.pdc: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.618467] [pid:916,cpu7,bash]psci-cpuidle-domain psci: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.629414] [pid:916,cpu7,bash]psci-cpuidle-domain psci: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.639757] [pid:916,cpu7,bash]arm_spe_pmu spe_pmu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.650270] [pid:916,cpu7,bash]arm_spe_pmu spe_pmu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.660176] [pid:916,cpu7,bash]armv8-pmu pmu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.670167] [pid:916,cpu7,bash]armv8-pmu pmu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.679552] [pid:916,cpu7,bash]arm-smmu-v3 b1b0000.iommu: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.690596] [pid:916,cpu7,bash]arm-smmu-v3 b1b0000.iommu: PM: platform_pm_suspend+0x0/0x70 returned 0 after 10 usecs
[   91.701111] [pid:916,cpu7,bash]optee firmware:optee: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.711711] [pid:916,cpu7,bash]optee firmware:optee: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.721706] [pid:916,cpu7,bash]sdei firmware:sdei-smc: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.732691] [pid:916,cpu7,bash]sdei firmware:sdei-smc: PM: platform_pm_suspend+0x0/0x70 returned 0 after 210 usecs
[   91.743032] [pid:916,cpu7,bash]arm-scmi firmware:scmi-smc: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.754153] [pid:916,cpu7,bash]arm-scmi firmware:scmi-smc: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.764670] [pid:916,cpu7,bash]ramoops 83d00000.cix_ramoops: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.775964] [pid:916,cpu7,bash]ramoops 83d00000.cix_ramoops: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.786656] [pid:916,cpu7,bash]regulator regulator.0: PM: calling regulator_suspend+0x0/0x114 @ 916, parent: reg-dummy
[   91.797348] [pid:916,cpu7,bash]regulator regulator.0: PM: regulator_suspend+0x0/0x114 returned 0 after 1 usecs
[   91.807342] [pid:916,cpu7,bash]reg-dummy reg-dummy: PM: calling platform_pm_suspend+0x0/0x70 @ 916, parent: platform
[   91.817854] [pid:916,cpu7,bash]reg-dummy reg-dummy: PM: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   91.828412] [pid:324,cpu10,kworker/u24:7]nvme 0000:91:00.0: PM: calling pci_pm_suspend_late+0x0/0x60 @ 324, parent: 0000:90:00.0
[   91.840006] [pid:324,cpu10,kworker/u24:7]nvme 0000:91:00.0: PM: pci_pm_suspend_late+0x0/0x60 returned 0 after 1 usecs
[   91.850673] [pid:325,cpu0,kworker/u24:8]pcieport 0000:90:00.0: PM: calling pci_pm_suspend_late+0x0/0x60 @ 325, parent: pci0000:90
[   91.862362] [pid:325,cpu0,kworker/u24:8]pcieport 0000:90:00.0: PM: pci_pm_suspend_late+0x0/0x60 returned 0 after 1 usecs
[   91.873418] [pid:916,cpu7,bash]cdns-gpio 4150000.gpio-controller: PM: calling cdns_gpio_suspend+0x0/0x210 @ 916, parent: soc@0
[   91.884843] [pid:916,cpu7,bash]cdns-gpio 4150000.gpio-controller: PM: cdns_gpio_suspend+0x0/0x210 returned 0 after 4 usecs
[   91.895882] [pid:916,cpu7,bash]cdns-gpio 4130000.gpio-controller: PM: calling cdns_gpio_suspend+0x0/0x210 @ 916, parent: soc@0
[   91.907270] [pid:916,cpu7,bash]cdns-gpio 4130000.gpio-controller: PM: cdns_gpio_suspend+0x0/0x210 returned 0 after 3 usecs
[   91.918309] [pid:916,cpu7,bash]cdns-gpio 4120000.gpio-controller: PM: calling cdns_gpio_suspend+0x0/0x210 @ 916, parent: soc@0
[   91.929797] [pid:916,cpu7,bash]cdns-gpio 4120000.gpio-controller: PM: cdns_gpio_suspend+0x0/0x210 returned 0 after 106 usecs
[   91.941023] [pid:916,cpu7,bash]sky1-audss-clk 7110000.system-controller:clock-controller: PM: calling pm_runtime_force_suspend+0x0/0x134 @ 916, parent: 7110000.system-controller
[   91.956841] [pid:916,cpu7,bash]sky1-audss-clk 7110000.system-controller:clock-controller: PM: pm_runtime_force_suspend+0x0/0x134 returned 0 after 0 usecs
[   91.970583] [pid:916,cpu7,bash]sky1-pinctrl 4170000.pinctrl_sky1: PM: calling sky1_pinctrl_suspend+0x0/0x2c @ 916, parent: soc@0
[   91.982155] [pid:916,cpu7,bash]sky1-pinctrl 4170000.pinctrl_sky1: PM: sky1_pinctrl_suspend+0x0/0x2c returned 0 after 4 usecs
[   91.993363] [pid:916,cpu7,bash]sky1-pinctrl 16007000.pinctrl_s5_sky1: PM: calling sky1_pinctrl_suspend+0x0/0x2c @ 916, parent: soc@0
[   92.005267] [pid:916,cpu7,bash]sky1-pinctrl 16007000.pinctrl_s5_sky1: PM: sky1_pinctrl_suspend+0x0/0x2c returned 0 after 2 usecs
[   92.016823] [pid:916,cpu7,bash]cdns-gpio 16004000.gpio-controller: PM: calling cdns_gpio_suspend+0x0/0x210 @ 916, parent: soc@0
[   92.028298] [pid:916,cpu7,bash]cdns-gpio 16004000.gpio-controller: PM: cdns_gpio_suspend+0x0/0x210 returned 0 after 5 usecs
[   92.039589] [pid:916,cpu7,bash]genpd genpd:5:14230000.vpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.050378] [pid:916,cpu7,bash]genpd genpd:5:14230000.vpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 1 usecs
[   92.060904] [pid:916,cpu7,bash]genpd genpd:4:14230000.vpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.071678] [pid:916,cpu7,bash]genpd genpd:4:14230000.vpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.082194] [pid:916,cpu7,bash]genpd genpd:3:14230000.vpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.092968] [pid:916,cpu7,bash]genpd genpd:3:14230000.vpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.103484] [pid:916,cpu7,bash]genpd genpd:2:14230000.vpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.114258] [pid:916,cpu7,bash]genpd genpd:2:14230000.vpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.124772] [pid:916,cpu7,bash]genpd genpd:1:14230000.vpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.135546] [pid:916,cpu7,bash]genpd genpd:1:14230000.vpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.146062] [pid:916,cpu7,bash]genpd genpd:0:14230000.vpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.156837] [pid:916,cpu7,bash]genpd genpd:0:14230000.vpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.167354] [pid:916,cpu7,bash]genpd genpd:3:14260000.aipu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.178215] [2025:05:01 09:09:21][pid:916,cpu7,bash]genpd genpd:3:14260000.aipu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.190640] [pid:916,cpu7,bash]genpd genpd:2:14260000.aipu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.201503] [pid:916,cpu7,bash]genpd genpd:2:14260000.aipu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.212105] [pid:916,cpu7,bash]genpd genpd:1:14260000.aipu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.222967] [pid:916,cpu7,bash]genpd genpd:1:14260000.aipu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 1 usecs
[   92.233568] [pid:916,cpu7,bash]genpd genpd:0:14260000.aipu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.244428] [pid:916,cpu7,bash]genpd genpd:0:14260000.aipu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.255031] [pid:916,cpu7,bash]genpd genpd:0:15000000.gpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.265805] [pid:916,cpu7,bash]genpd genpd:0:15000000.gpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.276318] [pid:916,cpu7,bash]genpd genpd:1:15000000.gpu: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: none
[   92.287092] [pid:916,cpu7,bash]genpd genpd:1:15000000.gpu: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.297608] [pid:916,cpu7,bash]linlondp 141d0000.disp-controller: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: soc@0
[   92.309077] [pid:916,cpu7,bash]linlondp 141d0000.disp-controller: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.320282] [pid:916,cpu7,bash]linlondp 14160000.disp-controller: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: soc@0
[   92.331751] [pid:916,cpu7,bash]linlondp 14160000.disp-controller: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.342949] [pid:916,cpu7,bash]linlondp 140f0000.disp-controller: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: soc@0
[   92.354417] [pid:916,cpu7,bash]linlondp 140f0000.disp-controller: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.365564] [pid:916,cpu7,bash]linlondp 14080000.disp-controller: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: soc@0
[   92.377031] [pid:916,cpu7,bash]linlondp 14080000.disp-controller: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.388231] [pid:916,cpu7,bash]linlondp 14010000.disp-controller: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: soc@0
[   92.399698] [pid:916,cpu7,bash]linlondp 14010000.disp-controller: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 0 usecs
[   92.411265] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: calling pci_pm_suspend_noirq+0x0/0x2c0 @ 322, parent: 0000:90:00.0
[   92.423028] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 1 usecs
[   92.433894] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM: calling pci_pm_suspend_noirq+0x0/0x2c0 @ 324, parent: pci0000:90
[   92.445880] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM: pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 39 usecs
[   92.457227] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling sky1_pcie_suspend_noirq+0x0/0x174 @ 916, parent: soc@0
[   92.479315] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy: pcie_phy_common_exit end
[   92.487389] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: sky1_pcie_suspend_noirq
[   92.494604] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: sky1_pcie_suspend_noirq+0x0/0x174 returned 0 after 26379 usecs
[   92.505619] [pid:916,cpu7,bash]sky1-audss-clk 7110000.system-controller:clock-controller: PM: calling genpd_suspend_noirq+0x0/0x80 @ 916, parent: 7110000.system-controller
[   92.520919] [pid:916,cpu7,bash]sky1-audss-clk 7110000.system-controller:clock-controller: PM: genpd_suspend_noirq+0x0/0x80 returned 0 after 1 usecs
[   92.534214] [pid:916,cpu7,bash]Disabling non-boot CPUs ...
[   92.542027] [pid:19,cpu1,migration/1][HANS] fun = __cpu_disable, line = 317 ...........
[   92.550148] [pid:19,cpu1,migration/1][HANS] fun = migrate_one_irq, line = 120 ...........
[   92.558410] [pid:19,cpu1,migration/1][HANS] fun = irq_shutdown_and_deactivate, line = 325 ...........
[   92.567711] [pid:19,cpu1,migration/1][HANS] fun = irq_shutdown, line = 308 ...........
[   92.575712] [pid:19,cpu1,migration/1][HANS] fun = pci_msix_mask, line = 67 irq = 94
[   92.583449] [pid:19,cpu1,migration/1][HANS] fun = pci_msix_mask, line = 69 irq_desc->depth = 1
[   92.592142] [pid:19,cpu1,migration/1]CPU: 1 PID: 19 Comm: migration/1 Tainted: G S         O       6.1.44-cix-build-generic #242
[   92.603702] [pid:19,cpu1,migration/1]Hardware name: Cix Technology Group Co., Ltd. CIX Merak Board/CIX Merak Board, BIOS 1.0 Apr 14 2025
[   92.615953] [pid:19,cpu1,migration/1]Stopper: multi_cpu_stop+0x0/0x190 <- stop_machine_cpuslocked+0x138/0x184
[   92.625876] [pid:19,cpu1,migration/1]Call trace:
[   92.630490] [pid:19,cpu1,migration/1] dump_backtrace+0xdc/0x130
[   92.636409] [pid:19,cpu1,migration/1] show_stack+0x18/0x30
[   92.641891] [pid:19,cpu1,migration/1] dump_stack_lvl+0x64/0x80
[   92.647725] [pid:19,cpu1,migration/1] dump_stack+0x18/0x34
[   92.653209] [pid:19,cpu1,migration/1] pci_msix_mask+0x5c/0xcc
[   92.658956] [pid:19,cpu1,migration/1] pci_msi_mask_irq+0x48/0x4c
[   92.664963] [pid:19,cpu1,migration/1] its_mask_msi_irq+0x18/0x30
[   92.670970] [pid:19,cpu1,migration/1] irq_shutdown+0xc4/0xf4
[   92.676626] [pid:19,cpu1,migration/1] irq_shutdown_and_deactivate+0x38/0x50
[   92.683583] [pid:19,cpu1,migration/1] irq_migrate_all_off_this_cpu+0x2ec/0x300
[   92.690807] [pid:19,cpu1,migration/1] __cpu_disable+0xe0/0xf0
[   92.696554] [pid:19,cpu1,migration/1] take_cpu_down+0x3c/0xa4
[   92.702302] [pid:19,cpu1,migration/1] multi_cpu_stop+0x9c/0x190
[   92.708218] [pid:19,cpu1,migration/1] cpu_stopper_thread+0x84/0x11c
[   92.714482] [pid:19,cpu1,migration/1] smpboot_thread_fn+0x228/0x250
[   92.720749] [pid:19,cpu1,migration/1] kthread+0x108/0x10c
[   92.726147] [pid:19,cpu1,migration/1] ret_from_fork+0x10/0x20
[   92.731894] [pid:19,cpu1,migration/1][HANS] fun = pci_msix_mask, line = 71 ...........

Debugging information added for the test.
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9757f955655b..f28f2b49780d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -314,6 +314,7 @@ int __cpu_disable(void)
        /*
         * OK - migrate IRQs away from this CPU
         */
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        irq_migrate_all_off_this_cpu();
 
        return 0;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce2e628f94a0..184b902303e3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3263,6 +3263,7 @@ static int nvme_resume(struct device *dev)
        struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
        struct nvme_ctrl *ctrl = &ndev->ctrl;
 
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        if (ndev->last_ps == U32_MAX ||
            nvme_set_power_state(ctrl, ndev->last_ps) != 0)
                goto reset;
@@ -3281,6 +3282,7 @@ static int nvme_suspend(struct device *dev)
        struct nvme_ctrl *ctrl = &ndev->ctrl;
        int ret = -EBUSY;
 
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        ndev->last_ps = U32_MAX;
 
        /*
@@ -3354,6 +3356,7 @@ static int nvme_simple_suspend(struct device *dev)
 {
        struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        return nvme_disable_prepare_reset(ndev, true);
 }
 
@@ -3362,6 +3365,7 @@ static int nvme_simple_resume(struct device *dev)
        struct pci_dev *pdev = to_pci_dev(dev);
        struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        return nvme_try_sched_reset(&ndev->ctrl);
 }
 
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index fdd2ec09651e..0297c983c854 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -63,6 +63,12 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
+       struct irq_desc *irq_desc = NULL;;
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d irq = %d \n", __func__, __LINE__, desc->irq);
+       irq_desc = irq_to_desc(desc->irq);
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d irq_desc->depth = %d \n", __func__, __LINE__, irq_desc->depth);
+       dump_stack();
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
        pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
        /* Flush write to device */
@@ -71,6 +77,9 @@ static inline void pci_msix_mask(struct msi_desc *desc)
 
 static inline void pci_msix_unmask(struct msi_desc *desc)
 {
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
+       dump_stack();
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
        pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 }
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8ac37e8e738a..76225ad47bdf 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -305,6 +305,7 @@ static void __irq_disable(struct irq_desc *desc, bool mask);
 
 void irq_shutdown(struct irq_desc *desc)
 {
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        if (irqd_is_started(&desc->irq_data)) {
                desc->depth = 1;
                if (desc->irq_data.chip->irq_shutdown) {
@@ -321,6 +322,7 @@ void irq_shutdown(struct irq_desc *desc)
 
 void irq_shutdown_and_deactivate(struct irq_desc *desc)
 {
+       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
        irq_shutdown(desc);
        /*
         * This must be called even if the interrupt was never started up,
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..81feec6e5f9f 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -117,6 +117,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
                 */
                if (irqd_affinity_is_managed(d)) {
                        irqd_set_managed_shutdown(d);
+                       printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, __LINE__);
                        irq_shutdown_and_deactivate(desc);
                        return false;
                }


Best regards,
Hans

---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..2243fabd54e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3508,6 +3508,8 @@ static int nvme_suspend(struct device *dev)
 		 */
 		ret = nvme_disable_prepare_reset(ndev, true);
 		ctrl->npss = 0;
+	} else {
+		ret = nvme_disable_prepare_reset(ndev, true);
 	}
 unfreeze:
 	nvme_unfreeze(ctrl);

base-commit: 4f79eaa2ceac86a0e0f304b0bab556cca5bf4f30
-- 
2.47.1


