Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9F46FEFA
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 11:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhLJKwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 05:52:06 -0500
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:26331
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233090AbhLJKwG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 05:52:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byruObF85KCwzrsVWRNnj5JuZI6c6yoiTk2dDjaxf0oeS3C+ftiWVb/ClHrT92Jgp00tyalkyCd0tHgvmS5tlCsRiR0RTkWifbjGc/JoRoMtqFp539B/nUuucN0MtK6fK5sPriWaUDYLrGh6pBPJzc+5RVew7TqKuXhwK2ZbGp+x+M00CzkZgR1I+7PigGytEEO5kQQjuFIte2c7ohsK9jg26wy3louzeSLtr3S6bJt2mxJuWlU/0gL1ZVnBWs1t3dag6xGboo9yoItHQfhMVzSg7LnC71ZZ+1JI/6CTY2qUu/yxDZxxq0RkPjnS9uiawxHCDQCWqhEas3S3DhSYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvY7bmDj2y9AKGDvgd2eWqIVI/qPNo4GDfywrNsw71o=;
 b=FGnT3MHSFgDkwbzb1GHpnzy/h0+lib4SUW+A2HjQvpDw52ZR8eQV0IcZcNe8FOSH5osNh6WELti6AmFLf9pYyKMa62fYBg4FoN44YsSe4/VjmmM4mDTz9gPIR5zWohkqMeZhmVpm03yrnMcbXcfQl3jJt7I2UvQwEM/98FkDbY1Oweca4CUqhlsCV4X2ZzQgtmUPs+XU/AN1ciQ0zuxpueNGzqXC0hZs+vhGKrv+Be57lwoNMhw2XqRnlpZsaGcfMmM00onPAbjMSPsKdA8nKtV4YkhF+rZWJtwewDCfEdpmgvmC7r8wgZ8otrq18zghuCPXuqA6aM9F2CXNp+r4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvY7bmDj2y9AKGDvgd2eWqIVI/qPNo4GDfywrNsw71o=;
 b=eb6vJjNAb7fJPuouzRUlirCF//2aFd6DXs6Z9euSkbQaalcEKisVlzZBQCbSTfPu9MBKN68bY29kYbWaOS04YdRHvG0OGCDVxhBNV5C3r5fkHLDjwq84WwKedVobTmk/33bGaYnT4cBrbvxbyeE/QvPOU4i9Bw7L+aB2/M7CYJU7irHVRvLhsyeZZFhZJFzhP7kVC1z+5FrIpgu/38o8HetL16LaFr8iPTkrk8r8U+qGA1iVM1owYnEi2NhAJFpcU0unxIh+GbcI+PNvyq+O4qq+d+eS9t0EEKCgunGZLK1sEUaFWm0Q/NcCQLpl2p1QNl4++qXwU69V4MnTeM18Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22; Fri, 10 Dec 2021 10:48:29 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%5]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 10:48:29 +0000
To:     Bjorn Helgaas <bhelgaas@google.com>, lorenzo.pieralisi@arm.com,
        Marc Zyngier <maz@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC] PCI/MSI: Warning observed for NVMe with ACPI
