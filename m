Return-Path: <linux-pci+bounces-42330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0201C950EB
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 201DF4E17E6
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7EC285C8C;
	Sun, 30 Nov 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tMcxlBQ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011051.outbound.protection.outlook.com [52.101.125.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8128467C;
	Sun, 30 Nov 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515478; cv=fail; b=QVdKAg5I42jC9s82rtcvtp5HxWkZDuWnMFz7QD+IRTS+sDC8EEQtdBr9bZgNxol5vEoT6G/xFk1w9kl89aWMdwV5doLNyNroP4kFGWjxDFjub+2m7CpPVRFbzT47PG0iF2pXAIhj8RguO6yNMxc6Jc4QKDSeYWAjngbu/qpTG/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515478; c=relaxed/simple;
	bh=O+25aDE86dw7kb8Igth+/Ni3EWo+0WC/Hj559OO8YVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PckmTIEJw7FCTzoNpKYVcXDP+2bZvulR58bv2eRFIlMcqI+tBBLn7TETZ25izybQUWb2tIcNXGNzpY/q7da1fzL+m4+pbTt5yz2ueHeSJDO7Zu3FGZ79oaSCQvhwm2sr0zaKdyNdF3zdA+iB4jEISYGaw58Uq30umo7Q2Y6KK8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tMcxlBQ6; arc=fail smtp.client-ip=52.101.125.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7T6/dh9Bimi0tYgs8eM2uWFh/XVRgZSYHay6wnmalbBTJ7+Yy8r8WnRvhnSRyQm4Sjcchh+1HMJ+hRPfvko/mnHkbnS2o9RBi3xPCvJImpW3oMWu1btxLMAsWwvRUJP2Ok+g15iA0e9EwECnDi7LfKLGoTcPDWUxw5N2wvkzcQ80NHf6IldjjrymB+Achy5xd3y9mG3JPcQkTi4CloqHPwMvE2mEDZ7PBxQwNYFaMu3Nw6i8uYUIjgYQ4CtsdHBPibm7y7UteCOeqbHnUUJV5p7WxnrUUXRGdxz9BSOFHlhxKpsHygc9Y3YPuudfeQt+wX9gSDCwlXNtEUExaBVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKApDRV0CwAGwCQhi8dzR3dNnpAqxilqtJChT0fy6BI=;
 b=k7EzFy9eR/uqn7RyKJOLpY71kSklEp/TDKYstjBAZ4wKGCtyMSkwRAs66LrN5m8+nwhyz9SstiN11IAzUx9730a4zQ2pawEtHzPO2pRoITWxRWGJviI960rvzE7/QMcvCuVYxB6XEQLJnUbHCbEbvjzazBLDwnUnLH53WI7sG40rQL/rvKeV/BbK8e9auJ1qAnNbFOf+9mjSdGYx2yC6S0O6S2UC4oIGYjzyrqcJ9T1L4YYc7wfdAS2vgMhSgPqJSrg9EADUm26Jo+kf3Qi0o5LLE6TiackhfX0x9CPE4uXl+fC5MsSuXR3GB2A+lWLOpNMT/V1rVn8MnHNHbcM5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKApDRV0CwAGwCQhi8dzR3dNnpAqxilqtJChT0fy6BI=;
 b=tMcxlBQ6PnW7pSpzeBqTdt787BrvCvO794CCrXUqcrzCcSzBCzdRHHEGOkIKmN81ZDK+CZXmDVuTrG9RuIej1BWlz5Km23LjUhsiKhlWxhEeZDIR2nQBUbEcGZBY0BryQnLUs28OirMdQE52/A3z6VcsrvbmxH+sblYavKG3KOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:08 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:08 +0000
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
Subject: [PATCH v3 3/7] PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
Date: Mon,  1 Dec 2025 00:10:56 +0900
Message-ID: <20251130151100.2591822-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251130151100.2591822-1-den@valinux.co.jp>
References: <20251130151100.2591822-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8398b069-768c-41b4-7782-08de3022b0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZUv4VVLvRJCX+cGDFR2jfMg9QbRpKidK/M7uMobC3q845ntv30AZe9IMoMs1?=
 =?us-ascii?Q?snqMyuafDdm0diJZph7SrJPW4R5AuXB04JVwVTANFILmgEQzsgksncXxlXue?=
 =?us-ascii?Q?SkNJ2nvzZA37Mc0EfDNbfG2Mhy0bSNFcGtNrrlwKVIbyqV6UayzVObVsmZyN?=
 =?us-ascii?Q?RtCIsbPobvN3HriUgib6jnNnvsoq8jMiRyW6ct+oc0Y3xhk4WSaWQGn1208e?=
 =?us-ascii?Q?p0yrZ5bjYg6RWj9GsRBLk4vGe3496HdOx7hUpcRWoF05/mra0+ssMuJhxRQn?=
 =?us-ascii?Q?xgGsJu3C1kXH/apaBBxPv0VrFPkG2uL15lki18ETP7a772Np8QjUz3NQ6Fu9?=
 =?us-ascii?Q?4hSY+hhmm0cRzzAWuUyItM7fwUe7Cm8JowWHdE+QxHZEJyZX2msQi0VWi+Ha?=
 =?us-ascii?Q?w9A95jXRXHRz6PPUTt0TejIPRULNGA07hywskUIlw3RjPE49ffSy2bpGJBQF?=
 =?us-ascii?Q?BN49vqE+Bc0Slhmo/1CoQ+pScXIYBRGa5pkHi9onJ+GLTXsrKZ7UuODQpx/+?=
 =?us-ascii?Q?JaodIHflYAIwsP8sBy18WXTv6jJQpmjivMOIv/gg+Cr7h+Mw/dGov1v6w9NJ?=
 =?us-ascii?Q?RDqil5i5rDh6uxUwKPcq+xKrCVuN5IG8WrgcrbNVtsFLV6j9N+mjaJhf6F+4?=
 =?us-ascii?Q?Nz4pH+48e2nROh7z09Cj38B7QUc3/IDCUHOsGXPgf74vs+g2BrExZFbbH+rI?=
 =?us-ascii?Q?c1X4Fd9nIBtiPL4WTwKdblDofiSl3KlOkugOknT4/QUJ6Cw/yoyKV6/GY8gD?=
 =?us-ascii?Q?OFZ3f3wTtITjqf6r/HgCJvdAcOopF41Xt9AaMB0duOZJyY2ckrF3DEu+RJuI?=
 =?us-ascii?Q?gvlRkBsxxNkD22+Bw3sKZ8UBBVmlNftUabieEEq+COB/ckxi4Ms/dUUBZk1w?=
 =?us-ascii?Q?ParEfd+MnwZeDLes12REyZu7Kd10S4UAQ6Eew90Aje9IljStqC0nnKzvVoCn?=
 =?us-ascii?Q?3se+ZoSf5hGrzUeLiKO8k0i/prh1XicLl5/xEpKr/M4JBfhpuC+q/wSACI+0?=
 =?us-ascii?Q?gbdQ1Hyay7+MD97FRawlBZYTFMiNUiAyCC9KtNkfq9LFIem44XKWMagHj2MH?=
 =?us-ascii?Q?OHgc9nat0IrT7Ild5bnPG8BtJKTh6TuEl91tH3Qh8tYF5cM+cf6i630SMrWn?=
 =?us-ascii?Q?9M6SrMtncvlvgap9cYO8qj/HPTPB4d3eYq3UhkPlmu1cOWAJLB43zULZObTj?=
 =?us-ascii?Q?6yH5Vr6zKgp4bC2R60/Ttqd3Dzc3Vd39ZU9qELP6s+Ebs8SsI2GACK4GMBQf?=
 =?us-ascii?Q?akR3CH5J7HZcFgcibCnmzaBeBwb3VW58i9ptxq2lH+eWJ+6ebu+jWnodPunS?=
 =?us-ascii?Q?n/d3OR3zPu2As9hDXwcHM1eO09Ofxvg7rqpRPxkyzmv7nE8arNuS2w0rPiVv?=
 =?us-ascii?Q?F2EoV+loxe3AnnL8AhLDahmyLZW+ZJkVKJ7weIrWpaxIyvYqNYdoPGofqOoF?=
 =?us-ascii?Q?+KTwVokx859bA2YUJJe47SNlZVXSDh4p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMf3VO/t01LJuSa1rwRnqmD2iVFgRPgC8RC5EJ/C9Fv1oNJ2VeXOCoWfPeIM?=
 =?us-ascii?Q?ummMWNKRd5CCs1+NpZ5H7bA8jyAm6RiQxWEvd3/F2CTgxrIXmEuHNU6SpcUK?=
 =?us-ascii?Q?JAeDiLH9J3/+5quK4M/H8QmyyfM8FSOW/zRjczdL1CzbypWKIrsfS08qrdUf?=
 =?us-ascii?Q?p4aTrlllAy2dc/B0tCW8hleOHLXibLDbV3bGe+W0Kkk6oo9UY9O213pN4fdD?=
 =?us-ascii?Q?KMAeV4BYExTsKB2eWQ6yDvo+nZhqOgH9hUmD4SGmadPvARyj/Df8pjKfEPQ2?=
 =?us-ascii?Q?GclvmB1/S3B1FMPHUlllHG2EfT6DjzdUXOtQw/PORtFPgUcreyfqi9CRWcmN?=
 =?us-ascii?Q?3yUOOnC/uvW0SR/3zfWZuK2EB5ErWnIEHTrTbPOXpmgCJ/+WnRSBmpp0uVLj?=
 =?us-ascii?Q?WYjcMB4vxtttzCeyFVNpOmxJihdeEo32AfNwt3k9jt7CzUrpF6Dw6e5Y2jPD?=
 =?us-ascii?Q?cO8ugRE2SpzzxKp68CBJKtAZGj2ZdW4LDVDq9IBYH1lS6S9M1w3EE30ekg8P?=
 =?us-ascii?Q?OqoXCc7x3psbiCP7NtF/5z6jaIrVxVxgv/Agi7Tq9FS8ZjkcSP1nEHumCSUQ?=
 =?us-ascii?Q?N2GNEyDYiMwLSSy+UdqBKFBqLEkLhyqOHgd5CXYqfYfcDGvcWMD/3HTlUoOp?=
 =?us-ascii?Q?Whp9X4Q9G6/Q47kn9G1ksZLyA4UmAHbuAgCANUa+wKVbH53W0/i2MEfIOK8V?=
 =?us-ascii?Q?iUKPiiM224lZ2OFCwtXJCF4Bz6Skhj1RvOvxvdVBdMfIJFyhn2BUzSzRiLLd?=
 =?us-ascii?Q?gE/Nroc0uTRwgwp8ShcFIruqfYw6DcooNbI7Jjo+1EB3sdTRbDBZg1HmVeBH?=
 =?us-ascii?Q?gIOcrVvNjhQZb6XGAJNN8SqsbHgomfZKsTdYw2HLEKja5/Gf8MrWlYQUmE3/?=
 =?us-ascii?Q?pG3lgAYCwTQnLKqmO+C8I1nVZn3BbBnXArqhiUio1DUc6lxvbAy8bi9QxF3p?=
 =?us-ascii?Q?P5Z//2GXnfFraiNV6MOkcoTJTVGNu1dQDpgwH4IJXLjLVjhptQtrSZfYgccj?=
 =?us-ascii?Q?E1xiUklDfpV8ZYUHyjUJdoEY49zpsWON3EEyeYV5UmnhlBtSIJbkvhDXj3rP?=
 =?us-ascii?Q?j8hbXVuqEkcoT7D0C9C9A1tN6kSz6yA8LVb9mJ2P5jsR7JecCpM8lcVH766X?=
 =?us-ascii?Q?e8tStN3vYhDNM4PQ9VEszUjJyni9tXxG8wKGzZQ24DuVS1cUMdJiH4KIRV56?=
 =?us-ascii?Q?O8fEFLfVgyCFRZx8bRw3HOXQuc3I4InOA8dtPvIkpc7RhMoGv+EL+Mg0o2fb?=
 =?us-ascii?Q?pma+/HYmDCdNbZCjeDWeWJ565L073VqY94l3CK/gG15Zt0wC9noCrJAfzUo0?=
 =?us-ascii?Q?ug7u0AlsxeIWo1sgEDSLnI39WlZwoeTWIInVF41Jqbg2iinFE83glpwsIJIs?=
 =?us-ascii?Q?B9QJjew0eZ9anNlnbJoPMhFNZsRL5iI4wW16UExwywV04vibBteAp+Ink0I4?=
 =?us-ascii?Q?Jmr9ceEKZltwk0kJNaNinNPLquMpiA5lpWLkLNKMAyL88ukTSwaGIk+q46rX?=
 =?us-ascii?Q?H/5x6PIt9NKaJHzcXxCFMMe6MG+MoePYrgdaEFL3iKbqtYZFJY+QW7PlKluB?=
 =?us-ascii?Q?TxYCIgiCDzOJD+d/sHTfGe4NMJzq2wWy+kGTQaYK3FoDAULRnIZxF7dbzPgL?=
 =?us-ascii?Q?5cW1CkPbLyU0jANyZ5mFAzI=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8398b069-768c-41b4-7782-08de3022b0be
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:08.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw1YdTgjv6qfPvUL40aEb7+1CpkslSbYSm//BKsQd7s+oZKG6Oi9eURgorSoK27eLfMJ+69jMyf/cG6TZqImoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to perform later. This leads to an oops when .allow_link fails
or when .drop_link is performed. The following is an example oops of the
former case:

  Unable to handle kernel paging request at virtual address dead000000000108
  [...]
  [dead000000000108] address between user and kernel address ranges
  Internal error: Oops: 0000000096000044 [#1]  SMP
  [...]
  Call trace:
   pci_epc_remove_epf+0x78/0xe0 (P)
   pci_primary_epc_epf_link+0x88/0xa8
   configfs_symlink+0x1f4/0x5a0
   vfs_symlink+0x134/0x1d8
   do_symlinkat+0x88/0x138
   __arm64_sys_symlinkat+0x74/0xe0
  [...]

Remove the helper, and drop pci_epc_put(). EPC device refcounting is
tied to the configfs EPC group lifetime, and pci_epc_put() in the
.drop_link path is sufficient.

Cc: <stable@vger.kernel.org>
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..49ce5d4b0ee5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -644,19 +644,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
-	pci_epc_put(ntb->epf->epc);
-}
-
-
 /**
  * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -1406,7 +1393,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
@@ -1446,9 +1433,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1464,7 +1448,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
-- 
2.48.1


