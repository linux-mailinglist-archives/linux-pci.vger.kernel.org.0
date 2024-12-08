Return-Path: <linux-pci+bounces-17888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5839E8428
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECDB1884693
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE8A442F;
	Sun,  8 Dec 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXMPBkAG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4817E0;
	Sun,  8 Dec 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733643731; cv=fail; b=m27qMCu3iNXA8hM6NKiXEiI2YBD7JwxALUyjvayR20cxRHcoVFDbLCh57RUHkv2qxGMTTFtkJYnCnYu+q21mszionyNXIbEA4DSjMQ8QqGWpWQnTt7dXYF7OSuaMdIf463pqSr5x264S5AANxHsF6hBknWO87K2gkeqF7+wObZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733643731; c=relaxed/simple;
	bh=3+iYTbqwD8tqYtJzPSgYjZmTAaf/TSIXKYkJhH56Ylg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IpSZXUdTlUxml/F078XDoU3LZUysOoX6wj1ybNB4ep8MXwIhmqFLXXokeFvznNPMcI/HJieGccl/p40Fzm1+EUNs4r5Kn42DFwflWenswjVrj5cmmEXkGaPvUxc0nxnJFeSQ9SInIRxtHy20ktYrnCwQYi0UQCbtMSKS56GTsKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXMPBkAG; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ4HWNVuzfAh21ZPtdK8vfsGltrnkC9OngPvqRync7Cn2A3QCYedS4ASIVm8KsjBbkTLKf8TiLWHX0wMhDblWdX965IuO1x2xCMWXJhQy1QwujMUgF6NpLfMWizQ7mrwPY/Kz88ZUL2B31LEOUnuWSDit/goI0PEX73oYtS7+DICPbEBCA8+X1AFGHFNILSmejKOfhbCjQ1kScvIz6e+zUajdlnAn9vpU91QVmfuxAX4g/cc6O+KGvmLZsDaY6dQAmv9z/liygqpnBiTxIvpbbYBmaoCwG3ms0SMRvUXSdEibM7F7CzH5ZZha61GhT9aWjBdrtBPVVb5S+0/Xa8LZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEX/SqnenP3O6naZw9dXQ0jSASz3u1+YzJfi9FBKeSc=;
 b=tjHG/2aAmH3tDdQruAAo3FhzVHWsBKsdIYMLy1v2wOUQHMUSOC1xEBHS7i4K87B6yHRjamAaakTghjj/2U9vUvRiXtWqqpHeIQj3SEWp1EcmdY/UEpk61DXCEehzydYQeTIGefrgINf04dd1SVGhWWEbA+8RjrQ7d+9kfsnc35ELIzQeF1mdPSStACla/YwefKxGWrQw140fN6AFekAqvO8ZPuupBTYLpK9RsTIn+OxTMf6eriEwrCx7zxQURLGPOIFlGqz4G+obOXYa8jqb0xICrF/ciLXK8dHQktBHglM8XKqaOz0r8GEDJTu3dY+0jUxkmIOBN7m7WXqhyNTwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEX/SqnenP3O6naZw9dXQ0jSASz3u1+YzJfi9FBKeSc=;
 b=XXMPBkAGADQr7NaGfKXywL21yGX/IABD3LdCnFJJgxZyPC3y88N52oHkq8z9qp1m2tfzsaLzBOQeVoBz4yQ4btFpeXoMVe3l6qKYW1rwG9+a2/1Py5pGhN5sb/HaRLTiwCtn0DARwYUG8ncb67GfbZom/YCkKb1x+thnRL7nvJfjTNduZ2kzJGmDyndtUvpmX263cLjM3+9uZQzHqGZflp1JvPWgYVz6IP6NfmM9Q/W/rOUj/v4nRuw+2wHT4gGnwFHObiwC/iccKXG74uC2Ub9YK2wJ2hNOxq494Ft1jk8ws/m4dTkQl81yTd7/+ps8EQZixTasJj5uUxEGKyXKVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 07:42:06 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 07:42:05 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: bhelgaas@google.com,
	mika.westerberg@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] PCI/PM: Put devices to low power state on shutdown