Message-ID: <47833bde-a89a-988a-6350-6e6ec90048b4@nvidia.com>
Date:   Fri, 10 Dec 2021 10:48:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 10 Dec 2021 10:48:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05f82447-4b9d-4cfe-accd-08d9bbca99ec
X-MS-TrafficTypeDiagnostic: CO6PR12MB5396:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB53964A2DCA1BE5E71E1FE6C2D9719@CO6PR12MB5396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lebs0MdC5FK+Vafm1gvDXgnYZj3HAZBD+k6e3baPm/4w5QJkxYZ+9vNn1SSVWDdE6GlAWwW8T3Ip96paMhAEa/uq6ZXQMIg/54mxJLN5Su90VZpOgx7NIDTbTjbKbubkgAzvcD1cT/juhrcCb4UjYZGDww0QOSxkmf1Ph81cnTn5/xyhUceCBePCuAlCE4mQvAoIOK8rFqlqoL9gpHbEVk4zkFux3kfSgcA/DgxjzXdnR/cSyotAELUpVBRy04mcklgm0yLjC5Mhsqn+nzinxm2eAS9OtokiNV45gFwPsJc33i7ordlgERrfgJu8PDgo5OlYEW75j7piOV+DKXL9EJ7Cm/g72X5zMnkByy7TwV9tEbvt0jDCURvn7r4l65+pILS1SxImbK5KLYhJ3GmzvreBykkoH8mVHAugj/SV2Gn5z3kZM7ZDhWRjOoZKHSc74JX5Dl9Xd2Y/dodAs1uWv7ODOymCxyzEpeV+0ibiE2XlPWBrBNIhdwe/Idpfxmc8ihnGU47hubzBwiIQ0RkLIjGJLOyUI6W/+ZvoL0p/GQ4/2wbbDXWafbvm4FCT4DGRgsLLumSVcdiISiGJIpv8aexVXpM1g02a7+J/GA3FxtL43N4yLoe75IStAlG5QinVPFgmTPFahz44FCMNihYwrZoPLgYcL+XwDuDcrBYwXrdQQMK+dD9oMdv5MqVap74N+5vRDh2P7gqC/RaY8T8TTsortvb6ws+0/THxdacAfQe5iGkF6C5pJ1FwVEdxppEl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(5660300002)(316002)(54906003)(2906002)(31686004)(31696002)(16576012)(956004)(2616005)(4326008)(66946007)(26005)(55236004)(8936002)(36756003)(83380400001)(45080400002)(8676002)(110136005)(86362001)(6486002)(38100700002)(6666004)(186003)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnMzU2RIdkd1c0loYzJrUkVkN3REcjR3eGlEREM1eTVNRmZwSnZOaStuZEVX?=
 =?utf-8?B?VDd6K096Skh4aFJJOW1HbnBzTE1lNDNCcGZXaGIrc243Zmd4TWs3MFdiLzdo?=
 =?utf-8?B?dEFMbXNYd0FOc2NWN0F3QStSeGJIczc5TlpKYXNWMnhHZVFkQW45dDlqT094?=
 =?utf-8?B?UldoYk9sSjA5YXYvU1Q0UmdXWnVVS2ZVSjJPbnYxU2NTRWZuSGNRMGxPVGhD?=
 =?utf-8?B?TzVQanRnV3FycHR4K1BDVDVhYWFybGM4dzlmejVwZWs5UVJ5Z0R2MHk0elht?=
 =?utf-8?B?ZWc5alV5QkRxdGF3MGwvVytBUUpMclE1b0laT2JSSTAxak91ZFhwV01GTC9l?=
 =?utf-8?B?eHBhVE80dzhmZnlCZHVueE1LWHFYczROUkhtN1Uram1lYmZMWjJsbU5QNk5K?=
 =?utf-8?B?VGdIb05yYm9wSjkwYW9MTEtvTWoyTzVpeFpEbmZWUklXVDcwZHh4Sm1JTGxy?=
 =?utf-8?B?WUVwMm40UnBrTk9lQiswN3A1MHVjUDhpemVKVEJ2eWFZTE1ybTJ0UFdnd1Iy?=
 =?utf-8?B?MEI1aEVVbE9NSHBTR0dEaUQrS2R4TXlmU3BnY0JXeER2L3ppL0NpcFBUMjJJ?=
 =?utf-8?B?TElJR3NDd0RvNlVtNksrelRCNmtOem5MYWYxOTZDazBOU3RtSVdMbWZhTUdZ?=
 =?utf-8?B?SXM1ejN0ck1idUNjSGY1WHUrZzZja3FKNGVZT2l1NXV4RmtDTzhEZ09UZEV0?=
 =?utf-8?B?UjdCblVlUU1JQUlLcmxIS0hnTnRMUTVIZGdmUWtqVXpldExpdEd6NW85Vytw?=
 =?utf-8?B?eEFQM0tQYTlZeWM0Ny9vVkNFc0FNQ0wzTS9Td01UOXlzbnVrT0h0VzA3RU1z?=
 =?utf-8?B?TlROcDhiTUtyaWZLWTFqSmNIalZVTVh0Z253YjRlU1JweVkxUkZZMDhSYUIw?=
 =?utf-8?B?RGtOcklVc3V6SnpRZ3RHR1l5QWdOdktRV25nTUNNcU4yd092bEx1VUxaWmVO?=
 =?utf-8?B?ckU3a0xycU14alY1dHE2R2ZqNkpoTUlZUGlnYUNQMTJ2SGQ5T0FSTjcrbWtG?=
 =?utf-8?B?VkZTakkzeEs4ZWQrcjRZMy9wQWRMNWhJUzJOaGorYm11emRuWm1nUFIzelQr?=
 =?utf-8?B?WTR2WDcyRDlDbjEvZExXdk5NMEIwL01BK3lvS1hDV3RIc05nazVxWUNMR3lQ?=
 =?utf-8?B?SmVRSytXZXZRY1g2RUlBeEZuL3B2ZERHak5MWG5jNFc2VE9Ud0pWcCtSZGF1?=
 =?utf-8?B?S2R0M0dpeitpZU5saVQ0b1ZZK3VjaUovd3BnSUZ2TFA1VERrQmpRSXJxOVR6?=
 =?utf-8?B?aHZvNGNoQmsxcmRFWUZiTHl6REtlbWk0YjducVdkWXVyL3RYUjZkdmlWUWZw?=
 =?utf-8?B?Y1RjLzBGYjVqZHcrZlczc1BVUVRqai9qYlkwRUdzMVJtSXI5RlZDbm5nbjNH?=
 =?utf-8?B?dC9iTEZZeXpGOVhzb2ZNb0M0ajNXWWlZUThOcm9heGpINGlEaUo5c3l0eHlJ?=
 =?utf-8?B?TTlTbEVucVdDbkZGakQxK0JTYis0UEdwY29SN0RRSGlzaUNMYVNwWGFLcXB3?=
 =?utf-8?B?NHQ2bmZwallSb2x4T2JwTEowalVzUVIrbk0vdDJDT25NMFpmbGJDSHBaQzNQ?=
 =?utf-8?B?SU8rVitnb1dtbnFUUVdaMnpzWkNscytEL3FKQlpjRnY0eFptQWw5WjhiSGdG?=
 =?utf-8?B?NjdhWG5CdzZXbDlZWUVINEJkMWZ6TWxVcGZNelhOVlNYWU43ZnBTY2dwZDdP?=
 =?utf-8?B?MlJpcXN4VE5OTFc1bnVEaEFRaTBkZXBDcVRTMjNBTjRZckhacHNjNmI5eDJs?=
 =?utf-8?B?UVR2dEdhbGw0ZGtCZ0c3Sy9oTzFNQm5pSHNQZDdCb29QZjk5cnpjWlRpaVpT?=
 =?utf-8?B?MDQxdlNzcUR5ZzJyTG0reDRvRUpMeElpSVE0RFNNYm5YbHdNYjBBajE2MUZX?=
 =?utf-8?B?UEZIejA4K000S0QyWjMrSSthRVIzSnczRTg2bDVZU2ozU256eC9OZ1doTnBO?=
 =?utf-8?B?Qmk4WmcvbHpxZm5PS3JPU3B1bEhYU3pjZVZQSHo0Z2JqVUlPVWc3UFBnUjE1?=
 =?utf-8?B?N2V6alUzTERNV3RWM29HOHlING00YkZOVkNkQUZ4V25qVVAzYTU1YnN6dG5I?=
 =?utf-8?B?YXEyL1duY3diV1ZMYnJhdEhnV2lKVldMMmd2UFIxZEtCWmZBMjk5d015blVx?=
 =?utf-8?B?ekJ1QitoTTRLUGdvVTh3dUxmbDI3aGhrVHBUVTRqV1d3Q3ZCeUt2Qy9Qdng2?=
 =?utf-8?Q?Z7Lu0+fG+xqOEkqYOj6sAng=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f82447-4b9d-4cfe-accd-08d9bbca99ec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 10:48:29.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RuxXteQImORrcjucV6yVshTm4O8JA+VhVzL0TF/qBoMSwvtd+iAkTb/pqWCs/JJIk9+RXqvTnSAVt4xbqzk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Since Linux v5.13, we have noticed that following warning splat when
