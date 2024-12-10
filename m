Return-Path: <linux-pci+bounces-17992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD49EAA62
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0004F284FE5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB822CBF8;
	Tue, 10 Dec 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bTbRmg04"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248403594F;
	Tue, 10 Dec 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818606; cv=fail; b=cx3BHpNWqvccTcZEEanIklPIiWOXMWDYq5l2jV12JSalPVdikDsyJKKj4qKQy7MqzNqO+TPABDy8IOYbSdQML8Ja2Zsbrh1nXSl3BkjRin3ZphaMne0GVvKOr9fZ+3jHpPveRkgkXAJyJv2FRIgEe3mZVjzYqRfKXbCvcvnbKsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818606; c=relaxed/simple;
	bh=xoXZQJm0a7qKjTtRLH0EID2PEooSQegcBY3y6RF7P5E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i7WIxcWv8vI0tHU/RUInsUx/wF6yxihOytPphmKG6jHNrJPScFjgiUw5PNxUWeocGQnwwXuw/bedSzJqQj4SNYzps5V+KtWcXL9Yct48t3LfG96QFCIknmEOH3pYoucr3Ns4lCkyqBSh+0eqiWa3FhOkpu/thTpi2V/OymKAeXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bTbRmg04; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrOKnoD6VlXNhi+DnEpA7PBoA2ZaCtRLdjh6tZVujP7hE5aRfq43WYIx9tzRqdIxEdif4l7wjRdPlUlrDIsQQaxmM7OQg14BTVG5eGg65HHYUFbTQku8tbxl+VQB3gqtlOj2TVLPl2z33FeQELDlThSBuRB0ID5r5tcZRfE5pQBw+43AhQutpvvLsM+Ls0dondVc8zvYHIYw/GaA8K930l31w6pKog98DeOdS8rXmtbQw9qmdjQJb7WlHsorf6oKkLzPi6LcvWbu0W3uEkgBz9izhMUc8B9VFGA5B573ZhTjZM6OozaFtV/T1Wk33P1WmRBdMd+/7kmuU2O93iZ97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBn+fsQBsW1chsXVuNjtxRRJdFBCrFeqhs1wikOpzR0=;
 b=F8AYY4TzulrUGo+TSUKckWgkQ+9lREDTOoXY2IoeJAhjp/T4z8k+TWkOAtsncIU+SzmO4RbY4SrC2JeINct7bgvEtrtvskkZaNfXokofdoHyP/9+I/mIZ8z+B77CO57PkcryharpmmtNnk+PXflKpYLyUnyNNdq6nloKoxidbdqfKJzIqmrqYNft05yJHFauhTDyJkISAafWhHWxbqGWH0LIKcbMtr8zlGtaztN5ei1zIN31nryOZMrUou3n9cXrwbbsCcuOGKArJ6tTh903bmpMiaEfxtJqBlxTlA3fW1zvqTRN5WIhyCmEOaWIGmh2aO3gw+OyYrIYxVflfQvMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBn+fsQBsW1chsXVuNjtxRRJdFBCrFeqhs1wikOpzR0=;
 b=bTbRmg04ZhGEjLq8Gsdep1zRD1O+3EGAHJcih25Uha5TOykTDCfb95G3na4tXKN4HcTaHxYNaeSmrU4yK+xhbycPANPcUZJu5db/7wwBLHPqFafUcakFA+VABku1KuZ0atmrYvvu1oSYq0h3FSrWPM6W3q/J7Jz8pTY1FbA28jI2wGBl3HKI3ExS7m5hlY7kOG/jB7hj/t68wg4FbOONRhHG0tQMeAlDPP/52G5Qycsa7dXTl5ZhXWXpybx2Svv7OszHiR91o0Sn5e+TAoTpzxrIXjhE7UEWONLtZpi/mVwZkwyyiqS6nWNRMhyZyaytjpAq+Hw81MCfWpjzfaIBrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB10156.eurprd04.prod.outlook.com (2603:10a6:150:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 08:16:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 08:16:40 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: dlemoal@kernel.org,
	jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com,
	quic_krichai@quicinc.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Bug fixes when dwc generic suspend/resume callbacks are used
Date: Tue, 10 Dec 2024 16:15:55 +0800
Message-Id: <20241210081557.163555-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GV1PR04MB10156:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e04b933-b44a-4ee8-51e0-08dd18f2f913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ih9+/Wk9oYdaK01anTNmPeiG1LW5JPm1msHYdTACpKUrr9NAlNaItY2eavL?=
 =?us-ascii?Q?JacuzIeGZGuM9M/CtZkES2rJlAKSmzSBDFPbnQdKOahA88F+MIzntclE9Zhn?=
 =?us-ascii?Q?2QS86BMrhb+6qpLAsH/xaKlk5xrPt1VaUSLDVR6t0C/QiWpMRz2WCbvRRGUu?=
 =?us-ascii?Q?4WkcIvVXLJGZGKKxFG7g9O0HuoC7dqAoZTsZksChJRvHQcvcvNcDryc3O9AI?=
 =?us-ascii?Q?XLvKmpM1E9j1SiUqHMsur2KpW6PTQvTyz0CC9dZTbmnUi72uaOpaM8nIRkpf?=
 =?us-ascii?Q?he8aSBAx0atZ6glHTh5HfMolC2pDQQ4V+w5NmTMAOyxs8zQFGxRTlcPZFmb9?=
 =?us-ascii?Q?rBFIZqdUAUpSn2JoTrOYNhceLr8dfMpQOaYo3veLuLoJj1r6/slLIaKLg61a?=
 =?us-ascii?Q?2s7WMw9q8Ry69v46t4Ow4nwjFDJww64tuJjlayySb28bI5EVfIF9X3qsoJoD?=
 =?us-ascii?Q?5fjgu7h4AzlmwdoaXGYJI/S3zdOpo9CXMDM2JFNDluphFr+xk6yZ3dKfF3mz?=
 =?us-ascii?Q?BwbUsoiWGwK72ZMYb8qIXvXKLl4LmeojGZD1izZWUhAIf3RL08xo88NmkARg?=
 =?us-ascii?Q?jXx9UBp2LlbhqU2zQ76zZlfBOLrmc8yA0vStWIagamozmNqhNnZZODbPiYSI?=
 =?us-ascii?Q?NhQnq4YL+XxI5j8RejY1k7Qjwhx7k084N/qRB9FZEfTYxP0p3nh3/cunW+7I?=
 =?us-ascii?Q?i4JnthSOLRIKH141fORkvLvyjxS/mUvL9Iwx6SZjO8EN7PvrltCsNVhWKrKn?=
 =?us-ascii?Q?em4LbwYg4aG0vkpUPiJj2ViYmfvoJBhcboYDer89Xspc7vqfo2gPxJOpHsTo?=
 =?us-ascii?Q?+dqwrPm5DjF6pB+ZT4kX6aS/lDSa8qy+bHGqjO2WkEOI4MbREyY6MFUFz9pF?=
 =?us-ascii?Q?6dRUXcqJB2jSfgBy992/xM/cSlSfMwKAemM3mlPej7ROXUjvLQAH00q2EZqf?=
 =?us-ascii?Q?Mx2qgyyGQ82ahEPv1FpaZuNKcQdIHevGenhVdFVKEl5CoRRL5CNoHiWrtp+v?=
 =?us-ascii?Q?BdDaW22rx2J9JZVL+rklvr6bQXdca5RckcaQwtUN5Giqal5hA0OtySQbieNq?=
 =?us-ascii?Q?pZOwYaWAL7Z+MeKreRDlHvYy7sB3Dxwoo6cw3O8/m5KJyuKBbz/jOKqsFY3P?=
 =?us-ascii?Q?Lu3mF5dDtCb395gy+CrqG7g1LfajO5UDzc8EFNO3Ny/Y5xjaWzL8O2XAUHcp?=
 =?us-ascii?Q?cTE0DPhL8KEUQDfq2YU49VQJHX04iQ7xVtGVpkICmpJ4GIRr1pXUHrTJN0uB?=
 =?us-ascii?Q?woKOJm0oBLHsU87tBtQSDE9q3D16IE/134HkmhGc0i3avXX2I7M1Od1NSwFN?=
 =?us-ascii?Q?oRNP78xpzlGh5oV1vmK/fhu+EJhWDm+yIiyXjoUpWQGCl3FsbPq0qi9bIG6M?=
 =?us-ascii?Q?LqA2SLCi4R1HQpUVVoXy15qtK5izUGESXkJWpHHR4OgsxYtRIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NAIuVjkO47S9A/5tC6fN8uXabzAV9F/Rzp9p2hOwAH1t8AudJWBoR3ObItP8?=
 =?us-ascii?Q?hEYLl3bfEDJ8uX7oBfjIdebdr/PgS+IhIA6BoMVCe5v78zuEhkAvqYmpzVEE?=
 =?us-ascii?Q?M+ao091tnhNd15ao+JB1DznNHazAR5ycQTr32ASVynqhLe7ptHkHD2TkVvxr?=
 =?us-ascii?Q?n7ee+F73IWlN2GyBB5YQ0YHS+EVOo7B3hySp9+Gyh4KA9hPMs5hOJmshCMf+?=
 =?us-ascii?Q?VIBN6lc0AP5ysKNiH59S+qDt2xWboj5Dya0uNa3U6bde4rFXAK+fdeOXacNT?=
 =?us-ascii?Q?Jj9gvsGoInaVrpRwigD6ToRDLvrZJee3d1YbkzzkEEMsJUb3T2WW1MwpVNfE?=
 =?us-ascii?Q?5qxS2zEHqOqLv807Lttnt1mxfwHul4VsI0GIaplJo7X8J8qf3yi08HH/TXDn?=
 =?us-ascii?Q?rZd56yfo7Q4EF5Mj6Qfx2EDYv3l59P8uh5oTXnfXgXwQ7nfsffsp2xR2u/cF?=
 =?us-ascii?Q?GMpbzwkS4UW0zyQd+/Dnxci2q+G9yw877riuwlJv+/AKfsnaT5Vf4yxHYPhC?=
 =?us-ascii?Q?z5TKt6CpOqyaRk7TouaeCmAISBrBUGpcSbXHeZJhUZ1pt8T/Or9by2azNPMV?=
 =?us-ascii?Q?D7Wdo3ahT21cqy1CupUBwHAEr6qo1L8tf2Per9p5le1kdbcwQIz5gCQToOq7?=
 =?us-ascii?Q?3jOGk79uK+F8WhfVuWZiGpdoIlxTaWb50g1ybV7Y+z0ADlgvuRmgtDNCLGoE?=
 =?us-ascii?Q?i1NY08uIylFGC12MG3CZONRtEx6Pn9FNyIMmd6alXJcXyobv0xFyzsaKy9sr?=
 =?us-ascii?Q?mmvHoR0zJr3uzvIdLSRzoRFbh83q+6LBfrFPexBcH/BM7eyeSHzpJuxlT9G5?=
 =?us-ascii?Q?mhysGIJSM4f4a2aA1QFmX+NKBAeK2txtsWwzgfFCkU/ORPR7MBl3bZDTpxV+?=
 =?us-ascii?Q?CqpPTeyely3UVjmSO42MVqUuXJYBFqWRCWeoEvOyxQQXuJ9kvJVL7tBPo8BY?=
 =?us-ascii?Q?S5qz8jqyX1GwxYUybbVno9hZj1M04jUK0F6t0v/bDMI8eu7m7eW5Z+RtiJet?=
 =?us-ascii?Q?LBQSIFb0vxwYBkc74+oSNxctlUNz5zSnoMhkZ5zbcr11yEt/k4Uah/H6CKdT?=
 =?us-ascii?Q?VfAvZ+sOoTfpSR8iSmKNiekjF6c+QxuLOdGwfrvFFMdGDdq2nudM6KC/3jsh?=
 =?us-ascii?Q?zMDwvYAQY7JMHtWcfSpta3XvVfF48ld4LBcYys5PNmc6kMw+4RHO0Tg7bICF?=
 =?us-ascii?Q?7Pmr/2P5DodN5DAm1BnNKW2GueyuOnb+PkUkCwiRZ8Z+tmDhrqLo9V/IpLWX?=
 =?us-ascii?Q?QXRuCkZZxh/dQxWUChezMfmTVDg5ru5pdeBymqRPMKrI47zy9Cc1MAva+PLa?=
 =?us-ascii?Q?29tiKMz+mb7axfdTU5gDQHJZYoR6R2jHMvFLsZdwXSQp4TvIF13OMJl5FIVl?=
 =?us-ascii?Q?+vGHXDHjB9OfLTeITYJqLQC9pRv5EoGWAd3F58lkf4d8myrBG/VqlebYh4ol?=
 =?us-ascii?Q?UVD83aI2O5z21aY3z9TSgnLJ+1M9PZe9pXSzfePSBgR88Tr2FsTXs8jsM+i9?=
 =?us-ascii?Q?sSqGLkdAo2gcW7cki0AUpbP52vdsbfw9tRXhk9o3t/oInfsT4Qj6w5UA+pvE?=
 =?us-ascii?Q?ifEXL/Gj/IzOf5ukdq8o5uiPT6WinfRQrzj/pajY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e04b933-b44a-4ee8-51e0-08dd18f2f913
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:16:40.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcEAUFrr5aoU6DSBjRAoREgV+t87dji+TDLlX8xzhwdvDuzGjOevZF6JfQVQGzh/6jr3Mwd3Kn9knVMOV1820g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10156

Some bug fixes when DWC generic suspend/resume callbacks are used.
Drop the first patch of v3 patch-set, since the use case of this patch had been
covered by #3 commit "PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()".
To be simple, re-format the codes, drop the first patch of v3 patch-set, and
only keep last two patches of v3 in v4 or later

Here is the discussion [1] and final solution [2] of the codes clean up commit.
[1] https://patchwork.kernel.org/project/linux-pci/patch/1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com/
[2] https://patchwork.kernel.org/project/linux-pci/patch/20241126073909.4058733-1-hongxing.zhu@nxp.com/

v4 changes:
Drop the first patch("PCI: dwc: Fix resume failure if no EP is connected on some platforms")
in v3, since it's use-case had been covered by #3 patch of v3.
Add one Fixes tag into "PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()".
Refer to Damien's comments, let ret test go inside the "else" and remove the
initialization of ret to 0 declaration. Thanks.

v3 changes:
Regarding the discussion listed above[2].
Resend the patch-set after adding one more codes clean up patch together.

v2 changes:
Thanks for Manivannan's review.
- Refine the subject of second patch and add
  "Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>"
- In first patch, update the commit message and move one comment into
  proper place.
  BTW, Manivannan found another potential issue that suspend is entry but
  the link is in L1SS stat in v1 review. This is a new story. And it's better
  to be verified and fixed by another commit later.
v2: https://patchwork.kernel.org/project/linux-pci/cover/1728539269-1861-1-git-send-email-hongxing.zhu@nxp.com/

[PATCH v4 1/2] PCI: dwc: Always stop link in the
[PATCH v4 2/2] PCI: dwc: Clean up some unnecessary codes in

drivers/pci/controller/dwc/pcie-designware-host.c | 28 ++++++++++++++++++----------
drivers/pci/controller/dwc/pcie-designware.h      |  1 +
2 files changed, 19 insertions(+), 10 deletions(-)


