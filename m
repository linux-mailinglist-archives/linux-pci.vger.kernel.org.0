Return-Path: <linux-pci+bounces-45152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE8D39D9E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 06:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9EED30062D2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 05:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB526B76A;
	Mon, 19 Jan 2026 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jessie.cafe header.i=@jessie.cafe header.b="usWu28+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020096.outbound.protection.outlook.com [52.101.150.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F2C2EA
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799424; cv=fail; b=N0F9mVFFvvDEtglMErQd7nebXHlFUU0DqqvZkdS60brFQLg63w8sbKk8p4t1GgshIu1iDqAP2BrM8JmLjEkDishW5bA7s66Q8ILEtPgohXaz29oMOO8sLNZSh/+lzWu0LdV3CV9JWttsNEerYUxmwZU5G1lHbsuiWLjHIlpj3bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799424; c=relaxed/simple;
	bh=gh8v+HQh7OoHsH2eI+aAJU6mk8el4bD0Yma1MOlakPo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bb0MpZgRoRtIYP8UggEUMUh2QZat6BvCG7QrWNwprkcH45GokgJ3AkXjARJc/72KqMdW2jcDcn5Y7dy346U5r51OGLNi0nEM6//dqDa1xubkUxYY2ynGh8EJs5xwHD69kqAepHQKwZjnz0GWrOO15bV3WLiphuVAYnPihEwAJNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jessie.cafe; spf=pass smtp.mailfrom=jessie.cafe; dkim=pass (2048-bit key) header.d=jessie.cafe header.i=@jessie.cafe header.b=usWu28+n; arc=fail smtp.client-ip=52.101.150.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jessie.cafe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jessie.cafe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHVq1JCZ4RyWh3KX32JefQQhACwXZebFuyUUIkm0fAEkp+pR8ZQs7jQQAi0ASlkxQ2a2fAeZaEy35l64pjufwAr95IBdHxWenRpNpndUUpeiPmU/o7Kv2/Xl0H87DH5I+lujq3jPcOaFNzTFMJKYYvlFqaj2n+b2M6k3oQcXU8NUDyAe+LeXr6sogbJtb6Xps9eHGmknwdDaoyXkJH+tsq6tGqzjAWEsPVY6/M4VOJFZS+3UMj3Z9DJIQqWJfC9/bYmfVpmC/7rM7liZd7dYrGApp7Gz3z+tSBFaTm4PkEui0A0rRqRx5gQhRZhLBBqIp1cGdGzeWhbQQlLf+5l1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDMoZAJZJfXyhuSkKkLERDG29S8w/BPEYu9GC0Y11lU=;
 b=g6kZ+C9gz/qvt4fqSRyxRSQsUcWI31VrkN2WEfK9AQCSg7fGWZ4Yh7rlqfDWWIcfs4DnumfdzLuY/foOr0Fos2BhI3S5ihuiNXljZV13IEPME/7BT1IPQmszgXTXCgKmGuhFI8wV+ZgmKTkSSMLkvuX/KZ8GjFJkhuNYzbvcBcth2AMe4PZhMn1BbSJAbvIgo3RVQm43cZuaFJyrFa/S1WVcFbukdvlvohn2+fiqOtPWdkP4Ey11LwzVWQ73VpUyPCKzFaSh3ou8F34Cx2PvYt8BDeYnXg1l0Vn6o9KhxvBBGGwJ5Oe5uUJLc2KsBby4WBL0tjNxEqp2Qz5ZWdVdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jessie.cafe; dmarc=pass action=none header.from=jessie.cafe;
 dkim=pass header.d=jessie.cafe; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jessie.cafe;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDMoZAJZJfXyhuSkKkLERDG29S8w/BPEYu9GC0Y11lU=;
 b=usWu28+n6a5cUAF9eH3OlFwMhvU5SikAemxjkmzaWRIeDz58AEfl7Z1XRyec943Q5ImgP9mkzmFjh8gYkw451R01BEvwd9z8Kdp7sHOtQN2ZfZo2edSoe9rePJ8PG0MvK0vZwqgTDdvj0lYM8OAbh4ffMoEdYHyLf0x78jjUOfGlp6lj4olpKZg8NK71nz4EkxD+T2U/Ctw58buDWkejxtb4L2Vlkng5MAcymXaJQc7FCCsIr0CoxbSF6S+tr2sGD3zkwKvnwhgjDMYEJcC9ICGIbYCqQy4s5UHhko2wImdYsHR+QSIATAl+vdor4AlSmxP1OkQE0fUrpbuWlujj9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jessie.cafe;