booting Tegra (ARM64) with ACPI ...

[    2.725479] WARNING: CPU: 0 PID: 94 at include/linux/msi.h:264 free_msi_irqs+0x84/0x188
[    2.736137] Modules linked in:
[    2.736147] CPU: 0 PID: 94 Comm: kworker/u16:1 Tainted: G        W         5.12.0-rc2-00008-g658376bd3e5-dirty #36
[    2.736160] Workqueue: nvme-reset-wq nvme_reset_work
[    2.746470] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[    2.757713] pc : free_msi_irqs+0x84/0x188
[    2.757726] lr : __pci_enable_msix_range+0x380/0x530
[    2.757735] sp : ffff800012813b00
[    2.757739] x29: ffff800012813b00
[    2.768371] x28: 00000000ffffffed
[    2.768382] x27: 0000000000000001 x26: 0000000000000000
[    2.768393] x25: ffff0000809362e8 x24: 0000000000000000
[    2.768407] x23: 000000000000000c x22: ffff000080936000
[    2.768418] x21: ffff0000809362e8 x20: ffff0000809362e8
[    2.775320] x19: ffff000080936000
[    2.785950] x18: ffffffffffffffff
[    2.785961] x17: 0000000000000007 x16: 0000000000000001
[    2.785975] x15: ffff800011bf9948
[    2.793997] x14: ffff8000928137e7
[    2.794009] x13: ffff8000128137f5 x12: ffff800011c19640
[    2.794023] x11: fffffffffffe5788 x10: 0000000005f5e0ff
[    2.794034] x9 : 00000000ffffffd0 x8 : 203a737542204f49
[    2.803737] x7 : 444d206465786946 x6 : ffff800011ee1fd7
[    2.803750] x5 : 0000000000000000 x4 : 0000000000000000
[    2.815286] x3 : 00000000ffffffff x2 : ffff0000809362e8
[    2.815300] x1 : ffff0000809362e8 x0 : 0000000000000000
[    2.825270] Call trace:
[    2.825275]  free_msi_irqs+0x84/0x188
[    2.825288]  __pci_enable_msix_range+0x380/0x530
[    2.825299]  pci_alloc_irq_vectors_affinity+0x158/0x168
[    2.825309]  nvme_reset_work+0x214/0x15b8
[    2.829340] dwc-eth-dwmac NVDA1160:00: SPH feature enabled
[    2.832986]  process_one_work+0x1cc/0x360
[    2.833002]  worker_thread+0x48/0x450
[    2.833012]  kthread+0x120/0x150
[    2.833020]  ret_from_fork+0x10/0x18


Bisecting this I found that started to occur because with Linux v5.13,
CONFIG_PCI_MSI_ARCH_FALLBACKS was no longer enabled by default and only
happened to be enabled because Renesas R-Car was enabling it.

When booting with ACPI, I see that when pci_msi_setup_msi_irqs() is
called, it ends up calling arch_setup_msi_irqs() and if
CONFIG_PCI_MSI_ARCH_FALLBACKS  is not enabled, then this will call
WARN_ON_ONCE(1).

So the question is, should this be enabled by default for ARM64? I see
a lot of other architectures enabling this when PCI_MSI is enabled. So
I am wondering if we should be doing something like ...

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..4bbd81bab809 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -202,6 +202,7 @@ config ARM64
         select PCI_DOMAINS_GENERIC if PCI
         select PCI_ECAM if (ACPI && PCI)
         select PCI_SYSCALL if PCI
+       select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
         select POWER_RESET
         select POWER_SUPPLY
         select SPARSE_IRQ

Cheers
Jon

-- 
nvpublic
