Return-Path: <linux-pci+bounces-39088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34439BFF7FB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD237354F8C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EC2E2DC4;
	Thu, 23 Oct 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TeMVFF8G"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B82D8376;
	Thu, 23 Oct 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203898; cv=fail; b=unF5WixPefq9HKcDcQaFWeEKO5eDOUr940eVXsXsn0CPZ35zyv3oM+NCmLdQZ8u5gMFfFConE/gKl2mgEa1WfxGU+7ULvNKF8K4OWEPOIvhoJ8CaB3js59u3GprM9d1mJKxuz9sBDVD/J9uSfRCUXoq5jZmYzHPQorj2Lwb7pHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203898; c=relaxed/simple;
	bh=QDlqhFSnoxb+kCd69u/yIzRI7KKPK7agpEzeIkdTnqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilLe5Fjz279+/peHvNiduPnEbantMmK1lJ9qfntCFPehPtAZIUkc+Cu9vUJhC2b/TRFKcWKYuilOFnOz6Cgm5AFTO0swHxIeQ5lJ4Y0zh1Bmh//cvM82aILlbTnno+NXKUuIy+KIgTtpnaVihLZi6DNimnlcM9d6ruQNMKoFZb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TeMVFF8G; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwu0FvuXzYC44qfbp9tylGb/VJ66IXaaSd5aP9BlRL53ju5tmmhRPZv08Ziagd7H6wHStjcoEAOpq9CRpJQ62MXksbg1UUlam7+N9NFirYo26kc7IFD1B3Uqz5/0aFTif9cYYyXz5VMa1NVMkKhJPvWFusdjEgedZSPxjN96piOaZ9yDFUqX+uSyBLxrgMYIuyB8cKFrtpPEolYW+nlN15xWfCLQAZLcwBgRHFNRNo9ACB73zfCOx+huYDe1XCX4GUV/bMI+8nEBu5jXO0G8JwipxdQwyuIJbwwVXU/jJBXsBA1kM4/E5Gm50J6yM8lw47sxSsbltOnJh/x9tadMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjkXh2lGFSmrloVxCLv4UpaOIx92aePRq2+GeFPajN8=;
 b=AWZk0rl+txpjmVRIaoA2MNnZJ2UTLOK+XbTynRxBG0Ja6u5d+fNImav7V/tFOU5RsMNLK5BL2K+Z16z4ZL8OxAy8o1/0ZEZ+8vtic4sykQT76kHxwsSta4FPCPC8B2woDPAV+Bg9zlG2uF41hBasoBJaDzcdKageWtKxHzXe0onrLqqy8tbI3HU/yzwPp0dzgxKYkGAngTVYDsma06lJsMAVXq2v2OGj0oDVkZphfHXZxq0aQG7DVV6Lx8UmS2qHzO/GpHeHgpqBAq1HbpaDbhmG3wGrf1O19VGapqQX8AW/k63Q9wUJrlGReUsgcwP8V3FfUNGuMGlaC9btwB3RnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjkXh2lGFSmrloVxCLv4UpaOIx92aePRq2+GeFPajN8=;
 b=TeMVFF8GEhKFx5sm+skaLruYc+bf8UYyXxFgsEfz1BIzwMkHi31i6zSB5WX4GrYSsZVYpWOo8q/OKuD6LekpTTgV1/2Vds5URed8DwOp3DUBU0qfFJTyi1aFcQjEjI9zl+YxQ7zEAgmtJk6ILFQP8LYNBJblj3gB3lD8fO1cpHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:18:12 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:18:12 +0000
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
Subject: [PATCH 2/6] PCI: endpoint: Fix parameter order for .drop_link
Date: Thu, 23 Oct 2025 16:17:53 +0900
Message-ID: <20251023071757.901181-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071757.901181-1-den@valinux.co.jp>
References: <20251023071757.901181-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::12) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3087bce3-8b3d-49b3-765a-08de12045395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OcSPDOqEUBITUkZpU6ellxtvrXwsTqE0nKPuyuh+iFmew2yulk9125SwHm97?=
 =?us-ascii?Q?UGJ2RweUt949QSPiss4euysjT6zS8Eku5u4JANpNllMHE1QDOESnnMs1e2fi?=
 =?us-ascii?Q?zoWIwjZXTj1RrvVepxJT7uIoIX9ajJY0Jy54PjZN+lboXSWyzAskn3aoxICO?=
 =?us-ascii?Q?upDOoHoieXxN17EHhB4pnkGkIScICRo8wSrLDfPEmZyTxDdoTV2cOc/n6E6r?=
 =?us-ascii?Q?/HGs4pOmB84pHN43oRNd6HjikDfdgi8nDYgyhibXuBM8FUach8meRhJfCXhC?=
 =?us-ascii?Q?9Mkkt60VjdXekC9c1B5qv7DQJDOhKi064p3d8jK/TJJ3u2ATYPUWMi8MVbl8?=
 =?us-ascii?Q?WbtTesoAvjn7TgrAzCmcqqvfY63wbmw0MyMQo0wTMmSLZyeyfMv3tID4cNLx?=
 =?us-ascii?Q?AwFVPdroHjPW2iyDvFwNCuCPz1PsAjLShaZs97Q5XFypGtaVhPQpbmnh+Zo9?=
 =?us-ascii?Q?dXow63VRdvw5TgxYRw7HWhryjxoH7fCTSitRZRVPwI84oDlT8if8A5bPFbsX?=
 =?us-ascii?Q?Gp6UIJHqyhPcwm1ZRhSWiTiTl3LXaBVtDGD+pSNJDTdmOeVEnW8CpSqYm+xU?=
 =?us-ascii?Q?ZJvlJ+3ouIsJjg4M6+6mf4Q0O4G7DOlZI1aT5tBzGOTxrJFYiT/xtHOH+9tD?=
 =?us-ascii?Q?3/UIDS0qHLOTIyfZRnyJO5YXiF/h59VZ92rdSvgTWfBVUQSHhBnNYFDJog3P?=
 =?us-ascii?Q?eBad+oyNIXOI0rvLSgFNHTOefHYAFw1jtlmYStdkGu/IZcDENJkS1N6Qub/p?=
 =?us-ascii?Q?e2ISza4eCOqI6soJPee5U43I6T1hHElwe82z9cUSHk9LRD76d8wMF4U8Nfoe?=
 =?us-ascii?Q?uVzmihz0ayjopW8GweGohK1erKHdSzQa283QkFOOCrKSo+NrYDKplCXAWHjG?=
 =?us-ascii?Q?IeXHgk+8XxjnPu1UgL8/ROIuzEM3XPd+hJwQ4BwtAn/YUX2o5OFnKn/dpZqR?=
 =?us-ascii?Q?Hr6EkWRGvP2Je8zkaTpUQuWQ9/mqV5XsScZUJBZ/nHYrQZ0oHkbPo+6QT6dC?=
 =?us-ascii?Q?ZDsqhhjasNQQUq2khIAgwsfoyw1myfO+0vwePLYEhNULP4we/IoEySB8LjEs?=
 =?us-ascii?Q?8lkpCd5abWnPDYDpHkkkJL0aUSUh4UNDoTO+VFBGHTUQcK3yLVsY8f6v5chq?=
 =?us-ascii?Q?1K2e3HRbcID0+CUVJWlCPrUCcKerjSjzVMovhc/4CRXzozNWGKVBgrSLLUSu?=
 =?us-ascii?Q?hOJdrPMdGKf5WsIrUctjZS2wkS4iSS0xiwce4vmeGBiATWHBwvXsXDBp7RhF?=
 =?us-ascii?Q?CWN7Io60+hknjUhjm1YKgKV4Rl9PIYcQfsD4lNQEtGM0jL7JeG5KDPJL0Q+S?=
 =?us-ascii?Q?47LlPsf6UTS5VJ2D1yVEmEoh971QwViJRXTjIJdGLZnNfY8rFyGVERtDLyXY?=
 =?us-ascii?Q?tpv1EA+ZPxGirnBp9JYckxDVds6t6iWHjEUEItSfnTWQZtM4LEiY2xRzetxE?=
 =?us-ascii?Q?kC+pS5tk3Ge7lVzZ6a/cjdBH6cNPj/9D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KcXSY9wAk6BA72YL11rASimE9VwRzjO6LKdOluv7oUcz/yMdSwTSxwCCfqrD?=
 =?us-ascii?Q?BYzXbrtgyKE3ZnBaTTpQugdJj8v4o4j5e+/uY/bubBoidrpcZrXBOVMApmjV?=
 =?us-ascii?Q?ErqtbdoTXuFPzcJzxsNZrGKuIqCCiG9uh4osPFm77buCoqeTovY0/dr3L1is?=
 =?us-ascii?Q?AOcfKcjHTBXXn12sOiS07cv18bo7dxDyIOMg2+N3dVfULZbIXkgwR7QkNeWu?=
 =?us-ascii?Q?OMg+WN+piEZ5hxUV2qzi7lqT7wrDsY2fUgSpPpNORUG2hG5eVq4PiyqMJcd0?=
 =?us-ascii?Q?AE5bZb1thyR6X2/HzmbTQScTnkxsPyThOzihvsiZA9iF880bZ6GzBaq+TeTG?=
 =?us-ascii?Q?22Hdixa+WrSEhHBOzH0G5nblMPaZPd9oA3KMSYh+LORhiich8ijGo378Y0MF?=
 =?us-ascii?Q?jVbwyxLKPLFbZG7VbrF/ion5Y/aLQr6ox6lA6M01MuDAD5rEZnI3Wwco7T1r?=
 =?us-ascii?Q?zv9Pj8xAlKGLax83RDQtzNAnA3o84ftPn3RLyl7RmOGpvK8f2wQZqSRlWS97?=
 =?us-ascii?Q?a39i+NilgCzh+qbFtJ2vJXb4zPSHWGSXyYo0LNJ/Z3e+UnFE5c56Dx7/7dlv?=
 =?us-ascii?Q?0RGmWQC4YOkv1OHBEMbt7PATNrugHF3pjbLatgU7t0DAzxu1uSpg/zfjqPsE?=
 =?us-ascii?Q?Cvnnx1VLD4ewNqb1MTOyw0RBXwal/k7vZXQFgDUS6fpou+aPF7FzXCUKy2DM?=
 =?us-ascii?Q?oEayvQFUwVAwKw3xmeZlEtE0OGc5UD5xw78fuEoEW6MOnb7rqUrr7kOxooHM?=
 =?us-ascii?Q?UGLTu4eh5prZQfhOW9BxsH7LYvyEU6oMGcSD3BbOmyvu70+8lcnsvPL0Tb8D?=
 =?us-ascii?Q?ZXSCBEtA7pgxNrXTbcgNlZ9JudNEU/HEieEmavlt0urSXXBC+C5sGbrGCZ/U?=
 =?us-ascii?Q?srxqGZE15d8ZySR3sYjf50RxcbhAV5GJheYbTHDEmE/MC8TYkJIaOl3KwrEI?=
 =?us-ascii?Q?v/QTk5VoAaVQTCXruHgYEssIXZCfMTrLLr6Ug7+liMa3/ycTITNhp5RO0L9F?=
 =?us-ascii?Q?1a9ITK2XRUGeY/WFmoJ45djixBVxFWlGvKliL8Y9shIzgAuA8Sxp9p4t80OD?=
 =?us-ascii?Q?ngME4/KpBPf6q54AeFHnaVrIw4CuH6IfHV/GYagjadtJ8J0o1FK9JTZ45/JA?=
 =?us-ascii?Q?Qu8wezVDy3vYIzC6THbcEB9IAEZzqfrp/72NEj1HvGzeKa49mRd7195UBJvc?=
 =?us-ascii?Q?ZB6cOmMnm/0RwGkFKUl8c4J5jScND8EbVPgu1OyiYsSjW+4lzOyKHau9Fwp4?=
 =?us-ascii?Q?Vd41E+/72R6y5WF3sBnRykAIoTzldJheY2dXrwhjy0dHK4QjuVbRUKYCB68H?=
 =?us-ascii?Q?nf2zPnYY7a/LM1iFwx29mwMRsk6rtiDs5f4nDXz9R2fBl0ojnyOaGpJG9dnL?=
 =?us-ascii?Q?TSfNWmEuDg+1FhW6FjB22TyUF6DtkB4LB7gWfP0q2stBrqiyKCQBkdXxpSgs?=
 =?us-ascii?Q?06b5276W1BBai42QUAu4M2qqA2wGStJIVX5qFHgNUu3QtmA6cEPd3DZF6CEI?=
 =?us-ascii?Q?7V/2cskOi+qVDiyl2vCIy4b+UGkbH0pDsA8Uw14E1DNReE7CuajuhMwcdzn9?=
 =?us-ascii?Q?3twDtr36JYUEPuvWYITc/NSmdnSNkUziQX8hysSL4LM44LfWJ4+6hG6ptLyz?=
 =?us-ascii?Q?MvsFHJjsEwFYROZj26Y7VF4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3087bce3-8b3d-49b3-765a-08de12045395
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:18:12.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUnRiCSbYykSfWmFp96rZZVDFJpjwMyRSMhkjzpFpl9cK1XtbOjOXpbI/TggQ+zTbsKUVDbjyjNgWLRPe5ueXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

The unlink callbacks passed the parameters in the wrong order that led
to looking up the wrong group objects. Swap the arguments so that the
first parameter is the epf item and the second is the epc item.

Cc: <stable@vger.kernel.org>
Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
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


