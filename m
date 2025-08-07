Return-Path: <linux-pci+bounces-33521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110CEB1D304
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DED73AB584
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950E422F76C;
	Thu,  7 Aug 2025 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BAdRdnfg"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8D22E40F;
	Thu,  7 Aug 2025 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550596; cv=fail; b=RY2uLYWHcmmwuN5o0+Tt/KOsY6ovubQbIHHTcm2OpvyBgCN2OV+ckC4zozu4FForpL1Q1Ko9uml0srD6xXg12gq8NUJdOiRzPRtfXPLHgN2JLm8LQ+/gI9w9FkeBwEc+SSMmg2/EKQ4q/xKRHZZZXYMUCv6DKT9u7A/lbThfy9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550596; c=relaxed/simple;
	bh=rS/Bk6m4zN6RO9xHJCSmQM2i6x7AWlwOtR7dY9NgPHo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BscbE0LzytWA5IqxyFUyzAaTcSRdu/mmkvQU+muIBA4lT3AJDEh/druNjK3xTuoV9v5/cpa60r14pO9syXjwt2dJ9tO/k+d/Ko+2ToGaeD9yTqozarB+mxM4uJ1UBHpU0TdBFyex7Exd5AyGyP1qgP6jDhCJdUihSFevqkTkTxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BAdRdnfg; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJQ1NNd2QS5sbiknqD9NrAkz+45ZI4SyphGzdYq2WugsIr9ts6jTod/kgcaX38T5qi1Xzp+uV5hbuWP8i7PwYjEwDTVtv5NLt7ZLSAgBuMCBGTs9n+pbuyvJJdz015zoV6tBIVq/sGC8FDG8sOV+/6gI5D1jL1cdlNkn6Fs9XgPYcPMJJnQHDWKvZde+lPMPltPBYNyvCb7etShAzHqAojk2bdBr8o7m7EgE5OSKIPJhQ9r6GX7l1vpoC9zwYJxEWDBgr1fub7dJdbpywmSBOVUZYFUKdpQg798zzIvdYuczF8/+IaSjkH0R1C37vHpxT2fpFk58b1OigeIBXegk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8FxaLkNVENYdDe/YFM9pT+fTTgG/NSAdg6cDChkd9U=;
 b=aU5tTTDXWgm50dhYbK+BPA1IZoSxmu5NMHSjEzzeV5+OG2kdWMJCXbQQ6GIrgP961BXq2UXNFR1GpuJMmJ/A0yOKk+GrSSxyUeoZ+tZt1WXKdej23giB9u84it+t2uvUEb4qsff5Vml32diiZhwQxxCKKUXOXWd3+QBOLCAADtW7C6OcgrNIUIEo7jeOHv/RJcYB55Tp8v7armZfNQE1XOPAq4tT+oMxDjv15KAMieB3aiZWPUM0ZyI4XgE1i/9Fwwvd5sMTFd+O7viCIWcB7TtSd0ikQIkCq9IZm97BTLPz3PiJqVsgWX7KKPDS4LvOOWrhKbOyREZxlexnn3xvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8FxaLkNVENYdDe/YFM9pT+fTTgG/NSAdg6cDChkd9U=;
 b=BAdRdnfgfXObnXUdpVks57wGmUuShDmqrh4SM7RFkwlIRh8/SujETLEKFdvB0oNvN2s6QXpgJ9Fkl0fQYAg8iRLA1xGarOktw5UpzbKuuqfjNIu0TmcnVCZxFe1bWTWZJ23HdE6+c/cghvJ0Hw1OnjQubk7o4YZXpmThsrax96W3D4THAxC1pxldA/5zKv3m/HpGSyAVPEjifgsucYxe8zAGrJTSWSPA61QZMZqb0d+ABr8HRoyBe+XiHla3WbDOsi7ujVJ0mcRmVmHgRETCLUX0cclpDxkyFOtgXGdx/1/akP4qrUCtaHx1jKmg3/ph0E5tgyuHDGTZNXHPwO3VbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB10814.eurprd04.prod.outlook.com (2603:10a6:10:58d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 07:09:48 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 07:09:48 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	Zhiqiang.Hou@nxp.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	Jonthan.Cameron@huawei.com,
	lukas@wunner.de,
	feng.tang@linux.alibaba.com,
	jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v1 0/2] PCI: dwc: Fetch dedicated AER/PME interrupters
