Return-Path: <linux-pci+bounces-34300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ACBB2C4DC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFEBC4E1362
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCE8305050;
	Tue, 19 Aug 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZzFYHbVD"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012011.outbound.protection.outlook.com [40.107.75.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7792C11FB;
	Tue, 19 Aug 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609173; cv=fail; b=G/ucwJbDfZSEVsGiEgNy8HkdxUDvama6sxTEOMW3hLnPhFArHHaCzPwxPlxW54Zt5VFs/xb4TjoPunpRRnMn/5AfpHOf+MBsL7B2FhRfxTOkIZlwGa2vxPI13beik355MEMbFTUykgnBwvFCySyGJB+uUfLZK79f+VY1fjWswZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609173; c=relaxed/simple;
	bh=3q7PLXHGtGnjQ6xXk05YjbwYcYR3GJgd1ytK7yD5NlE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=phYnoPbW6NsJ0n8uXvzXnbD7/ScB8UdVCZZVQN8OB8MRKfNzpQzsI9bfQwvxu52ezu6y2onQkABvwa9MsZmCyjwHJ8E8PMHVme3Pd7nJGtSQBaQouQ33WsAii4JfVWj5FT19iqMlXt17fpZwwKOjjPSn2WVPQHLvhv9V6D0NUmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZzFYHbVD; arc=fail smtp.client-ip=40.107.75.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGshL5IDL3wRSHcAnIYGgD6chm6eKan0/O4x4GrlRORaQ5gNORof3jzjyzsVlUxzS6n+dz02/LO6zJQShd9xloMhTcgB7j59VmfX2qzHlL++Ixg0rfO8/+vxWkiExUICpwYRtrkrzBtq3VEPuU4OYlNfxs/Qghg1pfAJ7ZsWxoNzYpWjVWr2VPYFQIh+D8qG7fkGQO80ok8VwMkvg9+9etIIMsTkkGuu7Ku20W91s1+OsEoUrBxw9NZP1U7+0GRSFIkA59J/ko0JZnG9nW/7BtBPCXr3LrGyHw7O51+bBhE2MSdNiWXPVwuRm2FR9ck3G7A/TPZ5Lp2xE0rXCUt6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HceUDQw1rtP8XBaT2T8upa+OvDGxcasuRHmHTed6fcw=;
 b=KuZtYqjS80mD8Ph2dCbqTjM9UcnPwz2ESsZmckk4ASmu8273FtoVCSsey5/gH+0lbBqDZ9zkbq0E8B5UtD7Ri9lFAzQTdn4Lhkx/LPVqwXCuxAuawN1p44ZVhRiEXCDgXvyQ9wlzd2ZsvE2HLjZDdtEUQlEtAXWamIEN14m2kTXF9k2YZDCpKFBJbscJ6O2yGBh/xsVtkgGk+HqNaQh6Ksb+jtx3L46l/xrlLx8r33smpoBFTsu7JBFnzIqPbGtMIpemovu5zE/5YZhkAMx/iJcbBRCAzKLHEb7GckBWiWF5l3TanvLL6CQ0LPKPFvPQXwUL2RLiKXta+tJ4ZcLjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HceUDQw1rtP8XBaT2T8upa+OvDGxcasuRHmHTed6fcw=;
 b=ZzFYHbVDDiw5c/lRVtVHBvUzb6jqSFMAYqkcAECSIPy8vBYajZRzj/QeZVH2SMEygR7dDYCGOArljSPa3k8USrS56ctaejq8yDRa5CSk2Jj7ruYfMjSIcWn4nTnnGMQrEX9JorH0Gvo7mUTNYbOM9DPQoYdSebrU7fx85ZuzUgS04N2A3kEP+qiXzRkd1xHfIwOkG+awtO1qm4XTLwTAGYUibpGcr0lfGlY/6O2pnfSdDGptykyyBNdOaROUlTpf6ikMHLppLAsnUgmwN/TepKUujZYZ4gpzoS66ILqffJpfiXdkh48DIJWNvYsTjU4EP8T8bvYJciwAgeygLK4uJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6095.apcprd06.prod.outlook.com (2603:1096:400:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Tue, 19 Aug
 2025 13:12:47 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:12:47 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] PCI: keystone: Use kcalloc() instead of kzalloc()
