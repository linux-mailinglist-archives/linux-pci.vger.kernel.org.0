Return-Path: <linux-pci+bounces-44930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCCAD23E00
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC3983099C53
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A5357A25;
	Thu, 15 Jan 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="owZD1csy"
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013073.outbound.protection.outlook.com [52.103.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19E3612CB;
	Thu, 15 Jan 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471998; cv=fail; b=divfL+vTLbKeHuHEaYZNpIWPDzbOA+5+InA7DD7WH8DtRumsIlS7TedlUy4hxHz3hFkBKsacZpa3Mh2vLJ9cJEBYOixhUWcFZS4+Im7z6cQmgLLSc2TI/TMz7UgjX/ZDByW5K2gJvg12zhXgdiJtzS0PdUQVunnDcfAI/oz5C6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471998; c=relaxed/simple;
	bh=AzCYgEzdPYf5Bd84r53qbW/Kozt0kCDQkWWN/o2VUJI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F8kYIUBXFQhajLuZE62cR8/ZfJSKJwroAcy/rC4iWpOUfsSob4ounkjPy0lGTZb8LuSTI6SX813DfhREPsHqdOUpehATxdafXGTmhon8/rSaXt2eC44WHOzFCUcBmZ2xeRYNHdnceXQznjwBUPgABr67D0X2KBa4gznjGroRkPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=owZD1csy; arc=fail smtp.client-ip=52.103.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms2YVBu4RfL40OzJEuJepfs0GunBud5qrskeWUO0qcIAzzISMbzjG1td8ZsFikfQ1rAhMHS0HcR/yAMeAudrffVgy2pOQB2gNuKb7z9QZHimW+fIbR5znsvp3O8XJvndALmxcioA/GZKyWdiaG+9lZLwlp5teGTuVU/YXDjP4I2ARoaJitBSAtzwDeMfKo602xS7NFmzgn/YgXLRaEH88+gWZjH48bQ9Db57fi4TlKcYIdg6i9S9/HUMZo2k9qubcPv7n77BnyjKTBrfXgUueKO38MNFFEZLnTYCDNvapyE1kSH46EV7nKvD38Nk8EFLgYGaMs4UeJY5BlNN68cdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxEHC2vcNLJYzq0at203b/qg3FDeKjbGPizn4DEj7M8=;
 b=g8cp90Ucxdgrr9f7CdN8WgRBTmGVY+GKn7WTHy3qpRFLKUqWdGDxGzr0W2RZkt5IaZLZO836dgDbLf76bTLjatZRkHQVvOYWUh71ApbjKljqHPo47HBYh3On0F/7uNjYyYXLBCKqFxmapYLOTSW/suTZflwzsRnLDd5789uPdSHITD2bhbXFTJpiZPyqUhK8yWJpY5JDMDTgVkCjz3hwIIpPU9yMYFLWLmS2n/gLnkzH6lFI8LuKjNV9DaArIhp73gwSC27+CkPVuPC/yg+Dt8xaNnouXL64CSRMtpU/H6W3DGfO2jwI+EYU31jk7VjC4GT1CUslHWXNKD+0XZicHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxEHC2vcNLJYzq0at203b/qg3FDeKjbGPizn4DEj7M8=;
 b=owZD1csyoSsvUrlrjZMIFrx59mAaCL30z8Fz6ki1WApcSeHDtqo954qO5uswrJdfyUUAzObrJBLNuFLijZCSHdfnoWTbfyTmdiMGhRh2POc8/emLbXCMZR3gOxIVVu71c31pztRvuZY76NU5OHNUmS0PuyADb4pvwEq8WoLyJ1GBLBovTIfwmWscm2lLiyMBql5EdmEgxvg+VQbrG5eFgypEijiUs3+lIquAlpb/AT/XjWCvgx+RAPBCb1cHxYlUiwqeHPAOqnMa2ZOy7oCCBBGM/vYjIKUlwVny5E3rPnIN3yGcEQ1+TNlaEtLjsgK6VH48rlymxvv9NDck698XuA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB5129.apcprd01.prod.exchangelabs.com
 (2603:1096:400:338::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 10:13:11 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 10:13:11 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	jgg@nvidia.com,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v1] PCI: Add support for ACS Enhanced Capability
Date: Tue, 20 Jan 2026 02:11:30 +0800
Message-ID:
 <SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260119181147.312141-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ebf296-2fbc-415a-758d-08de541eb004
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFAyHke/CE1Ui/FW7barhRQEVjLapl3uQ+9XRABt1eOf7M/rJYNNIGTDafIAJW0HL17Y+eUZRWyYzqas6Skk+XJuyP7VLB6QQKOHUpvIgY9fqujikpVjCRLG36sx2yO/Ye6KjZjVhax/+pL/cudUx2hl0VKeUV+jnKzBDYeGoyRi1PlCidfvUWM/483IYpB8cAjGo2U36WqmdNyngq6L5A6e+DUpuSXAslOcnACSG3WQ2O6X1FQbyuCgBoE01/nDEr3jW+9tq850e9kLevw+6bTU56eV3ZShSLZG/dIcqOTZ+0+dDzwg19MbuzBwMLBhZ8BEbk1I0qu8OBeIVK9u95owrg+xD9YsS/DCf0WLlh5KmHcznUYQb+vlrXKxEOyjRBqgjpEbnuTKvPs7tHWhT6S0e79QbdT4r2peTrIC6NuaW9igi6/gDKj64CzOMGlCISRgzbBu30/zEIlwCeUMDD+T9cYE1ycvcftbcWiDozyeykM7q9KOoMBJUIQaPQaehbBGmxcaemMleaQzgtmL0agXimPTraIbuU3HxdtN9uCgb6RKXGk6qvuTzGITu3o71aqqLbOQat0YQtedGxeBSsTwW23mkAqmLZ3uvVB63JciP9SgSOms5/UnDHD204oiRkh13vKD8Z2i6jwt922DaJC8LUNuDSTTTh4uUakiqcp5BmZRr10ceNC94SjeAFsvtt9lJNVP9xM3rlfUo+FLa6xUatBOsK8ko74nrEVYGgyolg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|461199028|6090799003|37102599003|5072599009|12121999013|23021999003|19110799012|41001999006|15080799012|8060799015|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?55+itiGEK+diUco41CXHtMEdA5kIuUbsYAb1oyIEbzPvhQEtJa1Voh2qpc7e?=
 =?us-ascii?Q?rH7GB/TVNAInhnjSatyGUFX/XuUjITzsnu9Bd6Cfxdv005O3ZMwPgiFYj3f6?=
 =?us-ascii?Q?fZBttJhuu2aT9ykVp3oUDFEyO0NHgnGhvixg4mREBy5Io39Npxx+EhLBQKCJ?=
 =?us-ascii?Q?zhIHgyMsXbGo0h+8jyWdeaQF8/XS0pl+jl5eWKb1TQwDSklPdhmj53SCK97C?=
 =?us-ascii?Q?9tTL8+vBB+kJCY6hVwWgADZ3PqEdu1kPJvSDWld74EI3iSTjQVpmuFLJmEFM?=
 =?us-ascii?Q?puLps60AjIBoWayB8NEXvjhoRjBJuCdgCqmPca9pFNvX43cjKCgTViJ/1pCn?=
 =?us-ascii?Q?KPE7JOjm0FA3rErmqo48I0TKNtJnt67A4JP1NcXOEs7x0PxTINekaKo4xUR2?=
 =?us-ascii?Q?r1k29Mt0HNwGvKZu812AtHYRtbZb5TiYj/MpA9btEu10+3PpOB9PVQ26a3NT?=
 =?us-ascii?Q?Vp+N9sDD5wg74Gm8zhPcSTvaAhglcqT0alnB9LrG+4WxFscAwRfkcgW8s822?=
 =?us-ascii?Q?f7ybSHEAVgt4BnnUHLOK+9q7K6GX+UZkZyccWutu6HmjEJ1U1xTcjds3+qMq?=
 =?us-ascii?Q?yOTS+T77UxwStLsodjCwFbf2d8J5QdLkrya2fYl/iypDLYAKHqZiAPF87D1D?=
 =?us-ascii?Q?DnmdotJiNTb9tZDOdFgDFCh9523/wzr6vrEwL2jGkQRVyfH4+wVZXbSQfyV6?=
 =?us-ascii?Q?EiutmkvQqdSKmdN3ncic46stImBzupPcX9LqOhMU0/+KWyqN1DsrRi7Iif9S?=
 =?us-ascii?Q?KjOs0pmO6khtehG6TPI4uXeeG7+EAEo9KcKsY+JmoQvpN2Y2oY2Tpf25Wa+y?=
 =?us-ascii?Q?DMsD1UwYPmEygzW+oG/z2JDwiX1RVdTGVI3aEiC1NETLvjnIycq1XO2LVsTa?=
 =?us-ascii?Q?RfZh80E8OJQbNtlNYOp7zqpthOEwsh0jS6Iti/dn/bj/nHlcAmka0fbH+/hM?=
 =?us-ascii?Q?QtFIBSKFvh7yqULsHxW9/pkrKyxHGR6Vz/cMXgpzm87uesZhYR9MJajerZnQ?=
 =?us-ascii?Q?DZdkbA7CzMsmJZ0ZwjI6iigTop3amNypCY9wYAUVfP9oU2f0C12Q1zERRGrt?=
 =?us-ascii?Q?mlgAWkmSyToJgRNfz1AzHRxmzbw7uO5TZ6jqB5kg5Jq2aXfo3RBGGD3utxKU?=
 =?us-ascii?Q?HK9omdoXPhIW99EOayyWtARrrkWIXPajgGaBx4OCzw0t+nMrR+kZDK3vbtfl?=
 =?us-ascii?Q?T1hCSYQ9M1e5n0Ww7XfNgnj+PQ/FCHGA8vAqj8+3hRrTu2YfU6PlpAzAG9r+?=
 =?us-ascii?Q?9Jb9hdaWHFCEW4pbDe5GW2seLenHQPLoFyfQVuAjD+sT3LOeXYZXpFlrCHJH?=
 =?us-ascii?Q?mssaJ1f7XUf7T1kxMB4StdSvdVTrPqmJZ1+NL3f2rUomESrWpaWqw/YHA50d?=
 =?us-ascii?Q?sNQcNNU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fNHvNk+iyWTOMe0lNqRnn7R8rQpWGYou/vV2/VvgIJUIte4w7vf7cwjhLxXN?=
 =?us-ascii?Q?WD8euR0bRWaAtYyT8RwXA+jlb/95xAIG6FJW/kZ13j6DakWm26ZT5Tcn3EVz?=
 =?us-ascii?Q?+ewPulQJTDzQHHbi+qqiCirj30doGO3zqSVI7tOI3ymuyHfxdoP0O8/OXwGv?=
 =?us-ascii?Q?CB/Y9RWO/7lLLErEZkaRxql8Pu4kKRgE5ncX6moL0MJtztH6MlXrRRNkTMfZ?=
 =?us-ascii?Q?x2JZN3dMdp2wtvjLMDFzzhWT/Nxmgqe/ZlBLBiVQsj18Wc4dpw/IkDjDY102?=
 =?us-ascii?Q?lWDr4+AbGGPpNuTKp3tS7BZouAZ/J5EbH9VWrq3uy9HFnZvnwA897N9Db+Qj?=
 =?us-ascii?Q?nCucJZPP9xdJV3Pi5yTsraqAe/GZGlPSERLmWh6i43yaJf6C3goIovrCMeia?=
 =?us-ascii?Q?r2HmXpY2Rxxvxrv9f+f1psmmyepeIgYee5u7q1SuAH9w/5PyD4rOVpZdLdEt?=
 =?us-ascii?Q?TCxFzRZ4/JKlrFaxVrwU/UWdkB2zRYJQj+UJYOpEhWF+mNrrMntA9KtxAXcR?=
 =?us-ascii?Q?dETj9XI74zsUuJxZBa4NA21UcCs1o9Z4hv10vGxxqBfucb/+7+nAz16IHQrk?=
 =?us-ascii?Q?LdrqWQJqIifXwrEz8cPpiA7RrVHPkPdge2VkhPw2QawRb0qawCSR9Pxzrt5S?=
 =?us-ascii?Q?7Fa8jvYTBsZ1xxqeeDRc9q6vCzLukU7ZWFp6ySmwLpFW+QqeqFemzOycxCEX?=
 =?us-ascii?Q?AGiI3BziDf6nCnaEVwPTNY1xOcvpzsDAogA21VuGeGsI0hi6FWtJ2k6Siibj?=
 =?us-ascii?Q?fFRwxu06WaO9iseCf7cuTZkFo/Ci+Ine7lRdkk2KOV6Ji0g2IFSOTkwhazHU?=
 =?us-ascii?Q?kpcW4qeBysXJE5xVc4Hs6wG6Hpjz+C0FWoAI588ydEhHfFDW7bMSHoJCbiVP?=
 =?us-ascii?Q?hygkAdtOoxxUZtgA92YNRUiCEY6foj8KofYB4BDtM9QiULvi1QlJRnVySeYK?=
 =?us-ascii?Q?QL6d/PDhXUX2ds3Cuu2Zulq8LRYiycif3JBWzAojz58O0BVvE8ASgbNGbCJ6?=
 =?us-ascii?Q?pTMC3GQIhPPqGh58tsV8Mge0ae2vDMJ9jOsMYOHJyLEdQM3WSSz7JpbET6Oj?=
 =?us-ascii?Q?OSma+bjYDUOIsRxgBzXKIO8cy2IWlwzE7TaUnXC/lhsoDRpoYpVJqKfHVMSB?=
 =?us-ascii?Q?N+fhNHTfpF72Fb1OHFOwlrrJ1soHoMZTnYPonrRmfvpIcbnOSGtDhpVFSYQo?=
 =?us-ascii?Q?nuWhSjN0BwPUo/SJE0FRi1rlZxzl8U32GW4DhLHXsMkMS2aodsxsprj/ipPM?=
 =?us-ascii?Q?m3oMQu7d14LgXrRNHmnqmfMiMzlBjq2FiOhgZHXyNlUQ16+gFTk9oXC22oWG?=
 =?us-ascii?Q?xX1DS87LwfDSM4Npp+p/i0vV7ywpEY4q6dHHU1d5KKHl4aP8f55Dbl6Tg2qN?=
 =?us-ascii?Q?W4m76Ze1o2PzFQd/KnxUjm9ugcQe?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ebf296-2fbc-415a-758d-08de541eb004
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 10:13:11.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5129

Add support for the ACS (Access Control Services) Enhanced Capability,
introduced with PCIe Gen 5. These new configuration options can be
controlled via the config_acs= boot parameter.

By default, the ACS Unclaimed Request Redirect Control (URRC) bit is
enabled if supported by the hardware (i.e., if the ACS Enhanced Capability
is present). This setting is particularly important for device passthrough
in virtualization scenarios.

Without URRC, a DMA transaction from a device may target a guest physical
address that lies within the memory aperture of the switch's upstream
port, but not within any memory aperture or BAR space of a downstream
port. In such cases, the switch would generate an Unsupported Request (UR)
response to the device, which is undesirable. Enabling URRC ensures that
these DMA requests are forwarded upstream instead of being rejected.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
 drivers/pci/pci.c                             |  7 +++++-
 include/uapi/linux/pci_regs.h                 |  5 ++++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31844c70f8bb..c6156a50b249 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5249,13 +5249,22 @@ Kernel parameters
 				flags.
 
 				ACS Flags is defined as follows:
-				  bit-0 : ACS Source Validation
-				  bit-1 : ACS Translation Blocking
-				  bit-2 : ACS P2P Request Redirect
-				  bit-3 : ACS P2P Completion Redirect
-				  bit-4 : ACS Upstream Forwarding
-				  bit-5 : ACS P2P Egress Control
-				  bit-6 : ACS Direct Translated P2P
+				  bit-0     : ACS Source Validation
+				  bit-1     : ACS Translation Blocking
+				  bit-2     : ACS P2P Request Redirect
+				  bit-3     : ACS P2P Completion Redirect
+				  bit-4     : ACS Upstream Forwarding
+				  bit-5     : ACS P2P Egress Control
+				  bit-6     : ACS Direct Translated P2P
+				  bit-7     : ACS I/O Request Blocking
+				  bit-9:8   : ACS DSP Memory Target Access Ctrl
+				      00    : Direct Request access enabled
+				      01    : Request blocking enabled
+				      10    : Request redirect enabled
+				      11    : Reserved
+				  bit-11:10 : ACS USP Memory Target Access Ctrl
+				              Same encoding as bit-9:8
+				  bit-12    : ACS Unclaimed Request Redirect Ctrl
 				Each bit can be marked as:
 				  '0' – force disabled
 				  '1' – force enabled
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 382ce8992387..3744d681bcb2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -948,7 +948,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 		}
 
 		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
-			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
+			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT | PCI_ACS_IB |
+			    PCI_ACS_DMAC | PCI_ACS_UMAC | PCI_ACS_URRC)) {
 			pci_err(dev, "Invalid ACS flags specified\n");
 			return;
 		}
@@ -1008,6 +1009,10 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
+	/* Unclaimed Request Redirect Control */
+	if (caps->cap & PCI_ACS_ECAP)
+		caps->ctrl |= PCI_ACS_URRC;
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (caps->cap & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..9cbde1ebd14a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1018,6 +1018,11 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Ehanced Capability */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
+#define  PCI_ACS_DMAC		0x0300	/* DSP Memory Target Access Control */
+#define  PCI_ACS_UMAC		0x0c00  /* USP Memory Target Access Control */
+#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */

base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
-- 
2.51.0