Date: Thu,  7 Aug 2025 15:09:15 +0800
Message-Id: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU4PR04MB10814:EE_
X-MS-Office365-Filtering-Correlation-Id: 81be147b-c0cb-4386-0e1f-08ddd581654c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1nZUAfe8zvSw9dowA4jdmTCQ8kprcAYU/Nab63hZKPHOKTZCVpmlaONfe6Tj?=
 =?us-ascii?Q?n2A+xydK5BR8JahyyvuN3xlOqslN3aKL/FOvvxl1Hk9TM/aSInuYcK1K+Xe3?=
 =?us-ascii?Q?BUXQY1oj9chOcPEwHgKGHeLvQJf/JhXM5oX5GiRkaWWRv4L5xgvgAypW2YZ4?=
 =?us-ascii?Q?F5mPBc/TuxbrC3SmUD5cr9saVm/lbU6wGZq6cb6T9sxtZFGc7nUZIZ42BbBX?=
 =?us-ascii?Q?agML/Xn5TcQ8LXMexSqjghwTaJWC1tFn4M6azqLzhus0AlsGsIMh+2VDKbuP?=
 =?us-ascii?Q?GMP3Hz9tdOaRrBfGSwdfy7Dc53PLq04wXI5tbe6di1ioka5uMLslg2aNgK+v?=
 =?us-ascii?Q?h/vHF8BUjdgJw+OsWIzSRu+grD/YWp9HJ2dHmLL+02QDr9Y5aKteG6OqrG8t?=
 =?us-ascii?Q?pLcnY4UP2ahwrRo4I/NyK8aoRBsqF5MI2xSidmY9n42zcyKBTLwoKNS3w/x7?=
 =?us-ascii?Q?itKARe4jcxcPtl2arfK8T3VIPvj7XSGSupW9oUXCXZ16/MEdvQPOENN2eqjj?=
 =?us-ascii?Q?eC3dDmNeuwJbo5OzhKtAxzzVKrQHtbx3vXgGMNJFIksDQSTUMx3jOyqHL3nv?=
 =?us-ascii?Q?4X5bKuWklJRakBCz9zx0ga8+9qtHRleqwuwrW3NSY8CM86vhgjtxaDXyrpbN?=
 =?us-ascii?Q?paKIxWKLQaVgZuH3UBo3nF8UP02qIg6Qo9bpfZuTSh9P6khhI2dKJCIBjtUi?=
 =?us-ascii?Q?k9u3ZhmE+vLJOaahYhymyGO8kNzsfQLqrJYePZ/uLhFxNy3kcH0gIAgrOSKo?=
 =?us-ascii?Q?3NtV05Br6Bw/h11CCziAQSOxXGSpJUm92j6eUqFgrVDT9+P4cNfaKjjmVRRq?=
 =?us-ascii?Q?mqACFNkv5Xt63MzuMJsQ9L/ShlLUesSKflyfxwt8EyZRtMl8IsNqdsHdlNF2?=
 =?us-ascii?Q?9WudjaC2GcTxpaZCFRbYW2ZAwtyBb38MGuDijlaNANCkLn1I2SlNaP3/K25U?=
 =?us-ascii?Q?AjKiF4qzrcmFmBxMTojgXCFLVXgjBUiqZMOkhYI5mj0XlkS2R4b9rSo2Wt0a?=
 =?us-ascii?Q?5xUiu7ds2ywHYvz1sMl1ZO7Qs999nq3jn6wm5yrWtHL1B49ys0Ui8hav0bIq?=
 =?us-ascii?Q?ebzSLy/7OQebJ0M8AKwl/MIP8xvrDmv+1yciYvxss7vjChtA69cUHfiLaI+6?=
 =?us-ascii?Q?HQazsRPTY6bof5GY8qqt6bpPRGW6cpDQKsdtd0YnkAoyhfqQdfSPeKT/S2Dh?=
 =?us-ascii?Q?io62s43xwKFiW8Bw40qxuVjAJ77ieUG8kXz9kGAmq3eDSMDcBG2SibLCRlvZ?=
 =?us-ascii?Q?4A+6lYNOsbsnlfznn0zAvKrw7JLNzVhX6aEQ+1XX9IYPFnAdDX4LnDpn46os?=
 =?us-ascii?Q?FUHXUPf8jkwHjE+VjORh0SH5nWRWxdGLhPO6121O/+9s4YlQMn1qINIYm1L8?=
 =?us-ascii?Q?M3xSSTZDwHtwTzT+FsKya4lstPtDkajgNM0ZXKm2haEd75SFTRbUCrQyvdxc?=
 =?us-ascii?Q?q76DfrNNc291/EnH0pNjnIEV/fOul0I9Fnq1uxkTZoAkxc6Li6JkuzGHfi3b?=
 =?us-ascii?Q?F39wkaOsY3tzXQWhxRcz4CDTRjGQ5k7PJUr5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKvVoU9HmgeqocvqdIXrufzYwBi3JMNhO6xpnIaAHiY+wBb/J8Go1sk2n6LU?=
 =?us-ascii?Q?quBnnVublh0Ky69Lo31BVZvebBuzJcKSKiyQEDQ+1W+qAsuHwVypBCCsh9+0?=
 =?us-ascii?Q?BNExZpMiT710AzdeZD7m1RMPhZRb4Kn8o2oj2FakriTBhHg+HeaCiwB8FEN+?=
 =?us-ascii?Q?kTorsGZXB1aVqlguXpkwZ+M0rr4mrKyn+WohI0t+GeuQ0dDRfJwN20/s117d?=
 =?us-ascii?Q?ZHm77jEniooJ07f/NgSQWGm3M3jvycKj7wWgCDhRKdzqhwB1VS8S5DyAn1FO?=
 =?us-ascii?Q?LtTJIL6l/uxISYtfPk8o/wroaINY4e24LqzIQpZ9KjkYc72W3ohFZ9S/T2og?=
 =?us-ascii?Q?b+OkkFNRFbIj3k1NnHMCPvBx5EBw6QlA5Zz1hIAUInkHJBfSA/NxMkhaJ9B2?=
 =?us-ascii?Q?xLb6TBshKjyHPzakqgo3wWlMofZHRRWsTbSHyU8zIByLym+86CNRaerkUjsB?=
 =?us-ascii?Q?oC5tsn2QJ4f9QHqy1vP1hulz9D+yov+ovyVx6GFvnOUUhKP3414VfgpVKtuX?=
 =?us-ascii?Q?uPCoeaDPYbnPDMLuAoDpOgYZL4tOWy2IRiC4GEFzHpX2E0sZPccPPu6MVT36?=
 =?us-ascii?Q?i7h4JGhueDwSYw74PpMD+bf6hWpoUtORB+BgEiPxMAGGsKW9ewmcMSQaH3ep?=
 =?us-ascii?Q?4UJQGFUHdWjdy1oVYSwFpyoH2cN1PUyOZKopguO/5sO8FXII7oHHAtL0ekCk?=
 =?us-ascii?Q?6fn41OA+g0jhDe3amRdR2qfR8v3UJN7V6kEVkIkfXjBayFAm5s2G4kJE8ctB?=
 =?us-ascii?Q?3AjXvp8zRjZflPX5+wK2/To7kegHEAwO1ymN5dYdXpew1PUDcuF2okFpMAYd?=
 =?us-ascii?Q?GjmdULnMEMjEAyIuXqsjpZFyZZ21C+JdAWzB4vMz8dNKFBxoYpRC0rOeGHEb?=
 =?us-ascii?Q?tPDvyvJTTbIAfdJhzBfVABct20J0JHasvJ3zh9pB2JmkaBfKd0+/Kx6b/IVk?=
 =?us-ascii?Q?WE6Tv3GnGceKQ/Ezz/oOuUEufCth2rTslv5dKwRc68WulKwJ746Mk/9IngFs?=
 =?us-ascii?Q?YTt4V9SKm4/TqsIL4vURBWdz+gyZfBfkypYwHjo2BAvZNvI7Xx7EiVYZdKr8?=
 =?us-ascii?Q?E3dJt13gWiW92OIpN87PSHSRYyQqP6i/Ivxpl9J29WjB5GtyoLQ38KZCydpl?=
 =?us-ascii?Q?qAYQvCqXg4WOd5tbYAUfZYTslNLDRdtZLfvmRlZngyYJntsWXPYbiZEI0URZ?=
 =?us-ascii?Q?9bFgNR4M1PIe6WumDicH6C2cqZ1l4YFRrlvkUtupxR5JreusgwknCgOBEauZ?=
 =?us-ascii?Q?wxAZ6NXXuhgkjvDBRyXVaGSDfYtV02BzejRazt1/DEr/th/pwg+bIWV5jx8B?=
 =?us-ascii?Q?OFe2btljZyjCCrguBPdLbmQVbBFD7TpjbnByJNDs//fBsB6Onk6z86mzaVEa?=
 =?us-ascii?Q?8ZGdousKXWH8SAt4OojOIm70mCbSXfCuBVIFU6jUkpSTz7/9Gu48MTPxG7Y6?=
 =?us-ascii?Q?zF9+8BBOwfxiaaTGKWEeeAb/6DPX9Q7URQJpd50NnprqUjsCz+GUbFtLWTdq?=
 =?us-ascii?Q?LwvOacfPayH8xGJWXXsohu8opMxjux14rdhvT0I+VaGabLXTrGmMdo6DJO7N?=
 =?us-ascii?Q?PPJ89FSioThaEpPTVApDBXtwxe0sTo5iWowkJ7F3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81be147b-c0cb-4386-0e1f-08ddd581654c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:09:48.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+UpJlfJXs9ZUxY12ja7FoZNdGTraYtezISeOcNapnyFRKp2w9D+6nKCfYuEaG2EAvuJgMmb7Tjx3UPEy1qaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10814

Some SoCs have the limitation that PME/AER can't work over MSI. And
vendors route the AER/PME via the dedicated SPI interrupt which is only
handled by the controller driver.

Add the generic get_service_irqs() callback for bridge, to let portdrv
can fetch the vendor specific AER/PME interrupter by it.

Closes: https://lore.kernel.org/linux-pci/20250702223841.GA1905230@bhelgaas/
Tested on LS1046A RDB board, the AER interrupter can be triggered by
pull-out of EP device based on v6.16 kernel.

[PATCH v1 1/2] PCI/portdrv: Use get_service_irqs() callback to get
[PATCH v1 2/2] PCI: dwc: Fetch dedicated AER/PME interrupters

drivers/pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++++++++++++++++++++++++
drivers/pci/pcie/portdrv.c                        |  7 +++++++
include/linux/pci.h                               |  1 +


