Return-Path: <linux-pci+bounces-25014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D46A76CE9
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2EC166693
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4856216E23;
	Mon, 31 Mar 2025 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B2HQaz53"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2074.outbound.protection.outlook.com [40.107.103.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F7214A96;
	Mon, 31 Mar 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445771; cv=fail; b=bmFE5a5OGM4Ah5woEOKQJkGxvXolbJEt3wfeX4xsmwwEYzTh4Xkfc4RODSubPmse18P9i+RcHXMd5IqtohEan80XvgIpH4fD5LtwlQZ2V1QzOtgskmPdEVqJWGpnFJ5nHcwTOkJJ6eM4kEiVzZ7fzMgem1lIpHMeyKkkBsi7oK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445771; c=relaxed/simple;
	bh=TTJ+PEgmaG83BU089iVXCSQa6D2UmztSNytUgJC3T1s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=go+l4k2rpYg2i+Xp8RDchIP1pBRipYWeRQtv8TTf2RCKqJ3ciNCjFP83PEwWe/1kOqNNHYnpk+HKvulpZ7cI7CU0iyPZMzHnJggkHD/2rIO9R5X+FajY9MOb+Ffz41+gGz8SCOnvSKq4lWPuRAl+0t0s+5F6OloaAJUdT6wMjW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B2HQaz53; arc=fail smtp.client-ip=40.107.103.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpfGJL6SbQzX5odv1dEqpMyW+Ce06XkioEZX7BYD2WPyiqztXKH20vKhjji7yg7GZJKQkFHU/ryfsDIvcJR7xJje6N75HYSNLJ23G9YxgNQCvk63vDolclhVUK2cgrIR5LMb/uagNY6qyk73fTNOBlnZHxQOlxU5lfmTEpXiIEps7tc4rF7LxyovcOXvBYnC3lpcVxJf3GSTRAjdccH7DSuFYG6bhJt70PedotsYnu8gFstZOCyMWQjP5pU5ic88CJdbth/AUqB917HmkYspK9eASXSL/wPllKE2VhhtyYfM2/XoFgv+gNL1S49tenXXpMqknhuFmNcWb6wsQfN7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2YmbZkwJnnm7Towg+ofnT9FJsw9kIDPihJEZjKeJMQ=;
 b=Ih5ZbVAcfV1M8RaTmBAWJ0KW8AlGgLFn9dfXo+agScdJpDCAunELp9lZ/1aZK8zZTo2YacBfqoNVYQv+dvF4Y+2GDrD/TXFcue6Exv/f/GUfvix3ukWW7QPpi2q1jncltGloLxxQQUS+4zn3zU+deB52VoDOdUqEBzs+snGIGVC5h/tOa3KQ2ZNsbhz6j+3yns1o85KOTn24TqBx6BWV7a+i3PrVyFAJTALXqJe/HDXRJ2tmz3eCfthx0NXUxClM+JoeZZItUyvNJ3MjfXFD5bsRYnrIM8MAA4eS07SCdUFxIj7z9ELy2hSHz+WonhJeAR1BC5eTiaac2NyZXRo4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2YmbZkwJnnm7Towg+ofnT9FJsw9kIDPihJEZjKeJMQ=;
 b=B2HQaz539kWPyQs/LaitEJ/3wv+OPJ1x058lpl5l+kMJNwP7daN7VUK8JYXMrPh9EnMB/znPev5kaGqAd3OJnXMv4vi69EMjHq9un+Lym1PzJJGi90m5mJLOjgLdXutH/pibm4NBfSscMFdZi5KSHfb9GK2k6DWI+NxMfWjdS3vHFGs74PuVn2c3FS2bGbGiTxxXsmQWj6aGn1QfevJbM2fj8OT0Inz704VG9QcvUpH2bmzAziNI4JTMs1b82f17YeSNQ6ytkR8/mL+oggASjmK6IyOGd78LYe3pWvHL0Jgrwp7olr+vlZdPJX+zK7pl98A13lxYhGWqodbiOj2jWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 31 Mar
 2025 18:29:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 18:29:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] misc: pci_endpoint_test: Set .driver_data for PCI_DEVICE_ID_IMX8
