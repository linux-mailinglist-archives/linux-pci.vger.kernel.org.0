Return-Path: <linux-pci+bounces-42329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E64AC950E2
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19B474E15CB
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6322848A4;
	Sun, 30 Nov 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="R+D3jV8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21B2836B1;
	Sun, 30 Nov 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515477; cv=fail; b=gTRoDgWn5aNeKljmMy1SpYNmYQuyZ8nE67lR13UWmpWGf2IIj8WkZe0UwJSHaP2TrsWd3idiaqQL1wMIdSDuWMtkzF880sQlGDuDKdFoo+J/z7YapyXEdzjCKrw9vEwZKW0+TIDzRpjwZMM+NXqlCvU6n4jRmuHwO/8mTHeEgOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515477; c=relaxed/simple;
	bh=wFhE9Q+XxbX1jLRxMK+EUYiUQzRLl1bDyGpu5AEwkiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTW6xu25Ecxdeuw8Z7H6yxIFR9FMBkmzzXMErKxkbSKmLoBiZrkS/4MsSkkQTzHSZSE6U7WbCAE+m9qQdNGMrZvWYHDyBCAp89lln2yOTBgDWkGbkVdWBOkn5GydlrbOtUOLPkIAtpIrbhqY2BPyGu3alPevHwjBcfMb4htoNAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=R+D3jV8I; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDGgL2falaq166BcrZPjcFO28TT+Ri6YehHEXx1q98mj4W2tejkjWFYlGxuavBcx4lg51ceD7mkTI7VgbdxTO7MNjEvtzrW06OzNlcP0Wtqsg441UCJ6MiV376Yq2B1+ubQ7NcDMuAJNJqm2uWyB8SyaTriJ7AWamZTP1GLRGXBn58wOKXpHCShHDLgR6OOZvpa3ShhyG2DoKqbAsV5rn48gXG8cW+Y59TRDql0bOvSQkvHDdBR8hu4rEKNPFDGS5i9St3WFZUnnZztFAQU9hijR3/JsUbB1goked8b3ngg9UnyY1U6QS74SQv/fjtS1PlXBJ6VlotqE5VjBsb+zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUbXZaNgaExAcWtrAOlLg+aS4C25w4bx4IUYpq7ovFc=;
 b=MJQrpcwqBRYj+BVYK1UJpA//49VQCLRggEoRVUTMMi9GFJcN0yotP8+gaeovpz6/rGpdAzL+sGUExYl6JhVvgcaeVVQU+WuwUmSBZT7Iv6gCXl5xLsA0xR3doaFG2dOQ8AD1/u0lmNAZML+notpGyfGt9mIPWYl4a6KuLvPfb2Gj6URhVlQ/COME39ow5NEA3zX5RBH7Ac7rI9gTMvTf3pphFG1TFx/v5gfDZaDwZxEMqBsGFmpX9mFZQiJuR+v2b3YPpkUi7MxOSLQHapWyHXueE3SiUl9HTRoPNeLrCofDj/P145vtHqsI0KB9fjShV66p5Viq20phjj6g9LQDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUbXZaNgaExAcWtrAOlLg+aS4C25w4bx4IUYpq7ovFc=;
 b=R+D3jV8IoR2rQ7RokxHi7BBagWKWvFKZhFfCytb+Xl1te2Tk5cRNY1z4cO09/mIp4OopAWf56EwaL0g+YJc3G6QjFRQLCJw+WWpybZprtgItiBFWR8Xhp6lkziukYyjeFyM2+4m+AuU2pii+hZymJYLkKGlDuToy5akDx1I+qgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:09 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	stable@vger.kernel.org
