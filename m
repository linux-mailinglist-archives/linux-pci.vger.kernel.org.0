Return-Path: <linux-pci+bounces-33703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48254B201B6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F5B189EC96
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB932DCC1C;
	Mon, 11 Aug 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cVAkmlMP"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013037.outbound.protection.outlook.com [52.101.127.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A222DAFDE;
	Mon, 11 Aug 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900567; cv=fail; b=FUy4YujLfM5feLPjXJjuBkjV/eT9BFtZhR95KJ898c7mh5pOuMvX69lSjMAZBN+jjtNAs0PlOGPIKQlbjfbttLksv5AxG3IwMEaF58TQ+yaOao3l/uzlcNm+FtRE7Hiisksee9paTH6FKCduP0hJWRuqeXiy7HoO4jO4ZChCqq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900567; c=relaxed/simple;
	bh=niwPD5V7mtTsNUDLQ41mYL8zo5FxTmk8BpuCersdkGM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WoaB2yy6EyqxuLMT9NbGHqhD4cvHQqLWQH0LZX4ppPyS2ZUB+Hs2mcPIUGcLd3HipC6Um1ce5IcHuyVfwckD4sqG3WwCogaikqM9K1UpFddN1Y4fHdvkGqJSZS+W5UTXrwSc8+D2PYwuz7nTMwrLvAMIreGRfdDXMs5KtDghuwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cVAkmlMP; arc=fail smtp.client-ip=52.101.127.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM4NrciA/514SZp5cc8IrBd+GuO1aOW6eGehd3/CPcsj97IVQJQg+XUvk1LjTNLbR+uy8+DI5VL5flLm0kilYOyRj2nDWUki5pQHt9Uanl2XRTiTBv6exKsR3t8voV3a1R5EmN1EI9fNiBJbHHq8ddE/ee9vUnWJxcLyRxKw7d284h/UAIQ/tMdVoOnuDsSWm8euZuJ+RggmqFRTl6BYpZDBWqL2FXtOKhdjJeS00d/X+dvVV3/yvoHEPL+XXzCLmE+IEWsf8zjqZGtxInrJJw5t3lXp+DNTeM6zOih2bj+svqLsdpGKUq5RacsEe4U7segPl2KsA46eIRCWTGTa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS2DCFVazNTlDjG+FBscIg/fNzcmcHP+gbW/6qdE7Lg=;
 b=J0eS55BJGQ6xvlCamZvppz4dBhXQmE1RbyOv6Q0r8KgGVrHw4myHOFjtE2SPrA6Bjsl1IBxyhB34T2TsOHjJQMXcTkl9l207m+PCVw8+TtQQ+EctqjPUM1Tu4jmyBPfSA+m23h9rGNIX3wSq6s1Tj/WgjiClgKm7A+KuQBFlAED+JlgNbSz9PN4pHKGAafS9Qts8mSu+EYhAlGQ01VuQLUJV07XICHPA3Dyy2vPGgjPbGXd6MbzUr1nPrVQSMCA4iLPBHskwXodiWu0zI7QkyopAM99e4D6AZH81jAJDQXXhParvYZpfJtOqc+uZUW7MA2+Ts00PAoLAtA+mbBV+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS2DCFVazNTlDjG+FBscIg/fNzcmcHP+gbW/6qdE7Lg=;
 b=cVAkmlMPZsNJpN0WeDAzFWy1Q5cHTWmvJ3byTCgsmKJimCE/vYJv3WrwPZV6WJIfrHgfreKwyFYj+EOhybpXpC4nZe9/NxGIc4mJaW4KScfVTVzn1wZKVwVJkih+tKCzfcbYEl/oQsLt62Vz26VIsaBGFwMiFMJuSfbGfrv5XCv6rGfgtXwgD6yizhPDXywVxluc752UVZbOX4IbvowdtbBlxOXKiEG74CC9qe/NdT08GrAcKBfWruqK5//v4lIsSRYMtLdt2HPd7WNic3Yv1C5dWbHALXjKzwtMHnp2DJedK1pWPbIfBpf1QyS3FNUoFRfanwWU/AdqaYd5xGbmZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB6231.apcprd06.prod.outlook.com (2603:1096:101:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 08:22:41 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:22:41 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] PCI: acpiphp_ibm: Using kmemdup() to simplify code
