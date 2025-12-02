Return-Path: <linux-pci+bounces-42460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29736C9A6F9
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34F53A6760
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC663043B2;
	Tue,  2 Dec 2025 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ApicSrYT"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D8301706;
	Tue,  2 Dec 2025 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660253; cv=fail; b=EUJpOxh8hdANI0qP5s77f8sfm6IxbUu69T+3KeX9nnB04qfaLGX0P8h39tq3j2UwvQjoxqhmIsEvoErxLyGOO0yAXcf+Dqg0SgXf6V34nMyjfLVMEvJr+NRzFK6sCDCPnihPur1hN71zL1q3X5IFLXso32opmJBhrCb5HxcwtxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660253; c=relaxed/simple;
	bh=FuXxBBr6MEVMSgbKuDtdOFZZVkypi03ayW0buVa/Rr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Al+IVON/7lXHfiJo/IWKBxGIRp651jKhRvwJFYoQfOLsos6+Ef6839AxWZ8YPq0zuwZrhHYa8UrY2zpyXo56AgagjRVNkTYTdIKiUuPW0jdqxTL83LZxPTzrCBOu4jlKvZNL1Lk9AZgQc+S9STf1V1wc3yF9WAD3tsTnJWoALNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ApicSrYT; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suPfliQWF6HtKU/QIzB7QC23fKT7bqGsdE6nbQDFAOcXVHOODsZyUX8rUsEvxNDSiEJ2khwbi23B4cnHR6ieHVpKteNJOHMV5bGojfAN2zpaB6Mn0WULPGWeM8Xs/CwX46YBB71fnfYSfVOWalnpZS6VDELv9czSID5NK+fkaW1jguV8K4Q8XAfTSoQmmh5bqbPVBEBxtooRbi8eQxYMngpdEE9Y3e1cCqdzD5lNJK7cdwrYiFMaCUPnqJWKCnswx/DrGpmf/B6suW2voXVV4cQelSRkaxz2/VfPKVCXc+sUSEKHLzmM+RQERDYCIU5NQgRZMjXk80fZOsELnSPnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAAEl7edclKA5q89FHqJZUN6fLcsfoUjj4OmOmzc+i8=;
 b=bID+Cs0DkmXB04isntIwnUyuLZfsj9G9bjYpKrnnXk5mPthVYioR0bH4J921/2U7f/aMmQk1NTJZHnJGr4QVLxtIH98Hx4sQ+IZcXdQ1oew6FLZb45EEIhQFxz5LQ4SU+WH8AenH8KJb0XuEoEN7L+sEUqObufLANMd2oq6xeGpeB0Pu8c6XeUYR1+0mAIjr63z8Ze1Wf5mK5G/XrJj+lzDrf14CWw+5EKM5spu4g1rG7MLsGjc7ob1evhneeP9bXINdR7cO+wKWA9RPa+iNMdxETd0iQvZPSvwWbSQijcRRC+WfsC5h/2/N3DUogW8bMrcntTE4io3p3vsdtY8TJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAAEl7edclKA5q89FHqJZUN6fLcsfoUjj4OmOmzc+i8=;
 b=ApicSrYTdskFNtlPCPIWdkJtuQL3G5KZ1TMmejjM8n7wNyM/0zfS+L3SfSKSORuajgxfr+lB3JHelVNlSJZGeQqVLI14MrroHWlruTFh/wRc04Wl2Oe5t1wYa2uMNullAA/Je1oI98G/LO+4BmVqw2b6DpYEuMtI0Y1eNKKwsSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:58 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:58 +0000
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
Subject: [PATCH v4 7/7] PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus teardown
Date: Tue,  2 Dec 2025 16:23:48 +0900
Message-ID: <20251202072348.2752371-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f97b4c-981c-407a-4edd-08de3173c173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmrBqsPRNIcQD7c+9lvNzT5GbLB7UfUuOLdRtOkRXDVTLQQTLqV/FOvpIl2v?=
 =?us-ascii?Q?7d05evSGwFMFcPtTV2SKJSj+0yrX2eg3SDRs67/zWTgzMrhEs/n7FvPhs7gy?=
 =?us-ascii?Q?n5lfpQBos2OXTZ5Z8McRyBZeatRlqMndN1Cc8PlHj3XiT2W2I8t9LJ1AO2Zc?=
 =?us-ascii?Q?GCBAEwnxAnxm4iMd6dPGwaTjBJNOZWPt7PVPEN4XPKoVUE/Xx4dVpJZg6BX/?=
 =?us-ascii?Q?uope2Tj7p2DUW6ZZSSIVFiFmoYpOTDZoei8m3MaO5Hsqnu1pb1t0b/unexFw?=
 =?us-ascii?Q?gFyRA4mOC6Efz1LWMwMeJEf9UWgaGZ+JJIRULssKFEzpQvw50VxRtVmqJruX?=
 =?us-ascii?Q?55fScNA4m8tKYmi8O5i3IjAr0Cx6KKVcU16eTlDL2LmQtlfxHtXbMhGq0Ahn?=
 =?us-ascii?Q?mGZqauwMcRPTEQcV2CjGFx5H3fndiIxe2P1Z9duZBIOZjJ5t5/HNZxKac/k5?=
 =?us-ascii?Q?+FKiCU0wz5A1wPN+PPmD+MFwxxGkzJgEGq9uYYD6tvz6kkrEwkD8bhjKtgBv?=
 =?us-ascii?Q?CRs2+y0Nr+C94/kbYJXOLPO+5JJFKR6tr2/mFsDdB4r2dbyehOiGSrYlDp7Q?=
 =?us-ascii?Q?8VdMVqHlbIw7XxaLb5DluWgN7sTD4y4lKKQa0faKSjOApIVBV4/vJwkZbrSb?=
 =?us-ascii?Q?i6+94SWh2yChwbDb1M8RSE1t5cCBnAsYjML4lXv82W63oBsJlhL1ILgO0Cqt?=
 =?us-ascii?Q?NKMnrz7w7r9gsPbgCHaPhPWMVJIwq1lmfgAbBydphh5XiNfuHlCMXsv0iZlA?=
 =?us-ascii?Q?8se8uIkaroWbkfRi/EH/9CUPVqKxOKy1fCWEw9/e5RcW4K5Zu5RrSkrfVTlf?=
 =?us-ascii?Q?kfIyVyp/kJE2n8jaMrZQ0SCXCLMcDXYxBtUKU0qtoWSxm/IpApL6fVNint3H?=
 =?us-ascii?Q?lFilYEqoNdRxBzcx/ARkn5+fUIezSVxkK/VjQXeh4gbbcJF2tFxQ0rpatWFj?=
 =?us-ascii?Q?gVdNfU018o1jpbXYWdBXMRNKxWHChHIy28LS63pYb9h4r1YUS353TSNrFVZ6?=
 =?us-ascii?Q?YfQHQUcZ1uJgtNuJpCyuu53sVxSwLxy8U4vmc2TKRaGW17P5fHqyEIgPRVhF?=
 =?us-ascii?Q?PqMUv7+aZOhNDjF5m12BcJLSYeMZrqY08sisGdQka9LuhSRQidUZsQCq4ghD?=
 =?us-ascii?Q?6zRcGn19y0W3DlT8aVxWmNqoDPNCWI+DJjvFraBXHy1Z3JRe8E7HewKzkloM?=
 =?us-ascii?Q?ZKKTrMObc3nBMyW11KgrU09c2wQgi5owxM+NPKaBMJqatKPCdP/HMWJ9ZXdg?=
 =?us-ascii?Q?mFfWaL8JZnXWT1guIbqd+O/CLBBAecpzLd5OSNyqcjyCjydCBxLd15BQB80r?=
 =?us-ascii?Q?Jhjq1WePU99ChMlg/Z8QBPiDohh4DdhFvvFqBCyyThtzyqmrjOHZfncO977B?=
 =?us-ascii?Q?TLHVkDZfmtYuHvJ0H/Jc6iSAkO4Ht6HdzSML2Zo4iH/ymFqshgzdIbsiYytI?=
 =?us-ascii?Q?PmFahVgoL3p80T/QVOOJGfQEqduG5TPa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LT3DLaWgpUr0peEbAP9KuDrjLHz3dXOK/ZK3fJVmapjSN9JvhZwlf7Gp2tW7?=
 =?us-ascii?Q?Jt2i0utrusTrouosxaYE1uYT56GhVDFKLZdwjY0lLDs33D1Uy47nuMmPLl0I?=
 =?us-ascii?Q?g20Oj+b9wRVi7LILdyf3+CAZ/qgern6mi7Xvlb8g1wpHJX5xzMU52J5bK5dU?=
 =?us-ascii?Q?5FtV/t7cOnV1R2vuYyA7+PtG0cuwYwWjYBXcEBaFdJkbL4v8kTzGyHat08E3?=
 =?us-ascii?Q?JPjaNAVD2kBehDKiX30RcLdK6j5niaPYEuTUrVYRyxseQEVyKWn2udnWHikF?=
 =?us-ascii?Q?TA/aCWsRo9F8Vtk7cTd5m5sXdzIG9Ol/TFHGZTYQWQ5LAspR4JTxf04guZOV?=
 =?us-ascii?Q?PDIqiiycvsCs6V1MAA7n9RK7oXEYbjCUfr7DhX7GpZSVU4CbFv/JjFk7tJ9a?=
 =?us-ascii?Q?HXv3wNkFalYrHdriY1x717gTV3NI8SDXwHX45P8ok2ZrUBRrM6PZGJ+RyiNK?=
 =?us-ascii?Q?B6ceWoH6zgG5xzr5S2IqfJjKhwPHOmQpuVXixmsOCokLmhH7fG8fC/5XLtNH?=
 =?us-ascii?Q?pmK1Q1qraRp5WO/+HmHx9GQD4adPMUbQ68Dfjj690nGeQ5Gev5mS04crhA6L?=
 =?us-ascii?Q?fHx5b62yeQkUWWFYo+YGK6boZ+xuiLr7DcjySJGQZ89c5esiHTM/DKS6E7lE?=
 =?us-ascii?Q?4MU/zxQfZk3kdVTwU/U4M2Kd/SyqXmMTGVs0ImR1tsIBKq7pJiiDg7dKCHAw?=
 =?us-ascii?Q?fIlXVY2868y48TPUGSrPXgokqIsEnzbhBpDty+rYh/hkQUzd7z4vo5IYnkjT?=
 =?us-ascii?Q?0hvOtLEq1jqgEKExPePDYjFF5CFoNcpeX++uEd0A26Zg01I7lhOMmasisjuf?=
 =?us-ascii?Q?dVNfp/KMRS/5HWy3G8fwlnQ1qPLPEoV8ogBUfJKwlSpov8ZU4dRAdO1zrle9?=
 =?us-ascii?Q?KCn2Ci7ENIa75NnpG7T1OCBrcNZRboCE6yulK9m43UlzLtwcJAuhG16Dcj51?=
 =?us-ascii?Q?r1P0MVR5vPi5tTrV0+qUOK4fWlS9leppZB0Dm/zzMQmhTpANpu83WiRygAeZ?=
 =?us-ascii?Q?zGrr1F7o/Xqr7qtfRP2IlEwMdkp1zkdL6EzSPQ7HEeEYwApI87tlFIGRcon8?=
 =?us-ascii?Q?WDG55YgKaeWV8qBbIfaAZ93UKYc2/53f8/bdPjgTXOOgWK/p0x65vqv65Am4?=
 =?us-ascii?Q?1sUEjdk/teCXMA927kfMh8jPYFtVV6iSSnnZoXeLoTdzZZd2pcrthaRmJ4ze?=
 =?us-ascii?Q?Q7GDvLMlnTthK7b0fDzoDP2r2USTCGxyeXqUc4BmxWftI2KOFg3sHo7k0X4/?=
 =?us-ascii?Q?2LEB3OdS63T+vDxC+3YB5DbjClHfTILYhgDPX9fl+JTLhE+e4XH7SpjGByLB?=
 =?us-ascii?Q?jza2GODoegAS7bwXaNIQRvEKdeWYCHgioS1WodHSpRqKBmAygNCviYsEkqk2?=
 =?us-ascii?Q?mY5v7UFHqPgtmMe9FibhAYgnEH6COVofHSCA/V3Sb3edf72qOMvOVsahHZoY?=
 =?us-ascii?Q?8XFBBWgpCS9UBST1ULGEZub/00rgdnjBGz4a3LIhGPoRbJAdcD5jLnHp2+gC?=
 =?us-ascii?Q?dv4U0vZZApY3bh4TtRB4vL4J7OPhLZbeZk3RCyiXdLLsBCwhBoihEfrE3pMD?=
 =?us-ascii?Q?F+giiBEvWu58sBYr0pQeHM8E2m0uQYDTSDkwsQEDeCJmneUI/ktEK4pYXTr1?=
 =?us-ascii?Q?OIgIBMtxkCWr24rcqPK86Ew=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f97b4c-981c-407a-4edd-08de3173c173
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:57.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQnarZwKM14JeozV5/ASCw2uUYtehyBSff0/C+e8AiZ1ZtFknzo6bclDaAXeSQ7eyH6L2nIu78y897Z9qsN39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

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
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 51 ++++++++++++++-----
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 23f0afbfeb09..3059ed85a955 100644
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
@@ -1114,6 +1120,7 @@ static int vpci_scan_bus(void *sysdata)
 		pr_err("create pci bus failed\n");
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1158,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ntb->ntb->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1258,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
 
 	return ret;
 }
@@ -1345,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1355,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = ntb_register_device(&ndev->ntb);
+	ret = ntb_register_device(ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
 		return ret;
@@ -1365,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1376,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1458,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
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


