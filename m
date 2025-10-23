Return-Path: <linux-pci+bounces-39091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71070BFF85E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF983AB4AE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4312E6CD4;
	Thu, 23 Oct 2025 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="H7jCf7qT"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011031.outbound.protection.outlook.com [40.107.74.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05772E6CA3;
	Thu, 23 Oct 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203906; cv=fail; b=b5WLbo/4d99/kwIKwx2/apzgyU4US9xTQJe8tkkA7ZtcVAHRJMubFjopmevbCeFEZWdN/C1cXrY/geZJK/sVQV0fnbHyAksJXmtb3zndKFIPceAfxbhGO8o+GOJcoqkc/6orAeI1qkn2ADWDKj04NH+qJLq6n7H7g9/3mNgynpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203906; c=relaxed/simple;
	bh=kl8QcfBak6blfclTRvIifEhO3U4Ck/VjC01KuEUw4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COs+OFsHBqdU2/WezNmbPhKLkxcy+qO0yfK3tYYtN5pZ/H8wszWuuq4hTx4tuA6hifq6x9ZjIotb7IwdC3QjhaNxeOvDZ/PzRJ9aKwNw7dzbICbT137vnjAOXVfKedCczLQVQpnz3sX/5pt9t7K/uT9MD+WTn5PJfnjkUTR1WuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=H7jCf7qT; arc=fail smtp.client-ip=40.107.74.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKRcYkYGQuqAhlgFbdAfN3q34Farr2g+zbU5m0Zh1ExWxvdaKC5RMR1AaLgbT8kt12kkK7VyGSDSSc4imT7OiFFzOE+v1oWKl/tMaR98dMB6pyTMujaMldsawkor6rFrCM6+iZSHtZi+48Sq8Ksroc+PLjXGlpDQheIakAw2kinxCkMamdJRBQ3iQYFy5r8SgN2FCSbMWrAeFeq0s+XrqVrIsI1lRUIBLB20dWFZ06o0IaQRkA1jPsAadigfJonI4MifGb8P6FyDQYhBVj1MSenxuScowkno3P1zbz6GMmpFKBsB404OZaN8I3biXUtbcWCA7H9I57Fj3/8QyLNc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXdtTUHoL2AtmZU6sFbDRbf+xkZ4ntu1d8KJ3J1LrpI=;
 b=nMLLoL5CGkDY/TPLdq+aTdnfzSJIqwj2wewt6sCJqzkv3X4WgIemGwdV8S4uW2UFvmXPqefkPW+/MPxTtZMy4/tYN7A9t00YhqFN2C+HrJigFGnOxz5r/tAPYZfPNzIquX+fUfj+9/K3ZJZvKOdUNLjqsidFB30Mkv5tezO8V9Oqejh2619lzXStmkRzpG2Jfy9FhR8dm/9n4sMOVbU8jyEsesN/ACkFYhqqb3W/23xJtkZPhufPkb4j3orb8npCsnubZoZtOs8HAbXVfKfImjP42tO7krhn623w3vT0iDa7WylhTj2D+vcLRTWqA/oo4IROVPXy2vk7Knk3LVK7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXdtTUHoL2AtmZU6sFbDRbf+xkZ4ntu1d8KJ3J1LrpI=;
 b=H7jCf7qT+SpHe1dYEZsnzKlO8YJZw3fX4un8e5oFOespHaNygrj8aeG8LBRAZmydd0mFUY9f/JYgxZY35pRxg6mNB5Ay4HfnfyuShl3yOwgsGDKJ35g04F1QCvw41gYgrcw4v6tegNn5nuKD9+WntyB7TiYFjO2JF5cVjHRpdxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:18:18 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:18:18 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de
Subject: [PATCH 6/6] PCI: endpoint: pci-epf-vntb: Manage ntb_dev lifetime and fix vpci bus teardown
Date: Thu, 23 Oct 2025 16:17:57 +0900
Message-ID: <20251023071757.901181-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071757.901181-1-den@valinux.co.jp>
References: <20251023071757.901181-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::14) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: b58fbfb7-65e4-4f6e-ae9e-08de120456d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e8Z0ZSx9yhlhTaX41vz+lpwaP2m9x6gSwQ8p+8P5rdN680z1zoAYwr5E7Yos?=
 =?us-ascii?Q?A5P2yeNMNdt1l5rfKiuOHqtw5PTNpPElk/Rij6pZwmxl6h374tYa+RIntkSY?=
 =?us-ascii?Q?aGlVS+gWkph8d8DLSMz08H7+q4qHJS/SVifJzDYjSZFmFGp8OTJ/1mSn9uZm?=
 =?us-ascii?Q?V4pdnQO7Z6cO8MBLCJcOQqTmC4CEwmSm9KACBkIz8ofqb00GAESt8gOUScyl?=
 =?us-ascii?Q?6ijsrjCCfTq2usIDJ4rWWeqS6MM+86wx8tlIP8cKdoXmUe9wLQdM/4SNRRxk?=
 =?us-ascii?Q?JtpuHEA2fAroOQiE7lquOOAMLM9/K/eIopieVUDahmNEhMH3+4bF8drNgKsA?=
 =?us-ascii?Q?P1epBshZsD2/YCcHXLdvk/NUYm6BZl9h5H//bqdPpKd167CRc3Y5LlHBN9gF?=
 =?us-ascii?Q?W9noc4owbcVbob1+3LY2mHW/CQF2G8/Qq2UjKlTq8qZUF4vv8JmezXnE/jmJ?=
 =?us-ascii?Q?S6mFsuFdl1aSK1ryNBIK/uxIybtL0AhpgyrCbdSSQpG6TpOntRcqGm/rRrU+?=
 =?us-ascii?Q?U8AsJRR6K5R4KWj9AuqmZpe73fEwrDsI/QRzxrtVfkKMpHu3mWXHkdFS73oa?=
 =?us-ascii?Q?FAV9krohjke6H+ZShof+uSPx+d7mcaSfz+AeEz6EABXDiOdQ/dlyRas8xqOV?=
 =?us-ascii?Q?CoLRuKMZLvnEMbi/vPebJOG09rOi6CuXhqR1I/8hU3KYFI0bHt6l/9yLxSn0?=
 =?us-ascii?Q?lLLm0gtcLUhXtDKTvCShmHm0m35f4P0thBn1kY6uIhF1OFqnHXM1A5Y9nvHq?=
 =?us-ascii?Q?DF5WZhR78LoqzJ80OPDU4m0RJSeM6jMTkcSYNEE8Q+Lu4a343whWAnDW/OV9?=
 =?us-ascii?Q?wT2cQmMFdF2uNPfr1MwM623ml7eHir4NMsKUEfYArbLX7QUHBjwyqWP4OszJ?=
 =?us-ascii?Q?I205Ede7qpVjiyqOnIxDQ8QtMhYkG0U6Ajh//xDJ6V7w5a2Ze2SITB/xg+m/?=
 =?us-ascii?Q?YZzeh8eY79ZoTYMMHOdTVapRpk96io5DA1KhTnd9Z7B3fbw/bMTNeIjf2JxW?=
 =?us-ascii?Q?EHs51UHDBIuTe1h47sQ6FSenu7myfFQiZ4b7pqTN0JtawAGKqJLeIRrmq0vQ?=
 =?us-ascii?Q?6A7zidJajEUOzITyNc5KIoB1H6KuXxbgZaazbGKe66OOCWflyh7PtLYO+buu?=
 =?us-ascii?Q?G1lQ4bjRmIOBSIdcP/2A5ukDXG/TprwGJ3jm/HNwSPpHx3EO6W57JCqmhkFq?=
 =?us-ascii?Q?qHcGXr1C4V9tCOid+Og+0Zce7MbGRppdNG0ouCReoscmTpAYCMBCSDWgjsIq?=
 =?us-ascii?Q?rKEOOmnmnzqOwTV0QyiyAtyuaLbqLlz6op/QUTgFAt+3ZP2QEZD5wbMQvF5t?=
 =?us-ascii?Q?B2xQCAROgHVjHhIAcgmwZ1dqfRiUPKyIBG/i6b6vxdlPJ+hQq5QaZqSQMDmE?=
 =?us-ascii?Q?FSl7oamCs2iKRT1LeP6m/XNbRQQlemo6CEfqa2BLtAUAo3FvZW6nY3QyJSbO?=
 =?us-ascii?Q?5G4wNOnvCtg+TauZWUVjqBkKDsGkhKeS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PX8lwnlfsldMS50OGM3uevDol+SqgccrMviOKnO9VZABX05AUlzStS/1/APi?=
 =?us-ascii?Q?aNb9c0gRBk98/OtVUO+dAtPHm0lZXfxPDb+jUQKgmmPGDpBsKZ5s2gwu3Pjx?=
 =?us-ascii?Q?99QjqmyfMWzjm0jsi4/SCDGE1R4KpXYsFEF3V488m+/ia02V6aROhNgAa6WX?=
 =?us-ascii?Q?Kvw+OChAeuiqkE2d5PzWaPfxZ/jVV61ZrKa+O+Ape253DwcY/K43XnCPirIW?=
 =?us-ascii?Q?SzqWLBBmuN5dE3IIdwKnU+v/py7as21l+xABPBf/dEztDtQkL4ZgrBdGqxWV?=
 =?us-ascii?Q?THWp36ygQ5A7n2nV5PFb2AGc2wigOdLHIFQBRpaK/wpFVOSm/bhkA3NCq7dZ?=
 =?us-ascii?Q?C+sjC3/18F8X/CGyRzd5tTCaw4vcrOatoS+QfQsmf8BjW9sx7TiX7mlguvvl?=
 =?us-ascii?Q?Wa9zKVNcG8+DRP1qJU6Ge59sMCTQ4GbVrGsKbWL1uXK7W5Y+WbSU9koWpS91?=
 =?us-ascii?Q?p6hK4VSko1Blv6OCzeYdqnJWMep5cwnTYr+rC04Y1EtAtJzDnYUOJ9I47bUu?=
 =?us-ascii?Q?urBteHfO4RDH8SjSw3dvTx7q/GaEvJtf3pwyxPbRM6Q6YjQOzwVuh4h2AG7L?=
 =?us-ascii?Q?kIpSRMIvUSnKqMpZnxpiFK9gn4CVY7cndy2pSbkTLE6KuYxH/sLjYbchtaJ7?=
 =?us-ascii?Q?FV8cxjFsJwh0uIP0h1+HJ7oYQIrYVXy2zKF4PUFJXBNOi0gJ4E5QplgZ7+rs?=
 =?us-ascii?Q?LZt+Qty+1oOsnmAe+HkyxGghPJ93KYt1iNrSqvDvJLgfL88OMz31xxKn7LBC?=
 =?us-ascii?Q?6Zq51udcwqXDbrIj7YKSX/gfoGqKh2dNuTor70BIDZTv2K/1R0e+NqeUsFIq?=
 =?us-ascii?Q?o4LrsPJceq6VNWpuQpzOu5ENusutYNQoHrTXBZFCcFnR5E1uKIxQ+8JdIBs/?=
 =?us-ascii?Q?Ak4d7ccTwlPXbLdoSpW1MWoBOu0rGMMITs/IPB61Wi3adW62i7NSQhrXUBcs?=
 =?us-ascii?Q?nspKlk3MFi2QklCDdHh3KeOhe5Kb+RPquPew1IRLG5XqLIQaFSB3wf3avuDv?=
 =?us-ascii?Q?v6NLEwKb9QH/0cIjb8JRrz5pi4pE9zzUiiHkqxI5hWZIoPODxpzGwlWHE6V4?=
 =?us-ascii?Q?bVLzjo4mwUxXGJFiVDbP4QXSLyzvEtkJ6oWpharBqLbScIovkLd1okq0DJve?=
 =?us-ascii?Q?dnkydb2PuWEJpL8jr1o5dAnIbjkdlV4W0MCd8p1MJg/F/I+Chf9Ii2/fI8et?=
 =?us-ascii?Q?ydhHsHP8fi88zFJK+5ZykGSzgQWnspphrfZeP/Qq35m7bHk2CwVPlxgFUGWQ?=
 =?us-ascii?Q?BSCr/xi+ul6kQaFQl03lOtKfyYhDP0+776fe16j6E4M4RAVZlrgpRQCtcyqP?=
 =?us-ascii?Q?l7+Cs+J64R+59xWak+MCvvi6+kgMdL5TKp32Ve11fXlU5onsLjX7ELtXPdCc?=
 =?us-ascii?Q?OPenvs97no0GixNSlkz29EK1ddU+pcw4ogKj4zIbwdDE6DuBE3+DdRIdT1VX?=
 =?us-ascii?Q?PfMxdHRXvlJvE8DWe/rhivcPP4HZu2Wd8aA20W1gmK6+fWR/xEEoJvguaED1?=
 =?us-ascii?Q?91R2CrMVHtw6rjsTc/4AaB7Nq+lK4iITdKvF6vfx87lXo2duP2i+OQ91/4Jw?=
 =?us-ascii?Q?A+aIqnFEXHtdUswDHTMNOfwsH6d33xea8jEsBSDn5Q+7FqY8Z/y48yc3vXZL?=
 =?us-ascii?Q?aMxqfCrBE/NLIL/VeeI4viY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b58fbfb7-65e4-4f6e-ae9e-08de120456d1
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:18:17.9983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9Y93STX87F/1vE3Y+iDJcyRqJe3RGQM1aQY0cWVrWsZHsu1kRhgZlABgqoWHY4N2n5tP8LdjTo3e1bZcoyHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
or stopping controller and linking or unlinking functions as you want.
In fact, re-linking and re-starting is not possible with the embedded
design and leads to oopses.