Date: Mon, 11 Aug 2025 16:22:23 +0800
Message-Id: <20250811082223.377017-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::7) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6cae40-f8f6-49ae-1db8-08ddd8b03d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LR7gULLl7APSB4nNFddSqbDpTl3LVMTqPe5OCJ+3cQ4FXJW9qPhHLR7Db2U?=
 =?us-ascii?Q?qo5KVt5I/GR9baF5SXEBzXIU251PN8qmy7BT/ojrLuite/ZcyGfveskry5DX?=
 =?us-ascii?Q?vaaMHpWh5vqDaHwpoeJpjpa76+z+kOihyEm5URaL4k238/hvTpz97yUPqNXF?=
 =?us-ascii?Q?yw0didgxo0ZrBI/K8jRkMspbFbPBRTsCa9IEdKdYc08C177hKf98sa2AT2Z3?=
 =?us-ascii?Q?bz1YIq0OCQZmOZS4aHdcomEkGtfF0jVMNnhiWXGPDAM0a46kYKNSsX4quMsq?=
 =?us-ascii?Q?BfLcj6RKZzZywP9pdr/nDVBGZHx5Zc5BFTe0n/tvG+K9uPK1icy73BqoSIZj?=
 =?us-ascii?Q?2Nd4dpF0IoWTtcDfT5aoXuMSViQ1gCA87boZwMj4DDBC3M+eCQe0S1gmGchI?=
 =?us-ascii?Q?nOFucjqTPsXdiTpH3OQtETfC+Be8/D+UbDQE2tQCZ++HYiCMbQhrKqTGte6r?=
 =?us-ascii?Q?eS2ghVxN9lhnwRhbdNxXGrKdnxUfvSoEv34gD1sFqyOU+xn6ZAQUTRA9qlF3?=
 =?us-ascii?Q?QY08qjOmW00TbWG61AbQpTM+BGF7c297YsxfRNBcD1k2GIWV5z8EZINqGrCv?=
 =?us-ascii?Q?JyOV34+chsFbnrUjR95ULrmqoINOG9kfNGxEphm3+U4lb2JCNFM6EhCGJbui?=
 =?us-ascii?Q?OiYjtmfLfXU9MAIiL0vcZYKaF+JsbsyE61IOAJdk0GPMljxSsFhE/wEEeVh+?=
 =?us-ascii?Q?EQpkEPTpxcf4vrpVIG4GuO0I9VbBCbVegFSG8pwxpQrlkK1+FKm6WDkd+syR?=
 =?us-ascii?Q?3l7WyaOox6BjQbaaHce0+MHesCuTU10wu5HqTHt2E09+B1QzLU1F7e5qXTSr?=
 =?us-ascii?Q?47Uz4p/vrCU6rWES1nGV+4vdDQHalNwRMOXnCqzekFxdfiriv/tBJGbX9JSA?=
 =?us-ascii?Q?NcYjBFxrBq8nr7Pjt8TFg+ipS0JusCvJiBRTZGQqD+WFKLq0silyULlxdiR+?=
 =?us-ascii?Q?BUKAZqORV1PE+sF6VbYjt84X5nsQWSJdDoASdln2lhFxEGtQQHUzKdzb9VWR?=
 =?us-ascii?Q?pmajcJrxy3MonapBKIOWHJtM4OZvyZ/g/y5RSraTiogl9g0ztRoi9DzSBwbC?=
 =?us-ascii?Q?4SRwvN9KgYgLcnZ5m840x/6qVc7waCS8mj7dsB5Z07oHMN434P49ewwAFwv7?=
 =?us-ascii?Q?MV52Vj+dxkX9yzwwf2POoGffxCK6+KLYFlQPdYqTgxY4IIBt2vDMvku3vDyu?=
 =?us-ascii?Q?MMAv/DELG2FHjwF1Jn7bm9fkmYkgxfwJoCr90bdTt9ygt7gPJafsct2mITT3?=
 =?us-ascii?Q?yZYgFa73Iah120IyBa7e/us/0YTEAlhaudxO5JTulNEzStnPCMR+uPGfTs+Y?=
 =?us-ascii?Q?O0rM+Nj4ExD+p/321ItneHogCuRBd7gIHfy6rFX2gs45iwgeA2icOSmm6J5j?=
 =?us-ascii?Q?FszXY9rWI6/fMXNxGpLoTIRXbDAxyds78LZz+1NUtnOwmwVXKnSxWbl/hMUG?=
 =?us-ascii?Q?beZMaJaFuK7CXvpiJNfc7LnJfqsddU0l5HUOVFDR2XlQIxT+gIv04Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FagCC1ONNQy5DXzO6VEXPoyztG81TP9uHqKkJ5td3sRVoRGGZE5LX9w6iOgY?=
 =?us-ascii?Q?Dhfzbht0cpxsqK3WKCEzN7E2ZhqPedC3P6mazHQsOPtp6nadjiOaxef6k9sw?=
 =?us-ascii?Q?bDVR2u3JVIBwnXb9GHxGmTpoSMohYGxqle7x8YIGXvSJQx+Fi1xGhzwtUFyK?=
 =?us-ascii?Q?fOzrIhdZ+Q5WaY28ddHIcmjSEphAx8VRwEPREnwjEoBEJHul1NQ9AYC81BQY?=
 =?us-ascii?Q?cABk5mAvFbPn18syR3vAJEa0qQuGnzOzCg07OfrpXUM5uR/PCo1i6jQ6YHp0?=
 =?us-ascii?Q?eonPaxliFjhcv7FmweHnRSmSI4Zmt/vNCu8swxl6X26zYXQhbBajNfET51Go?=
 =?us-ascii?Q?vpm9+TEsc2DpYd7q5oYJ1Y74Z5O4i31gQWMIz4EcNbwm7PAdo2aUPWheERfp?=
 =?us-ascii?Q?11bECDuQDSYYbY950gVKJUm4re8NRcQgcL5ELpAqhB2c+YOJkiE6gpCMNJdw?=
 =?us-ascii?Q?bCkOAHluG4ghx2KRwV0ZhFIsFVSI9yVspj46MiUcXOEWVec1cZRGE1FcefIo?=
 =?us-ascii?Q?Dio95eoMFpdDTZ0+nJuelmLuxZFVJsaI9XOeLTzYAcgbMvedNERTuSZXucqU?=
 =?us-ascii?Q?xbVEcOM9xZwVNDhML5dPvTyE4biEcwp6w98AbCAkCvVQdkQOk5wbPlBV5twh?=
 =?us-ascii?Q?9q5KssjDtDQLOFB30TCsxgNZFU+Ardv0xNx0OCI2l+dLsW+4SeIvtoQFHKal?=
 =?us-ascii?Q?meZ5R7uO1Pbgt5o32WTsUd2BJD6ixdlQmnC6qt40L+cdYih8rcTjkquSNmGr?=
 =?us-ascii?Q?t4eWiwPQjWO1FcHUZDubX9SquZznrY/qBEBWAHMd1dhvQ6SHm2r5vUMQ5/6o?=
 =?us-ascii?Q?j4AcVsp1IE2EujgIpbF2jXSgSKfo+4aNbR0qFallu9ea1DgKD2Ih5K1XhUsp?=
 =?us-ascii?Q?OY2vZcnAc4YQzxgzcjM0CP5h3sFlzrL3uazvErD4HzsZcPcCuchuLQEUjho8?=
 =?us-ascii?Q?aD4BX/eJOHCwCX2OivDWNtDX5YhvmXrXuRwrtVF5GSfsIv5BUJYgGs8fWbud?=
 =?us-ascii?Q?aeY/P8Pqww4biQTRgPPi11UnDyvFEw5Zu1zyiCsFhCeqrkHbqN8A6Eexi+Iq?=
 =?us-ascii?Q?bfvLh9iRINbiZoQjPAAK4+uvD0mJsrSKz3jPErsUg233zzAw6laciDQTtcYD?=
 =?us-ascii?Q?sQqUau2KfQaU1xGogL/8AjP+aGVFVglFFjOKHyAEU++5Ik12WH3DiwhbIae4?=
 =?us-ascii?Q?C9mQt47qpcUIUdgUdqZZFMmp++AF1GOMjWinm1zlYfqg5vtqeMrtOkoltydu?=
 =?us-ascii?Q?SgqIO03HISZ05mgTqENR2Q+XpxMaFmn8jRKg+R18dLesYHo6SeayQROb8nMW?=
 =?us-ascii?Q?iIz0we6zI8R8hhvScfLjCUFRyPlcDFw96ApCC5wUwGPq3ywMAbgjB2oaVqdL?=
 =?us-ascii?Q?9z7MZjUxEUfcJCQB2JUVuf1tonGpXC3ypQJspYWcX2yZa1OxmujNAfUIZIhV?=
 =?us-ascii?Q?QERZaw1s05zylTGZB7+ZbJFt1ay4+Bw8iB9JMwcl1V9Rq03L1d0OWq79SxGV?=
 =?us-ascii?Q?LZUfKhK3Ocs5+XoteCFsda5k/N6kkTKtNZRxLh2K82Of+uIS1dlz19lWd8tO?=
 =?us-ascii?Q?IrBV0aiGFZubVAPpGPMIpXhY+HA+UC8turFFF815?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6cae40-f8f6-49ae-1db8-08ddd8b03d87
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:22:41.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD82g7VN6/twrB9N9y/njdnvOLWF/VkI/kt4YBBSmWa4JIeXtSdV9dEGtv6X4qeW8qAT0W2ljhtQMzR2sojt+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6231

Use kmemdup() to replace the original code's allocate-and-copy operations.
It enhances code readability and simplifies nested conditionals.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/pci/hotplug/acpiphp_ibm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 18e01cd55a8e..6a16c8e8238f 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -140,11 +140,8 @@ static union apci_descriptor *ibm_slot_from_id(int id)
 		ret = des;
 
 ibm_slot_done:
-	if (ret) {
-		ret = kmalloc(sizeof(union apci_descriptor), GFP_KERNEL);
-		if (ret)
-			memcpy(ret, des, sizeof(union apci_descriptor));
-	}
+	if (ret)
+		ret = kmemdup(des, sizeof(union apci_descriptor), GFP_KERNEL);
 	kfree(table);
 	return ret;
 }
-- 
2.34.1


