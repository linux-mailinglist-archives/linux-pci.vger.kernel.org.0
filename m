Return-Path: <linux-pci+bounces-12963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF89722F5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 21:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78406283DA5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2CE17C9B8;
	Mon,  9 Sep 2024 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="W219bAJQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020132.outbound.protection.outlook.com [52.101.61.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079963CF51
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911076; cv=fail; b=iXbQE0zm8EwyGfpqL4NHBr6NFVCuLIxvLDGKbTSlws27ZSYKbbVS50C9uf1W1E72e/TE0a1V9PY11OUP5KoS+wCQO9Hkf0io+RkVZWvhYcLAa/xfYVAJGmmRgNqTfE6e3rzQNIFLyGSPGNdIvJgmV/nngY5Yex7nuPTWuEz6V/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911076; c=relaxed/simple;
	bh=TZG4dh6n/VMFH3SLR0ARjA8Us0tgCV95u8GPvX1lNQs=;
	h=Date:From:To:Subject:Message-ID:Content-Type:MIME-Version; b=VNECMAooaJu9ABHRgjeTciQb2Nh82sqCk9kp137Y4ihnyHZS/Hty86/SiWNOuUWKLXbqBMnKf/kbzM7YXC1X3Oc4SuF4m13kKcOf9A8aDwkFomaVJOvUmPJ8hO8uW6ctPaVzaHJd7nnGTnacmfQWb+jR9qq2RyOyGuWZY5hOIUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=W219bAJQ; arc=fail smtp.client-ip=52.101.61.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBmVHR7Q0k9otByr/iH5vJAiYPeUnMaEcdY4RAWh+EjoRO7N7WNQ4qjTQ2BHDPM3idqAIcffOwp6opoEhV8prQmZKhWWnXvuDflTlj4uRlqsnovozsgt6wn9ig6lbTEuwkzNYN6TWmUPMWMuOjgPdkZlgx6s4J7OLpcEp/RfKoJGP3nwf7oGZdAhD6u3SxHXqtls0cFKvYsf1CnV6/9Pw3bG8jR6mnJOuumMewlh71yh8QtBAV9nLwrCufQ4bBDZkox5FHcKGP23WzTTNm5VKWCHLUF/+++h9jaHU6IqgrJkddv/ZBPYQUWlLcMmuX5+xbst0fglEMDDWz+FFE6hfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/JZfgWceCjkLsaYpVG6VW4Un+yVp9qqpBv31vLb+eE=;
 b=m5eIKmZ/CIvnBfJEy30n7D5hY+uj0JuXoS5I8PqyVoO5UrH/gbpvPzBQ6WhaXaOZqiFWvoNlW3FwAjHwlkQty1VJeFebu7Zd0G3SjtlndOHFNi2IVbeN9fATL/445F6A9jrtfe6ElP6e7SMMn1//p+LFAeztfh/twwWU/ugQGx8IA1Djkp6VItUn73dgoYKbqxL6tUYoAYI2pDwjibDrQlVH8NNcZNInNT7baa7tJWHZbpbpuS8+c2HGDTnFFWxigcNvdnbVT7aJIhTLFYNcvZsKdbeZL6XGn4gaKPrpAXuCVzrGXmj7MSZzpDKo5OgY4/PDbTM5ALAX7d6O5/6j+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/JZfgWceCjkLsaYpVG6VW4Un+yVp9qqpBv31vLb+eE=;
 b=W219bAJQSs3Z76OzQ2HrGkJzG/q9ODoxD+okuRdf/V7G+WF28lxwzUCwj3sOvRdc9uWObsz6dQ977aChzfsE6et5fP+M7AZiIUyDVH9UGfKKZREzQsB8En6UfaU3i0SxO0jXtR/U6eD8br6+R4Tah9z/ZQRLUd95zbK7g3GAFb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 IA0PR01MB8585.prod.exchangelabs.com (2603:10b6:208:48f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Mon, 9 Sep 2024 19:44:26 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 19:44:26 +0000
Date: Mon, 9 Sep 2024 12:44:19 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: linux-pci@vger.kernel.org, lukas@wunner.de, ian.may@canonical.com
Subject: Deadlock between reset_lock and pci_slot_mutex
Message-ID: <9db19c51-dd77-9114-2e7e-ee3fe4c3157@os.amperecomputing.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::18) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|IA0PR01MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b8f0e3-ee01-4577-83f9-08dcd107cffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0BtOU2Ms0zTkFjmsSjaZNNlGxb5Vr1iS7JqyHFz16nH08oaqYO/B4yjH6HEb?=
 =?us-ascii?Q?sz86RgaCiSAaEhyUAHyxrmc218lmhuMZurLPtljwOY//J1riVYb0BNOWmepl?=
 =?us-ascii?Q?lPpT1cjTbSoUrnOAI4xVTJTMjalOjHBuT9NQ9+/R2a7VLQVphfL8Tkg7YmhW?=
 =?us-ascii?Q?OT54o82Eo8fAKNsN/Vs4qwGAe/RF8vrPpeHb9Fjqq+++nK+CPR9Yvhdyj+9A?=
 =?us-ascii?Q?5MhmYuU97XQlYTO/dHjAISbMqA+FNLiDdULlYYSIOuhsyojajq8xdFGlfIty?=
 =?us-ascii?Q?OTP8MWvP3Uyte4kXeVJjhL4TzuR+FdQrNGR4Mq/TGf4FzWgVnA+jNfxHgKqh?=
 =?us-ascii?Q?Je9611vX0Sn1RiF6ikeSXKIazYl6poxKg1fwph+lkkY1fS5/opk/FiGR1PV6?=
 =?us-ascii?Q?RuSvCPNTPti3FPomYXfZVZuJgdXmfu4sfiOkPXi1WEbmYQaUenypln3zqAYj?=
 =?us-ascii?Q?W1Equ0K+aCqVnZ59RKjBYkt5HsnVO6WtXb6oKFWs7eqIJoe1WeSim9k4cNNV?=
 =?us-ascii?Q?Maqc4Is/NyW10NYYGpjAgYdy1J/O1IgxXWfCD8e0oIFpkxHYq85jpJmm6KoS?=
 =?us-ascii?Q?PSJS71ho9lB9eZmNrYw5dWPDdY5OFHpQQMmhRFreeZmLpo/km1U24y0A2lzR?=
 =?us-ascii?Q?xGqJNnD3INYXDiSYKsu+gbPLM4fXMeFG3qHH34aaZIF4u0d8A1ktRqSOvv8Y?=
 =?us-ascii?Q?SpEOFpZTdNVKI5WICXcb8r3OW0EnjEjR2kcBQBO+ZxnWVJUUxSdGLeTsvRKD?=
 =?us-ascii?Q?wyalADq80mWziG7u/7l9PYlU7UiZNdcFYAN26/vVY2RhA6wB3VjYDZw1tb1l?=
 =?us-ascii?Q?8j+mHMaLe1yZ/WboWbToMM9/bpocQPaPzuIp3yv8Lgg/ajGS134kihFro2VB?=
 =?us-ascii?Q?0H8mDZM+h0RFltBtzjQfQJ7wl2cSf5i//maw8Gf5TxEv0djlv6BDoWHpMYkw?=
 =?us-ascii?Q?q6LRzu/KlcUTTtbE9y1ip9SHSHLuRAky6udW4sqtUfONYTVqXo0109u2OdMM?=
 =?us-ascii?Q?7lYixVrzQmWjHW2VQCo+PLWgoo9rKoynnVQj7hCMpeXA8Y3KXS1yz4F1Q1sK?=
 =?us-ascii?Q?Ms7i8wuF5pI1iWK/qQePlEq8eew7bx6Id3I2Rgu3t+OMqK7uFfYYotXB21WY?=
 =?us-ascii?Q?TF1oHnk0GxooKr818S0dTEQBfdRSSe8tXpkYAImAlQe94KzjyUFjtqnMAXuV?=
 =?us-ascii?Q?jBiAlZqvVUIEFa6pmfyuyWKxp1zEvvyOBN/3P6D3I8inMCvs7rCHT2XjisNO?=
 =?us-ascii?Q?ARpTGUggtlrLcvIEV7PckRj0AUFmQf0rIfuR3MfCzx3lBPcDB7JKO+OrJq5/?=
 =?us-ascii?Q?oaEl5ohO9mApDjszZ27sWEFbudwwdBVKT70crWQ4w2y7XU2RdkeSGLp8X5s+?=
 =?us-ascii?Q?JxgNtXGDWzf4P8mOXj4s3LsdnI28V6G8BQ1mflaAf5yb+kw6FA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TpYcF4wg/YlrR/HKSkSvLiHrQorOFLZflZInpQwsIBoYvkkFTWGuBdJLOmGJ?=
 =?us-ascii?Q?8qOIwFD0Y9Sukvo0GgpfVCktzzuKbQPmVAHgtnrFRBOOnqHCLyM+1OpCEHIH?=
 =?us-ascii?Q?ne5iHhypw31o28caA2QB3JGeSSeAU6+Aeup7yUiABM/aBUiIuNHxMhsR+d6H?=
 =?us-ascii?Q?W0l7ksVloiTWyxLohEN2RKg0FV/+kvgSJFWzU5g/fZwtiRv/huHL6pkQ7XDW?=
 =?us-ascii?Q?6p/BmgGhC2cCxWC9Lvhnd0ugcD1lr2NfXxaaE4uSGQzJVqbPEnPrOqZWlIyg?=
 =?us-ascii?Q?cqqdzJAZyo4AWbTG5AgRDLkC7fkO8u60qcyCJWQKvkzikFMGlP512Y6iqsGN?=
 =?us-ascii?Q?DoAHtwDcytivxo/EyptJ5BWejNN3Up4jeWkZepZue4ZEjHM7vtufHuthvFHT?=
 =?us-ascii?Q?3+y2MX5ILlyaj7MSyRe4FSQiUoK0y0KraV6pYTlDdTwit+e9ZWhfQG21E4oP?=
 =?us-ascii?Q?+x5XQTbjI9DJlrbtgylyF/nfPoANDh2OPrjkpn/7gNZPviho85qGMJpBUG0B?=
 =?us-ascii?Q?CtHTZ0BakSjhmEGHuYJMECgAQ/V4uMQnnWu7dNtOu/BZtUOsT5r9+u17UmSf?=
 =?us-ascii?Q?71qv3SYq2uKorSVH3lA8wZ6310O7Iic8nMtw+ah+HJQHO88O+XZ5GTl/zDjM?=
 =?us-ascii?Q?CRm+YM237JZ8w8wAQ0BKcC4/ph1fARgCjnrJaFWj0Iv/AU1VIwhCG5Wqddfi?=
 =?us-ascii?Q?W+TjmscMb6NghJayrktyw5pA3Cg60MQTfEFf9g1ZuthbKmcpFNI9NyitxtcX?=
 =?us-ascii?Q?K1LzzZyP5fC/c/lnjJOH1JR7YbtBgzwLjnP90uiLDIEpRbVwq4E2UJ4cIEhF?=
 =?us-ascii?Q?OPxN2ablhVUPoP+qEsOwbG649ysDscmuO5c9xKnC6AYiPqAPWqcWumtoQBdO?=
 =?us-ascii?Q?PVn2TXNXtrK41LfFGQzR3x6OfMHSXVb9QsSigpJothYHz1PhcIRgcxFWyycf?=
 =?us-ascii?Q?1mxjXkRnV6if2G1RdeoMfTXVLmrMEl95fa030kmqM5GU2PSc3v3D1enQqjBF?=
 =?us-ascii?Q?8AfJqkrcVLPYX0fU4xK+Al7/r8ZIJYDdKoAVZobhgVR/Z4tdJ3+iZYJSPcvR?=
 =?us-ascii?Q?I2o+s69Nezw0YdMNyAc/yzWXcCViEsxi/r1qJ3GRF1/VqRH+1WnX8weJuYmm?=
 =?us-ascii?Q?LWdEx8jr92nxKkNBHe6MgiAYezGTHjnATG8oT/8K+BTrRrUqurCGstt01Avb?=
 =?us-ascii?Q?DjYrCO5yEJKU2l/1stAjvAvLp6LRzmOwcM3VaS8IKi3Ml0L3sN/QFngkwUrR?=
 =?us-ascii?Q?Vaw9R6GEmvgTz1BQ93DGTYQOC7bz+iJK9WPCNbIBdSdd4eIAuT6eSk/3sKSA?=
 =?us-ascii?Q?LcMlKDI0pa2UfepODwZa4dhR+mbnyLFi3khaGIm6hjrp8FUnSb7vD/xyW/Wo?=
 =?us-ascii?Q?JTxH9IDcRj6D0/ye+EbekI/lItoHLMC6N2IUuL/br8gLlZMkdbc9MWhmNV41?=
 =?us-ascii?Q?3Kv4Qiros2EFG0heNKhdDlwpObuz3n4yKSY1WLDO63VeLMtBzInwM0b6Y5OF?=
 =?us-ascii?Q?jooS4g8QZDJbAxMNeoNfrdttowYvW1DDMJ/ftDzeMbVn8Iyo3NFoXJmqyTYY?=
 =?us-ascii?Q?ex/1S6fyGqlmTmb9KGIIHU8qOvU3Ze0WeWr7QK1qzz4uYOgl6vhdpoJ898e0?=
 =?us-ascii?Q?jHWuMwkhQweBX5246oxVt/k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b8f0e3-ee01-4577-83f9-08dcd107cffa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 19:44:26.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2Q63QFj2nW3A7iVOqbBEDI/e19/udVM6GKjJ54q9G5zb09FrPaylVA8GE20KDehCJ2Y+P1glDiBhOQnVh6UgmRU6GaqscLcmeM7rIkjsvsXy46YxrTlOv5ElbKRA0+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8585