Subject: [PATCH v3 4/7] PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
Date: Mon,  1 Dec 2025 00:10:57 +0900
Message-ID: <20251130151100.2591822-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251130151100.2591822-1-den@valinux.co.jp>
References: <20251130151100.2591822-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::7) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 520ea7b2-5d65-4fed-ca5a-08de3022b162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWR3eiGUlKmFvh3Y1fsU2A0HdmaYDoEOC/V9KwGEj8mxHOdizipkd4jG/GvG?=
 =?us-ascii?Q?F8tddm30DaMzy8weVpiaIUIGUlWw2iTECiTJ7Y+gV78CtCZwuayfRABCZrPM?=
 =?us-ascii?Q?OSDaXyoOwh2ddr8171yUdL8V0qDtTh5pfHBV8FsuBq1V1nEr2GW+ayeyXp07?=
 =?us-ascii?Q?kutXGW3dgn4vWUUjik4SdKnGgE12qJedUxdY1uN68y5ccrkcUDwqfvGLN80c?=
 =?us-ascii?Q?tPSaJ/NZXpx4Hbe2rTIGQmiuKmWy0EDJf1RnFTrCKHa7ACNa6VqrXUl4RxS3?=
 =?us-ascii?Q?/Mrp3AqVz5VYjdQrdJ2RTkksDqNqf9VRMglB5LwTJauj4be+ADyrG1d70Pqc?=
 =?us-ascii?Q?GqFShhX3qh9vj84yZWvRZ1lIR7M/yfQQSS62VUFF4gOcZ98aSTGWHzRyR3qw?=
 =?us-ascii?Q?VejgAAJgs0qPrE1PStX/llXoGXjNvUEQYePlTGFr0cAspNeOXF6pwi9YRrmg?=
 =?us-ascii?Q?E0XXL3t/P8Xid70EXpyfG/lTUw1fUDkuX2FUcN7CAAoHhm4+GzNkU8KVYyhF?=
 =?us-ascii?Q?j0qUqLPDPbg8ny2/Cs8+/eaUv9uUvAJ8Je38g/HZWVyxmJ07ywa7v4rIG23Y?=
 =?us-ascii?Q?VmAy6WLZPpEIC5dP9bAcNOx5nqnLCcVpayKkxTJxIiJPF123UHHATWGXOC1F?=
 =?us-ascii?Q?hG75FX6abs3fd8xK3QiYSwqZsBNWanw5D4Lrs0Powr1Ig/8buc3mblWZoskS?=
 =?us-ascii?Q?B8y9xog3B6WaMFgCZL2kWCMvdvkowzd1lSmUuorG4Nr8DltBZYNbHMLO0+zq?=
 =?us-ascii?Q?pqRSwFzF2IKtXFqSkLtgk7pCR5kFkaEfOdmbyzXCp/t6SCNawxmS5QOCebDU?=
 =?us-ascii?Q?OZQTWLi8uD0wH12if34MZAwrKXxg5WOfsDwuVdWyT+eW9RHum6w9sG6ACGoF?=
 =?us-ascii?Q?mH8jTBeTLOKO/3zB+iy66lgODva//XWfkP2wWNCNRbS3MRQW+C7KJztyG45j?=
 =?us-ascii?Q?kHMOaj3jZ5rc6J+K6RhlmuUtGdhPOB/+SQXTaiGKLCFa6VymTP0n+r+8p4rg?=
 =?us-ascii?Q?IkBHT6ZYObOjIfOxnMG4k0DhzstVRGnxu/+8D8meC6AZNrgKmjUxXJe0ez62?=
 =?us-ascii?Q?HOPRW/OlBBtGZq/eI2YrwbeayoC7iRYOCiIUvtpcnfQigbiOx0gXrr6luC3A?=
 =?us-ascii?Q?7repZKchQ3s+PU6AU6vJeV6qRPotzTV4GJ0N72pjXNvcDKFu+nj+f3AFrG00?=
 =?us-ascii?Q?zVPmn7Ar/jFq5UWaGac8FgfUx++4h5OO1DiHlK3pnZB7uX/mnY5geMcNrx+g?=
 =?us-ascii?Q?JAyHBnw6km605r6FCB1LQ8kTExLHwZJam1H1xQ+noEAwR8g1NdYgYGPNlD5g?=
 =?us-ascii?Q?lqV5Tt4gvK1w0N5uGEwMvEg9IW1FCDP4+cWYZpOrWBxdPdN2nAP7+BtLE2DG?=
 =?us-ascii?Q?H6xd44n+Py4iYoWsAl41jFhqNKqAjgkm0OtyJiNtFeCgmUAW8knCOrC2jm+i?=
 =?us-ascii?Q?COoyG1i5pUvG5Y6cPPR3t/BpoDBbbyaD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7tLf4RRE/3o/7G0vJ6CkGCe+OA4eeUxthbFUs3pgsZmjheqfAvpNwhn4RZ98?=
 =?us-ascii?Q?9bpiCf5JD1SgPNGcEL8WqRGOpsmZG3chPN8W9jt70rUmoe/Q4uFALW4j+Mfd?=
 =?us-ascii?Q?h6MxBbcXkv5Mm0TWdQ/qgNBZLMzJ3DTLcr16n903GJpeTb2W8Tugxz8/76Y2?=
 =?us-ascii?Q?CnIrjE7uihfexPhCckku9HfbBRic+pY5MhxdDhx2k3YHDnKXLu4JPQY+qt10?=
 =?us-ascii?Q?MAmDs4FSwCJYQxpwH7W4etPvvZ/8hf1lI6ncyOpt+RD74cswz4Dm906j6lYl?=
 =?us-ascii?Q?PshlPm6i+a3NN7nN6CDx4u7FFBEUFMRVfb+V7f2JTqpoI4NOUBIvptXaHOrs?=
 =?us-ascii?Q?mHJoWFkNkVhodztxzOee8NmH9aYs2B62bqGapOG97T3wo64xMzZpBf5TYcY/?=
 =?us-ascii?Q?C4QowBAAd96fcR6jAG2I/CKNxIsSu25EFVCRfdpWUKnnD4K0frqLSpWn94qx?=
 =?us-ascii?Q?IFqyYkml2ZR3vfP3/mCiCfypRLHMWI4wcQEcEgjXAj06uT92mWbik9Rq4n7K?=
 =?us-ascii?Q?ekjxBwo3Z6ZwWUyJ4vhCqvSMR0E5G2/B49imuTxui1g8JLfXnDX+jss+BP+p?=
 =?us-ascii?Q?rzO0PtcHW1bH6OPdnfnT1MbxOkQ3CS5gpcNZ2Y0gRN+Dq4Oji59Gpdp2Qqg9?=
 =?us-ascii?Q?As35SFUEs8qm9GIWdfK5bhu9C6a3li/R3txcoQnNhdSqNksBsxBFSJwegVwR?=
 =?us-ascii?Q?/1twiafPso1AMKkFsVVezrRc6/X5DN9srGgmTFTz8xhgw0gnvcYyNWEG3q8l?=
 =?us-ascii?Q?BGWalNPg1uIR6mb4FjBtezhpzmC4RPRfNkiQ0L03tBZvCrTykEewcj+FDgui?=
 =?us-ascii?Q?zcjcxTfuBuDur9Ou73qwY8pg/wcmv26Lw7F0BMUa/qlqZdn2jcuNNi/ac7C8?=
 =?us-ascii?Q?V0BZ0C8UqrcGNGngYsXCPdXiycjUPlO4GyiXnmbw2O18nW/++EJF6YNvT5mJ?=
 =?us-ascii?Q?d1Mt+5xaAvJTf07OPzKAcG3IfFnFkBUQ0Oo6vrrEzH5g25Kh5EaygU6jUcUs?=
 =?us-ascii?Q?eClBVEkbVQnqF0AKL3i5LgbkBWCENPVoNgXxs88NurMYI/MhxYwvj5kKPhRx?=
 =?us-ascii?Q?fart5LWBjM9Z2gQE6vTnTAKVbBjYCYbU37++g88MCCDisWtElb8LWXOIZdtG?=
 =?us-ascii?Q?qFiZ/Vb8mhO2+Vuz/hjnqMMkPL85TNcaBSfYkO/LqRzSXK1lXfUC3p4f3V1M?=
 =?us-ascii?Q?iQ2YPcJDbZKVehZXVO3abTwWjtRKhmzxtbCTohbe7pjkz46Jzkkjr7PmP8lC?=
 =?us-ascii?Q?SGNPZj+y7zi1HT5g2t6QVVT8G6OWqLH5HyNfAYRzd0hY3QH5LGvY3auNRjpC?=
 =?us-ascii?Q?DEnT1aBuzynQAdGbPUl/V4kKR2S7lObJWz9eTavCSj1rFYN7Zrt+iSEr31BL?=
 =?us-ascii?Q?5+MmDPgC1iCF4kHiLGm714w5/Xd8yPcsHG7ShR95fjR8B3WAKAEZfAyj7TjD?=
 =?us-ascii?Q?V+GZD8TFKQXuW0a4YxLOEcUtQsDfOPoqYSJtHbX1tXO9G9D60N4m183UrlYC?=
 =?us-ascii?Q?NsGwpRURUH+xC+let6aErYexid1NKXIlgmhM30SyaqdElzF/m4qoU/30CdV/?=
 =?us-ascii?Q?3uiwPSqc82w2GmNeb+0JBzY4jNmWIYokl/tgLNjonMpvLQy7S85HR2RYgERK?=
 =?us-ascii?Q?3jZE0a1voLNPEqnvc4FQF6g=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 520ea7b2-5d65-4fed-ca5a-08de3022b162
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:09.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhcdI1eA28UsWCnXwo4AX5x+Fw8bw1ZVUFNIfTHE3LkcTFvDUJ1n5FLPTntY68L3LeJnla6Fmd5Neo9UBPXJBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to do later. This leads to an oops when .allow_link fails or
when .drop_link is performed. Remove the helper.