Date: Mon, 31 Mar 2025 14:29:10 -0400
Message-Id: <20250331182910.2198877-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: df206211-4aa5-41c6-0c6d-08dd7081f718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2M5oIM88fQEr4igSROjBu2Wiv8iDlmWd4tkEpN+e+jJdd7PwL4Fy0cg5p8/h?=
 =?us-ascii?Q?PomI95eBMQ5TbCTDxgynHuS09eWpHo1bxaYZ3en7yl6vBOG6IX39BTBgZITD?=
 =?us-ascii?Q?/bLFPRYfcEUQK4/gSHp/EyW/tj7+kEUlhJJV2bnZHXQuo528TUl/q9Ql4z4a?=
 =?us-ascii?Q?BL01EhLpXHgjsX0agDDnjKcQI3mq6NeNwSDvv0wug5Bfz838l9hNcvpxoApU?=
 =?us-ascii?Q?Domrnifed84adjgkaoKIlPrXS9jjkv4CjbTtN7rPUe75jNl6yUAGO+pjs8R/?=
 =?us-ascii?Q?heMsDX8dDnHmLrul+DifIyQ8XlB5Y87uPq6X+hf5x/+54cA1s2meBYZa4HEP?=
 =?us-ascii?Q?EuGYq525zlJOjVGvlN5Jhqb0bIQe17J6CJfE5PIyjjzQeRFO2HjNV8NlN78l?=
 =?us-ascii?Q?naIExIIiaQoLGGGP4g6nogUS+kXZb2lO7GgBl7BzIEnwdANNax1a5ATOSUva?=
 =?us-ascii?Q?Nh5mpRGR1s4AMjLGFrGOU6ZH98SJ1qwSz4cgFkKBOhleTD4QlWfWHlrHherM?=
 =?us-ascii?Q?6/efax1h9NXnInR5bTCAZqpJES0e3c/SYRh426feUOOcao+uut8aHuAMUM4V?=
 =?us-ascii?Q?lDCDr5pOC6Cp27hfx5TKBVaF/008lZwORvHFYkQ/wqXLemT6IWZVzggCCj1H?=
 =?us-ascii?Q?YnZt5oNtWOe/yjpgFjRW0GJf/NHCd7+2G2A3c7DrZTpn7SHhZLnLVI507vc1?=
 =?us-ascii?Q?GoDUgmoku/8rfwpdhE9CZuYaYTYZrQC37WvOc5I4JhG/+BT3NLKIt61yEqzV?=
 =?us-ascii?Q?Nv3yqpUeNAhs3qIonZyy02KrJ+egrTrVej55zt8ttxyT9Wn+/O91MfoJuB8x?=
 =?us-ascii?Q?1OyinSKhlRXK00QVR6SRPzJlzWG9dWS/vGXgXMgSG9emCs7GCVPi1Ilv04qA?=
 =?us-ascii?Q?wnN+PuPRyLGZqhA53pExeq+iqz7towFbb4ymVCfVf5vr33dgLYNiObr0Gtnp?=
 =?us-ascii?Q?+iYtmL5uqiq3e2ILyCOEv19dFgGZMPOchhN//Ae1luE0CxC7iZV/V8fLOf9f?=
 =?us-ascii?Q?dmvMdUFLYNAxJgIcQtsBE73NHiU1bwZWVvih/4GWXojvfl0CituIkYutSDrv?=
 =?us-ascii?Q?aMAjnNRyeVtHp79JaQAXvC6YjaRnP8xxKRyaCFxLN5ix4zeFiItRlRft525E?=
 =?us-ascii?Q?//0XmhdaLCn4lMTDl3u9zpnfWxHZwzVIfQ+R6hsV4g1AuHxOwPMEODsJw89d?=
 =?us-ascii?Q?HmVebC5qIYhNuzS9vVDqE6BpvIRjA5lqGoreRxwg4ZUFm2Dc6t7SLEoFh8gJ?=
 =?us-ascii?Q?M4iehJRFqgwFG9Kmga5utIZdkvHUVIFA7OmHK6Va2nlsxVaCWT3tWzypg+v8?=
 =?us-ascii?Q?Irqu8fmuUUq2V5F1L8GIeO6WufaMwZfYe6/ohhyObt6u0jJrRdCGwdlLZ1cr?=
 =?us-ascii?Q?x/gjsa8vXqrnV+uuMwk7YDly9xwfKJKUZ/2ALNVRteIna/kQbkBPvk0ELtcT?=
 =?us-ascii?Q?Id6zWUgseuMclqolZidwHgUvMkZXyzXo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRTWpTS04zpicaHLP8ygYeCnxDOGJIEvh6qxXMjlikbGKfjdvpvIsB4HI42q?=
 =?us-ascii?Q?EQZ3QvQZGlNY0CXDB6UensYUY7B0fFCxBRIwFGrpFlIOCliLj/H/uMR1vlFr?=
 =?us-ascii?Q?5mn4s29smtHeHPiXPasj7C7xYL+Rjk9IvBPiGTuFebJL4/byOrAhhlekM/kE?=
 =?us-ascii?Q?ginfgDJKHgeMSl9G1/bsLrWUl+eLTtnNwAyVHvxIjemNMFHCFgo8ybCGXgn5?=
 =?us-ascii?Q?uqjmT5b3bH3zkMn8JFNpyLvt3fhB0jUBXktH241hzhM66V6RHdf3+oYdXRq2?=
 =?us-ascii?Q?hYv+rIKfXTeGt6RR7BaYYqHwNAFnq/fxJ9YkE+pyhBCHpQ7BF01LDKJ2vTKO?=
 =?us-ascii?Q?Vlc19s1oqG37zANQU2R/rmAEV3f1fZusO/HL7UQf+1yxP7XK2mtBrmqkKreB?=
 =?us-ascii?Q?adF/TDMuRpXlK2zdQvYO/6Uh/J4oqeBU48jfm85ZYy77Z8hSVUbcX/F18GTp?=
 =?us-ascii?Q?cclw9bQ8IzaLXi+8VsciCzrYmWY8cFP3c/Gdx0G+N0MDFbGUwe98NRukFa94?=
 =?us-ascii?Q?ORfB8KLzOBvNZnqNO3YgjNvhXjRkxLqcZ6vuUuaZ2q16hS1rYb473JVTv3nV?=
 =?us-ascii?Q?0uImTZNm8EYY52HCcyXz+XNRCHGzXAS5nj3yQn6HoVw0Qed5dU/8LSdr53R2?=
 =?us-ascii?Q?ffsVufk2kUW+f62e0py12LcI0nVqYhiSMgbzxIqxGn/ysQEAFzfhAajodhq3?=
 =?us-ascii?Q?iHUJPZt6P0BxZRuT3f3su6iA1AB5gyeGVG1hIS1HfileC4v694+HzuW7GAAw?=
 =?us-ascii?Q?Sifx4I1yfOzy8VWpv4OcqsCv0WrlBvmYlb7bhxRhRwfnzJV+D7ZmVZKv+I4G?=
 =?us-ascii?Q?22UCwzAZbkVyjBKmc8HahzHWo204kokcvNeAXYkJXErjvYpME+Qjvfudspjv?=
 =?us-ascii?Q?Fx+Y7M/PNZ6R9Pn2urf6ynK7sw+ovUGyk78hzk+GbymQahySJjQ2NkmF1pm1?=
 =?us-ascii?Q?zk/0Kmm0pl+PzMgYekkAiJpGcUBWmHn1M8zcnX1XmGlD4nqdOSQCPt3ZG+G5?=
 =?us-ascii?Q?N1lIKujojG7vOCei9Logcf+1n+5x5P4mWPE8uePIqxYurQFe/tgsluyx8u4c?=
 =?us-ascii?Q?wpzhjrzQOyfTeG6Dn/JzNk4hnvmTI90Khxfv4BPnnLFgku7wnx5Fcjr8Ml7R?=
 =?us-ascii?Q?cNf0c8j97zXP+8CSC69y4n8WaIrAuIv8Da5L2cO9iZQiOkjBtvfLDJSyW3VU?=
 =?us-ascii?Q?SarVyynIU3ZW7Todt4RzImqex6vSZg9uCoZuqNck6/tKaB70OAHmsZ0FAZbF?=
 =?us-ascii?Q?Ykmme1XLx9KHPBIKe8X7Ik7Vo1GrR3l/V0XcheKXJMl4Ek5BZHlZthO0rCA0?=
 =?us-ascii?Q?F6jAf9eKzMAcDKY5g7VKGzlQTlZvTAwzlFZ+KmMFu15Go0IVT0xhfAvru28m?=
 =?us-ascii?Q?2xX5sEH6UXfnkUVs3/lqtoXetExsJOHAtqp9wMH4bavpQHN7NDSZMLtUW0zD?=
 =?us-ascii?Q?cVNoAnr55bmcTCZrlg/U+eeZE8IoEml4N+vmUmbaoIo6a1AfcRn0a4bBT8ll?=
 =?us-ascii?Q?217GhrA/F8QGeoDVibC0Xv4Cyl/IxQmhdbKMzdzqE45TGkDdhmDJRo0/WoeJ?=
 =?us-ascii?Q?4lkt6FG0zCm4EaZHlD8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df206211-4aa5-41c6-0c6d-08dd7081f718
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 18:29:25.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zk7UWvXDFkNJz9WA/2ixMbXHOqmrMTbNG6iUsaT2HViObrvuZCiism9ueMfK6O8mLmL1FKgfK40CDFsVvAzaMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

Ensure driver_data is set for PCI_DEVICE_ID_IMX8 to specify the IRQ type,
preventing probe failure.

Fixes the following error:
  pci-endpoint-test 0001:01:00.0: Invalid IRQ type selected
  pci-endpoint-test 0001:01:00.0: probe with driver pci-endpoint-test failed with error -22

Fixes: a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/misc/pci_endpoint_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d294850a35a12..da96dba7357c6 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1125,7 +1125,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),
+	 .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
-- 
2.34.1