Received: from SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d2::5) by
 SY0P300MB1538.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2cf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Mon, 19 Jan 2026 05:10:17 +0000
Received: from SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
 ([fe80::2977:4263:62c7:1658]) by SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
 ([fe80::2977:4263:62c7:1658%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 05:10:17 +0000
From: Jess <jess@jessie.cafe>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: Jess <jess@jessie.cafe>
Subject: [PATCH] PCI: host-generic: Avoid reporting incorrect "missing "reg" property" error
Date: Mon, 19 Jan 2026 18:06:45 +1300
Message-ID: <20260119050745.27650-1-jess@jessie.cafe>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AK0P299CA0026.NZLP299.PROD.OUTLOOK.COM
 (2603:10c6:108:16::6) To SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:2d2::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P300MB1543:EE_|SY0P300MB1538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9696c202-579b-4f17-2317-08de57190932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvjYcBjVO9WNDKpTV+d2/p8nOfUDakDsAePVHVggDrxHnip7p4tYS/HHSmfi?=
 =?us-ascii?Q?bJQW49aGsDlTO0p3Bgu0Cfey/FsGJfk6JzVYz2yHaq8vNkav3nLNjk/lSKt5?=
 =?us-ascii?Q?yxCfWKNqg6Q0w4CXU/GCd9XyT3PRsRjBf2Vs7X9cvAaMfOh6dxi9PrrSHu1h?=
 =?us-ascii?Q?hZyt6yCn98V4MJbp7A2vn8EqldxSfqgBxbcfGlEx3GMCulcbm3TDD6ghx02O?=
 =?us-ascii?Q?7Z2ye+hTx//kslIIMf8sfX2YfzsYMZ8cBlDrtifotIe5N/L3slLyWMkEy7NB?=
 =?us-ascii?Q?c9eZi/PwE0gJoOuYUD8gtVpzRRG6WJcig6pvDdYmL7yePe+FvKCRgpRhzEhv?=
 =?us-ascii?Q?zFysyEE8jO4Wmvu9x2Bzinq2TFnmHqCNk55Evl/7dKac+FdFtpp38vJe4s94?=
 =?us-ascii?Q?J0/CH/Jy/wLIh+JSP0ccEkH/y/ZuOOhRgVSy4sGkGypn8a3njQnPEkz7tqiA?=
 =?us-ascii?Q?nPqIEOlgM9YwaJ9H/HUqijzj98wJwgHbK0vkJpYGyB380Qqh9FjKv4LQcp2Y?=
 =?us-ascii?Q?rzVTO88FXKBMbVjmsWCDVOLL8N+R4S6cfINsKWl+X8niIrU5YlxubEUMU9Iv?=
 =?us-ascii?Q?BdoNg4pU04vnqQI3oE6l8jkQCOG4nxqi9tr+OUchEAEbji0d2oRpD0DJjHUf?=
 =?us-ascii?Q?KYPdm7fG0fDph7NdN5QKZa9GQdhfjdGVVFTB2MKcpqPsiJn6tMp/6v2moR6w?=
 =?us-ascii?Q?6Qs4ERTAdCrx2ELMI9GiAGx9/2qsoEuaujS4jslQg7MGFH6BAOfSgcnA7yG2?=
 =?us-ascii?Q?Z6Zm+UL0YFOmJha9GhA40GyxMUzPp51cooi+jAhIacPvShf/oa9o4mNav1gj?=
 =?us-ascii?Q?eZxKrb7YRGM2KF101eaME8ZShnHlK1Ap9A280CkiEdSjdv2FaD0xGqkg/dQj?=
 =?us-ascii?Q?8RjrtzNAqZLypge8K4ftTrSz9EvFk7J1YDodbKEyoXZ26+Wmr7dKU6+486aJ?=
 =?us-ascii?Q?BiOlJ+SaVpeJKDZsyWp+F6x8m918y3XRW4pmbaZQzqct+8XSzuohc9eyll1J?=
 =?us-ascii?Q?8cDa52elkGSCVH8eE0HuyBPqGiQyu7C0WaI8H9Oglwy/UySLu+d71Rc664R1?=
 =?us-ascii?Q?hu5qusHSsJR178Ivf8YW3CGjW7N9jhA2LSuIGdW4Gw56TfmJ83asTzHQHqla?=
 =?us-ascii?Q?rjpgwyDb+UfFG6SUofJilH/2nXDv74kDlGAMJK7f/uHWNxw7d4M1b6++sC90?=
 =?us-ascii?Q?x5XqOEJM3WmHH2SBKG2fYk8Fqk7pET6IYf4pfCE0IbIU4U1lZFC6VFJFPDfG?=
 =?us-ascii?Q?Hf+GtQBYZIcVo0smu0C0+RRvI7lROX46AdC7AyNHsJ/ny/TnX6DcGFqPoGJE?=
 =?us-ascii?Q?SD3jT69yOG607ir4JyPYrWfJhWutsmbpGtQxgGYTc25mP6ApiMIYjeePdnU/?=
 =?us-ascii?Q?tkhH5/BLrudrnZPVjBK+apTyQbDQPLVN61r3J6BI4wcs5sK2TYBLSMgUdawh?=
 =?us-ascii?Q?+RsNIlR8nQYv67IxFjiu22++WXs/q6PttY8H2mOvDVTZZ2xQWQOtP1JZmTE/?=
 =?us-ascii?Q?INu6tEQ0hdKVn6tkzWacBu5nbmjMmxwaQkDMpnNt253tIzTvh6gXRfCsJcAv?=
 =?us-ascii?Q?fYB+W3WbQfzP07STGcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LTA6XU06SxiHOrCYx98nkH+qXGFCdlrYoKCLKsSrUkxGg7qE21p+sKoGdsPR?=
 =?us-ascii?Q?ciRkmtQuJuv9j+EwJVjrq7ilusWAVXnworNxz+IfiswjrppW5ir7Jk1oSgXo?=
 =?us-ascii?Q?hbvJUPqu4sJ3XIUOjeDFR5+GlD7NWDOgVuePJMFZX6SGlkmZhzELW3jmNxgH?=
 =?us-ascii?Q?ZB++6j/SRKL20rsr3fB6VJHktupCQjbEbUgkzVR3+giZYkgfsqaEK432Gj2U?=
 =?us-ascii?Q?vdJDbIqyrziGhRO8CsO7XXtv7592oXoyeIw3QYjY9ktZPlUp8rc6g0ElV75P?=
 =?us-ascii?Q?Ypvrp5/0NTFDdV+ka/lccwUqPF332cj85JpNfMYEndMl7welK/IVHl1gOMe+?=
 =?us-ascii?Q?ka1m9K14FgTkERI+PWYQG1lHz9pI+pXj2L33YAAH8R7NxynBw9y3uJmTqa/h?=
 =?us-ascii?Q?SxR22xHmboZVAgVbKNqtopeZ7S2fKsg7bP4zKWMxcr+++xjzs95qNJH0b3MS?=
 =?us-ascii?Q?Fv1q0soH/km+6xqywVp5KP2icXzaTOLbgc+KUbI02ytMHN6TyCYTeGLCkBzF?=
 =?us-ascii?Q?Pj9VLdlYY2wNjVmsBaD5O6yCf5wWr11YFrhBL+1J+YOMc7sMMOQILHuNBRXS?=
 =?us-ascii?Q?X3dckO0xvMT6WgVKLMVoI3wzBwtukKy1IkeUS7q0ofXZ63ZA9P0ARZoaxHQn?=
 =?us-ascii?Q?hkj/NDncgwPcpAa0kdx1i5xM9SflTLNo8o3YGPvgOmKW67JqAYFBTFO+Yji5?=
 =?us-ascii?Q?+ZV4VJJNeFvMxfnWqbSi6NPquPUUD3cWAVJsZFPCJX3izb/QAXiDCyGY1rLj?=
 =?us-ascii?Q?4mSXOW4UFuRs+m/nfv+hNAHojQkuF4mZ8tq+k9nOIeKsPMtnWsqpddCepJPH?=
 =?us-ascii?Q?UL8POpdXFSXNjCi9tr3UrOrIEHF7gnVXasSLm3Icz44+slXFYUuGaYK7ltaA?=
 =?us-ascii?Q?m98uYTYBvoPlWRjRx7mAeDfyG8MnXKp1CwX1l7ia0kyBceBXk0AVY6icH7Zi?=
 =?us-ascii?Q?p2wRaFeo4jX6DvHN2v/fdsJhEblsSp5plgALOj3lpx/ITBXzg1h0owqimCNS?=
 =?us-ascii?Q?E5vSeIGK0wRSpGtC3psKaCDSEhLBR36VQ4XwiQ8gK//oa4f2/8gVbh7AfwjV?=
 =?us-ascii?Q?6ZP1y+kraeK60mhBnTALh9ddIONiyGA0dDlayWylTQNwJr1A5Jcpr0naIM/r?=
 =?us-ascii?Q?2g4YSAUYHcteck5x4RqFkbEQGxC6PDcIdlGJFIu2isx8ymbvoBsplPKDCKfl?=
 =?us-ascii?Q?5qFP6ARX+0ArxMuB0pye/lleXXTEsQEYi7EeixWxNPH7IohNnPZReWSM+jm9?=
 =?us-ascii?Q?Ge1nijEf4caPivkGCNg0VPVwXJIFMgqCRudma6sZi5pbKS44YjYFTwlokqxM?=
 =?us-ascii?Q?7vPcl4S9GtAl+m7J+B93JLDdJLNtknZmAc01QuZwq+BplYazGGB2DpAJAQ2d?=
 =?us-ascii?Q?s0RHtxavLnhqEELRs6waRpg8SMbMBLXdA5bWnfKb7EUcfdOsu0rjOILKxDdD?=
 =?us-ascii?Q?7lxS4zAj5Wy2vlJDevq5baUmIWb+F+5cBeb7w86LAa7LNcziYecJgglEwAq4?=
 =?us-ascii?Q?5DjRggESUwWr1yOUqWJiZXeEcTCWnfx31OhMbBJCm/1tHnOew/Y1bkBfuA6l?=
 =?us-ascii?Q?/bvylu0TwPm2wev/8XwBxFNMHD1A5OpK0dkdIfzpI6DnNEdQsEyvZ6u9OZ7A?=
 =?us-ascii?Q?+4upZlbMfKi2HVxgk6I2UYvGDUxDXd6KlSr1g2g6779YSmzL+NpKpOjXCyDH?=
 =?us-ascii?Q?B5EUif3JswxSktq/r9ZFtxhH712gAatCaozbfj1AAv/lNxWujkuQxq+RXPpU?=
 =?us-ascii?Q?9uqbtf9I/CsmR35fpw966yFBHel0pu4Q0B7t3l+8UXAa5C0Sf7ZjRPBQusVq?=
X-MS-Exchange-AntiSpam-MessageData-1: +upuhltgQtybaw==
X-OriginatorOrg: jessie.cafe
X-MS-Exchange-CrossTenant-Network-Message-Id: 9696c202-579b-4f17-2317-08de57190932
X-MS-Exchange-CrossTenant-AuthSource: SY7P300MB1543.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:10:17.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 04514c4e-7367-4e0b-9b50-3a190055b14c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1BPlg+zuy77DbtaudQL2FsQy/ECD/7OQEl6htNefnZ4Bz9qeZoMtjiy5SW052tTkJpr6BJizCqyNa2o8P9d3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB1538

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

This commit gets rid of the confusing error message.

Link: https://www.qemu.org/docs/master/system/arm/virt.html
Signed-off-by: Jess <jess@jessie.cafe>
---
 drivers/pci/controller/pci-host-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c473e7c03bac..04e1fef70c9c 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -31,10 +31,8 @@ struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_config_window *cfg;
 
 	err = of_address_to_resource(dev->of_node, 0, &cfgres);
-	if (err) {
-		dev_err(dev, "missing \"reg\" property\n");
+	if (err)
 		return ERR_PTR(err);
-	}
 
 	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
 	if (!bus)
-- 
2.51.2


