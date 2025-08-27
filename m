Return-Path: <linux-pci+bounces-34816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD73CB376FC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE3A2A7CC7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A21CD1F;
	Wed, 27 Aug 2025 01:35:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022086.outbound.protection.outlook.com [40.107.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF86DF49;
	Wed, 27 Aug 2025 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258508; cv=fail; b=NDK3eK4n3xk9PKkFCbIqnLTRfZ8zLiLEBCANvEXSbVLM7NED8+qAR2f53gs/TuixzQLb9MYtHdZ+abkXdhDU9bvC7V06oYWbqdI/UH001AQcXB3pf/rOJcxzl5TDg/n1Rh6SmEpWU8i/9fWEtVSxaknjRcEBr3/JQejr2oM/Uno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258508; c=relaxed/simple;
	bh=uKhmocSACTsiy/OzpBgzz1rxlk9fZGCqySaTZ309vdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuFCtSWqgaPUS9zDKQy/GIfT0h2wx7la8q02gYH2ODUSC6cQoUy/+f3g3hTxQH2xZUwKWheuVFmAWrML7t9I1WoKbOtxsfiFxAN6y0FxBhD/f/h/OsC+KWtN3pRZU1eYBZlk7O/G1nbqVjF0AgkLu/ogjUo5nciBMEpy96boFdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUBBZDT1Ml7lOqh4urI+SRvm2hyrawZx6r8PLhPDdKVRJnfXrgA47uGqnUh0lQYeTdvFD3uHOcADKT2WQyQyAyF/kEH3+Urtu26ra2Y79IBeydWwFOZogfNYKsqjaXaeW2S/0ahAAdPYHAdvT21FCkMPUCbhl2etEaXzPMccvG2RHNltfegqnNuhr4IFNuYLYKFygc+WZJLzoIf1Y05AB/nZmMZ+I6dmxdcN9KU99Z3lJFe1/eMTnYvhTeBUZvK1mybzK/R2u/7DTcvUAXVu2Wu/fwNHFsPDeSH7gxz1oOMy2TL61F/USIVob1NM2J8qr+56BvhDkPUHybKaY81Spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGAK5pdwZHOBVKbEavE4HjqWWDdhvMCmQ1+knrYlwpE=;
 b=L9O0kYZnU1qcfo5+huvsh9DCUoOozo/146geVrbTvIlcHFYCIKHTHvpP/4hlapSe4Lxbc9M7XcN3afs6LvXC8XHjCp4c5ZXCJKyjEhNyteYvFXP1l8ikkB7LJFbwboGuNH7ZPMqh0S+zPZAotHXwcFm2qzDvmfOZ4crWqhGw5eqos2AXwjnpNtwr5gduCDWx7Lx/pkXb0l6etOZa8AyjyFHMcdpYL0UFL/WSgIVEQWS6aizNbbTnYlD8GJgthRUbtPjnK3T+Hft3c0kRYgWimSu/vb/8a0l0b30QyOXOEuPcpE1KJHgmHKYrIr0UEp/PltoJTOchdauO5gyF+VJPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0109.KORP216.PROD.OUTLOOK.COM (2603:1096:101::6) by
 TYZPR06MB6462.apcprd06.prod.outlook.com (2603:1096:400:45d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Wed, 27 Aug 2025 01:35:00 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:101:0:cafe::6a) by SL2P216CA0109.outlook.office365.com
 (2603:1096:101::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 01:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:35:00 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D921441C0141;
	Wed, 27 Aug 2025 09:34:58 +0800 (CST)
Message-ID: <3611030d-0ea4-410a-849d-362265fb8dba@cixtech.com>
Date: Wed, 27 Aug 2025 09:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
To: Matthew Wood <thepacketgeek@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250821232239.599523-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|TYZPR06MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd533b3-b7de-4f11-ffab-08dde509f01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d051VFBoeUp1WU1yR1N4dUJNK0lqWkZXOEhtelJTUVprMGlVZW41NTRpc0xu?=
 =?utf-8?B?b2NyeXNSOFhRYWg2b0JzWXJzSzFraEZLUlc4Y2p5dGVQK1dpcnRvVzM0TlBT?=
 =?utf-8?B?ekVIL05mOXpmaE5zVGRsMHNKajhPUUt2VnZGNXczeXZvWlo5dWw1enh5YUtX?=
 =?utf-8?B?SXl2dWJSRFpuWU16ZFBDZkNOZGVQaUJzNk9oQmIxRlg1QU9aeG13NnE2bE5n?=
 =?utf-8?B?ZnpaaTFUdy8zYWM4clQ3eVZyajlHbXdvQzVZa0dla24wS1ZLR1ZzUk0wdHM0?=
 =?utf-8?B?M05Md3NENnFVS3Vqd1RCa2lDVG1HT28yU3RIcVBYbFJnOU5vYlo2Vit4UEpw?=
 =?utf-8?B?N1NDcmhyUVJReFBzcWx6K1MwTDJzU2I1UGxGOXk2SFhJWFVtclFkTFNrZTl0?=
 =?utf-8?B?WURaVi9ZY1lxKzd5OG45cXRubTVwVVhVZlNMYnF0QW9KVjY1cmtranM3SkpL?=
 =?utf-8?B?YU1jazBhZDNFaEpoZjB2SHI0U1pJNVVTeEkzeDZYaE1INy84bnFraXIvcGps?=
 =?utf-8?B?bFpGenBEQWEwOGFlOXhJUHUxWklrdFJxeU1GRGNQQkVNcm8weGtvRlQ2MU55?=
 =?utf-8?B?cHF1b2plbzZJS3pSUVJ2clNtS2RtN1RFN3p1cDQrRDhhYTFKVXMybUM1YW5S?=
 =?utf-8?B?cVpVdUlzS1VXMFM1M1RSZU9LZGpNTERGcmplZjhhd1RpUFFCQU1oaEE0T2xi?=
 =?utf-8?B?eU5obmlOc0RmUldaZm9yWlZjYWV5TDBvWGxXVjlJS3c4NGVhM3JvZWxjM1Jn?=
 =?utf-8?B?dzZxcjhXUzlmOXcrSE1xVUl2L1VrOUhsbFM4NkdQRisyMXZkLzJSYjZHc2ZX?=
 =?utf-8?B?SWJ4NHpyMWhUbm5UME0rem5lT2VGTHBFQjlNMWxmZlBWUnI2MmZHNjZuMm9H?=
 =?utf-8?B?OXhWNzA4MTdxc21UWDRmWDUzQ1RzQ05SL2dUdGhhRys3RmRDaFpTZDY2OGRC?=
 =?utf-8?B?RzNLbERVNE1HWXUvbXJpSEY5MmxUNlB6NUJTejU1bUJMSjhUeGIrcSs4Rlox?=
 =?utf-8?B?WWJsRGZBV2JFSkN3RzcxSktNbXgwYTN4K2gvUjFyOWsvTmdEVWY0VHpINkNl?=
 =?utf-8?B?c282QWtUZW1qckdoTTRmSVFxRGhKaXF6N3g5dVVMYmh6bmJyZHJFeFFsS2w0?=
 =?utf-8?B?cThhZ1Q1TnhKNU5VUElqTzNzcVpLejdScUNJQnM4VnZRK0F2eFFyL1VtTEVx?=
 =?utf-8?B?UHd3bmtQZ3VvWWJxeE9RQ1FudXE3ZTJUd2JaWUhQS2ZaaVBkK3pXK2N5L0po?=
 =?utf-8?B?MzFpdkx3L3lKZnVldklBUUl0aDM5ZkhNVSs5L0p0UWllL1RkSURsaU5XOFNX?=
 =?utf-8?B?K1dCczdHL1J5OUFSaXJGZVZmcUxaK0dnMDhsbnZrMTR6NVd3bkxUbFNVOXdq?=
 =?utf-8?B?a0VQYm1yK1J3YndNQnd0N2NadmhXOVNpZ1hlMTB1K05LQmVRSlNtVnB0aVI0?=
 =?utf-8?B?U3kwSE8xaGJEVkxlcWljdmd2WDRHWHBPTHlDRTJsWjNrcTRYeWlKMXBaMjcy?=
 =?utf-8?B?RnRxWHVjbHVsTXppRTJTa3hPUzVNbU5oWVgxelhjaWtzankvUk13RGxaUFN3?=
 =?utf-8?B?RmNwNFZXRVdORUh6eFgxRVcrY28yR2kzdTAzNGtnL2JxMHVHTFduNi9jdExw?=
 =?utf-8?B?ZFVjNG9jZGlTUW5aQWREN0N0blVvL3huVDBRZC9JcG1jb0l0Q25QWkIwTWRQ?=
 =?utf-8?B?ck9CNGNtS2RPZEZqNDZveWVsVmdWU3Roanhjd2xTQUl6YXcwdjhCTk9VbExJ?=
 =?utf-8?B?QkY3NEFqWjJzQWRMbnVBR0RGMWpJSGgzQk44aVZpQ3pXVCthS00zOXRTak9O?=
 =?utf-8?B?a2cySnZZVlN1dzlJTDVZOExXM0JncGY3UWdSblNZZHRkN1E2b3hFVDVzaEl6?=
 =?utf-8?B?eGxBcE13RG1NVUdTbVFiQWIrSUdIQzlWMmwycnRiVDJoRCtoYWc0N0FSVU5x?=
 =?utf-8?B?T3Z5amVCU0puQml2cXpFaUEvbDJyV3A3RFA4V0syUTRFNHM4aURJVWdNZlZa?=
 =?utf-8?B?N2FzZW9sUEs4cStabks0L1pGMmR6eGdwNTlaK2tCb1paWmIvZ0hqVDZoNVY4?=
 =?utf-8?Q?DrShcB?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:35:00.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd533b3-b7de-4f11-ffab-08dde509f01f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6462



On 2025/8/22 07:22, Matthew Wood wrote:
> EXTERNAL EMAIL
> 
> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> Reviewed-by: Mario Limonciello <superm1@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Tested-by: Hans Zhang <hans.zhang@cixtech.com>

Best regards,
Hans

> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>   drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
>   2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..d5251f4f3659 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,12 @@ Description:
> 
>                    # ls doe_features
>                    0001:01        0001:02        doe_discovery
> +
> +What:          /sys/bus/pci/devices/.../serial_number
> +Date:          December 2025
> +Contact:       Matthew Wood <thepacketgeek@gmail.com>
> +Description:
> +               This is visible only for PCIe devices that support the serial
> +               number extended capability. The file is read only and due to
> +               the possible sensitivity of accessible serial numbers, admin
> +               only.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d5..1d26e4336f1b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -30,6 +30,7 @@
>   #include <linux/msi.h>
>   #include <linux/of.h>
>   #include <linux/aperture.h>
> +#include <linux/unaligned.h>
>   #include "pci.h"
> 
>   #ifndef ARCH_PCI_DEV_GROUPS
> @@ -239,6 +240,22 @@ static ssize_t current_link_width_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(current_link_width);
> 
> +static ssize_t serial_number_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct pci_dev *pci_dev = to_pci_dev(dev);
> +       u64 dsn;
> +       u8 bytes[8];
> +
> +       dsn = pci_get_dsn(pci_dev);
> +       if (!dsn)
> +               return -EIO;
> +       put_unaligned_be64(dsn, bytes);
> +
> +       return sysfs_emit(buf, "%8phD\n", bytes);
> +}
> +static DEVICE_ATTR_ADMIN_RO(serial_number);
> +
>   static ssize_t secondary_bus_number_show(struct device *dev,
>                                           struct device_attribute *attr,
>                                           char *buf)
> @@ -660,6 +677,7 @@ static struct attribute *pcie_dev_attrs[] = {
>          &dev_attr_current_link_width.attr,
>          &dev_attr_max_link_width.attr,
>          &dev_attr_max_link_speed.attr,
> +       &dev_attr_serial_number.attr,
>          NULL,
>   };
> 
> @@ -1749,10 +1767,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>          struct device *dev = kobj_to_dev(kobj);
>          struct pci_dev *pdev = to_pci_dev(dev);
> 
> -       if (pci_is_pcie(pdev))
> -               return a->mode;
> +       if (!pci_is_pcie(pdev))
> +               return 0;
> 
> -       return 0;
> +       if (a == &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
> +               return 0;
> +
> +       return a->mode;
>   }
> 
>   static const struct attribute_group pci_dev_group = {
> --
> 2.50.1
> 
> 

