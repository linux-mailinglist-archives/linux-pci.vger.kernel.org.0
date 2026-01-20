Return-Path: <linux-pci+bounces-45227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2251CD3BC8F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 01:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA27B302B502
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 00:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874584086A;
	Tue, 20 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jessie.cafe header.i=@jessie.cafe header.b="jwPRW4yu"
X-Original-To: linux-pci@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022127.outbound.protection.outlook.com [40.107.40.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81F86323
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768869936; cv=fail; b=kzIcP6ouqJ+d8M5IFUw78Px9OqJkIlP+nf/EzSR6hUpy/9DPIiH0kAp+yn2DnyyhYvPYCevN5JE6G9TUKLJbi/QzGvObHCZXNnLvrojrdwNeOBo1t4/ri6E7X7qH+PBqs9Ib99LzPKTjW8CuMliKBMIWjvFp2nCc5rLcn8Dspz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768869936; c=relaxed/simple;
	bh=uuEvTqiI9SXmKaPh9snJTR3Ak2aoX19wY8RAyn4LAoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cr/fQDhoreSr5EaG+88GCu4O0/VFpL/gmuOprYTVKlPVf6RtPj5K86L/IhYp5zakuMvkS1kSrVRqAe7yVP5dxEbKsOpvOeyl+N4bg6CK4HCKxKuBa8VVeugVv/zcDKzTH3l1H9JbMMMOGn4GTpowCN9nqM4HEOlaJIXPp9z9Xqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jessie.cafe; spf=pass smtp.mailfrom=jessie.cafe; dkim=pass (2048-bit key) header.d=jessie.cafe header.i=@jessie.cafe header.b=jwPRW4yu; arc=fail smtp.client-ip=40.107.40.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jessie.cafe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jessie.cafe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNNXNYfcEBuf5rrtK0ODo/SkzDaiUoqcohyQSX4B1xRE60/7Lq4WbXohsy2kGglQV8JoZ6EYsCunbwxU0sKA+HLcX6GH4wi47mxnLcspzT1e6znP0tV8b8xRtXePOww2nhpQ7E36f0luZ7NlxmHW5l2aNJ98NIGuYfCjMiq6mEqvgJVcRfLWK+UbKDF7IXcz2Fk1HuLDuvLcNl1/+YIlq1tn8KAcpUUzU1ng9qb777wE+axzEtpSwGyc3yWOAERbGdGm9UJADa9oThSo57snj1Y8a/5bat1WuwAT9LUU2pnD4NCrV5gAJveOsJztyl2czhMcl7uw7mT11Q3gEEisdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6W7ACLfS9J1ZBpE+E4Kb5FX4Ch0TvAuqeDj9oAiQ64=;
 b=eeMT2PXnzSV2vIRnGA4vB5GXnEQApgCAYGPnX3XTdVVUjFc9jX+QC9YJ7aCx8RxzADKVNpa3duVUQie2wHjqJjhHbH5ruCZ1v5ZCyXoJj8YjPBX2+M3jdrUNgA0rz3NOt714fiqXxD5PXYbjMfgLoSv3xhYHn2tV2rEqO3XJIdsv+oU7sh4sO/f/ZumsQ+Yo4LsYn9RD4DmOXmRNGW6EbPOo1+gey7GfzS7IaXJhZ5f6uvWl4f9bIwngC3XZWhg9TeTUKNy8LeLf5XzzhDxPaLwY0LUzpQMe0keVwxHk1cGPH7ujYMes1ygTlGoPiG4Jf3VFoUqar2p9Ij/OWbn+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jessie.cafe; dmarc=pass action=none header.from=jessie.cafe;
 dkim=pass header.d=jessie.cafe; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jessie.cafe;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6W7ACLfS9J1ZBpE+E4Kb5FX4Ch0TvAuqeDj9oAiQ64=;
 b=jwPRW4yueR1BCWM61vinzmntF8mSxDp78aTkbD61sWcn9/99+VaSCwOK/dDiAe7OIaN9B/RYcDt0dogeaDvRqb11otNAIspcABGctNI6WdC1mlhtEPEjPzB6wBXXpqK+HuxxA/BWyuys24dxP8BJOnAPKrKc4sbVu4VZU/viWpJhxAhApQOAp/wb4VamldfpbyhkRA5Acnc3Z/+eVzpXeUN9KfyMZOtrPr+IbIEMlxKENBCKQ4wrnfuoVBThrqnMTx8JcIDZzIXRLu1w3xCB8MNMccQ0aw5ThM3VyfjP5sBUSwnW1ORZBACz+uTw0UpbHXArVzitgnZGhMotZP7U1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jessie.cafe;
Received: from SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d2::5) by
 SY7P300MB1433.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 00:45:29 +0000