Also drop pci_epc_put(). EPC device refcounting is tied to configfs EPC
group lifetime, and pci_epc_put() in the .drop_link path is sufficient.

Cc: <stable@vger.kernel.org>
Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 56 +-------------------
 1 file changed, 2 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d21..7702ebb81d99 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1494,47 +1494,6 @@ static int epf_ntb_db_mw_bar_init(struct epf_ntb *ntb,
 	return ret;
 }
 
-/**
- * epf_ntb_epc_destroy_interface() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
- * @type: PRIMARY interface or SECONDARY interface
- *
- * Unbind NTB function device from EPC and relinquish reference to pci_epc
- * for each of the interface.
- */
-static void epf_ntb_epc_destroy_interface(struct epf_ntb *ntb,
-					  enum pci_epc_interface_type type)
-{
-	struct epf_ntb_epc *ntb_epc;
-	struct pci_epc *epc;
-	struct pci_epf *epf;
-
-	if (type < 0)
-		return;
-
-	epf = ntb->epf;
-	ntb_epc = ntb->epc[type];
-	if (!ntb_epc)
-		return;
-	epc = ntb_epc->epc;
-	pci_epc_remove_epf(epc, epf, type);
-	pci_epc_put(epc);
-}
-
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	enum pci_epc_interface_type type;
-
-	for (type = PRIMARY_INTERFACE; type <= SECONDARY_INTERFACE; type++)
-		epf_ntb_epc_destroy_interface(ntb, type);
-}
-
 /**
  * epf_ntb_epc_create_interface() - Create and initialize NTB EPC interface
  * @ntb: NTB device that facilitates communication between HOST1 and HOST2
@@ -1614,15 +1573,8 @@ static int epf_ntb_epc_create(struct epf_ntb *ntb)
 
 	ret = epf_ntb_epc_create_interface(ntb, epf->sec_epc,
 					   SECONDARY_INTERFACE);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "SECONDARY intf: Fail to create NTB EPC\n");
-		goto err_epc_create;
-	}
-
-	return 0;
-
-err_epc_create:
-	epf_ntb_epc_destroy_interface(ntb, PRIMARY_INTERFACE);
 
 	return ret;
 }
@@ -1887,7 +1839,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc_interface(ntb);
@@ -1909,9 +1861,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1927,7 +1876,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 }
 
 #define EPF_NTB_R(_name)						\
-- 
2.48.1