Date: Sun,  8 Dec 2024 15:41:47 +0800
Message-Id: <20241208074147.22945-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::9) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 007699a9-a7e2-4d08-051e-08dd175bcfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kT11pc76tTDOhXDsHf/M5u1uyo8cLG6B5Ui4Liq+d/JePKp/iLoguHuZsPaV?=
 =?us-ascii?Q?f4Jj+EeFV5fc5vHZxldfzj+R+wUwXmXFeBy1zs5SO+49/cSm7K5TDP5bdv3G?=
 =?us-ascii?Q?EkT4oA/F11Qt0SAFn7rjA8JRsgABlXqXl6j1eogMaV86QOwb6QnPi39o0c7d?=
 =?us-ascii?Q?cey9v9L9Iyf9VDDa3Rt8XilrW9bjpljnNryPlz5J+8q/+x6CW2Mgjjm59/k0?=
 =?us-ascii?Q?LiZ1Y7SRAXSB4nwqsDWeGAXqh4zCp0jsa6hm8/cRTwMw0/Fix3diUc5o5Lab?=
 =?us-ascii?Q?iMoWCLlOMOddHbdFGjOy/+ORfEyTM0wXKnOdAgcr/p1069EAhhtngfSGaJ9C?=
 =?us-ascii?Q?FnxpaB77W3dMTHCxEFrSVzoaO8DED7FGrNKmv3ZTPoUZaLSO5dclE3suZHJh?=
 =?us-ascii?Q?LuhcdVuR8AS6XGxQeOxmroS0GR7RLS4FfxURGYCgyCIe4pt+OsMNVTw9DYEe?=
 =?us-ascii?Q?LzFTB0fom1ARFPKeTN7wneEG49Zvl+Vo4xWdqQ/BEj5RuseFk2H23/ibncNs?=
 =?us-ascii?Q?JIp6fFQWbAcx+CcobX9VH+dwRRJM4NSOvAFm6VsbRDQDmkIuI1nwsytfi5Qi?=
 =?us-ascii?Q?VhHsDrI8+q/+lhNxVxMGddU5D50b9Kkmik2GR8Dj8Od/R+KjlEiUJM6q7fnk?=
 =?us-ascii?Q?XwDZE4OOU9+PhOw3h/A+QrvXgXgtcGgAjEmsMMG2amOR7Ri5xw2IFeiarkTr?=
 =?us-ascii?Q?Nn4abJ8Z/v+bXriHPvuelfjXkGKuO6X1xrPoXzO+X74uqot7O9wuIqLPD33y?=
 =?us-ascii?Q?/m/WpE7sHJTnmZH+xbFHJMkDhLuEseFLTgaPClY6G19go54juppLQWEt3iiY?=
 =?us-ascii?Q?IvzMbbQpyRi/5QwrusOzQGmJnsiJ/DrUaLkkVfF8YtxUy3tESY54H/PdZKu8?=
 =?us-ascii?Q?kae5t51iNCQ4IgTrjysfotgyGVk2GDF3Tf0iCmjB4LQhQhF4vohaFhev9bpw?=
 =?us-ascii?Q?xdS7/xLZv1Kveb5vGrqo/o5xLbgCYiQZgRdQ+jjE79myZi5djlvguSe7cRsD?=
 =?us-ascii?Q?tN1ScHP1y5QN0u3Vr3ur0L1NiBL47yiPmMzzwdDhnr3dn0HU8U+7JNnKKOgE?=
 =?us-ascii?Q?v+4HqaWqk4a+KZ86aJ0EsSxLLg3TkCmOqguG84KvYhIVPLq2Ky2/aXQMQlZ4?=
 =?us-ascii?Q?OjkybgjLZCpiKRRVgYOnlK5tt0wQpywZ9o0vqZbYHb8L55XreiuA755RoySC?=
 =?us-ascii?Q?dElbQXj4Lcdx6onYCHP7zd2LvWZIr25h3VBizAo+bX9wndfPICXXGlt0W7cm?=
 =?us-ascii?Q?Fv/8GvF0ZBzgFQIDENdifeQTI/S1KHXE801qFcohxFua9ka7N88rZughgNCM?=
 =?us-ascii?Q?1gB6K6QkB35ABCYMXVQF5ZRZKczMfand9KNRcNOztGCLxilVBO7oXGsidKnW?=
 =?us-ascii?Q?Zzrgzog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XB+mi0kd50RpTPw+ChUHgaor/ssuYpZXR6dZaFCLXGRZZV979H+KzYcNlyFM?=
 =?us-ascii?Q?C7+uDh3dG79K70+AbGdU+zgqEUp+omjWdz4LvcbXqLHrB6jN352UMieiKxcD?=
 =?us-ascii?Q?tJITBuTljQZ76LI/VDMyWz4ohP9tbogs9sINjWObmMYqrk2qtSUmitJBeheb?=
 =?us-ascii?Q?hsEdfn6G4KsD1rszgOFplPkgXAPTAjCBcM1dPuxTu1kzPXfHzRecJT09V75N?=
 =?us-ascii?Q?1dBmbBRkHnF0rwq5rV0vjyo+FhDLXV1Hp7YqSR8DVnw0T7gOZa0DiwvN3TqM?=
 =?us-ascii?Q?5mNuUr34DjbC5/YLWJlNFeMk0JzNy35w/KCy2MLmKccoe5ooI++1I7EaFIJe?=
 =?us-ascii?Q?hL6F3IW3zdjhmYAU+2njC5kXfhec2n1QAGBF3gNnatlpgNr8K2U6aqQuoq+s?=
 =?us-ascii?Q?wI6750wiOYo5qVp3HLf8OGv2CtRECRBZOnLZ6QYzvzyF443SyCU5j0V0YIZ1?=
 =?us-ascii?Q?fT3ZYaIxibyVeH5kekTfKxs8/W+dJZFywvMJcKrg9ISeZrNSsmVfn/6Gjldh?=
 =?us-ascii?Q?hbaqB8Y1L+fhcWOBmeJ/6FaiVL6X1VId3uoWtXy/YFXi24lJExHIZFUgM6aa?=
 =?us-ascii?Q?R7vgVCO/Ik3x1odtcWJS4gf05lra1NAzITVhoZfv0oeAnhNrYRLuTk7nan1D?=
 =?us-ascii?Q?eqaPznfJM2ik3RA1Y2Y4CzTEyZbyKyQ3oB6W+xrC5LX5dRVLtHU6YSySBEmB?=
 =?us-ascii?Q?1cOfVShbB6Z3Sn29yr147Wn4b3GSnyw6mOjms3R4RuZClil1Nf71pisGPEWz?=
 =?us-ascii?Q?bk+BUyXRnMOgFAx58pyO8vBQoR14JL0LSfXRy3/bfQrtPelJKa/2XiqxuEhN?=
 =?us-ascii?Q?5XJqS9K0yhplzoAIXc8tn84gzOVC93md3i+y/gXHD3Qhi5u36Ad1M09r4DII?=
 =?us-ascii?Q?/YgByTxGOPQf19b6QvBjjrlNulZYns72bxvKFB9rN1vZ+C0+QgL5Po2mvIbd?=
 =?us-ascii?Q?tDsQvh4wyNQcwS08mFHKfJTqDPMbh+OrdG10uQ+iBb+xOhoFoi4LXkkKE37D?=
 =?us-ascii?Q?VxMc2RzPF9nWzIZgakhGavSOUCnD47HrYoANMh7vblalpIpkoqT0KbrCH6de?=
 =?us-ascii?Q?ZJy7jm19+xdg5Fwbxk/fG4nDytTvXpClNu7lizhLTdjcnAe09sMr6wn5J8dE?=
 =?us-ascii?Q?HYxE4CJZ7bzkJW9w3fsy2W1pyEXjdGwNWtOu4xokT3MEcTRJlOFMVzQvWJW1?=
 =?us-ascii?Q?JpUpqTOdP9oxUh+0eCWmUn1oU6UfB8BTB7rAL1JpZsxsxv3Vc0Plt1/4igvZ?=
 =?us-ascii?Q?wrJzLCG3TY3c4//t/+4UntO3ApbZ9CAwsmxRNYyz1rL6aGXlalVMlITGKBLy?=
 =?us-ascii?Q?XboNzxgMG+a0D6wi+RJSr+36q0c3Qo2lqYP07xbb3Tszty6+pPpYSVq9NkUS?=
 =?us-ascii?Q?gmUwJAbnMAdO2ASmNQk7rfd4fkNHALohDueqRSOWHeGOY4/RQSTue8ypYL4F?=
 =?us-ascii?Q?DzDQehYShoqvCGvG/w+2TuDv3id0cGPJb+FIahPmn0T6zC6eudbUI2HzBqsV?=
 =?us-ascii?Q?TpHiFafRUSpEYnAYDhsmF+LTPp9Oz2M1HJtD6Gcvc9TiK3uhmQq/7g2RsePu?=
 =?us-ascii?Q?aejNc8OOK6o3pQBmnLTrZNOyj7LJJ1lRyhXcB/c0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007699a9-a7e2-4d08-051e-08dd175bcfd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 07:42:05.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SivJ8IXmGshunSPB1Y0G5LXSjeg/cPxZAxEnB6liG6M8hHNVCugNpVOTdV8fFAO9B16SBhlTTcKg4KbzEIEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
connected.

The following error message can be found during shutdown:
pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
pcieport 0000:09:04.0:    [ 7] BadDLLP

Calling aer_remove() during shutdown can quiesce the error message,
however the spurious wakeup still happens.

The issue won't happen if the device is in D3 before system shutdown, so
putting device to low power state before shutdown to solve the issue.

ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
compatible with the current Power Resource states. In other words, all
devices are in the D3 state when the system state is S4."

The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
state is similar to the S4 state except that OSPM does not save any
context." so it's safe to assume devices should be at D3 for S5.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
Cc: AceLan Kao <acelan.kao@canonical.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/pci/pci-driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 35270172c833..248e0c9fd161 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
+	/*
+	 * If driver already changed device's power state, it can mean the
+	 * wakeup setting is in place, or a workaround is used. Hence keep it
+	 * as is.
+	 */
+	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
+		pci_prepare_to_sleep(pci_dev);
+
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-- 
2.47.0


