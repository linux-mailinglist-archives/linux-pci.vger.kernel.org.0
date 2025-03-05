Return-Path: <linux-pci+bounces-22974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E18A500ED
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9923AF20A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD924BCFD;
	Wed,  5 Mar 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RiCPOW9A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2068.outbound.protection.outlook.com [40.92.42.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD924BC0F;
	Wed,  5 Mar 2025 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182220; cv=fail; b=fGZ/k+0hhNEx80tCZpGqgO9/DlDBkHABGWGGbNW4xp4mD0GHHLvfZJlOY+nQfw8Q+VMmSPyTfot1ssMgH4H07EyaxBh3Gy+i96eJm23cJKhEl8BegsrmtVy7AUNX3fxXY3Rfl5q0sfCvpFoK6+T8hwpDloYqP4NP/02aI3NZO4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182220; c=relaxed/simple;
	bh=vBs7eem2n7QnMUbszm51Lc8GRVBncB63Mnj2syxEY4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ze/Zxe5ZYeRUnp1lwmhgPxGREFUQiWtT+6ZNeQEWO78pkJCVl+dni6K2C2JDbElol72Jp5SEEm7W8bFA6M4T2Ub/zjhWucwUk/Nb77FCVxCVLhQwNWGEzl7vWKyUiyBl1HlRzhIHNN0oNctRsh/oWysL5smJs06OQs2zdeucBEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RiCPOW9A; arc=fail smtp.client-ip=40.92.42.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n76ph4qXhV6IOUijqZ5wJBusd4hi+kKtcl/bDINb9seBo6og0izghn2bCgD0aKiSwTaaKGtMnXifB5NzewpZl69ztV+atHxGtT5o+nZc4RYjMQVqgKKC4nGSWJ51aM9duLLEK9s6OAvwMn3P8Q3ObsrWe28Wmb6mGz+WrDtKiG/cWuQ0Ls8YzceacRQgFOLkaiKMxRxy9XMqWBcb4GDh875WDNf6DFWolPxeXTd1/lCY6x88JELaVLYuicAap+4kDw8eDXUCgnubmTgU6m9+2P5ThIzTqjm2BbHpFWcqSWjo5yhQX+kazjxshrpm7etfi7K14fJE/VkhfnyO+RSVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM6iiSmPde0VTkIgZH7hr74laqDtJxkgsCBbaFvPskk=;
 b=vYV7MIPp4oW0KhDL4vIOXE03x7wE6Hiinov4iLv1gGfxVTBJDJCtq+9eS36w/5E+Or7RvCmBCbkxD8dwhIxNJtdYxW2bc/hEcCA+cn8eFf4xbQpBbG8DP1blnHyLtu1MBsapdTjYSeENU15IRQyQ+ZqQZkJmeExCOxbVbw8ImVr3XsMilXaBjwoN1DmBIVQSluD0C6fF8P1nDNw5mIKIhoIFfvKIgzA5iGIuOUmTPI6JlQ7yGzSyLMsBmbcOZYJGjykz5BCVzYyT1VNWmXDx4ogUvsDn/TYTguyF+dYKwQrU/vtTotgF1rfB+gwapqu14ghxHxdjPyAA5YG9VkW5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM6iiSmPde0VTkIgZH7hr74laqDtJxkgsCBbaFvPskk=;
 b=RiCPOW9AConOwS+wOc8jk8SdgRFmr0H1yLo98n6ROcwRp3z/uGAJYdzJZ8ExA+h9+aTdYCtCOKjayarT2LihgjCRJKPvSpCZ8QX+2OFaI5IceJyEdKhsSPsUdFhG2p7NJQenYNP5fZPkUAMZz4uSYeDR/eX5tntTtMLQLb4E1gkBHQONXcvCnPUXqurchvTgsIbe4wtrVDkmWPssV8vJT4Tffz35EUvAMPklK/5zG+cykzndGQhxO581E8rWaH3Lgs9+2G05fNwjLyJNrhoz+2XtaI+YQGjMVU7u+i1xnLGvZujZclucTijaJqtW7MKRlv9S+tbZEvbfOR6M3uKRwQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH2PR19MB8895.namprd19.prod.outlook.com (2603:10b6:610:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 13:43:34 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:43:34 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	andersson@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	kishon@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com,
	robh@kernel.org,
	robimarko@gmail.com,
	vkoul@kernel.org
Cc: quic_srichara@quicinc.com,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v3 4/6] PCI: qcom: Add support for IPQ5018
Date: Wed,  5 Mar 2025 17:41:29 +0400
Message-ID:
 <DS7PR19MB8883AB310FF217F669FE32939DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305134239.2236590-1-george.moussalem@outlook.com>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX2P273CA0003.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:8::15) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250305134239.2236590-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH2PR19MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abd1f8e-ae68-467a-345a-08dd5bebb941
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzBU/AYwvgxHgARL0yqSqaJ1QGPNTsqxGHEcIl+quAqTewJpgqRTwfAAPwjG?=
 =?us-ascii?Q?PXgSZtAAb9qcGX8Zb33DlDn6NuNIAm93YzXc+rXxLP4Iw9QneDUp7f4A/Ef7?=
 =?us-ascii?Q?Haod8rlYTeXEMSnmMtV8cdIv5+DMKhng9gl+d2BC7//NyempfH//UJwwCmoE?=
 =?us-ascii?Q?bgYCuBNeCBNKbEXvbQS+bBfyx+kyhuonr5T4Wrdb81H1jb9qiGHTG/Gwke79?=
 =?us-ascii?Q?R18L+JMYnBFK19/Ob9vMwyJCgF91KXLr5Ky1hlg2pmYVFwAe1nvagH7cTy19?=
 =?us-ascii?Q?ce8EIg0zkB6ja22uiLc8N3xFAhs6c2wRAJuXLSVYxv20AKiJPIOG4weQ1UJQ?=
 =?us-ascii?Q?hygPoY/h8oJcxzhAKV/1+DL191idGOx1rw4Ndh5BwOQRebU58sMBpjb9IuEC?=
 =?us-ascii?Q?6R57lCSD4aP8vOpBbXSzeO77PL2CqBblkTM8SmOWj27WkpBqCAxMJmgsf0uH?=
 =?us-ascii?Q?/WVRzFX3wVBK/3qtO7P7oK0/qLyTB2k407vyntnL8H5ObGvEw6JhaKhh/5Gb?=
 =?us-ascii?Q?eDqvW/3X9aywxpf768PcVoBUYJC8hEN5sxXIyHbjxi5rWjuVIZ2WpptmEg64?=
 =?us-ascii?Q?Il5ZmW1cZQf9ASNpgFn3a5veKSkLBItbIdXPl51UDSMrgsOuAfEaQW1+Ckwt?=
 =?us-ascii?Q?V05LaiaAZ2DD9HDhsUaV3OsrAsxLmhnSC9ufCymsjSuahIJs1hK9jEP9RcQK?=
 =?us-ascii?Q?Qer/TjdNfK4dwdVeCzKwN8mjHaUb4YcGAK3Dnv32DtO6lWockFguul5cOHsN?=
 =?us-ascii?Q?zU+wxUPKQ0GE3RGpM5ulO/GGI1RUrs7BCX9nbwAfDs7kdIg2qfICboi3aTUt?=
 =?us-ascii?Q?ZBlq+PU0Fql4dnMcO5vBAzlB2RAT9e64quTotVpR6creK5pYJuD1iuKUZEve?=
 =?us-ascii?Q?x6A7f0D9nxJQwYRBS1M6AQVNs9wcs1fEBT5ymS3z6ImPdXgLl8cgWS0yEFX2?=
 =?us-ascii?Q?M8nvtTgN8sla4txlfQ/1/HSLUpowTVdULsIHK+HUsOE+pNNKa7AuMGFDR9JS?=
 =?us-ascii?Q?f3GRzwpu5+auG31klOpvLC6tHCW0zL3N5eNQHCrnRFptTT6lgUjkMC5VUDlD?=
 =?us-ascii?Q?+ZFflHZ+f+rAG8WHwyt48wY2a6xg30Vt1idjd5Rm0TwM70OJaZ4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sHNxkzcCkk8NUA1ZByu5gWT9fQaHONGrTQJILKN3LHph5vTVlkpkDHTms3z+?=
 =?us-ascii?Q?CuKwR/880SyXELy6hivqvHAfzqsPCFmtkGXdsdIsYygxtnpABEYwhJihQjtS?=
 =?us-ascii?Q?SLfz45pa8ZaFknmP3HiXeOzAl7TSwMMiV8MgS8ECvKulVMDzLRpjyFydVRkg?=
 =?us-ascii?Q?GqGC+XWFXzsSSwsIuYPNJn9UZSlxhV1zG1WmN0sqII9VlilORJZXd2j+MJcB?=
 =?us-ascii?Q?pqGroEBnWqnH633Z+UKcgF2MqAsp473Ptw2IMpilffm/Im++4kyrbW2vLacm?=
 =?us-ascii?Q?6jLYzYf/EJUHO6WAGmrkfUUxwkI9CL4ULcND13hAJQ7tyvzFXnX+6p6tygGv?=
 =?us-ascii?Q?Hg2BkIwEvmBVbhr4SNBpKuUJu4Ytco84IKhGM9Q4wxoX+iS00iMyd0dCSsys?=
 =?us-ascii?Q?S7asuE9QVSThM1l2S7eJV7R2+JkBlnFYNk5EGbhrSl/U5mcJ3O9MkxoiDiVT?=
 =?us-ascii?Q?9rCFad3L0SkDR5yCojvlq386FHNztWlY8X71l572vAWIA+w/C6wwHJ7ogceE?=
 =?us-ascii?Q?9FWkdSnTOi0tKlP20/BLfTpaDOnk9V1lv2tTO+7f8hDp825SEx849Z4lAEOf?=
 =?us-ascii?Q?PS2gFV9UPsj9HxG3QyNrOiHkMsOojnh8xYz55tHswPIMevQ1zV8mDDt4/0b+?=
 =?us-ascii?Q?wtNMdLAz1t8ycKnWhBMKbGLogXj62Ym0v2aEfaPliWmmFTJJT+o2VkRF4o1t?=
 =?us-ascii?Q?YFOK/wfz5vQKYUePTPQitHNaHfmfpZZevcBmBkHUlUEE6LMoA49hrmBQQcn6?=
 =?us-ascii?Q?7KvN72uzxX9jH5X/i0+3IPgZi8sCRncl8Biq2MkU8W9wuj3gV5aY9SmODG7j?=
 =?us-ascii?Q?IOzmy+LayoKuP5wdIypcb9k0DMd8yG7Jdn4/6QxMTzH3IoJ8Xu2wtC8DPMaL?=
 =?us-ascii?Q?fYsY8rwpfT73RSQWNutfw7RCbJLyY2zMP8qNlBpHxqmtUMZ8/OJ6/TujsCiT?=
 =?us-ascii?Q?Rbtd/Vvrbs6dm/6T1bHaoflpLVFXFlDiJazClJVltqxKv+lAfdRAqEuzzMKl?=
 =?us-ascii?Q?YfNrvUsh1m4L/kM9RRHhzYM8C6JBcQCpRavjr4sh3QpD+E98RNnwYia2Ls9a?=
 =?us-ascii?Q?VSQL0GcPm+eHQIDyFkkBa/Lo20XS/QXQ5VEqA1VQT8Jgcd+qGDLhzM+OSC+0?=
 =?us-ascii?Q?2LmM1zNWxL2+KjuwJ/umlc+n7WE8mF0E5qnp9RHNsz+Ocm6WWJbr3rRuPQXM?=
 =?us-ascii?Q?N/56kKVAMQg34PDjOKSK5BDHk6Dc0ZTdY9k44fkk+CuX7wr4uQVZQEVyHn3E?=
 =?us-ascii?Q?fiB7PNXM0na+QvgrYIB4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abd1f8e-ae68-467a-345a-08dd5bebb941
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:43:34.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8895

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add IPQ5018 platform with is based on Qcom IP rev. 2.9.0
and Synopsys IP rev. 5.00a.

The platform itself has two PCIe Gen2 controllers: one single-lane and
one dual-lane. So let's add the IPQ5018 compatible and re-use 2_9_0 ops.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..94800c217d1d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1840,6 +1840,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-ipq5018", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
-- 
2.48.1