Received: from SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
 ([fe80::2977:4263:62c7:1658]) by SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
 ([fe80::2977:4263:62c7:1658%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 00:45:29 +0000
From: Jess <jess@jessie.cafe>
To: will@kernel.org
Cc: bhelgaas@google.com,
	jess@jessie.cafe,
	kwilczynski@kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org
Subject: [PATCH v2] PCI: host-generic: Avoid reporting incorrect "missing "reg" property" error
Date: Tue, 20 Jan 2026 13:44:44 +1300
Message-ID: <20260120004444.191093-1-jess@jessie.cafe>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aW5gmRDAlqR0Ii5S@willie-the-truck>
References: <aW5gmRDAlqR0Ii5S@willie-the-truck>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AK1P299CA0006.NZLP299.PROD.OUTLOOK.COM
 (2603:10c6:108:17::24) To SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:2d2::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P300MB1543:EE_|SY7P300MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d00d9c-7b0a-4cc0-4745-08de57bd356c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1mlorv1E+L7Zn80RSkCXhQhVTTcnsG16c+3ekj0UpVbkk9ZxvJ2eNw5GJo1h?=
 =?us-ascii?Q?QY2l0AXjQCLx38I7yY9oBC5gmIoJJxc53xw/gfxSSImrFLUebhSYaBqJxWnM?=
 =?us-ascii?Q?30dDnh+yPWyYu8W+dKJs+OXMBdejUmovVak2p5s8lBOhoUvZK4EUmt4amYtT?=
 =?us-ascii?Q?xdOzTa4NnYuN70Jg1E9R9/F9GdKR5XsaUVrdo1c+b2NcegIWfV0bTWpXN8Pp?=
 =?us-ascii?Q?uBkzWxH/N/ni4AbP5uyXzrHlh26ds6PdvsTf46NWk9ruQ/bXFMKll5xsE14K?=
 =?us-ascii?Q?8SVaBOefrOVLEC8HhvCwibMWKovafGVprHaF/kbOoVN4Ws25Wgr5NWODyo0N?=
 =?us-ascii?Q?Y9sybyTbKEnO2Gdz6sR6RojmQxz52j2Ci06TuWoyEHox0/4vPy0qxpcXaQ1I?=
 =?us-ascii?Q?HMU7OkhAX/iXviPwDZsBgdu7Nz2AhnbdlCZxZ9ysTO6nlYB03ra78XDcy//v?=
 =?us-ascii?Q?3cifFNX1jZCfTeOEy7wHrkHAIEBB1PLm9zX5rkis193Qk1OuoXae5nRFRl1z?=
 =?us-ascii?Q?8TbEwzKyk7UME/ldZf+EMLkv5pJhV0xvZ+Ob3pLBkdOXQ3HGuVqitRhAVSmx?=
 =?us-ascii?Q?h5edrP0ZAYfqVXxIAlfZiGJjvkjX1voUty+iE28V30bjBcZDxB7K0XSe7ab9?=
 =?us-ascii?Q?ITZtRyV3Nmpkt6uZqj7o7g8F1F2qxqdJOAQwHrya3iaOsf7/BrCChWnhol9J?=
 =?us-ascii?Q?aklwkDrq+sgPZ1fiOIVe15yokdJqalh4eI2Gf8Sj0Uygj0JJOv6jx7qdJebI?=
 =?us-ascii?Q?ABZLcP6f6j74p/v7c9Lpf4QyZ05QA+VtDPWL3BHhHGHGK8R27JLqUD0UGwjz?=
 =?us-ascii?Q?ptWSQVW0AtTSbzENHgZbFU2J+fZcoE4Y41ZivleG7W/lTUkvz1roE1gTJc5e?=
 =?us-ascii?Q?Nf3nFCaRWSfoOhpKSHG4QBlKvTBk/7b+bt++UenbjRCJidKPYZzhPCLTUpwS?=
 =?us-ascii?Q?QE9CFKwm8GgiLwCOW8Xvw6KuUt82UjaZ2mfwdob1cTuvrQOy5mK/7K9JQ7+w?=
 =?us-ascii?Q?812zql7lIq811JwPUkRJ2OuhAZfn8OHYDD2ZWXH1e9F02sUS2zaXWOMrdkNI?=
 =?us-ascii?Q?k38pFFllmTDCOWh0lQL0gEkwm+JYSaYqrICsQI+cgO6XVgJ6+FeOOZoCMt7a?=
 =?us-ascii?Q?tvl8HqBnAqKWihhn1AGAOYH1ctoZxlhXANFpKDhrb+pqHulqW2dy2FZBNmwR?=
 =?us-ascii?Q?pBmVH6KK2zZjd9wFJ1E46RP8xh/RmNivpItW8jdv7IVeh910MYY1nIoLtW+L?=
 =?us-ascii?Q?puRl2xsKGdy6J1UUQNWJ7jYWdDXMoOH4tS2PHF32BhCjbUv3uioBkBB6+/Xb?=
 =?us-ascii?Q?Oi6qwkBzeqq/jDKVRUnU8YxgL7n8zoMmXoPYkashlAlAE6rJHinf9AsNyH5N?=
 =?us-ascii?Q?LRJr1EzOl+on0uoscY+guP5jYAbg7n9e1T3ZJxG8F80gIjw6+xMMygwnm7qX?=
 =?us-ascii?Q?xVDCkcAuXTJBbQHDzRbwGAZ0Iv2oNzTbeS+1K8BE4grTZvhzEPpQqCpuA6J9?=
 =?us-ascii?Q?biwY60zyAi2cVqlkSmRSdf50Bpb9HijZK0xowPD5Tg6ItEu4Bmf7YoKSMF1w?=
 =?us-ascii?Q?qwRUBz5bQs+QhA3XeoM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3EKA+KYyXZKNfZdfv5QZtq79ZYS/3GnuZ9zZlUkBRfovtqvsuoS5qoBqBs2C?=
 =?us-ascii?Q?lqXirSD5TpUYnP2GLHntmBhkCJTTpHo433QiCKr/tWqFQFRSfbcciJiTeu4b?=
 =?us-ascii?Q?Y70l3Sz4qIxQjdrYXsNkRWj9xp9lmnpdRPW/uRz+XHsG4NndNPyIhgbs9pFL?=
 =?us-ascii?Q?2NBMgyedetroaDo3goDAySt4w8gZxgkTMfjk2IQhWIoyHuok2P6s5sQENMkr?=
 =?us-ascii?Q?YAN74Z+Ty1YOT9Lexj/4i5prjPZ9hTvFHuXP3+xnMa5il2/jSPd8u3L9+C0m?=
 =?us-ascii?Q?8tljmg3528z5Hi8/lDofyJx78htISyW5wTU0PFnEkHTYQibfQu/wUdBpl2AE?=
 =?us-ascii?Q?HnL5FY++yjtnGGdPtyuVjuGdlw6dLQwO6yWIsgwXXBerZiP4tBqsm8jVbEpa?=
 =?us-ascii?Q?l2MZiGr9Ktej5dVWryIhyMHuvb942gctIqeDY/KJMGwpNeHnkQT42kg57UKr?=
 =?us-ascii?Q?hxV/nKLe0i3RRdy2EIb1f7lSVCB87pZpiReWmflaVzsnp1PE5o9CxNp1TuBj?=
 =?us-ascii?Q?8BKlsWRW6eh4K/923Sd0goLvpGfImoibj6dhQhtN7VpJxr8hY3B9BZqfqzIz?=
 =?us-ascii?Q?YxHvHYDtI5aBZp/doKu1RApQ4Rx1yQTBUuCg/SwACm2Ja4/YuaWpgRIDH+6r?=
 =?us-ascii?Q?A+CA5+VkvY13f9dsLMYtf6YrwY97MTs699M8qBgdZj4MmN3QgGOfMUGY+Ti/?=
 =?us-ascii?Q?uwnC/kcP7bONWnVnA3e7iufkBG5EbBblWf/QqIYZrAtY2SUjtnB+DfrGU8sX?=
 =?us-ascii?Q?b+ixRJ8zX9/M6t9a0ITLPk8kl+ynJ5PT0P5rMXPOj6pS55laEG1cmb+f726b?=
 =?us-ascii?Q?tbEJOzWmKQzMMvkLhnEbHFBJgWk+S+O261byLbr2BC/12ZG79WBqIbvpgCkq?=
 =?us-ascii?Q?4+/cptabo994CNups44Mor0wtvuW5gs3NV0by66PTxjX/9cV+xUlEEXOQrDj?=
 =?us-ascii?Q?3a5hTXg0uLc24Bru8Ajz/YcYo1Dd//I4FQHKPt+Tz9PV9HoxKUX/lBmGz2Wl?=
 =?us-ascii?Q?UDzZa2MmAU7zfmFrSajLzK46gkRuO2MXvcV25dzBLiDcinmpOS7VIlvWrYdj?=
 =?us-ascii?Q?QvRRLBhWmq+8VbOfluB1U1E1KcdmffNGVoikxREru07414A5W7/Zpgcja4zn?=
 =?us-ascii?Q?+BBgmvdsAJRlJ6N0m0DUz6+4iszyS+NrEOWcg8wQeIZYVzl4oSiy7cOJ1k8x?=
 =?us-ascii?Q?uiYFkjd9hdSlGq0TwFcE2E3uWtAgRbeEPK8GEfh/k/ateBP/sr8Lix5u/MA0?=
 =?us-ascii?Q?OUDkamol/W54cQPs1Xq/0mbDvYmIC4onnTG2ZjUmAl+q4C4T1v7ISegMbyzN?=
 =?us-ascii?Q?zO8ymHXtmSK6qeCAdTZfpYb1McLsYQB4cOVfUx3WbpAD/O+d7Qlzeim8UyR2?=
 =?us-ascii?Q?9AKCPqV61byZphqJHi7/fjmFExg/vxFO983CDM2nnlEdxbOHuaGH/TcsNR91?=
 =?us-ascii?Q?ZfJj8n2pXI5s5Yy+wVeMAq90wsbLPYEow0mdo1muKxv1kz9KRF/3Z1UKH5mJ?=
 =?us-ascii?Q?mu0kwe2bvwD7s0qn0lnIGsIsq8oKS0iDIsgg6AmBgsEDaLgJdwITl7LwGmcj?=
 =?us-ascii?Q?s3uDYYgGAFf5PAgjVb7cJSP8yyLN7RWAeVc6FHqK0cjcwC3V7jIPl1+708DU?=
 =?us-ascii?Q?J+/dDF0+h/gWgQU9Y+8zxOe9CjlnFV/1Vryax4Nz1u8VFwoN6osezZzfIt/k?=
 =?us-ascii?Q?M/vYL30DMEAou6aYkT0BQWCInqPdP711ReBCdKM2WW/0ZsGY3H3Bm274EFRP?=
 =?us-ascii?Q?2Z9uhgOfmfxNau3IoIDUdvBMV7Ckq0RY92UAOOYkivDcbbZGn0IoEgi8o+q3?=
X-MS-Exchange-AntiSpam-MessageData-1: e55X1HM/XgW+XA==
X-OriginatorOrg: jessie.cafe
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d00d9c-7b0a-4cc0-4745-08de57bd356c
X-MS-Exchange-CrossTenant-AuthSource: SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 00:45:29.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 04514c4e-7367-4e0b-9b50-3a190055b14c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csvwKrsg6Lb6JdPrxQs24Nd0MRhrVp3qiHjMtX7UOQ5IMlln+tLZXKgrMsAUYbV1xwXHuSx076KrMT8m/Dohww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1433

When the function pci_host_common_ecam_create() calls
of_address_to_resource() it assumes all errors from that callsite are due
to a missing "reg" property in the device tree node.

This can manifest when running the qemu "virt" board, with a 32-bit kernel
and `highmem=on`.

After the following calls:
of_address_to_resource()
  -> __of_address_to_resource()
  -> __of_address_resource_bounds()

this overflow check can fail due to PCI being out of range:
if (overflows_type(start, r->start))
	return -EOVERFLOW;

This leads to the very confusing error message:
pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
pci-host-generic 4010000000.pcie: missing "reg" property
pci-host-generic 4010000000.pcie: probe with driver pci-host-generic failed with error -75

Make the error message more generic.

Link: https://www.qemu.org/docs/master/system/arm/virt.html
Signed-off-by: Jess <jess@jessie.cafe>
---
 drivers/pci/controller/pci-host-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c473e7c03bac..d6258c1cffe5 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -32,7 +32,7 @@ struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 
 	err = of_address_to_resource(dev->of_node, 0, &cfgres);
 	if (err) {
-		dev_err(dev, "missing \"reg\" property\n");
+		dev_err(dev, "missing or malformed \"reg\" property\n");
 		return ERR_PTR(err);
 	}
 
-- 
2.51.2


