Return-Path: <linux-pci+bounces-42328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D1C950C7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A63A3496
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C68283683;
	Sun, 30 Nov 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Y4VGUsQY"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0340827FB1E;
	Sun, 30 Nov 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515475; cv=fail; b=fq9w/99ryhQoiY0M+txU9CAgYqDl8KOtF82RM8Dq57ywaJ4Mi4XBLDIDuFE6UUonuijZgy5Gsfms/4aMG6u/ZM5/NSY5+2AkP9+FcgDCIo4ONFRHXgw8aHV7T0tMQZAERgeghDbY9fe8fEu0XJ1dC5E5sQ/JdinwU0Oqp2eZd4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515475; c=relaxed/simple;
	bh=kQskWWtIs3dq2QEqSb62M5nTdddcCqrhR2KtArq0fbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgQKF8+3GeQhot8X5HBIR0NGgGv0F4hat/pwzKOuVV5ftTiOK1HVZW9gjpxwLWyfPxc6cMzsLUNbWpLNoCs32K5vJun6WwHVB1hqH7/TT1Eqs7N7JwPm6KMTay4HTvTvAYSwj/M6XQZS3Gms7eOTtC+n/Fd0av/tToK9g7e912E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Y4VGUsQY; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFhBFFTCr7wEEtr5tEHS2uDb3FdfPNkxM3VxE3HRhf0OUszlBz7mUE6nOc83B8rnh4qljjFg9FWIJeIFqnYQ7nsByT337Bqy2qJL+Z5Gaxjuy8KDAowrr8t9EPmLvVCDIlw4qG/kmrshYh+8Ndc4M7pTFZFOEy6QRR18Z0M44MP8lN1U1RdcKze0/gkYniNn787keQ5Hb/DBZEwXCpTDT/Kqby3QwlkHZAIt+pSUaJIYtjsYrbQ07cE1VaYRQfdJli9TowFEYmwzAJJh2jfcLjcHHoP3NYklQ+gjtDjeK+gKX3Mcck7VFXj8ohXqxq0ghNySqMQCjMHvpnVvHYpygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I++yll8TSjloR+LP7mQ+1mGSxZ9EZxoJoKEUH08NIKI=;
 b=IX3QXDlILzeyKAsP0qaWaVopMS7Ig6YcbuXTgcS6h9INMWLtpc102xWi7vjHDY96uYirPXAqewEEtL4KXXyztLTbot0Kz3aGbtCPjK+NKjBSWoGETpAD/SW/DFZRfvyFZGun60DT47a8tVs+7NQOcyst28mK2WQfr0DRuC54Es1fgEIUfEadw65v3ay+uNJX1aW0hv5RlJbc29dpiUuMv/0Jx5Y24f7AZysympb0T/JUl2s0DlOMQeuyEJ35LOoeuvN0PfK0FA/eQ8Ta5zkrblVv7bjJc0wRwcKK9tA7E5hpTwzFIZI5Zixa8vCWWIGNJn3Nv19iIw4+0383taJyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I++yll8TSjloR+LP7mQ+1mGSxZ9EZxoJoKEUH08NIKI=;
 b=Y4VGUsQYciXTDTojSG/OHeN4L+/fyNPo6Drz3AUhcsYlNx1z7asuHBrVf0LH6LbLSrW/eB4jA3HcF0SGNIiPpvXIppnv2eAPA+FzVa0U+mht+i22TIvYoRc4mLEsYz/GKSWHpQvEf9oHoSGJumkPOcI1//SCi3agy5oQ1ptWaJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:07 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:07 +0000
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
Subject: [PATCH v3 2/7] PCI: endpoint: Fix parameter order for .drop_link
Date: Mon,  1 Dec 2025 00:10:55 +0900
Message-ID: <20251130151100.2591822-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251130151100.2591822-1-den@valinux.co.jp>
References: <20251130151100.2591822-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: f5af7b2b-5e31-418c-c3bf-08de3022aff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cdd1AttA7Acxpb5/JW4U6U2RydmK53mh8a0F86yxuGLtbBn8BhLgR6VqVlM5?=
 =?us-ascii?Q?luRbNPxWMRjPG3thxuiN3QT4WDz1CmkVRPb23EOstQOu8odw0bi2KkuagoYo?=
 =?us-ascii?Q?mgt6/ygV6nDe9Kbm715588be9UuchKkkZSZelaJTwzqM4w7NYcJSiZ0+EyIA?=
 =?us-ascii?Q?vzMyIO0LAOclpAF1Jbxe5XrUIvRDxygoxgKaouoL8z4/c6pGmzHQqmKwDu19?=
 =?us-ascii?Q?3d1WvhobQEf1wqeZ4rZ+QPyDIqM/Ruxllg3SmRzMUrhruuVkhBjhgMnBimaZ?=
 =?us-ascii?Q?5JduSF9JC7Bejo0L+41L6GW6a1Odud2EBUwMnshxSLkjdKJNYfdVgK2lOsjU?=
 =?us-ascii?Q?GaDULRReUrdj5s/eErwbAulGWyQb7rKtyENuownypAV2ao3EvN4eCb2myyz9?=
 =?us-ascii?Q?Q1w7iQPWep4zLMlP347djgvC3BChpLZVrDBowXXPxOxw8TbvEWnZ+RHilBfb?=
 =?us-ascii?Q?31DJnKA5uMo66TdlqMkS84DxZlHIDwwht95kXuqbE/lsdZGACJbWwrVcgpH0?=
 =?us-ascii?Q?nz+cdD70BtpeucKKLsVubiogZezZS5vwWT3LhwoHALfrzEyhqEekuG6B5V1b?=
 =?us-ascii?Q?1RFS12l47c1TFhM3W1ZRvVyYhvE7CXUf15nyfNYHRFeKndLDNpdRdPjKz38I?=
 =?us-ascii?Q?mO6z0BPT4ylrY8nfMs9k4tOeALQTi0QWAy2zWSQtq1lKJpy5BSfIBuV/F+RE?=
 =?us-ascii?Q?W6FKTgzSIafdTXfT++t8qZrCTkkG/tk6tD1xBQEOg1oGvUiq1pFBNKH77gw2?=
 =?us-ascii?Q?0T8DBQZvbcpgCk9MzPK18ZciTGx4+5c6ZCdVZEz9AEsCc7HyiqQ6MlNll/vQ?=
 =?us-ascii?Q?2lMoMFi4iKs43E1OGK8/96Nrk+SbtVu8b6FasiTnBykLDj+Req1ZRJXol/Ey?=
 =?us-ascii?Q?ax5hvg2vlUiS7cpjWItoxFFTSz1JD3JyC6toAfvSvn8fBx3uWYGKjXPJgDCh?=
 =?us-ascii?Q?TDkqpJa5CpmqNteDIuFEl1LfRcIkeRwig5tBdZkBTOUf5JWq+yGvhHiE1Twb?=
 =?us-ascii?Q?Re5Zx2+dahiQDbyTx00qH8aUGdYbjcsYjOm/US8lWI7qrEAWQx4RoF0+aHwA?=
 =?us-ascii?Q?ndxg2fW2qmEdS0EkiD8zEbryOSJWbkOOEw82o6iEANmn4SMntV0Y7iJMpbsH?=
 =?us-ascii?Q?NMjdMW9rk7Fja3RiYRGEd8zwaSoax1hfEyFVU/nZbm/55X4kZDH5uIUrqqrN?=
 =?us-ascii?Q?/Ltmh03u+JsF8+KIEObyz2LQC5NsxKPf58RlCuFdssvjkj/lstsAFInIfoJ4?=
 =?us-ascii?Q?vxiCAJU5QVfyHWMOuBY1qda8j8oxncv45g4vCzZVozkNGgDhj7St7p4EviS6?=
 =?us-ascii?Q?L/O2KeNulo1qvM4KmO5Xipa/kAzte/7D52NuhJuQ4+BtHhwdp+kQUkIsBBEM?=
 =?us-ascii?Q?FblKtHYtV0bVyvl2e2Uz7NEj4ERJM4GwJW+/jU5ubAF+Zsn4EqwnxMoMvMBH?=
 =?us-ascii?Q?33ygP2pUlrkY0kXVQXLL4yCJnS+kdjV/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tKz64emKPWfSAruZDZWWUF5F8emlaPTTwFz+xcWPih6FrvqcQojJyWs+rqSs?=
 =?us-ascii?Q?D6TCHo1DM0+qWYjqIOy0xnoglLTWcSWhJs9wnEtdqXP++xppkuEZy8xvtHy8?=
 =?us-ascii?Q?mPp6zt/WZmk0PMlGEZkDlzpoOxw2mVesKs8DIQyKXud6hgeiYnbssSD1M4MF?=
 =?us-ascii?Q?eDUZVccqMbKD4J67w6jtA4cQu8XDLx5S/hOvWH92Vr63NuTEUkuAeM7IZk/A?=
 =?us-ascii?Q?HthDsuw1AZ83mIwlmGnN9mWavDNG5b0tRGNp0MH7DRgZdQnHBq91SgPJ9GfH?=
 =?us-ascii?Q?1gDlGjxRWE0lDiCS4Xsq0U+iPSjaDra1PIJ90GU6VKiLj4UJAwtt4Op3cPZW?=
 =?us-ascii?Q?lQIoXyV7EOy2bzlLwZTsSjtUkY5wNVHd8yCy6ih1qz6Tbe+LfPWFj7zcw5r1?=
 =?us-ascii?Q?S3XBFTQ+pR+UAp8cIG6cS2AyCQ4ANnfrZgHStFxMX5JJa5TrHsRdHXMazTeM?=
 =?us-ascii?Q?hSOe5pz/h9HdOc1xWnUcJYOXEHd8o9JyX3DPb5MxSDKsmia7XoHXtHgWwjX8?=
 =?us-ascii?Q?Tiwgd1epW+6K2NFHXq+2s+5PBD2psQ75myUc8BI9tJR/7xa6JCkABBp+9ZiO?=
 =?us-ascii?Q?jpJTAdx4pKDaQ4SxyB0qAeLphiSoCL8UfeWarpUH9GveE86NspTquXar5mPL?=
 =?us-ascii?Q?2RNtXgCusdQyYDdNZtxPZc6wwe8wI945jBgs/ZPfJ3kZr43qvwBmJhyKCEWh?=
 =?us-ascii?Q?UO1XA9+nypzacTUIVMdftebgOpvtDuCyyfgd26nwmFXFwjUr5VcLq3okOwPR?=
 =?us-ascii?Q?u+a7In6AhvGiLZ6ZjKPQEnOIsm6AfmcQm/0uKKl2uF0rHXBfNfIVW5aq1bPn?=
 =?us-ascii?Q?TI0oqFqHTKtHNdKNgPzUKS71YJiGlQuKYxnZtA7lmIOJUW0veBhg3uWZLwdH?=
 =?us-ascii?Q?yWOy+n4P1q5WLANAQ7pjcmElunJy7nWDD/93zRRhW5cIxrpZDInAy7cpwoM/?=
 =?us-ascii?Q?uHXRUUzZ1gTCO6LoDeVqypzIRGKNyM5JA9HTNbnFo2MNHIDhsOpyehB/Zdic?=
 =?us-ascii?Q?OebP3YoCrKhnZbAVHgstKme8lgML/khuHdWtSz7EpOqhIuYv+to8g9IEL1U3?=
 =?us-ascii?Q?tARuvgG9LHpigbXjgVVlODxNwZd3SqtvMWzqOmarh6HLbn4cdQGvbqMIkxyc?=
 =?us-ascii?Q?P8fzP2hw/zdT/mVXGjCPBL+R3LORX3bXtEG+kjKmw/ZXGgbuDT1EdaBj4UQ/?=
 =?us-ascii?Q?axZ9jPnubyzDF5rEXsZho3P05Gh9pKMyLXWy9+N4C0lkRyFPPsV4vwG4U62l?=
 =?us-ascii?Q?0VwnTtRx77f7DuuCLRjR5tpKXMPjNIBi1cgancSInJrFpWCL9DNCyXbVZfcJ?=
 =?us-ascii?Q?ICnuxSNjMvw4Lw/JtUfh3tRLDDiOwiBfL5gh0fPOOwcVNcswv3rjmAam/b0E?=
 =?us-ascii?Q?HCgfPELqQMHDcxgeBXnKl0oiG4v21p2sOm5dOFpremPS8K9njKxK9jzr0lEd?=
 =?us-ascii?Q?dQUpU95BNOAVVgQbRf5pKeHvPY/gmIdoCJPMsfFmy2y0DNicFwA7aqtLUddD?=
 =?us-ascii?Q?45tOL7QEv65E9zQR3xeod1W0XHty8p3OA/Yg4HqMHhxTGCoIy/KyFPp4HYsM?=
 =?us-ascii?Q?lgHyxJNAx+i0K3Zipo15WKmjfztWCmNp7Ygy2F84qKSta4Y0PNHKCkSApFFu?=
 =?us-ascii?Q?naFLTdLcMJv3sCLqKr+BNk4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f5af7b2b-5e31-418c-c3bf-08de3022aff1
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:07.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBIue+ZTXCymbcyuKt6n7EXAcDb/kfJALT11h9tdUn8gvdpjWDt3pwtgdVYu6fg6LTrt3tXA+7QOhPadCjyCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

The unlink callbacks passed the parameters in the wrong order that led
to looking up the wrong group objects. Swap the arguments so that the
first parameter is the epf item and the second is the epc item.

Cc: <stable@vger.kernel.org>
Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index ef50c82e647f..c7cf6c76d116 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -69,8 +69,8 @@ static int pci_secondary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
-					 struct config_item *epf_item)
+static void pci_secondary_epc_epf_unlink(struct config_item *epf_item,
+					 struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
@@ -133,8 +133,8 @@ static int pci_primary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
-				       struct config_item *epf_item)
+static void pci_primary_epc_epf_unlink(struct config_item *epf_item,
+				       struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
-- 
2.48.1