Allocate ntb_dev with devm and add a .remove callback to the pci driver
that calls ntb_unregister_device(). This allows a fresh device to be
created on the next .bind call.

With these changes, the controller can now be stopped, a function
unlinked, configfs settings updated, and the controller re-linked and
restarted without rebooting the endpoint, as long as the underlying
pci_epc_ops .stop() operation is non-destructive, and .start() can
restore normal operations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 66 +++++++++++++++----
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 750a246f79c9..3059ed85a955 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -118,7 +118,7 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb {
-	struct ntb_dev ntb;
+	struct ntb_dev *ntb;
 	struct pci_epf *epf;
 	struct config_group group;
 
@@ -144,10 +144,16 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	struct pci_bus *vpci_bus;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
-#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
+
+static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
+{
+	return (struct epf_ntb *)ntb->pdev->sysdata;
+}
 
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
@@ -173,7 +179,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	else
 		ntb->reg->link_status &= ~LINK_STATUS_UP;
 
-	ntb_link_event(&ntb->ntb);
+	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -261,7 +267,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	for (i = 1; i < ntb->db_count; i++) {
 		if (ntb->epf_db[i]) {
 			ntb->db |= 1 << (i - 1);
-			ntb_db_event(&ntb->ntb, i);
+			ntb_db_event(ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -1097,12 +1103,24 @@ static int vpci_scan_bus(void *sysdata)
 {
 	struct pci_bus *vpci_bus;
 	struct epf_ntb *ndev = sysdata;
-
-	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
+	LIST_HEAD(resources);
+	static struct resource busn_res = {
+		.start = 0,
+		.end = 255,
+		.flags = IORESOURCE_BUS,
+	};
+
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_res);
+
+	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
+				     &vpci_ops, sysdata, &resources);
 	if (!vpci_bus) {
 		pr_err("create pci bus failed\n");
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1147,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ntb->ntb->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1247,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
 
 	return ret;
 }
@@ -1334,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
 	struct device *dev = &pdev->dev;
 
-	ndev->ntb.pdev = pdev;
-	ndev->ntb.topo = NTB_TOPO_NONE;
-	ndev->ntb.ops =  &vntb_epf_ops;
+	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
+	if (!ndev->ntb)
+		return -ENOMEM;
+	ndev->ntb->pdev = pdev;
+	ndev->ntb->topo = NTB_TOPO_NONE;
+	ndev->ntb->ops = &vntb_epf_ops;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -1344,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = ntb_register_device(&ndev->ntb);
+	ret = ntb_register_device(ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
 		return ret;
@@ -1354,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
+static void pci_vntb_remove(struct pci_dev *pdev)
+{
+	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
+
+	if (!ndev || !ndev->ntb)
+		return;
+
+	ntb_unregister_device(ndev->ntb);
+	ndev->ntb = NULL;
+}
+
 static struct pci_device_id pci_vntb_table[] = {
 	{
 		PCI_DEVICE(0xffff, 0xffff),
@@ -1365,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1447,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 {
 	struct epf_ntb *ntb = epf_get_drvdata(epf);
 
+	pci_unregister_driver(&vntb_pci_driver);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(ntb->vpci_bus);
+	pci_remove_root_bus(ntb->vpci_bus);
+	pci_unlock_rescan_remove();
+
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-
-	pci_unregister_driver(&vntb_pci_driver);
 }
 
 // EPF driver probe
-- 
2.48.1