Date: Tue, 19 Aug 2025 21:12:33 +0800
Message-Id: <20250819131235.152967-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 7174802f-039a-4eca-9f26-08dddf22178c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vk/JGZB4TbgVI/LlWz91jg9YNZ13GeEwk3x61cliG4vcazq/14QeZEqUr3iW?=
 =?us-ascii?Q?DzMOfgzfQMTTkOey/N2idtA7l2rjiWKAlm0xr20lAfXsGZQWfr7DqGQS+axQ?=
 =?us-ascii?Q?SxqqyXYlQJPJs3CqpFB3kbnVZVA3JeZk/3Irh/uW8C13Kz88rMEY9nZ/KW95?=
 =?us-ascii?Q?JokTvO1ZfVHYgqIDPcSnS3JEnjzopn1M4f/GQvGWnCQUMlUhFJB0/cIDTDyy?=
 =?us-ascii?Q?lCFRSJTjzlmt6oJfE2s1DigoFcsPTT9qkXVgDBQzgQOgbrk7XjFuIdlIw0pw?=
 =?us-ascii?Q?gjp9jmUq7vLoxxnJYIxyIQfi4+TTiXs7iMrodwLpRAQQc/rxAZjMdih4ZQca?=
 =?us-ascii?Q?sDjLgNFLDbIS8APJaiMQRZkCnst/uG2i5JvyKAxDWA/ZLoio5u1k7X0DbhlK?=
 =?us-ascii?Q?z1Y7Odt5bOY8kdICK9/2OzymlLNtjKiO1pHguWn0dAf73yZ96fikvY88dm6N?=
 =?us-ascii?Q?iRhzKpk7fyQlXv94eiZSr0frij9nDLDhOalvosyqUd9w//ma3G/dmYmDO3jn?=
 =?us-ascii?Q?rmUYuAJdj/xK7nqi7Th1i7kunFoLvPxQlcpR/GVNixOOKViap6jz5a6+fE8e?=
 =?us-ascii?Q?qqLh0akfcTZyG5pcnKAq8dvqZf/z4lQcIKNEZwdsUT3/PHsNf62ab7rF+w3v?=
 =?us-ascii?Q?c2mTJvsgrfrUA1ieZaOLB0sTpPSUqp+7ENwcNmkiW3OSBXudhjG2ksvKqfa2?=
 =?us-ascii?Q?tH7U+agD4DpJg/xPSBFSZu+uL/3ghbkxldST6alrYxJ70pLu8MCJjaa6kOrC?=
 =?us-ascii?Q?peFNHSnOCigQkghPn0wWA11zgjyZq1S++2W7B0++yOJz/7rNbyZL0djBajCy?=
 =?us-ascii?Q?FH+TDbAVgHIescHFogI/ZmVjGJy4af9ySAdsJa2DDiPH52l1A2qUHpTyQz5U?=
 =?us-ascii?Q?V+1qe1ASUur9AOXmdmFkz7l+RaPKkDSTZK2TESI/Gvd3vSxCKbbD9kQTiM6d?=
 =?us-ascii?Q?EnN5VDh/aXD2jE1lhnIkF3YUIA5oEqSVT0jX3IGM25/bO7YDlIxcKkFmQSUd?=
 =?us-ascii?Q?t3JixzRmtkW8dHCANbxVxzpQDfi4H60VUFHquvEPiZTww/AXYP/VMVHzp86t?=
 =?us-ascii?Q?Qv2WRHZoABQz5QlkA5Z+6WhBXrzD1aZcTfF+se/EUWBRpghGZ+cFlYWvE+fI?=
 =?us-ascii?Q?nVXISapwM1O6gJ/x59ATmQql4/uuQh3gsTC5T/Xg+bK5pmNiorUD7pyIaqmM?=
 =?us-ascii?Q?B0rifxYCCQIICGV98nSZFCU+Ncgh+QogQsw3F+Uxl9QvpP76O79yH/lFfRpL?=
 =?us-ascii?Q?F9rOLOm7dGy2QxxPwVIe+otJUmi4uGxN8rB5LC4S4emeoRVZxtgAJ0414CKF?=
 =?us-ascii?Q?LxLsCAbWM3hom2TYn5dBOIUrixvSWg3ufPh0ctMb5LSwy56jheYyc2+PB41v?=
 =?us-ascii?Q?6B3ZVMl7YQa0HfAjSuDi1k/rZSx8CGOBxAhWgUxVmNGYc3IrojlUS039VdNh?=
 =?us-ascii?Q?r4OB3fSCPK11shqgNUu0NFiqVI5ORonw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUuXv8oxP/6DTyPGDnSqgbB9Ad1VmXwDixiVgO0o0Y//VqNFw+v7X6kHu0ta?=
 =?us-ascii?Q?AwRsMy0U+8cWV4OI3XSMjnT+UYIaXn7ApmaUFZlmA8PYpQQvsJcmWMKK9fRh?=
 =?us-ascii?Q?imnxhrUk/J4YK+3wiPg/ys280JhoGcdLqE7lroqptoyUvYWf8+51rped+w+q?=
 =?us-ascii?Q?z3lLC19qNqI/z3x0iCV2CqMeI44FwRiDs5LstM0/9IIjquDLgDB3CdJLypDi?=
 =?us-ascii?Q?syBwlz0lsSkPV9sDsAYcZlwRnbZMvSpxg86KEM22R3h3krJYZtxvlDKfLPKI?=
 =?us-ascii?Q?PJ78gCr3NS3go/i2bieTW+s25nVcwl0YUbxnsMxqrOYKPdzq/dNfMfsAHRRB?=
 =?us-ascii?Q?DFE65jvh7PhoKp3+1vArnPqEl4Lj0C5VJ3USdyTRLLzg0XEgrJWr7LeLtl1a?=
 =?us-ascii?Q?Nr8vM5pP/Wz+MO94fLKR/8GZVx4GzOHQx5BDGkNWqjLUWPCGA5vkEdGHBGWQ?=
 =?us-ascii?Q?tAPD45oetVe9JlHaeroFQq57QrOC82GQR2cMGyNlOggi5w7pxVQVJXj6CfUs?=
 =?us-ascii?Q?PD0tOsvzjHoC5PAO5nRnRd0v0I0w0ojJg1uroA4tvr8e4mwXm6GRXtUdvnoR?=
 =?us-ascii?Q?Taj+aGgyZgF34tQnZcV1mE4POLEqUGKWeRvYvxzfXiw3BA39dXwmPoIC8dM1?=
 =?us-ascii?Q?e6dgrorXyvdhEcKVSgJH0gM1r35ifYVtxdbSNHcIVwAW7jIZV7yDiaDGM3F4?=
 =?us-ascii?Q?Gjab46FK+9OG5H3xsWonfSBDcgZJSglIB3+CVsrjvKkW3XWhuHVs7yWh5/+0?=
 =?us-ascii?Q?S2HwEk2Q8gPWj78x1WbPf8tJwldboMr7tNRWRUFlyTYRxQnjQtn1TX3QFeq1?=
 =?us-ascii?Q?s2KhdL0RalJCKFt/O1oh0goabsnbsatS6hZzVLkE65yDTrmkK3MZf2370POj?=
 =?us-ascii?Q?nNyH/Bhi4umhjOfkG7o/TcA7G/aVIFQ1maO1PJV5zdSVdruvLXIcjzr+jSYI?=
 =?us-ascii?Q?IVRCevSXCWI7/haemzjJNHkQo81x8CwDs0MGu61YDjVZAH5qT6JUV0WNUCDG?=
 =?us-ascii?Q?e4MAhEIlSgW8i+u2BbXWs//VFVrvCegr+a40B5x2Y10YGKTRC4J9fk2bb67+?=
 =?us-ascii?Q?ZEe8PtalFXOc8nKO1ceoXCGcsY4sG3XJ4ZafnG1Hsb163vDqF03cqSh7DhTW?=
 =?us-ascii?Q?3Kn6JU0ibYuejtS9P85FOg1WfbDWw97q5h5rqicx+u2gsYr9YnQkk+zEeKtR?=
 =?us-ascii?Q?ZMLX6uowvfsWZsqjWI85I7Hks5w2KEhNBwOVQQZE4DuvwPRxfZMWUCb8rfFh?=
 =?us-ascii?Q?XJCUNsQjKbQUVjg+jWDrV2JDYjS85dfWcGK4QKktKK+cwF8uS+4yT2NAsaDP?=
 =?us-ascii?Q?EA1FAqGZcvQrtRvk02L8oYPbBGuCveVsilgHKx0ez4sxK6iJ4cWnPhY74wMr?=
 =?us-ascii?Q?sLlrUD3in1sQ5gL4tKPOBdBL63rDWZrNxanEcTvCZ7cgQuoqlMioVIoAED8F?=
 =?us-ascii?Q?vsE33Xw4U6SOzgEKP/69EKj7x2CFwiEyw/LbZ05A7pCHHC4dIesmMWYvqeKc?=
 =?us-ascii?Q?X6aeYmaA6+QNVSEUDt4dojdajRtckz9g99NFWLM5h0c4TUaKvVkH40J+KkYH?=
 =?us-ascii?Q?ViYTKWHvA3CCaVcPb40jF4hSPF5UmWkH5gtkrnGC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7174802f-039a-4eca-9f26-08dddf22178c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:12:47.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7F8LN/LaOG+G8f5Hve5ne6YE8o1uDdvaTbhUAoeeE6aAXgoXnaYfk0SsVPyAt0AFu8jW8wpdqF2jgEmCXAdRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6095

Replace calls of devm_kzalloc() with devm_kcalloc() in ks_pcie_probe().
As noted in the kernel documentation [1], open-coded multiplication in
allocator arguments is discouraged because it can lead to integer
overflow.

Using devm_kcalloc() provides built-in overflow protection, making the
memory allocation safer when calculating the allocation size compared
to explicit multiplication.

[1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Modified the commit message.
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7d7aede54ed3..3d10e1112131 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1212,11 +1212,11 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		num_lanes = 1;
 
-	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
+	phy = devm_kcalloc(dev, num_lanes, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
+	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
 
-- 
2.34.1


