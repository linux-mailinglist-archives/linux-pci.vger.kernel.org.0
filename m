Return-Path: <linux-pci+bounces-42459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC432C9A6F1
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D884E3531
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154F3043D4;
	Tue,  2 Dec 2025 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NZBLLo7t"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD51303C8F;
	Tue,  2 Dec 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660251; cv=fail; b=KhL0O1G2mEfioZ9KiC/q2HLqB7kzm4mZjBMEUFt+T8wMaWsbR+HCFwBgipkSE3Qugol86+AQC9JAEgXOsCHdbWJwcSRAalyfRtPSe1MXRG0CHL9zdoej2FlMpijyf/oHb81eExny/0fEPSRZAeIcV7iqpuRLHjVxHETzhT4wlQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660251; c=relaxed/simple;
	bh=+/ydGQ2IPxrd7gCsogKkZybwd5DYnkeOK156Wld6o94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKL5faQhzgm71ImLkyek+2G+8QcyGcsdi7ouqHLXd1/X8QLlQlVdpn4vHjonPi2jyIxPRMpdKCqz+eaSgeAn0y30IMjKCGAKHm9czRzfsDhuIn/UkoiE34i2ktaZpjZ/NKadzA33bd1k98cIkOaIv5XS/FXKoXsttfTF4sBhMgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NZBLLo7t; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMn9qSeTj83hiqgFwbWzB+CWXD2YkFer9Sz8eyWffP9LwFw+MIcMm2FQIErPVS68Ffhqi6xBtWKnr4eeFbOf3Tud+s1aZMRjxQS192ShE8FH+4X+3rSr/ElgMdSN3eGHU4TcS6ZutxonWS57J3bOK9N0gfbOS5ixx6Xs6FchT5mDAQEttczquwmp7Ue6W4ywqRZt+VaiYVHs5Ir2p5FkhreNB+Pko26773t8UbnPdDo0kG1P8Cy46QEmds/NC8FKqHGpU+UoGQbkTBjuTOGkFu56XU0SOwG/BAlvCrT9tSnMQl+Qg4Z5/fxvuixyM7RFf1MXMQ3iGRd85sB3kp4StQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBEB7fVynklPWmIXmEFFKdlDx+IY2DdlgpPZd4p67Ww=;
 b=UK+nXEiXNo5kfBJC31G5KTaOC0iHCkV8shS6VIecOB21kHEDjDMFwyVP+P+PyQNnC4vZtUFqbZKvPzrbNrt3q/LQZkuHCMBB7yJOjgeuajmGjSc2rdnYhQJcOi9eNPhk1P4rdYJ4Npb42L7v8KpjmPFzjeDo8jrhkmA8JHNz4B0l5l4Dy0n4VeqPjpCvLC9yLeUhDUHMZzNQ/QSK4mf0LbWdteYrryBedHh77zxylV4i0UAy6Mj75Gdp+Xnxr5fH8THGdpadiBQA9OcDh6hj4ifeYDUANfCcwfwKclA8raZvBLIBaSv18dNJV8RvzvRC4ysOQ1VZYBg7Olbmr25p3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBEB7fVynklPWmIXmEFFKdlDx+IY2DdlgpPZd4p67Ww=;
 b=NZBLLo7tlRN8+7R+BQmZOzXQ4VB9fFJbxvGZOGxK81NpriugUqoG6QVJYCZcJsiWw7CkwmFcO1fnHByjo33/w4oogZ9dP7hH0rUbZ36UUe28zHFTTNmu7rQspTAyfi8mSKHnF2unZRb1injYFZBadAwfJM3/igQ7WfVsG1E+uRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:56 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:56 +0000
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
	arnd@arndb.de
