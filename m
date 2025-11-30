Return-Path: <linux-pci+bounces-42332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FE9C950EE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D08683431AC
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D692877CB;
	Sun, 30 Nov 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="caTv2hyu"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011051.outbound.protection.outlook.com [52.101.125.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AB285CA3;
	Sun, 30 Nov 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515480; cv=fail; b=I20sWwbtrEc7RzZ+vUniUGEJo8qRRKbzlvq1JpkzjZk+8s8O2QUwHsu5FvZWQ+WjIsozeY9hszxoEdgMPhQRWpZ/Ym+CuaDYRouhgnoH6oo9DbCFPr00hnhqVT6H78D2PR/cYTjBG9E4x6cA2Ps46ctMiXk+FUlVuDBPZIKx8Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515480; c=relaxed/simple;
	bh=h/I4zfZaV0SBGXfxmOco9smNG6ZXKd+B8eKMWZz3oQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJA2EKP519iPZm7TPGOMok3VuvdHphJ/2AOF5izCwC/CrGzii5MpfvoiQriEEHrcFH4SyDNLzpWqiaT0AtL0b+xpQmh/mLrEzkWURB1FoTbmMM8hZctPvQoVSclggI7fknNlWUaA33dZTUi3cmCbJvt+6beoea6c0PDOsIFj9x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=caTv2hyu; arc=fail smtp.client-ip=52.101.125.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbFxmr7yihjqSTQelAHTBQDDx0fmLLIsueCX8w9ED1TbZk1bCewkF7KFKTahCYPhJjv3138tJpScVWuynRO1evkH/Q0aDsG3qrifdWutpHU/J/qwoI1L2DgCyyfjbFThujEc2fosHXV654O/oG6IbNjHWrUqPWFfeSRrkDY6aX/5ZY49fSqwYsXFxoJLDc3/HlMnTUyP7ssey+0Mk8L4irkwD1EwnAoAQelIRQJJwNG2kcqtfAGsrtaDqAUXzpivsbJx+pCll0K4rAB2JizzEUbdFgy086HxB7f+RV7dIzuui0lAgQa35Z5G1GRwlqA3IPJxa8Z6X9oJzSaUiLWrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDbpZijf/VnOIP5EHW5yX5vN+z8BWR+/QGOjMuYR5A8=;
 b=KX8+NIxq6gnqJkRdzfF9BznqwbCIKTwytoaRigi7LDRwL0686wYbwARvRl0+1ruLEW5lM5poNAcN5wYXHGbp9l73rTyzrbuab7/vWXZH+puZeAWWb0z0KlwNC97F6nTKJbW2Ve6eSyy2xXFculKbkm7VQopSJMaSXFUGtseO9hShH0A+W77yEuIirkcSlcseR3IPfR7FmdNtIJhcgbK6hBgHyvzsy5pz4lwNmHft5N4rK4A53SSoyp9aqvsMqdlxOJxeZdc61Kcf+QEBvfDmE+iBhwmSlWh25HlpjzBphEseGgRJ77N5qNtb+p+x2rhDfJ0aguAqhISARf+Dr6uH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDbpZijf/VnOIP5EHW5yX5vN+z8BWR+/QGOjMuYR5A8=;
 b=caTv2hyuepmzMXwZF/ygjt91bV/fQxXRSIWqR9aRcoxYSoS9et+wl2Y5na17T04qPAfp89UKlNAV3nKFhT8Jzg+059wiaccCShEwY0B3bmEWMsbAOy71+u6Sv6IArxX88D1+dpAnoYJFTsaSnqF/fYhq4m9oIXO/nteh1/9+os8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:11 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:11 +0000
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
Subject: [PATCH v3 6/7] PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use pci_scan_root_bus()
Date: Mon,  1 Dec 2025 00:10:59 +0900
Message-ID: <20251130151100.2591822-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251130151100.2591822-1-den@valinux.co.jp>
References: <20251130151100.2591822-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: d80120b7-9320-4bdd-c467-08de3022b25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCrPNkUTwNTB7xJIxaufZ49G4Q3rnjFy8emE98kj1rCdHmZpoYmyZicSV7U7?=
 =?us-ascii?Q?iEiE/L3D4swHuY/or+3R/InBEfJvzVf0avcCDQHYjkuF7xfrNFCn27tR+XXX?=
 =?us-ascii?Q?tt8sdplOXm+0wGf1LTswE/f/aovxHBnx4EhwDi38apjlwdrvZiSMS/QmV3f8?=
 =?us-ascii?Q?Uvap3r/rpdUTjQ5EcnHjKWrCEewozZRf1QsKmjhRIaJIz4fDL6P8xvXAlX+z?=
 =?us-ascii?Q?XBiSOklp9syRrji/oMHXAVkX7msXpUm8j13DhtkziWG29fb/j5dwtmSZncSi?=
 =?us-ascii?Q?Q8nCD+mGzVdmKCuuafCpUbaXO9aYaxbKQ6xIzGru6t5yHtcGYqurzqAoXr39?=
 =?us-ascii?Q?H3fZG6WMRVVsBlhfVEkrjap1onG2WU4uvti7fVdBLeBp+OmJ5ALwOI/hLp4z?=
 =?us-ascii?Q?IXEz38nj5qr46ZRB0gohsvuSaYgt5BdOWZHjAXaNVTFVfMT4MDXNfq5mjpfo?=
 =?us-ascii?Q?LyW3oT1AeCjoNCIyG8YUws310colQySUCO0058R4wigiY3vO88cX1qb7JwH5?=
 =?us-ascii?Q?0Wbu9Ui4H2X2e6gd1qf/XzBBIooE5HesAfN8wwTR7hjDvTpe1+El0FBjjcNq?=
 =?us-ascii?Q?LxUs+GB2ijSS2Qw2ZzCjz93wMeewau5aJmcAnfTRqcSt2HPKQjN7QI2cjUHZ?=
 =?us-ascii?Q?kdJUAHqdCefnPhOXPgNw7YLpwVDN+wjgW+xSfSA/do+cTqkxE0AGJXW2ctH7?=
 =?us-ascii?Q?dd06VGzA/rEtw+H2DsTm7D1jP/ZBZ3p9I2eJtfRNPFkgWHn4yKDuQpDFjYq/?=
 =?us-ascii?Q?j0aD7p68hmVYnGCBKPUQpKmg6gWF1ZRwM1wMtB+5VHKVbEZDVIzKXemc2cGV?=
 =?us-ascii?Q?4sNDU1Dj61iUfb3WvsE+iQBwjlEG/O4lmoEl3A1pZ089jv3eF6Pxe2NISQxz?=
 =?us-ascii?Q?1FiI1hTlS7NzMfYa/bF7mr7AlXqHOWFUECaFl4I+JYEi8oNHTqTXHaYbqcmv?=
 =?us-ascii?Q?FhR4VFJcKryz47clhU871PHVrM/AaQ5ku6UC06ZeRLqVcqpr4+njskEJ61FR?=
 =?us-ascii?Q?nm6CACRQM0L2LBjFqPhUi7HnwIGbhB0hpNDjNPEZDTXFL5rLty9zEjQtbOB0?=
 =?us-ascii?Q?ZNcRy9l/z74ngd14ZPqQt+umuOKA9NrY1w9AoPnLOyHwAmh98LjaAjBE8eHg?=
 =?us-ascii?Q?yZoWTXsPTOy92ebXfQ/fXgFu0UwQogi8NA7jdY2MKKTJyCDWd4m5JojOkbEG?=
 =?us-ascii?Q?B4MEdNA8hupSLNRRe12r+Ax+wVU3vcHAwjXgbfjcwoon/GO/3qDDGheSnzx2?=
 =?us-ascii?Q?eohWyIykP1SmZ9lJ9E5ACZz0tk+A8LAt+lyTPcgNTGFZeLLzHp39b5fkW3kh?=
 =?us-ascii?Q?wGzbAtv8PlLFp98Gecn2Xubz5yijU1BW3BnH6GsrbhwzJoUlYKh4gJX76knc?=
 =?us-ascii?Q?Mm5vG3RGC+Szk9+mZBq0m3Kf39e39FBO3bq6sJB8AIV7BqRrNpvZLPoNXK0R?=
 =?us-ascii?Q?qu66ncl8hgcgw4iUB2kyZFunKPHXT7Ew?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKu3IR2Ca5kp+mC0k/VtnhdnJdYuzCAzit7UEHhRoAIENVdziBKUWBFHLrs4?=
 =?us-ascii?Q?c8UNqTA5qXYtchZnVwQSi1753l0Quw9ZIrD4v8ttMK0Tk+8OooJf6vfP3OpH?=
 =?us-ascii?Q?OaOZdQIFPe8XdeSX/+0nNrHAKEVUcPEN3PnqSeXL6hQF4FysVQj0mA97s+Zp?=
 =?us-ascii?Q?F77FS5GpzwMAxHThokOJ1mig75SyolVfpoLXwp3kleAQyOr4fSCMWPrRaIRk?=
 =?us-ascii?Q?A+oZt5uMptUIQYjYuV4HBH6xIhzIMegRss4BUfljVSM0n7E6ycEvQpOAUdz7?=
 =?us-ascii?Q?mRWbzvCJIm+/N4xle+07UahvL1lEE2kI04tTf1kimSayx3ZKhh2OnXqQKTko?=
 =?us-ascii?Q?0gXfT6R8f5bRAijuoKyoNAaCtBV8GBhqx40wRBVg4GS5IPdNV7fKmdkqfETI?=
 =?us-ascii?Q?pMkLKNGgddRQElr4/CHfyVtbclG4lX8hSmjup0gMalAKWc2XTMxWw2Tfyb8P?=
 =?us-ascii?Q?qeYkZ/6DfZRjV1Ocbnx+Tq9DW9yOek5eaGhRV36aTCahXE6mD2ZRiRl3G2by?=
 =?us-ascii?Q?gTcLR07kqKNy5+q9M77vP7+vGFBlUfHb9OfuOJKcU63z7zBwb4NMLP/pDKok?=
 =?us-ascii?Q?lpcqtdFTXzW3DZENzyl45X1HEWzcYm5S3j7FtkhmFxx2NOWoQQt3aNj+aHQ+?=
 =?us-ascii?Q?q6TdbSxoorD12n9n89rK6kLbOufH7EqveeTzTCXMw8q61wGzog5K7DNflE30?=
 =?us-ascii?Q?hXVPXtCZ1nnBPJSpUaod2SIxXeT8kVX6iYW2MlAF/hi/1fpyvg3NPGie+Dg/?=
 =?us-ascii?Q?RAbKCx6BEfEICcd9vbB5n9MjJUTuBaa5Lc0lpFJXago+0TYoSFgpFHcvv2A3?=
 =?us-ascii?Q?DdgX9nydCl2PWAvLW73fZ7pdNuQP2uVcyKoqUTaWAbttxuF2Z2/Me4QL1T8r?=
 =?us-ascii?Q?+giCJNggd/VbIPPKq+KJdiV9NeuZirYe1fPu4cl0uGFKhZarNwmL+3F8uMgT?=
 =?us-ascii?Q?Z2QJHdrCDCtuK+SUA4Dd+L62LPuTFGRZoxP2GV9+7rngsbFSruPxd1/jR8jn?=
 =?us-ascii?Q?CByZqnnw3YnZivZnQ7qDo3N/1vqdUVnbIO6Q4TpSc5bAHQvRi2I1FjitJx4L?=
 =?us-ascii?Q?xPF3zgOXq2sEtVebf0zEjqV4JJiFzynA/WpMuVRHfY3jRj8NNBVLrmWzNSK+?=
 =?us-ascii?Q?B2LoMxse1XXEnGgphXApkR94c8NFCwiaMzMtoSTYLZYCbletFdJ7qXtSMxdk?=
 =?us-ascii?Q?kQblpI4IwQ+FhInuy4zG+Zz54yRnSkUpI6RkXPk8RWEC0ozDYw/dr6PDdaRd?=
 =?us-ascii?Q?cUfXs5RrGZ/lI7vPqoPbSd3Xoxnz4JM/lLJ+6xuT7sgLsP3Tpiq2YljlpzsV?=
 =?us-ascii?Q?ruNVingUQiDB7q24TadUEM+dYJwLhZ+6olGWewaQlgJ+wIkN7vCIm+G1KZJq?=
 =?us-ascii?Q?aSbuGEQgJ5AKWlC8sfADM9jX7g7vdnpG1ygcs/q5CDtYus0XEIA/LhporCfj?=
 =?us-ascii?Q?LUNf2Nc/fLWSNxC995DaS6uF0+BdT/W3qEvVICmn9OomDHxO8kYqcbN1leya?=
 =?us-ascii?Q?/8HnNbkUuguHyfCn434UZZs6O1Ha2KW1QIAyaGxn3XKpRqh4/zcxxlYTEc5y?=
 =?us-ascii?Q?BxZDOHfLNaP5B48ZBKH03mnDU3BhPk40EaKCUivFopDVQ3Ag/vcPyF10O4sG?=
 =?us-ascii?Q?/5QzcPoLTn0NCPRW+nJz4K8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d80120b7-9320-4bdd-c467-08de3022b25d
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:11.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTBVZFYU4P2TaqH4etZQmY3gS5+MuQ95ZF01TFgkHn19xswlw+Lmy5tg65USMHZaU3Fvc3CfTMf/ECdsl+++Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

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

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 750a246f79c9..af0651c03b20 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1098,7 +1098,19 @@ static int vpci_scan_bus(void *sysdata)
 	struct pci_bus *vpci_bus;
 	struct epf_ntb *ndev = sysdata;
 
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