Hi all,

We are seeing a deadlock between reset_lock and pci_slot_mutex when one 
injects an error with Intel PEI error injection card. It was initially 
reported with some older kernels but it was also reproduced on 6.11-rc6. 
Apparently, it requires FW first more of AER handling being set.


    Not tainted 6.11.0-rc6-orig+ #8
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:kworker/0:2 state:D stack:0 pid:1003 tgid:1003 ppid:2 flags:0x00000008
    Workqueue: events aer_recover_work_func
    Call trace:
     __switch_to+0xc4/0xe8
     __schedule+0x280/0x748
     schedule+0x3c/0xe0
     schedule_preempt_disabled+0x2c/0x50
     rwsem_down_write_slowpath+0x1ec/0x6f0
     down_write+0xac/0xb8
     pciehp_reset_slot+0x60/0x178 			<-- ctrl->reset_lock
     pci_reset_hotplug_slot+0x54/0x90
     pci_slot_reset+0x138/0x1a8
     pci_bus_error_reset+0x110/0x158			<-- pci_slot_mutex
     aer_root_reset+0xbc/0x298
     pcie_do_recovery+0x2a0/0x3b8
     aer_recover_work_func+0x144/0x150
     process_one_work+0x184/0x420
     worker_thread+0x250/0x360
     kthread+0xfc/0x110
     ret_from_fork+0x10/0x20

    INFO: task irq/78-pciehp:1497 blocked for more than 122 seconds.
        Not tainted 6.11.0-rc6-orig+ #8
     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:irq/78-pciehp state:D stack:0 pid:1497 tgid:1497 ppid:2 flags:0x00000008
    Call trace:
     __switch_to+0xc4/0xe8
     __schedule+0x280/0x748
     schedule+0x3c/0xe0
     schedule_preempt_disabled+0x2c/0x50
     __mutex_lock.constprop.0+0x28c/0x960
     __mutex_lock_slowpath+0x1c/0x30
     mutex_lock+0x6c/0x88
     pci_dev_assign_slot+0x2c/0x88		<-- pci_slot_mutex
     pci_setup_device+0xfc/0x6f0
     pci_scan_single_device+0xd0/0x120
     pci_scan_slot+0x6c/0x200
     pciehp_configure_device+0x50/0x188
     pciehp_enable_slot+0x1b0/0x290
     pciehp_handle_presence_or_link_change+0xfc/0x208
     pciehp_ist+0x214/0x260
     irq_thread_fn+0x34/0xb8
     irq_thread+0x160/0x250			<-- ctrl->reset_lock
     kthread+0xfc/0x110
     ret_from_fork+0x10/0x20


I noticed Ian May reported two deadlocks a while ago [1]. The first issue 
got fixed but I'm wondering if the other one was patched and we're simply 
seeing a new, yet a similar one?


[1] https://lore.kernel.org/linux-pci/20200615143250.438252-1-ian.may@canonical.com/

Cheers, Ilkka