Subject: [PATCH v4 6/7] PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use pci_scan_root_bus()
Date: Tue,  2 Dec 2025 16:23:47 +0900
Message-ID: <20251202072348.2752371-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::15) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 49445947-ad5d-47db-61eb-08de3173c0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?woctHtm1esS42fKFrPREMknhm3MtLBY57cdvWbAp3oeQcMkrT4VQLDbxDelN?=
 =?us-ascii?Q?vmYU+ilNp/135jG0V5CmrRBZPq2hNtWCM/+h/ImRYYTzE1YBh1QvE3mhMxDV?=
 =?us-ascii?Q?bPNWeTyGARIkK05ZY6n0yCUIbahQZm3cyfILBs3Ops+PccQaHhqUv9/DuzMc?=
 =?us-ascii?Q?ygdJj5kN9lPUt0uEGRDBDS86iItrDALNf3aEl8XQD6AuFy8lUtFc4YbC1fIL?=
 =?us-ascii?Q?3sDvtzATPFWmGFGno0eUq74BIACdPvI6Q2WIw2rWPJuZxQQ1aQOQR0f3qV7d?=
 =?us-ascii?Q?S8bJZtLrnPLk1C7EfWGKYTqH59fH6ezOMhikXUReTIWg4tUuMBjEZ/xOkum4?=
 =?us-ascii?Q?kenDKm/MgWM1fKoDZmoOoouqlUFLPYYnlokJaKYK9/BCI5S93DryIaRiVrlC?=
 =?us-ascii?Q?CM/bmNu5Ajz5SEGz/mu1+pHwle73UCHdYD4cJ5kMzPRoVkDGo31hdFNdiXYW?=
 =?us-ascii?Q?/e2PT4lPeIQq7YmoHpoRHp4AxHKBoakfWqo4E77FT/VXenBrOjcnr8QMtHuQ?=
 =?us-ascii?Q?iHVYnEwByWGNaA2UUOjoUJdlFwx0uI7TBxHINJpqqMM8LBSbmJPT0HikQqDn?=
 =?us-ascii?Q?QAwgezgUnWvErW9k8PanjLgSykCu7ewp8xxIV5TDYyX8vEHNwWZ94fF1OBnN?=
 =?us-ascii?Q?2RVkxPRMEwSvtATFtFgB2YCm6yVSIIfu/V+Ue0enD5/HameqEuO29Vfu4TeU?=
 =?us-ascii?Q?l1SZoCH6upPUVB5w4Jpb1/LUvcufWhJs1fhl6qjUuWwz7PR8tQEDwojIc2e+?=
 =?us-ascii?Q?gK1Hk2ajHicuz2h1Y6gz5O7FRhO4hZfJtcB/vOdsFlP3JYvTJnOxD5sDO43t?=
 =?us-ascii?Q?ydCoxenX1jFK2saSz2RgwATSN78k3YGDS7afLKV+WUeQFboj1LI7m6Ft3cJz?=
 =?us-ascii?Q?+GIIzhCEoltXxH28vyuWYKjCo2SKo501mVFiZrwyp/qyDuHA/cQS8aBKEVs4?=
 =?us-ascii?Q?AU+M34xbVMaZabVendMmQbknkxD28ryYQ6U+334AWRg9iWV6Ahk5VyZykscz?=
 =?us-ascii?Q?uyYQMVLJ6c4mtWfG4RB9GOjZ2vunY0PhO2G99659+L8rFAsW+w9SfaqoqweN?=
 =?us-ascii?Q?+Bi9mEsZKALToaSy0ocy4UbsNCDG3VRJXHKZBHCfmHnYo+SmeDQvxG7aGrhj?=
 =?us-ascii?Q?BwEGcSCgZT4hgt1YD7uRrVe+dVIyXpzxauErUv+dWm1Iz3GE0qswzpIDYvM7?=
 =?us-ascii?Q?OxmS3j9Y6yL6HW/8w1GzAYJDYVWb/p9KSNUhHQ/AyPc6lNDbfm8SJ3q06wH3?=
 =?us-ascii?Q?qGZ8vwjXyRePTHTq5vZ3pOUs/SDz+3SoeCZVzWLH9niGpBpIAWTGTWP68J8Y?=
 =?us-ascii?Q?u0oHXYNeQDgcl9cJ+723jDIij+my1eFFtjiahfRxMBaTHxBXbE+k8DT1qgjD?=
 =?us-ascii?Q?oDU0zj0VFnD/GXqiwNXDKDJ/c0Hw7YjFJ9+X7g1OREErEyPYyZG9H7xvlTlw?=
 =?us-ascii?Q?hT6JIgJVw1TVv/Dyyh8XZgvi0GNKpReV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWD/5KVebu/KahaBUhMjwd/2RRwMXimnSHvW8xykUCt97lcB9Xamm19A3AVH?=
 =?us-ascii?Q?qe782LVfv4WW5x/v9D2tMZzCuKjuriWNbOA1ZPt/6RcYhpxu7l7oePN5eHxz?=
 =?us-ascii?Q?/QD5+0C42l7j6dex3AT3IQWMLmp9XeFZN93tTwOHaKDtnw9RbJdvFTU1A6As?=
 =?us-ascii?Q?SZL/RJSuvzGzFTRf3uEJl3eJEwJtYAvR7L+hhFva4O9s+4ZSGyeQ+PdSlh41?=
 =?us-ascii?Q?puR//S9SLLuVo2SVHYduxwT83XUEvypm3BdHRQ/og25jlYc+ACCa7gnIwt3H?=
 =?us-ascii?Q?ynqWTu4CmH1D8EjptPXoeYw2pBtTGaQuLzUEvo6T9YbJo9fymkJ41LRhLzh7?=
 =?us-ascii?Q?a/Ooegh9+/Yb/pD0OFShI2GizdvIjXMp+Bf6a/0efexVhYu8wyxAGCI7vhqX?=
 =?us-ascii?Q?L1HkErjvSj08I2fWtBewOWSWsUq3R01ZTsWdLM16DLepVHgGantlJpgRiwp9?=
 =?us-ascii?Q?3+khoNKO+JSueiqgC8cclZppDaXil0M9r0pUZv5zN1WYJzQVkilNkw/NXaXn?=
 =?us-ascii?Q?bTGK3sLTG4f149CYRd4MmdaKg+GNuu3RNHPAGyfO+PEO5eZ61uzc2tuh5yIS?=
 =?us-ascii?Q?hIrMaG3ca5CwGuhTTRicfq9vu47AryG/oAH3sAtIkSaI3xKJjbpZU7MdxFGB?=
 =?us-ascii?Q?S9b115aPSPXqY4qYVx/aHKQlqG37IkBs4TPWt2YnVjAchrEnmjynihVeltsF?=
 =?us-ascii?Q?tvfBUlp4EyoIqRwLrDUogokQXroJFpVzRhOidILGW5WpHlz1TBRYxR5sNo8x?=
 =?us-ascii?Q?9Pokv/7vlbL4efbikQPmubC5ofHSoozxWOeDf/EQSBvHuMlQsrnKOtw9VZno?=
 =?us-ascii?Q?+UhegociAkP8boc3pAJO+Ca498saNEwGj9AsZXk+zy3pvaPDyUSLA8LFEDtF?=
 =?us-ascii?Q?Ew89Wm9gbsPd5qHARwuZb6uInu2r2/6/Kl0kSYT330tV88Bm6+uFbxBLSuCr?=
 =?us-ascii?Q?QSEGhnLX+sbQIQGhPzIZjTuhIiA0WszTlbYsFl7N++B0bZeyVxYnUVfGwawL?=
 =?us-ascii?Q?nWsMxzh0sdwrNVyOm5MaQI9YtALs4UH5RuW5COZvt6Gk8Kg8WxaWcy+vLbQk?=
 =?us-ascii?Q?rEwf4L/+jrA6AHgPLjXbcEegyoW8/F/GYKb+UyAOYzYHqoH6UjY1GRYnRT2i?=
 =?us-ascii?Q?N3ZRfGvQjoF1TY82KmktSfw+JWzF4641bO/35NQwtKlzbe3tChIPHjw1HWZ7?=
 =?us-ascii?Q?1g+K8qAjQII+t6wTldm/I0+2Pd7ZuIuDaCoqPQNKgLBeg9st5kGYTxtfx5PS?=
 =?us-ascii?Q?6q2ofFAQPESt4dx+9UUEZRvznNB2lYACORO88eMe/cF6Ma96bIjGDk/lZ5ic?=
 =?us-ascii?Q?CvO+cKgdRnhFF9iur4XB0Z70kmFk/VBjJ8nzWKCVemk59QMSbv8Xkb/qIJIX?=
 =?us-ascii?Q?MNQ2yhQxN2gHuvQRWZy7Sm5nOPu2hcP4TVV9/EFIP5E413Bu8q7QBPiUfQKT?=
 =?us-ascii?Q?31+GF0zFxYk6UVQU3bkHcG/ZbauFMJBi+SXOzPVVvGt+QMTrEMkReJwwjz+Y?=
 =?us-ascii?Q?KaoNHlByxZu1GJFzDdgaX0d7sE3FETIMbUAVBessohKC6VTKXIwpR6ARUy3m?=
 =?us-ascii?Q?yRgX5BgN1mFrN6KagKKzDAkQiotwXREu04wkXvsmtHFzz4lSZ1ZgyFe4Sf9u?=
 =?us-ascii?Q?yd0GA+op+bj0jpvT8zBRnuA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 49445947-ad5d-47db-61eb-08de3173c0e1
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:56.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lc4n/HAyVL5A7UFxMG7oLZ94haaC7KE+AOiM3rPV6/EqgyqVaJj+XMyT/+qBmy3LuuPwKpHp7IF38VNrZ6ym3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

vpci_scan_bus() currently uses pci_scan_bus(), which creates a root bus
without a parent struct device. In a subsequent change we want to tear
down the virtual PCI root bus using pci_remove_root_bus(). For that to
work correctly, the root bus must be associated with a parent device,
similar to what the removed pci_scan_bus_parented() helper used to do.

Switch vpci_scan_bus() to use pci_scan_root_bus() and pass
&ndev->epf->epc->dev as the parent. Build the resource list in the same
way as pci_scan_bus(), so the behavior is unchanged except that the
virtual root bus now has a proper parent device. This avoids crashes in
the pci_epf_unbind() -> epf_ntb_unbind() -> pci_remove_root_bus() ->
pci_bus_release_domain_nr() path once we start removing the root bus in
a follow-up patch.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 750a246f79c9..23f0afbfeb09 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1097,8 +1097,19 @@ static int vpci_scan_bus(void *sysdata)
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
-- 
2.48.1


